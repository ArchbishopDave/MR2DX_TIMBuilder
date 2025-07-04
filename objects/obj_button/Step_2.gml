
if ( !obj_menu_master.m_menu_locked && m_available && !m_pressed ) {
     if ( m_hovering ) {
        sprite_index = spr_button_highlight; 
    } else {
        sprite_index = spr_button_normal;
    }
}

else if ( !obj_menu_master.m_menu_locked && m_available && m_pressed ) {
     if ( m_hovering ) {
        sprite_index = spr_button_highlight_dp; 
    } else {
        sprite_index = spr_button_pressed;
    }
}

else {
    sprite_index = spr_button_unavailable;
}