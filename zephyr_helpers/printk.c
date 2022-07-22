#include <zephyr/sys/printk.h>

void zhelper_printk(const char *buf)
{
    printk("%s", buf);
}
