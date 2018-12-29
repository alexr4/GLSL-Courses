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
  float thickness = 0.025;

  float shapeHorizontal = line(st.x, 0.5, thickness);
  float shapeVertical   = line(st.y, 0.5, thickness);
  //here st.x + st.y will give a result from 0.0 to 2.0 so we will remap it into a range from 0.0 to 1.0
  float sdf             = (st.x + st.y) * 0.5;
  float shapeDiagRight  = lineSmooth(sdf, 0.5, thickness, 0.015);
  //here st.x - st.y will give a result from -1.0 to 1.0 so we will remap it into a range from 0.0 to 1.0
        sdf             = 0.5 + (st.x - st.y) * 0.5;
  float shapeDiagLeft   = lineSmooth(sdf, 0.5, thickness, 0.015);

  vec3 color = vec3(shapeHorizontal + shapeVertical + shapeDiagRight + shapeDiagLeft);

  gl_FragColor = vec4(color, 1.0);
}
