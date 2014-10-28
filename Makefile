ARCHS = armv7 arm64
TARGET = iphone:clang:latest:latest
THEOS_BUILD_DIR = Packages

include theos/makefiles/common.mk

TWEAK_NAME = Dropped
Dropped_FILES = Tweak.xm
Dropped_LDFLAGS = -lactivator
Dropped_FRAMEWORKS = CoreMotion
Dropped_PrivateFrameworks = Preferences

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += droppedprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
