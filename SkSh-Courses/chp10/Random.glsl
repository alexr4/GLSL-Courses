#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;

/**
This function simulate the random function. Try differents value for x and inc to see how it behaves
*/
float randSim(float x, float inc){
  return fract(sin(x) * inc);
}

/*
This function will return a random number between 0.0 and 1.0 at a specific number x
*/
float random(float x){
  return fract(sin(x) * 43758.5453123);
}

/*
This function will return a random number between 0.0 and 1.0 at a specific coordinate xy (random with more variation)
*/
float random (vec2 st) {
    return fract(sin(dot(st.xy, vec2(10.9898,78.233)))*43758.5453123);
}

void main(){
  vec2 st = gl_FragCoord.xy/u_resolution.xy;

  float simRand = randSim(st.x * 3.14, 10000.0); //random simulation
  float randNum = random(st.x * 3.14); // random on one axis

  vec2 nst = u_time * st; // new animated coordiate to feed the random for animated random
  float grain = random(st);//random on two axis

  vec3 color = vec3(grain);

  gl_FragColor = vec4(color, 1.0);
}
