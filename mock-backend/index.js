import express from "express";
import cors from "cors";

const app = express();
const PORT = 5000;

app.use(cors());
app.use(express.json());

app.get("/", (req, res) => {
  res.send("Mock backend running ✅");
});

app.use((req, res, next) => {
  console.log(`📢 Incoming request: ${req.method} ${req.url}`);
  next();
});

app.post("/search", (req, res) => {
  const { query } = req.body;
  console.log("Received query:", query);

  // Mock response
  if (!query) {
    return res.status(400).json({ error: "Missing query" });
  }

  const results = [
    { title: "Coffee Shop", description: "Best coffee near you" },
    { title: "Coffee Beans", description: "Buy premium coffee beans" },
  ];

  res.json({ results });
});

app.listen(PORT, "127.0.0.1", () => {
  console.log(`✅ Server running on http://127.0.0.1:${PORT}`);
});
// app.listen(PORT, "0.0.0.0", () => {
//   console.log(`✅ Server running on http://localhost:${PORT}`);
// });
