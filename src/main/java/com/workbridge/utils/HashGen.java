package com.workbridge.util;

import org.mindrot.jbcrypt.BCrypt;

public class HashGen {
    public static void main(String[] args) {
        String password = "Admin@123";
        String hashed = BCrypt.hashpw(password, BCrypt.gensalt(12));
        System.out.println("HASH:" + hashed);
    }
}
