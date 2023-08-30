package terminal

import "core:testing"
import "core:os"
import "core:fmt"

@test
show_colors :: proc(t: ^testing.T) {
	set_fg_color(Basic_Color.Red)
	set_bg_color(os.stdout, Basic_Color.Yellow)
	fmt.printf("Hello ")
	set_bg_color(Basic_Color.White)
	set_fg_color(os.stdout, Basic_Color.Blue)
	fmt.printf("World")
	clear_style()
	fmt.println("!")
}
