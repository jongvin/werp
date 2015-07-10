package com.cj.common;

import java.io.*;
import java.net.*;
import java.text.*;
import java.math.*;
import java.util.*;
import javax.servlet.http.*;

import com.gauce.*;
import com.gauce.common.*;
import com.gauce.io.*;
import com.gauce.db.*;
import com.gauce.log.*;

import com.cj.database.*;
import com.cj.util.*;

public class CITCommon
{
	public static final String CONFIG_FILE = "server.conf";
	public static final String SYSTEM_NAME = "cj";
	protected static boolean isSetSystemProperty = false;
	
	private static final String [] SourceStrings = {"&", "<", ">", "'", "\"", "\\\\"};
	private static final String [] ConvertStrings = {"&amp;", "&lt;", "&gt;", "&apos;", "&quot;", "&won;"};
	private static final String FILE_SEPARATOR = "\\";
	
	public static void main(String[] args) throws Exception
	{
		/*
		System.out.println(CITDate.getDate());
		System.out.println(CITDate.getDate("yyyy.MM.dd"));
		System.out.println(CITDate.getDate("yyyy/MM/dd"));
		
		Object object = "123";
		Integer integer = new Integer("456");
		String string = null;
		
		System.out.println(CITCommon.toInt(object));
		System.out.println(CITCommon.toInt(integer));
		System.out.println(CITCommon.toInt(string));
		
		System.out.println(CITCommon.toFormat("1234567890", "$#,##0.00"));
		System.out.println(CITCommon.toFormat("1234567890.145", "\\#,##0.00"));
		
		Object [] oTemp = readFile(CONFIG_FILE);
		
		for (int i = 0; i < oTemp.length; i++)
		{
			System.out.println(oTemp[i]);
		}
		
		CITCommon.createTempFile("C:\\DBHM\\Temp", "txt");
		
		System.out.println(CITCommon.toStringFM("7309201067128", "xxxxxx-xxxxxxx"));
		
		String lsTemp = "12������234����";
		System.out.println(CITCommon.substringB(lsTemp, 2, 10));
		
		setSystemProperty();
		CITData lrData = getAllSystemProperty();
		
		for (int i = 0; i < lrData.getRowsCount(); i++)
		{
			System.out.println(lrData.toString(i, "KEY") + " : " + lrData.toString(i, "VALUE"));
		}
		*/
	}
	
	// ������ �ʱ�ȭ
	public static void initPage(HttpServletRequest aRequest, HttpServletResponse aResponse, HttpSession aSession) throws Exception
	{
		initPage(aRequest, aResponse, aSession, true);
	}
	
	public static void initPage(HttpServletRequest aRequest, HttpServletResponse aResponse, HttpSession aSession, boolean isCheck) throws Exception
	{
		try
		{
			if (aRequest.getProtocol().equals("HTTP/1.1"))
			{
				aResponse.setHeader("Cache-Control", "no-cache, post-check=0, pre-check=0");
			}
			
			aResponse.setHeader("Pragma", "no-cache");
			aResponse.setHeader("Expires", "0");
			
			aRequest.setCharacterEncoding("EUC-KR");
			
			if (isCheck)
			{
				//if (aSession == null || aSession.getAttribute("user_no") == null) throw new Exception ("������ �� �����ϴ�. �ٽ� �α��� �Ͻʽÿ�.");
				
				/* 2005-10-25 ���� CJ���� ������
				if (aRequest.getParameter("M_CHK") != null && aRequest.getParameter("M_CHK").equals("Y"))
				{
					if (isNull(aRequest.getParameter("MENU_ID"))) throw new Exception ("MENU_ID ��(��) �������� �ʽ��ϴ�.");
					
					CITData lrArgData = new CITData();
					CITData lrReturnData = null;
					String strSql = "";
				
					strSql += " Select USER_NO, ";
					strSql += "        MENU_ID, ";
					strSql += "        MENU_LEVEL ";
					strSql += " From   TCC_USER_MENU_LEVEL ";
					strSql += " Where  USER_NO = ? ";
					strSql += "  And   MENU_ID = ? ";
					
					lrArgData.addColumn("USER_NO", CITData.NUMBER);
					lrArgData.addColumn("MENU_ID", CITData.NUMBER);
					lrArgData.addRow();
					lrArgData.setValue("USER_NO", aSession.getAttribute("user_no"));
					lrArgData.setValue("MENU_ID", aRequest.getParameter("MENU_ID"));
				
					lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
					
					if (lrReturnData.getRowsCount() > 0)
					{
						aSession.setAttribute("menu_level", lrReturnData.toString(0, "MENU_LEVEL"));
					}
					else
					{
						aSession.setAttribute("menu_level", "");
					}
					
					if (lrReturnData.getRowsCount() > 0 && lrReturnData.toString(0, "MENU_LEVEL").equals("NN"))
					{
						throw new Exception("�� ����ڴ� �ش� �޴��� ������ ������ �����ϴ�.");
					}
				}
				*/
			}
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon initPage Error : " + ex.getMessage());
		}
	}
	
