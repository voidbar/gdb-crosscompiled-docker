set -e

[ -z "$GDB_VERSION" ] && echo "Env GDB_VERSION is not set" && exit 1
[ -z "$HOST" ] && echo "Env HOST is not set" && exit 1
[ -z "$TARGET" ] && echo "Env TARGET is not set" && exit 1
[ -z "$TARGET_TOOLCHAIN" ] && echo "Env TARGET_TOOLCHAIN is not set" && exit 1

mkdir src
wget -qO- https://ftp.gnu.org/gnu/gdb/gdb-$GDB_VERSION.tar.gz | tar -xvz --strip-components=1 -C ./src

mkdir arm-gdb
mkdir arm-gdbserver

# Compiling gdb with arm target
cd arm-gdb
../src/configure --srcdir=../src --host=${HOST} --target=${TARGET}
make

# Compiling gdbserver
cd ../arm-gdbserver
CROSS_COMPILE=$TARGET_TOOLCHAIN ../src/gdb/gdbserver/configure --srcdir=../src/gdb/gdbserver --host ${TARGET}
make

cd ..
tar -rvf $1 arm-gdb/ arm-gdbserver/