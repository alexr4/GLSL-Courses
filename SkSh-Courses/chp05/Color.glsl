#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

void main(){
  vec2 st = gl_FragCoord.xy / u_resolution.xy;
  //GLSL works with normalized color value from (0.0 to 1.0) where RGB 127 is normalized by doing 127.0/255.0
  vec3 red = vec3(1.0, 0.0, 0.0);
  vec3 green = vec3(0.0, 1.0, 0.0);
  vec3 blue = vec3(0.0, 0.0, 1.0);

  vec3 yellow  = vec3(red.x, green.y, 0.0);
  vec3 magenta = vec3(red.x, 0.0, blue.z);

  //The built-in function mix(a, b, offset) will return and linear interpolation between a and b along an normalized offset
  vec3 gradientOne = mix(yellow, magenta, st.x);

  float percent = abs(sin(st.x * 3.14159265359 * 4.0));
  vec3 gradientTwo = mix(green, blue, percent);

  float sinTime = abs(sin(u_time));
  vec3 finalgradient = mix(gradientOne, gradientTwo, sinTime);

  gl_FragColor = vec4(finalgradient, 1.0);
}
