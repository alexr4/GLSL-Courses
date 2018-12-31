# Chapter 14: Add shader to you webpage

* Here we are, at our final stage, the final moment where we can put everything we have learned on a webpage
* At the begining of this course we explained how shaders works. They are bound to another program, which run on the CPU.
* It is this main program which compile the shader and run it.
* In order to work perpely we have aslo learned that shader works with geometric space. The GPU will then transform the geometry into an image as seen as by a camera. This image will then be send to the fragment shader where we can compute differents operation per "pixels"
* So basically we need to setup a simple 3D scene in our webpage, with a plane seen by a camera and then apply our shader to this pipeline.* That it for a basic explanation on how this stuff works
* For this we will add a javascript library to our webpage called Three js
* Three js is a 3D library for the web used by many programmers, artists and company.
* Once again, as we are in an introduction course, we will not cover how to create a 3D scene, not even the html part where I've create my design layout. We will only focus on how to implement and manipulate our sahder from this template.

# HTML and JS decomposition
* In the html page you will notice differents parts :
* * A div with the id 'experiment'. It's the div where my canvas this the 3D scene will be created
* * Two Script tag of typ x-shader and the ids fragmentShader and vertexShader. This is where you put our shader program. I will go back to it later
* * Three script at the end of the page :
* * The first one is the three js library called from cdnjs
* * The seconds is stats.js which provide us a nice performance tracker
* * The last one index.js is our script where we setup our Scene

# The JS parts
* Let's take a look at the JS parts
* The first part is simply the declaration of the performance tracker.
* Then we can find our variable. We need differents elements :
* * The div 'experiment' where we put our canvas
* * the threejs scene variable which are
* * * the camera, the scene and the renderer
* * * and object uniforms which will handle all our uniform variables. Remember that uniforms are the variables bound to the shader from the CPU program, here our js script
* * * A variable startTime for the time counter, mouse for the mouse position and canvas width and height for the size of our canvas.
* The init function handle the creation of the Scene
* * At first we initialize the time, create a camera and a scene.
* * We create a simple plane which fill the entire view of our Camera
* * We create a uniforms object in order to handle all our uniforms variables. It's here where we declare all our variable we need to send from our CPU program to our shader. Notice how we reuse the same names as the glsl-preview package in order to not change anything in our variable declaration. That means your variables names need to be the same in the uniforms object and your shader
* * We create a simple material. This is where we call our shader from our webpage. We get the two script with the corresponding id and pass it to the the program. The first shader will handle the geometry and the second one the fragment operations
* * We then create a mesh and put it into our scene, create the renderer and push it to the page (the DOM)
*  * The following last declaration setup the detection of the mouse position
* The render function handle the rendering part. It has
* * The computation of the mouse position into and GLSL normalize space (remember our shader as it origin at bottom left so we need to invert the y axis)
* * The computation of the timer passed
* * The sending of the value to our shader. Notice how you can communicate to a variable using the following declaration uniforms.yourvariable.value
* * The rendering of the scene
* The animate function is the main loop which call the render and perfom the stats tracking
* The resize element is a function called everytime you rescale the page.
* * It define the size of the canvas according to the size of the windows with a scale of 0.75. Here we have setup a square size canvasWidth
* * We also send to our shader the new resolution to the variable u_resolution each time we redefine it
* The add event and getmouse functions handle the detection of the mouse position on the canvas
* At last we call the differents functions to launch and run our program

# Add your shader to the template page
* Now we have understand how the index.js program works we can go back to the html page and the x-shader script tag
* As we said earlier the first shader, the vertex shader, handle the computation of the geomrty from the point of view of the camera. We do not need to update it
* We will only update the second one, the fragment shader tag. You can copy/paste your latest shader here and test your program.
* You will notice I used a new package, the live-sever package in order to have a live server running on my computer. This simulate a server on atom and assure anything works well.

# 
