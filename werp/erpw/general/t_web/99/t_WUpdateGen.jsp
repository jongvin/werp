<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
	CITData lrReturnData = null;
	String strOut = "";

    try
    {
    	CITCommon.initPage(request, response, session, false);
	}
	catch (Exception ex)
	{
		throw new Exception("페이지 초기화 오류 -> " + ex.getMessage());
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>회계관리 - Update 페이지 생성</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript">
		<!--
			var			CRLF = "\r\n";
			var			SPECIALCHARS = "`~!@#$%^&*()-=\\+|[]{};':\",./<>? 	\r\n";
			var			strOwnerList = "APP,CCMS,BAMS,PAMS,IAMS,HSMS,ACMS,CSPS,CPIS,HRMS,CLSM";
			var			strInsertProcName = "";
			var			strUpdateProcName = "";
			var			strDeleteProcName = "";
			var			strInsertAddColumn = "";
			var			strInsertSetValue = "";
			var			strUpdateAddColumn = "";
			var			strUpdateSetValue = "";
			var			strDeleteAddColumn = "";
			var			strDeleteSetValue = "";
			var			iInsertArgCount = 0;
			var			iUpdateArgCount = 0;
			var			iDeleteArgCount = 0;

			function Initialize()
			{
				txtCRTDATE.value=getNowDate();
				G_addDataSet(dsMAIN, null, null, "t_WUpdateGen_q.jsp?ACT=MAIN", "테이블목록");
				G_addDataSet(dsCOLUMN, null, null, "t_WUpdateGen_q.jsp?ACT=COLUMN", "컬럼목록");

				G_addRel(dsMAIN, dsCOLUMN);


				G_addRelCol(dsCOLUMN, "OWNER", "OWNER");
				G_addRelCol(dsCOLUMN, "TABLE_NAME", "TABLE_NAME");
			}
			function OnLoadBefore(dataset)
			{
				if (dataset == dsMAIN)
				{
					dataset.DataID = "t_WUpdateGen_q.jsp?ACT=MAIN&CONDITION="+txtTABLE_NAME.value;
				}
				else if (dataset == dsCOLUMN)
				{
					var			strOWNER;
					var			strTABLE_NAME;
					strOWNER = dsMAIN.NameString(dsMAIN.RowPosition,"OWNER");
					strTABLE_NAME = dsMAIN.NameString(dsMAIN.RowPosition,"TABLE_NAME");
					dataset.DataID = "t_WUpdateGen_q.jsp?ACT=COLUMN&OWNER="+strOWNER+"&TABLE_NAME="+strTABLE_NAME;
				}
			}

			// 함수관련---------------------------------------------------------------------//
			function	getDefaultComment()
			{
				var			strHEADER="";
				strHEADER += CRLF+ "/**************************************************************************/";
				strHEADER += CRLF+ "/* 1. 프 로 그 램 id : ";
				strHEADER += CRLF+ "/* 2. 유형(시나리오) : Update Page";
				strHEADER += CRLF+ "/* 3. 기  능  정  의 : ";
				strHEADER += CRLF+ "/* 4. 변  경  이  력 : " + txtCRTUSERNAME.value + " 작성(" + txtCRTDATE.value + ")";
				strHEADER += CRLF+ "/* 5. 관련  프로그램 : ";
				strHEADER += CRLF+ "/* 6. 특  기  사  항 : ";
				strHEADER += CRLF+ "/**************************************************************************/";
				return strHEADER;
			}
			function	getProcedureComment(asProcName, asTableName, asType)
			{
				var			strHEADER="";
				strHEADER += CRLF+ "/**************************************************************************/";
				strHEADER += CRLF+ "/* 1. 프 로 그 램 id : " + asProcName;
				strHEADER += CRLF+ "/* 2. 유형(시나리오) : Procedure";
				strHEADER += CRLF+ "/* 3. 기  능  정  의 : " + asTableName + " 테이블 " + asType;
				strHEADER += CRLF+ "/* 4. 변  경  이  력 : " + txtCRTUSERNAME.value + " 작성(" + txtCRTDATE.value + ")";
				strHEADER += CRLF+ "/* 5. 관련  프로그램 : ";
				strHEADER += CRLF+ "/* 6. 특  기  사  항 : ";
				strHEADER += CRLF+ "/**************************************************************************/";
				return strHEADER;
			}
			function	getCallState(asProcName,aiCount)
			{
				var			strRET = "						strSql = \"{call "+asProcName+"(";
				for(i = 0 ; i < aiCount ; i ++)
				{
					if (i == 0)
					{
						strRET += "?";
					}
					else
					{
						strRET += ",?";
					}
				}
				strRET += ")}\";"+CRLF;
				return strRET;
			}
			function	getNowDate()
			{
				var			lddtNow;
				var			liYear;
				var			liMonth;
				var			liDay;
				var			lsYear;
				var			lsMonth;
				var			lsDay;
				lddtNow = new Date();
				liYear = lddtNow.getFullYear();
				liMonth = lddtNow.getMonth() + 1;
				liDay = lddtNow.getDate();
				lsYear = liYear.toString();
				if (liMonth>=10)
				{
					lsMonth = liMonth.toString();
				}
				else
				{
					lsMonth = "0"+liMonth.toString();
				}
				if (liDay>=10)
				{
					lsDay = liDay.toString();
				}
				else
				{
					lsDay = "0"+liDay.toString();
				}
				return lsYear+"-"+lsMonth+"-"+lsDay;
			}
			function	isSpecialChar(asChar)
			{
				return SPECIALCHARS.indexOf(asChar,0) >= 0;
			}
			function	convDataType(arType)
			{
				if (arType == "NUMBER" || arType == "FLOAT")
				{
					return "NUMBER";
				}
				else
				{
					return "VARCHAR2";
				}
			}
			function	getGrantAndCreateSynonym(asOwner,asProcName)
			{
				var		arrOwner = strOwnerList.split(",");
				var		strRET = "";
				for(i = 0 ; i <arrOwner.length ; i ++)
				{
					if (arrOwner[i] == asOwner) continue;
					strRET += "GRANT ALL ON "+asProcName+" TO "+arrOwner[i]+";"+CRLF;
				}
				strRET += "CREATE PUBLIC SYNONYM "+asProcName+" FOR "+asOwner+"."+asProcName+";"+CRLF+CRLF;
				return strRET;
			}
			function	getInsertProcedure()
			{
				var			strRET = "";
				var			strTABLE_NAME = "";
				var			strPROC_NAME = "";
				var			strColName;
				var			strSelect;
				var			strDataType;
				var			strIsKey;
				var			iCount;
				var			strOwner = dsMAIN.NameString(dsMAIN.RowPosition,"OWNER");
				if (dsMAIN.CountRow < 1) return strRET;
				strTABLE_NAME = dsMAIN.NameString(dsMAIN.RowPosition,"TABLE_NAME");
				strPROC_NAME = "SP_"+strTABLE_NAME + "_I";
				strInsertProcName = strPROC_NAME;
				strRET = "Create Or Replace Procedure "+strPROC_NAME+CRLF;
				if (dsCOLUMN.CountRow < 0) return strRET;
				strRET += "("+CRLF;
				iCount = 0;
				strInsertAddColumn = "";
				strInsertSetValue = "";
				for(i = 1 ; i <= dsCOLUMN.CountRow ; i ++)
				{
					strColName = dsCOLUMN.NameString(i,"COLUMN_NAME");
					strSelect = dsCOLUMN.NameString(i,"ISSELECT");
					if (strSelect == "F")
					{
						if (strColName == "CRTUSERNO")
						{
							alert("CRTUSERNO는 반드시 선택하여 주십시오.");
						}
						continue;
					}
					if (strColName == "CRTDATE" ||
						strColName == "MODUSERNO" ||
						strColName == "MODDATE" )
					{
						continue;
					}
					iCount ++;
					if (iCount == 1)
					{
						strRET += "	AR_"+C_RPad(dsCOLUMN.NameString(i,"COLUMN_NAME"),40," ") +convDataType(dsCOLUMN.NameString(i,"DATA_TYPE"));
					}
					else
					{
						strRET += ","+CRLF+"	AR_"+C_RPad(dsCOLUMN.NameString(i,"COLUMN_NAME"),40," ") +convDataType(dsCOLUMN.NameString(i,"DATA_TYPE"));
					}
					strInsertAddColumn += "						lrArgData.addColumn(\""+strColName+"\", CITData."+convDataType(dsCOLUMN.NameString(i,"DATA_TYPE"))+");"+CRLF;
					if (strColName == "CRTUSERNO") {
						strInsertSetValue +=  "						lrArgData.setValue(\""+strColName+"\", strUserNo);"+CRLF;
					} else {
						strInsertSetValue +=  "						lrArgData.setValue(\""+strColName+"\", rows[i].getString(ds"+txtACT.value+".indexOfColumn(\""+strColName+"\")));"+CRLF;
					}
				}
				iInsertArgCount = iCount;
				strRET += CRLF+")"+CRLF;
				strRET += "Is";
				strRET += getProcedureComment(strPROC_NAME, strTABLE_NAME, "Insert")+CRLF;
				strRET += "Begin"+CRLF;
				strRET += "	Insert Into "+strTABLE_NAME+CRLF;
				strRET += "	("+CRLF;
				iCount = 0;
				for(i = 1 ; i <= dsCOLUMN.CountRow ; i ++)
				{
					strColName = dsCOLUMN.NameString(i,"COLUMN_NAME");
					strSelect = dsCOLUMN.NameString(i,"ISSELECT");
					strDataType = dsCOLUMN.NameString(i,"DATA_TYPE");
					strIsKey = dsCOLUMN.NameString(i,"ISKEY");
					if (strSelect == "F")
					{
						continue;
					}
					iCount ++;

					if (iCount == 1)
					{
						strRET += "		"+strColName;
					}
					else
					{
						strRET += ","+CRLF+"		"+strColName;
					}

				}
				strRET += CRLF+"	)"+CRLF;
				strRET += "	Values"+CRLF;
				strRET += "	("+CRLF;
				iCount = 0;
				for(i = 1 ; i <= dsCOLUMN.CountRow ; i ++)
				{
					strColName = dsCOLUMN.NameString(i,"COLUMN_NAME");
					strSelect = dsCOLUMN.NameString(i,"ISSELECT");
					strDataType = dsCOLUMN.NameString(i,"DATA_TYPE");
					strIsKey = dsCOLUMN.NameString(i,"ISKEY");
					if (strSelect == "F")
					{
						continue;
					}
					if (strColName == "CRTDATE")
					{
						strColName = "SYSDATE";
					}
					else if (strColName == "MODUSERNO")
					{
						strColName = "NULL";
					}
					else if (strColName == "MODDATE" )
					{
						strColName = "NULL";
					}
					else if (strDataType == "DATE")
					{
						strColName = "F_T_StringToDate("+"AR_"+strColName+")";
					}
					else
					{
						strColName = "AR_"+strColName;
					}
					iCount ++;
					if (iCount == 1)
					{
						strRET += "		"+strColName;
					}
					else
					{
						strRET += ","+CRLF+"		"+strColName;
					}
				}
				strRET += CRLF+"	);"+CRLF;
				strRET += "End;"+CRLF;
				strRET += "/"+CRLF;
				//strRET += getGrantAndCreateSynonym(strOwner,strPROC_NAME);
				return strRET;
			}
			function	getUpdateProcedure()
			{
				var			strRET = "";
				var			strTABLE_NAME = "";
				var			strPROC_NAME = "";
				var			strColName;
				var			strSelect;
				var			strDataType;
				var			strIsKey;
				var			strSetName;
				var			iCount;
				var			strOwner = dsMAIN.NameString(dsMAIN.RowPosition,"OWNER");
				if (dsMAIN.CountRow < 1) return strRET;
				strTABLE_NAME = dsMAIN.NameString(dsMAIN.RowPosition,"TABLE_NAME");
				strPROC_NAME = "SP_"+strTABLE_NAME + "_U";
				strUpdateProcName = strPROC_NAME;
				strRET = "Create Or Replace Procedure "+strPROC_NAME+CRLF;
				if (dsCOLUMN.CountRow < 0) return strRET;
				strRET += "("+CRLF;
				iCount = 0;
				strUpdateAddColumn = "";
				strUpdateSetValue =  "";
				for(i = 1 ; i <= dsCOLUMN.CountRow ; i ++)
				{
					strColName = dsCOLUMN.NameString(i,"COLUMN_NAME");
					strSelect = dsCOLUMN.NameString(i,"ISSELECT");
					if (strSelect == "F")
					{
						if (strColName == "MODUSERNO")
						{
							alert("MODUSERNO는 반드시 선택하여 주십시오.");
						}
						continue;
					}
					if (strColName == "CRTDATE" ||
						strColName == "CRTUSERNO" ||
						strColName == "MODDATE" )
					{
						continue;
					}
					iCount ++;
					if (iCount == 1)
					{
						strRET += "	AR_"+C_RPad(dsCOLUMN.NameString(i,"COLUMN_NAME"),40," ") +convDataType(dsCOLUMN.NameString(i,"DATA_TYPE"));
					}
					else
					{
						strRET += ","+CRLF+"	AR_"+C_RPad(dsCOLUMN.NameString(i,"COLUMN_NAME"),40," ") +convDataType(dsCOLUMN.NameString(i,"DATA_TYPE"));
					}
					strUpdateAddColumn += "						lrArgData.addColumn(\""+strColName+"\", CITData."+convDataType(dsCOLUMN.NameString(i,"DATA_TYPE"))+");"+CRLF;
					if (strColName == "MODUSERNO") {
						strUpdateSetValue +=  "						lrArgData.setValue(\""+strColName+"\", strUserNo);"+CRLF;
					} else {
						strUpdateSetValue +=  "						lrArgData.setValue(\""+strColName+"\", rows[i].getString(ds"+txtACT.value+".indexOfColumn(\""+strColName+"\")));"+CRLF;
					}
				}
				iUpdateArgCount = iCount;
				strRET += CRLF+")"+CRLF;
				strRET += "Is";
				strRET += getProcedureComment(strPROC_NAME, strTABLE_NAME, "Update")+CRLF;
				strRET += "Begin"+CRLF;
				strRET += "	Update "+strTABLE_NAME+CRLF;
				strRET += "	Set"+CRLF;
				iCount = 0;
				for(i = 1 ; i <= dsCOLUMN.CountRow ; i ++)
				{
					strColName = dsCOLUMN.NameString(i,"COLUMN_NAME");
					strSelect = dsCOLUMN.NameString(i,"ISSELECT");
					strDataType = dsCOLUMN.NameString(i,"DATA_TYPE");
					strIsKey = dsCOLUMN.NameString(i,"ISKEY");
					if (strSelect == "F")
					{
						continue;
					}
					if (strIsKey == "T")
					{
						continue;
					}
					if (strColName == "CRTDATE")
					{
						continue;
					}
					if (strColName == "CRTUSERNO")
					{
						continue;
					}
					else if (strColName == "MODUSERNO")
					{
						strSetName = "AR_MODUSERNO";
					}
					else if (strColName == "MODDATE" )
					{
						strSetName = "SYSDATE";
					}
					else if (strDataType == "DATE")
					{
						strSetName = "F_T_StringToDate("+"AR_"+strColName+")";
					}
					else
					{
						strSetName = "AR_"+strColName;
					}
					iCount ++;
					if (iCount == 1)
					{
						strRET += "		"+strColName+" = "+strSetName;
					}
					else
					{
						strRET += ","+CRLF+"		"+strColName+" = "+strSetName;
					}
				}
				iCount = 0;
				for(i = 1 ; i <= dsCOLUMN.CountRow ; i ++)
				{
					strColName = dsCOLUMN.NameString(i,"COLUMN_NAME");
					strSelect = dsCOLUMN.NameString(i,"ISSELECT");
					strDataType = dsCOLUMN.NameString(i,"DATA_TYPE");
					strIsKey = dsCOLUMN.NameString(i,"ISKEY");
					if (strIsKey == "F")
					{
						continue;
					}
					if (strDataType == "DATE")
					{
						strSetName = "F_T_StringToDate("+"AR_"+strColName+")";
					}
					else
					{
						strSetName = "AR_"+strColName;
					}
					iCount ++;
					if (iCount == 1)
					{
						strRET += CRLF+"	Where	"+strColName+" = "+strSetName;
					}
					else
					{
						strRET += CRLF+"	And	"+strColName+" = "+strSetName;
					}
				}
				strRET += ";"+CRLF;
				strRET += "End;"+CRLF;
				strRET += "/"+CRLF;
				//strRET += getGrantAndCreateSynonym(strOwner,strPROC_NAME);
				return strRET;
			}
			function	getDeleteProcedure()
			{
				var			strRET = "";
				var			strTABLE_NAME = "";
				var			strPROC_NAME = "";
				var			strColName;
				var			strSelect;
				var			strDataType;
				var			strIsKey;
				var			strSetName;
				var			iCount;
				var			strOwner = dsMAIN.NameString(dsMAIN.RowPosition,"OWNER");
				if (dsMAIN.CountRow < 1) return strRET;
				strTABLE_NAME = dsMAIN.NameString(dsMAIN.RowPosition,"TABLE_NAME");
				strPROC_NAME = "SP_"+strTABLE_NAME + "_D";
				strDeleteProcName = strPROC_NAME;
				strRET = "Create Or Replace Procedure "+strPROC_NAME+CRLF;
				if (dsCOLUMN.CountRow < 0) return strRET;
				strRET += "("+CRLF;
				iCount = 0;
				strDeleteAddColumn = "";
				strDeleteSetValue =  "";
				for(i = 1 ; i <= dsCOLUMN.CountRow ; i ++)
				{
					strColName = dsCOLUMN.NameString(i,"COLUMN_NAME");
					strSelect = dsCOLUMN.NameString(i,"ISSELECT");
					strIsKey = dsCOLUMN.NameString(i,"ISKEY");
					if (strIsKey == "F")
					{
						continue;
					}
					iCount ++;
					if (iCount == 1)
					{
						strRET += "	AR_"+C_RPad(dsCOLUMN.NameString(i,"COLUMN_NAME"),40," ") +convDataType(dsCOLUMN.NameString(i,"DATA_TYPE"));
					}
					else
					{
						strRET += ","+CRLF+"	AR_"+C_RPad(dsCOLUMN.NameString(i,"COLUMN_NAME"),40," ") +convDataType(dsCOLUMN.NameString(i,"DATA_TYPE"));
					}
					strDeleteAddColumn += "						lrArgData.addColumn(\""+strColName+"\", CITData."+convDataType(dsCOLUMN.NameString(i,"DATA_TYPE"))+");"+CRLF;
					strDeleteSetValue +=  "						lrArgData.setValue(\""+strColName+"\", rows[i].getString(ds"+txtACT.value+".indexOfColumn(\""+strColName+"\")));"+CRLF;
				}
				iDeleteArgCount = iCount;
				strRET += CRLF+")"+CRLF;
				strRET += "Is";
				strRET += getProcedureComment(strPROC_NAME, strTABLE_NAME,"Delete")+CRLF;
				strRET += "Begin"+CRLF;
				strRET += "	Delete "+strTABLE_NAME;
				iCount = 0;
				for(i = 1 ; i <= dsCOLUMN.CountRow ; i ++)
				{
					strColName = dsCOLUMN.NameString(i,"COLUMN_NAME");
					strSelect = dsCOLUMN.NameString(i,"ISSELECT");
					strDataType = dsCOLUMN.NameString(i,"DATA_TYPE");
					strIsKey = dsCOLUMN.NameString(i,"ISKEY");
					if (strIsKey == "F")
					{
						continue;
					}
					if (strDataType == "DATE")
					{
						strSetName = "F_T_StringToDate("+"AR_"+strColName+")";
					}
					else
					{
						strSetName = "AR_"+strColName;
					}
					iCount ++;
					if (iCount == 1)
					{
						strRET += CRLF+"	Where	"+strColName+" = "+strSetName;
					}
					else
					{
						strRET += CRLF+"	And	"+strColName+" = "+strSetName;
					}
				}
				strRET += ";"+CRLF;
				strRET += "End;"+CRLF;
				strRET += "/"+CRLF;
				//strRET += getGrantAndCreateSynonym(strOwner,strPROC_NAME);
				return strRET;
			}
			function	getConvToJSP()
			{
				var			strRET = "";
				strRET = "<"+"%@ page import=\"com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*\" errorPage=\"../common/Error.jsp\" contentType=\"text/html;charset=euc-kr\"%"+">"+CRLF;
				strRET += "<"+"%";
				strRET += getDefaultComment()+CRLF;
				strRET += "	CITGauceInfo GauceInfo = null;"+CRLF;
				strRET += "	"+CRLF;
				strRET += "	//Dataset이 여러개이면 이부분을 복사에 붙이셔요(시작)"+CRLF;
				strRET += "	GauceDataSet ds"+txtACT.value+" = null;"+CRLF;
				strRET += "	//Dataset이 여러개이면 이부분을 복사에 붙이셔요(끝)"+CRLF;
				strRET += "	//Dataset이 여러개이면 아래 나타나는 부분중 '//복사시작' 에서 '//복사끝' 까지를 기존 갱신 페이지의 '//여기에 붙여넣으세요' 자리에 붙여넣으세요"+CRLF;
				strRET += "	"+CRLF;
				strRET += "	GauceDataRow[] rows = null;"+CRLF;
				strRET += "	"+CRLF;
				strRET += "	String strSql = \"\";"+CRLF;
				strRET += "	String strAct = \"\";"+CRLF;
				strRET += "	String strUserNo = \"\";"+CRLF;
				strRET += "	Connection conn = null;"+CRLF;
				strRET += "	"+CRLF;
				strRET += "	try"+CRLF;
				strRET += "	{"+CRLF;
				strRET += "		GauceInfo = CITCommon.initServerPage(request, response, session);"+CRLF;
				strRET += "		/* 세션정보 */"+CRLF;
				strRET += "		strUserNo = CITCommon.toKOR((String)session.getAttribute(\"emp_no\"));"+CRLF;
				strRET += "		conn = CITConnectionManager.getConnection(false);"+CRLF;
				strRET += "		"+CRLF;
				strRET += "		strAct = GauceInfo.request.getParameter(\"ACT\");"+CRLF;
				strRET += "		"+CRLF;
				strRET += "		if (CITCommon.isNull(strAct))"+CRLF;
				strRET += "		{"+CRLF;
				strRET += "	//복사시작"+CRLF;
				strRET += "			ds"+txtACT.value+" = GauceInfo.request.getGauceDataSet(\"ds"+txtACT.value+"\");"+CRLF;
				strRET += "			"+CRLF;
				strRET += "			if (ds"+txtACT.value+" == null) throw new Exception(\"ds" + txtACT.value + "이(가) 널(Null)입니다.\");"+CRLF;
				strRET += "			"+CRLF;
				strRET += "			rows = ds"+txtACT.value+".getDataRows();"+CRLF;
				strRET += "			"+CRLF;
				strRET += "			try"+CRLF;
				strRET += "			{"+CRLF;
				strRET += "				for	(int i = 0;	i <	rows.length; i++)"+CRLF;
				strRET += "				{"+CRLF;
				strRET += "					CITData lrArgData = new CITData();"+CRLF;
				strRET += "					"+CRLF;
				strRET += "					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)"+CRLF;
				strRET += "					{"+CRLF;
				strRET += getCallState(strInsertProcName,iInsertArgCount);
				strRET += "						"+CRLF;
				strRET += strInsertAddColumn+CRLF;
				strRET += "						lrArgData.addRow();"+CRLF;
				strRET += strInsertSetValue;
				strRET += "					}"+CRLF;
				strRET += "					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)"+CRLF;
				strRET += "					{"+CRLF;
				strRET += getCallState(strUpdateProcName,iUpdateArgCount);
				strRET += "						"+CRLF;
				strRET += strUpdateAddColumn+CRLF;
				strRET += "						lrArgData.addRow();"+CRLF;
				strRET += strUpdateSetValue;
				strRET += "					}"+CRLF;
				strRET += "					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)"+CRLF;
				strRET += "					{"+CRLF;
				strRET += getCallState(strDeleteProcName,iDeleteArgCount);
				strRET += "						"+CRLF;
				strRET += strDeleteAddColumn+CRLF;
				strRET += "						lrArgData.addRow();"+CRLF;
				strRET += strDeleteSetValue;
				strRET += "					}"+CRLF;
				strRET += "					else"+CRLF;
				strRET += "					{"+CRLF;
				strRET += "						continue;"+CRLF;
				strRET += "					}"+CRLF;
				strRET += "					"+CRLF;
				strRET += "					CITDatabase.executeProcedure(strSql, lrArgData, conn);"+CRLF;
				strRET += "				}"+CRLF;
				strRET += "			}"+CRLF;
				strRET += "			catch (Exception ex)"+CRLF;
				strRET += "			{"+CRLF;
				strRET += "				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);"+CRLF;
				strRET += "				GauceInfo.response.writeException(\"USER\", \"900001\", \"" + txtTABLE_NAME.value + " 테이블 데이타 갱신 에러\" + ex.getMessage());"+CRLF;
				strRET += "				throw new Exception(ex.getMessage());"+CRLF;
				strRET += "			}"+CRLF;
				strRET += "	//복사끝"+CRLF;
				strRET += "	//여기에 붙여넣으세요"+CRLF;
				strRET += "		}"+CRLF;
				strRET += "		conn.commit();"+CRLF;
				strRET += "	}"+CRLF;
				strRET += "	catch (Exception ex)"+CRLF;
				strRET += "	{"+CRLF;
				strRET += "		if (conn != null) conn.rollback();"+CRLF;
				strRET += "		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);"+CRLF;
				strRET += "		GauceInfo.response.writeException(\"SYS\", \"100001\", \"페이지 초기화 오류 -> \" + ex.getMessage());"+CRLF;
				strRET += "	}"+CRLF;
				strRET += "	finally"+CRLF;
				strRET += "	{"+CRLF;
				strRET += "		try"+CRLF;
				strRET += "		{"+CRLF;
				strRET += "			CITConnectionManager.freeConnection(conn);"+CRLF;
				strRET += "			CITCommon.finalServerPage(GauceInfo);"+CRLF;
				strRET += "		}"+CRLF;
				strRET += "	    catch (Exception ex)"+CRLF;
				strRET += "	    {"+CRLF;
				strRET += "			if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);"+CRLF;
				strRET += "	    	GauceInfo.response.writeException(\"SYS\", \"100002\", \"페이지 종료 오류 -> \" + ex.getMessage());"+CRLF;
				strRET += "	    }"+CRLF;
				strRET += "	}"+CRLF;
				strRET += "%"+">"+CRLF;
				return strRET;
			}
			function	getConvToPLSQL()
			{
				return getInsertProcedure()+getUpdateProcedure()+getDeleteProcedure();
			}
			// 이벤트관련-------------------------------------------------------------------//
			function	btnRetrieve_onClick()
			{
				G_Load(dsMAIN,null);
			}
			function	btnTransForm_onClick()
			{
				txtSP.value = getConvToPLSQL();
				txtJSP.value = getConvToJSP();
			}

		//-->
		</script>
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
			<param name="SyncLoad" value="-1">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsCOLUMN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
			<param name="SyncLoad" value="-1">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
	</head>
	<body onload="C_Initialize()">
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
			<tr height="*">
				<td width="100%" align="left" valign="top">
					<!-- 표준 페이지의 고정 DIV 시작 : 크기(폭:800px, 높이:530px) //-->
					<div id="divMainFix" class="main_div">
					<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
						<tr valign="top">
							<td width="100%" >
								<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td>
											<!-- 현재위치 테이블 시작 //-->
											<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td>
														<table width="100%" border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td width="60">
																	작성자 :
																</td>
																<td width="65">
																	<input id="txtCRTUSERNAME" type="text" VALUE="홍길동"   style="width:60px">
																</td>
																<td width="60">
																	작성일 :
																</td>
																<td width="80">
																	<input id="txtCRTDATE" type="text" datatype="DATE" VALUE=""   style="width:75px">
																</td>
																<td width="60">
																	ACT :
																</td>
																<td width="80">
																	<input id="txtACT" type="text" VALUE="MAIN"   style="width:75px">
																</td>
																<td>&nbsp;</td>
															</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td height="1" bgcolor="#CCCCCC"></td>
												</tr>
											</table>
											<!-- 현재위치 테이블 종료 //-->
										</td>
									</tr>
									<tr height="100%">
										<td  height="100%">
											<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
												<tr  height="100%">
													<td  height="100%" width="350" >
														<!-- 서브 테이블 시작 //-->
														<!-- 서브 본문 시작 //-->
														<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td>
																	<!-- 서브 타이틀 시작 //-->
																	<table width="100%" border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<!-- 프로그래머 수정 시작 //-->
																			<td width="15" height="20"><img src="../images/bullet1.gif" width="9" height="9"></td>
																			<td class="font_green_bold"> 테이블</td>
																			<td align="right">
																				<input id="txtTABLE_NAME" type="text" VALUE=""   style="width:100px">
																				<input name="btnRetrieve" type="button" class="img_btn2_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT "value="조회" onclick="btnRetrieve_onClick()"/>
																				<input name="btnTransForm" type="button" class="img_btn2_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT "value="변환" onclick="btnTransForm_onClick()"/>
																			</td>
																			<!-- 프로그래머 수정 종료 //-->
																		</tr>
																	</table>
																	<!-- 서브 타이틀 종료 //-->
																</td>
															</tr>
															<tr >
																<td width="100%" >
																	<table width="100%" border="0" cellspacing="0" cellpadding="0">
																		<tr class="head_line">
																			<td width="*" height="3"></td>
																		</tr>
																		<tr>
																			<td bgcolor="#FFFFFF" height="100%">
																				<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="150" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT codebase="../../../cabfiles/toinbgrid.cab#version=1,1,0,125">
																					<PARAM NAME="Editable" VALUE="0">
																					<PARAM NAME="ColSelect" VALUE="-1">
																					<PARAM NAME="ColSizing" VALUE="-1">
																					<PARAM NAME="UsingOneClick" VALUE="-1">
																					<PARAM NAME="Format" VALUE="
																						<C> Name='소유자' ID='OWNER' Align=Center  Edit=None HeadAlign=Center HeadBgColor=#d4d0c8 SumBgColor=#d4d0c8 Width=100
																						</C>
																						<C> Name='테이블명' ID='TABLE_NAME' Align=Left  Edit=None HeadAlign=Center HeadBgColor=#d4d0c8 SumBgColor=#d4d0c8 Width=210
																						</C>
																						">
																					<PARAM NAME="DataID" VALUE="dsMAIN">
																				</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
																			</td>
																		</tr>
																		<tr class="head_line">
																			<td width="*" height="3" ></td>
																		</tr>
																	</table>
																</td>
															</tr>
															<tr>
																<td>
																	<!-- 서브 타이틀 시작 //-->
																	<table width="100%" border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<!-- 프로그래머 수정 시작 //-->
																			<td width="15" height="20"><img src="../images/bullet1.gif" width="9" height="9"></td>
																			<td class="font_green_bold"> 컬럼 목록</td>
																			<td align="right">

																			</td>
																			<!-- 프로그래머 수정 종료 //-->
																		</tr>
																	</table>
																	<!-- 서브 타이틀 종료 //-->
																</td>
															</tr>
															<tr height="100%">
																<td width="100%"  height="100%">
																	<table width="100%"  height="100%" border="0" cellspacing="0" cellpadding="0">
																		<tr class="head_line">
																			<td width="*" height="3"></td>
																		</tr>
																		<tr>
																			<td bgcolor="#FFFFFF" height="100%">
																				<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridCOLUMN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT codebase="../../../cabfiles/toinbgrid.cab#version=1,1,0,125">
																					<PARAM NAME="Editable" VALUE="-1">
																					<PARAM NAME="ColSelect" VALUE="-1">
																					<PARAM NAME="ColSizing" VALUE="-1">
																					<PARAM NAME="UsingOneClick" VALUE="-1">
																					<PARAM NAME="Format" VALUE="
																						<FC> Name='컬럼명' ID='COLUMN_NAME' Align=Left Edit=None HeadAlign=Center HeadBgColor=#d4d0c8 SumBgColor=#d4d0c8 Width=120
																						</FC>
																						<C> Name='키여부' ID='ISKEY' Align=Center HeadAlign=Center EditStyle=CheckBox HeadBgColor=#d4d0c8 SumBgColor=#d4d0c8 Width=55
																						</C>
																						<C> Name='선택' ID='ISSELECT' Align=Center HeadAlign=Center EditStyle=CheckBox HeadBgColor=#d4d0c8 SumBgColor=#d4d0c8 Width=55
																						</C>
																						<C> Name='데이타형' ID='DATA_TYPE' Align=Left Edit=None  HeadAlign=Center HeadBgColor=#d4d0c8 SumBgColor=#d4d0c8 Width=80
																						</C>
																						">
																					<PARAM NAME="DataID" VALUE="dsCOLUMN">
																				</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
																			</td>
																		</tr>
																		<tr class="head_line">
																			<td width="*" height="3" ></td>
																		</tr>
																	</table>
																</td>
															</tr>
														</table>
														<!-- 서브 본문 종료 //-->
														<!-- 서브 테이블 종료 //-->
													</td>
													<td width="10">
														&nbsp;
													</td>
													<td  height="100%">
														<!-- 서브 테이블 시작 //-->
														<!-- 서브 본문 시작 //-->
														<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td>
																	<!-- 서브 타이틀 시작 //-->
																	<table width="100%" border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<!-- 프로그래머 수정 시작 //-->
																			<td width="15" height="20"><img src="../images/bullet1.gif" width="9" height="9"></td>
																			<td class="font_green_bold"> 저장프로시져</td>
																			<td align="right">
																			</td>
																			<!-- 프로그래머 수정 종료 //-->
																		</tr>
																	</table>
																	<!-- 서브 타이틀 종료 //-->
																</td>
															</tr>
															<tr>
																<td width="100%" height="200">
																	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
																		<tr class="head_line">
																			<td width="*" height="3"></td>
																		</tr>
																		<tr  height="100%">
																			<td bgcolor="#FFFFFF" height="100%">
																				<textarea name="txtSP" style="width:100% ; height:100% " wrap="off"></textarea>
																			</td>
																		</tr>
																		<tr class="head_line">
																			<td width="*" height="3"></td>
																		</tr>
																	</table>
																</td>
															</tr>
															<tr>
																<td>
																	<!-- 서브 타이틀 시작 //-->
																	<table width="100%" border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<!-- 프로그래머 수정 시작 //-->
																			<td width="15" height="20"><img src="../images/bullet1.gif" width="9" height="9"></td>
																			<td class="font_green_bold"> JSP</td>
																			<td align="right">
																			</td>
																			<!-- 프로그래머 수정 종료 //-->
																		</tr>
																	</table>
																	<!-- 서브 타이틀 종료 //-->
																</td>
															</tr>
															<tr height="100%">
																<td width="100%" height="100%">
																	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
																		<tr class="head_line">
																			<td width="*" height="3"></td>
																		</tr>
																		<tr  height="100%">
																			<td bgcolor="#FFFFFF" height="100%">
																				<textarea name="txtJSP" style="width:100% ; height:100% " wrap="off"></textarea>
																			</td>
																		</tr>
																		<tr class="head_line">
																			<td width="*" height="3"></td>
																		</tr>
																	</table>
																</td>
															</tr>
														</table>
														<!-- 서브 본문 종료 //-->
														<!-- 서브 테이블 종료 //-->
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					</div>
					<!-- 표준 페이지의 고정 DIV 종료 //-->
				</td>
			</tr>
		</table>
	</body>
</html>
