import argparse
import msgpack
import os
import socket
import sys

def send_file(server_host, server_port, filepath):
    filepath = os.path.abspath(filepath)
    if not os.path.isfile(filepath):
        print(f"[ERROR] File does not exist: {filepath}")
        return

    with open(filepath, 'rb') as f:
        content = f.read()

    filename = os.path.basename(filepath)
    data = msgpack.packb({
        'filename': filename,
        'content': content
    })

    try:
        with socket.create_connection((server_host, server_port), timeout=5) as sock:
            sock.sendall(data)
        print(f"[INFO] Sent file {filename} ({len(content)} bytes)")
    except Exception as e:
        print(f"[ERROR] Failed to send file: {e}")

def parse_args():
    parser = argparse.ArgumentParser(description="Send file to clipboard server")
    parser.add_argument('file', help="File to send")
    parser.add_argument('--host', default='localhost', help="Server host (default: localhost)")
    parser.add_argument('--port', type=int, default=6543, help="Server port (default: 6543)")
    return parser.parse_args()

if __name__ == '__main__':
    args = parse_args()
    send_file(args.host, args.port, args.file)

