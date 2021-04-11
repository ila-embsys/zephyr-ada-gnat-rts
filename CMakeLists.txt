if(CONFIG_ADA_GNAT_RTS)
  set(CMAKE_ADA_LINKER_PREFERENCE 1)

  project(gnat C ASM ADA)

  zephyr_library()

  zephyr_library_compile_options(
      # $<$<COMPILE_LANGUAGE:ADA>:-O2>
      $<$<COMPILE_LANGUAGE:ADA>:-nostdinc>
      $<$<COMPILE_LANGUAGE:ADA>:-gnatA -gnatg -gnatp -gnatn2>
      $<$<COMPILE_LANGUAGE:ADA>:-g>
      $<$<COMPILE_LANGUAGE:ADA>:-I${CMAKE_CURRENT_LIST_DIR}/adainclude>
      $<$<COMPILE_LANGUAGE:ADA>:-I${CMAKE_CURRENT_LIST_DIR}/zephyr_helpers>
  )

  # includes doesnt work because cmake ada module doesnt pass includes

  # zephyr_library_include_directories(
  #     adainclude
  #     zephyr_helpers
  # )

  zephyr_library_sources(
      # Helpers to call Zephyr from GNAT
      ${CMAKE_CURRENT_LIST_DIR}/zephyr_helpers/printk.c

      # Ada
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/a-elchha.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/a-except.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/a-textio.adb

      # System
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-macres.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-secsta.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-sssita.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-stoele.adb

      # Interfaces
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/i-cstrin.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/i-c.adb
  )

  zephyr_library_app_memory(k_gnat_partition)

endif()
