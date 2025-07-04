if ( m_current_tim != -1 ) {
    m_tim = m_tim_list[m_current_tim];
    var v = 0;
    draw_set_color(c_white);
    draw_text(4, v*16, m_filename); v++;
    draw_text(4, v*16, "TIM " + string (m_current_tim+1) + "/" + string(array_length(m_tim_list))); v++;
    draw_text(4, v*16, "Version: " + string(m_tim.header.tagver)); v++;
    draw_text(4, v*16, "BPC: " +  string(m_tim.header.bppclp)); v++;
    draw_text(4, v*16, "CLUT"); v++;
    draw_text(4, v*16, "CLEN: " +  string(m_tim.clut.length)); v++;
    draw_text(4, v*16, "CVALs: " +  string(m_tim.clut.cx) + " " +  string(m_tim.clut.cy) + " " +  string(m_tim.clut.cw) + " " +  string(m_tim.clut.ch)); v++;
    //for (var i = 0; i < array_length(m_tim.clut.colors); i++) {
    //    draw_set_color(make_color_rgb(m_tim.clut.colors[i].r * 8, m_tim.clut.colors[i].g * 8, m_tim.clut.colors[i].b * 8));
    //    draw_text(4, v*16, "C" + string(i) + ": " + string(m_tim.clut.colors[i].raw) + " | " +  string(m_tim.clut.colors[i].r) + ", " +  string(m_tim.clut.colors[i].g) + ", " +  
    //        string(m_tim.clut.colors[i].b) + ", " +  string(m_tim.clut.colors[i].stp)); v++;
    // }
    
    draw_text(4, v*16, "ILEN: " +  string(m_tim.image.length)); v++;
    draw_text(4, v*16, "IVALs: " +  string(m_tim.image.ix) + " " +  string(m_tim.image.iy) + " " +  string(m_tim.image.iw) + " " +  string(m_tim.image.ih)); v++;
    draw_text(4, v*16, "Palette Length: " + string(array_length(m_palette)) + "/" + string(m_palette_length)); v++; 
    draw_text(4, v*16, "MIN Uses: " + string(m_color_minimum_uses)); v++;
    draw_text(4, v*16, "Temp Palette Length: " + string(array_length(m_palette_new)) + "/" + string(m_palette_len)); v++; 
    
    var scale = 6;
    var cx = 0;
    var cy = 0;
    for ( var j = 0; j < array_length(m_tim.image.data); j++ ) {
        cx = j % (m_tim.image.iw * m_tim.image.wmult);
        if ( cx == 0 ) { cy++; }
        var color = m_tim.image.data[j];
        draw_set_color(m_tim.clut.colors[color].gmcolor);
        draw_sprite_ext(spr_1x1, 0, 256 + (cx * scale ), 32 + (cy*scale), scale, scale, 0, m_tim.clut.colors[color].gmcolor, 1);
        draw_text(400 + 256 + (cx * scale * 5 ), 32 + (cy*scale * 5), string(m_tim.clut.colors[color].palette_id));
     }
 }

draw_set_color(c_white);

var lowuses = 0;
var scale = 8; var cx = 0; var cy = 0;
for ( var i = 0; i < array_length(m_palette); i++ ) {
    //if ( m_palette[i].id != i ) { continue; } 
        cx++; 
    cx = cx % (16);
    if ( cx == 0 ) { cy++; }
    
    draw_sprite_ext(spr_1x1, 0, 32 + (cx * scale), 256 + (cy * scale), scale, scale, 0, 
        m_palette[i].color.gmcolor, 1);
    draw_set_color(c_white);
    
    if ( m_palette[i].uses <= m_color_minimum_uses + 4 ) {
        draw_sprite_ext(spr_1x1, 0, 256 + (lowuses * 24), 512, 24, 24, 0, m_palette[i].color.gmcolor, 1);
        draw_text(256 + (lowuses * 24), 512, string(m_palette[i].uses)); 
        lowuses++;
    }
}

cx = 0; cy = 0;
for ( var i = 0; i < array_length(m_palette_new); i++ ) {
    cx++; 
    cx = cx % (16);
    if ( cx == 0 ) { cy++; }
    
    draw_sprite_ext(spr_1x1, 0, 256 + (cx * scale), 256 + (cy * scale), scale, scale, 0, 
        m_palette_new[i].color.gmcolor, 1);
    draw_set_color(c_white);
}