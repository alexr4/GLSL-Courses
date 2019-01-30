#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

float rectangleSDF(vec2 st, vec2 thickness){
  //remap st coordinate from 0.0 to 1.0 to -1.0, 1.0
  st = st * 2.0 - 1.0;
  float edgeX = abs(st.x / thickness.x);
  float edgeY = abs(st.y / thickness.y);
  return max(edgeX, edgeY);
}

float stroke(float x, float s, float w){
  float d = step(s, x + w * 0.5) - step(s, x - w * 0.5);
  return clamp(d, 0.0, 1.0);
}

float fill(float x, float size){
  return 1.0 - step(size, x);
}

void main(){
  vec2 st = gl_FragCoord.xy / u_resolution.xy;

    float rectsdf     = rectangleSDF(st, vec2(1.0));
    float rectStroke  = stroke(rectsdf, 0.75, 0.015);
    float rectFill    = fill(rectsdf, 0.25);

    float offset                  = cos((st.x + st.y + u_time * 0.25) * 3.14159265359 * 3.0);
    float amplitude               = 0.1;
    float rectsdfdeform           = rectangleSDF(st, vec2(1.0) + offset * amplitude);
    float rectsdfDeformStroke     = fill(rectsdfdeform, 0.55);
    float rectsdfDeformStrokeInv  = 1.0 - fill(rectsdfdeform, 0.45);
    //remap offset from -1.0 to 1.0 to 0.5 to 1.0
    float shadow                  = (offset * 0.25 + 0.75);
    float finalRectDeform         = (rectsdfDeformStroke * rectsdfDeformStrokeInv) * shadow;

  vec3 color = vec3(rectStroke + finalRectDeform  + rectFill);
  gl_FragColor = vec4(color, 1.0);
}
