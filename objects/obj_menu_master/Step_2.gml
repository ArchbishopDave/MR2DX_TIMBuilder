if ( m_import_tim.m_pressed ) {
    user_event(obj_tim_open_r2, 0);
    
    if ( array_length(obj_tim_open_r2.m_tim_list) > 0 ) {
        m_export_png.m_available = true;
        m_import_png.m_available = true;
        
        m_current_message = "Export the TIM's PNG and make edits, or import the a PNG to continue, or Import a new TIM to start over."
    }
    
    else {
        m_current_message = "Click Import TIM to load an MRDX2.tex or .tim file.";
        m_import_png.m_available = false;
        m_export_png.m_available = false;
        m_export_tim.m_available = false;
    }
    
    m_import_tim.m_pressed = false;
}

else if ( m_export_png.m_pressed ) {
    var filename = get_save_filename("MRDX2 TIMBuilder Texture Map|*.png", string_delete(obj_tim_open_r2.m_filename, -1, -3) + "png"); 
    if ( filename != "" ) {
        var ic = instance_create_depth(OOB, OOB, 0, obj_image_creator);
        ic.m_filename_png = filename;
        m_current_message = "PNG Exported. Make edits and import the new PNG to continue.";
        m_export_png.m_available = false;
    }
    
    m_export_png.m_pressed = false;
}

else if ( m_import_png.m_pressed ) {
    var filename = get_open_filename_ext("MRDX2 TIMBuilder Texture Mapping|*.png", "", "","Import PNG into the loaded TIM");
    if ( filename != "" ) {
        scr_image_import(filename, obj_tim_open_r2.m_tim_list);  
        m_current_message = "Importing PNG and Processing TIM for Export."
        m_menu_locked = true;
        m_processing = true;
        m_processing_step = 1;
        m_processing_cur = 0;
        
        m_export_png.m_available = false;
        m_export_tim.m_available = true;
    }
    
    m_import_png.m_pressed = false;
}

else if ( m_export_tim.m_pressed ) {
    var filename = get_save_filename("MRDX2 TEX|*.tex;*.tim", obj_tim_open_r2.m_filename); 
    if ( filename != "" ) {
        obj_tim_open_r2.f_convert_to_tim(obj_tim_open_r2.m_tim_list, filename);
        m_current_message = "TIM Exported Successfully.";
        m_export_png.m_available = false; 
    }
        
    m_export_tim.m_pressed = false;
}
