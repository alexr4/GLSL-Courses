# Chapter 6: Drawing basic shapes with function

* During the previous chapter, we have learned how GLSL behave, how we can create our own shaping function and how we can manipulate color but we haven't drawn anything yet.
* We will now learn how to use this knowledges to create our first shapes.
* In order to draw shapes with GLSL, you need to think as a painter in front of a wall. If you want to paint half your wall, from the bottom to the top, you will fill it with color from the bottom the half of the top. Now you want to draw en square on it, you will fill only the parts contain by the square.
* This is exactly how you need to think with GLSL. You need to think "How can i defined the part of the shape on the canvas I need to fill it with color ?"

## Line
* The simplest and basic shapes to draw is a line going from an edge of the canvas to another.
* To do that we need to compare a value to see if its between to two edges.
* As we described with our painting wall metaphore, if we want to draw a line, from an edge to another, we will fill the wall only if the parts is between the values defined by its thickness.
* We will use the ```step()``` function to do that.
* We write our own line function which take three arguments :
* * the value to compare
* * the edge of the line to fill
* * the thickness
* The first ```step``` checks if the value if greater than our edge we we can start to fill our canvas
* The second one checks if the value if beyond the edge so we need to stop to fill the canvas
* Remember that ```step``` gives us a results of 1.0 if the condition is true and 0.0 if it's not. So to fill our line only on the edge part we will substract the seconds step to the first one which give us a result of 1.0 if the value is between edge - thickness and edge + thickness
* You can also add some smoothness to the edge of you line by modifying the line function and replace the ```step````methods by a smoothstep one. Check my implementation and try to manipulate with differents smoothness.
* You can also manipulate the value you gave to your line function, using a sin or a cos methods to get some great curved line. See my implementd and manipulate it.

## Rectangle
* The second shape is the Rectangle.
* You can think of it as an extension of the line. Instead of comparing only one value from and edge we will compare two value corresponding to the x and y axis of our rectangle.
* So basically we will take our line function and modife its arguments to become vec2
* Then, for each axis, we will compare the position of the pixel from the center as we have done it for our line function
* Note that now our edge variable is named center, this variable describe the center position of our rectangle
* Like the line function you can add some smoothnessto your shape by modifying the ```step``` function into a ```smoothstep``` function. Again, you can check my implementation
* And agin you can manipulate the values in order to deform the shape as we made it on our curve line. You can check my implementation to create this nice fabric on the wind effect
* This two methods are not the only one used to draw rectangle and you can find various implementation. I encourage you to try differnts one and find which on can filled your expectation.
* I've provide you another implementation rom Patricio Vivo Gonzalez, which use Signe Distance approach in order to describe the shape. This is really usefull when you need to switch between filled or stroked shapes.

## Ellipse
* The third shape is the circle. When we think about circle into a cartesian coordinates system (with x and y) it can tricky to define how to draw it. We need to think about it differently.
* Circle are defined a position and a radius. The first define the position of the circle and the second one define it's size. In fact the radius is just the distance between the edge of the shape and the position of its center
* So in order to draw a circle, we will need to ask if the distance from its center is greater than the radius. If so we will stop to fill our drawing.
* They are differents way to calculate the distance from a point to another in GLSL.
* Here we will used the ```length()``` methods which return the magnitude of a vector.
* First we will calculate the vector from the canvas to the center of the Circle by substracting the center of our shape to our point
* Then we will retreived its magnitude by using the ```length()``` methods. This will give us the distance between the point on the canvas and the center of our shape
* At last we will check if this distance if greater or equals to our radius using the ```step()``` method. By doing so, our function will return 1.0 if the pixel is beyond the radius, so we will substract one with our result in order to get a value of 1.0 if our pixel is inside our shape.
* Like the line function you can add some smoothness to your shape by modifying the ```step``` function into a ```smoothstep``` function. Again, you can check my implementation
* And agin you can manipulate the values in order to deform the shape as we made it on our curve line. You can check my implementation to create this nice fabric on the wind effect
