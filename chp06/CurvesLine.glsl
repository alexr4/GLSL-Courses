#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

float line(float x, float edge, float thickness){
  return step(edge, x + thickness * 0.5) - step(edge, x - thickness * 0.5);
}

float lineSmooth(float x, float edge, float thickness, float smoothness){
  return smoothstep(edge, edge + smoothness, x + thickness * 0.5) - smoothstep(edge - smoothness, edge, x - thickness * 0.5);
}

void main(){
  vec2 st = gl_FragCoord.xy / u_resolution.xy;
  float thickness = 0.125;
  float sdf       = 0.5 + (st.x - st.y) * 0.5;
  float offset    = cos((st.x + st.y + u_time * 0.5) * 3.14159265359 * 4.0) * 0.025;

  float shape    = lineSmooth(sdf, 0.0 + offset, thickness, 0.005);
  shape         += lineSmooth(sdf, 0.25 + offset, thickness, 0.005);
  shape         += lineSmooth(sdf, 0.5 + offset, thickness, 0.005);
  shape         += lineSmooth(sdf, 0.75 + offset, thickness, 0.005);
  shape         += lineSmooth(sdf, 1.0 + offset, thickness, 0.005);

  vec3 color = vec3(shape);

  gl_FragColor = vec4(color, 1.0);
}
