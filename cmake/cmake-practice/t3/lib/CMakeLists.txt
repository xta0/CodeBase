SET(LIBHELLO_SRC hello.c)
# dylib
ADD_LIBRARY(hello SHARED ${LIBHELLO_SRC})
# .a
# 如果我们使用相同的TARGET 则不能work
# ADD_LIBRARY(hello STATIC ${LIBHELLO_SRC})
ADD_LIBRARY(hello_static STATIC ${LIBHELLO_SRC})

# 由于TARGET不能重名${LIBHELLO_SRC}，因此如果dylib或者.a只能生成一个

# 如果想要生成名字相同的dylib和.a，则要使用 SET_TARGET_PROPERTIES 命令
SET_TARGET_PROPERTIES(hello_static PROPERTIES OUTPUT_NAME "hello")

# GET_TARGET_PROPERTY(OUTPUT_STATIC_VALUE hello_static OUTPUT_NAME1)
# GET_TARGET_PROPERTY(OUTPUT_DYNAMIC_VALUE hello_dynamic OUTPUT_NAME2)
# MESSAGE(STATUS "This is the hello_static name:" ${OUTPUT_STATIC_VALUE})
# MESSAGE(STATUS "This is the hello_static name:" ${OUTPUT_DYNAMIC_VALUE})

INSTALL(TARGETS  hello hello_static 
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib)

INSTALL(FILES hello.h DESTINATION include/hello)

##########################################################################
# cmake -DCMAKE_INSTALL_PREFIX=/usr ..
# make
# make install