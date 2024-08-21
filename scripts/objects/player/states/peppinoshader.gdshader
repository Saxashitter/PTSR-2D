shader_type canvas_item;

uniform float epsilon = 0.0001;
uniform vec4 origin_1: source_color;
uniform vec4 new_color_1: source_color;


void fragment() {
	vec4 current_pixel = texture(TEXTURE, UV);
	if (length(current_pixel - origin_1) < epsilon)
		COLOR = (new_color_1 );
	else
		COLOR = current_pixel;
}