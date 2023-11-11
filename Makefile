obj-m := jupiter.o

KVER ?= $(shell uname -r)
KDIR ?= /lib/modules/$(KVER)/build
VERSION ?= $(shell cat VERSION)

default:
	$(MAKE) -C $(KDIR) M=$(CURDIR) modules

clean:
	$(MAKE) -C $(KDIR) M=$(CURDIR) clean

install:
	$(MAKE) -C $(KDIR) M=$(CURDIR) modules_install

load:
	-/sbin/rmmod jupiter
	/sbin/insmod jupiter.ko

dkms.conf: dkms.conf.in
	sed "s/@@VERSION@@/$(VERSION)/" $^ > $@

dkms-add: dkms.conf
	/usr/sbin/dkms add $(CURDIR)

dkms-build: dkms.conf
	/usr/sbin/dkms build jupiter/$(VERSION)

dkms-install: dkms.conf
	/usr/sbin/dkms install jupiter/$(VERSION)

dkms-remove: dkms.conf
	/usr/sbin/dkms remove jupiter/$(VERSION) --all

modprobe-install:
	modprobe jupiter

modprobe-remove:
	modprobe -r jupiter

dev: modprobe-remove dkms-remove dkms-add dkms-build dkms-install modprobe-install
