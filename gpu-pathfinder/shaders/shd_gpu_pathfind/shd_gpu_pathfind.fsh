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
	    vec4 obstacleColor = texture2D( u_texture_obstacle, v_vTexcoord );
	
		if(obstacleColor.a == 1.0){
			gl_FragColor = vec4(0.0,0.0,0.0,0.0);
		} else {
		    vec4 baseColor = texture2D( gm_BaseTexture, v_vTexcoord );
	
		    vec4 upColor = texture2D( gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y - u_texel.y) );
		    vec4 downColor = texture2D( gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y + u_texel.y) );
		    vec4 leftColor = texture2D( gm_BaseTexture, vec2(v_vTexcoord.x - u_texel.x, v_vTexcoord.y) );
		    vec4 rightColor = texture2D( gm_BaseTexture, vec2(v_vTexcoord.x + u_texel.x, v_vTexcoord.y) );
	
			gl_FragColor = baseColor;
	
			gl_FragColor.r += upColor.r+upColor.g+upColor.b+upColor.a;
			gl_FragColor.r = clamp(gl_FragColor.r,0.0,1.0);
			gl_FragColor.r -= gl_FragColor.g+gl_FragColor.b+gl_FragColor.a;
			gl_FragColor.r = clamp(gl_FragColor.r,0.0,1.0);
	
			gl_FragColor.g += downColor.r+downColor.g+downColor.b+downColor.a;
			gl_FragColor.g = clamp(gl_FragColor.g,0.0,1.0);
			gl_FragColor.g -= gl_FragColor.r+gl_FragColor.b+gl_FragColor.a;
			gl_FragColor.g = clamp(gl_FragColor.g,0.0,1.0);
	
			gl_FragColor.b += leftColor.r+leftColor.g+leftColor.b+leftColor.a;
			gl_FragColor.b = clamp(gl_FragColor.b,0.0,1.0);
			gl_FragColor.b -= gl_FragColor.r+gl_FragColor.g+gl_FragColor.a;
			gl_FragColor.b = clamp(gl_FragColor.b,0.0,1.0);
	
			gl_FragColor.a += rightColor.r+rightColor.g+rightColor.b+rightColor.a;
			gl_FragColor.a = clamp(gl_FragColor.a,0.0,1.0);
			gl_FragColor.a -= gl_FragColor.r+gl_FragColor.g+gl_FragColor.b;
			gl_FragColor.a = clamp(gl_FragColor.a,0.0,1.0);
		}
	}
}
