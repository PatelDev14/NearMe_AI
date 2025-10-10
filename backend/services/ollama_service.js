import axios from "axios";

const OLLAMA_URL = "http://127.0.0.1:11434/api/generate";

export async function askOllama(prompt) {
  try {
    console.log("🚀 Sending prompt to Ollama:", prompt);

    const response = await axios.post(OLLAMA_URL, {
      model: "gpt-oss:120b-cloud",
      prompt: prompt,
      stream: false,
    });

    console.log("🧠 Ollama raw data:", response.data);

    return response.data.response || "(no content returned from Ollama)";
  } catch (err) {
    console.error("🔥 Ollama error:", err.message);
    if (err.response) console.error(err.response.data);
    throw new Error("Failed to get response from Ollama");
  }
}
