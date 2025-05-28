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
		
	    float height_center = texture2D( u_texture_obstacle, v_vTexcoord ).r;
		float height_up = texture2D( u_texture_obstacle, vec2(v_vTexcoord.x, v_vTexcoord.y - u_texel.y) ).r;
		float height_down = texture2D( u_texture_obstacle, vec2(v_vTexcoord.x, v_vTexcoord.y + u_texel.y) ).r;
		float height_left = texture2D( u_texture_obstacle, vec2(v_vTexcoord.x - u_texel.x, v_vTexcoord.y) ).r;
		float height_right = texture2D( u_texture_obstacle, vec2(v_vTexcoord.x + u_texel.x, v_vTexcoord.y) ).r;
		
		vec4 upColor = texture2D( gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y - u_texel.y) );
		vec4 downColor = texture2D( gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y + u_texel.y) );
		vec4 leftColor = texture2D( gm_BaseTexture, vec2(v_vTexcoord.x - u_texel.x, v_vTexcoord.y) );
		vec4 rightColor = texture2D( gm_BaseTexture, vec2(v_vTexcoord.x + u_texel.x, v_vTexcoord.y) );
		
		gl_FragColor.r = pow(2.0,abs(height_center-height_up))*clamp(upColor.r+upColor.g+upColor.b+upColor.a,0.0,1.0)/4294967295.0;
		gl_FragColor.g = pow(2.0,abs(height_center-height_down))*clamp(upColor.r+upColor.g+upColor.b+upColor.a,0.0,1.0)/4294967295.0;
		gl_FragColor.b = pow(2.0,abs(height_center-height_left))*clamp(upColor.r+upColor.g+upColor.b+upColor.a,0.0,1.0)/4294967295.0;
		gl_FragColor.a = pow(2.0,abs(height_center-height_right))*clamp(upColor.r+upColor.g+upColor.b+upColor.a,0.0,1.0)/4294967295.0;
	}
}
