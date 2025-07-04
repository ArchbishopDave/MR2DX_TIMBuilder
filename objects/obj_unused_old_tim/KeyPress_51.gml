// Merge all colors below the usage threshold into another palette
for ( var i = 0; i < array_length(m_palette); i++ ) {
    var pdata = m_palette[i];
    
    if ( pdata.uses < m_color_minimum_uses ) {
        f_merge_closest_color(i, m_palette, m_color_minimum_uses);
    }
}

m_color_minimum_uses++;