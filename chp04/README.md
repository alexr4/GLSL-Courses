# Chapter 4: Basic shaping function in GLSL

## gl_FragCoord
* GLSL can provide us the screen coordinates of the pixel by using the _built in_ variable ```gl_FragCoord```
* This coordinates are not normalized and set into screen space, which means if your canvas has a size of 500×500 the ```gl_FragCoord``` will return a value between 0.0 and 500;
* We can normalized this coordinates in order to used them as color. In order to do that we will divide the pixel coordinates by the resolution of the canvas given the ```u_resolution``` variable.
* By doing that, each pixel will have its coordinates mapped into ist red and green channel.
* You can also use the mouse position on x or y to map the blue value for example.

## Shaping function

## Custom shaping function
* You can also create your own shaping function to create custom behaviours.
* You will find a large amount of various shaping function on on the web such as :
* * [Robert Penner easing function](http://www.gizma.com/easing/)
* * Golan Levin shaping functions
* * * [Exponential shaping functions](http://www.flong.com/texts/code/shapers_exp/)
* * * [Polynomial shaping functions](http://www.flong.com/texts/code/shapers_poly/)
* * * [Bezier and other parametric shaping functions](http://www.flong.com/texts/code/shapers_bez/)
* * * [Circular and elliptical shaping functions](http://www.flong.com/texts/code/shapers_circ/)
* * [Inigo Quilez useful functions](http://www.iquilezles.org/www/articles/functions/functions.htm)
