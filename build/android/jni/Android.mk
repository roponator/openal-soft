LOCAL_PATH := $(call my-dir)/../../..

include $(CLEAR_VARS)

# These libraries will be linked by modules that include this one.
#LOCAL_EXPORT_LDLIBS := -llog -lOpenSLES

LOCAL_CFLAGS :=-fvisibility=internal -Wno-psabi -fPIC -DAL_BUILD_LIBRARY -D_GNU_SOURCE=1 -DAL_ALEXT_PROTOTYPES -std=c99
LOCAL_MODULE = openal32
LOCAL_SRC_FILES = \
        OpenAL32/alAuxEffectSlot.c \
        OpenAL32/alBuffer.c        \
        OpenAL32/alEffect.c        \
        OpenAL32/alError.c         \
        OpenAL32/alExtension.c     \
        OpenAL32/alFontsound.c     \
        OpenAL32/alFilter.c        \
        OpenAL32/alListener.c      \
        OpenAL32/alMidi.c          \
        OpenAL32/alPreset.c        \
        OpenAL32/alSoundfont.c     \
        OpenAL32/alSource.c        \
        OpenAL32/alState.c         \
        OpenAL32/alThunk.c         \
        OpenAL32/sample_cvt.c      \
        Alc/ALc.c                  \
        Alc/alcConfig.c            \
        Alc/effects/dedicated.c    \
        Alc/effects/echo.c         \
        Alc/effects/autowah.c      \
        Alc/effects/compressor.c   \
        Alc/effects/distortion.c   \
        Alc/effects/equalizer.c    \
        Alc/effects/chorus.c       \
        Alc/effects/flanger.c      \
        Alc/effects/modulator.c    \
        Alc/effects/null.c         \
        Alc/effects/reverb.c       \
        Alc/alcRing.c              \
        Alc/ALu.c                  \
        Alc/bs2b.c                 \
        Alc/helpers.c              \
        Alc/panning.c              \
        Alc/hrtf.c                 \
        Alc/mixer.c                \
        Alc/mixer_c.c              \
        Alc/backends/base.c        \
        Alc/backends/loopback.c    \
        Alc/backends/null.c        \
        Alc/backends/opensl.c      \
        Alc/backends/wave.c        \
        Alc/midi/base.c            \
        Alc/midi/dummy.c           \
        Alc/midi/sf2load.c         \
        Alc/midi/soft.c            \
        Alc/midi/fluidsynth.c      \
        common/uintmap.c           \
        common/atomic.c            \
        common/rwlock.c            \
        common/threads.c

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
    LOCAL_CFLAGS += -DHAVE_NEON -DHAVE_ARM_NEON_H
    LOCAL_SRC_FILES += Alc/mixer_neon.c.neon
    LOCAL_ARM_NEON := true
endif

ifeq ($(TARGET_ARCH_ABI),x86)
    LOCAL_CFLAGS += -DHAVE_SSE -DHAVE_SSE2 -DHAVE_XMMINTRIN_H
    LOCAL_SRC_FILES += Alc/mixer_sse.c Alc/mixer_sse2.c
endif

ifeq ($(TARGET_ARCH_ABI),x86_64)
    LOCAL_CFLAGS += -DHAVE_SSE -DHAVE_SSE2 -DHAVE_XMMINTRIN_H
    LOCAL_SRC_FILES += Alc/mixer_sse.c Alc/mixer_sse2.c
endif

LOCAL_C_INCLUDES := $(LOCAL_PATH)/build/android/jni $(LOCAL_PATH)/include $(LOCAL_PATH)/OpenAL32/Include $(LOCAL_PATH)/Alc

LOCAL_ARM_MODE := arm
TARGET_PLATFORM = android-19
LOCAL_STATIC_LIBRARIES += cpufeatures

LOCAL_LDLIBS += -Wl,--build-id -Bsymbolic -shared
#LOCAL_CFLAGS += -I$(ANDROID_NDK_ROOT)/sources/android/cpufeatures
LOCAL_LDLIBS += -ldl -lOpenSLES -llog

include $(BUILD_SHARED_LIBRARY)

$(call import-module,android/cpufeatures)