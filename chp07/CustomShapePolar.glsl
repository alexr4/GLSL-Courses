#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
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

void main(){
  vec2 st = gl_FragCoord.xy / u_resolution.xy;


  vec2 toCenter   = vec2(0.5) - st;
  float radius    = length(toCenter);
  float angle     = atan(toCenter.x, toCenter.y);

  float offset    = abs(sin(angle * 2.0 - PI * u_time ) * cos(angle * 4.0 + PI * u_time) * sin(u_time + angle * 8.0)) ;

  float newRadius     = offset * 0.15 + 0.25;
  float newSmoothness = offset * 0.01 + 0.005;
  float circ = circleSmooth(st, vec2(0.5), newRadius, newSmoothness);
  float distShadow = smoothstep(0.0, 0.5, radius);
  float shadow = mix(1.0, offset, distShadow);
  vec3 color = vec3(circ * shadow);
  gl_FragColor = vec4(color, 1.0);
}
