/**
animated example using the distance of the cell from the center
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

/**
this function will return a time loop between 0.0 and the max time
*/
float getTimeLoop(float maxTime){
  float modTime    = mod(u_time, maxTime);
  float normTime   = modTime / maxTime;
  return normTime;
}

/**
This function will return a oscillating time value from 0 to 1.0 to 0.0
during a specific max time
*/
float getPingPongTimeLoop(float maxTime){
  float normTime = getTimeLoop(maxTime);
  return abs(normTime * 2.0 - 1.0);
}

void main(){
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  float pptime = getPingPongTimeLoop(4.0);

  //define a vector with the number of desired columns and rows for your pattern
  vec2 colsrows = vec2(5.0, 5.0);
  //multiply the pixel coordinate with the colsrows vector t scale the space coordinate system from 0.0 to 1.0 to 0.0 to colsrows
  vec2 nst = st * colsrows;
  //get the fractional parts of the new space coordinates in order to get a repetited grid from 0.0 to 1.0
  vec2 fst = fract(nst);
  //get the nearest integer less than or equals to the new space coordinate to get the index i,j of the cell
  vec2 ist = floor(nst);

  //normalize index and remap it to 1.0 → 0.0 → 1.0
  vec2 nist  = abs(ist / (colsrows - 1.0)) * 2.0 - 1.0;
  float dist = length(nist) + 0.5; // get the distance from origin (0.0)

  //create a new cell fragment coordinate using a rotation along distance and time
  vec2 s0fst = rotate(fst, (PI * dist) * pptime);
  //scale it along distance and time
  s0fst = scale(s0fst, pptime * vec2(4.0 * dist));
  //draw the first rectangle
  float rect0 = rectangleSmooth(s0fst, vec2(0.5), vec2(1.0), vec2(0.01));


  //create a new cell fragment coordinate using a rotation along distance and time
  vec2 s1fst = rotate(fst, (-PI * dist) * pptime);
  //scale it along distance and time
  s1fst = scale(s1fst, pptime * vec2(4.0 * dist));
  //draw the second rectangle
  float rect1 = rectangleSmooth(s1fst, vec2(0.5), vec2(1.0) * (1.0 - pptime), vec2(0.01));

  //draw the first rectangle - the second one
  vec3 color = vec3(rect0 - rect1);
  gl_FragColor = vec4(color, 1.0);
}
