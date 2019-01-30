#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;


/*
Function for drawing a line as float (1.0 if the pixel is inside the line, 0.0 if it is outside)
st is the fragment coordinate to test, edge is the position of the line and thickness defines its thickness below and above the edge
*/
float line(float x, float edge, float thickness){
  return step(edge, x + thickness * 0.5) - step(edge, x - thickness * 0.5);
}

/*
Function for drawing a smoothed line as float (1.0 if the pixel is inside the line, 0.0 if it is outside)
st is the fragment coordinate to test, edge is the position of the line, thickness defines its thickness below and above the edge
smoothness define the smooth value for the blurry edge
*/
float lineSmooth(float x, float edge, float thickness, float smoothness){
  return smoothstep(edge, edge + smoothness, x + thickness * 0.5) - smoothstep(edge - smoothness, edge, x - thickness * 0.5);
}

void main(){
  vec2 st = gl_FragCoord.xy / u_resolution.xy;
  float thickness = 0.025;

  //compute line on x and on y to get horizontal and vertical lines
  float shapeVertical = line(st.x, 0.5, thickness);
  float shapeHorizontal   = line(st.y, 0.5, thickness);
  //here st.x + st.y will give a result from 0.0 to 2.0 so we will remap it into a range from 0.0 to 1.0
  float sdf             = (st.x + st.y) * 0.5;
  float shapeDiagRight  = lineSmooth(sdf, 0.5, thickness, 0.015);
  //here st.x - st.y will give a result from -1.0 to 1.0 so we will remap it into a range from 0.0 to 1.0
        sdf             = 0.5 + (st.x - st.y) * 0.5;
  float shapeDiagLeft   = lineSmooth(sdf, 0.5, thickness, 0.015);

  vec3 color = vec3(shapeHorizontal + shapeVertical + shapeDiagRight + shapeDiagLeft);

  gl_FragColor = vec4(color, 1.0);
}
