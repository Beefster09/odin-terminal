package terminal


Info :: struct {
	width, height: int,
	is_tty: bool,
	supports_ansi_escapes: bool,
	color: Color_Mode,
}

Color_Mode :: enum u8 {
	None,
	Color_16,
	Color_256,
	Color_True,
}
