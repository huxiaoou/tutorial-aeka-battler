shader_type spatial;
//shader_type canvas_item;

uniform sampler2D tex_ground: filter_linear, repeat_enable;
uniform float tile_multiplier = 16.0;
uniform float border_width = 0.005;

float is_inner_border(float x, float multiplier, float width)
{
    float z = x * multiplier;
    float d = abs(z - round(z));
    return step(d, width);
}

void fragment() {
    vec4 sampled_color = texture(tex_ground, UV*tile_multiplier);
    float left = step(UV.x, border_width);
    float right = step(1.0 - border_width, UV.x);
    float top = step(UV.y, border_width);
    float bottom = step(1.0 - border_width, UV.y);
    float is_border = max(max(left, right), max(top, bottom));
    
    float x_inner_border = is_inner_border(UV.x, tile_multiplier, border_width);
    float y_inner_border = is_inner_border(UV.y, tile_multiplier, border_width);
    is_border = max(is_border, max(x_inner_border, y_inner_border));
    
    ALBEDO= mix(sampled_color.rgb, vec3(0.0, 0.0, 0.2), is_border);
}
