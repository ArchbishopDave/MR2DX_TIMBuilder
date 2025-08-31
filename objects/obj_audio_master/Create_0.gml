m_sounds_enabled = true;

f_play_sound = function(_sound) {
    if ( m_sounds_enabled ) {
        audio_play_sound(_sound, 0, false);
    }
}

m_button_sound = instance_create_depth(512 + 256, 0, 0, obj_button);
m_button_sound.m_text = "Sound On";
m_button_sound.m_available = true;

