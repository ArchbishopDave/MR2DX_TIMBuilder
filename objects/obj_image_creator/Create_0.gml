m_surface_prepared = false;
m_surface = new str_surface();

m_timlist = obj_tim_open_r2.m_tim_list;
m_msx = 0; m_msy = 0;
m_icols = ceil(sqrt(array_length(m_timlist)));

for ( var i = 0; i < array_length(m_timlist); i++ ) {
    var tim = m_timlist[i];
    
    m_msx = max( m_msx, ( tim.image.iw * tim.image.wmult ) );
    m_msy = max( m_msy, tim.image.ih );
}
