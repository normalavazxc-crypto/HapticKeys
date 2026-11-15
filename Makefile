TARGET := iphone:clang:latest:16.0
ARCHS := arm64 arm64e
THEOS_PACKAGE_SCHEME := rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME := HapticKeys

HapticKeys_FILES := Tweak.x
HapticKeys_CFLAGS := -fobjc-arc -Wno-unused-function
HapticKeys_FRAMEWORKS := UIKit QuartzCore

include $(THEOS_MAKE_PATH)/tweak.mk
