package terminal


Capabilities :: struct {
	is_tty: bool,
	color: Color_Capabilities,
}

Color_Capabilities :: enum {
	None,
	Color_16,
	Color_256,
	Color_True,
}
