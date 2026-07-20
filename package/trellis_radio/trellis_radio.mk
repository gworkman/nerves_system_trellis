################################################################################
#
# trellis_radio
#
################################################################################

# Bump/retag as the driver evolves. This is the esp-hosted repo's `main` HEAD
# at the time this package was written -- see
# https://github.com/gworkman/trellis_radio.
TRELLIS_RADIO_VERSION = 824e0395358fc0dfbcf4fc2afce453685a1f0500
TRELLIS_RADIO_SITE = $(call github,gworkman,trellis_radio,$(TRELLIS_RADIO_VERSION))
TRELLIS_RADIO_LICENSE = GPL-2.0
TRELLIS_RADIO_LICENSE_FILES = driver/LICENSE

# The kernel module lives under driver/, but its Makefile reaches out to
# ../shared/include for wire-protocol headers shared with the ESP32 firmware
# -- so the package needs the whole repo checked out, with driver/ as the
# module subdir (not just driver/ fetched on its own).
TRELLIS_RADIO_MODULE_SUBDIRS = driver

define TRELLIS_RADIO_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_NET)
	$(call KCONFIG_ENABLE_OPT,CONFIG_WIRELESS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CFG80211)
	$(call KCONFIG_ENABLE_OPT,CONFIG_MMC)
endef

$(eval $(kernel-module))
$(eval $(generic-package))
