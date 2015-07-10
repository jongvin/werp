package com.cj.util;

import com.cj.common.*;

import java.math.*;
import java.sql.*;
import java.util.*;

// �����ͺ��̽��� ����� ����� ���� ������ �����ϴ� Vector ������ Ŭ����
public class CITData
{
	// CITData�� �޼��� �÷��� �� ���� �޼��� ���
	
	// CITData�� �÷� Ÿ�� ���
	public static final int VARCHAR2 = Types.VARCHAR;
	public static final int NUMBER = Types.NUMERIC;
	public static final int DATE = Types.DATE;
	public static final int DATETIME = Types.TIMESTAMP;
	public static final int LONG = Types.LONGVARCHAR;
	public static final int LONG_RAW = Types.LONGVARBINARY;
	
	public static final int MSG_TYPE_REQUEST = 0;
	public static final int MSG_TYPE_RESULT = 1;
	public static final int MSG_TYPE_WAIT = 2;
	
	private boolean bolError = false;
	private String strErrorMessage = null;
	private long lngRequestHandle = -1;
	private int intMessageType = -1;
	private long lngWaitTime = -1;
	private String strServiceName = null;
	private String strMethodName = null;
	
	private ArrayList arRow;
	private Hashtable htColIndex;
	private Hashtable htColInfo;

	public CITData() throws Exception
	{
		this.arRow = new ArrayList();
		this.htColIndex = new Hashtable();
		this.htColInfo = new Hashtable();
	}
	
	public void close()
	{
		try
		{
			this.finalize();
		}
		catch (Throwable ex)
		{
		}
	}
	
	// ResultSet�� �÷� MetaData�� CITData Ŭ������ ����
	public void setColumnInfo(ResultSetMetaData aColMetaData) throws Exception
	{
		for (int i = 1; i <= aColMetaData.getColumnCount(); i++)
		{
			this.addColumn(aColMetaData.getColumnDisplaySize(i), aColMetaData.getColumnName(i), aColMetaData.getColumnType(i), aColMetaData.getColumnTypeName(i), aColMetaData.getPrecision(i),	aColMetaData.getScale(i), aColMetaData.getSchemaName(i), aColMetaData.getTableName(i), 1, false);
		}
	}
	
	// �ش� �÷��� MetaData�� ����
	public CITColumnInfo getColumnInfo(int aiIndex)
	{
		return (CITColumnInfo)this.htColInfo.get(new Integer(aiIndex));
	}
	
	// �÷� �߰�
	public void addColumn(String asColumnName) throws Exception
	{
		this.addColumn(asColumnName, Types.VARCHAR);
	}
	
	// �÷� �߰�
	public void addColumn(String asColumnName, int aiColumnType) throws Exception
	{
		this.addColumn(-1, asColumnName, aiColumnType, null, -1, -1, null, null, 1, false);
	}
	
	// �÷� �߰�
	public void addColumn(String asColumnName, int aiColumnType, boolean abOutParameter) throws Exception
	{
		this.addColumn(-1, asColumnName, aiColumnType, null, -1, -1, null, null, 1, abOutParameter);
	}
	
	// �÷� �߰�
	public void addColumn(int aiColumnDisplaySize, String asColumnName, int aiColumnType, String asColumnTypeName, int aiPrecision, int aiScale, String asSchemaName, String asTableName, int aiNullable, boolean abOutParameter) throws Exception
	{
		this.addColumn(aiColumnDisplaySize, asColumnName, aiColumnType, asColumnTypeName, aiPrecision, aiScale, asSchemaName, asTableName, aiNullable, abOutParameter, false);
	}
	
