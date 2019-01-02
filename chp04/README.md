# Chapter 4: Basic shaping function in GLSL

## gl_FragCoord
* GLSL can provide us the screen coordinates of the pixel by using the _built in_ variable ```gl_FragCoord```
* This coordinates are not normalized and set into screen space, which means if your canvas has a size of 500×500 the ```gl_FragCoord``` will return a value between 0.0 and 500;
* We can normalized this coordinates in order to used them as color. In order to do that we will divide the pixel coordinates by the resolution of the canvas given the ```u_resolution``` variable.
* By doing that, each pixel will have its coordinates mapped into its red and green channel.
* You can also use the mouse position on x or y to map the blue value for example.

## Shaping function
* In GLSL everything goes by manipulating value from one range to another.
* Lets focus on a simple value, st.x. This value represent the space coordinate of our pixels on x. It goes from 0.0 to 1.0.
* If we think about space, we will notice that 0.0 represent the left corner, 1.0 the right corner and 0.5 the center of the canvas.
* Another way to think about this value is by thinking in terms of brightness as we see a gradient. A simple example if a fog effect where the fog increase with de distance for example.
* Our main goal is to manipulate with gradient, or the way this value goes from 0.0 to 1.0 in order to draw the shape we want.

# Step
* Let's start with a simple relationship. Imagine we want to divide our space into two rectangles, one black, on the left, one white on the right. In order to do that we will need to know when the value of st.x is greater or equal to 0.5.
* The best way to do this is by using the ```step()``` function. It takes two argument : an edge, limit or threshold and a value and return 1.0 if the value is greater or equals to the edge. If not it will return 0.0. This just looks like a simple if/else operation
* If you set our glo_FragColor with this value we will now have a white rectangle on the right and a black one on the left

# Smoothstep
* Another simple operation if the ```smoothstep``` function.
* This function will interpolate a value between an given range. The first parameters are the min and max edges while the third one if the offset value.
* You notice how it's easy to create a blurry edge between the two rectangle with this one.

# The others
* We have seen the two main function we will use to draw our shapes but GLSL has a lot of useful function. You will find nearly everything basic mathematical operation such pow, sin, cos, modulo, fract... let's see some of them
* pow return the value powered by another
* mod will return the modulo of the value by another
* fract (a useful one) will return the fractional part of a value, which is the number beyond the floating point
* sin and cos will return the sin and cosine of a value
* ceil and floor will return the nearest integer greater or less to the value
* absolute will return the absolute number of a value
* You can find many other in the GLSL documentation.
* For now it may seems quite difficult to understand how this can be useful but you will return to this chapter later when we will start to draw some shapes and gradients
* Try differents functions and value, may try to experiments with st.y in order to see the difference with the y axis

## Custom shaping function
* You can also create your own shaping function to create custom behaviors.
* You will find a large amount of various shaping function on the web such as :
* * [Robert Penner easing function](http://www.gizma.com/easing/)
* * Golan Levin shaping functions
* * * [Exponential shaping functions](http://www.flong.com/texts/code/shapers_exp/)
* * * [Polynomial shaping functions](http://www.flong.com/texts/code/shapers_poly/)
* * * [Bezier and other parametric shaping functions](http://www.flong.com/texts/code/shapers_bez/)
* * * [Circular and elliptical shaping functions](http://www.flong.com/texts/code/shapers_circ/)
* * [Inigo Quilez useful functions](http://www.iquilezles.org/www/articles/functions/functions.htm)
