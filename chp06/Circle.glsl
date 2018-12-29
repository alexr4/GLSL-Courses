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

  float circ = circle(st, vec2(0.5), 0.35);
  float circsmooth = circleSmooth(st, vec2(0.5), 0.35, 0.05);
  //float ellipse = ellipseSmooth(st, vec2(0.5), 0.35, vec2(1.0, 0.5), 0.05);

  vec3 color = vec3(circsmooth);

  gl_FragColor = vec4(color, 1.0);
}
