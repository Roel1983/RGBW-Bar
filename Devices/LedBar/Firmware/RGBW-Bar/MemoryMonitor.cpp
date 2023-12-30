#include <Arduino.h>

static constexpr char         unused_ram_value    = 0x55;
static constexpr unsigned int internal_sram_start = 0x0100;
static constexpr unsigned int internal_sram_end   = 0x08FF;


void MemoryMonitorGet(unsigned int& heap, unsigned int& stack, unsigned int& free) {
  char top;
  unsigned int start_candidate;
  unsigned int start=0;
  unsigned int end=0;
  
  for(unsigned int i = internal_sram_start; i < (unsigned int)&top; i++) {
    if(*(char*)i == unused_ram_value) {
      start_candidate= i;
      while (*(char*)(++i) == unused_ram_value && i < (unsigned int)&top);
      if((i - start_candidate) > (end - start)) {
        start  = start_candidate;
        end = i;
      }
    }
  }

  heap = start - internal_sram_start;
  stack = internal_sram_end - end;
  free = end - start;
}

