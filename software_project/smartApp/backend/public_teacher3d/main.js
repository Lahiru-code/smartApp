/*import * as THREE from "/three/build/three.module.js";
import { GLTFLoader } from "/three/examples/jsm/loaders/GLTFLoader.js";
import { OrbitControls } from "/three/examples/jsm/controls/OrbitControls.js";
import { KTX2Loader } from '/three/examples/jsm/loaders/KTX2Loader.js';

const hint = document.getElementById("hint");
const canvas = document.getElementById("c");

const renderer = new THREE.WebGLRenderer({ canvas, antialias: true });
renderer.setPixelRatio(window.devicePixelRatio);
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.outputColorSpace = THREE.SRGBColorSpace;

const scene = new THREE.Scene();
scene.background = new THREE.Color(0x111111);

const camera = new THREE.PerspectiveCamera(45, window.innerWidth / window.innerHeight, 0.1, 1000);

const controls = new OrbitControls(camera, renderer.domElement);
controls.enableDamping = true;

// STRONG LIGHTING
scene.add(new THREE.AmbientLight(0xffffff, 2.0));
const light = new THREE.DirectionalLight(0xffffff, 3.0);
light.position.set(5, 10, 5);
scene.add(light);

// Visual helpers (so we KNOW rendering works)
scene.add(new THREE.GridHelper(20, 20));
scene.add(new THREE.AxesHelper(2));

let teacher;

const loader = new GLTFLoader();

const ktx2Loader = new KTX2Loader()
  .setTranscoderPath("/three/examples/jsm/libs/basis/") // ✅ correct place
  .detectSupport(renderer);                             // ✅ correct place

loader.setKTX2Loader(ktx2Loader); // ✅ only this on GLTFLoader

loader.load(
  "./teacher.glb",
  (gltf) => {
    teacher = gltf.scene;
    scene.add(teacher);

    const box = new THREE.Box3().setFromObject(teacher);
    const size = box.getSize(new THREE.Vector3());
    const center = box.getCenter(new THREE.Vector3());

    teacher.position.sub(center);
    teacher.position.y += size.y / 2;

    const maxDim = Math.max(size.x, size.y, size.z);
    const fov = camera.fov * (Math.PI / 180);
    let cameraZ = Math.abs(maxDim / 2 / Math.tan(fov / 2));
    cameraZ *= 1.5;

    camera.position.set(0, size.y * 0.6, cameraZ);

    controls.target.set(0, size.y * 0.5, 0);
    controls.update();

    hint.textContent = "3D Teacher loaded ✅ (drag to rotate)";
  },
  undefined,
  (error) => {
    console.error(error);
    hint.textContent = "Failed to load model ❌";
  }
);
*/

import * as THREE from "three";
import { GLTFLoader } from "three/addons/loaders/GLTFLoader.js";
import { OrbitControls } from "three/addons/controls/OrbitControls.js";
import { KTX2Loader } from "three/addons/loaders/KTX2Loader.js";

const hint = document.getElementById("hint");
const canvas = document.getElementById("c");

const renderer = new THREE.WebGLRenderer({ canvas, antialias: true });
renderer.setPixelRatio(window.devicePixelRatio);
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.outputColorSpace = THREE.SRGBColorSpace;

const scene = new THREE.Scene();
scene.background = new THREE.Color(0x111111);

const camera = new THREE.PerspectiveCamera(
  45,
  window.innerWidth / window.innerHeight,
  0.1,
  1000
);

const controls = new OrbitControls(camera, renderer.domElement);
controls.enableDamping = true;

controls.minDistance = 1;
controls.maxDistance = 20;

scene.add(new THREE.AmbientLight(0xffffff, 1.2));
const light = new THREE.DirectionalLight(0xffffff, 2.5);
light.position.set(5, 10, 5);
scene.add(light);

scene.add(new THREE.AmbientLight(0xffffff, 0.6));

const key = new THREE.DirectionalLight(0xffffff, 2.0);
key.position.set(5, 10, 5);
scene.add(key);

const fill = new THREE.DirectionalLight(0xffffff, 1.2);
fill.position.set(-5, 5, 5);
scene.add(fill);

const rim = new THREE.DirectionalLight(0xffffff, 1.0);
rim.position.set(0, 8, -8);
scene.add(rim);

//scene.add(new THREE.GridHelper(20, 20));
//scene.add(new THREE.AxesHelper(2));

const loader = new GLTFLoader();

// KTX2 (Basis) support (only needed if your model uses KTX2 textures)
const ktx2Loader = new KTX2Loader()
  .setTranscoderPath("/three/examples/jsm/libs/basis/")
  .detectSupport(renderer);

loader.setKTX2Loader(ktx2Loader);

loader.load(
  "./teacher.glb",
  (gltf) => {
    const teacher = gltf.scene;
    scene.add(teacher);

    const box = new THREE.Box3().setFromObject(teacher);
    const size = box.getSize(new THREE.Vector3());
    const center = box.getCenter(new THREE.Vector3());

    teacher.position.sub(center);
    teacher.position.y += size.y / 2;

    const maxDim = Math.max(size.x, size.y, size.z);
    const fov = camera.fov * (Math.PI / 180);
    let cameraZ = Math.abs(maxDim / 2 / Math.tan(fov / 2));
    cameraZ *= 1.5;

    camera.position.set(0, size.y * 0.6, cameraZ);
    controls.target.set(0, size.y * 0.5, 0);
    controls.update();

    hint.textContent = "3D Teacher loaded ✅ (drag to rotate)";
  },
  undefined,
  (err) => {
    console.error(err);
    hint.textContent = "Failed to load model ❌";
  }
);

function animate() {
  requestAnimationFrame(animate);
  controls.update();
  renderer.render(scene, camera);
}
animate();

window.addEventListener("resize", () => {
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();
  renderer.setSize(window.innerWidth, window.innerHeight);
});