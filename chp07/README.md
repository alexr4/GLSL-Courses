# Chapter 7: Drawing complexe shapes with function

* By combinying drawing basic shapes you we can produce complexe pattern but it can be usefull to know how to draw more complexe shape. During this part, we will see how we can produce more complexe shape using two differents approache

## Manipulating the radius of a polar shape
* In the last course we have seen how to draw a circle using a distance from a point, the radius. Another way to draw shape is to modulate this radius along the angle of the shape.
* In this way we stop thinking about space as a cartesian coordinates system, defined by an x and y axis and start to think of it as a polar coordinates system based on a radius and an angle.
* If we modulate the radius along the angle we will be able to produce differents shapes that may look like flowers. For this, we will start with our last shader, where we have drawn a circle.
* At start we define the vector pointing from the pixel to the center of the canvas
* The radius of the circle is defined by the ```length()``` function, in order to get the angle of the vector we will use the ```atan()``` function. This will give us the angle of the vector from the range -PI to PI
* We can now compute a radius varying along the angle by using shaping function. The easiest one will be using sin of the angle multiply by a value. This will give us a raidus oscillating between -1.0 to 1.0
* We can multiply this result by an amplitude to define the ratio of variation of this radius.
* At last we use this modulated radius into our circle function to get a custom shape which kind of look like a flowers
* You can try different shaping function to modulate your radius or even use additional shaping function to create a more complexe shape. You can see my implementation in order to tests differents values

## Creating a edges shape function
* Modulating the radius of a circle can give us a flower like shape but we can also take this approach to create differents circle based shape such as triangle, pentagon, octagon and others
* For this one, we will create a function taking the pixel coordinate, the number of edges as arguments and the size of the shape.
* We will start again with the same variables such as the vector pointing from the pixel to the center and the angle of the vector.
* We will define the radius of the shape by dividing two PI by the number of edges. Note that we need to cast our int into a floating point value.
* We can now create our distance shaping method which will be
cos(floor(0.5 + angle/radius) * radius - angle) * length(toCenter);
* At last we will return 1.0 - step(0.5 * size, d);
* You can now try different value for the number of edges in order to get various shapes
