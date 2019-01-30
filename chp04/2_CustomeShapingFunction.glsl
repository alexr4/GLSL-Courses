/**
This example show you how to create you own custom shaping function in order to get a custom behavior
*/

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

//This function will describe an in out quad curve from a normalized value
//It is an implementation of the inoutquad easing function from Robert Penner http://robertpenner.com/easing/
//You can find more here http://www.gizma.com/easing/
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

  //we create a simple mathematical condition using step in order to check if the x position is equals or greater than 0.5 (middle of the screen)
  float stepper   = step(0.5, st.x);
  //we get the fractional part of the time value (the numbers after the floating point) in order to get value from 0.0 to 1.0 only
  float value      = fract(u_time);
  //we used or custom shaping function in order to return an inout curve interpolation of our fractional time value
  float easedValue = inoutquad(fract(u_time));

  //we draw the fractional time of the left side (1.0 - stepper) and the inoutquad curve on the right side
  vec3 color = vec3(value) * (1.0 - stepper) + easedValue * stepper;
  gl_FragColor = vec4(color, 1.0);
}
