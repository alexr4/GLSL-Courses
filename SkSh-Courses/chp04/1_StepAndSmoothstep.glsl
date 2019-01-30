/*
Pre-processor macro defining the behavior of the GLSL program according to the GLSL version
Here we define, if the program run on a GL_ES environment (mainly used for web and mobile devices) we will use float value with medium precision
More precision (highp) will goes will more latency and low precision (lowp) will be faster but not precise
*/
#ifdef GL_ES
precision mediump float;
#endif

/*
uniform variables are the variables bounds to the shader from the CPU side (Javascript in our case)
They are set to read-only and cannot be modified by the shader because they need to be identical for each fragment of the images
u_time, u_resolution and u_mouse are uniform provided by the glsl-preview package. See the documentation of the package online for more informations
*/
uniform vec2 u_resolution;

/**
The main function is the principal function of the GLSL program. It's like the update or draw in processing, js and other
*/
void main(){
  /**
  GLSL provides us a built-in variable gl_FragCoord which represent the fragment coordinate in screen space
  GLSL color are normalized (from 0.0 to 1.0), in order to visualize and use the fragment position we need to normalized it
  The vector st will be our normalized fragment coordinate and is equals to the fragment position (in screen space) divide by the resolution
  */
  vec2 st = gl_FragCoord.xy / u_resolution.xy;

  //The following methods present various built-in function for mathematical operations
  //You can find it al here : https://www.khronos.org/registry/OpenGL-Refpages/gl4/index.php
  //This link will provide you only the main ones : http://www.shaderific.com/glsl-functions
  float value = st.x;
  //value = step(0.5, st.x); //return 1.0 if x > 0.5 else return 0.0
  //value = smoothstep(0.49,0.51, st.x); //return and interpolation of x from 0.25 → 0.5 to 0.0 → 1.0
  //value = pow(st.x, 10.0); // power x to 10.0
  //value = pow(st.x, 0.5); // power x to 0.5
  //value = mod(st.x, 0.25); // return x modulo 0.25
  //value = fract(st.x * 2.0); // return the fractional part of a number
  //value = sin(st.x * 3.14159265359 * 8.0); //return sin of x * PI * 8.0
  //value = ceil(sin(st.x * 3.14159265359 * 8.0)); //return nearest integer greater than or equals to x
  //value = floor(1.0 + sin(st.x * 3.14159265359 * 8.0)); //return nearest integer less than or equals to x
  //value = abs(sin(st.x * 3.14159265359 * 8.0)); //return absolute value of x

  vec3 color = vec3(value);
  gl_FragColor = vec4(color, 1.0);
}
