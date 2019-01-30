/**
This example show how to use random value in order to create a particles line effetc
*/

#ifdef GL_ES
precision mediump float;
#endif
#define PI 3.14159265359

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;

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

/*
This function will return a random number between 0.0 and 1.0 at a specific coordinate xy (random with more variation)
*/
float random (vec2 st) {
    return fract(sin(dot(st.xy, vec2(10.9898,78.233)))*43758.5453123);
}

void main(){
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  st = rotate(st, PI * 0.25);
  //define a vector with the number of desired columns and rows for your pattern
  vec2 colsrows = vec2(5.0, 25.0);

  //get the index for each row
  vec2  randPerRow       = vec2(floor(st.y * colsrows.y));
  //define a random value form each row
  float randomOffset     = random(randPerRow);
  //define a speed from the random value
  float randomSpeed      = randomOffset * 2.0 + 0.5 ;
  //offset each row with a random speed
  st.x += randomOffset + u_time * randomSpeed;


  //multiply the pixel coordinate with the colsrows vector t scale the space coordinate system from 0.0 to 1.0 to 0.0 to colsrows
  vec2 nst = st * colsrows;
  //get the fractional parts of the new space coordinates in order to get a repetited grid from 0.0 to 1.0
  vec2 fst = fract(nst);
  //get the nearest integer less than or equals to the new space coordinate to get the index i,j of the cell
  vec2 ist = floor(nst);

  //get a random value for each cell
  float randPerCell = random(ist);
  //define if the cell has to be drawn depending on the random value per cell
  float isDrawn     = step(0.5, randPerCell);
  //define a random width for each shape depending on the random value per cell
  float randwidth   = randPerCell * 0.5 + 0.25;
  //define a random height for each shape depending on a new the random value per cell define by the inverted indices
  float randheight  = random(ist.yx) * 0.5 + 0.25;

  //draw the rectangle
  float rect        = rectangleSmooth(fst, vec2(0.5), vec2(randwidth, randheight), vec2(0.01));

  vec3 color = vec3(rect * isDrawn);
  gl_FragColor = vec4(color, 1.0);
}
