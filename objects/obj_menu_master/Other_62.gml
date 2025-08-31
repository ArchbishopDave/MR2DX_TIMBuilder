
if ( ds_map_exists(async_load, "result") ) {
    var result = json_decode( async_load[?"result"] );
    if ( ds_map_exists(result, "tag_name") && result[?"tag_name"] != "v1.1.0" ) {
        md_message_version = $"A new release, {result[?"tag_name"]} is available from https://github.com/ArchbishopDave/MR2DX_TIMBuilder/releases\n{result[?"body"]}";
    }
    ds_map_destroy(result);
 }