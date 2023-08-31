package terminal


import "core:fmt"
import "core:os"
import "core:strings"


Basic_Color :: enum u8 {
	Black,
	Red,
	Green,
	Yellow,
	Blue,
	Magenta,
	Cyan,
	Light_Gray,
	Dark_Gray,
	Light_Red,
	Light_Green,
	Light_Yellow,
	Light_Blue,
	Light_Magenta,
	Light_Cyan,
	White,
}

Extended_Color :: distinct u8

set_fg_color :: proc {
	set_fg_color_fd_basic,
	set_fg_color_stdterm_basic,
	set_fg_color_fd_256,
	set_fg_color_stdterm_256,
	set_fg_color_fd_truecolor,
	set_fg_color_stdterm_truecolor,
}

set_bg_color :: proc {
	set_bg_color_fd_basic,
	set_bg_color_stdterm_basic,
	set_bg_color_fd_256,
	set_bg_color_stdterm_256,
	set_bg_color_fd_truecolor,
	set_bg_color_stdterm_truecolor,
}

clear_style :: proc {
	clear_style_fd,
	clear_style_stdterm,
}

// === Implementations ===

clear_style_fd :: proc(fd: os.Handle) {
	os.write(fd, {'\e', '[', '0', 'm'})
}
clear_style_stdterm :: proc() {
	clear_style_fd(os.stderr)
}

// fg color

set_fg_color_fd_basic :: proc(fd: os.Handle, color: Basic_Color) {
	escape: []u8 = {'\e', '[', 0, 0, 'm'}
	if u8(color) <= 7 {
		escape[2] = '3'
	} else {
		escape[2] = '9'
	}
	escape[3] = '0' + (u8(color) & 7)
	os.write(fd, escape)
}
set_fg_color_stdterm_basic :: proc(color: Basic_Color) {
	set_fg_color_fd_basic(os.stderr, color)
}

set_fg_color_fd_256 :: proc(fd: os.Handle, color: Extended_Color) {
	sb_bytes: [11]u8
	sb := strings.builder_from_bytes(sb_bytes[:])
	strings.write_string(&sb, "\e[38;5;")
	strings.write_int(&sb, int(color))
	strings.write_byte(&sb, 'm')
	os.write_string(fd, strings.to_string(sb))
}
set_fg_color_stdterm_256 :: proc(color: Extended_Color) {
	set_fg_color_fd_256(os.stderr, color)
}

set_fg_color_fd_truecolor :: proc(fd: os.Handle, r, g, b: u8) {
	sb_bytes: [19]u8
	sb := strings.builder_from_bytes(sb_bytes[:])
	strings.write_string(&sb, "\e[38;2;")
	strings.write_int(&sb, int(r))
	strings.write_byte(&sb, ';')
	strings.write_int(&sb, int(g))
	strings.write_byte(&sb, ';')
	strings.write_int(&sb, int(b))
	strings.write_byte(&sb, 'm')
	os.write_string(fd, strings.to_string(sb))
}
set_fg_color_stdterm_truecolor :: proc(r, g, b: u8) {
	set_fg_color_fd_truecolor(os.stderr, r, g, b)
}

// bg color

set_bg_color_fd_basic :: proc(fd: os.Handle, color: Basic_Color) {
	escape: []u8
	if u8(color) <= 7 {
		escape = {'\e', '[', '4', '0' + (u8(color) & 7), 'm'}
	} else {
		escape = {'\e', '[', '1', '0', '0' + (u8(color) & 7), 'm'}
	}
	os.write(fd, escape)
}
set_bg_color_stdterm_basic :: proc(color: Basic_Color) {
	set_bg_color_fd_basic(os.stderr, color)
}

set_bg_color_fd_256 :: proc(fd: os.Handle, color: Extended_Color) {
	sb_bytes: [11]u8
	sb := strings.builder_from_bytes(sb_bytes[:])
	strings.write_string(&sb, "\e[48;5;")
	strings.write_int(&sb, int(color))
	strings.write_byte(&sb, 'm')
	os.write_string(fd, strings.to_string(sb))
}
set_bg_color_stdterm_256 :: proc(color: Extended_Color) {
	set_bg_color_fd_256(os.stderr, color)
}

set_bg_color_fd_truecolor :: proc(fd: os.Handle, r, g, b: u8) {
	sb_bytes: [19]u8
	sb := strings.builder_from_bytes(sb_bytes[:])
	strings.write_string(&sb, "\e[48;2;")
	strings.write_int(&sb, int(r))
	strings.write_byte(&sb, ';')
	strings.write_int(&sb, int(g))
	strings.write_byte(&sb, ';')
	strings.write_int(&sb, int(b))
	strings.write_byte(&sb, 'm')
	os.write_string(fd, strings.to_string(sb))
}
set_bg_color_stdterm_truecolor :: proc(r, g, b: u8) {
	set_bg_color_fd_truecolor(os.stderr, r, g, b)
}
