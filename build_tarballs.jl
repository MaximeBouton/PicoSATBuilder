# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

name = "PicoSATBuilder"
version = v"9.6.0"

# Collection of sources required to build PicoSATBuilder
sources = [
    "http://fmv.jku.at/picosat/picosat-965.tar.gz" =>
    "15169b4f28ba8f628f353f6f75a100845cdef4a2244f101a02b6e5a26e46a754",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
cd picosat-965/
./configure.sh --shared
make
cd $WORKSPACE/srcdir
ls
cd picosat-965/
ls
mv *.o $WORKSPACE/destdir

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:x86_64, libc=:glibc)
]

# The products that we will ensure are always built
products(prefix) = [
    FileProduct(prefix, "version", :version),
    FileProduct(prefix, "picomcs", :picomcs),
    FileProduct(prefix, "main", :main),
    FileProduct(prefix, "picogcnf", :picogcnf),
    FileProduct(prefix, "picomus", :picomus),
    FileProduct(prefix, "picosat", :picosat),
    FileProduct(prefix, "app", :app)
]

# Dependencies that must be installed before this package can be built
dependencies = [
    
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)

