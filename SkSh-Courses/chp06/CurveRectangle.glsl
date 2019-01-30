/**
This example show you how to deform the fragment coordinate in order to draw a simple oscillating shape
*/

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

  //offset and amplitude define the osccilation of the shape. It is a cosine wave
  float offset      = cos((st.x + st.y + u_time * 0.25) * 3.14159265359 * 3.0); //cosine wave
  float amplitude   = 0.05;//amplitude (height) of the wave

  //the main idea in order to deform the shape is to use the cosine wave as an increment of the thickness and the smoothness
  //This will return an oscillating shape where thickness and smoothness change along the wave
  float rectsmooth  = rectangleSmooth(st, vec2(0.5), vec2(0.5) + offset * amplitude, vec2(0.005) + offset * amplitude * 0.5);
  //remap offset from -1.0 to 1.0 to 0.5 to 1.0 in order to simulate a shadow
  float shadow      = (offset * 0.25 + 0.75);
  vec3 color = vec3(rectsmooth * shadow);
  gl_FragColor = vec4(color, 1.0);
}
