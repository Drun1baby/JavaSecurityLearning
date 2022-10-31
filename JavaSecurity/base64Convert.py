import base64
file = open("ser.bin","rb")

now = file.read()
ba = base64.b64encode(now)
print(ba)
file.close()
