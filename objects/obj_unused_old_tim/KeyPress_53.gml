

m_palette_new = [];
m_palette_len = -1;

for ( var i = 0; i < array_length(m_palette); i++ ) {
    var pdata = m_palette[i];
    
    if ( pdata.id == i ) {
        m_palette_len++;
        var newpdata = {
                id : m_palette_len,
                uses : pdata.uses,
                raw : pdata.raw,
                color : new str_color_copy(pdata.color)
        };
        newpdata.color.palette_id = m_palette_len;
        
        array_push(m_palette_new, newpdata);
    }
}
