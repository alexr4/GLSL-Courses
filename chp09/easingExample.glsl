#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


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

vec2 scaleFrom(vec2 st, vec2 pos, vec2 scale){
  //move to center
  st -= pos;
  st = scale2d(scale) * st;
  //reset position
  st += pos;

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

void main(){
  vec2 st = gl_FragCoord.xy / u_resolution.xy;

  float normTime = getPingPongTimeLoop(0.5);
  float ioquad   = inoutquad(normTime);
  float ioexp    = inoutexp(normTime);

  float rect = 0.0;
  float size = 0.0;
  vec2 nst   = st;
  vec2 squaresize = vec2(0.15);

  //linear animation
  size  = 0.5 + normTime * 2.0;
  nst    = scaleFrom(st, vec2(0.25 - squaresize.x * 0.5, 0.5), vec2(size));
  rect  += rectangleSmooth(nst, vec2(0.25 - squaresize.x * 0.5, 0.5), squaresize, vec2(0.005));

  //inout quad
  size  = 0.5 + ioquad * 2.0;
  nst    = scaleFrom(st, vec2(0.5, 0.5), vec2(size));
  rect  += rectangleSmooth(nst, vec2(0.5, 0.5), squaresize, vec2(0.005));

  //inout exponential
  size  = 0.5 + ioexp * 2.0;
  nst    = scaleFrom(st, vec2(0.75 + squaresize.x * 0.5, 0.5), vec2(size));
  rect  += rectangleSmooth(nst, vec2(0.75 + squaresize.x * 0.5, 0.5), squaresize, vec2(0.005));

  vec3 color = vec3(rect);

  gl_FragColor = vec4(color, 1.0);
}