	// ������(���콺) �ʱ�ȭ
	public static CITGauceInfo initServerPage(HttpServletRequest aRequest, HttpServletResponse aResponse, HttpSession aSession) throws Exception
	{
		return initServerPage(aRequest, aResponse, aSession, true);
	}
	
	public static CITGauceInfo initServerPage(HttpServletRequest aRequest, HttpServletResponse aResponse, HttpSession aSession, boolean isCheck) throws Exception
	{
		try
		{
			initPage(aRequest, aResponse, aSession, isCheck);
			
			// ���콺 ���̼��� üũ
			//LicenseChecker.check();
			
			return new CITGauceInfo(aRequest, aResponse);
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon initServerPage Error : " + ex.getMessage());
		}
	}
	
	// ������ ����
	public static void finalPage() throws Exception
	{
		try
		{
			// ������ ���� �߰�
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon finalPage Error : " + ex.getMessage());
		}
	}
	
	// ������(���콺) ����
	public static void finalServerPage(CITGauceInfo aGauceInfo) throws Exception
	{
		try
		{
			finalPage();
			
			if (aGauceInfo == null) return;
			
			aGauceInfo.response.flush();
			aGauceInfo.response.commit();
			aGauceInfo.response.close();
			
			/* 2004-11-23  ���� ��� ����
			if (aGauceInfo.connection != null) 
			{
				try 
				{
					aGauceInfo.connection.close();
				}
				catch (Exception ex)
				{
				}
			}
			*/
			
			aGauceInfo.loader.restoreService(aGauceInfo.service);
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon finalServerPage Error : " + ex.getMessage());
		}
	}
	
	// CITData�� GauceDataSet�� ��ȯ
	public static GauceDataSet toGauceDataSet(CITData aData) throws Exception
	{
		return toGauceDataSet(aData, null);
	}
	
	// CITData�� GauceDataSet�� ��ȯ
	public static GauceDataSet toGauceDataSet(CITData aData, String asDataSetName) throws Exception
	{
		GauceDataSet lrDataSet = null;
		
		if (isNull(asDataSetName))
		{
			lrDataSet = new GauceDataSet();
		}
		else
		{
			lrDataSet = new GauceDataSet(asDataSetName);
		}
		
		String sColName = null;
		int iColType = -1;
		int iColSize = -1;
		int iColDec = -1;
		int iKeyType = -1;
		
		if (aData == null) throw new Exception ("CITCommon toGauceDataSet Error : CITData�� ��(null)�Դϴ�");
		
		try
		{
			int		liColCounts = aData.getColsCount();
			for(int i = 0; i < liColCounts ; i++)
			{
				sColName = aData.getColumnName(i);
				
				if (aData.isKey(i))
				{
					iKeyType = GauceDataColumn.TB_KEY;
				}
				else
				{
					iKeyType = aData.isNullable(i) == 1 ? GauceDataColumn.TB_NORMAL : GauceDataColumn.TB_NOTNULL;
				}
				
				switch (aData.getColumnType(i))
				{
					case CITData.VARCHAR2 :
						iColType = GauceDataColumn.TB_STRING;
						iColSize = aData.getColumnDisplaySize(i) < 0 ? 4000 : aData.getColumnDisplaySize(i);
						iColDec = 0;
						break;
					case CITData.DATE :
					case CITData.DATETIME :
						iColType = GauceDataColumn.TB_STRING;
						iColSize = 19;
						iColDec = 0;
						break;
					case CITData.NUMBER :
						iColType = GauceDataColumn.TB_DECIMAL;
						iColSize = aData.getColumnDisplaySize(i) < 0 ? 38 : aData.getColumnDisplaySize(i);
						iColDec = aData.getScale(i) < 0 ? 0 : aData.getScale(i);
						break;
					case CITData.LONG :
						iColType = GauceDataColumn.TB_STRING;
						//iColSize = aData.getPrecision(i) < 0 ? 0 : aData.getPrecision(i);
						iColSize = 10000;
						iColDec = 0;
						break;
					case CITData.LONG_RAW :
						iColType = GauceDataColumn.TB_BLOB;
						iColSize = aData.getPrecision(i) < 0 ? 0 : aData.getPrecision(i);
						iColDec = 0;
						break;
					default :
						iColType = GauceDataColumn.TB_STRING;
						iColSize = aData.getColumnDisplaySize(i) < 0 ? 4000 : aData.getColumnDisplaySize(i);
						iColDec = 0;
						break;
				}
				
				lrDataSet.addDataColumn(new GauceDataColumn(sColName, iColType, iColSize, iColDec, iKeyType));
			}
			
			for(int i = 0; i < aData.getRowsCount(); i++)
			{
				GauceDataRow row = lrDataSet.newDataRow();

				for(int j = 0; j < aData.getColsCount(); j++)
				{
					switch (aData.getColumnType(j))
					{
						case CITData.VARCHAR2 :
						case CITData.DATE :
						case CITData.DATETIME :
						case CITData.LONG :
							row.setString(j, aData.toString(i, j));
							break;
						case CITData.NUMBER :
							if (isNull(aData.toString(i, j)))
							{
								row.setDouble(j, 0);
							}
							else
							{
								row.setDouble(j, Double.parseDouble(aData.toString(i, j)));
							}
							break;
						case CITData.LONG_RAW :
							row.setInputStream(j, (InputStream)aData.getValue(i, j));
							break;
						default :
							row.setString(j, aData.toString(i, j));
							break;
					}
				}

				lrDataSet.addDataRow(row);
			}
			
			return lrDataSet;
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon toGauceDataSet Error : " + ex.getMessage());
		}
	}
	
