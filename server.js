const http = require("http"), fs = require("fs"), path = require("path"), os = require("os");
const PORT = 8080, root = __dirname;
const types = {".html":"text/html; charset=utf-8",".js":"text/javascript",".css":"text/css"};
http.createServer((req, res) => {
  let p = decodeURIComponent(req.url.split("?")[0]); if (p === "/") p = "/index.html";
  const f = path.join(root, path.normalize(p).replace(/^(\.\.[\/\\])+/, ""));
  if (!f.startsWith(root)) { res.writeHead(403); return res.end(); }
  fs.readFile(f, (e, d) => {
    if (e) { res.writeHead(404); return res.end("Not found"); }
    res.writeHead(200, {"Content-Type": types[path.extname(f)] || "application/octet-stream"}); res.end(d);
  });
}).listen(PORT, "0.0.0.0", () => {
  const ips = Object.values(os.networkInterfaces()).flat().filter(i => i.family === "IPv4" && !i.internal).map(i => i.address);
  console.log("\n  Visa Bio Converter berjalan.\n  Di komputer ini : http://localhost:" + PORT);
  ips.forEach(ip => console.log("  Dari komputer lain (jaringan sama): http://" + ip + ":" + PORT));
  console.log("\n  Tekan Ctrl+C untuk berhenti.\n");
});
