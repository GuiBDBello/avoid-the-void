shader_type spatial;

uniform float blur_amount: hint_range(0.0, 5.0) = 0.0;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

vec4 blur1(vec2 fragCoord, sampler2D tex) {
    
    vec4 color = vec4(0, 0, 0, 0); 
    
    // sum the pixels colors
    for(float x=-1.0; x <= 1.0; x++) {
        for(float y = -1.0; y <= 1.0; y++) {
            
            // get the pixel coordinates at offset (x, y)
            vec2 coordinate = fragCoord + vec2(x, y);
            
            // normalize the coordinates (range from 0 to 1)
            vec2 normalizedCoordinate = coordinate / SCREEN_PIXEL_SIZE.xy;
            
            // sum the color
            color += texture(tex, normalizedCoordinate);
        }
    }
    
    // divide the color by the number of colors you sumed up
    color /= 9.0;
    
    return color;
}

void fragment() {
	
	vec4 color = textureLod(SCREEN_TEXTURE, SCREEN_UV, blur_amount);
	ALBEDO = color.xyz;
}
