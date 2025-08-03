shader_type canvas_item;

uniform vec2 scroll_offset = vec2(0.0, 0.0);
uniform float alpha_factor = 0.5;  // transparency (0.0 = fully transparent, 1.0 = opaque)

void fragment() {
    vec2 uv = UV + scroll_offset;
    vec4 tex_color = texture(TEXTURE, uv);

    // Multiply the texture alpha by alpha_factor
    tex_color.a *= alpha_factor;

    COLOR = tex_color;
}
