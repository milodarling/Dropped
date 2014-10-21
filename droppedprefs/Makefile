ARCHS = armv7 arm64
TARGET = iphone:clang:latest:latest
LDFLAGS = -F$(THEOS)/frameworks
#You’ll probably want the next line uncommented if you installed SettingsKit right, but mine is messed up so I have it uncommented :/
#CFLAGS = -fobjc-arc

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = DroppedPrefs
DroppedPrefs_FILES = DroppedPrefs.mm $(shell find $(THEOS)/include/SettingsKit -name '*.m')
DroppedPrefs_INSTALL_PATH = /Library/PreferenceBundles
DroppedPrefs_FRAMEWORKS = UIKit MessageUI Social QuartzCore CoreGraphics
DroppedPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)cp $(THEOS)/include/SettingsKit/Resources/*.png $(THEOS_STAGING_DIR)/Library/PreferenceBundles/DroppedPrefs.bundle/$(ECHO_END)
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/DroppedPrefs.plist$(ECHO_END)
