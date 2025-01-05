# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

# If CMAKE_DISABLE_SOURCE_CHANGES is set to true and the source directory is an
# existing directory in our source tree, calling file(MAKE_DIRECTORY) on it
# would cause a fatal error, even though it would be a no-op.
if(NOT EXISTS "/home/jake/.emacs.d/elpa/vterm-20240825.133/build/libvterm-prefix/src/libvterm")
  file(MAKE_DIRECTORY "/home/jake/.emacs.d/elpa/vterm-20240825.133/build/libvterm-prefix/src/libvterm")
endif()
file(MAKE_DIRECTORY
  "/home/jake/.emacs.d/elpa/vterm-20240825.133/build/libvterm-prefix/src/libvterm-build"
  "/home/jake/.emacs.d/elpa/vterm-20240825.133/build/libvterm-prefix"
  "/home/jake/.emacs.d/elpa/vterm-20240825.133/build/libvterm-prefix/tmp"
  "/home/jake/.emacs.d/elpa/vterm-20240825.133/build/libvterm-prefix/src/libvterm-stamp"
  "/home/jake/.emacs.d/elpa/vterm-20240825.133/build/libvterm-prefix/src"
  "/home/jake/.emacs.d/elpa/vterm-20240825.133/build/libvterm-prefix/src/libvterm-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/jake/.emacs.d/elpa/vterm-20240825.133/build/libvterm-prefix/src/libvterm-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/home/jake/.emacs.d/elpa/vterm-20240825.133/build/libvterm-prefix/src/libvterm-stamp${cfgdir}") # cfgdir has leading slash
endif()
