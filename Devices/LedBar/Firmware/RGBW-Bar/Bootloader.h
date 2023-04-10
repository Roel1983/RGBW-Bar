#ifndef _BOOTLOADER_H_
#define _BOOTLOADER_H_

#ifndef BOOT_LOADER_ADDRESS
#define BOOT_LOADER_ADDRESS 0x7800
#endif

void inline BootloaderExecute() {
  typedef void (*BootLoaderMeth)(void);
  ((BootLoaderMeth)BOOT_LOADER_ADDRESS)();
}

#endif
