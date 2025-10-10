// backend/routes/search.js
import express from "express";
import { askOllama } from "../services/ollama_service.js"; // ✅ correct

const router = express.Router();

router.post("/", async (req, res) => {
  try {
    const { query } = req.body;
    console.log("📨 Received query:", query);

    if (!query) {
      return res.status(400).json({ error: "Missing query" });
    }

    const aiResponse = await askOllama(query);
    console.log("🤖 Ollama response:", aiResponse);

    res.json({
      results: [
        {
          name: "AI Response",
          summary: aiResponse,
        },
      ],
    });
  } catch (error) {
    console.error("❌ /search error:", error.message);
    res.status(500).json({ error: "Failed to fetch AI response" });
  }
});

export default router;