	// GauceDataSet�� CITData�� ��ȯ
	public static CITData toCITData(GauceDataSet aDataSet) throws Exception
	{
		CITData lrData = new CITData();
		String sColName = null;
		int iColType = -1;
		int iColSize = -1;
		int iColDec = -1;
		int iNull = -1;
		boolean bKeyType = false;
		
		if (aDataSet == null) throw new Exception ("CITCommon toCITData Error : GauceDataSet�� ��(null)�Դϴ�");
		
		try
		{
			for(int i = 0; i < aDataSet.getDataColCnt(); i++)
			{
				sColName = aDataSet.getDataColumn(i).getColName();
				iColSize = aDataSet.getDataColumn(i).getSize();
				iColDec = aDataSet.getDataColumn(i).getDec();
				
				if (aDataSet.getDataColumn(i).getKeyType() == GauceDataColumn.TB_KEY)
				{
					iNull = 0;
					bKeyType = true;
				}
				else if (aDataSet.getDataColumn(i).getKeyType() == GauceDataColumn.TB_NOTNULL)
				{
					iNull = 0;
					bKeyType = false;
				}
				else
				{
					iNull = 1;
					bKeyType = false;
				}
				
				switch (aDataSet.getDataColumn(i).getColType())
				{
					case GauceDataColumn.TB_STRING :
						iColType = CITData.VARCHAR2;
						break;
					case GauceDataColumn.TB_NUMBER :
					case GauceDataColumn.TB_DECIMAL :
						iColType = CITData.NUMBER;
						break;
					case GauceDataColumn.TB_BLOB :
						iColType = CITData.LONG_RAW;
						break;
					default :
						iColType = CITData.VARCHAR2;
						break;
				}
				
				lrData.addColumn(iColSize, sColName, iColType, null, -1, iColDec, null, null, iNull, false, bKeyType);
			}
			
			for(int i = 0; i < aDataSet.getDataRowCnt(); i++)
			{
				lrData.addRow();
				
				for(int j = 0; j < aDataSet.getDataColCnt(); j++)
				{
					lrData.setValue(j, aDataSet.getDataRow(i).getColumnValue(j));
				}
			}
			
			return lrData;
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon toCITData Error : " + ex.getMessage());
		}
	}
	
	// �ش� ������Ƽ�� ���� �����ش�
	public static String getProperty(String asPropertyName) throws Exception
	{
		return getProperty(asPropertyName, null);
	}
	
	public static String getProperty(String asPropertyName, String asDefaultValue) throws Exception
	{
		if (isNull(asPropertyName)) throw new Exception ("CITCommon getProperty Error : ������Ƽ�� Ű�� ��(Null)�Դϴ�");
		
		try
		{
			/* 2005-10-25 ���� CJ���� ������
			if (!isSetSystemProperty)
			{
				setSystemProperty();
				isSetSystemProperty = true;
			}
			*/
			return System.getProperty(SYSTEM_NAME + "." + asPropertyName.toLowerCase(), asDefaultValue);
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon getProperty Error : " + ex.getMessage());
		}
	}
	
