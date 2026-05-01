import express from "express";

const router = express.Router();

const OLLAMA_URL = process.env.OLLAMA_URL || "http://127.0.0.1:11434";
const OLLAMA_MODEL = process.env.OLLAMA_MODEL || "gemma3:4b";

function buildFallbackReply(rawMessage = "") {
  const shortQuestion = rawMessage
    .replace(/^Subject:\s*/i, "")
    .replace(/\nQuestion:\s*/i, " - ")
    .trim();

  return [
    "I am in offline mode right now, so I cannot use the full AI model.",
    "Here is a quick teaching response:",
    shortQuestion
      ? `For \"${shortQuestion}\", start with the core concept, then try one simple example, and finally test yourself with a short practice problem.`
      : "Start with the core concept, then try one simple example, and finally test yourself with a short practice problem.",
    "If you start Ollama, I can provide richer answers and step-by-step explanations.",
  ].join(" ");
}

router.post("/teacher", async (req, res) => {
  const { message, roomId, schedule } = req.body;

  try {
    const prompt = `
You are a smart classroom AI teacher.
Room: ${roomId || "unknown"}
Schedule: ${schedule ? JSON.stringify(schedule) : "not provided"}

Student question: ${message}
Answer clearly like a teacher.
`;

    const r = await fetch(`${OLLAMA_URL}/api/generate`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        model: OLLAMA_MODEL,
        prompt,
        stream: false
      }),
      signal: AbortSignal.timeout(60000),
    });

    if (!r.ok) {
      const text = await r.text();
      throw new Error(`Ollama HTTP ${r.status}: ${text}`);
    }

    const data = await r.json();
    const reply = (data.response || "").toString().trim();

    if (!reply) {
      const detail = data.error ? ` (${data.error})` : "";
      throw new Error(`Empty AI response${detail}`);
    }

    return res.json({ reply });
  } catch (e) {
    console.warn("AI teacher fallback due to Ollama issue:", e.message);
    return res.json({
      reply: buildFallbackReply(message),
      offline: true,
    });
  }
});

export default router;