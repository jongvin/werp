/**
 * EVCSPSoap.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.2RC3 Feb 28, 2005 (10:15:14 EST) WSDL2Java emitter.
 */

package org.tempuri;

public interface EVCSPSoap extends java.rmi.Remote {
    public void callEncrypt(java.lang.String seedKey, java.lang.String origional, javax.xml.rpc.holders.StringHolder callEncryptResult, javax.xml.rpc.holders.StringHolder rtnEncData) throws java.rmi.RemoteException;
    public void callDecrypt(java.lang.String seedKey, java.lang.String encData, javax.xml.rpc.holders.StringHolder callDecryptResult, javax.xml.rpc.holders.StringHolder rtnOrgData) throws java.rmi.RemoteException;
    public void callBase64Encode(java.lang.String inputString, javax.xml.rpc.holders.StringHolder callBase64EncodeResult, javax.xml.rpc.holders.StringHolder rtnEncData) throws java.rmi.RemoteException;
    public void callBase64Decode(java.lang.String b64EncodedData, javax.xml.rpc.holders.StringHolder callBase64DecodeResult, javax.xml.rpc.holders.StringHolder rtnDecData) throws java.rmi.RemoteException;
    public void callHash(java.lang.String orgMsg, javax.xml.rpc.holders.StringHolder callHashResult, javax.xml.rpc.holders.StringHolder rtnHashValue) throws java.rmi.RemoteException;
    public void callSign(java.lang.String certDn, int SType, java.lang.String orgMsg, java.lang.String password, javax.xml.rpc.holders.StringHolder callSignResult, javax.xml.rpc.holders.StringHolder rtnSignedData) throws java.rmi.RemoteException;
    public void callSignVerify(java.lang.String signedData, javax.xml.rpc.holders.StringHolder callSignVerifyResult, javax.xml.rpc.holders.StringHolder rtnOrgData, javax.xml.rpc.holders.StringHolder rtnSigner) throws java.rmi.RemoteException;
    public void callCertValidation(java.lang.String certDn, int SType, javax.xml.rpc.holders.StringHolder callCertValidationResult, javax.xml.rpc.holders.StringHolder rtnValidateResult) throws java.rmi.RemoteException;
    public void callEnvelopedData_Enclose(java.lang.String certDn, int SType, java.lang.String plainText, javax.xml.rpc.holders.StringHolder callEnvelopedData_EncloseResult, javax.xml.rpc.holders.StringHolder rtnEnvelopedData) throws java.rmi.RemoteException;
    public void callEnvelopedData_Open(java.lang.String envelopedData, java.lang.String password, javax.xml.rpc.holders.StringHolder callEnvelopedData_OpenResult, javax.xml.rpc.holders.StringHolder rtnPlainText) throws java.rmi.RemoteException;
    public void callSignAndEnvelopData(java.lang.String certDn, int SType, java.lang.String message, java.lang.String password, java.lang.String recipientDn, javax.xml.rpc.holders.StringHolder callSignAndEnvelopDataResult, javax.xml.rpc.holders.StringHolder rtnSignAndEnvData) throws java.rmi.RemoteException;
    public void callOpenAndVerifyData(java.lang.String signAndEnvData, java.lang.String password, javax.xml.rpc.holders.StringHolder callOpenAndVerifyDataResult, javax.xml.rpc.holders.StringHolder rtnOrgMsg) throws java.rmi.RemoteException;
}
