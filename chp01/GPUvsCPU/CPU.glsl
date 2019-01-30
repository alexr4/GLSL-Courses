/*
Pre-processor macro defining the behavior of the GLSL program according to the GLSL version
Here we define, if the program run on a GL_ES environment (mainly used for web and mobile devices) we will use float value with medium precision
More precision (highp) will goes will more latency and low precision (lowp) will be faster but not precise
*/
#ifdef GL_ES
precision mediump float;
#endif

//pre-processor macro defining the key word PI as 3.14159265359 will compiled
#define PI 3.14159265359

/*
uniform variables are the variables bounds to the shader from the CPU side (Javascript in our case)
They are set to read-only and cannot be modified by the shader because they need to be identical for each fragment of the images
u_time, u_resolution, u_mouse and image are uniform provided by the glsl-preview package. See the documentation of the package online for more informations
*/
uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform sampler2D image; //image.png

/*
Function for drawing a rectangle as float (1.0 if the pixel is inside the rectangle, 0.0 if it is outside)
st is the fragment coordinate to test, center is the center of the shape and thickness defines its width and height
*/
float rectangle(vec2 st, vec2 center, vec2 thickness){
  float edgeX = step(center.x, st.x + thickness.x * 0.5) - step(center.x, st.x - thickness.x * 0.5);
  float edgeY = step(center.y, st.y + thickness.y * 0.5) - step(center.y, st.y - thickness.y * 0.5);
  return edgeX * edgeY;
}

void main(){
  //compute the normalize screen coordinate
  vec2 st = gl_FragCoord.xy/u_resolution.xy;

  //compute the fractional parts of the time with a low increment (to reduce speed) in order to get only 0.0 to 1.0 value
  float ftime = fract(u_time * 0.01);

  //define the number of column and rows (here it is a representation of the pixels)
  vec2 colsrows = vec2(100.0);

  //Create the pixelated pattern where fuv is the multicated screen coordinate and iuv is the column and row indices
  vec2 nuv = st * colsrows;
  vec2 fuv = fract(nuv);
  vec2 iuv = floor(nuv);

  //define the number of pixel of the image as the multiplication of the column and rows
  float numberOfPixel = floor(colsrows.x * colsrows.y);
  //Compute the pixel index from the column and row indices (for more information you can read the great pixel manipulation tutorial from Daniel Shiffman on processing.org https://processing.org/tutorials/pixels/)
  float index = iuv.x + iuv.y * colsrows.x;

  //Simulate how the CPU/GPU works. CPU will update each pixel one by one, GPU will update them all at once
  float cpuProcessSimulation = step(index, ftime * numberOfPixel);
  float gpuProcessSimulation = fract(u_time);

  //compute the pixelated uv which is define by the colsrows coordinate of the center of each cell normalized
  vec2 pixelUV = (vec2(0.5) + iuv) / colsrows;

  //draw a grid which is only the border remain on each cell when we draw a rectangle on its center
  float grid = (1.0 - rectangle(fuv, vec2(0.5), vec2(0.85))) * 0.1;

  //define the color of the cell by getting the RGBA value from the texture multiplying by the CPU/GPU simulation
  vec4 rgba = texture2D(image, pixelUV) * gpuProcessSimulation;

  //draw everything
  gl_FragColor = rgba + grid;
}
