import pickle

class Person():
    def __init__(self):
        self.name = "Drunkbaby"
        self.age = 20

p = Person()
opcode = pickle.dumps(p)
print(opcode)

P = pickle.loads(opcode)

print('The name is :' + P.name, 'The age is :' + str(P.age))