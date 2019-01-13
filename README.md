# dsvdb

An experimental DSV-based database software using vibe.d.

## Building and Running

dsvdb is build using the dub package manager. I use dmd2 and dub, but the gdb compiler should also work. Once dmd2 and dub
have been installed, run the project using the command `dub run dsvdb`, or by using the build.ps1 script provided. On some
machines, it may be necessary to NOT use the default optlink linker. In such a case, use `dub run dsvdb --arch=x86_mscoff`
instead.