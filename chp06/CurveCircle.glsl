/**
This example show you how to deform the fragment coordinate in order to draw a simple oscillating shape
*/

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

/*
Function for drawing a circle as float (1.0 if the pixel is inside the circle, 0.0 if it is outside)
st is the fragment coordinate to test, center is the center of the shape and radius the size of the circle (radius)
*/
float circle(vec2 st, vec2 center, float radius){
  float distFromCenter = distance(center, st);
  return 1.0 - step(radius, distFromCenter);
}

/*
Function for drawing a smoothed circle as float (1.0 if the pixel is inside the circle, 0.0 if it is outside)
st is the fragment coordinate to test, center is the center of the shape and radius the size of the circle (radius)
smoothness  define the blurryness of the shape
*/
float circleSmooth(vec2 st, vec2 center, float radius, float smoothness){
  float distFromCenter = distance(center, st);
  return 1.0 - smoothstep(radius - smoothness * 0.5, radius + smoothness * 0.5, distFromCenter);
}


void main(){
  vec2 st = gl_FragCoord.xy / u_resolution.xy;

  //offset and amplitude define the osccilation of the shape. It is a cosine wave
  float offset      = cos((st.x + st.y + u_time * 0.25) * 3.14159265359 * 4.0); //cosine wave
  float amplitude   = 0.015;//amplitude (height) of the wave

  //the main idea in order to deform the shape is to use the cosine wave as an increment of the radius and the smoothness
  //This will return an oscillating shape where radius and smothness change along the wave
  float circsmooth = circleSmooth(st, vec2(0.5), 0.35 + offset * amplitude, 0.015 + offset * amplitude * 0.5);
  //remap offset from -1.0 to 1.0 to 0.5 to 1.0 in order to simulate a shadow
  float shadow      = (offset * 0.25 + 0.75);
  vec3 color = vec3(circsmooth * shadow);

  gl_FragColor = vec4(color, 1.0);
}