	// �ش� ������Ƽ�� ���� �����Ѵ�
	public static String setProperty(String asPropertyName, String asValue) throws Exception
	{
		if (isNull(asPropertyName)) throw new Exception ("CITCommon setProperty Error : ������Ƽ�� Ű�� ��(Null)�Դϴ�");
		if (isNull(asValue)) throw new Exception ("CITCommon setProperty Error : ������Ƽ�� ���� ��(Null)�Դϴ�");
		
		try
		{
			return System.setProperty(SYSTEM_NAME + "." + asPropertyName.toLowerCase(), asValue);
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon setProperty Error : " + ex.getMessage());
		}
	}
	
	// �ش� ������Ƽ�� �����ϴ��� ����
	public static boolean existsProperty(String asPropertyName) throws Exception
	{
		if (isNull(asPropertyName)) throw new Exception ("CITCommon existsProperty Error : ������Ƽ�� Ű�� ��(Null)�Դϴ�");
		
		try
		{
			String lsData = getProperty(asPropertyName.toLowerCase(), null);
			
			if (lsData == null) return false;
			
			return true;
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon existsProperty Error : " + ex.getMessage());
		}
	}
	
	// �ý��� ������Ƽ�� CITData�� �����ش�
	public static CITData getSystemProperty() throws Exception
	{
		try
		{
			Enumeration emNames = System.getProperties().propertyNames();
			Object [] loName = new Object[System.getProperties().size()];
			CITData lrData = new CITData();
			int liIndex = 0;
			String lsKey = null;
			
			while (emNames.hasMoreElements())
			{
				loName[liIndex] = emNames.nextElement().toString();
				liIndex++;
			}
			
			Arrays.sort(loName);
			
			lrData.addColumn("KEY", CITData.VARCHAR2);
			lrData.addColumn("VALUE", CITData.VARCHAR2);
			
			for (int i = 0; i < loName.length; i++)
			{
				lsKey = loName[i].toString();
				
				if (lsKey.length() < (SYSTEM_NAME.length()) || !lsKey.substring(0, SYSTEM_NAME.length()).equals(SYSTEM_NAME)) continue;
				
				lrData.addRow();
				lrData.setValue("KEY", loName[i]);
				lrData.setValue("VALUE", System.getProperty(loName[i].toString(), ""));
			}
			
			return lrData;
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon getSystemProperty Error : " + ex.getMessage());
		}
	}
	
	// ��ü �ý��� ������Ƽ�� CITData�� �����ش�
	public static CITData getAllSystemProperty() throws Exception
	{
		try
		{
			Enumeration emNames = System.getProperties().propertyNames();
			Object [] loName = new Object[System.getProperties().size()];
			CITData lrData = new CITData();
			int liIndex = 0;
			String lsKey = null;
			
			while (emNames.hasMoreElements())
			{
				loName[liIndex] = emNames.nextElement().toString();
				liIndex++;
			}
			
			Arrays.sort(loName);
			
			lrData.addColumn("KEY", CITData.VARCHAR2);
			lrData.addColumn("VALUE", CITData.VARCHAR2);
			
			for (int i = 0; i < loName.length; i++)
			{
				lsKey = loName[i].toString();
				
				lrData.addRow();
				lrData.setValue("KEY", loName[i]);
				lrData.setValue("VALUE", System.getProperty(loName[i].toString(), ""));
			}
			
			return lrData;
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon getSystemProperty Error : " + ex.getMessage());
		}
	}
	
	// �ý��� ������Ƽ ����
	public static void setSystemProperty() throws Exception
	{
		Enumeration emNames = null;
		Object [] loProperty = null;
		String [] lsTemp = null;
		String lsKey = null;
		String lsValue = null;
		
		try
		{
			loProperty = readFile(System.getProperty("user.dir", "") + FILE_SEPARATOR + CONFIG_FILE);
			emNames = System.getProperties().propertyNames();
					
			while (emNames.hasMoreElements())
			{
				lsKey = emNames.nextElement().toString();
				
				if (lsKey.length() > (SYSTEM_NAME.length() - 1) && lsKey.substring(0, SYSTEM_NAME.length()).equals(SYSTEM_NAME))
				{
					System.getProperties().remove(lsKey);
				}
			}
			
			for (int i = 0; i < loProperty.length; i++)
			{
				if (loProperty[i].toString().trim().substring(0, 1).equals("#") || loProperty[i].toString().indexOf("=") < 0) continue;
				
				lsTemp = loProperty[i].toString().split("=");
				
				if (lsTemp.length < 1) continue;
				lsKey = SYSTEM_NAME + "." + lsTemp[0].toLowerCase();
				lsValue = lsTemp.length > 1 ? lsTemp[1] : "";
				
				System.setProperty(lsKey, lsValue);
			}
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon setSystemProperty Error : " + ex.getMessage());
		}
	}
	
