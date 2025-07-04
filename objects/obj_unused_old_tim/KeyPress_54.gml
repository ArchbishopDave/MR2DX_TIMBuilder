for ( var i = 0; i < array_length(m_tim_list); i++ ) {
    var ctim = m_tim_list[i];
    
    for ( var j = 0; j < array_length(ctim.image.data); j++ ) {
        var idat = ctim.image.data[j];
        
        for ( var k = 0; k < array_length(m_palette_new); k++ ) {
            var npal = m_palette_new[k];
            
            if ( ctim.clut.colors[idat].raw == npal.color.raw ) {
                ctim.image.data[j] = npal.id;
            }
        }
    }
}

for ( var i = 0; i < array_length(m_tim_list); i++ ) {
    var ctim = m_tim_list[i];
    
    ctim.clut.colors = [];
    
    for ( var j = 0; j < array_length(m_palette_new); j++ ) {
        array_push(ctim.clut.colors, new str_color_copy(m_palette_new[j].color));
    }
    
    for ( var k = array_length(m_palette_new); k < 256; k++ ) {
        array_push(ctim.clut.colors, new str_color_copy(m_palette_new[0].color));
    }
}

m_palette = m_palette_new;
m_palette_length = m_palette_len;