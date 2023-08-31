package terminal

import "core:os"


detect_fd_capabilities :: proc(fd: os.Handle) -> (term: Info) {unimplemented("TODO: windows")}
enable_terminal_processing :: proc() {unimplemented("TODO")}
