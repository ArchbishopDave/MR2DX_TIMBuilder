if ( m_processing ) {
    m_menu_locked = true;
    
    if ( m_processing_step == 4 ) {
        user_event(obj_tim_open_r2, m_processing_step);
    }
    
    if ( m_processing_cur == 0 ) {
        user_event(obj_tim_open_r2, m_processing_step);
        
        if ( m_processing_step == 1 ) {
            m_current_message = "Processing PNG (1/6): Generating Color Palette Used"; }
        else if ( m_processing_step == 2 ) {
            m_current_message = "Processing PNG (2/6): Counting Palette Uses."; }
        else if ( m_processing_step == 3 ) {
            m_current_message = "Processing PNG (3/6): Merging Colors to meet CLUT requirements."; }
        else if ( m_processing_step == 4 ) {
            m_current_message = "Processing PNG (4/6): Applying Merged Colors to TIM Data."; }
        else if ( m_processing_step == 5 ) {
            m_current_message = "Processing PNG (5/6): Updating Palette Color IDs"; }
        else if ( m_processing_step == 6 ) {
            m_current_message = "Processing PNG (6/6): Applying new IDS to TIM Data."; }
        
        
        
    }
    
    m_processing_cur++;
    
    if ( m_processing_cur > m_processing_max ) { 
        m_processing_cur = 0; 
        m_processing_step++;
    }
    
    if ( m_processing_step >= 7 ) {
        m_menu_locked = false;
        m_processing = false;
        m_processing_step = 1;
    }
}