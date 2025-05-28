//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float u_f32;

void main()
{
    gl_FragColor = vec4(u_f32, u_f32, u_f32, u_f32);
}
