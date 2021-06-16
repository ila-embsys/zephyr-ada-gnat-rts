with Interfaces.C.Strings;

package Zephyr_Helpers is
   procedure printk (buf : Interfaces.C.Strings.chars_ptr)
   with Import => True,
      Convention => C,
      External_Name => "zhelper_printk";

   procedure log_panic
   with Import => True,
      Convention => C,
      External_Name => "zhelper_log_panic";
end Zephyr_Helpers;
