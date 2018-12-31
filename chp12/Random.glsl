#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;

float randSim(float x, float inc){
  return fract(sin(x) * inc);
}

float random(float x){
  return fract(sin(x) * 43758.5453123);
}

float random (vec2 st) {
    return fract(sin(dot(st.xy, vec2(10.9898,78.233)))*43758.5453123);
}

void main(){
  vec2 st = gl_FragCoord.xy/u_resolution.xy;

  float simRand = randSim(st.x * 3.14, 10000.0);
  float randNum = random(st.x * 3.14);
  vec2 nst = u_time * st;
  float grain = random(st);
  vec3 color = vec3(grain);
  gl_FragColor = vec4(color, 1.0);
}
