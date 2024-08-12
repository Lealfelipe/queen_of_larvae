shader_type canvas_item;

uniform float alpha:hint_range(0.0, 1.0, 0.1) = 1;
uniform vec4 flash_color:source_color = vec4(1);

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	color.rgb = mix(color.rgb,flash_color.rgb,alpha);
	COLOR = color;
}
