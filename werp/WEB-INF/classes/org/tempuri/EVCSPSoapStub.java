/**
 * EVCSPSoapStub.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.2RC3 Feb 28, 2005 (10:15:14 EST) WSDL2Java emitter.
 */

package org.tempuri;

public class EVCSPSoapStub extends org.apache.axis.client.Stub implements org.tempuri.EVCSPSoap {
    private java.util.Vector cachedSerClasses = new java.util.Vector();
    private java.util.Vector cachedSerQNames = new java.util.Vector();
    private java.util.Vector cachedSerFactories = new java.util.Vector();
    private java.util.Vector cachedDeserFactories = new java.util.Vector();

    static org.apache.axis.description.OperationDesc [] _operations;

    static {
        _operations = new org.apache.axis.description.OperationDesc[12];
        _initOperationDesc1();
        _initOperationDesc2();
    }

    private static void _initOperationDesc1(){
        org.apache.axis.description.OperationDesc oper;
        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("callEncrypt");
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "SeedKey"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Origional"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "callEncryptResult"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.OUT, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "rtnEncData"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.OUT, false, false);
        oper.setReturnType(org.apache.axis.encoding.XMLType.AXIS_VOID);
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        _operations[0] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("callDecrypt");
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "SeedKey"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "EncData"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "callDecryptResult"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.OUT, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "rtnOrgData"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.OUT, false, false);
        oper.setReturnType(org.apache.axis.encoding.XMLType.AXIS_VOID);
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        _operations[1] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("callBase64Encode");
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "InputString"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "callBase64EncodeResult"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.OUT, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "rtnEncData"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.OUT, false, false);
        oper.setReturnType(org.apache.axis.encoding.XMLType.AXIS_VOID);
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        _operations[2] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("callBase64Decode");
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "B64EncodedData"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "callBase64DecodeResult"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.OUT, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "rtnDecData"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.OUT, false, false);
        oper.setReturnType(org.apache.axis.encoding.XMLType.AXIS_VOID);
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        _operations[3] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("callHash");
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "orgMsg"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "callHashResult"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.OUT, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "rtnHashValue"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.OUT, false, false);
        oper.setReturnType(org.apache.axis.encoding.XMLType.AXIS_VOID);
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        _operations[4] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("callSign");
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "CertDn"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "SType"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "OrgMsg"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Password"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "callSignResult"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.OUT, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "rtnSignedData"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.OUT, false, false);
        oper.setReturnType(org.apache.axis.encoding.XMLType.AXIS_VOID);
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        _operations[5] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("callSignVerify");
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "SignedData"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "callSignVerifyResult"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.OUT, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "rtnOrgData"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.OUT, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "rtnSigner"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.OUT, false, false);
        oper.setReturnType(org.apache.axis.encoding.XMLType.AXIS_VOID);
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        _operations[6] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("callCertValidation");
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "CertDn"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "SType"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "callCertValidationResult"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.OUT, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "rtnValidateResult"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.OUT, false, false);
        oper.setReturnType(org.apache.axis.encoding.XMLType.AXIS_VOID);
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        _operations[7] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("callEnvelopedData_Enclose");
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "CertDn"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "SType"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "PlainText"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "callEnvelopedData_EncloseResult"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.OUT, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "rtnEnvelopedData"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.OUT, false, false);
        oper.setReturnType(org.apache.axis.encoding.XMLType.AXIS_VOID);
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        _operations[8] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("callEnvelopedData_Open");
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "EnvelopedData"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Password"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "callEnvelopedData_OpenResult"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.OUT, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "rtnPlainText"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.OUT, false, false);
        oper.setReturnType(org.apache.axis.encoding.XMLType.AXIS_VOID);
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        _operations[9] = oper;

    }

    private static void _initOperationDesc2(){
        org.apache.axis.description.OperationDesc oper;
        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("callSignAndEnvelopData");
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "CertDn"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "SType"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Message"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Password"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "RecipientDn"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "callSignAndEnvelopDataResult"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.OUT, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "rtnSignAndEnvData"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.OUT, false, false);
        oper.setReturnType(org.apache.axis.encoding.XMLType.AXIS_VOID);
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        _operations[10] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("callOpenAndVerifyData");
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "SignAndEnvData"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Password"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.IN, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "callOpenAndVerifyDataResult"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.OUT, false, false);
        oper.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "rtnOrgMsg"), new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, org.apache.axis.description.ParameterDesc.OUT, false, false);
        oper.setReturnType(org.apache.axis.encoding.XMLType.AXIS_VOID);
        oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
        oper.setUse(org.apache.axis.constants.Use.LITERAL);
        _operations[11] = oper;

    }

    public EVCSPSoapStub() throws org.apache.axis.AxisFault {
         this(null);
    }

    public EVCSPSoapStub(java.net.URL endpointURL, javax.xml.rpc.Service service) throws org.apache.axis.AxisFault {
         this(service);
         super.cachedEndpoint = endpointURL;
    }

    public EVCSPSoapStub(javax.xml.rpc.Service service) throws org.apache.axis.AxisFault {
        if (service == null) {
            super.service = new org.apache.axis.client.Service();
        } else {
            super.service = service;
        }
        ((org.apache.axis.client.Service)super.service).setTypeMappingVersion("1.2");
    }

    protected org.apache.axis.client.Call createCall() throws java.rmi.RemoteException {
        try {
            org.apache.axis.client.Call _call =
                    (org.apache.axis.client.Call) super.service.createCall();
            if (super.maintainSessionSet) {
                _call.setMaintainSession(super.maintainSession);
            }
            if (super.cachedUsername != null) {
                _call.setUsername(super.cachedUsername);
            }
            if (super.cachedPassword != null) {
                _call.setPassword(super.cachedPassword);
            }
            if (super.cachedEndpoint != null) {
                _call.setTargetEndpointAddress(super.cachedEndpoint);
            }
            if (super.cachedTimeout != null) {
                _call.setTimeout(super.cachedTimeout);
            }
            if (super.cachedPortName != null) {
                _call.setPortName(super.cachedPortName);
            }
            java.util.Enumeration keys = super.cachedProperties.keys();
            while (keys.hasMoreElements()) {
                java.lang.String key = (java.lang.String) keys.nextElement();
                _call.setProperty(key, super.cachedProperties.get(key));
            }
            return _call;
        }
        catch (java.lang.Throwable _t) {
            throw new org.apache.axis.AxisFault("Failure trying to get the Call object", _t);
        }
    }

    public void callEncrypt(java.lang.String seedKey, java.lang.String origional, javax.xml.rpc.holders.StringHolder callEncryptResult, javax.xml.rpc.holders.StringHolder rtnEncData) throws java.rmi.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[0]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("http://tempuri.org/callEncrypt");
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://tempuri.org/", "callEncrypt"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {seedKey, origional});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            java.util.Map _output;
            _output = _call.getOutputParams();
            try {
                callEncryptResult.value = (java.lang.String) _output.get(new javax.xml.namespace.QName("http://tempuri.org/", "callEncryptResult"));
            } catch (java.lang.Exception _exception) {
                callEncryptResult.value = (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_output.get(new javax.xml.namespace.QName("http://tempuri.org/", "callEncryptResult")), java.lang.String.class);
            }
            try {
                rtnEncData.value = (java.lang.String) _output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnEncData"));
            } catch (java.lang.Exception _exception) {
                rtnEncData.value = (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnEncData")), java.lang.String.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
  throw axisFaultException;
}
    }

    public void callDecrypt(java.lang.String seedKey, java.lang.String encData, javax.xml.rpc.holders.StringHolder callDecryptResult, javax.xml.rpc.holders.StringHolder rtnOrgData) throws java.rmi.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[1]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("http://tempuri.org/callDecrypt");
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://tempuri.org/", "callDecrypt"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {seedKey, encData});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            java.util.Map _output;
            _output = _call.getOutputParams();
            try {
                callDecryptResult.value = (java.lang.String) _output.get(new javax.xml.namespace.QName("http://tempuri.org/", "callDecryptResult"));
            } catch (java.lang.Exception _exception) {
                callDecryptResult.value = (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_output.get(new javax.xml.namespace.QName("http://tempuri.org/", "callDecryptResult")), java.lang.String.class);
            }
            try {
                rtnOrgData.value = (java.lang.String) _output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnOrgData"));
            } catch (java.lang.Exception _exception) {
                rtnOrgData.value = (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnOrgData")), java.lang.String.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
  throw axisFaultException;
}
    }

    public void callBase64Encode(java.lang.String inputString, javax.xml.rpc.holders.StringHolder callBase64EncodeResult, javax.xml.rpc.holders.StringHolder rtnEncData) throws java.rmi.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[2]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("http://tempuri.org/callBase64Encode");
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://tempuri.org/", "callBase64Encode"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {inputString});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            java.util.Map _output;
            _output = _call.getOutputParams();
            try {
                callBase64EncodeResult.value = (java.lang.String) _output.get(new javax.xml.namespace.QName("http://tempuri.org/", "callBase64EncodeResult"));
            } catch (java.lang.Exception _exception) {
                callBase64EncodeResult.value = (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_output.get(new javax.xml.namespace.QName("http://tempuri.org/", "callBase64EncodeResult")), java.lang.String.class);
            }
            try {
                rtnEncData.value = (java.lang.String) _output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnEncData"));
            } catch (java.lang.Exception _exception) {
                rtnEncData.value = (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnEncData")), java.lang.String.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
  throw axisFaultException;
}
    }

    public void callBase64Decode(java.lang.String b64EncodedData, javax.xml.rpc.holders.StringHolder callBase64DecodeResult, javax.xml.rpc.holders.StringHolder rtnDecData) throws java.rmi.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[3]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("http://tempuri.org/callBase64Decode");
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://tempuri.org/", "callBase64Decode"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {b64EncodedData});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            java.util.Map _output;
            _output = _call.getOutputParams();
            try {
                callBase64DecodeResult.value = (java.lang.String) _output.get(new javax.xml.namespace.QName("http://tempuri.org/", "callBase64DecodeResult"));
            } catch (java.lang.Exception _exception) {
                callBase64DecodeResult.value = (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_output.get(new javax.xml.namespace.QName("http://tempuri.org/", "callBase64DecodeResult")), java.lang.String.class);
            }
            try {
                rtnDecData.value = (java.lang.String) _output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnDecData"));
            } catch (java.lang.Exception _exception) {
                rtnDecData.value = (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnDecData")), java.lang.String.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
  throw axisFaultException;
}
    }

    public void callHash(java.lang.String orgMsg, javax.xml.rpc.holders.StringHolder callHashResult, javax.xml.rpc.holders.StringHolder rtnHashValue) throws java.rmi.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[4]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("http://tempuri.org/callHash");
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://tempuri.org/", "callHash"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {orgMsg});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            java.util.Map _output;
            _output = _call.getOutputParams();
            try {
                callHashResult.value = (java.lang.String) _output.get(new javax.xml.namespace.QName("http://tempuri.org/", "callHashResult"));
            } catch (java.lang.Exception _exception) {
                callHashResult.value = (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_output.get(new javax.xml.namespace.QName("http://tempuri.org/", "callHashResult")), java.lang.String.class);
            }
            try {
                rtnHashValue.value = (java.lang.String) _output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnHashValue"));
            } catch (java.lang.Exception _exception) {
                rtnHashValue.value = (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnHashValue")), java.lang.String.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
  throw axisFaultException;
}
    }

    public void callSign(java.lang.String certDn, int SType, java.lang.String orgMsg, java.lang.String password, javax.xml.rpc.holders.StringHolder callSignResult, javax.xml.rpc.holders.StringHolder rtnSignedData) throws java.rmi.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[5]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("http://tempuri.org/callSign");
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://tempuri.org/", "callSign"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {certDn, new java.lang.Integer(SType), orgMsg, password});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            java.util.Map _output;
            _output = _call.getOutputParams();
            try {
                callSignResult.value = (java.lang.String) _output.get(new javax.xml.namespace.QName("http://tempuri.org/", "callSignResult"));
            } catch (java.lang.Exception _exception) {
                callSignResult.value = (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_output.get(new javax.xml.namespace.QName("http://tempuri.org/", "callSignResult")), java.lang.String.class);
            }
            try {
                rtnSignedData.value = (java.lang.String) _output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnSignedData"));
            } catch (java.lang.Exception _exception) {
                rtnSignedData.value = (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnSignedData")), java.lang.String.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
  throw axisFaultException;
}
    }

    public void callSignVerify(java.lang.String signedData, javax.xml.rpc.holders.StringHolder callSignVerifyResult, javax.xml.rpc.holders.StringHolder rtnOrgData, javax.xml.rpc.holders.StringHolder rtnSigner) throws java.rmi.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[6]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("http://tempuri.org/callSignVerify");
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://tempuri.org/", "callSignVerify"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {signedData});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            java.util.Map _output;
            _output = _call.getOutputParams();
            try {
                callSignVerifyResult.value = (java.lang.String) _output.get(new javax.xml.namespace.QName("http://tempuri.org/", "callSignVerifyResult"));
            } catch (java.lang.Exception _exception) {
                callSignVerifyResult.value = (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_output.get(new javax.xml.namespace.QName("http://tempuri.org/", "callSignVerifyResult")), java.lang.String.class);
            }
            try {
                rtnOrgData.value = (java.lang.String) _output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnOrgData"));
            } catch (java.lang.Exception _exception) {
                rtnOrgData.value = (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnOrgData")), java.lang.String.class);
            }
            try {
                rtnSigner.value = (java.lang.String) _output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnSigner"));
            } catch (java.lang.Exception _exception) {
                rtnSigner.value = (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnSigner")), java.lang.String.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
  throw axisFaultException;
}
    }

    public void callCertValidation(java.lang.String certDn, int SType, javax.xml.rpc.holders.StringHolder callCertValidationResult, javax.xml.rpc.holders.StringHolder rtnValidateResult) throws java.rmi.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[7]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("http://tempuri.org/callCertValidation");
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://tempuri.org/", "callCertValidation"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {certDn, new java.lang.Integer(SType)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            java.util.Map _output;
            _output = _call.getOutputParams();
            try {
                callCertValidationResult.value = (java.lang.String) _output.get(new javax.xml.namespace.QName("http://tempuri.org/", "callCertValidationResult"));
            } catch (java.lang.Exception _exception) {
                callCertValidationResult.value = (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_output.get(new javax.xml.namespace.QName("http://tempuri.org/", "callCertValidationResult")), java.lang.String.class);
            }
            try {
                rtnValidateResult.value = (java.lang.String) _output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnValidateResult"));
            } catch (java.lang.Exception _exception) {
                rtnValidateResult.value = (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnValidateResult")), java.lang.String.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
  throw axisFaultException;
}
    }

    public void callEnvelopedData_Enclose(java.lang.String certDn, int SType, java.lang.String plainText, javax.xml.rpc.holders.StringHolder callEnvelopedData_EncloseResult, javax.xml.rpc.holders.StringHolder rtnEnvelopedData) throws java.rmi.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[8]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("http://tempuri.org/callEnvelopedData_Enclose");
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://tempuri.org/", "callEnvelopedData_Enclose"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {certDn, new java.lang.Integer(SType), plainText});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            java.util.Map _output;
            _output = _call.getOutputParams();
            try {
                callEnvelopedData_EncloseResult.value = (java.lang.String) _output.get(new javax.xml.namespace.QName("http://tempuri.org/", "callEnvelopedData_EncloseResult"));
            } catch (java.lang.Exception _exception) {
                callEnvelopedData_EncloseResult.value = (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_output.get(new javax.xml.namespace.QName("http://tempuri.org/", "callEnvelopedData_EncloseResult")), java.lang.String.class);
            }
            try {
                rtnEnvelopedData.value = (java.lang.String) _output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnEnvelopedData"));
            } catch (java.lang.Exception _exception) {
                rtnEnvelopedData.value = (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnEnvelopedData")), java.lang.String.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
  throw axisFaultException;
}
    }

    public void callEnvelopedData_Open(java.lang.String envelopedData, java.lang.String password, javax.xml.rpc.holders.StringHolder callEnvelopedData_OpenResult, javax.xml.rpc.holders.StringHolder rtnPlainText) throws java.rmi.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[9]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("http://tempuri.org/callEnvelopedData_Open");
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://tempuri.org/", "callEnvelopedData_Open"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {envelopedData, password});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            java.util.Map _output;
            _output = _call.getOutputParams();
            try {
                callEnvelopedData_OpenResult.value = (java.lang.String) _output.get(new javax.xml.namespace.QName("http://tempuri.org/", "callEnvelopedData_OpenResult"));
            } catch (java.lang.Exception _exception) {
                callEnvelopedData_OpenResult.value = (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_output.get(new javax.xml.namespace.QName("http://tempuri.org/", "callEnvelopedData_OpenResult")), java.lang.String.class);
            }
            try {
                rtnPlainText.value = (java.lang.String) _output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnPlainText"));
            } catch (java.lang.Exception _exception) {
                rtnPlainText.value = (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnPlainText")), java.lang.String.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
  throw axisFaultException;
}
    }

    public void callSignAndEnvelopData(java.lang.String certDn, int SType, java.lang.String message, java.lang.String password, java.lang.String recipientDn, javax.xml.rpc.holders.StringHolder callSignAndEnvelopDataResult, javax.xml.rpc.holders.StringHolder rtnSignAndEnvData) throws java.rmi.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[10]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("http://tempuri.org/callSignAndEnvelopData");
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://tempuri.org/", "callSignAndEnvelopData"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {certDn, new java.lang.Integer(SType), message, password, recipientDn});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            java.util.Map _output;
            _output = _call.getOutputParams();
            try {
                callSignAndEnvelopDataResult.value = (java.lang.String) _output.get(new javax.xml.namespace.QName("http://tempuri.org/", "callSignAndEnvelopDataResult"));
            } catch (java.lang.Exception _exception) {
                callSignAndEnvelopDataResult.value = (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_output.get(new javax.xml.namespace.QName("http://tempuri.org/", "callSignAndEnvelopDataResult")), java.lang.String.class);
            }
            try {
                rtnSignAndEnvData.value = (java.lang.String) _output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnSignAndEnvData"));
            } catch (java.lang.Exception _exception) {
                rtnSignAndEnvData.value = (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnSignAndEnvData")), java.lang.String.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
  throw axisFaultException;
}
    }

    public void callOpenAndVerifyData(java.lang.String signAndEnvData, java.lang.String password, javax.xml.rpc.holders.StringHolder callOpenAndVerifyDataResult, javax.xml.rpc.holders.StringHolder rtnOrgMsg) throws java.rmi.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[11]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("http://tempuri.org/callOpenAndVerifyData");
        _call.setEncodingStyle(null);
        _call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
        _call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://tempuri.org/", "callOpenAndVerifyData"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {signAndEnvData, password});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            java.util.Map _output;
            _output = _call.getOutputParams();
            try {
                callOpenAndVerifyDataResult.value = (java.lang.String) _output.get(new javax.xml.namespace.QName("http://tempuri.org/", "callOpenAndVerifyDataResult"));
            } catch (java.lang.Exception _exception) {
                callOpenAndVerifyDataResult.value = (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_output.get(new javax.xml.namespace.QName("http://tempuri.org/", "callOpenAndVerifyDataResult")), java.lang.String.class);
            }
            try {
                rtnOrgMsg.value = (java.lang.String) _output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnOrgMsg"));
            } catch (java.lang.Exception _exception) {
                rtnOrgMsg.value = (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_output.get(new javax.xml.namespace.QName("http://tempuri.org/", "rtnOrgMsg")), java.lang.String.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
  throw axisFaultException;
}
    }

}