	// Ư�� ������ ������ �о� �� ������ Object �迭�� �����ش�
	public static Object [] readFile(String asFileName) throws Exception
	{
		ArrayList alDataList = null;
		BufferedReader brList = null;
		String lsTemp = null;
		
		try
		{
			alDataList = new ArrayList();
			brList = new BufferedReader(new FileReader(asFileName));
			
			while (true)
			{
				lsTemp = brList.readLine();
				
				if (lsTemp == null) break;
				if (isNull(lsTemp)) continue;
				
				alDataList.add(lsTemp);
			}
			
			brList.close();
		}
		catch (FileNotFoundException fnfex)
		{
			throw new Exception (asFileName + " ������ �������� �ʽ��ϴ�");
		}
		catch (Exception ex)
		{
			throw new Exception (ex.getMessage());
		}
		
		return alDataList.toArray();
	}
	
	// Object �迭�� ���� �ش� ���ϸ����� �����Ͽ� �����ش�
	public static File writeFile(String asFileName, Object [] aoData) throws Exception
	{
		BufferedWriter bwList = null;
		
		try
		{
			bwList = new BufferedWriter(new FileWriter(asFileName));
			
			for (int i = 0; i < aoData.length; i++)
			{
				bwList.write(aoData[i].toString());
				bwList.newLine();
			}
			
			bwList.flush();
			bwList.close();
			
			return new File(asFileName);
		}
		catch (Exception ex)
		{
			throw new Exception (ex.getMessage());
		}
	}
	
	// �ش� ��η� Temp ������ ������ �� �����ش�(Ȯ���ڰ� Null�� ���� .tmp ���Ϸ� ����)
	public static File createTempFile(String asTempPath, String asSuffix) throws Exception
	{
		File lfFile = null;
		String lsSuffix = null;
		
		if (isNull(asTempPath)) throw new Exception ("CITCommon createTempFile Error : Temp ���丮 ��ΰ� �����ϴ�.");
		
		try
		{
			lfFile = new File(asTempPath);
			
			if (!lfFile.exists()) lfFile.mkdir();
			
			if (!isNull(asSuffix))
			{
				lsSuffix = "." + asSuffix.replaceAll("\\.", "");
			}
			
			return File.createTempFile(CITDate.getNow("yyyyMMdd") + "_", lsSuffix, lfFile);
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon createTempFile Error : " + ex.getMessage());
		}
	}
	
	// Null ���� üũ
	public static boolean isNull(Object aoValue)
	{
		return aoValue == null || aoValue.toString().trim().equals("") ? true : false;
	}

	// �ѱۺ�ȯ
	public static String toKOR(String asValue) throws Exception
	{
		return toKOR(asValue, "");
	}
	
	// �ѱۺ�ȯ
	public static String toKOR(String asValue, String asDefaultValue) throws Exception
	{
		if (isNull(asValue)) return asDefaultValue;
		
		try
		{
			//return new String(asValue.getBytes("8859_1"), "KSC5601");
			return asValue;
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon toKOR Error : " + ex.getMessage());
		}
	}
	
	// �ѱۺ�ȯ
	public static String toKOR2(String asValue) throws Exception
	{
		return toKOR2(asValue, "");
	}
	
	// �ѱۺ�ȯ
	public static String toKOR2(String asValue, String asDefaultValue) throws Exception
	{
		if (isNull(asValue)) return asDefaultValue;
		
		try
		{
			return new String(asValue.getBytes("8859_1"), "KSC5601");
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon toKOR2 Error : " + ex.getMessage());
		}
	}
	
	// UTF-8�� Encoding ��ȯ
	public static String URLEncoding(String asValue) throws Exception
	{
		if (isNull(asValue)) return "";
		
		try
		{
			return URLEncoder.encode(asValue, "UTF-8");
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon URLEncoding Error : " + ex.getMessage());
		}
	}
	
	// UTF-8�� Decoding ��ȯ
	public static String URLDecoding(String asValue) throws Exception
	{
		if (isNull(asValue)) return "";
		
		try
		{
			return URLDecoder.decode(asValue, "UTF-8");
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon URLDecoding Error : " + ex.getMessage());
		}
	}

	// Null�� ��� Empty�� ��ȯ
	public static String NvlString(String asString)
	{
		return NvlString(asString, "");
	}
	
	// Null�� ��� �Է��� ���ڷ� ��ȯ
	public static String NvlString(String asString, String asDefaultValue)
	{
		if(asString == null) return asDefaultValue;
		return asString;
	}
	
	// Null�� ��� Empty�� ��ȯ
	public static String NvlString(Object aoObject)
	{
		return NvlString(aoObject, "");
	}
	
	// Null�� ��� �Է��� ���ڷ� ��ȯ
	public static String NvlString(Object aoObject, String asDefaultValue)
	{
		if(aoObject == null) return asDefaultValue;
		return aoObject.toString();
	}
	
