package com.cj.util;

import com.cj.common.*;
import com.cj.database.*;

import java.io.*;
import javax.xml.parsers.*;
import org.w3c.dom.*;

// CITData 클래스를 XML로 변환하는 클래스
public class CITXml
{
	private static final String XML_NULL = "#NULL#";
	
	public CITXml()
	{
	}
	
	public static void main(String[] args) throws Exception
	{
		/*
		CITData lrData = null;
		CITData argData = new CITData();
		String strSql = "";
		
		argData.addColumn("USER_NO", CITData.NUMBER);
		argData.addRow();
		argData.setValue("USER_NO", "1");
		
		strSql = "  Select * ";
        strSql += " From  PTZ_USER ";
        strSql += " Where USER_NO = ? ";
    	
		lrData = CITDatabase.selectQuery(strSql, argData);
		lrData = XML2CITData(CITData2XML(lrData));
		
		System.out.println(CITData2XML(lrData));
		
		String testString = "<\"하하하\"&&'킥킥킥'\\>";
		String lsTemp = "";
		
		System.out.println("Source String : " + testString);
		
		lsTemp = CITCommon.enSC(testString);
		System.out.println("enSC1 : " + lsTemp);
		
		lsTemp = CITCommon.enSC(lsTemp);
		System.out.println("enSC2 : " + lsTemp);
		
		lsTemp = CITCommon.deSC(lsTemp);
		System.out.println("deSC1 : " + lsTemp);
		
		lsTemp = CITCommon.deSC(lsTemp);
		System.out.println("deSC2 : " + lsTemp);
		*/
	}
	
	/*
		C_I : COLUMN_INFO
		C : COLUMN
		C_D_S : COLUMN_DISPLAY_SIZE
		C_N : COLUMN_NAME
		C_T : COLUMN_TYPE
		C_T_N : COLUMN_TYPE_NAME
		PR : PRECISION
		SS : SSCALE
		S_N : SCHEMA_NAME
		T_N : TABLE_NAME
		IS_N : NULLABLE
		O_P : OUT_PARAMETER
		M_D : MAIN_DATA
		D_R : DATA_ROW
	*/
	
