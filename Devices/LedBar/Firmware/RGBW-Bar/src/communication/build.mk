include src/communication/receiver/build.mk
include src/communication/sender/build.mk

FIRMWARE_SOURCE_FILES_CPP += $(wildcard src/communication/*.cpp)
FIRMWARE_SOURCE_FILES_C   += $(wildcard src/communication/*.c)
