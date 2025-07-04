if ( m_visible ) {
    draw_self();
    draw_set_color(c_white);
    draw_set_align(0, 0);
    draw_text(x + (sprite_width / 2), y + (sprite_height / 2), m_text);
    draw_set_align(-1, -1);
}