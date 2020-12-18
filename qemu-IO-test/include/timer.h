#include "irq.h"

#define TIMER_CLO       (PBASE+0x00003004)
#define TIMER_C1        (PBASE+0x00003010)
#define TIMER_CS        (PBASE+0x00003000)
#define TIMER_CS_M1     (1 << 1)