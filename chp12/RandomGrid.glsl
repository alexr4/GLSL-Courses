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

float inoutexp(float value){
  float nvalue = value * 2.0;
  float inc = 1.0;
  float eased = 0.0;
  float stepper = step(1.0, value);
  eased += (0.5 * pow(2.0, 10.0 * (nvalue - 1.0))) * (1.0 - stepper);
  value--;
  eased += (0.5 * (-pow(2.0, -10.0 * (nvalue - 1.0)) + 2.0)) * stepper;

  return (value == 0.0 || value == 1.0) ? value : clamp(eased, 0.0, 1.0);
}

float inoutquad(float value){
    value *= 2.0;
    float inc = 1.0;
    float eased = 0.0;
    float stepper = step(1.0, value);
    eased += (0.5 * value * value) * (1.0 - stepper);
    value--;
    eased += (-0.5 * (value * (value - 2.0) - 1.0)) * stepper;
    return clamp(eased, 0.0, 1.0);
}

float getTimeLoop(float maxTime){
  float modTime    = mod(u_time, maxTime);
  float normTime   = modTime / maxTime;
  return normTime;
}

float getPingPongTimeLoop(float maxTime){
  float normTime = getTimeLoop(maxTime);
  return abs(normTime * 2.0 - 1.0);
}

float random (vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233)))*43758.5453123);
}

void main(){
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  st = rotate(st, PI * 0.25);
  //define a vector with the number of desired columns and rows for your pattern
  vec2 colsrows = vec2(5.0, 25.0);

  vec2  randPerRow       = vec2(floor(st.y * colsrows.y));
  float randomOffset     = random(randPerRow);
  float randomSpeed      = randomOffset * 2.0 + 0.5 ;
  st.x += randomOffset + u_time * randomSpeed;


  //multiply the pixel coordinate with the colsrows vector t scale the space coordinate system from 0.0 to 1.0 to 0.0 to colsrows
  vec2 nst = st * colsrows;
  //get the fractional parts of the new space coordinates in order to get a repetited grid from 0.0 to 1.0
  vec2 fst = fract(nst);
  //get the nearest integer less than or equals to the new space coordinate to get the index i,j of the cell
  vec2 ist = floor(nst);

  float randPerCell = random(ist);
  float isDrawn     = step(0.5, randPerCell);
  float randwidth   = randPerCell * 0.5 + 0.25;
  float randheight  = random(ist.yx) * 0.5 + 0.25;
  float rect        = rectangleSmooth(fst, vec2(0.5), vec2(randwidth, randheight), vec2(0.01));

  vec3 color = vec3(rect * isDrawn);
  gl_FragColor = vec4(color, 1.0);
}
