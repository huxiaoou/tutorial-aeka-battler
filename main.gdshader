shader_type spatial;
//shader_type canvas_item;

uniform sampler2D tex_ground: filter_linear, repeat_enable;
uniform float tile_multiplier = 16.0;
uniform float border_width = 0.005;

void fragment() {
    vec4 sampled_color = texture(tex_ground, UV*tile_multiplier);
    float left = step(UV.x, border_width);
    float right = step(1.0 - border_width, UV.x);
    float top = step(UV.y, border_width);
    float bottom = step(1.0 - border_width, UV.y);
    
    float m = round(UV.x * 16.0);
    float d = abs(UV.x * 16.0 - m);
    
    
    // Combine all edges (if any are 1.0, the result is 1.0)
    float is_border = max(max(left, right), max(top, bottom));
    is_border = max(is_border, step(d, border_width));
    
    
    ALBEDO= mix(sampled_color.rgb, vec3(1.0), is_border);
}
