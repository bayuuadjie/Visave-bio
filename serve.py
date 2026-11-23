import http.server, socketserver, socket, os, functools
PORT = 8080
os.chdir(os.path.dirname(os.path.abspath(__file__)))
def lan_ip():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        s.connect(("10.255.255.255", 1)); return s.getsockname()[0]
    except Exception:
        return socket.gethostbyname(socket.gethostname())
    finally:
        s.close()
class H(http.server.SimpleHTTPRequestHandler):
    def log_message(self, *a): pass
socketserver.ThreadingTCPServer.allow_reuse_address = True
with socketserver.ThreadingTCPServer(("0.0.0.0", PORT), H) as srv:
    print("\n  Visa Bio Converter berjalan.")
    print(f"  Di komputer ini : http://localhost:{PORT}")
    print(f"  Dari komputer lain (jaringan sama): http://{lan_ip()}:{PORT}")
    print("\n  Tekan Ctrl+C untuk berhenti.\n")
    srv.serve_forever()
