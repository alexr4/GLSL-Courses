# Chapter 5: Using color

## Using color in GLSL
* As we saw previously; in GLSL; colors work as normalized values into an RGBA space. Which means the color of the pixel is defined by using an vec4 variable where each component corresponds to the R, G, B, A channels and varies from 0.0 to 1.0;
* We can easily create a simple gradient by using _built in_ function such as ```mix()```. This function will create a interpolation between two values according to a normalized percentage.
* Now you can use what see learned on the previous chapter to create custom gradients. For example we take the absolute value of the sinus of the time in order to animated our color from one gradient to another
* By using the shaping function we can also modify how our color interpolation behave for each gradient. For example, we can use a sin wave of the x value of the pixel in order to create a repetition of our second gradient

## Using HSB color
* Another way to talk about color is by switching from RGB space to HSB space.
* RGB space is a color space where each color is described by 3 channel Red, green and blue.
* HSB space, which stands for Hue, stauration and brightness, describes color as 3 channels : the hue, the saturation and the brightness of the color.
* HSB space can be a more intuitive way to speak about color. When we describe an painting we usually describe its color by its hue, saturation and brightness values.
* In GLSL you can implements a function in order to convert your color from HSB to RGB space. In our case we will not try to explain how the maths behind this conversion works. You can take a time later to read the function and understand it. Here we will use functions from Inigo Quilez in order to convert a color from HSB space to RGB space
* First we create our color using HSB convention into normalized space. Note that the hue value will goes from 0.0 to 1.0 in order to describe the 0.0 to 360.0 degrees of the colors and the saturation and brightness component will go from 0.0 to 1.0 to described the 0.0 nto 100.0 percent of saturation and brightness of the color.
* Then we can convert our HSB color into an RGB color in order to use it on ou shader
