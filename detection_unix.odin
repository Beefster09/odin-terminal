//+build linux, darwin, freebsd, openbsd
package terminal

import "core:os"


detect_fd_capabilities :: proc(fd: os.Handle) -> (term: Info) {
	unimplemented(#procedure)
	//unistd.isatty(fd)  // NOTE(justin): I have absolutely no idea how to implement this in pure odin. probably some maze of system calls
}
