var scale = ms_image_scale;
var cx = 0;
var cy = 0;

draw_set_font(f_font);

if ( m_current_tim != -1 ) {
    m_tim = m_tim_list[m_current_tim];
    var v = 4;
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
    draw_text(4, v*16, "MIN Uses: " + string(m_color_minimum_uses)); v++;
    
    if ( m_tim.palette != -1 ) {
        draw_text(4, v*16, "Current Palette Info"); v++;
        draw_text(4, v*16, "CLUT ID: " + string(m_tim.palette.clut_id) + " Slots " + string(array_length(m_tim.palette.palette_slots)) + "/" + string(m_tim.palette.unique_slots));     
    }
    
    scale = ms_image_scale;
    cx = 0;
    cy = 0;
    for ( var j = 0; j < array_length(m_tim.image.data); j++ ) {
        cx = j % (m_tim.image.iw * m_tim.image.wmult);
        if ( cx == 0 ) { cy++; }
        var color = m_tim.image.data[j];
        draw_set_color(m_tim.clut.colors[color].gmcolor);
        draw_sprite_ext(spr_1x1, 0, 256 + (cx * scale), 96 + (cy*scale), scale, scale, 0, m_tim.clut.colors[color].gmcolor, 1);
        //draw_text(400 + 256 + (cx * 6 * 5 ), 32 + (cy * 6 * 5), string(m_tim.clut.colors[color].palette_id));
        draw_text(400 + 256 + (cx * 6 * 5 ), 96 + (cy * 6 * 5), string(color));
     }
    
    var palette = m_tim_list[m_current_tim].palette;
    if ( palette != -1 ) {
        draw_set_color(c_white);
        draw_text(8, WIN_H-48, "Infrequently Used Colors");
        var lowuses = 0;
        scale = 12; cx = -1; cy = -1;
        for ( var j = 0; j < array_length(palette.palette_slots); j++ ) {
            cx++; cx = cx % (16);
            if ( cx == 0 ) { cy++; }
            if ( j == 256 ) { cy++; }
            
            var paldata = palette.palette_slots[j];
            draw_sprite_ext(spr_1x1, 0, 16 + (cx * scale), 256 + 32 + (cy * scale), scale, scale, 0, 
                paldata.color.gmcolor, 1);
            
            
            if ( paldata.uses <= 8 ) {
                draw_sprite_ext(spr_1x1, 0, (lowuses * 24), WIN_H-24, 24, 24, 0, paldata.color.gmcolor, 1);
                draw_text((lowuses * 24), WIN_H-24, string(paldata.uses)); 
                lowuses++;
            }
        }
    }
 }

draw_set_color(c_white);

cx = 0; cy = 0;
for ( var i = 0; i < array_length(m_palette_new); i++ ) {
    cx++; 
    cx = cx % (16);
    if ( cx == 0 ) { cy++; }
    
    draw_sprite_ext(spr_1x1, 0, 256 + (cx * scale), 256 + (cy * scale), scale, scale, 0, 
        m_palette_new[i].color.gmcolor, 1);
    draw_set_color(c_white);
}