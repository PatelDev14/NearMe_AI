import axios from "axios";

const OLLAMA_URL = "http://127.0.0.1:11434/api/generate";

export async function askOllama(prompt) {
  try {
    const systemPrompt = `
You are a travel and local discovery assistant.
When asked a query like “best restaurants near me” or “places to visit in Toronto”,
return a JSON object with this exact structure:
{
  "results": [
    {
      "name": "string",
      "summary": "short, human-readable description",
      "rating": number (approximate if unknown),
      "url": "website if known, else null",
      "reviews": "Google Maps or Yelp link if known, else null"
    }
  ]
}
Do NOT include markdown or extra commentary — return ONLY valid JSON.
`;

    const response = await axios.post(OLLAMA_URL, {
      model: "gpt-oss:120b-cloud",
      prompt: `${systemPrompt}\nUser query: ${prompt}\n\nOutput only JSON:`,
      stream: false
    });

    const text = response.data.response.trim();

    // ✅ Try to parse as JSON
    try {
      const parsed = JSON.parse(text);
      return parsed;
    } catch (err) {
      console.warn("⚠️ Failed to parse Ollama JSON, returning text summary instead.");
      return { results: [{ name: "AI Assistant", summary: text }] };
    }
  } catch (err) {
    console.error("🔥 Ollama error:", err.message);
    throw new Error("Failed to get response from Ollama");
  }
}
