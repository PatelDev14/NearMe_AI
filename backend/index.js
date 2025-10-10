import express from "express";
import cors from "cors";
import searchRouter from "./routes/search.js"; // ✅ correct

const app = express();
const PORT = 5000;

app.use(cors());
app.use(express.json());

app.use("/search", searchRouter); // ✅ route hooked

app.listen(PORT, "127.0.0.1", () => {
  console.log(`✅ Server running on http://127.0.0.1:${PORT}`);
});
