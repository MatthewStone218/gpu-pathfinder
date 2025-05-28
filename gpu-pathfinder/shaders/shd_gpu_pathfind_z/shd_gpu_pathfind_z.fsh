//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec2 u_texel;
uniform sampler2D u_texture_obstacle;
uniform int u_passthrough;

void main()
{
	if(u_passthrough == 1){
		gl_FragColor = texture2D( gm_BaseTexture, v_vTexcoord );
	} else {
		vec4 baseColor = texture2D( gm_BaseTexture, v_vTexcoord );
	    vec4 height_center = texture2D( u_texture_obstacle, v_vTexcoord ).r;
		
		vec4 height_up = texture2D( gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y - u_texel.y) ).r;
		vec4 height_down = texture2D( gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y + u_texel.y) ).r;
		vec4 height_left = texture2D( gm_BaseTexture, vec2(v_vTexcoord.x - u_texel.x, v_vTexcoord.y) ).r;
		vec4 height_right = texture2D( gm_BaseTexture, vec2(v_vTexcoord.x + u_texel.x, v_vTexcoord.y) ).r;
		
		vec4 upColor = texture2D( gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y - u_texel.y) );
		vec4 downColor = texture2D( gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y + u_texel.y) );
		vec4 leftColor = texture2D( gm_BaseTexture, vec2(v_vTexcoord.x - u_texel.x, v_vTexcoord.y) );
		vec4 rightColor = texture2D( gm_BaseTexture, vec2(v_vTexcoord.x + u_texel.x, v_vTexcoord.y) );
		
		gl_FragColor = baseColor;
	
		gl_FragColor.r = 0.0;
		gl_FragColor.r = pow(2.0,_diff-2.0) ^ 0xFFFFFFFF;
	}
}
