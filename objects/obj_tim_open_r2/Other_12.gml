// Count Palette Uses
for ( var i = 0; i < array_length(m_tim_list); i++ ) {
    var ctim = m_tim_list[i];
    
    for ( var j = 0; j < array_length(ctim.image.data); j++ ) {
        var image_cid = ctim.image.data[j];
        var color = ctim.clut.colors[image_cid];
        
        ctim.palette.palette_slots[color.palette_id].uses = ctim.palette.palette_slots[color.palette_id].uses + 1;
    }
}