#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

//  Iñigo Quiles : https://www.shadertoy.com/view/MsS3Wc
vec3 hsb2rgb(vec3 c){
    vec3 rgb = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),
                             6.0)-3.0)-1.0,
                     0.0,
                     1.0 );
    rgb = rgb*rgb*(3.0-2.0*rgb);
    return c.z * mix(vec3(1.0), rgb, c.y);
}

void main(){
  vec2 st = gl_FragCoord.xy / u_resolution.xy;
  float hueTime = abs(sin(u_time * 0.5));

  vec3 hsbColorOne = vec3(0.625, 1.0, 0.25);
  vec3 hsbColorTwo = vec3(hueTime, 1.0, 1.0);

  vec3 hsbColorOnetoRGB = hsb2rgb(hsbColorOne);
  vec3 hsbColorTwotoRGB = hsb2rgb(hsbColorTwo);

  vec3 gradient = mix(hsbColorOnetoRGB, hsbColorTwotoRGB, st.x);

  gl_FragColor = vec4(gradient, 1.0);
}
