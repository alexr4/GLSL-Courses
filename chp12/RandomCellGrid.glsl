#ifdef GL_ES
precision mediump float;
#endif
#define PI 3.14159265359

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;

/*
This function will return a random number between 0.0 and 1.0 at a specific coordinate xy (random with more variation)
*/
float random (vec2 st) {
    return fract(sin(dot(st.xy, vec2(10.9898,78.233)))*43758.5453123);
}


void main(){
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  vec2 colsrows = vec2(10.0, 10.0);

  //multiply the pixel coordinate with the colsrows vector t scale the space coordinate system from 0.0 to 1.0 to 0.0 to colsrows
  vec2 nst = st * colsrows;
  //get the fractional parts of the new space coordinates in order to get a repetited grid from 0.0 to 1.0
  vec2 fst = fract(nst);
  //get the nearest integer less than or equals to the new space coordinate to get the index i,j of the cell
  vec2 ist = floor(nst);

  //define and increment on the y axis by the time in order to get a animated random
  vec2 inc = vec2(0.0, floor(u_time * 4.0));
  float randPerCell = random(ist + inc); //get an random for each cell depending on their indice and increment
  //randPerCell = step(0.5, randPerCell); //try this in order get a nice bit pattern. The main idea is to check is the random is equal or great than a specific value to define if we draw the cell or not

  vec3 color = vec3(randPerCell);
  gl_FragColor = vec4(color, 1.0);
}
