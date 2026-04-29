LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE := zygisk_rvmm
LOCAL_SRC_FILES := module.cpp
LOCAL_LDLIBS := -llog
LOCAL_CFLAGS := -Wall -Wextra -O2 -fvisibility=hidden -fvisibility-inlines-hidden
LOCAL_CPPFLAGS := -std=c++17
include $(BUILD_SHARED_LIBRARY)