	// �÷� �߰�
	public void addColumn(int aiColumnDisplaySize, String asColumnName, int aiColumnType, String asColumnTypeName, int aiPrecision, int aiScale, String asSchemaName, String asTableName, int aiNullable, boolean abOutParameter, boolean abKey) throws Exception
	{
		CITColumnInfo lrColInfo = null;
		
		if (CITCommon.isNull(asColumnName)) throw new Exception ("CITData addColumn Error : �÷����� ��(null)�Դϴ�");
		
		try
		{
			lrColInfo = new CITColumnInfo();
				
			lrColInfo.ColumnDisplaySize = aiColumnDisplaySize;
			lrColInfo.ColumnName = asColumnName == null ? "" : asColumnName;
			lrColInfo.ColumnType = aiColumnType;
			lrColInfo.ColumnTypeName = asColumnTypeName == null ? "" : asColumnTypeName;
			lrColInfo.Precision = aiPrecision;
			lrColInfo.SScale = aiScale;
			lrColInfo.SchemaName = asSchemaName == null ? "" : asSchemaName;
			lrColInfo.TableName = asTableName == null ? "" : asTableName;
			lrColInfo.Nullable = aiNullable;
			lrColInfo.OutParameter = abOutParameter ? 1 : 0;
			lrColInfo.Key = abKey ? 1 : 0;
			
			this.htColIndex.put(asColumnName, new Integer(this.getColsCount()));
			this.htColInfo.put(new Integer(this.getColsCount()), lrColInfo);
		}
		catch (Exception ex)
		{
			throw new Exception ("CITData addColumn Error : [�÷���=" + asColumnName + "] " + ex.getMessage());
		}
	}
	
	// �÷� ����
	public void removeColumn(String asColName)
	{
		this.htColInfo.remove(this.htColIndex.get(asColName));
		this.htColIndex.remove(asColName);
	}
	
	// �÷� ����
	public void removeColumn(int aiColIndex)
	{
		CITColumnInfo lrColInfo = (CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex));
		
