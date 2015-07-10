/**
 * EVCSPLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.2RC3 Feb 28, 2005 (10:15:14 EST) WSDL2Java emitter.
 */

package org.tempuri;

public class EVCSPLocator extends org.apache.axis.client.Service implements org.tempuri.EVCSP {

    public EVCSPLocator() {
    }


    public EVCSPLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public EVCSPLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for EVCSPSoap
    private java.lang.String EVCSPSoap_address = "http://192.168.1.12:8080/WS_EVCSP/EVCSP.asmx";

    public java.lang.String getEVCSPSoapAddress() {
        return EVCSPSoap_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String EVCSPSoapWSDDServiceName = "EVCSPSoap";

    public java.lang.String getEVCSPSoapWSDDServiceName() {
        return EVCSPSoapWSDDServiceName;
    }

    public void setEVCSPSoapWSDDServiceName(java.lang.String name) {
        EVCSPSoapWSDDServiceName = name;
    }

    public org.tempuri.EVCSPSoap getEVCSPSoap() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(EVCSPSoap_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getEVCSPSoap(endpoint);
    }

    public org.tempuri.EVCSPSoap getEVCSPSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            org.tempuri.EVCSPSoapStub _stub = new org.tempuri.EVCSPSoapStub(portAddress, this);
            _stub.setPortName(getEVCSPSoapWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setEVCSPSoapEndpointAddress(java.lang.String address) {
        EVCSPSoap_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (org.tempuri.EVCSPSoap.class.isAssignableFrom(serviceEndpointInterface)) {
                org.tempuri.EVCSPSoapStub _stub = new org.tempuri.EVCSPSoapStub(new java.net.URL(EVCSPSoap_address), this);
                _stub.setPortName(getEVCSPSoapWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("EVCSPSoap".equals(inputPortName)) {
            return getEVCSPSoap();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://tempuri.org/", "EVCSP");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://tempuri.org/", "EVCSPSoap"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        if ("EVCSPSoap".equals(portName)) {
            setEVCSPSoapEndpointAddress(address);
        }
        else { // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
