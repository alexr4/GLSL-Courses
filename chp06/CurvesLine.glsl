/**
This example show you how to deform the fragment coordinate in order to draw a simple oscillating shape
*/

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

  float thickness = 0.125; //define the thickness of the line
  float sdf       = 0.5 + (st.x - st.y) * 0.5; // define the position of the line (diagonal)
  //offset and amplitude define the osccilation of the shape. It is a cosine wave
  float offset    = cos((st.x + st.y + u_time * 0.5) * 3.14159265359 * 4.0) * 0.025;

  // draw multiple sahpe along the diagonal axis
  float shape    = lineSmooth(sdf, 0.0 + offset, thickness, 0.005);
  shape         += lineSmooth(sdf, 0.25 + offset, thickness, 0.005);
  shape         += lineSmooth(sdf, 0.5 + offset, thickness, 0.005);
  shape         += lineSmooth(sdf, 0.75 + offset, thickness, 0.005);
  shape         += lineSmooth(sdf, 1.0 + offset, thickness, 0.005);

  vec3 color = vec3(shape);

  gl_FragColor = vec4(color, 1.0);
}