	// CITData 클래스의 정보를 XML로 변환
	public static String CITData2XML(CITData aData) throws Exception
	{
		StringBuffer sbXml = new StringBuffer();
		int iRow = 0;
		int iCol = 0;
		
		if (aData == null) throw new Exception ("CITXml CITData2XML Error : CITData가 널(null)입니다");
		
		sbXml.append("<?xml version='1.0' encoding='euc-kr'?>");
		sbXml.append("<CITDATA>");
		
		sbXml.append("<C_I>");
		
		for (iCol = 0; iCol < aData.getColsCount(); iCol++)
		{
			sbXml.append("<C>");
			
			sbXml.append("<C_D_S>" + aData.getColumnDisplaySize(iCol) + "</C_D_S>");
			sbXml.append("<C_N>");
			//sbXml.append(CITCommon.isNull(aData.getColumnName(iCol)) ? XML_NULL : aData.getColumnName(iCol));
			sbXml.append(CITCommon.isNull(aData.getColumnName(iCol)) ? XML_NULL : CITCommon.enSC(aData.getColumnName(iCol)));
			sbXml.append("</C_N>");
			sbXml.append("<C_T>" + aData.getColumnType(iCol) + "</C_T>");
			sbXml.append("<C_T_N>");
			//sbXml.append(CITCommon.isNull(aData.getColumnTypeName(iCol)) ? XML_NULL : aData.getColumnTypeName(iCol));
			sbXml.append(CITCommon.isNull(aData.getColumnTypeName(iCol)) ? XML_NULL : CITCommon.enSC(aData.getColumnTypeName(iCol)));
			sbXml.append("</C_T_N>");			
			sbXml.append("<PR>" + aData.getPrecision(iCol) + "</PR>");
			sbXml.append("<SS>" + aData.getScale(iCol) + "</SS>");
			sbXml.append("<S_N>");
			//sbXml.append(CITCommon.isNull(aData.getSchemaName(iCol)) ? XML_NULL : aData.getSchemaName(iCol));
			sbXml.append(CITCommon.isNull(aData.getSchemaName(iCol)) ? XML_NULL : CITCommon.enSC(aData.getSchemaName(iCol)));
			sbXml.append("</S_N>");
			sbXml.append("<T_N>");
			//sbXml.append(CITCommon.isNull(aData.getTableName(iCol)) ? XML_NULL : aData.getTableName(iCol));
			sbXml.append(CITCommon.isNull(aData.getTableName(iCol)) ? XML_NULL : CITCommon.enSC(aData.getTableName(iCol)));
			sbXml.append("</T_N>");
			sbXml.append("<IS_N>" + aData.isNullable(iCol) + "</IS_N>");
			sbXml.append("<O_P>");
			sbXml.append(aData.isOutParameter(iCol) ? "1" : "0");
			sbXml.append("</O_P>");
			
			sbXml.append("</C>");
		}
		
		sbXml.append("</C_I>");
		
		sbXml.append("<M_D>");
		
		for (iRow = 0; iRow < aData.getRowsCount(); iRow++)
		{
			sbXml.append("<D_R>");
			
			for (iCol = 0; iCol < aData.getColsCount(); iCol++)
			{
				sbXml.append("<" + aData.getColumnName(iCol) + ">");
				//sbXml.append(CITCommon.isNull(aData.getValue(iRow, iCol)) ? XML_NULL : aData.getValue(iRow, iCol));
				sbXml.append(CITCommon.isNull(aData.getValue(iRow, iCol)) ? XML_NULL : CITCommon.enSC(aData.toString(iRow, iCol)));
				sbXml.append("</" + aData.getColumnName(iCol) + ">");
			}
			
			sbXml.append("</D_R>");
		}
		
		sbXml.append("</M_D>");
		
		sbXml.append("<CLASS_INFO>");
		sbXml.append("<ERROR>");
		sbXml.append(aData.isError() ? "1" : "0");
		sbXml.append("</ERROR>");
		sbXml.append("<ERROR_MESSAGE>");
		//sbXml.append(CITCommon.isNull(aData.getErrorMessage()) ? XML_NULL : aData.getErrorMessage());
		sbXml.append(CITCommon.isNull(aData.getErrorMessage()) ? XML_NULL : CITCommon.enSC(aData.getErrorMessage()));
		sbXml.append("</ERROR_MESSAGE>");
		sbXml.append("<REQUEST_HANDLE>");
		sbXml.append(aData.getRequestHandle());
		sbXml.append("</REQUEST_HANDLE>");
		sbXml.append("<MESSAGE_TYPE>");
		sbXml.append(aData.getMessageType());
		sbXml.append("</MESSAGE_TYPE>");
		sbXml.append("<WAIT_TIME>");
		sbXml.append(aData.getWaitTime());
		sbXml.append("</WAIT_TIME>");
		sbXml.append("<SERVICE_NAME>");
		//sbXml.append(CITCommon.isNull(aData.getServiceName()) ? XML_NULL : aData.getServiceName());
		sbXml.append(CITCommon.isNull(aData.getServiceName()) ? XML_NULL : CITCommon.enSC(aData.getServiceName()));
		sbXml.append("</SERVICE_NAME>");
		sbXml.append("<METHOD_NAME>");
		//sbXml.append(CITCommon.isNull(aData.getMethodName()) ? XML_NULL : aData.getMethodName());
		sbXml.append(CITCommon.isNull(aData.getMethodName()) ? XML_NULL : CITCommon.enSC(aData.getMethodName()));
		sbXml.append("</METHOD_NAME>");
		sbXml.append("</CLASS_INFO>");
		
		sbXml.append("</CITDATA>");
		
		return sbXml.toString();
	}
	
