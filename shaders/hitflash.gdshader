shader_type canvas_item;

uniform vec4 flash_color : source_color;
uniform float progress;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	color.rgb = mix(color, flash_color, progress).rgb;
	COLOR = color;
}
