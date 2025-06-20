shader_type spatial;
render_mode blend_add, unshaded, cull_disabled;

uniform sampler2D flame_texture;
uniform sampler2D color_gradient;

void fragment() {
    vec2 uv = UV;

    // Animate the UV vertically
    vec2 animated_uv = vec2(uv.x, uv.y + TIME * 0.8);
    float flame_sample = texture(flame_texture, animated_uv).r;

    // Fade shape (oval from bottom center)
    float shape = 1.0 - sqrt(pow(uv.x - 0.5, 2.0) + pow(uv.y - 1.0, 2.0) * 0.2) * 2.0;
    float flame = flame_sample * shape;

    // Apply color gradient
    vec3 color = texture(color_gradient, vec2(flame, 0.0)).rgb * flame * 3.5;

    // Output final flame color and alpha
    ALBEDO = color;
    ALPHA = flame > 0.1 ? flame : 0.0;
}
