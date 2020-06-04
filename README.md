# gdb-crosscompiled-docker
This docker builds a cross compiled gdb server and a corresponding gdb binary. 

## Build
`docker build . -t gdbcross`

## Get the cross compiled Gdb and Gdb Server
`docker run --rm gdbcross > compiled.tar.gz`

Or, if these binaries are needed during a build in the Dockfiler:

`COPY --from=gdbcross:latest /root/gdb-cross.tar.gz /root/` 
