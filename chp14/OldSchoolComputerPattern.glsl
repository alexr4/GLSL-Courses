#ifdef GL_ES
precision mediump float;
#endif
#define PI 3.14159265359

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;

float circleSDF(vec2 st){
  return length(st - 0.5) * 2.0;
}

float rectangleSDF(vec2 st, vec2 thickness){
  //remap st coordinate from 0.0 to 1.0 to -1.0, 1.0
  st = st * 2.0 - 1.0;
  float edgeX = abs(st.x / thickness.x);
  float edgeY = abs(st.y / thickness.y);
  return max(edgeX, edgeY);
}

float lineSmooth(float x, float edge, float thickness, float smoothness){
  return smoothstep(edge, edge + smoothness, x + thickness * 0.5) - smoothstep(edge - smoothness, edge, x - thickness * 0.5);
}

float stroke(float x, float size, float thickness, float smoothness){
  float d = smoothstep(size - thickness * 0.5 - smoothness * 0.5, size - thickness * 0.5 + smoothness * 0.5, x) -
            smoothstep(size + thickness * 0.5 - smoothness * 0.5, size + thickness * 0.5 + smoothness * 0.5, x);
  return clamp(d, 0.0, 1.0);
}

float fill(float x, float size, float smoothness){
  return 1.0 - smoothstep(size - smoothness * 0.5, size + smoothness * 0.5, x);
}

//  Iñigo Quiles : https://www.shadertoy.com/view/MsS3Wc
vec3 hsb2rgb(vec3 c){
    vec3 rgb = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),
                             6.0)-3.0)-1.0,
                     0.0,
                     1.0 );
    rgb = rgb*rgb*(3.0-2.0*rgb);
    return c.z * mix(vec3(1.0), rgb, c.y);
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

float inoutexp(float value){
  float nvalue = value * 2.0;
  float inc = 1.0;
  float eased = 0.0;
  float stepper = step(1.0, value);
  eased += (0.5 * pow(2.0, 10.0 * (nvalue - 1.0))) * (1.0 - stepper);
  value--;
  eased += (0.5 * (-pow(2.0, -10.0 * (nvalue - 1.0)) + 2.0)) * stepper;

  return (value == 0.0 || value == 1.0) ? value : clamp(eased, 0.0, 1.0);
}

float inoutquad(float value){
    value *= 2.0;
    float inc = 1.0;
    float eased = 0.0;
    float stepper = step(1.0, value);
    eased += (0.5 * value * value) * (1.0 - stepper);
    value--;
    eased += (-0.5 * (value * (value - 2.0) - 1.0)) * stepper;
    return clamp(eased, 0.0, 1.0);
}

float getTimeLoop(float maxTime){
  float modTime    = mod(u_time, maxTime);
  float normTime   = modTime / maxTime;
  return normTime;
}

float getPingPongTimeLoop(float maxTime){
  float normTime = getTimeLoop(maxTime);
  return abs(normTime * 2.0 - 1.0);
}

float random (vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233)))*43758.5453123);
}

//noise from Morgan McGuire
//https://www.shadertoy.com/view/4dS3Wd
float noise(vec2 st){
  vec2 ist = floor(st);
  vec2 fst = fract(st);

  //get 4 corners of the pixel
  float bl = random(ist);
  float br = random(ist + vec2(1.0, 0.0));
  float tl = random(ist + vec2(0.0, 1.0));
  float tr = random(ist + vec2(1.0, 1.0));

  //smooth interpolation using cubic function
  vec2 si = fst * fst * (3.0 - 2.0 * fst);

  //mix the four corner to get a noise value
  return mix(bl, br, si.x) +
         (tl - bl) * si.y * (1.0 - si.x) +
         (tr - br) * si.x * si.y;
}

