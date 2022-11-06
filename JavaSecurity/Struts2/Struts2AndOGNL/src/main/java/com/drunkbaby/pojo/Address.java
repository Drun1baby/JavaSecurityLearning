package com.drunkbaby.pojo;


public class Address {

    private String port;
    private String address;

    public Address(String port,String address) {
        this.port = port;
        this.address = address;
    }

    public String getPort() {
        return port;
    }

    public void setPort(String port) {
        this.port = port;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public String toString() {
        return "Address{" +
                "port='" + port + '\'' +
                ", address='" + address + '\'' +
                '}';
    }
}