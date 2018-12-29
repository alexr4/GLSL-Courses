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
  float angle   = atan(toCenter.x, toCenter.y) + PI;
  float radius  = (PI * 2.0) / float(nbEdges);

  //modulate the distance to define the shape
  float d = cos(floor(0.5 + angle/radius) * radius - angle) * length(toCenter);

  return 1.0 - step(0.5 * size, d);
}

float shapeSmooth(vec2 st, int nbEdges, float size, float smoothness){
  vec2 toCenter = vec2(0.5) - st;
  //get angle of the pixel coordinate
  //atant will return a value between -PI and PI
  float angle   = atan(toCenter.x, toCenter.y) + PI;
  float radius  = (PI * 2.0) / float(nbEdges);

  //modulate the distance to define the shape
  float d = cos(floor(0.5 + angle/radius) * radius - angle) * length(toCenter);

  return 1.0 - smoothstep(0.5 * size - smoothness * 0.5, 0.5 * size + smoothness * 0.5, d);
}

void main(){
  vec2 st = gl_FragCoord.xy / u_resolution.xy;

  float dist       = length(vec2(0.5) - st);
  float offset     = cos((dist + u_time * 0.5) * 3.14159265359 * 4.0);
  float amplitude  = 0.05;

  float cs0 = shapeSmooth(st, 9, 0.5  + offset * amplitude, 0.005);
  float cs1 = shapeSmooth(st, 3, 0.48 + offset * amplitude, 0.005);
  float cs2 = shapeSmooth(st, 3, 0.45 + offset * amplitude, 0.005);
  float cs3 = shapeSmooth(st, 3, 0.435+ offset * amplitude, 0.005);
  float cs4 = shapeSmooth(st, 6, 0.4  + offset * amplitude, 0.005);
  float cs5 = shapeSmooth(st, 6, 0.38 + offset * amplitude, 0.005);
  float cs6 = shapeSmooth(st, 8, 0.3  + offset * amplitude, 0.005);
  float cs7 = shapeSmooth(st, 8, 0.2  + offset * amplitude, 0.005);
  float cs8 = shapeSmooth(st, 6, 0.1  + offset * amplitude, 0.005);

  float cs01 = cs0 * (1.0 - cs1);
  float cs23 = cs2 * (1.0 - cs3);
  float cs45 = cs4 * (1.0 - cs5);
  float cs67 = cs6 * (1.0 - cs7);
  vec3 color = vec3(cs01 + cs23 + cs45 + cs67 + cs8);
  gl_FragColor = vec4(color, 1.0);
}
