/**
this example show you how to use the indices of the pattern to modify the shape drawn on each cell.
It also show you how to use the mouse as an interactive input
*/

#ifdef GL_ES
precision mediump float;
#endif
#define PI 3.14159265359

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;

float rectangle(vec2 st, vec2 center, vec2 thickness){
  float edgeX = step(center.x, st.x + thickness.x * 0.5) - step(center.x, st.x - thickness.x * 0.5);
  float edgeY = step(center.y, st.y + thickness.y * 0.5) - step(center.y, st.y - thickness.y * 0.5);
  return edgeX * edgeY;
}

float rectangleSmooth(vec2 st, vec2 center, vec2 thickness, vec2 smoothness){
  float edgeX = smoothstep(center.x, center.x + smoothness.x, st.x + thickness.x * 0.5) - smoothstep(center.x - smoothness.x, center.x, st.x - thickness.x * 0.5);
  float edgeY = smoothstep(center.y, center.y + smoothness.y, st.y + thickness.y * 0.5) - smoothstep(center.y - smoothness.y, center.y, st.y - thickness.y * 0.5);
  return edgeX * edgeY;
}

float circle(vec2 st, vec2 center, float radius){
  float distFromCenter = length(center - st);
  return 1.0 - step(radius, distFromCenter);
}

float circleSmooth(vec2 st, vec2 center, float radius, float smoothness){
  float distFromCenter = length(center - st);
  return 1.0 - smoothstep(radius - smoothness * 0.5, radius + smoothness * 0.5, distFromCenter);
}


mat2 rotate2d(float angle){
  return mat2(cos(angle), -sin(angle),
              sin(angle),  cos(angle));
}

vec2 rotate(vec2 st, float angle){
  //move to center
  st -= vec2(0.5);
  st = rotate2d(angle) * st;
  //reset position
  st += vec2(0.5);

  return st;
}

mat2 scale2d(vec2 scale){
  return mat2(scale.x, 0.0,
              0.0    , scale.y);
}

vec2 scale(vec2 st, vec2 scale){
  //move to center
  st -= vec2(0.5);
  st = scale2d(scale) * st;
  //reset position
  st += vec2(0.5);

  return st;
}


void main(){
  vec2 st = gl_FragCoord.xy/u_resolution.xy;

  //define a vector with the number of desired columns and rows for your pattern
  vec2 colsrows = vec2(10.0, 10.0);
  //multiply the pixel coordinate with the colsrows vector t scale the space coordinate system from 0.0 to 1.0 to 0.0 to colsrows
  vec2 nst = st * colsrows;
  //get the fractional parts of the new space coordinates in order to get a repetited grid from 0.0 to 1.0
  vec2 fst = fract(nst);
  //get the nearest integer less than or equals to the new space coordinate to get the index i,j of the cell
  vec2 ist = floor(nst);

  //check if the cell index is even or odd
  float index = floor(ist.x + ist.y * (colsrows.x + 1.0)); //the index of the cell into the grid
  //The modulo of the index with 2.0 will return 0.0 if the index is even and 1.0 if the index is odd
  float modIndex = mod(index, 2.0);
  //Check if the index is even/odd
  float isOdd = step(1.0, modIndex);

  //normalize index and remap it to 1.0 → 0.0 → 1.0
  vec2 nist  = (ist / (colsrows - 1.0)) * 2.0 - 1.0;
  float dist = length(nist); //return the length of the vector nist, which is the distance from the origin (0.0, 0.0)
  dist = pow(dist, u_mouse.x * 10.0); // power the distance this the mouse input
  fst = scale(fst, vec2(1.0) + vec2(0.5 * dist));//scale the cell according the computed distance

  //compute shapes
  float circ = circleSmooth(fst, vec2(0.5), 0.45, 0.05);
  float rect = rectangleSmooth(fst, vec2(0.5), vec2(1.1), vec2(0.05));

  //draw shape (rectangle if odd and circle if even)
  vec3 color = vec3(rect) * isOdd + vec3(circ) * (1.0 - isOdd);
  gl_FragColor = vec4(color, 1.0);
}
