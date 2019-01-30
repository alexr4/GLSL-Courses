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
uniform vec2 u_mouse;

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

  //GLSL buit-in variables defining the color of the fragment
  //Colors are define as a Vector4 representing the RGBA channel
  gl_FragColor = vec4(st, 0.0, 1.0);
}
