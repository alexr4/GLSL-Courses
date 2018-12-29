#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;

void main(){
  vec2 st = gl_FragCoord.xy / u_resolution.xy;

  gl_FragColor = vec4(st, 0.0, 1.0);
}