	// Object ���� int�� ��ȯ
	public static int toInt(Object aoValue) throws Exception
	{
		return toInt(aoValue.toString());
	}
	
	// Integer ���� int�� ��ȯ
	public static int toInt(Integer aiValue) throws Exception
	{
		return toInt(aiValue.toString());
	}
	
	// String ���� int�� ��ȯ
	public static int toInt(String asValue) throws Exception
	{
		try
		{
			return Integer.parseInt(asValue);
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon toInt Error : " + ex.getMessage());
		}
	}
	
	// ���� ���ڿ� ���� "#,###" �������� ����
	public static String toFormat(String asValue) throws Exception
	{
		return toFormat(asValue, "#,##0");
	}
	
	// ���� ���ڿ� ���� �ش� �������� ����
	public static String toFormat(String asValue, String asFormat) throws Exception
	{
		if (isNull(asValue)) return "";
		
		try
		{
			DecimalFormat df = new DecimalFormat(asFormat);
			
			if (asFormat.indexOf(".") > -1)
			{
				BigDecimal bd = new BigDecimal(asValue);
				bd.setScale(asFormat.length() - asFormat.indexOf(".") - 1, BigDecimal.ROUND_HALF_UP);
				return df.format(bd.doubleValue());
			}
			else
			{
				return df.format(Double.parseDouble(asValue));
			}
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon toFormat Error : " + ex.getMessage());
		}
	}
	
	// ���ڿ� ���� �ش� �������� ����(������ �и��ڴ� '-' �� ���)
	public static String toStringFM(String asValue, String asFormat) throws Exception
	{
		String lsData = null;
		int liPos = -1;
		
		if (isNull(asValue) || isNull(asFormat)) return asValue;

		try
		{
			lsData = asValue.replaceAll("-", "");
		
			if (lsData.length() != asFormat.replaceAll("-", "").length()) return asValue;
		
			while (true)
			{
				liPos = asFormat.indexOf("-", liPos + 1);
		
				if (liPos < 1) break;
				
				lsData = lsData.substring(0, liPos) + "-" + lsData.substring(liPos);
			}
			
			return lsData;
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon toStringFM Error : " + ex.getMessage());
		}
	}
	
	// ���ڿ� ���� �ش� ���̷� �߶󳽴�(��ġ�� �ڸ���, ���ڶ�� �ش� ���ڷ� ä���)
	public static String substringB(String asValue, int aiCount) throws Exception
	{
		return substringB(asValue, 0, aiCount);
	}
	
	// ���ڿ� ���� �ش� ���̷� �߶󳽴�(��ġ�� �ڸ���, ���ڶ�� �ش� ���ڷ� ä���)
	public static String substringB(String asValue, int aiStart, int aiCount) throws Exception
	{
		return substringB(asValue, aiStart, aiCount, ' ');
	}
	
	// ���ڿ� ���� �ش� ���̷� �߶󳽴�(��ġ�� �ڸ���, ���ڶ�� �ش� ���ڷ� ä���)
	public static String substringB(String asValue, int aiStart, int aiCount, char acFillChar) throws Exception
	{
		if (isNull(asValue)) asValue = "";
		if (aiStart < 0) throw new Exception ("CITCommon SubStringB Error : ������ġ�� ���� 0 ���� �۽��ϴ�");
		if (aiCount < 0) throw new Exception ("CITCommon SubStringB Error : Count�� ���� 0 ���� �۽��ϴ�");
		
		byte [] lbTemp = null;
		byte [] lbData = new byte[aiCount];
		int liCount = 0;
		
		try
		{
			lbTemp = asValue.getBytes("KSC5601");
			
			liCount = (aiStart + aiCount) > lbTemp.length ? lbTemp.length : aiStart + aiCount;
			
			for (int i = aiStart; i < liCount; i++)
			{
				lbData[i - aiStart] = lbTemp[i];
			}

			for (int i = lbTemp.length - aiStart; i < aiCount; i++)
			{
				lbData[i] = Byte.parseByte(new Integer(new Character(acFillChar).hashCode()).toString());
			}
			
			return new String(lbData, "KSC5601");
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon SubStringB Error : " + ex.getMessage());
		}
	}
	
