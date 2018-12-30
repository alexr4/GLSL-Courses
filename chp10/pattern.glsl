#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;

void main(){
  vec2 st = gl_FragCoord.xy/u_resolution.xy;

  //define a vector with the number of desired columns and rows for your pattern
  vec2 colsrows = vec2(2.0, 2.0);
  //multiply the pixel coordinate with the colsrows vector t scale the space coordinate system from 0.0 to 1.0 to 0.0 to colsrows
  vec2 nst = st * colsrows;
  //get the fractional parts of the new space coordinates in order to get a repetited grid from 0.0 to 1.0
  vec2 fst = fract(nst);
  //get the nearest integer less than or equals to the new space coordinate to get the index i,j of the cell
  vec2 ist = floor(nst);

  vec3 color = vec3(fst, 0.0);
  gl_FragColor = vec4(color, 1.0);
}
