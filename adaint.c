#include <autoconf.h>

int
__gnat_number_of_cpus (void)
{
  int cores = 1;

#if defined (__ZEPHYR__)
#if defined(CONFIG_SMP)
  cores = (int) CONFIG_MP_NUM_CPUS;
#endif
#endif

  return cores;
}