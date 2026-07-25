shader_type canvas_item;

uniform vec4 flash_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform float flash_strength : hint_range(0.0, 1.0) = 0.0;
uniform float border_size : hint_range(0.0, 0.5) = 0.08;

void fragment() {
	vec4 screen = texture(TEXTURE, UV);

	float edge = min(
		min(UV.x, 1.0 - UV.x),
		min(UV.y, 1.0 - UV.y)
	);

	float border = 1.0 - smoothstep(0.0, border_size, edge);

	vec3 color = mix(
		screen.rgb,
		flash_color.rgb,
		border * flash_strength
	);

	COLOR = vec4(color, screen.a);
}