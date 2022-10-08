package com.drunkbaby.security;


/**
 * SSRFException
 *
 * @author JoyChou @2020-04-04
 */
public class SSRFException extends RuntimeException {

    SSRFException(String s) {
        super(s);
    }

}
