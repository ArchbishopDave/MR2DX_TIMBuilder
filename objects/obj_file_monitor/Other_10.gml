m_enabled = true;

m_file_png_import = get_open_filename_ext("MR2DX TIMBuilder Texture Mapping|*.png", "", "","Track and import the selected PNG file.");

if ( m_file_png_import != "" ) {
    
    m_file_tim_export = get_save_filename_ext("MR2DX TEX|*.tex;*.tim", obj_tim_open_r2.m_filename, "", "The MR2DX TEX file to save to."); 
}

if ( m_file_png_import == "" || m_file_tim_export = "" ) {
    m_enabled = false;
}

else {
    obj_audio_master.f_play_sound(sou_select);
    scr_image_import(m_file_png_import, obj_tim_open_r2.m_tim_list);  
    
    obj_menu_master.m_processing = true;
    obj_menu_master.m_processing_step = 1;
    obj_menu_master.m_processing_cur = 0;
    m_processing = true;
    
    
    
    m_file_png_hash = md5_file(m_file_png_import);
}

        

    

