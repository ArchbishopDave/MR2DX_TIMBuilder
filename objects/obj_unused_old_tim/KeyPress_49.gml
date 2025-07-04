// Generate Palette

m_palette = [];
for ( var i = 0; i < array_length(m_tim_list); i++ ) {
    var ctim = m_tim_list[i];
    for ( var j = 0; j < array_length(ctim.clut.colors); j++ ) {
        var cdata = ctim.clut.colors[j];
        var repcolor = false;
        for ( var z = 0; z < array_length(m_palette); z++ ) {
            if ( m_palette[z].raw == cdata.raw ) {
                repcolor = true;
                cdata.palette_id = z;
            }
        }
        
        if (!repcolor ) { 
            var pdata = {
                id : m_palette_length,
                uses : 0,
                raw : cdata.raw,
                color : new str_color_copy(cdata)
            };
            
            array_push(m_palette, pdata);
            pdata.color.palette_id = array_length(m_palette) - 1;
            cdata.palette_id = array_length(m_palette) - 1;
            
            m_palette_length++;
        } 
    }
}