	// ���ڿ��� ���̺��� �Է��� ���̰� ū ��� Ư�� ���ڸ� �������� ä���
	public static String LPad(String asValue, int aiLength, char acPadChar) throws Exception
	{
		if (asValue == null || aiLength <= asValue.getBytes("KSC5601").length) return asValue;
		
		byte [] lbTemp = asValue.getBytes("KSC5601");
		byte [] lbData = new byte[aiLength];
		byte lbPadChar = Character.toString(acPadChar).getBytes()[0];
		int liAddCnt = aiLength - lbTemp.length;
		
		for (int i = 0; i < liAddCnt; i++)
		{
			lbData[i] = lbPadChar;
		}
		
		for (int i = 0; i < lbTemp.length; i++)
		{
			lbData[i + liAddCnt] = lbTemp[i];
		}
		
		return new String(lbData);
	}
	
	// ���ڿ��� ���̺��� �Է��� ���̰� ū ��� Ư�� ���ڸ� �������� ä���
	public static String RPad(String asValue, int aiLength, char acPadChar) throws Exception
	{
		if (asValue == null || aiLength <= asValue.getBytes("KSC5601").length) return asValue;
		
		byte [] lbTemp = asValue.getBytes("KSC5601");
		byte [] lbData = new byte[aiLength];
		byte lbPadChar = Character.toString(acPadChar).getBytes()[0];
		int liAddCnt = aiLength - lbTemp.length;
		
		for (int i = 0; i < lbTemp.length; i++)
		{
			lbData[i] = lbTemp[i];
		}
		
		for (int i = 0; i < liAddCnt; i++)
		{
			lbData[lbTemp.length + i] = lbPadChar;
		}
		
		return new String(lbData);
	}
	
	// ���ڿ��� ���̸� ���Ѵ�(�ѱ��� 2���ڷ� �ν�)
	public static int lengthB(String asValue) throws Exception
	{
		if (asValue == null) return 0;
		
		return asValue.getBytes("KSC5601").length;
	}
	
	public static String enSC(String asValue) throws Exception
	{
		return renderSpecialChars(asValue);
	}
	
	public static String renderSpecialChars(String asValue) throws Exception
	{
		if (isNull(asValue)) return "";
		
		String lsTemp = new String(asValue);
		
		for (int i = 0; i < SourceStrings.length; i++)
		{
			lsTemp = lsTemp.replaceAll(SourceStrings[i], ConvertStrings[i]);
		}
		
		return lsTemp;
	}
	
	public static String deSC(String asValue) throws Exception
	{
		return restoreSpecialChars(asValue);
	}
	
	public static String restoreSpecialChars(String asValue) throws Exception
	{
		if (isNull(asValue)) return "";
		
		String lsTemp = new String(asValue);
		
		for (int i = 0; i < SourceStrings.length; i++)
		{
			lsTemp = lsTemp.replaceAll(ConvertStrings[i], SourceStrings[i]);
		}
		
		return lsTemp;
	}
	
	// ��ȸ���� �� ��ȸ�� ������ html�� �������ش�
	public static String getSelectInfo(HttpSession aSession) throws Exception
	{
		String lsTemp = "";
		String lsUser = "";
		
		lsUser += aSession.getAttribute("G_TaskBrnceName") == null ? "" : aSession.getAttribute("G_TaskBrncName").toString();
		lsUser += aSession.getAttribute("G_UserName") == null ? " " : " " + aSession.getAttribute("G_UserName").toString();
		lsUser += aSession.getAttribute("G_UserID") == null ? "()" : "(" + aSession.getAttribute("G_UserID").toString() + ")";
		
		lsTemp += "<TABLE cellSpacing='0' cellPadding='0' width='780' border='0'>";
		lsTemp += "<TR>";
		lsTemp += "<TD>";
		lsTemp += "<TABLE cellSpacing='0' cellPadding='0' width='100%' border='0'>";
		lsTemp += "<TR>";
		lsTemp += "<TD width='10' align='center'><IMG src='../Images/arrowLocation.gif'></TD>";
		lsTemp += "<TD width='300'>��ȸ���� : " + CITDate.getNow("yyyy-MM-dd HH:mm:ss") + "</TD>";
		lsTemp += "<TD width='10' align='center'><IMG src='../Images/arrowLocation.gif'></TD>";
		lsTemp += "<TD>��ȸ�� : " + lsUser + "</TD>";
		lsTemp += "</TR>";
		lsTemp += "</TABLE>";
		lsTemp += "</TD>";
		lsTemp += "</TR>";
		lsTemp += "</TABLE>";
		
		return lsTemp;
	}
	
