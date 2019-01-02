#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
uniform vec2 u_resolution;
uniform float u_time;

float shape(vec2 st, int nbEdges, float size){
  vec2 toCenter = vec2(0.5) - st;
  //get angle of the pixel coordinate
  //atant will return a value between -PI and PI
  float angle   = atan(toCenter.y, toCenter.x) + PI;
  float radius  = (PI * 2.0) / float(nbEdges);

  //modulate the distance to define the shape
  float d = cos(floor(0.5 + angle/radius) * radius - angle) * length(toCenter);

  return 1.0 - step(0.5 * size, d);
}

float shapeSmooth(vec2 st, int nbEdges, float size, float smoothness){
  vec2 toCenter = vec2(0.5) - st;
  //get angle of the pixel coordinate
  //atant will return a value between -PI and PI
  float angle   = atan(toCenter.y, toCenter.x) + PI;
  float radius  = (PI * 2.0) / float(nbEdges);

  //modulate the distance to define the shape
  float d = cos(floor(0.5 + angle/radius) * radius - angle) * length(toCenter);

  return 1.0 - smoothstep(0.5 * size - smoothness * 0.5, 0.5 * size + smoothness * 0.5, d);
}

void main(){
  vec2 st = gl_FragCoord.xy / u_resolution.xy;

  float customshape = shapeSmooth(st, 9, 0.5, 0.01);
  vec3 color = vec3(customshape);
  gl_FragColor = vec4(color, 1.0);
}
