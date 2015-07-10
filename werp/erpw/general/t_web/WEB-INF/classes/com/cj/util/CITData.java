package com.cj.util;

import com.cj.common.*;

import java.math.*;
import java.sql.*;
import java.util.*;

// 데이터베이스의 결과나 사용자 정의 정보를 보관하는 Vector 구조의 클래스
public class CITData
{
	// CITData의 메서지 컬럼명 및 정상 메세지 상수
	
	// CITData의 컬럼 타입 상수
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
	
	// ResultSet의 컬럼 MetaData를 CITData 클래스에 설정
	public void setColumnInfo(ResultSetMetaData aColMetaData) throws Exception
	{
		for (int i = 1; i <= aColMetaData.getColumnCount(); i++)
		{
			this.addColumn(aColMetaData.getColumnDisplaySize(i), aColMetaData.getColumnName(i), aColMetaData.getColumnType(i), aColMetaData.getColumnTypeName(i), aColMetaData.getPrecision(i),	aColMetaData.getScale(i), aColMetaData.getSchemaName(i), aColMetaData.getTableName(i), 1, false);
		}
	}
	
	// 해당 컬럼의 MetaData를 제공
	public CITColumnInfo getColumnInfo(int aiIndex)
	{
		return (CITColumnInfo)this.htColInfo.get(new Integer(aiIndex));
	}
	
	// 컬럼 추가
	public void addColumn(String asColumnName) throws Exception
	{
		this.addColumn(asColumnName, Types.VARCHAR);
	}
	
	// 컬럼 추가
	public void addColumn(String asColumnName, int aiColumnType) throws Exception
	{
		this.addColumn(-1, asColumnName, aiColumnType, null, -1, -1, null, null, 1, false);
	}
	
	// 컬럼 추가
	public void addColumn(String asColumnName, int aiColumnType, boolean abOutParameter) throws Exception
	{
		this.addColumn(-1, asColumnName, aiColumnType, null, -1, -1, null, null, 1, abOutParameter);
	}
	
	// 컬럼 추가
	public void addColumn(int aiColumnDisplaySize, String asColumnName, int aiColumnType, String asColumnTypeName, int aiPrecision, int aiScale, String asSchemaName, String asTableName, int aiNullable, boolean abOutParameter) throws Exception
	{
		this.addColumn(aiColumnDisplaySize, asColumnName, aiColumnType, asColumnTypeName, aiPrecision, aiScale, asSchemaName, asTableName, aiNullable, abOutParameter, false);
	}
	
