if(CONFIG_ADA_GNAT_RTS)
  set(CMAKE_ADA_LINKER_PREFERENCE 1)

  # file(GLOB SRC_FILES ${CMAKE_CURRENT_LIST_DIR}/adainclude/*.adb)


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
  # )

  # zephyr_include_directories(
  #     .
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

  # zephyr_library_sources(
  #     ${CMAKE_CURRENT_LIST_DIR}/zephyr_helpers/printk.c

  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/breakpoint_handler-cortexm.S

  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/a-assert.adb
  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/a-elchha.adb
  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/a-except.adb
  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/a-tags.adb
  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/a-textio.adb
  #     # ${CMAKE_CURRENT_LIST_DIR}/adainclude/g-io-put.adb
  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/g-io.adb
  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-assert.adb
  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-atacco.adb
  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-bbarat.adb
  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-fatgen.adb
  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-imgboo.adb
  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-imgint.adb
  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-imglli.adb
  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-imgllu.adb
  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-imguns.adb
  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-macres.adb
  #     # ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-memcom.adb
  #     # ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-memcop.adb
  #     # ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-memmov.adb
  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-memory.adb
  #     # ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-memset.adb
  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-secsta.adb
  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-semiho.adb
  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-sssita.adb
  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-stoele.adb
  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/s-textio.adb

  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/i-cstrin.adb
  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/i-c.adb

  #     ${CMAKE_CURRENT_LIST_DIR}/adainclude/interfac.ads
  # )

  zephyr_library_app_memory(k_gnat_partition)

endif()
