user_event(self.id, 15);

m_filename = "";
m_timbuffer = -1;

m_palette_list = [];
m_palette_list_new = [];

m_palette = [];
m_palette_length = 0;

m_palette_new = [];
m_palette_len = -1;

m_tim_list = [];
m_current_tim = -1;

m_color_weights = { h : 48, s : 28, v : 24 };
m_color_minimum_uses = 0;

m_ignore_merge_battle_file = false;
m_ignore_merge_image_data = [];
m_ignore_merge_clut_colors = [];

m_tim = {
    id : 0,
    
    header : {
        tagver : 0x10,
        version : 0,
        bppclp : 9,
    },
    
    clut : {
        length : 12,
        cx : 0,
        cy : 0,
        cw : 0,
        ch : 0,
        colors : []
    },
    
    image : {
        length : 12,
        ix : 0,
        iy : 0,
        iw : 0,
        ih : 0,
        wmult : 2,
        data : []
    },
    
    palette : -1
}

ms_image_scale = 6;

