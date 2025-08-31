if ( m_import_tim.m_pressed ) {
    
    user_event(obj_tim_open_r2, 0);
    
    if ( array_length(obj_tim_open_r2.m_tim_list) > 0 ) {
        m_export_png.m_available = true;
        m_import_png.m_available = true;
        m_button_cmode.m_available = false;
        
        md_message_current = "Export the TIM's PNG and make edits, or import the a PNG to continue, or Import a new TIM to start over."
        md_message_processing = "";
    }
    
    else {
        obj_audio_master.f_play_sound(sou_reject);
        m_button_cmode.m_available = true;
        m_import_png.m_available = false;
        m_export_png.m_available = false;
        m_export_tim.m_available = false;
        
        md_message_current = "Click Import TIM to load an MR2DX.tex or .tim file.\nClick Creator Mode to use the expedited TIM creation process.";
        md_message_processing = "";
    }
    
    m_import_tim.m_pressed = false;
}

else if ( m_export_png.m_pressed ) {
    var filename = get_save_filename("MR2DX TIMBuilder Texture Map|*.png", string_delete(obj_tim_open_r2.m_filename, -1, -3) + "png"); 
    if ( filename != "" ) {
        var ic = instance_create_depth(OOB, OOB, 0, obj_image_creator);
        ic.m_filename_png = filename;
        md_message_current = "PNG Exported. Make edits and import the new PNG to continue.";
        m_export_png.m_available = false;
    }
    
    else {
        obj_audio_master.f_play_sound(sou_reject);
    }
    
    m_export_png.m_pressed = false;
}

else if ( m_import_png.m_pressed ) {
    var filename = get_open_filename_ext("MR2DX TIMBuilder Texture Mapping|*.png", "", "","Import PNG into the loaded TIM");
    if ( filename != "" ) {
        scr_image_import(filename, obj_tim_open_r2.m_tim_list);  
        md_message_current = "Importing PNG and Processing TIM for Export."
        m_menu_locked = true;
        m_processing = true;
        m_processing_step = 1;
        m_processing_cur = 0;
        
        m_export_png.m_available = false;
        m_export_tim.m_available = true;
    }
    
    else { 
        obj_audio_master.f_play_sound(sou_reject);
    }
    
    m_import_png.m_pressed = false;
}

else if ( m_export_tim.m_pressed ) {
    var filename = get_save_filename("MR2DX TEX|*.tex;*.tim", obj_tim_open_r2.m_filename); 
    if ( filename != "" ) {
        obj_tim_open_r2.f_convert_to_tim(obj_tim_open_r2.m_tim_list, filename);
        md_message_current = "TIM Exported Successfully.";
        m_export_png.m_available = false; 
    }
        
    else {
        obj_audio_master.f_play_sound(sou_reject);
    }
    
    m_export_tim.m_pressed = false;
}

else if ( m_button_cmode.m_pressed ) {

    var exitMode = false;
    
    if ( obj_file_monitor.m_enabled ) { exitMode = true; }
        
    else {
        user_event(obj_tim_open_r2, 0);
        
        if ( array_length(obj_tim_open_r2.m_tim_list) > 0 ) {
            
            m_import_tim.m_available = false;
            m_import_png.m_available = false;
            m_export_png.m_available = false;
            m_export_tim.m_available = false;
            
            user_event(obj_file_monitor, 0);
        }
        
        if ( obj_file_monitor.m_enabled ) {
            md_message_current = "Creator Mode is now enabled. Click the Creator Mode button again to disable this mode of operation."
        }
        else {
            exitMode = true;
        }
    }
    
    if ( exitMode ) {
        obj_audio_master.f_play_sound(sou_reject);
        
        md_message_current = "Click Import TIM to load an MR2DX.tex or .tim file.\nClick Creator Mode to use the expedited TIM creation process.";
        md_message_processing = "";
        
        m_import_tim.m_available = true;
        m_import_png.m_available = false;
        m_export_png.m_available = false;
        m_export_tim.m_available = false;
    }
    
    m_button_cmode.m_pressed = false;
}