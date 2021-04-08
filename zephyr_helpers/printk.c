#include <logging/log.h>
#include <stdio.h>

void zhelper_printk(const char *buf)
{
    printk("%s", buf);
}