	// CITData 클래스의 정보를 XML로 변환
	public static String CITData2XML_CR(CITData aData) throws Exception
	{
		StringBuffer sbXml = new StringBuffer();
		int iRow = 0;
		int iCol = 0;
		
		if (aData == null) throw new Exception ("CITXml CITData2XML Error : CITData가 널(null)입니다");
		
		sbXml.append("<?xml version='1.0' encoding='euc-kr'?>\n");
		sbXml.append("<CITDATA>\n");
		
		sbXml.append("\t<C_I>\n");
		
		for (iCol = 0; iCol < aData.getColsCount(); iCol++)
		{
			sbXml.append("\t\t<C>\n");
			
			sbXml.append("\t\t\t<C_D_S>" + aData.getColumnDisplaySize(iCol) + "</C_D_S>\n");
			sbXml.append("\t\t\t<C_N>");
			//sbXml.append(CITCommon.isNull(aData.getColumnName(iCol)) ? XML_NULL : aData.getColumnName(iCol));
			sbXml.append(CITCommon.isNull(aData.getColumnName(iCol)) ? XML_NULL : CITCommon.enSC(aData.getColumnName(iCol)));
			sbXml.append("</C_N>\n");
			sbXml.append("\t\t\t<C_T>" + aData.getColumnType(iCol) + "</C_T>\n");
			sbXml.append("\t\t\t<C_T_N>");
			//sbXml.append(CITCommon.isNull(aData.getColumnTypeName(iCol)) ? XML_NULL : aData.getColumnTypeName(iCol));
			sbXml.append(CITCommon.isNull(aData.getColumnTypeName(iCol)) ? XML_NULL : CITCommon.enSC(aData.getColumnTypeName(iCol)));
			sbXml.append("</C_T_N>\n");			
			sbXml.append("\t\t\t<PR>" + aData.getPrecision(iCol) + "</PR>\n");
			sbXml.append("\t\t\t<SS>" + aData.getScale(iCol) + "</SS>\n");
			sbXml.append("\t\t\t<S_N>");
			//sbXml.append(CITCommon.isNull(aData.getSchemaName(iCol)) ? XML_NULL : aData.getSchemaName(iCol));
			sbXml.append(CITCommon.isNull(aData.getSchemaName(iCol)) ? XML_NULL : CITCommon.enSC(aData.getSchemaName(iCol)));
			sbXml.append("</S_N>\n");
			sbXml.append("\t\t\t<T_N>");
			//sbXml.append(CITCommon.isNull(aData.getTableName(iCol)) ? XML_NULL : aData.getTableName(iCol));
			sbXml.append(CITCommon.isNull(aData.getTableName(iCol)) ? XML_NULL : CITCommon.enSC(aData.getTableName(iCol)));
			sbXml.append("</T_N>\n");
			sbXml.append("\t\t\t<IS_N>" + aData.isNullable(iCol) + "</IS_N>\n");
			sbXml.append("\t\t\t<O_P>");
			sbXml.append(aData.isOutParameter(iCol) ? "1" : "0");
			sbXml.append("</O_P>\n");
			
			sbXml.append("\t\t</C>\n");
		}
		
		sbXml.append("\t</C_I>\n");
		
		sbXml.append("\t<M_D>\n");
		
		for (iRow = 0; iRow < aData.getRowsCount(); iRow++)
		{
			sbXml.append("\t\t<D_R>\n");
			
			for (iCol = 0; iCol < aData.getColsCount(); iCol++)
			{
				sbXml.append("\t\t\t<" + aData.getColumnName(iCol) + ">");
				//sbXml.append(CITCommon.isNull(aData.getValue(iRow, iCol)) ? XML_NULL : aData.getValue(iRow, iCol));
				sbXml.append(CITCommon.isNull(aData.getValue(iRow, iCol)) ? XML_NULL : CITCommon.enSC(aData.toString(iRow, iCol)));
				sbXml.append("</" + aData.getColumnName(iCol) + ">\n");
			}
			
			sbXml.append("\t\t</D_R>\n");
		}
		
		sbXml.append("\t</M_D>\n");
		
		sbXml.append("\t<CLASS_INFO>\n");
		sbXml.append("\t\t<ERROR>");
		sbXml.append(aData.isError() ? "1" : "0");
		sbXml.append("</ERROR>\n");
		sbXml.append("\t\t<ERROR_MESSAGE>");
		//sbXml.append(CITCommon.isNull(aData.getErrorMessage()) ? XML_NULL : aData.getErrorMessage());
		sbXml.append(CITCommon.isNull(aData.getErrorMessage()) ? XML_NULL : CITCommon.enSC(aData.getErrorMessage()));
		sbXml.append("</ERROR_MESSAGE>\n");
		sbXml.append("\t\t<REQUEST_HANDLE>");
		sbXml.append(aData.getRequestHandle());
		sbXml.append("</REQUEST_HANDLE>\n");
		sbXml.append("\t\t<MESSAGE_TYPE>");
		sbXml.append(aData.getMessageType());
		sbXml.append("</MESSAGE_TYPE>\n");
		sbXml.append("\t\t<WAIT_TIME>");
		sbXml.append(aData.getWaitTime());
		sbXml.append("</WAIT_TIME>\n");
		sbXml.append("\t\t<SERVICE_NAME>");
		//sbXml.append(CITCommon.isNull(aData.getServiceName()) ? XML_NULL : aData.getServiceName());
		sbXml.append(CITCommon.isNull(aData.getServiceName()) ? XML_NULL : CITCommon.enSC(aData.getServiceName()));
		sbXml.append("</SERVICE_NAME>\n");
		sbXml.append("\t\t<METHOD_NAME>");
		//sbXml.append(CITCommon.isNull(aData.getMethodName()) ? XML_NULL : aData.getMethodName());
		sbXml.append(CITCommon.isNull(aData.getMethodName()) ? XML_NULL : CITCommon.enSC(aData.getMethodName()));
		sbXml.append("</METHOD_NAME>\n");
		sbXml.append("\t</CLASS_INFO>\n");
		
		sbXml.append("</CITDATA>\n");
		
		return sbXml.toString();
	}
	
