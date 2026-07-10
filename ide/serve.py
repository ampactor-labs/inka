#!/usr/bin/env python3
"""ide/serve.py — serve the repo with cross-origin isolation.

The compiler's wasm declares SHARED memory (the threading substrate), and
browsers only allow shared WebAssembly memory on cross-origin-isolated
pages — which needs two headers a bare file:// open cannot provide. This
serves the REPO ROOT (so the IDE can fetch ../lib/runtime/*.mn for the
runtime link) with those headers set.

    python3 ide/serve.py            # http://localhost:7378/ide/
    python3 ide/serve.py 8080       # custom port
"""
import http.server
import os
import sys

PORT = int(sys.argv[1]) if len(sys.argv) > 1 else 7378
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


class Isolated(http.server.SimpleHTTPRequestHandler):
    extensions_map = {
        **http.server.SimpleHTTPRequestHandler.extensions_map,
        ".wasm": "application/wasm",
        ".mn": "text/plain",
    }

    def end_headers(self):
        self.send_header("Cross-Origin-Opener-Policy", "same-origin")
        self.send_header("Cross-Origin-Embedder-Policy", "require-corp")
        self.send_header("Cache-Control", "no-store")
        super().end_headers()


os.chdir(ROOT)
print(f"mentl edit → http://localhost:{PORT}/ide/")
http.server.ThreadingHTTPServer(("127.0.0.1", PORT), Isolated).serve_forever()
