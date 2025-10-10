// temp_test.js
import axios from "axios";

const OLLAMA_URL = "http://127.0.0.1:11434/api/generate";

const test = async () => {
  const prompt = "best places in Kainchi Dham, India in brief";
  const response = await axios.post(OLLAMA_URL, {
    model: "gpt-oss:120b-cloud",
    prompt,
    stream: false
  });
  console.log("🧠 Full Ollama response:\n", response.data);
};

test();
