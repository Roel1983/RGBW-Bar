#ifndef _BOOTLOADER_HPP_
#define _BOOTLOADER_HPP_

namespace bootloader {

#ifndef BOOT_LOADER_ADDRESS
#define BOOT_LOADER_ADDRESS 0x7800
#endif

void inline execute() {
  typedef void (*BootLoaderMeth)(void);
  ((BootLoaderMeth)BOOT_LOADER_ADDRESS)();
}

} // End of: namespace bootloader

#endif
