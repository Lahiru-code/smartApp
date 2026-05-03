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

/*
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

*/
/*
import * as THREE from "three";
import { GLTFLoader } from "three/addons/loaders/GLTFLoader.js";
import { OrbitControls } from "three/addons/controls/OrbitControls.js";
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
  1000,
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

const loader = new GLTFLoader();

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
  },
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
*/
import * as THREE from "three";
import { GLTFLoader } from "three/addons/loaders/GLTFLoader.js";
import { OrbitControls } from "three/addons/controls/OrbitControls.js";

const hint = document.getElementById("hint");
const canvas = document.getElementById("c");
const answerBox = document.getElementById("answerBox"); // ✅ FIX

let isSpeaking = false;
let teacherModel = null;
let mouthMesh = null;
let headBone = null;
let neckBone = null;

// Renderer
const renderer = new THREE.WebGLRenderer({ canvas, antialias: true });
renderer.setSize(window.innerWidth, window.innerHeight);

// Scene
const scene = new THREE.Scene();
scene.background = new THREE.Color(0x111111);

// Camera
const camera = new THREE.PerspectiveCamera(
  45,
  window.innerWidth / window.innerHeight,
  0.1,
  1000
);
camera.position.set(0, 2, 6);

// Controls
const controls = new OrbitControls(camera, renderer.domElement);
controls.enableDamping = true;

// Lights
scene.add(new THREE.AmbientLight(0xffffff, 2));

const light = new THREE.DirectionalLight(0xffffff, 2);
light.position.set(5, 10, 5);
scene.add(light);

// Load model
const loader = new GLTFLoader();

loader.load(
  "./teacher.glb",
  (gltf) => {
    const teacher = gltf.scene;
    teacherModel = teacher; // ✅ store model

    teacher.traverse((child) => {

      if (child.name === "mixamorigHead_06") headBone = child;
if (child.name === "mixamorigNeck_05") neckBone = child;


  console.log(child.name, child);

  if (
    child.isMesh &&
    child.morphTargetDictionary &&
    (
      child.morphTargetDictionary["mouthOpen"] !== undefined ||
      child.morphTargetDictionary["jawOpen"] !== undefined ||
      child.morphTargetDictionary["viseme_aa"] !== undefined
    )
  ) {
    mouthMesh = child;
    console.log("Mouth mesh found:", child.name);
  }
});

    scene.add(teacher);

    teacher.position.set(0, 0, 0);
    teacher.scale.set(1, 1, 1);

    controls.target.set(0, 1, 0);
    controls.update();

    hint.textContent = "3D Teacher loaded ✅";
  },
  (xhr) => {
    hint.textContent = "Loading 3D teacher...";
  },
  (error) => {
    console.error(error);
    hint.textContent = "Failed to load ❌";
  }
);

// Animation loop
function animate() {
  requestAnimationFrame(animate);

  // ✅ speaking animation
  if (teacherModel && isSpeaking) {
    teacherModel.rotation.y = Math.sin(Date.now() * 0.005) * 0.05;
  }

  controls.update();
  renderer.render(scene, camera);

  if (mouthMesh && isSpeaking) {
  const dict = mouthMesh.morphTargetDictionary;
  const key =
    dict["mouthOpen"] !== undefined ? "mouthOpen" :
    dict["jawOpen"] !== undefined ? "jawOpen" :
    dict["viseme_aa"] !== undefined ? "viseme_aa" :
    null;

  if (key) {
    const index = dict[key];
    mouthMesh.morphTargetInfluences[index] =
      (Math.sin(Date.now() * 0.03) + 1) / 2;
  }
}

if (mouthMesh && !isSpeaking) {
  mouthMesh.morphTargetInfluences.fill(0);
}

if (isSpeaking) {
  const t = Date.now() * 0.006;

  if (headBone) {
    headBone.rotation.y = Math.sin(t) * 0.12;
    headBone.rotation.x = Math.sin(t * 1.7) * 0.04;
  }

  if (neckBone) {
    neckBone.rotation.y = Math.sin(t * 0.8) * 0.06;
  }
} else {
  if (headBone) {
    headBone.rotation.y = 0;
    headBone.rotation.x = 0;
  }

  if (neckBone) {
    neckBone.rotation.y = 0;
  }
}


}
animate();

// Resize
window.addEventListener("resize", () => {
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();
  renderer.setSize(window.innerWidth, window.innerHeight);
});

// ================= AI PART =================

async function askTeacher() {
  const input = document.getElementById("question");
  const question = input.value.trim();

  if (!question) return;

  hint.textContent = "Teacher thinking...";

  const response = await fetch("http://localhost:11434/api/generate", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      model: "gemma3:4b",
      prompt: `You are a classroom teacher. Answer briefly in simple words (max 3 paragraphs): ${question}`,
      stream: false,
    }),
  });

  const data = await response.json();
  const answer = data.response;

  answerBox.textContent = answer; // ✅ correct usage
  hint.textContent = "3D Teacher ready";

  speak(answer);
}

// Speech
function speak(text) {
  const utterance = new SpeechSynthesisUtterance(text);

  utterance.onstart = () => (isSpeaking = true);
  utterance.onend = () => (isSpeaking = false);

  speechSynthesis.cancel();
  speechSynthesis.speak(utterance);
}

// Events
document.getElementById("askBtn").addEventListener("click", askTeacher);

document.getElementById("question").addEventListener("keydown", (e) => {
  if (e.key === "Enter") askTeacher();
});