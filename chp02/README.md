# Chapter 2 : Discovering fragment shader : A world from 0 to 1

A fragment shader is composed by the following structure :
* A *single* ```main``` function which return a color at the given pixel. This is the main function of your program.
* The ```gl_FragColor``` variable is the reserved global variable which assign the color to the pixel. There is various _built in_ functions and varibales like the ````gl_FragColor``` in GLSL. We will see it later.
* The ```gl_FragColor``` seems to be a vector with four components. In GLSL we use the type ```vec4``` to declare a Vector with four components. We can use ```vec2``` or ```vec3``` to declare a vector with two or three components.
* If the color of the pixel is assigned using a ```vec4``` we can conclude that each component refers to the *RED*, *GREEN*, *BLUE* and *ALPHA* channel of the pixel.
* We can note that each channel is *normalized* which means their values goes from 0.0 to 1.0. As we know RGB values go from 0.0 to 255.0 we can assumes here that RGB 127 will be 0.5 as a ```vec4```.
* GLSL is similar to C and have *pre-processor macros*. They are part of the pre-compilation step. By using them it's possible to design behaviours, variables, functions, condition... which will be defined before the compilation of our program. In our example, the macro ```#ifdef GL_ES``` describes a behavior of a floating point variable if the program is compiled on mobile devices or web browser.
* Floating point variable are crucial to shader as we work in a normalized space from 0.0 to 1.0. Our macro on line 2 describes the precision of our floating points values. _Lower_ precision will be faster but will have less quality. You can declare precision in your macros using ```lowp```, ```mediump``` or ```highp```. Here we use a ```mediump``` precision
* As we saw, GLSL has differnts variables to describe a vector such as ```vec4```, ```vec3``` and ```vec2```. You can also use ```float``` to describe a floating point varibale and ```int``` to describe an integer.

_examples_ :
* HelloWorld.glsl
