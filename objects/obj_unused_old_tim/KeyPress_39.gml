if ( array_length(m_tim_list) == 0 ) { m_current_tim = -1; }
m_current_tim = clamp(m_current_tim+1, 0, array_length(m_tim_list)-1);