void main(){
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  float maxTime = 8.0;
  float normTime = getTimeLoop(maxTime);
  normTime = inoutquad(normTime);


  //distToMouse = pow(distToMouse, 5.0) * 10.0;
  vec2 colsrows = vec2(80.0, 80.0);
  //multiply the pixel coordinate with the colsrows vector t scale the space coordinate system from 0.0 to 1.0 to 0.0 to colsrows
  vec2 nst = st * colsrows;
  //get the fractional parts of the new space coordinates in order to get a repetited grid from 0.0 to 1.0
  vec2 fst = fract(nst);
  //get the nearest integer less than or equals to the new space coordinate to get the index i,j of the cell
  vec2 ist = floor(nst);

  float ftime = floor(u_time / maxTime);
  vec2 inc = vec2(0.0, ftime);
  float randDistribution = random(inc) * 0.05 + 0.30;
  float randPerCell = noise(ist * randDistribution + inc);
  float randCellShown = step(0.5, randPerCell) * 0.85 + 0.15;
  float randomGrey = random(ist) * 0.75 + 0.25;

  float normIndexOfCell = floor(ist.x + (colsrows.y - 1.0 - ist.y) * colsrows.x) / (colsrows.x * colsrows.y);
  float isShown = step(normIndexOfCell, normTime);

  float noiseCellAngle = noise(ist * 0.25 + u_time);
  float angle          = noiseCellAngle * PI * 2.0;
  vec2  nfst = rotate(fst, angle);

  float numberOfShape  = 5.0;
  float randIndexShape = floor(randPerCell * numberOfShape);
  float randShape1      = step(0.0, randIndexShape) * (1.0 - step(1.0, randIndexShape));
  float randShape2      = step(1.0, randIndexShape) * (1.0 - step(2.0, randIndexShape));
  float randShape3      = step(2.0, randIndexShape) * (1.0 - step(3.0, randIndexShape));
  float randShape4      = step(3.0, randIndexShape) * (1.0 - step(4.0, randIndexShape));
  float randShape5      = step(4.0, randIndexShape) * (1.0 - step(5.0, randIndexShape));

  float circsdf = circleSDF(fst);
  float rectsdf = rectangleSDF(fst, vec2(1.0));
  float rectnoisesdf = rectangleSDF(nfst, vec2(0.5, 0.25));

  float size = 0.65;
  float smoothness = 0.25;
  float thickness = 0.25;
  float rectNoiseFill = fill(rectnoisesdf, size, smoothness);
  float rectFill = fill(rectsdf, size, smoothness);
  float circFill = fill(circsdf, size, smoothness);
  float rectStroke = stroke(rectsdf, size, thickness, smoothness);
  float circStroke = stroke(circsdf, size, thickness, smoothness);

  float shape = circStroke    * randShape1 + rectNoiseFill * randShape1 +
                rectFill      * randShape2 +
                circFill      * randShape3 +
                rectStroke    * randShape4 + rectNoiseFill * randShape4 +
                circStroke    * randShape5;

  float whiteShape = shape * randomGrey * randCellShown * isShown;
  whiteShape = clamp(whiteShape, 0.0, 1.0);

  float distToMouse = smoothstep(0.0, 1.0, length(u_mouse - st)) * 2.0;
  float noiseghue = noise(st * 4.0) * 0.5;
  float hue = random(inc);
  float hueOffset = (distToMouse + noiseghue) * 0.75;
  vec3 colorone = hsb2rgb(vec3(hue, 1.0, 1.0));
  vec3 colortwo = hsb2rgb(vec3(hue + hueOffset, 0.75, 1.0));
  vec3 mixcolor = mix(colorone, colortwo, whiteShape) * whiteShape;;

  //OLD SCHOOL EFFECT
  vec2 scanLineGrid = fract(st * vec2(1.0, 150.0) + vec2(0.0, u_time));
  float scanline = lineSmooth(scanLineGrid.y, 0.0, 0.75, 0.25);

  float grain = random(st * u_time);
  gl_FragColor = vec4(mixcolor, 1.0) + grain * 0.05 + scanline * 0.05;
}
