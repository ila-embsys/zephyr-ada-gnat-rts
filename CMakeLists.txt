file(GLOB SRC_FILES ${CMAKE_CURRENT_LIST_DIR}/adainclude/*.adb)

zephyr_library()

# zephyr_library_include_directories(
#     adainclude
# )

zephyr_include_directories(
    .
)

zephyr_library_sources(
    ${SRC_FILES}
)

zephyr_library_app_memory(k_gnat_partition)
