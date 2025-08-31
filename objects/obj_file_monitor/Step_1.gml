if ( !m_enabled ) { exit; }
    
m_timer_cur++;

if ( m_timer_cur >= m_timer_max && !m_processing ) {
    var newhash = md5_file(m_file_png_import);
    
    if ( newhash != m_file_png_hash ) {
        obj_audio_master.f_play_sound(sou_select);
        scr_image_import(m_file_png_import, obj_tim_open_r2.m_tim_list);  
        
        obj_menu_master.m_processing = true;
        obj_menu_master.m_processing_step = 1;
        obj_menu_master.m_processing_cur = 0;
        m_processing = true;
    
        m_file_png_hash = newhash;
    }
    
    m_timer_cur = 0;
}