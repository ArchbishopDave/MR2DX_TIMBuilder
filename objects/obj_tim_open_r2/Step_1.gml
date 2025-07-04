if ( keyboard_check_pressed(vk_left) ) {
    if ( array_length(m_tim_list) == 0 ) { m_current_tim = -1; }
    m_current_tim = clamp(m_current_tim-1, 0, array_length(m_tim_list)-1);
}

if ( keyboard_check_pressed(vk_right) ) {
    if ( array_length(m_tim_list) == 0 ) { m_current_tim = -1; }
    m_current_tim = clamp(m_current_tim+1, 0, array_length(m_tim_list)-1);
}

if ( keyboard_check_pressed(vk_down) ) {
    ms_image_scale = clamp(ms_image_scale - 1, 1, 16);
}

if ( keyboard_check_pressed(vk_up) ) {
    ms_image_scale = clamp(ms_image_scale + 1, 1, 16);
}