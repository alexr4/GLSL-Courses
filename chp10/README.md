# Chapter 10: Pattern : multiplying your shapes

* We have seen previously how to draw differents kinds of shape and animate them, we will now learn how to create a pattern made with this shapes
* A pattern is the repetition of a shape along one or two axis. The main idea behind this is to multiply the space coordinates in order to have a repetition of 0.0 to 1.0
* In order to do that we will define a new vec2, whose name will be colsrows. This vector will define how many columns and rows we want in our Pattern
* We will now multiply our space coordinate with this new vector, this will scale our space coordinate from 0.0 to 1.0 to 0.0 to colsrows
* We know to draw our shape we work into a normalize space but we now have a space which goes beyond 1.0. We need to remap it in order to have a repetition of a normalized space
* To do that we will use a function seen before : ```fract()```. This function will return only the fractionnal part of a number, which is are the values after the floating point.
* So by using ```fract()``` of our new space coordinate, we will now have a repetition of 0.0 to 1.0
* We can now draw our shape into this grid to get a nice Pattern
* Another useful function is ```floor()```. This will return the nearest integer less or equals to a value. Used with our new space coordinate this will return us the index of the cell as a column and row number

## Create our first pattern
* An great usage example of the ```floor()``` function is the brick like effect where one in two row as an offset on x
* In order to do this effect we will compute the modulo of the space coordinate index on the y axis by two. This will give us a result switching between 0.0 and 1.0
* We can now add and offset of a value multiply by this result to the original space coordinate.
* Our space coordinate is now offseted by the value on one in two row.
* In fact the modulo of a value by 2 is a great snippet if you want to know if a number is even or odd.

## Going further
* We can now go further by apply various matrix operation to our new space coordinates to animated or pattern such as a simple rotation with an eased time value for example
* I have prepare various example using différents kind of shape and matrix operation. I invite you to read and tweak them in order to create your own pattern
