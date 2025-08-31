draw_set_color(c_white);
draw_text(8, 32 + 8, md_message_current);
draw_text(8, 32 + 24, md_message_processing);

draw_set_align(1, 1);
draw_set_color(c_orange);
draw_text(window_get_width() - 8, window_get_height() - 8, md_message_version);
draw_set_align(-1, -1);
draw_set_color(c_white);