package com.drunkbaby;

import com.sun.tools.attach.VirtualMachine;
import com.sun.tools.attach.VirtualMachineDescriptor;

import java.util.List;

import com.sun.tools.attach.VirtualMachine;
import com.sun.tools.attach.VirtualMachineDescriptor;

import java.util.List;

public class get_PID {
    public static void main(String[] args) {

        List<VirtualMachineDescriptor> list = VirtualMachine.list();
        for(VirtualMachineDescriptor vmd : list){

            //遍历每一个正在运行的JVM，如果JVM名称为get_PID则返回其PID
            if(vmd.displayName().equals("get_PID"))
                System.out.println(vmd.id());
        }

    }
}