package terminal

import "core:testing"
import "core:os"
import "core:fmt"

@test
show_colors :: proc(t: ^testing.T) {
	set_fg_color(Basic_Color.Light_Red)
	set_bg_color(os.stdout, Basic_Color.Yellow)
	fmt.printf("Hello ")
	set_bg_color(Basic_Color.White)
	set_fg_color(os.stdout, Basic_Color.Blue)
	fmt.printf("World")
	clear_style()
	fmt.println("!")

	set_fg_color(Extended_Color(45))
	set_bg_color(48, 64, 96)
	fmt.printf("a mix of 8-bit")
	set_fg_color(127, 127, 192)
	set_bg_color(Extended_Color(206))
	fmt.printf(" and truecolor")
	clear_style()
	fmt.println()
}
