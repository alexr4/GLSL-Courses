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
  //The main idea behind circle is to compute the distance between the fragment coordinate and the center of the circle. If it is beyond the radius then the fragment is outisde the circleSmooth
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

  float circ = circle(st, vec2(0.5), 0.35);
  float circsmooth = circleSmooth(st, vec2(0.5), 0.35, 0.05);

  vec3 color = vec3(circsmooth);

  gl_FragColor = vec4(color, 1.0);
}
