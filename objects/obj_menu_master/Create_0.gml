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

m_button_cmode = instance_create_depth(512, 0, 0, obj_button);
m_button_cmode.m_text = "Creator Mode";
m_button_cmode.m_available = true;

md_message_current = "Click Import TIM to load an MR2DX.tex or .tim file.\nClick Creator Mode to use the expedited TIM creation process.";
md_message_processing = "";
md_message_version = "";

m_warning_export_png_overwrite = false;



m_http_request = http_get("https://api.github.com/repos/ArchbishopDave/MR2DX_TIMBuilder/releases/latest");

