# Cross-compiling for Windows can be done by passing `-d:crosswin` to Nim
when defined(crosswin):
  switch("cc", "gcc")
  let mingwExe = "x86_64-w64-mingw32-gcc"
  switch("gcc.linkerexe", mingwExe)
  switch("gcc.exe", mingwExe)
  switch("gcc.path", "/usr/bin/")
  switch("gcc.options.linker", "")
  switch("os", "windows")
  switch("define", "windows")
