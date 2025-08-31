if ( !m_enabled ) { exit; }
    
if ( m_processing && obj_menu_master.m_processing == false ) {
    m_processing = false;
    obj_tim_open_r2.f_convert_to_tim(obj_tim_open_r2.m_tim_list, m_file_tim_export);
    obj_audio_master.f_play_sound(sou_confirm);
    obj_menu_master.md_message_processing = "Texture file exported successfully. Awaiting additional PNG updates."
}