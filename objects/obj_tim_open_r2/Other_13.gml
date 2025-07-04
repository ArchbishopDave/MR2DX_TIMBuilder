// Merge all colors below the usage threshold into another palette
for ( var i = 0; i < array_length(m_palette_list); i++ ) {
    
    var palette = m_palette_list[i];
    var uniques = palette.max_slots + 1;
    
    var min_uses = 0;
    
    while ( uniques > palette.max_slots ) {
        uniques = 0;
        for ( var j = 0; j < array_length(palette.palette_slots); j++ ) {
            var pdata = palette.palette_slots[j];
            
            if ( palette.palette_slots[j].id != j ) { continue; }
            
            if ( pdata.uses <= min_uses ) {
                f_merge_closest_color(j, palette, min_uses);
            }
            
            if ( palette.palette_slots[j].id == j ) { uniques++; }
        }
        min_uses++;
    }
    palette.unique_slots = uniques;
 }