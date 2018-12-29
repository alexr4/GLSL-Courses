#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


float rectangle(vec2 st, vec2 center, vec2 thickness){
  float edgeX = step(center.x, st.x + thickness.x * 0.5) - step(center.x, st.x - thickness.x * 0.5);
  float edgeY = step(center.y, st.y + thickness.y * 0.5) - step(center.y, st.y - thickness.y * 0.5);
  return edgeX * edgeY;
}

float rectangleSmooth(vec2 st, vec2 center, vec2 thickness, vec2 smoothness){
  float edgeX = smoothstep(center.x, center.x + smoothness.x, st.x + thickness.x * 0.5) - smoothstep(center.x - smoothness.x, center.x, st.x - thickness.x * 0.5);
  float edgeY = smoothstep(center.y, center.y + smoothness.y, st.y + thickness.y * 0.5) - smoothstep(center.y - smoothness.y, center.y, st.y - thickness.y * 0.5);
  return edgeX * edgeY;
}

mat2 rotate2d(float angle){
  return mat2(cos(angle), -sin(angle),
              sin(angle),  cos(angle));
}

vec2 rotate(vec2 st, float angle){
  //move to center
  st -= vec2(0.5);
  st = rotate2d(angle) * st;
  //reset position
  st += vec2(0.5);

  return st;
}

mat2 scale2d(vec2 scale){
  return mat2(scale.x, 0.0,
              0.0    , scale.y);
}

vec2 scale(vec2 st, vec2 scale){
  //move to center
  st -= vec2(0.5);
  st = scale2d(scale) * st;
  //reset position
  st += vec2(0.5);

  return st;
}

void main(){
  vec2 st = gl_FragCoord.xy / u_resolution.xy;

  //rotate
  st = rotate(st, u_time * 0.25);

  //scale
  float size = 1.0 + sin(u_time * 1.5) * 0.25;
  st = scale(st, vec2(size));

  float offset      = cos((st.x + st.y + size + u_time * 0.5) * 3.14159265359 * 3.0);
  float amplitude   = 0.1 * size * 0.75;

  float rectsmooth  = rectangleSmooth(st, vec2(0.5), vec2(0.5) + offset * amplitude, vec2(0.005) + offset * amplitude * 0.5);
  //remap offset from -1.0 to 1.0 to 0.5 to 1.0
  float shadow      = (offset * 0.25 + 0.75);
  vec3 color = vec3(rectsmooth * shadow);

  gl_FragColor = vec4(color, 1.0);
}
