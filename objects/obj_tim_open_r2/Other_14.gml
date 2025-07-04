// Update Image Data with new Palette Information
for ( var i = 0; i < array_length(m_tim_list); i++ ) {
    var ctim = m_tim_list[i];
    
    for ( var j = 0; j < array_length(ctim.clut.colors); j++ ) {
        var clut_color = ctim.clut.colors[j];
        ctim.clut.colors[j] = new str_color_copy(ctim.palette.palette_slots[clut_color.palette_id].color);
    }
}