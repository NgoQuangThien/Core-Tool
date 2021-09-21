from elasticsearch import Elasticsearch

def get_data(es, index_name):
    res = es.search(index=index_name,
                    body={"query": {"match_all": {}},
                          "sort": [{"@timestamp": {"order": "desc"}}]}
                    )
    return res

def connect_to_els(ip, port):
    es = Elasticsearch(hosts=ip, port=port,
                       maxsize=3,
                       request_timeout=5
                       )
    if not es.ping():
        return False
    else:
        return es
    

if __name__ == '__main__':
    els_ip = '10.3.10.236'
    els_port = '8080'
    # cluster = 'master_cluster'
    index = 'logstash-ids*'
    point = 0

    elasticsearch = connect_to_els(els_ip, els_port)
    response = get_data(elasticsearch, index)
    print(response)