	// CITData 클래스의 정보를 담고있는 XML을 CITData 클래스로 변환
	public static CITData XML2CITData(String asXML) throws Exception
	{
		if (asXML == null || asXML.trim().equals("")) throw new Exception ("CITXml XML2CITData Error : XML 문자열이 널(null)입니다");
		
		CITData lrData = new CITData();
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = factory.newDocumentBuilder();
		Document Doc = docBuilder.parse(new ByteArrayInputStream(asXML.getBytes()));
		
		NodeList nlGroupList = Doc.getElementsByTagName("C");
		NodeList nlGroup = null;
		Node nField = null;
		String lsValue = null;
		
		int liColumnDisplaySize = -1;
		String lsColumnName = null;
		int liColumnType = -1;
		String lsColumnTypeName = null;
		int liPrecision = -1;
		int liSScale = -1;
		String lsSchemaName = null;
		String lsTableName = null;
		int liNullable = -1;
		boolean lbOutParameter = false;
		
		for (int i = 0; i < nlGroupList.getLength(); i++)
		{
			nlGroup = nlGroupList.item(i).getChildNodes();
			
			for (int j = 0; j < nlGroup.getLength(); j++)
			{
				nField = nlGroup.item(j);
				
				if (Node.ELEMENT_NODE != nField.getNodeType()) continue;
				
				lsValue = nField.getFirstChild().getNodeValue();
				
				if (nField.getNodeName().equals("C_D_S"))
				{
					liColumnDisplaySize = Integer.parseInt(lsValue);
				}
				else if (nField.getNodeName().equals("C_N"))
				{
					//lsColumnName = isXmlNull(lsValue) ? null : lsValue;
					lsColumnName = isXmlNull(lsValue) ? null : CITCommon.deSC(lsValue);
				}
				else if (nField.getNodeName().equals("C_T"))
				{
					liColumnType = Integer.parseInt(lsValue);
				}
				else if (nField.getNodeName().equals("C_T_N"))
				{
					//lsColumnTypeName = isXmlNull(lsValue) ? null : lsValue;
					lsColumnTypeName = isXmlNull(lsValue) ? null : CITCommon.deSC(lsValue);
				}
				else if (nField.getNodeName().equals("PR"))
				{
					liPrecision = Integer.parseInt(lsValue);
				}
				else if (nField.getNodeName().equals("SS"))
				{
					liSScale = Integer.parseInt(lsValue);
				}
				else if (nField.getNodeName().equals("S_N"))
				{
					//lsSchemaName = isXmlNull(lsValue) ? null : lsValue;
					lsSchemaName = isXmlNull(lsValue) ? null : CITCommon.deSC(lsValue);
				}
				else if (nField.getNodeName().equals("T_N"))
				{
					//lsTableName = isXmlNull(lsValue) ? null : lsValue;
					lsTableName = isXmlNull(lsValue) ? null : CITCommon.deSC(lsValue);
				}
				else if (nField.getNodeName().equals("IS_N"))
				{
					liNullable = Integer.parseInt(lsValue);
				}
				else if (nField.getNodeName().equals("O_P"))
				{
					lbOutParameter = Integer.parseInt(lsValue) == 1 ? true : false;
				}
			}
			
			lrData.addColumn(liColumnDisplaySize, lsColumnName, liColumnType, lsColumnTypeName, liPrecision, liSScale, lsSchemaName, lsTableName, liNullable, lbOutParameter);
		}

		nlGroupList = Doc.getElementsByTagName("D_R");
		
		for (int i = 0; i < nlGroupList.getLength(); i++)
		{
			lrData.addRow();
			nlGroup = nlGroupList.item(i).getChildNodes();
			
			for (int j = 0; j < nlGroup.getLength(); j++)
			{
				nField = nlGroup.item(j);
				
				if (Node.ELEMENT_NODE != nField.getNodeType()) continue;
				
				lsValue = isXmlNull(nField.getFirstChild().getNodeValue()) ? "" : nField.getFirstChild().getNodeValue();
				//lrData.setValue(nField.getNodeName(), lsValue);
				lrData.setValue(nField.getNodeName(), CITCommon.deSC(lsValue));
			}
		}
		
		nlGroupList = Doc.getElementsByTagName("CLASS_INFO");		
		nlGroup = nlGroupList.item(0).getChildNodes();
		
		for (int i = 0; i < nlGroup.getLength(); i++)
		{
			nField = nlGroup.item(i);
				
			if (Node.ELEMENT_NODE != nField.getNodeType()) continue;
			
			lsValue = nField.getFirstChild().getNodeValue();
			
			if (nField.getNodeName().equals("ERROR"))
			{
				lrData.setError(lsValue.equals("1") ? true : false);
			}
			else if (nField.getNodeName().equals("ERROR_MESSAGE"))
			{
				//lrData.setErrorMessage(isXmlNull(lsValue) ? null : lsValue);
				lrData.setErrorMessage(isXmlNull(lsValue) ? null : CITCommon.deSC(lsValue));
			}
			else if (nField.getNodeName().equals("REQUEST_HANDLE"))
			{
				lrData.setRequestHandle(Long.parseLong(lsValue));
			}
			else if (nField.getNodeName().equals("MESSAGE_TYPE"))
			{
				lrData.setMessageType(Integer.parseInt(lsValue));
			}
			else if (nField.getNodeName().equals("WAIT_TIME"))
			{
				lrData.setWaitTime(Long.parseLong(lsValue));
			}
			else if (nField.getNodeName().equals("SERVICE_NAME"))
			{
				//lrData.setServiceName(isXmlNull(lsValue) ? null : lsValue);
				lrData.setServiceName(isXmlNull(lsValue) ? null : CITCommon.deSC(lsValue));
			}
			else if (nField.getNodeName().equals("METHOD_NAME"))
			{
				//lrData.setMethodName(isXmlNull(lsValue) ? null : lsValue);
				lrData.setMethodName(isXmlNull(lsValue) ? null : CITCommon.deSC(lsValue));
			}
		}

		return lrData;
	}
	
	// XML 노드(Node) 값의 널(Null) 여부
	public static boolean isXmlNull(String asValue)
	{
		return asValue != null && asValue.toString().equals(XML_NULL) ? true : false;
	}
}