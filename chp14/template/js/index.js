
//Create var for the contenair, the webGL 3D scene, uniforms to bind into shader and timer
var stats = new Stats();
stats.showPanel( 0 ); // 0: fps, 1: ms, 2: mb, 3+: custom
document.getElementById('stats-container').appendChild(stats.domElement);

var main = document.getElementById('main');
var infos = document.getElementById('infos');
var context = document.getElementById('experiment');
var title = document.getElementById('title');

var ratio = 1.0;

var camera, scene, renderer;
var uniforms;
var startTime;
var canvasWidth, canvasHeight;
var mouse;

function init() {
	//Create THREE.JS scene and timer
	startTime = Date.now();
	camera = new THREE.Camera();
	camera.position.z = 1;
	scene = new THREE.Scene();

	//create a simple plance
	var geometry = new THREE.PlaneBufferGeometry(2, 2);

	//create uniform table which provide all our GLSL binding
	uniforms = {
		u_time: { type: "f", value: 1.0 },
		u_resolution: { type: "v2", value: new THREE.Vector2() },
		u_mouse: { type: "v2", value: new THREE.Vector2() },
		u_colsrows: { type: "v2", value: new THREE.Vector2() }
	};

	//create THREE.JS material
	var material = new THREE.ShaderMaterial( {
	//set shaders and uniforms into material
		uniforms: uniforms,
		vertexShader: document.getElementById('vertexShader').textContent,
		fragmentShader: document.getElementById('fragmentShader').textContent
	} );

	//create mesh, add it to the scene
	var mesh = new THREE.Mesh(geometry, material);
	scene.add(mesh);

	//create renderer and add it to the DOM
	renderer = new THREE.WebGLRenderer();
	context.appendChild(renderer.domElement);

	renderer.domElement.addEventListener('mousemove', function(evt) {
        mouse = getMousePos(renderer.domElement, evt);
  }, false);

  uniforms.u_colsrows.value.x = 80;
	uniforms.u_colsrows.value.y = 80;
}

function render() {

	//get mouse position
	if(mouse != undefined){
		let normMouseX = mouse.x / canvasWidth;
		let normMouseY = mouse.y / canvasHeight;
	  uniforms.u_mouse.value.x = normMouseX;
		uniforms.u_mouse.value.y = 1.0 - normMouseY;
	}

	//get passed time
	let currentTime = Date.now();
	let elaspedSeconds =  (currentTime - startTime) / 1000.0;
	uniforms.u_time.value = elaspedSeconds;

	renderer.render(scene, camera);
}

function animate() {
	stats.begin();
	render();
	stats.end();
	requestAnimationFrame(animate);
}

function resizeElements(){
  let mainHeight = infos.offsetHeight;
	canvasWidth = mainHeight;
	canvasHeight = mainHeight;

	renderer.setSize(canvasWidth, canvasHeight);
  uniforms.u_resolution.value.x = canvasWidth;
	uniforms.u_resolution.value.y = canvasHeight;
}

var addEvent = function(object, type, callback) {
    if (object == null || typeof(object) == 'undefined') return;
    if (object.addEventListener) {
        object.addEventListener(type, callback, false);
    } else if (object.attachEvent) {
        object.attachEvent("on" + type, callback);
    } else {
        object["on"+type] = callback;
    }
};

function getMousePos(canvas, evt) {
    var rect = canvas.getBoundingClientRect();
    return {
      x: evt.clientX - rect.left,
      y: evt.clientY - rect.top
    };
}

addEvent(window, "resize", resizeElements);
init(); //init scene
animate(); //updateScene
resizeElements();
