import base64
file = open("ser.bin","rb")

now = file.read()
ba = base64.b64encode(now)
exp = str(ba).replace("+","%2b")
print(exp)
file.close()
