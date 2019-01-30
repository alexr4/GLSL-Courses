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
uniform vec2 u_resolution; // size of the preview
uniform vec2 u_mouse; // cursor in normalized coordinates [0, 1]
uniform float u_time; // clock in seconds

/**
The main function is the principal function of the GLSL program. It's like the update or draw in processing, js and other
*/
void main(){
  float red = u_mouse.x;
  float green = u_mouse.y;
  float blue = 0.0;
  vec3 color = vec3(red, green, blue);


  //GLSL buit-in variables defining the color of the fragment
  //Colors are define as a Vector4 representing the RGBA channel
  gl_FragColor = vec4(color, 1.0);
}
