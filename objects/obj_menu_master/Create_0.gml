m_menu_locked = false;

m_processing = false;
m_processing_step = 1;
m_processing_cur = 0;
m_processing_max = 15;
m_processing_reduction_loop = 0;

m_import_tim = instance_create_depth(0, 0, 0, obj_button);
m_import_tim.m_text = "Import TIM"; 
m_import_tim.m_available = true;

m_export_png = instance_create_depth(128, 0, 0, obj_button);
m_export_png.m_text = "Export PNG";

m_import_png = instance_create_depth(256, 0, 0, obj_button);
m_import_png.m_text = "Import PNG";

m_export_tim = instance_create_depth(256+128, 0, 0, obj_button);
m_export_tim.m_text = "Export TIM";

m_confirm = instance_create_depth(256, 256, -1, obj_button);
m_confirm.m_text = "CONFIRM";
m_confirm.m_visible = false;

m_cancel = instance_create_depth(256+16+128, 256, -1, obj_button);
m_cancel.m_text = "CANCEL";
m_cancel.m_visible = false;

m_current_message = "Click Import TIM to load an MRDX2.tex or .tim file.";

m_warning_export_png_overwrite = false;

