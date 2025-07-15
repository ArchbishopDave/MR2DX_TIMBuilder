// Remap and Update CLUTS
for ( var i = 0; i < array_length(m_tim_list); i++ ) {
    var ctim = m_tim_list[i];
    
    for ( var j = 0; j < array_length(ctim.image.data); j++ ) {
        var idat = ctim.image.data[j];
        
        if ( m_ignore_merge_battle_file && i == 1 && m_ignore_merge_image_data[j] == 3 ) { 
            ctim.image.data[j] = 3;
            continue; 
        } // Handle the special cases where we want to preserve the '2nd' transparent black.
            
        for ( var k = 0; k < array_length(m_palette_list_new); k++ ) {
            var palette = m_palette_list_new[k];
            if ( palette.clut_id == ctim.palette.clut_id ) {
                for ( var z = 0; z < array_length(palette.palette_slots); z++ ) {
                    
                    var npal = palette.palette_slots[z];
                    
                    if ( ctim.clut.colors[idat].raw == npal.color.raw ) {
                        ctim.image.data[j] = npal.id;
                        break;
                    } 
                }
            }
        }
    }
}

for ( var i = 0; i < array_length(m_tim_list); i++ ) {
    var ctim = m_tim_list[i];
    
    ctim.clut.colors = [];
    var palette = -1;
    
    for ( var k = 0; k < array_length(m_palette_list_new); k++ ) {
        if ( m_palette_list_new[k].clut_id == ctim.palette.clut_id ) {
            palette = m_palette_list_new[k];
       }
   }
        
    
    var current = 0;
    
    for ( var j = 0; j < min(ctim.clut.cw * ctim.clut.ch, array_length(palette.palette_slots)); j++ ) {
        array_push(ctim.clut.colors, new str_color_copy(palette.palette_slots[j].color));
        current++;
    }
    
    for ( var k = current; k < (ctim.clut.cw * ctim.clut.ch); k++ ) {
        array_push(ctim.clut.colors, new str_color_copy(palette.palette_slots[0].color));
    }
    
    ctim.palette = palette;
}

m_palette_list = m_palette_list_new;