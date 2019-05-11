# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qttools
$(PKG)_WEBSITE  := https://www.qt.io/
$(PKG)_DESCR    := Qt
$(PKG)_IGNORE   :=
$(PKG)_VERSION   = $(qtbase_VERSION)
$(PKG)_CHECKSUM := 1a63ba838058d73cb540040589b235ded77f76402693decfd6d4d3c75ea67926
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/$(PKG)-[0-9]*.patch)))
$(PKG)_SUBDIR    = $(subst qtbase,qttools,$(qtbase_SUBDIR))
$(PKG)_FILE      = $(subst qtbase,qttools,$(qtbase_FILE))
$(PKG)_URL       = $(subst qtbase,qttools,$(qtbase_URL))
$(PKG)_DEPS     := cc qtactiveqt qtbase qtdeclarative

$(PKG)_TEST_DIR := $(dir $(lastword $(MAKEFILE_LIST)))/qttools-test

define $(PKG)_UPDATE
    echo $(qtbase_VERSION)
endef

define $(PKG)_BUILD
    $(QMAKE_MAKE_INSTALL)

    # test QUiLoader
    mkdir '$(BUILD_DIR)'.test
    cd '$(BUILD_DIR)'.test && '$(TARGET)-cmake' '$($(PKG)_TEST_DIR)'
    $(MAKE) -C '$(BUILD_DIR)'.test
    cp '$(BUILD_DIR)'.test/mxe-cmake-qtuitools.exe \
        '$(PREFIX)/$(TARGET)/bin/test-qttools.exe'
endef
