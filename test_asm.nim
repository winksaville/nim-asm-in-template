when defined(use_proc):
  # This works when x1 is defined as a proc
  proc x1(name: string) =
    var hi, lo: uint32

    asm """
      rdtsc
      :"=a"(`lo`), "=d"(`hi`)
    """
    var cycles = int64(lo) or (int64(hi) shl 32)

    echo name, " cycles=", cycles

else:
  # Making x1 a template fails to compile the c code.
  # The problem is that the asm code is generated at
  # the top level without being inside of a subroutine.
  # See line 21 of nimcache/test_asm.c.
  template x1(name: string) =
    var hi, lo: uint32

    asm """
      rdtsc
      :"=a"(`lo`), "=d"(`hi`)
    """
    var cycles = int64(lo) or (int64(hi) shl 32)

    echo name, " cycles=", cycles

when isMainModule:
  x1("hi")
