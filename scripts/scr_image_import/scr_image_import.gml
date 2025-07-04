function scr_image_import(_filename, _timlist) {
    var sprite = sprite_add(_filename, 1, false, false, 0, 0);
        
    var m_msx = 0; var m_msy = 0;
    var m_icols = ceil(sqrt(array_length(_timlist)));

    // Get Max XY of a single TIM for the spritesheet
    for ( var i = 0; i < array_length(_timlist); i++ ) {
        var tim = _timlist[i];
        
        m_msx = max( m_msx, ( tim.image.iw * tim.image.wmult ) );
        m_msy = max( m_msy, tim.image.ih );
    }
    
    var surface = new str_surface();
    surface.f_check_and_set(m_icols * m_msx, m_icols * m_msy);
    draw_sprite(sprite, 0, 0, 0);
    surface_reset_target();
    
    for ( var i = 0; i < array_length(_timlist); i++ ) {
        var tim = _timlist[i];
        
        tim.clut.colors = [];
        tim.image.data = [];
        
        var sx = ( i % m_icols ) * m_msx;
        var sy = ( i div m_icols ) * m_msy;
        
        for ( var k = 0; k < tim.image.ih; k++ ) {
            for ( var j = 0; j < ( tim.image.iw * tim.image.wmult ); j++ ) {
                var pixeldata = surface_getpixel_ext(surface.surface, sx + j, sy + k);
                var a = (pixeldata >> 24) & 255;
                var b = (pixeldata >> 16) & 255;
                var g = (pixeldata >> 8) & 255;
                var r = pixeldata & 255;
                
                //a = a < 253 ? 1 : 0;
                //b = (b div 8) * 8;
                //g = (g div 8) * 8;
                //r = (r div 8) * 8;
                
                var gmc = new str_color_rgba(r, g, b, a);
                
                var foundcolor = false;
                for ( var z = 0; z < array_length(tim.clut.colors); z++ ) {
                    var color = tim.clut.colors[z];
                    
                    if ( color.gmcolor == gmc.gmcolor && color.stp == gmc.stp ) {
                        gmc = color;
                        foundcolor = true;
                        array_push(tim.image.data, z);
                        break;
                    }
                }
                
                if ( !foundcolor ) {
                    array_push(tim.image.data, array_length(tim.clut.colors) );
                    array_push(tim.clut.colors, gmc);
                }
            }
        }
    }
    
    surface_free( surface.surface );
}

