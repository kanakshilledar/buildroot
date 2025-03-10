################################################################################
#
# pthreadpool
#
################################################################################

PTHREADPOOL_VERSION = 560c60d342a76076f0557a3946924c6478470044
PTHREADPOOL_SITE = $(call github,Maratyszcza,pthreadpool,$(PTHREADPOOL_VERSION))
PTHREADPOOL_LICENSE = BSD-2-Clause
PTHREADPOOL_LICENSE_FILES = LICENSE
PTHREADPOOL_INSTALL_STAGING = YES
PTHREADPOOL_DEPENDENCIES = fxdiv

PTHREADPOOL_CFLAGS = $(TARGET_CFLAGS)
PTHREADPOOL_CXXFLAGS = $(TARGET_CXXFLAGS)

ifeq ($(BR2_PACKAGE_CPUINFO),y)
PTHREADPOOL_DEPENDENCIES += cpuinfo
PTHREADPOOL_CFLAGS += -DPTHREADPOOL_USE_CPUINFO=1
PTHREADPOOL_CXXFLAGS += -DPTHREADPOOL_USE_CPUINFO=1
else
PTHREADPOOL_CFLAGS += -DPTHREADPOOL_USE_CPUINFO=0
PTHREADPOOL_CXXFLAGS += -DPTHREADPOOL_USE_CPUINFO=0
endif

PTHREADPOOL_CONF_OPTS = \
	-DCMAKE_C_FLAGS="$(PTHREADPOOL_CFLAGS)" \
	-DCMAKE_CXX_FLAGS="$(PTHREADPOOL_CXXFLAGS)" \
	-DFXDIV_SOURCE_DIR="$(FXDIV_DIR)" \
	-DPTHREADPOOL_BUILD_TESTS=OFF \
	-DPTHREADPOOL_BUILD_BENCHMARKS=OFF

$(eval $(cmake-package))
