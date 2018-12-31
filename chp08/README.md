# Chapter 8: Matrix transformation : Rotate, translate and scale

* During the last two courses we have learned how to draw basics and complexe shapes.
* We have seen how to draw a shape from the center of our canvas
* We have also seen how to draw them on a different position by changing their center
* Now we will see how we can animated them by moving, rotating or scaling them.

# Matrix transformation
* In GLSL we don't move, rotate or scale and object by changing it's position but by changing the whole coordinate system.
* As see saw previously, we can see our canvas as a cartesian coordinate system, where the origin is set at the left bottom corner of the canvas.
* A way to change it's position is to offset this origin which will affects all drawing on the screen.

# Translation
* The translation is the easiest transformation to do.
* It is achieved by adding a vector to the pixel coordinate 'st'
* In this example offset the origin of the coordinates system with a vec2 where the x component is equals to a sin of the time multiply by an amplitude of 0.25 and the y component is equals to 0.0. Which will give us a nice oscillating effect on the x axis for our square
* You can try differents value for your translation. For example you can try to move the square around the center of the canvas by using a simple polar coordinate conversion for your translate vector where x = cos(angle) * radius and y = sin(angle) * radius;

# Rotation
* Like the translation, the rotation need to be apply on the coordinate system.
* As we saw, we can think about our shader as a program manipulating each pixel and we can understand that we cannot physically rotate a pixel.
* So the main idea is to rotate the coordinate system in order to have a grid a pixel set to the right angle.
* For that we will need to use a matrix. A matrix is a rectangular array of numbers organized in columns and rows. They are used in linear algebra in order to make vector operations. Again i will not convert the principle of matrix and vector operation here and i only ask you to remember that vector are multiply by matrices following a precises order. If you want to learn more about matrices and vectors operation i will invite you to check only for more linear algebra and OpenGL courses.
* GLSL can natively support matrices of differents dimension such as 2, 3 or 4
* For rotating an object we will multiply a ```mat2()```; which is a matrix of dimension 2; by our vector. This mat2 will contain our angle as following :
mat2(cos(angle), -sin(angle),
     sin(angle),  cos(angle));

* This matrix represent the rotation matrix for 2D coordinate system
* We will embed our matrix into a simpple function so we will not have to write it again.
* Now we can rotate our object. We need to remember that we will rotate the entire system. So by default the rotation will happen from the origin. Because of that, our shape, which is set at the center of the screen, will apperas to rotate around the origin and not on itself.
* To rotate the shape on itself, we will need to set the origin of the canvas to position of the shape, rotate it and reset it at its previous position.
* To handle that we will write a simple function like this
* We can now rotate or shape by simply calling our function

# Scaling
* Like the rotation, scaling is a transformation that need a matrix;
* This one will be quite simple. As we are in a 2 dimension space, we will use the following mat2() :
mat2(scale.x, 0.0,
    0.0    , scale.y);
* This transformation is handle the way as the rotation, which is by multiplying our matrix by our vector.
* For that we will write two function. The first one will handle our matrix creation and the second one will handle the scaling operation.
* You can notice that the scaling operation has the same construction as the rotation operation. Which is offseting the origin to the center of the screen, scaling the shape then reset its position
* Now you can try the differents transformation operations with differents value. Try for example to rotate an object around a point (for example the mouse position) or scale the object according its position.

https://paper.dropbox.com/doc/Transformation-2D--AUxdtoqJ96nJ9qFmJHYUWOP5AQ-EGyFbRYDESOBGxDd3l4C6
