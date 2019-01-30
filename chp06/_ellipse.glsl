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
