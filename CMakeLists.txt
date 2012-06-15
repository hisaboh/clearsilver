cmake_minimum_required(VERSION 2.6)

# === macro === #

SET(CMAKE_C_FLAGS         "-Wall ${KONOHA_CFLAGS}")
SET(CMAKE_CXX_FLAGS       "-Wall ${KONOHA_CFLAGS}")
SET(CMAKE_C_FLAGS_RELEASE      "-Wall -O2 -g0")
SET(CMAKE_C_FLAGS_DEBUG        "-O0 -g3")
SET(CMAKE_C_FLAGS_COMPRESSED   "-Os -g0")
SET(CMAKE_CXX_FLAGS_RELEASE    "${CMAKE_C_FLAGS_RELEASE}")
SET(CMAKE_CXX_FLAGS_DEBUG      "${CMAKE_C_FLAGS_DEBUG}")
SET(CMAKE_CXX_FLAGS_COMPRESSED "${CMAKE_C_FLAGS_COMPRESSED}")

macro(POP _STR _DELIM _RESULT)
	string(REPLACE ${_DELIM} ";" _tmp ${_STR})
	list(REVERSE _tmp)
	list(GET _tmp 0 ${_RESULT})
endmacro()

macro(PKGNAME _STR _RESULT)
	set(_tmp)
	POP(${_STR} "/" _tmp)
	POP(${_tmp} "." ${_RESULT})
endmacro()

enable_testing()

macro(create_package_project _PKGNAME)
	project(${_PKGNAME})
	file(GLOB_RECURSE test_files ${CMAKE_CURRENT_SOURCE_DIR}/test/*.k)
	foreach(f ${test_files})
		string(REPLACE // / f ${f})
		string(REPLACE ${CMAKE_CURRENT_SOURCE_DIR}/test/ "" test_name ${f})
		string(REPLACE /test "" test_name ${test_name})
		add_test(${test_name} konoha --test-with ${f})
		set_tests_properties(${test_name} PROPERTIES TIMEOUT 10)
	endforeach(f ${test_files})
	set(CMAKE_BUILD_TYPE ${KONOHA_BUILD_TYPE})
	PKGNAME(${_PKGNAME} _PACKAGE_NAME)
	set(LIB  "${_PACKAGE_NAME}_glue")
	set(_KONOHA_PACKAGE_DIR konoha2/package/${PROJECT_NAME})
	set(CMAKE_C_FLAGS_${uppercase_CMAKE_BUILD_TYPE}
		"${CMAKE_C_FLAGS_${uppercase_CMAKE_BUILD_TYPE}} ${PACKAGE_C_FLAGS}")
	set(CMAKE_CXX_FLAGS_${uppercase_CMAKE_BUILD_TYPE}
		"${CMAKE_CXX_FLAGS_${uppercase_CMAKE_BUILD_TYPE}} ${PACKAGE_CXX_FLAGS}")
	set(_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}
			${CMAKE_CURRENT_SOURCE_DIR}/include  ${CMAKE_CURRENT_BINARY_DIR}
			${KONOHA_INCLUDE_DIRS}
			${_PACKAGE_INCLUDE_DIR})
	include_directories(${_INCLUDE_DIRS})
	list(LENGTH PACKAGE_SOURCE_CODE LEN)
	if(${LEN} GREATER 0)
		add_library(${LIB} SHARED ${PACKAGE_SOURCE_CODE})
		set_target_properties(${LIB} PROPERTIES PREFIX "")
		target_link_libraries(${LIB} konoha2)
		if(PACKAGE_EXTRA_LIBRARY)
		target_link_libraries(${LIB} ${PACKAGE_EXTRA_LIBRARY})
		endif(PACKAGE_EXTRA_LIBRARY)
		install(TARGETS ${LIB} DESTINATION ${_KONOHA_PACKAGE_DIR})
	endif(${LEN} GREATER 0)
	install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/${PACKAGE_SCRIPT_CODE} DESTINATION ${_KONOHA_PACKAGE_DIR})
endmacro(create_package_project)

macro(add_konoha_package PKGNAME)
	set(__BUILD true)
	foreach(arg ${ARGN})
		if (NOT ${arg})
			set(__BUILD false)
		endif (NOT ${arg})
	endforeach(arg ${ARGN})
	if (__BUILD)
		create_package_project(${PKGNAME})
	endif (__BUILD)
endmacro(add_konoha_package)

# ============= #

project(lib.clearsilver)

find_path(HAVE_CLEARSILVER_H "ClearSilver/ClearSilver.h" PATHS ${INCLUDE_DIRS})

if(HAVE_CLEARSILVER_H)
	find_library(LIB_NEO_CS neo_cs)
	find_library(LIB_NEO_CGI neo_cgi)
	find_library(LIB_NEO_UTL neo_utl)
	find_library(LIB_Z z)
	set(CLEARSILVER_LIBS ${LIB_NEO_CS} ${LIB_NEO_UTL} ${LIB_NEO_CGI} ${LIB_Z})
	set(PACKAGE_EXTRA_LIBRARY ${CLEARSILVER_LIBS})
	set(PACKAGE_SOURCE_CODE clearsilver_glue.c)
	set(PACKAGE_SCRIPT_CODE clearsilver_glue.k)
	set(_PACKAGE_INCLUDE_DIR ${HAVE_CLEARSILVER_H}/ClearSilver)
	add_konoha_package(lib.clearsilver)
endif(HAVE_CLEARSILVER_H)
