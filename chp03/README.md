# Chapter 3: Programming fragment shader using Atom

* Shaders can't be used as stand alone program. They need to be called and compile by a program running on our CPU. In our case, this will be a javascript file on our webpage.
* In order to focus our learning on the GLSL parts we will be using a a package with Atom which will provide us a live preview of our fragment shader. With this package we will be able to create our own shader without having to setup a js program on a webpage. We will see at the end of the course how to embed our shader into a webpage.

## Install Atom.io
* We will use Atom has our code editor. You can download it from [atom.io](https://atom.io/)
* After installing it we will add two package that will help us in our learning path :
* * language-glsl provide syntax highlight for GLSL
* * glsl-preview will allow us to have a live preview of our shader by using the key combination `ctrl+shift+g`
* In order to install this packages, you will need to go to *File → Settings → Install* then search for each of them and click to install

## HelloWorld with Atom.io and gl-preview
* After everything has been installed, we can take our _HelloWorld_ shader and have a live preview of it by pressing `ctrl+shift+g`
* As we know shaders run on parallel threads. Each one assigned the color of to a fraction of an image. We can see our ```main``` function as big forloop system for each pixel. We also know that each thread is blind to the other.
* We have seen in our previous chapter how to assigned a variable in our shader (or here in our thread). But we also need to be able to send some inputs from outside our shader to it. Theses inputs came from the CPU via the program which compile and run our shader. This inputs can be for example, the passed time ou the mouse position. Because this inputs need to be the same for each thread of our shader we will be using the new keyworkd ```uniform``` in front of their declarations. By using this ```uniform``` keyword, I declare a globale variable, coming from outside the shader and equals for each thread.
* It is important to note that ```uniform``` are _read only_ variable Because they need to be equal for each thread.
* You can think of ```uniform``` variable as connection between CPU and GPU sides
* *glsl-preview* provides us various ```uniform``` variables which will be very useful for us :
* * ```u_resolution``` : is the size of the canvas as a vec2
* * ```u_mouse``` : is the position of mouse on the canvas as a vec2
* * ```u_time``` : is time passed in seconds
