shader_type spatial;

uniform sampler2D albedo_texture : source_color, filter_nearest;

void vertex() {
    float snap_value = 1.0 / 100.0;
    vec4 clip_pos = PROJECTION_MATRIX * MODELVIEW_MATRIX * vec4(VERTEX, 1.0);
    vec3 ndc_pos = clip_pos.xyz / clip_pos.w;
    ndc_pos.xy = floor(ndc_pos.xy / snap_value + 0.5) * snap_value;
    clip_pos.xyz = ndc_pos * clip_pos.w;
    POSITION = clip_pos;
}

void fragment() {

    vec4 tex_color = texture(albedo_texture, UV);
    ALBEDO = tex_color.rgb;
    //ALPHA = tex_color.a;
}