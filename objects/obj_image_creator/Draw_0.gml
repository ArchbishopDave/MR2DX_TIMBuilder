if ( m_filename_png != "" ) {
    if ( !m_surface_prepared ) {
        if ( m_surface.f_check_and_set(m_msx * m_icols, m_msy * m_icols) ) {
            for ( var i = 0; i < array_length(m_timlist); i++ ) {
                var tim = m_timlist[i];
                
                var idata = tim.image.data;
                var ix = ( i % m_icols ) * m_msx;
                var iy = ( i div m_icols ) * m_msy;
                
                var cx = 0; var cy = -1;
                for ( var j = 0; j < array_length(idata); j++ ) {
                    cx = j % (tim.image.iw * tim.image.wmult);
                    if ( cx == 0 ) { cy++; }
                    var color = idata[j];
                    var blackstp = tim.clut.colors[color].stp;
                    if ( tim.clut.colors[color].r == 0 && tim.clut.colors[color].g == 0 && tim.clut.colors[color].b == 0 ) { blackstp = !blackstp; }
                    //draw_sprite_ext(spr_1x1, 0, ix + (cx * 1 ), iy + (cy*1), 1, 1, 0, tim.clut.colors[color].gmcolor, 1 - ( 0.03 * tim.clut.colors[color].stp) ); 
                    draw_sprite_ext(spr_1x1, 0, ix + (cx * 1 ), iy + (cy*1), 1, 1, 0, tim.clut.colors[color].gmcolor, 1 - ( 0.03 * blackstp) ); 
                }
            }
            
            m_surface_prepared = true;
            
            surface_save(m_surface.surface, m_filename_png);
            surface_reset_target();
        }
    }
}

instance_destroy();
            