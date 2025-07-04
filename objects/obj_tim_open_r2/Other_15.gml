// Create Merged Palette
m_palette_list_new = [];

for ( var i = 0; i < array_length(m_palette_list); i++ ) {
    var palette = m_palette_list[i];
    var newpal = new str_palette(palette.clut_id, palette.max_slots, palette.unique_slots);
    
    for ( var j = 0; j < array_length(palette.palette_slots); j++ ) {
        var pslotdata = palette.palette_slots[j];
        
        if ( pslotdata.id == j ) {
            var newpdata = {
                    id : array_length(newpal.palette_slots),
                    uses : pslotdata.uses,
                    raw : pslotdata.raw,
                    color : new str_color_copy(pslotdata.color)
            };
            newpdata.color.palette_id = array_length(newpal.palette_slots);
            
            array_push(newpal.palette_slots, newpdata);
        }
    }
    
    array_push(m_palette_list_new, newpal);
}