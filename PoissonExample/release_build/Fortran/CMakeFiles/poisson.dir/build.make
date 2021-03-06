# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.5

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /afs/.mathematik.uni-stuttgart.de/home/cmcs/share/environment-modules/Packages/cmake/3.5.0/bin/cmake

# The command to remove a file.
RM = /afs/.mathematik.uni-stuttgart.de/home/cmcs/share/environment-modules/Packages/cmake/3.5.0/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /usr/local/home/kraemer/software/iron-examples/PoissonExample

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /usr/local/home/kraemer/software/iron-examples/PoissonExample/release_build

# Include any dependencies generated for this target.
include Fortran/CMakeFiles/poisson.dir/depend.make

# Include the progress variables for this target.
include Fortran/CMakeFiles/poisson.dir/progress.make

# Include the compile flags for this target's objects.
include Fortran/CMakeFiles/poisson.dir/flags.make

Fortran/CMakeFiles/poisson.dir/src/NonlinearPoissonExample.f90.o: Fortran/CMakeFiles/poisson.dir/flags.make
Fortran/CMakeFiles/poisson.dir/src/NonlinearPoissonExample.f90.o: ../Fortran/src/NonlinearPoissonExample.f90
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/usr/local/home/kraemer/software/iron-examples/PoissonExample/release_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building Fortran object Fortran/CMakeFiles/poisson.dir/src/NonlinearPoissonExample.f90.o"
	cd /usr/local/home/kraemer/software/iron-examples/PoissonExample/release_build/Fortran && /usr/bin/f95  $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -c /usr/local/home/kraemer/software/iron-examples/PoissonExample/Fortran/src/NonlinearPoissonExample.f90 -o CMakeFiles/poisson.dir/src/NonlinearPoissonExample.f90.o

Fortran/CMakeFiles/poisson.dir/src/NonlinearPoissonExample.f90.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing Fortran source to CMakeFiles/poisson.dir/src/NonlinearPoissonExample.f90.i"
	cd /usr/local/home/kraemer/software/iron-examples/PoissonExample/release_build/Fortran && /usr/bin/f95  $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -E /usr/local/home/kraemer/software/iron-examples/PoissonExample/Fortran/src/NonlinearPoissonExample.f90 > CMakeFiles/poisson.dir/src/NonlinearPoissonExample.f90.i

Fortran/CMakeFiles/poisson.dir/src/NonlinearPoissonExample.f90.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling Fortran source to assembly CMakeFiles/poisson.dir/src/NonlinearPoissonExample.f90.s"
	cd /usr/local/home/kraemer/software/iron-examples/PoissonExample/release_build/Fortran && /usr/bin/f95  $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -S /usr/local/home/kraemer/software/iron-examples/PoissonExample/Fortran/src/NonlinearPoissonExample.f90 -o CMakeFiles/poisson.dir/src/NonlinearPoissonExample.f90.s

Fortran/CMakeFiles/poisson.dir/src/NonlinearPoissonExample.f90.o.requires:

.PHONY : Fortran/CMakeFiles/poisson.dir/src/NonlinearPoissonExample.f90.o.requires

Fortran/CMakeFiles/poisson.dir/src/NonlinearPoissonExample.f90.o.provides: Fortran/CMakeFiles/poisson.dir/src/NonlinearPoissonExample.f90.o.requires
	$(MAKE) -f Fortran/CMakeFiles/poisson.dir/build.make Fortran/CMakeFiles/poisson.dir/src/NonlinearPoissonExample.f90.o.provides.build
.PHONY : Fortran/CMakeFiles/poisson.dir/src/NonlinearPoissonExample.f90.o.provides

Fortran/CMakeFiles/poisson.dir/src/NonlinearPoissonExample.f90.o.provides.build: Fortran/CMakeFiles/poisson.dir/src/NonlinearPoissonExample.f90.o


# Object files for target poisson
poisson_OBJECTS = \
"CMakeFiles/poisson.dir/src/NonlinearPoissonExample.f90.o"

# External object files for target poisson
poisson_EXTERNAL_OBJECTS =

Fortran/poisson: Fortran/CMakeFiles/poisson.dir/src/NonlinearPoissonExample.f90.o
Fortran/poisson: Fortran/CMakeFiles/poisson.dir/build.make
Fortran/poisson: /usr/local/home/kraemer/software/OpenCMISS/iron/install/x86_64_linux/gnu-4.9-F4.9/openmpi_release/release/lib/libiron_c.so
Fortran/poisson: /usr/local/home/kraemer/software/OpenCMISS/iron/install/x86_64_linux/gnu-4.9-F4.9/openmpi_release/release/lib/libiron.so
Fortran/poisson: /usr/lib/libmpi_f90.so
Fortran/poisson: /usr/lib/libmpi_f77.so
Fortran/poisson: /usr/lib/libmpi.so
Fortran/poisson: /usr/lib/libmpi.so
Fortran/poisson: /usr/lib/x86_64-linux-gnu/libdl.so
Fortran/poisson: /usr/lib/x86_64-linux-gnu/libhwloc.so
Fortran/poisson: Fortran/CMakeFiles/poisson.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/usr/local/home/kraemer/software/iron-examples/PoissonExample/release_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking Fortran executable poisson"
	cd /usr/local/home/kraemer/software/iron-examples/PoissonExample/release_build/Fortran && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/poisson.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
Fortran/CMakeFiles/poisson.dir/build: Fortran/poisson

.PHONY : Fortran/CMakeFiles/poisson.dir/build

Fortran/CMakeFiles/poisson.dir/requires: Fortran/CMakeFiles/poisson.dir/src/NonlinearPoissonExample.f90.o.requires

.PHONY : Fortran/CMakeFiles/poisson.dir/requires

Fortran/CMakeFiles/poisson.dir/clean:
	cd /usr/local/home/kraemer/software/iron-examples/PoissonExample/release_build/Fortran && $(CMAKE_COMMAND) -P CMakeFiles/poisson.dir/cmake_clean.cmake
.PHONY : Fortran/CMakeFiles/poisson.dir/clean

Fortran/CMakeFiles/poisson.dir/depend:
	cd /usr/local/home/kraemer/software/iron-examples/PoissonExample/release_build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /usr/local/home/kraemer/software/iron-examples/PoissonExample /usr/local/home/kraemer/software/iron-examples/PoissonExample/Fortran /usr/local/home/kraemer/software/iron-examples/PoissonExample/release_build /usr/local/home/kraemer/software/iron-examples/PoissonExample/release_build/Fortran /usr/local/home/kraemer/software/iron-examples/PoissonExample/release_build/Fortran/CMakeFiles/poisson.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : Fortran/CMakeFiles/poisson.dir/depend

