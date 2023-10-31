package com.contrast.gadget;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.Serializable;

public class ProcBuilder implements Serializable {

    private String cmd;

    public String getCmd() {
        return cmd;
    }

    public void addCommandInNotBeanStandardWay(String string ){
        cmd = string;
    }


    public void setCmd(String cmd) {
        this.cmd = cmd;
        try {
            Runtime.getRuntime().exec(cmd);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void readObject(ObjectInputStream ois) throws IOException, ClassNotFoundException {
        ois.defaultReadObject();
        setCmd(cmd);
    }
}
