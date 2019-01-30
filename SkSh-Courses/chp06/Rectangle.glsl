#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

/*
Function for drawing a rectangle as float (1.0 if the pixel is inside the rectangle, 0.0 if it is outside)
st is the fragment coordinate to test, center is the center of the shape and thickness defines its width and height
*/
float rectangle(vec2 st, vec2 center, vec2 thickness){
  //the first step define if st.x is bewteen the center.x - thickness.x and center.x + thickness.x. The vertical edges
  float edgeX = step(center.x, st.x + thickness.x * 0.5) - step(center.x, st.x - thickness.x * 0.5);
  //the second step define if st.y is bewteen the center.y - thickness.y and center.y + thickness.y. The horizontal edges
  float edgeY = step(center.y, st.y + thickness.y * 0.5) - step(center.y, st.y - thickness.y * 0.5);
  return edgeX * edgeY;
}

/*
Function for drawing a smoothed rectangle as float (1.0 if the pixel is inside the rectangle, 0.0 if it is outside)
st is the fragment coordinate to test, center is the center of the shape, thickness defines its width and height and
smoothness define the smooth value for the blurry edge on x and y
*/
float rectangleSmooth(vec2 st, vec2 center, vec2 thickness, vec2 smoothness){
  float edgeX = smoothstep(center.x, center.x + smoothness.x, st.x + thickness.x * 0.5) - smoothstep(center.x - smoothness.x, center.x, st.x - thickness.x * 0.5);
  float edgeY = smoothstep(center.y, center.y + smoothness.y, st.y + thickness.y * 0.5) - smoothstep(center.y - smoothness.y, center.y, st.y - thickness.y * 0.5);
  return edgeX * edgeY;
}

void main(){
  vec2 st = gl_FragCoord.xy / u_resolution.xy;

  float rect        = rectangle(st, vec2(0.5), vec2(0.1, 0.25));
  float rectsmooth  = rectangleSmooth(st, vec2(0.5), vec2(0.5), vec2(0.025));

  vec3 color = vec3(rectsmooth);
  gl_FragColor = vec4(color, 1.0);
}