	// 컬럼 추가
	public void addColumn(int aiColumnDisplaySize, String asColumnName, int aiColumnType, String asColumnTypeName, int aiPrecision, int aiScale, String asSchemaName, String asTableName, int aiNullable, boolean abOutParameter, boolean abKey) throws Exception
	{
		CITColumnInfo lrColInfo = null;
		
		if (CITCommon.isNull(asColumnName)) throw new Exception ("CITData addColumn Error : 컬럼명이 널(null)입니다");
		
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
			throw new Exception ("CITData addColumn Error : [컬럼명=" + asColumnName + "] " + ex.getMessage());
		}
	}
	
	// 컬럼 삭제
	public void removeColumn(String asColName)
	{
		this.htColInfo.remove(this.htColIndex.get(asColName));
		this.htColIndex.remove(asColName);
	}
	
	// 컬럼 삭제
	public void removeColumn(int aiColIndex)
	{
		CITColumnInfo lrColInfo = (CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex));
		
		if (lrColInfo != null) this.removeColumn(lrColInfo.ColumnName);
	}
	
	// 모든 컬럼 삭제
	public void removeAllColumn()
	{
		this.htColIndex.clear();
		this.htColInfo.clear();
	}
	
	// 한 행 추가
	public void addRow() throws Exception
	{
		if (this.getColsCount() < 1) throw new Exception ("CITData addRow Error : 컬럼이 존재하지 않습니다");
		arRow.add(new CITRow(this.getColsCount()));
	}
	
	// 한 행 삭제
	public void removeRow(int aiRowIndex) throws Exception
	{
		try
		{
			arRow.remove(aiRowIndex);
		}
		catch (Exception ex)
		{
			throw new Exception ("CITData removeRow Error : [행=" + aiRowIndex + "] " + ex.getMessage());
		}
	}
	
	// 모든 행 삭제
	public void removeAllRow()
	{
		arRow.clear();
	}
	
	// 모든 행, 컬럼 삭제
	public void removeAll()
	{
		removeAllRow();
		removeAllColumn();
	}
	
	// CITData에 입력된 데이터의 전체 레코드수
	public int getRowsCount()
	{
		return this.arRow.size();
	}
	
	// CITData의 전제 컬럼수
	public int getColsCount()
	{
		return this.htColInfo.size();
	}

	// 해당 컬럼의 길이
	public int getColumnDisplaySize(int aiColIndex)
	{
		return !this.htColInfo.containsKey(new Integer(aiColIndex)) ? -1 : ((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).ColumnDisplaySize;
	}

	// 해당 컬럼의 길이
	public int getColumnDisplaySize(String asColName)
	{
		return !this.htColIndex.containsKey(asColName) ? -1 : this.getColumnDisplaySize(Integer.parseInt(this.htColIndex.get(asColName).toString()));
	}

	// 해당 컬럼의 이름
	public String getColumnName(int aiColIndex)
	{
		return !this.htColInfo.containsKey(new Integer(aiColIndex)) ? "" : ((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).ColumnName;
	}

	// 해당 컬럼의 타입
	public int getColumnType(int aiColIndex)
	{
		return !this.htColInfo.containsKey(new Integer(aiColIndex)) ? -1 : ((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).ColumnType;
	}

	// 해당 컬럼의 타입
	public int getColumnType(String asColName)
	{
		return !this.htColIndex.containsKey(asColName) ? -1 : this.getColumnType(Integer.parseInt(this.htColIndex.get(asColName).toString()));
	}

	// 해당 컬럼의 타입명
	public String getColumnTypeName(int aiColIndex)
	{
		return !this.htColInfo.containsKey(new Integer(aiColIndex)) ? "" : ((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).ColumnTypeName;
	}
	
	// 해당 컬럼의 타입명
	public String getColumnTypeName(String asColName)
	{
		return !this.htColIndex.containsKey(asColName) ? "" : this.getColumnTypeName(Integer.parseInt(this.htColIndex.get(asColName).toString()));
	}

	// 해당 컬럼의 10진 자리수
	public int getPrecision(int aiColIndex)
	{
		return !this.htColInfo.containsKey(new Integer(aiColIndex)) ? -1 : ((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).Precision;
	}

	// 해당 컬럼의 10진 자리수
	public int getPrecision(String asColName)
	{
		return !this.htColIndex.containsKey(asColName) ? -1 : this.getPrecision(Integer.parseInt(this.htColIndex.get(asColName).toString()));
	}

	// 해당 컬럼의 소수점 이하 자리수
	public int getScale(int aiColIndex)
	{
		return !this.htColInfo.containsKey(new Integer(aiColIndex)) ? -1 : ((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).SScale;
	}

	// 해당 컬럼의 소수점 이하 자리수
	public int getScale(String asColName)
	{
		return !this.htColIndex.containsKey(asColName) ? -1 : this.getScale(Integer.parseInt(this.htColIndex.get(asColName).toString()));
	}

	// 해당 컬럼의 스키마명
	public String getSchemaName(int aiColIndex)
	{
		return !this.htColInfo.containsKey(new Integer(aiColIndex)) ? "" : ((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).SchemaName;
	}
	
	// 해당 컬럼의 스키마명
	public String getSchemaName(String asColName)
	{
		return !this.htColIndex.containsKey(asColName) ? "" : this.getSchemaName(Integer.parseInt(this.htColIndex.get(asColName).toString()));
	}

	// 해당 컬럼의 테이블명
	public String getTableName(int aiColIndex)
	{
		return !this.htColInfo.containsKey(new Integer(aiColIndex)) ? "" : ((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).TableName ;
	}
	
	// 해당 컬럼의 테이블명
	public String getTableName(String asColName)
	{
		return !this.htColIndex.containsKey(asColName) ? "" : this.getTableName(Integer.parseInt(this.htColIndex.get(asColName).toString()));
	}

	// 해당 컬럼의 널(Null) 설정여부
	public int isNullable(int aiColIndex)
	{
		return !this.htColInfo.containsKey(new Integer(aiColIndex)) ? -1 : ((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).Nullable ;
	}
	
	// 해당 컬럼의 널(Null) 설정여부
	public int isNullable(String asColName)
	{
		return !this.htColIndex.containsKey(asColName) ? -1 : this.isNullable(Integer.parseInt(this.htColIndex.get(asColName).toString()));
	}
	
	// 해당 컬럼의 OUT 설정여부
	public boolean isOutParameter(int aiColIndex)
	{
		if (!this.htColInfo.containsKey(new Integer(aiColIndex))) return false;		
		return ((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).OutParameter == 1 ? true : false;
	}
	
	// 해당 컬럼의 OUT 설정여부
	public boolean isOutParameter(String asColName)
	{
		if (!this.htColIndex.containsKey(asColName)) return false;
		return this.isOutParameter(Integer.parseInt(this.htColIndex.get(asColName).toString()));
	}
	
	// 해당 컬럼의 Key 설정여부
	public boolean isKey(int aiColIndex)
	{
		if (!this.htColInfo.containsKey(new Integer(aiColIndex))) return false;		
		return ((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).Key == 1 ? true : false;
	}
	
	// 해당 컬럼의 Key 설정여부
	public boolean isKey(String asColName)
	{
		if (!this.htColIndex.containsKey(asColName)) return false;
		return this.isKey(Integer.parseInt(this.htColIndex.get(asColName).toString()));
	}
	
	// 해당 컬럼을 Key로 설정
	public void setKey(int aiColIndex, boolean abKey)
	{
		if (!this.htColInfo.containsKey(new Integer(aiColIndex))) return;		
		((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).Key = abKey == true ? 1 : 0;
	}
	
	// 해당 컬럼을 Key로 설정
	public void setKey(String asColName, boolean abKey)
	{
		if (!this.htColIndex.containsKey(asColName)) return;
		this.setKey(Integer.parseInt(this.htColIndex.get(asColName).toString()), abKey);
	}
	
	// 해당 컬럼을 Not Null로 설정
	public void setNotNull(int aiColIndex, boolean abKey)
	{
		if (!this.htColInfo.containsKey(new Integer(aiColIndex))) return;		
		((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).Nullable = abKey == true ? 0 : 1;
	}
	
	// 해당 컬럼을 Not Null로 설정
	public void setNotNull(String asColName, boolean abKey)
	{
		if (!this.htColIndex.containsKey(asColName)) return;
		this.setNotNull(Integer.parseInt(this.htColIndex.get(asColName).toString()), abKey);
	}
	
	// 해당 컬럼의 ColumnDisplaySize를 설정
	public void setColumnDisplaySize(int aiColIndex, int aiColumnDisplaySize)
	{
		if (!this.htColInfo.containsKey(new Integer(aiColIndex))) return;		
		((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).ColumnDisplaySize = aiColumnDisplaySize;
	}
	
	// 해당 컬럼의 ColumnDisplaySize를 설정
	public void setColumnDisplaySize(String asColName, int aiColumnDisplaySize)
	{
		if (!this.htColIndex.containsKey(asColName)) return;
		this.setColumnDisplaySize(Integer.parseInt(this.htColIndex.get(asColName).toString()), aiColumnDisplaySize);
	}
	
	// 해당 컬럼의 Precision을 설정
	public void setPrecision(int aiColIndex, int aiPrecision)
	{
		if (!this.htColInfo.containsKey(new Integer(aiColIndex))) return;		
		((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).Precision = aiPrecision;
	}
	
	// 해당 컬럼의 Precision을 설정
	public void setPrecision(String asColName, int aiPrecision)
	{
		if (!this.htColIndex.containsKey(asColName)) return;
		this.setPrecision(Integer.parseInt(this.htColIndex.get(asColName).toString()), aiPrecision);
	}
	
	// 해당 컬럼의 Scale을 설정
	public void setScale(int aiColIndex, int aiScale)
	{
		if (!this.htColInfo.containsKey(new Integer(aiColIndex))) return;		
		((CITColumnInfo)this.htColInfo.get(new Integer(aiColIndex))).SScale = aiScale;
	}
	
	// 해당 컬럼의 Scale을 설정
	public void setScale(String asColName, int aiScale)
	{
		if (!this.htColIndex.containsKey(asColName)) return;
		this.setScale(Integer.parseInt(this.htColIndex.get(asColName).toString()), aiScale);
	}

	// 마지막 행, 특정 컬럼에 값을 설정
	public void setValue(int aiColIndex, Object aoValue) throws Exception
	{
		this.setValue(arRow.size() - 1, aiColIndex, aoValue);
	}
	
	// 마지막 행, 특정 컬럼에 값을 설정
	public void setValue(String asColName, Object aoValue) throws Exception
	{
		this.setValue(arRow.size() - 1, this.getColIndex(asColName), aoValue);
	}
	
	// 특정 행, 특정 컬럼에 값을 설정
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
					strErrMsg = ",컬럼타입=VARCHAR2, 값=" + aoValue.toString();
					object = aoValue.toString();
				}
				else if (this.getColumnType(aiColIndex) == this.NUMBER)
				{
					strErrMsg = ",컬럼타입=NUMBER, 값=" + aoValue.toString();
					object = new BigDecimal(aoValue.toString().trim().replaceAll(",",""));
				}
				else if (this.getColumnType(aiColIndex) == this.DATE)
				{
					strErrMsg = ",컬럼타입=DATE, 값=" + aoValue.toString();
					object = CITDate.getDate(aoValue.toString());
				}
				else if (this.getColumnType(aiColIndex) == this.DATETIME)
				{
					strErrMsg = ",컬럼타입=DATETIME, 값=" + aoValue.toString();
					object = new Timestamp(CITDate.getDate(aoValue.toString()).getTime());
				}
				else if (this.getColumnType(aiColIndex) == this.LONG || this.getColumnType(aiColIndex) == this.LONG_RAW)
				{
					strErrMsg = ",컬럼타입=LONG 또는 LONG_RAW, 값=" + aoValue.toString();
					object = aoValue;
					//throw new Exception("CITData.LONG 과 CITData.LONG_RAW 타입의 값으로 String 값을 사용할 수 없습니다.");
				}
				else
				{
					strErrMsg = ",컬럼타입=기타, 값=" + aoValue.toString();
					object = aoValue;
				}
			}
			else
			{
				strErrMsg = ",컬럼타입=기타, 값=" + aoValue.toString();
				object = aoValue;
			}
			
			CITRow lrRow = (CITRow)arRow.get(aiRowIndex);
			lrRow.setValue(aiColIndex, object);
		}
		catch (Exception ex)
		{
			throw new Exception("CITData setValue Error : [행=" + aiRowIndex + ",열=" + aiColIndex + strErrMsg + "] " + ex.getMessage());
		}
	}
	
	// 특정 행, 특정 컬럼에 값을 설정
	public void setValue(int aiRowIndex, String asColName, Object aoValue) throws Exception
	{
		this.setValue(aiRowIndex, this.getColIndex(asColName), aoValue);
	}
	
	// 특정 행, 특정 컬럼의 값
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
			throw new Exception("CITData getValue Error : [행=" + aiRowIndex + ",열=" + aiColIndex + "] " + ex.getMessage());
		}
		
		return loValue;
	}
	
	// 특정 행, 특정 컬럼의 값
	public Object getValue(int aiRowIndex, String asColName) throws Exception
	{
		return this.getValue(aiRowIndex, this.getColIndex(asColName));
	}
	
	// 특정 행, 특정 컬럼의 값을 문자로 변환
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
			throw new Exception("CITData toString Error : [행=" + aiRowIndex + ",열=" + aiColIndex + "] " + ex.getMessage());
		}
	}
	
	// 특정 행, 특정 컬럼의 값을 문자로 변환
	public String toString(int aiRowIndex, String asColName) throws Exception
	{
		return this.getValue(aiRowIndex, asColName) == null ? "" : this.toString(aiRowIndex, this.getColIndex(asColName));
	}
	
	// 특정 행, 특정 컬럼의 널(Null) 여부
	public boolean isNullValue(int aiRowIndex, int aiColIndex) throws Exception
	{
		return this.getValue(aiRowIndex, aiColIndex) == null ? true : false;
	}
	
	// 특정 행, 특정 컬럼의 널(Null) 여부
	public boolean isNullValue(int aiRowIndex, String asColName) throws Exception
	{
		return this.isNullValue(aiRowIndex, this.getColIndex(asColName));
	}
	
	// 컬럼 이름에 해당하는 컬럼 인덱스 제공
	private int getColIndex(String asColName) throws Exception
	{
		return !this.htColIndex.containsKey(asColName) ? -1 : Integer.parseInt(this.htColIndex.get(asColName).toString());
	}
	
	// CITData의 에러 여부 설정
	public void setError(boolean abolError)
	{
		this.bolError = abolError;
	}
	
	// CITData의 에러 여부
	public boolean isError()
	{
		return this.bolError;
	}
	
	// CITData의 에러 메세제 설정
	public void setErrorMessage(String asErrorMessage)
	{
		this.strErrorMessage = asErrorMessage;
	}
	
	// CITData의 에러 메세제
	public String getErrorMessage()
	{
		return this.strErrorMessage;
	}
	
	// CITData의 RequestHandle 설정
	public void setRequestHandle(long alRequestHandle)
	{
		this.lngRequestHandle = alRequestHandle;
	}
	
	// CITData의 RequestHandle 값
	public long getRequestHandle()
	{
		return this.lngRequestHandle;
	}
	
	// CITData의 MessageType 설정
	public void setMessageType(int aiMessageType)
	{
		this.intMessageType = aiMessageType;
	}
	
	// CITData의 MessageType 값
	public int getMessageType()
	{
		return this.intMessageType;
	}
	
	// CITData의 WaitTime 설정
	public void setWaitTime(long alWaitTime)
	{
		this.lngWaitTime = alWaitTime;
	}
	
	// CITData의 WaitTime 값
	public long getWaitTime()
	{
		return this.lngWaitTime;
	}
	
	// CITData의 ServiceName 설정
	public void setServiceName(String asServiceName)
	{
		this.strServiceName = asServiceName;
	}
	
	// CITData의 ServiceName
	public String getServiceName()
	{
		return this.strServiceName;
	}
	
	// CITData의 MethodName 설정
	public void setMethodName(String asMethodName)
	{
		this.strMethodName = asMethodName;
	}
	
	// CITData의 MethodName
	public String getMethodName()
	{
		return this.strMethodName;
	}
	
	// 에러 메시지를 담고 있는 CITData를 생성
	public static CITData makeErrorObject(String asErrorMessage) throws Exception
	{
		CITData lrData = new CITData();
		
		lrData.setError(true);
		lrData.setErrorMessage(asErrorMessage);
		
		return lrData;
	}
	
	// 레코드 수를 담고 있는 CITData를 생성
	public static CITData makeReturnObject(int aiRecordCount) throws Exception
	{
		CITData lrData = new CITData();
		
		lrData.addColumn("RECORD_COUNT", CITData.NUMBER);
		lrData.addRow();
		lrData.setValue("RECORD_COUNT", new Integer(aiRecordCount));
		
		return lrData;
	}
	
	// 메세지를 담고 있는 CITData를 생성
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

// CITData의 행 클래스
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