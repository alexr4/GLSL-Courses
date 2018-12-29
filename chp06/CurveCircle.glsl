#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

float circle(vec2 st, vec2 center, float radius){
  float distFromCenter = length(center - st);
  return 1.0 - step(radius, distFromCenter);
}

float circleSmooth(vec2 st, vec2 center, float radius, float smoothness){
  float distFromCenter = length(center - st);
  return 1.0 - smoothstep(radius - smoothness * 0.5, radius + smoothness * 0.5, distFromCenter);
}

float ellipse(vec2 st, vec2 center, float radius, vec2 aspectRatio){
  //first we map the st cordinate from 0.0 to 1.0 to -1.0 to 1.0
  st = st * 2.0 - 1.0;
  //we divide the coordinate by the ellipse aspect ratio to get the redesired radius on x and y
  vec2 nst = st / aspectRatio;
  //we remap the new coordinate from 0.0 to 1.0
  nst = nst * 0.5 + 0.5;
  float distFromCenter = length(center - nst);
  return 1.0 - step(radius, distFromCenter);
}

float ellipseSmooth(vec2 st, vec2 center, float radius, vec2 aspectRatio, float smoothness){
  //first we map the st cordinate from 0.0 to 1.0 to -1.0 to 1.0
  st = st * 2.0 - 1.0;
  //we divide the coordinate by the ellipse aspect ratio to get the redesired radius on x and y
  vec2 nst = st / aspectRatio;
  //we remap the new coordinate from 0.0 to 1.0
  nst = nst * 0.5 + 0.5;
  float distFromCenter = length(center - nst);
  return 1.0 - smoothstep(radius - smoothness * 0.5, radius + smoothness * 0.5, distFromCenter);
}


void main(){
  vec2 st = gl_FragCoord.xy / u_resolution.xy;

  float offset      = cos((st.x + st.y + u_time * 0.25) * 3.14159265359 * 4.0);
  float amplitude   = 0.015;
  float circsmooth = circleSmooth(st, vec2(0.5), 0.35 + offset * amplitude, 0.015 + offset * amplitude * 0.5);
  //remap offset from -1.0 to 1.0 to 0.5 to 1.0
  float shadow      = (offset * 0.25 + 0.75);
  vec3 color = vec3(circsmooth * shadow);

  gl_FragColor = vec4(color, 1.0);
}
