#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution; // size of the preview
uniform vec2 u_mouse; // cursor in normalized coordinates [0, 1]
uniform float u_time; // clock in seconds

void main(){
  float red = u_mouse.x;
  float green = u_mouse.y;
  float blue = 0.0;
  vec3 color = vec3(red, green, blue);
  gl_FragColor = vec4(color, 1.0);
}
