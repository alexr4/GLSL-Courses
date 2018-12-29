#ifdef GL_ES
precision mediump float;
#endif

void main(){
  float red = 1.0;
  float green = 0.5;
  float blue = 0.0;
  vec3 color = vec3(red, green, blue);
  gl_FragColor = vec4(color, 1.0);
}
