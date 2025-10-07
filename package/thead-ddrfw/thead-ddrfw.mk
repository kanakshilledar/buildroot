################################################################################
#
# thead-ddrfw
#
################################################################################

THEAD_DDRFW_VERSION = a7595482097e5f852655cd537e65eb0325b81845
THEAD_DDRFW_SITE = https://github.com/ziyao233/th1520-firmware.git
THEAD_DDRFW_SITE_METHOD = git
THEAD_DDRFW_LICENSE = GPL-2.0
THEAD_DDRFW_LICENSE_FILES = LICENSE

THEAD_DDRFW_DEPENDENCIES = host-lua
THEAD_DDRFW_INSTALL_IMAGES = YES
THEAD_DDRFW_INSTALL_TARGET = NO

define THEAD_DDRFW_BUILD_CMDS
	cd $(@D) && \
	$(HOST_DIR)/bin/lua ddr-generate.lua src/lpddr4x-3733-dualrank.lua th1520-ddr-firmware.bin && \
	cp $(@D)/th1520-ddr-firmware.bin \
		$(BUILD_DIR)/uboot-e4c8b32d03d7ecffd586b7d33336603ad639d7c0/th1520-ddr-firmware.bin
endef

define THEAD_DDRFW_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0644 $(@D)/th1520-ddr-firmware.bin \
		$(BINARIES_DIR)/th1520-ddr-firmware.bin
endef

$(eval $(generic-package))
