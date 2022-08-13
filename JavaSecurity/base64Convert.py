import base64

# base64 encode EXP, easy to attack
temp_file = open("ser.bin", "rb+")
f = temp_file.read()
result = base64.b64encode(f)

print(result)