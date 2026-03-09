import express from "express";
import cors from "cors";
import morgan from "morgan";
import helmet from "helmet";
import dotenv from "dotenv";
import path from "path";
import { fileURLToPath } from "url";

import authRoutes from "./routes/auth.routes.js";
import deviceRoutes from "./routes/device.routes.js";
import aiTeacherRouter from "./routes/aiTeacher.js";

dotenv.config();

const app = express();

app.use(cors());
app.use(
  helmet({
    contentSecurityPolicy: {
      useDefaults: true,
      directives: {
        ...helmet.contentSecurityPolicy.getDefaultDirectives(),

        // Allow textures and binary data used by glTF loaders
        "img-src": ["'self'", "data:", "blob:"],
        "connect-src": ["'self'", "blob:"],

        // Needed if you use module scripts / workers for wasm decoders
        "script-src": ["'self'", "'unsafe-inline'"],
        "worker-src": ["'self'", "blob:"],
      },
    },
    crossOriginResourcePolicy: { policy: "cross-origin" }, // helps with assets
  })
);
app.use(express.json());
app.use(morgan("dev"));

app.use("/api/auth", authRoutes);
app.use("/api/devices", deviceRoutes);
app.use("/api/ai", aiTeacherRouter);

/* ✅ Serve 3D Teacher static files */
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// this points to: backend/public_teacher3d
app.use(
  "/teacher3d",
  express.static(path.join(__dirname, "..", "public_teacher3d"))
);

// ✅ serve Three.js from node_modules (NO CDN)
app.use("/three", express.static(path.join(__dirname, "..", "node_modules", "three")));

app.get("/", (req, res) => {
  res.json({ message: "Smart Classroom API running" });
});

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});