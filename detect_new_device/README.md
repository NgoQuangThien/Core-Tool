# DETECT NEW DEVICE 

## CentOS 7

###	Update kernel

	Cài đặt kernel mới
```
	$ sudo rpm -i kernel-ml-5.15.3-1.el7.elrepo.x86_64.rpm
```

	Kiểm tra các version kernel hiện có
```
	$ sudo awk -F\' '$1=="menuentry " {print i++ " : " $2}' /etc/grub2.cfg
```

	Thiết lập kernel mặc định (sử dụng ID của kernel vừa cài - lấy từ câu lệnh kiểm tra phía trên để thay vào câu lệnh - ở đây giả sử với ID = 0)
```
	$ sudo grub2-set-default 0
	$ sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

	Khởi động lại thiết bị
```
	$ sudo reboot
```

	Kiểm tra lại version kernel đang sử dụng
```
	$ uname -snr
```

### Cài thành phần phụ thuộc
	
	Cài centos-release-scl
```
	$ sudo rpm -i dependencies/centos-release-scl-rh-2-3.el7.centos.noarch.rpm
	$ sudo rpm -i centos-release-scl-2-3.el7.centos.noarch.rpm
```

	Cài llvm-toolset-7
```
	$ cd llvm-toolset-7/dependencies/
	$ sudo rpm -i scl-utils-20130529-19.rpm
	$ sudo rpm -i llvm-toolset-7-runtime-5.0.1.rpm
	$ sudo rpm -i devtoolset-7-runtime-7.1.rpm
	$ sudo rpm -i mpfr-3.1.1-4.rpm
	$ sudo rpm -i llvm-toolset-7-compiler-rt-5.0.1-2.rpm
	$ sudo rpm -i llvm-toolset-7-libomp-5.0.1.rpm
	$ sudo rpm -i llvm-toolset-7-llvm-libs-5.0.1-8.rpm
	$ sudo rpm -i llvm-toolset-7-llvm-5.0.1-8.rpm
	$ sudo rpm -i python-backports-1.0-8.rpm 
	$ sudo rpm -i python-ipaddress-1.0.16-2.rpm
	$ sudo rpm -i python-backports-ssl_match_hostname-3.5.0.1.rpm
	$ sudo rpm -i python-setuptools-0.9.8-7.rpm
	$ sudo rpm -i llvm-toolset-7-python2-lit-0.5.1.rpm
	$ sudo rpm -i devtoolset-7-libstdc++-devel-7.3.1.rpm
	$ sudo rpm -i kernel-headers-3.10.0-1160.45.rpm
	$ sudo rpm -i glibc-headers-2.17-325.rpm
	$ sudo rpm -i glibc-devel-2.17-325.rpm
	$ sudo rpm -i libmpc-1.0.1-3.rpm
	$ sudo rpm -i devtoolset-7-binutils-2.28-11.el7.x86_64.rpm
	$ sudo rpm -i devtoolset-7-gcc-7.3.1.rpm
	$ sudo rpm -i devtoolset-7-gcc-c++-7.3.1.rpm
	$ sudo rpm -i llvm-toolset-7-clang-libs-5.0.1-4.rpm
	$ sudo rpm -i llvm-toolset-7-clang-5.0.1-4.rpm
	$ sudo rpm -i llvm-toolset-7-lldb-5.0.1-4.rpm
	$ cd ../
	$ sudo rpm -i llvm-toolset-7-5.0.1-4.el7.x86_64.rpm
```

	Enable llvm-toolset-7 và devtoolset-7
```
	$ scl enable llvm-toolset-7 bash
	$ scl enable devtoolset-7 bash
```

	Kiểm tra version clang, gcc
```
	$ clang --version
	$ gcc --version
```

	Cài đặt phụ thuộc XDP
```
	$ git submodule update --init
	$ sudo rpm -i elfutils-libelf-devel-0.176-5.el7.x86_64.rpm
	$ sudo rpm -i bpftool-3.10.0-1160.45.1.el7.x86_64.rpm
	$ sudo rpm -i 
	$ sudo rpm -i 
```
	Bổ xung thư viện XDP
```
	$ cd required_by_XDP/
	$ sudo rpm -i glibc-devel-2.17-325.el7_9.i686.rpm
	$ sudo rpm -i glibc-2.17-325.el7_9.i686.rpm
	$ sudo rpm -i nss-softokn-freebl-3.67.0-3.el7_9.i686.rpm
```

### Cài đặt chương trình
	Chương trình phía kernel
```
	$ git clone
	$ make
	$ sudo ./xdp_loader --dev ens192 --auto-mode --force
```

	Chương trình phía user_space
