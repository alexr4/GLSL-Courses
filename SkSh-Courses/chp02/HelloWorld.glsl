/*
Pre-processor macro defining the behavior of the GLSL program according to the GLSL version
Here we define, if the program run on a GL_ES environment (mainly used for web and mobile devices) we will use float value with medium precision
More precision (highp) will goes will more latency and low precision (lowp) will be faster but not precise
*/
#ifdef GL_ES
precision mediump float;
#endif

/**
The main function is the principal function of the GLSL program. It's like the update or draw in processing, js and other
*/
void main(){
  //define float for each color channel (notice that colors are normalized)
  float red = 1.0;
  float green = 0.5;
  float blue = 0.0;

  //You can assign it in a vector of 3 dimension for better use
  vec3 color = vec3(red, green, blue);

  /* you can refere to each component of a vector by using
  float x = color.x;  float y = color.y,  float z = color.z;
  or
  vec2 rg = color.xy;
  */

  //GLSL buit-in variables defining the color of the fragment
  //Colors are define as a Vector4 representing the RGBA channel
  gl_FragColor = vec4(color, 1.0);


  /**
  Notes on vector usage :
  On GLSL you can write
  vec3 color = vec3(0.0); which is equals to vec3 color = vec3(0.0, 0.0, 0.0);
  vec4 rgba = vec4(vec3(0.0), 1.0); which is equals to vec4 rgba = vec4(0.0, 0.0, 0.0, 1.0) or vec4 rgba = vec4(color, 1.0)  which is equals to vec4 rgba = vec4(color.xyz, 1.0)

  Notes on vector component
  color.x = color.r;
  color.y = color.g;
  color.z = color.b;
  color.w = color.a;
  */
}
