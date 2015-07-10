<%@ page language="java" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,com.cj.common.*, com.cj.util.*, com.cj.database.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
	CITData lrReturnData = null;
	String	strOut = "";
	String	strACT = "";
	String	strSQL_TEXT = "";
	String	strCOLUMNS = "";
    try
    {
		CITCommon.initPage(request, response, session, false);

    	strACT = CITCommon.toKOR(request.getParameter("ACT"));


    	if(strACT.equals("PARSE"))
    	{
    		strSQL_TEXT = CITCommon.toKOR(request.getParameter("SQL_TEXT"));
			CITData lrArgData = new CITData();
			lrArgData.addColumn("RET",CITData.VARCHAR2,true);
			lrArgData.addColumn("SQL_TEXT",CITData.VARCHAR2);
			lrArgData.addColumn("SQL_TAG",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("SQL_TEXT",strSQL_TEXT);
			lrArgData.setValue("SQL_TAG","CT");

			String	strSQL;
			strSQL = "{?= call F_T_DESCRIBE_COLUMN(?,?)}";
			CITDatabase.executeProcedure(strSQL,lrArgData);
			strCOLUMNS = lrArgData.toString(0,"RET");
    	}
	}
	catch (Exception ex)
	{
		strACT = "ERROR";
		strCOLUMNS = ex.getMessage();
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title></title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript">
		<!--
			function	Initialize()
			{
				if(frmList.ACT.value == "PARSE")
				{
					frmList.ACT.value = "";
					parent.reportParse(frmList.COLUMNS.value);
				}
				else if(frmList.ACT.value == "ERROR")
				{
					frmList.ACT.value = "";
					alert(frmList.COLUMNS.value);
				}
				frmList.ACT.value = "";
			}
			function	parseSQL(arSQL)
			{
				frmList.ACT.value = "PARSE";
				frmList.SQL_TEXT.value = arSQL;
				frmList.submit();
			}
		//-->
		</script>
	</head>
	<body onload="C_Initialize()">
	    <FORM name="frmList" action="./t_WSelectGen_01.jsp" target="_self" method="post">
			<INPUT type='hidden' name='ACT' value="<%=strACT%>">
			<INPUT type='hidden' name="SQL_TEXT" value="">
			<INPUT type='hidden' name="COLUMNS" value="<%=strCOLUMNS%>">
		</FORM>
	</body>
</html>