	// ���콺 �׸����� Combo Data�� �������ش�
	public static String toGauceComboString(CITData aData, String asKey, String asValue) throws Exception
	{
		String lsRet = "";
		
		if (aData == null) throw new Exception ("CITCommon toGauceComboString Error : �����Ͱ� ��(Null)�Դϴ�.");
		if (isNull(asKey) || isNull(asValue)) throw new Exception ("CITCommon toGauceComboString Error : Ű �÷��� �Ǵ� �� �÷����� �����ϴ�.");
		
		try
		{
			if (aData.getRowsCount() > 0)
			{
				for (int i = 0; i < aData.getRowsCount(); i++)
				{
					lsRet += aData.toString(i, asKey) + ":" + aData.toString(i, asValue) + ",";
				}
				
				lsRet = lsRet.substring(0, lsRet.length() - 1);
			}
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon toGauceComboString Error : " + ex.getMessage());
		}
		
		return lsRet;
	}
	
	// Html Select(�޺�)�� Option�� �������ش�
	public static String toHtmlComboString(CITData aData, String asKey, String asValue) throws Exception
	{
		String lsRet = "";
		
		if (aData == null) throw new Exception ("CITCommon toHtmlComboString Error : �����Ͱ� ��(Null)�Դϴ�.");
		if (isNull(asKey) || isNull(asValue)) throw new Exception ("CITCommon toHtmlComboString Error : Ű �÷��� �Ǵ� �� �÷����� �����ϴ�.");
		
		try
		{
			if (aData.getRowsCount() > 0)
			{
				for (int i = 0; i < aData.getRowsCount(); i++)
				{
					lsRet += "<OPTION VALUE='" + aData.toString(i, asKey) + "'>" + aData.toString(i, asValue) + "\n";
				}
				
				lsRet = lsRet.substring(0, lsRet.length() - 1);
			}
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon toHtmlComboString Error : " + ex.getMessage());
		}
		
		return lsRet;
	}
	
	// Html Select(�޺�)�� Option�� JavaScript�� �߰��Ѵ�(���� �Լ� Common.js�� �̿�)
	public static String toScriptComboString(CITData aData, String asCombo, String asKey, String asValue) throws Exception
	{
		String lsRet = "";
		
		if (aData == null) throw new Exception ("CITCommon toScriptComboString Error : �����Ͱ� ��(Null)�Դϴ�.");
		if (isNull(asCombo) || isNull(asKey) || isNull(asValue)) throw new Exception ("CITCommon toScriptComboString Error : �޺���, Ű �÷��� �Ǵ� �� �÷����� �����ϴ�.");
		
		try
		{
			lsRet += "C_intiCombo(" + asCombo + ");\n";
			
			if (aData.getRowsCount() > 0)
			{
				for (int i = 0; i < aData.getRowsCount(); i++)
				{
					lsRet += "C_addComboItem(" + asCombo + ", '" + aData.toString(i, asKey) + "', '" + aData.toString(i, asValue) + "');\n";
				}
			}
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon toScriptComboString Error : " + ex.getMessage());
		}
		
		return lsRet;
	}
	
	public static Cookie getCookie(HttpServletRequest aRequest, String asCookieName) throws Exception
	{
		if (isNull(asCookieName)) throw new Exception ("CITCommon getCookie Error : ��Ű���� ��(Null)�Դϴ�");
		
		Cookie [] cookies = null;
		
		try
		{
			cookies = aRequest.getCookies();
			
			if (cookies == null || cookies.length < 1) return null;
			
			for (int i = 0; i < cookies.length; i++)
			{
				if (asCookieName.equals(cookies[i].getName())) return cookies[i];
			}
			
			return null;
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon getCookie Error : " + ex.getMessage());
		}
	}
	
	public static String getCookieValue(HttpServletRequest aRequest, String asCookieName) throws Exception
	{
		Cookie cookie = getCookie(aRequest, asCookieName);
		
		if (cookie == null) throw new Exception ("CITCommon getCookieValue Error : ��Ű�� �������� �ʽ��ϴ�(��Ű��:" + asCookieName + ")");
		
		return cookie.getValue();
	}
	
	public static void setCookieValue(HttpServletRequest aRequest, String asCookieName, String asCookieValue) throws Exception
	{
		Cookie cookie = getCookie(aRequest, asCookieName);
		
		if (cookie == null) throw new Exception ("CITCommon setCookieValue Error : ��Ű�� �������� �ʽ��ϴ�(��Ű��:" + asCookieName + ")");
		
		cookie.setValue(asCookieValue);
	}
	
	public static Cookie addCookie(HttpServletResponse aResponse, String asCookieName, String asCookieValue) throws Exception
	{
		if (isNull(asCookieName)) throw new Exception ("CITCommon addCookie Error : ��Ű���� ��(Null)�Դϴ�");
		
		Cookie cookie = null;
		
		try
		{
			cookie = new Cookie(asCookieName, asCookieValue);
			aResponse.addCookie(cookie);
			return cookie;
		}
		catch (Exception ex)
		{
			throw new Exception ("CITCommon addCookie Error : " + ex.getMessage());
		}
	}
}
