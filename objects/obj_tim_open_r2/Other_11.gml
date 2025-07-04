// Generate Palettes
m_palette_list = [];

for ( var i = 0; i < array_length(m_tim_list); i++ ) {
    var ctim = m_tim_list[i];
    
    var palette = -1;
    var foundpal = false;
    var clut_id = (ctim.clut.cx + 3) * (1028 + ctim.clut.cy);
    for ( var j = 0; j < array_length(m_palette_list); j++ ) {
        var pal = m_palette_list[j];
        
        if ( pal.clut_id == clut_id ) {
            palette = pal;
            foundpal = true;
            break;
        }
    }
    
    if ( !foundpal ) {
        palette = new str_palette(clut_id, ctim.clut.cw * ctim.clut.ch, 0);
        array_push(m_palette_list, palette);
    }
    
    ctim.palette = palette;
    
    
    for ( var j = 0; j < array_length(ctim.clut.colors); j++ ) {
        var cdata = ctim.clut.colors[j];
        var repcolor = false;
        for ( var z = 0; z < array_length(palette.palette_slots); z++ ) {
            if ( palette.palette_slots[z].raw == cdata.raw ) {
                repcolor = true;
                cdata.palette_id = z;
            }
        }
        
        if (!repcolor ) { 
            var pslot = array_length(palette.palette_slots);
            var pdata = {
                id : pslot,
                uses : 0,
                raw : cdata.raw,
                color : new str_color_copy(cdata)
            };
            
            array_push(palette.palette_slots, pdata);
            pdata.color.palette_id = pslot;
            cdata.palette_id = pslot;
        } 
    }
}