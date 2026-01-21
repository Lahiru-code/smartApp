import express from "express";
import cors from "cors";
import morgan from "morgan";
import helmet from "helmet";
import dotenv from "dotenv";
import authRoutes from "./routes/auth.routes.js";
import deviceRoutes from "./routes/device.routes.js";



dotenv.config();

const app = express();

app.use(cors());
app.use(helmet());
app.use(express.json());
app.use(morgan("dev"));
app.use("/api/auth", authRoutes);
app.use("/api/devices", deviceRoutes);
 


app.get("/", (req, res) => {
  res.json({ message: "Smart Classroom API running" });
});

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
