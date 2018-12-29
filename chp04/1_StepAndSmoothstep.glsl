#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;

void main(){
  vec2 st = gl_FragCoord.xy / u_resolution.xy;

  float value = pow(st.x, 10.0); // power x to 10
  //float value = pow(st.x, 0.5); // power x to 0.5
  //float value = mod(st.x, 0.25); // return x modulo 0.25
  //float value = fract(st.x * 2.0); // return the fractional part of a number
  //float value = sin(st.x * 3.14159265359 * 8.0); //return sin of x * PI * 8.0
  //float value = ceil(sin(st.x * 3.14159265359 * 8.0)); //return nearest integer greater than or equals to x
  //float value = floor(1.0 + sin(st.x * 3.14159265359 * 8.0)); //return nearest integer less than or equals to x
  //float value = abs(sin(st.x * 3.14159265359 * 8.0)); //return absolute value of x
  //float value = step(0.5, st.x); //return 1.0 if x > 0.5 else return 0.0
  //float value = smoothstep(0.25,0.5, st.x); //return and interpolation of x from 0.25 → 0.5 to 0.0 → 1.0

  vec3 color = vec3(value);
  gl_FragColor = vec4(color, 1.0);
}
