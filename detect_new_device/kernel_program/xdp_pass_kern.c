/* SPDX-License-Identifier: GPL-2.0 */
#include <linux/bpf.h>
#include <arpa/inet.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <linux/if_vlan.h>
#include <linux/in.h>
#include <stdbool.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_endian.h>
#include <string.h>

#include "parsing_helpers.h"

#define ARP_HEADER_LENGTH 0x0008
#define ARP_SHA 0x0006
#define ARP_SPA 0x0004
#define ARP_THA 0x0006
#define ARP_TPA 0x0004

#define bpf_printk(fmt, ...)                                    \
({                                                              \
	char ____fmt[] = fmt;                                   \
	bpf_trace_printk(____fmt, sizeof(____fmt),              \
                         ##__VA_ARGS__);                        \
})

/* to u64 in host order */
static inline __u64 mac_addr_to_u64(const __u8 *addr)
{
	__u64 u = 0;
	int i;

	for (i = 6 - 1; i >= 0; i--)
		u = u << 8 | addr[i];
	return u;
}

static inline __u64 ip_addr_to_64(const __u8 *addr)
{
	__u64 u = 0;
	int i;

	for (i = 4 - 1; i >= 0; i--)
		u = u << 8 | addr[i];
	return u;
}

SEC("xdp")
int  xdp_prog_simple(struct xdp_md *ctx)
{
	void *data = (void *)(long)ctx->data;
	void *data_end = (void *)(long)ctx->data_end;

	struct hdr_cursor nh;
	nh.pos = data;

	struct ethhdr *eth;
	struct collect_vlans vlans;
	int eth_type;

	struct arphdr *arphdr;
	int arp_type;

	eth_type = parse_ethhdr(&nh, data_end, &eth, &vlans);
	if (eth_type == bpf_htons(ETH_P_ARP))
	{
		arp_type = parse_arphdr(&nh, data_end, &arphdr);
		if (arp_type == bpf_htons(ARPOP_REPLY))
		{
			// Print ARP Reply info
			bpf_printk("mac: %llu, ip: %llu\n",
					mac_addr_to_u64(arphdr->ar_sha),
					ip_addr_to_64(arphdr->ar_sip)
					);
		}
	}

	return XDP_PASS;
}

char _license[] SEC("license") = "GPL";
