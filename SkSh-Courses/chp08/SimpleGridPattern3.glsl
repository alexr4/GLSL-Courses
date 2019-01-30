/**
animated example using the index of the cell
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


void main(){
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  //rotate the fragment coordinates from the center
  st = rotate(st, PI * 0.15);
  //increment it by the time in order to get a "sliding/infinte translation" effect
  st.x += u_time * 0.25;

  //define a vector with the number of desired columns and rows for your pattern
  vec2 colsrows = vec2(5.0, 15.0);

  //The modulo of the index.y with 2.0 will return 0.0 if the index is even and 1.0 if the index is odd
  float modRow    = mod(st.y * colsrows.y, 2.0);
  //check is the index.y is odd or even is order to offset one row on two
  float offsetx   = step(1.0, modRow);
  //define the amplitude of the speed variation
  float amplitude = 0.5;
  //define the based offset for each row on two
  vec2 offsetMod  = vec2(offsetx * amplitude, 0.0);
  //define the speed offset for each row on two
  vec2 offsetTime = vec2(offsetx * u_time * 0.25, 0.0);
  st += offsetMod;
  st += offsetTime;

  //multiply the pixel coordinate with the colsrows vector t scale the space coordinate system from 0.0 to 1.0 to 0.0 to colsrows
  vec2 nst = st * colsrows;
  //get the fractional parts of the new space coordinates in order to get a repetited grid from 0.0 to 1.0
  vec2 fst = fract(nst);
  //get the nearest integer less than or equals to the new space coordinate to get the index i,j of the cell
  vec2 ist = floor(nst);

  float rect = rectangleSmooth(fst, vec2(0.5), vec2(0.95, 0.5), vec2(0.01));

  vec3 color = vec3(rect);
  gl_FragColor = vec4(color, 1.0);
}
