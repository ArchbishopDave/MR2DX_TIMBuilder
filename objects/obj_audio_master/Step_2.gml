if ( m_button_sound.m_pressed ) {
    m_sounds_enabled = !m_sounds_enabled;
    
    if ( !m_sounds_enabled ) {
        m_button_sound.m_text = "Sound Off";
    } else {
        m_button_sound.m_text = "Sound On";
    }
    
    m_button_sound.m_pressed = false;
}