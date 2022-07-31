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
      ${CMAKE_CURRENT_LIST_DIR}/adaint.c

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
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-imageu.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-imguns.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-imgint.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-atacco.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-multip.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-parame.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-soflin.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-soliin.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-stache.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-stausa.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-traent.adb

      # Interfaces
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/i-cstrin.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/i-c.adb

      # GNARL
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/a-reatim.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-taskin.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-multip.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-soliin.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-soflin.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-stache.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-stusta.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-stausa.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-atacco.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-traent.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-taprop.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-tasdeb.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-taprop.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-tasdeb.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-tasinf.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-tassta.adb
      ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-tpopsp.adb
      
      
  )

  zephyr_library_app_memory(k_gnat_partition)

endif()
