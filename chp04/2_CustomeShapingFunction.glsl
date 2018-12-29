#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

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

void main(){
  vec2 st = gl_FragCoord.xy / u_resolution.xy;

  float stepper   = step(0.5, st.x);
  float value      = fract(u_time);
  float easedValue = inoutquad(fract(u_time));

  vec3 color = vec3(value) * (1.0 - stepper) + easedValue * stepper;
  gl_FragColor = vec4(color, 1.0);
}