		if (lrColInfo != null) this.removeColumn(lrColInfo.ColumnName);
	}
	
	// ��� �÷� ����
	public void removeAllColumn()
	{
		this.htColIndex.clear();
		this.htColInfo.clear();
	}
	
	// �� �� �߰�
	public void addRow() throws Exception
	{
		if (this.getColsCount() < 1) throw new Exception ("CITData addRow Error : �÷��� �������� �ʽ��ϴ�");
		arRow.add(new CITRow(this.getColsCount()));
	}
	
	// �� �� ����
	public void removeRow(int aiRowIndex) throws Exception
	{
		try
		{
			arRow.remove(aiRowIndex);
		}
		catch (Exception ex)
		{
			throw new Exception ("CITData removeRow Error : [��=" + aiRowIndex + "] " + ex.getMessage());
		}
	}
	
	// ��� �� ����
	public void removeAllRow()
	{
		arRow.clear();
	}
	
	// ��� ��, �÷� ����
	public void removeAll()
	{
		removeAllRow();
		removeAllColumn();
	}
	
	// CITData�� �Էµ� �������� ��ü ���ڵ��
	public int getRowsCount()
	{
		return this.arRow.size();
	}
	
	// CITData�� ���� �÷���
	public int getColsCount()
	{
		return this.htColInfo.size();
	}

	// �ش� �÷��� ����
	public int getColumnDisplaySize(int aiColIndex)
	{
		return !this.htColInfo.containsKey(new Integer(aiColIndex)) ? -1 : ((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).ColumnDisplaySize;
	}

	// �ش� �÷��� ����
	public int getColumnDisplaySize(String asColName)
	{
		return !this.htColIndex.containsKey(asColName) ? -1 : this.getColumnDisplaySize(Integer.parseInt(this.htColIndex.get(asColName).toString()));
	}

	// �ش� �÷��� �̸�
	public String getColumnName(int aiColIndex)
	{
		return !this.htColInfo.containsKey(new Integer(aiColIndex)) ? "" : ((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).ColumnName;
	}

	// �ش� �÷��� Ÿ��
	public int getColumnType(int aiColIndex)
	{
		return !this.htColInfo.containsKey(new Integer(aiColIndex)) ? -1 : ((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).ColumnType;
	}

	// �ش� �÷��� Ÿ��
	public int getColumnType(String asColName)
	{
		return !this.htColIndex.containsKey(asColName) ? -1 : this.getColumnType(Integer.parseInt(this.htColIndex.get(asColName).toString()));
	}

	// �ش� �÷��� Ÿ�Ը�
	public String getColumnTypeName(int aiColIndex)
	{
		return !this.htColInfo.containsKey(new Integer(aiColIndex)) ? "" : ((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).ColumnTypeName;
	}
	
	// �ش� �÷��� Ÿ�Ը�
	public String getColumnTypeName(String asColName)
	{
		return !this.htColIndex.containsKey(asColName) ? "" : this.getColumnTypeName(Integer.parseInt(this.htColIndex.get(asColName).toString()));
	}

	// �ش� �÷��� 10�� �ڸ���
	public int getPrecision(int aiColIndex)
	{
		return !this.htColInfo.containsKey(new Integer(aiColIndex)) ? -1 : ((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).Precision;
	}

	// �ش� �÷��� 10�� �ڸ���
	public int getPrecision(String asColName)
	{
		return !this.htColIndex.containsKey(asColName) ? -1 : this.getPrecision(Integer.parseInt(this.htColIndex.get(asColName).toString()));
	}

	// �ش� �÷��� �Ҽ��� ���� �ڸ���
	public int getScale(int aiColIndex)
	{
		return !this.htColInfo.containsKey(new Integer(aiColIndex)) ? -1 : ((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).SScale;
	}

	// �ش� �÷��� �Ҽ��� ���� �ڸ���
	public int getScale(String asColName)
	{
		return !this.htColIndex.containsKey(asColName) ? -1 : this.getScale(Integer.parseInt(this.htColIndex.get(asColName).toString()));
	}

	// �ش� �÷��� ��Ű����
	public String getSchemaName(int aiColIndex)
	{
		return !this.htColInfo.containsKey(new Integer(aiColIndex)) ? "" : ((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).SchemaName;
	}
	
	// �ش� �÷��� ��Ű����
	public String getSchemaName(String asColName)
	{
		return !this.htColIndex.containsKey(asColName) ? "" : this.getSchemaName(Integer.parseInt(this.htColIndex.get(asColName).toString()));
	}

	// �ش� �÷��� ���̺��
	public String getTableName(int aiColIndex)
	{
		return !this.htColInfo.containsKey(new Integer(aiColIndex)) ? "" : ((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).TableName ;
	}
	
	// �ش� �÷��� ���̺��
	public String getTableName(String asColName)
	{
		return !this.htColIndex.containsKey(asColName) ? "" : this.getTableName(Integer.parseInt(this.htColIndex.get(asColName).toString()));
	}

	// �ش� �÷��� ��(Null) ��������
	public int isNullable(int aiColIndex)
	{
		return !this.htColInfo.containsKey(new Integer(aiColIndex)) ? -1 : ((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).Nullable ;
	}
	
	// �ش� �÷��� ��(Null) ��������
	public int isNullable(String asColName)
	{
		return !this.htColIndex.containsKey(asColName) ? -1 : this.isNullable(Integer.parseInt(this.htColIndex.get(asColName).toString()));
	}
	
	// �ش� �÷��� OUT ��������
	public boolean isOutParameter(int aiColIndex)
	{
		if (!this.htColInfo.containsKey(new Integer(aiColIndex))) return false;		
		return ((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).OutParameter == 1 ? true : false;
	}
	
	// �ش� �÷��� OUT ��������
	public boolean isOutParameter(String asColName)
	{
		if (!this.htColIndex.containsKey(asColName)) return false;
		return this.isOutParameter(Integer.parseInt(this.htColIndex.get(asColName).toString()));
	}
	
	// �ش� �÷��� Key ��������
	public boolean isKey(int aiColIndex)
	{
		if (!this.htColInfo.containsKey(new Integer(aiColIndex))) return false;		
		return ((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).Key == 1 ? true : false;
	}
	
	// �ش� �÷��� Key ��������
	public boolean isKey(String asColName)
	{
		if (!this.htColIndex.containsKey(asColName)) return false;
		return this.isKey(Integer.parseInt(this.htColIndex.get(asColName).toString()));
	}
	
	// �ش� �÷��� Key�� ����
	public void setKey(int aiColIndex, boolean abKey)
	{
		if (!this.htColInfo.containsKey(new Integer(aiColIndex))) return;		
		((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).Key = abKey == true ? 1 : 0;
	}
	
	// �ش� �÷��� Key�� ����
	public void setKey(String asColName, boolean abKey)
	{
		if (!this.htColIndex.containsKey(asColName)) return;
		this.setKey(Integer.parseInt(this.htColIndex.get(asColName).toString()), abKey);
	}
	
	// �ش� �÷��� Not Null�� ����
	public void setNotNull(int aiColIndex, boolean abKey)
	{
		if (!this.htColInfo.containsKey(new Integer(aiColIndex))) return;		
		((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).Nullable = abKey == true ? 0 : 1;
	}
	
	// �ش� �÷��� Not Null�� ����
	public void setNotNull(String asColName, boolean abKey)
	{
		if (!this.htColIndex.containsKey(asColName)) return;
		this.setNotNull(Integer.parseInt(this.htColIndex.get(asColName).toString()), abKey);
	}
	
	// �ش� �÷��� ColumnDisplaySize�� ����
	public void setColumnDisplaySize(int aiColIndex, int aiColumnDisplaySize)
	{
		if (!this.htColInfo.containsKey(new Integer(aiColIndex))) return;		
		((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).ColumnDisplaySize = aiColumnDisplaySize;
	}
	
	// �ش� �÷��� ColumnDisplaySize�� ����
	public void setColumnDisplaySize(String asColName, int aiColumnDisplaySize)
	{
		if (!this.htColIndex.containsKey(asColName)) return;
		this.setColumnDisplaySize(Integer.parseInt(this.htColIndex.get(asColName).toString()), aiColumnDisplaySize);
	}
	
	// �ش� �÷��� Precision�� ����
	public void setPrecision(int aiColIndex, int aiPrecision)
	{
		if (!this.htColInfo.containsKey(new Integer(aiColIndex))) return;		
		((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).Precision = aiPrecision;
	}
	
	// �ش� �÷��� Precision�� ����
	public void setPrecision(String asColName, int aiPrecision)
	{
		if (!this.htColIndex.containsKey(asColName)) return;
		this.setPrecision(Integer.parseInt(this.htColIndex.get(asColName).toString()), aiPrecision);
	}
	
	// �ش� �÷��� Scale�� ����
	public void setScale(int aiColIndex, int aiScale)
	{
		if (!this.htColInfo.containsKey(new Integer(aiColIndex))) return;		
		((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).SScale = aiScale;
	}
	
	// �ش� �÷��� Scale�� ����
	public void setScale(String asColName, int aiScale)
	{
		if (!this.htColIndex.containsKey(asColName)) return;
		this.setScale(Integer.parseInt(this.htColIndex.get(asColName).toString()), aiScale);
	}

	// ������ ��, Ư�� �÷��� ���� ����
	public void setValue(int aiColIndex, Object aoValue) throws Exception
	{
		this.setValue(arRow.size() - 1, aiColIndex, aoValue);
	}
	
	// ������ ��, Ư�� �÷��� ���� ����
	public void setValue(String asColName, Object aoValue) throws Exception
	{
		this.setValue(arRow.size() - 1, this.getColIndex(asColName), aoValue);
	}
	
	// Ư�� ��, Ư�� �÷��� ���� ����
	public void setValue(int aiRowIndex, int aiColIndex, Object aoValue) throws Exception
	{
		Object object = null;
		String strErrMsg = null;
		
		try
		{
			if (aoValue == null)
			{
				object = null;
			}
			else if (aoValue.toString().trim().equals(""))
			{
				object = aoValue.toString().trim();
			}
			else if (aoValue != null && aoValue instanceof java.lang.String)
			{
				if (this.getColumnType(aiColIndex) == this.VARCHAR2)
				{
					strErrMsg = ",�÷�Ÿ��=VARCHAR2, ��=" + aoValue.toString();
					object = aoValue.toString();
				}
				else if (this.getColumnType(aiColIndex) == this.NUMBER)
				{
					strErrMsg = ",�÷�Ÿ��=NUMBER, ��=" + aoValue.toString();
					object = new BigDecimal(aoValue.toString().trim().replaceAll(",",""));
				}
				else if (this.getColumnType(aiColIndex) == this.DATE)
				{
					strErrMsg = ",�÷�Ÿ��=DATE, ��=" + aoValue.toString();
					object = CITDate.getDate(aoValue.toString());
				}
				else if (this.getColumnType(aiColIndex) == this.DATETIME)
				{
					strErrMsg = ",�÷�Ÿ��=DATETIME, ��=" + aoValue.toString();
					object = new Timestamp(CITDate.getDate(aoValue.toString()).getTime());
				}
				else if (this.getColumnType(aiColIndex) == this.LONG || this.getColumnType(aiColIndex) == this.LONG_RAW)
				{
					strErrMsg = ",�÷�Ÿ��=LONG �Ǵ� LONG_RAW, ��=" + aoValue.toString();
					object = aoValue;
					//throw new Exception("CITData.LONG �� CITData.LONG_RAW Ÿ���� ������ String ���� ����� �� �����ϴ�.");
				}
				else
				{
					strErrMsg = ",�÷�Ÿ��=��Ÿ, ��=" + aoValue.toString();
					object = aoValue;
				}
			}
			else
			{
				strErrMsg = ",�÷�Ÿ��=��Ÿ, ��=" + aoValue.toString();
				object = aoValue;
			}
			
			CITRow lrRow = (CITRow)arRow.get(aiRowIndex);
			lrRow.setValue(aiColIndex, object);
		}
		catch (Exception ex)
		{
			throw new Exception("CITData setValue Error : [��=" + aiRowIndex + ",��=" + aiColIndex + strErrMsg + "] " + ex.getMessage());
		}
	}
	
	// Ư�� ��, Ư�� �÷��� ���� ����
	public void setValue(int aiRowIndex, String asColName, Object aoValue) throws Exception
	{
		this.setValue(aiRowIndex, this.getColIndex(asColName), aoValue);
	}
	
	// Ư�� ��, Ư�� �÷��� ��
	public Object getValue(int aiRowIndex, int aiColIndex) throws Exception
	{
		Object loValue = null;
		
		try
		{
			CITRow lrRow = (CITRow)arRow.get(aiRowIndex);
			loValue = lrRow.getValue(aiColIndex);
		}
		catch (Exception ex)
		{
			throw new Exception("CITData getValue Error : [��=" + aiRowIndex + ",��=" + aiColIndex + "] " + ex.getMessage());
		}
		
		return loValue;
	}
	
	// Ư�� ��, Ư�� �÷��� ��
	public Object getValue(int aiRowIndex, String asColName) throws Exception
	{
		return this.getValue(aiRowIndex, this.getColIndex(asColName));
	}
	
	// Ư�� ��, Ư�� �÷��� ���� ���ڷ� ��ȯ
	public String toString(int aiRowIndex, int aiColIndex) throws Exception
	{
		String lsReturnData = null;
		
		try
		{
			if (this.getValue(aiRowIndex, aiColIndex) == null) return "";
			
			if (this.getColumnType(aiColIndex) == this.VARCHAR2 || this.getColumnType(aiColIndex) == this.NUMBER ||
				this.getColumnType(aiColIndex) == this.LONG || this.getColumnType(aiColIndex) == this.LONG_RAW)
			{
				lsReturnData = this.getValue(aiRowIndex, aiColIndex).toString();
			}
			else if (this.getColumnType(aiColIndex) == this.DATE)
			{
				lsReturnData = CITDate.toString((java.util.Date)(this.getValue(aiRowIndex, aiColIndex)), "yyyyMMdd");
			}
			else if (this.getColumnType(aiColIndex) == this.DATETIME)
			{
				lsReturnData = CITDate.toString((java.util.Date)(this.getValue(aiRowIndex, aiColIndex)), "yyyyMMddHHmmss");
			}
			else
			{
				lsReturnData = this.getValue(aiRowIndex, aiColIndex).toString();
			}
			
			return lsReturnData;
		}
		catch (Exception ex)
		{
			throw new Exception("CITData toString Error : [��=" + aiRowIndex + ",��=" + aiColIndex + "] " + ex.getMessage());
		}
	}
	
	// Ư�� ��, Ư�� �÷��� ���� ���ڷ� ��ȯ
	public String toString(int aiRowIndex, String asColName) throws Exception
	{
		return this.getValue(aiRowIndex, asColName) == null ? "" : this.toString(aiRowIndex, this.getColIndex(asColName));
	}
	
	// Ư�� ��, Ư�� �÷��� ��(Null) ����
	public boolean isNullValue(int aiRowIndex, int aiColIndex) throws Exception
	{
		return this.getValue(aiRowIndex, aiColIndex) == null ? true : false;
	}
	
	// Ư�� ��, Ư�� �÷��� ��(Null) ����
	public boolean isNullValue(int aiRowIndex, String asColName) throws Exception
	{
		return this.isNullValue(aiRowIndex, this.getColIndex(asColName));
	}
	
	// �÷� �̸��� �ش��ϴ� �÷� �ε��� ����
	private int getColIndex(String asColName) throws Exception
	{
		return !this.htColIndex.containsKey(asColName) ? -1 : Integer.parseInt(this.htColIndex.get(asColName).toString());
	}
	
	// CITData�� ���� ���� ����
	public void setError(boolean abolError)
	{
		this.bolError = abolError;
	}
	
	// CITData�� ���� ����
	public boolean isError()
	{
		return this.bolError;
	}
	
	// CITData�� ���� �޼��� ����
	public void setErrorMessage(String asErrorMessage)
	{
		this.strErrorMessage = asErrorMessage;
	}
	
	// CITData�� ���� �޼���
	public String getErrorMessage()
	{
		return this.strErrorMessage;
	}
	
	// CITData�� RequestHandle ����
	public void setRequestHandle(long alRequestHandle)
	{
		this.lngRequestHandle = alRequestHandle;
	}
	
	// CITData�� RequestHandle ��
	public long getRequestHandle()
	{
		return this.lngRequestHandle;
	}
	
	// CITData�� MessageType ����
	public void setMessageType(int aiMessageType)
	{
		this.intMessageType = aiMessageType;
	}
	
	// CITData�� MessageType ��
	public int getMessageType()
	{
		return this.intMessageType;
	}
	
	// CITData�� WaitTime ����
	public void setWaitTime(long alWaitTime)
	{
		this.lngWaitTime = alWaitTime;
	}
	
	// CITData�� WaitTime ��
	public long getWaitTime()
	{
		return this.lngWaitTime;
	}
	
	// CITData�� ServiceName ����
	public void setServiceName(String asServiceName)
	{
		this.strServiceName = asServiceName;
	}
	
	// CITData�� ServiceName
	public String getServiceName()
	{
		return this.strServiceName;
	}
	
	// CITData�� MethodName ����
	public void setMethodName(String asMethodName)
	{
		this.strMethodName = asMethodName;
	}
	
	// CITData�� MethodName
	public String getMethodName()
	{
		return this.strMethodName;
	}
	
	// ���� �޽����� ��� �ִ� CITData�� ����
	public static CITData makeErrorObject(String asErrorMessage) throws Exception
	{
		CITData lrData = new CITData();
		
		lrData.setError(true);
		lrData.setErrorMessage(asErrorMessage);
		
		return lrData;
	}
	
	// ���ڵ� ���� ��� �ִ� CITData�� ����
	public static CITData makeReturnObject(int aiRecordCount) throws Exception
	{
		CITData lrData = new CITData();
		
		lrData.addColumn("RECORD_COUNT", CITData.NUMBER);
		lrData.addRow();
		lrData.setValue("RECORD_COUNT", new Integer(aiRecordCount));
		
		return lrData;
	}
	
	// �޼����� ��� �ִ� CITData�� ����
	public static CITData makeReturnObject(String asMessage) throws Exception
	{
		CITData lrData = new CITData();
		
		lrData.addColumn("MESSAGE", CITData.VARCHAR2);
		lrData.addRow();
		lrData.setValue("MESSAGE", asMessage);
		
		return lrData;
	}
	
	public void copyCITDataClassInfo(CITData aData)
	{
		this.setError(aData.isError());
		this.setErrorMessage(aData.getErrorMessage());
		this.setRequestHandle(aData.getRequestHandle());
		this.setMessageType(aData.getMessageType());
		this.setWaitTime(aData.getWaitTime());
		this.setServiceName(aData.getServiceName());
		this.setMethodName(aData.getMethodName());
	}
}

// CITData�� �� Ŭ����
class CITRow
{
	private Object [] objValue;
	
	public CITRow(int aiColCount)
	{
		objValue = new Object[aiColCount];
	}
	
	public void setValue(int aiColIndex, Object aoValue) throws Exception
	{
		objValue[aiColIndex] = aoValue;
	}
	
	public Object getValue(int aiColIndex) throws Exception
	{
		return objValue[aiColIndex];
	}
}