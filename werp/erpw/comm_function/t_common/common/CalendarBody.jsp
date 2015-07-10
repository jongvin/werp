<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="Error.jsp" contentType="text/html;charset=euc-kr" %>
<%!
	private String LPad(String asValue, int aiLength, char acPadChar) throws Exception
	{
		if (CITCommon.isNull(asValue)) asValue = "";
		if (aiLength <= asValue.getBytes("KSC5601").length) return asValue;
		if (CITCommon.isNull(Character.toString(acPadChar))) acPadChar = ' ';
		
		byte [] lbTemp = asValue.getBytes("KSC5601");
		byte [] lbData = new byte[aiLength];
		int liAddCnt = aiLength - lbTemp.length;
		
		for (int i = 0; i < liAddCnt; i++)
		{
			lbData[i] = Byte.parseByte(Integer.toString(new Character(acPadChar).hashCode()));
		}
		
		for (int i = 0; i < lbTemp.length; i++)
		{
			lbData[i + liAddCnt] = lbTemp[i];
		}
		
		return new String(lbData);
	}
%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : CalendarBody(달력-년월일,년월)
/* 2. 유형(시나리오) : 달력
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 강덕율 작성(2005-10-31)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrWeek = null;
	Calendar calendar = null;
	String strOut = "";
	String strSql = "";
	
	String strCalendarID = "";
	String strType = "";
	String strDate = "";
	String strToDay = "";
	String strYear = "";
	String strMonth = "";
	String strDay = "";
	boolean isLast = false;
	
	try
	{
		CITCommon.initPage(request, response, session);
		
		strCalendarID = CITCommon.toKOR(request.getParameter("CID"));
		strType = CITCommon.toKOR(request.getParameter("TYPE"));
		strDate = CITCommon.toKOR(request.getParameter("DATE"));
		
		if (!CITCommon.isNull(strDate))
		{
			try
			{
				calendar = CITDate.getDateCalendar(strDate);
			}
			catch (Exception ex)
			{
				calendar = Calendar.getInstance();
			}
		}
		else
		{
			calendar = Calendar.getInstance();
		}
		
		strDate = CITDate.toString(calendar.getTime());
		strToDay = CITDate.getNow();
		
		strYear = strDate.substring(0, 4);
		strMonth = strDate.substring(5, 7);
		strDay = strDate.substring(8, 10);
		
		// 해당 년월의 1일로 설정
		calendar.set(Integer.parseInt(strYear), Integer.parseInt(strMonth) - 1, 1, 0, 0, 0);
		
		lrWeek = new CITData();
		
		lrWeek.addColumn("SUN", CITData.VARCHAR2);
		lrWeek.addColumn("MON", CITData.VARCHAR2);
		lrWeek.addColumn("TUE", CITData.VARCHAR2);
		lrWeek.addColumn("WED", CITData.VARCHAR2);
		lrWeek.addColumn("THU", CITData.VARCHAR2);
		lrWeek.addColumn("FRI", CITData.VARCHAR2);
		lrWeek.addColumn("SAT", CITData.VARCHAR2);
		
		isLast = true;
		
		for (int i = 0; i < 31; i++)
		{
			if (calendar.get(Calendar.MONTH) != Integer.parseInt(strMonth) - 1) break;
			
			if (isLast)
			{
				isLast = false;
				
				lrWeek.addRow();
				
				lrWeek.setValue("SUN", "NA");
				lrWeek.setValue("MON", "NA");
				lrWeek.setValue("TUE", "NA");
				lrWeek.setValue("WED", "NA");
				lrWeek.setValue("THU", "NA");
				lrWeek.setValue("FRI", "NA");
				lrWeek.setValue("SAT", "NA");
			}
			
			switch (calendar.get(Calendar.DAY_OF_WEEK))
			{
				case Calendar.SUNDAY :
					lrWeek.setValue("SUN", Integer.toString(calendar.get(Calendar.DATE)));
					break;
				case Calendar.MONTH :
					lrWeek.setValue("MON", Integer.toString(calendar.get(Calendar.DATE)));
					break;
				case Calendar.TUESDAY :
					lrWeek.setValue("TUE", Integer.toString(calendar.get(Calendar.DATE)));
					break;
				case Calendar.WEDNESDAY :
					lrWeek.setValue("WED", Integer.toString(calendar.get(Calendar.DATE)));
					break;
				case Calendar.THURSDAY :
					lrWeek.setValue("THU", Integer.toString(calendar.get(Calendar.DATE)));
					break;
				case Calendar.FRIDAY :
					lrWeek.setValue("FRI", Integer.toString(calendar.get(Calendar.DATE)));
					break;
				case Calendar.SATURDAY :
					lrWeek.setValue("SAT", Integer.toString(calendar.get(Calendar.DATE)));
					isLast = true;
					break;
			}
			
			calendar.add(Calendar.DATE, 1);
		}
		
		if (strType.equals("D"))
		{
			for (int i = 0; i < lrWeek.getRowsCount(); i++)
			{
				String lsSUN = lrWeek.toString(i, "SUN").equals("NA") ? "" : lrWeek.toString(i, "SUN");
				String lsMON = lrWeek.toString(i, "MON").equals("NA") ? "" : lrWeek.toString(i, "MON");
				String lsTUE = lrWeek.toString(i, "TUE").equals("NA") ? "" : lrWeek.toString(i, "TUE");
				String lsWED = lrWeek.toString(i, "WED").equals("NA") ? "" : lrWeek.toString(i, "WED");
				String lsTHU = lrWeek.toString(i, "THU").equals("NA") ? "" : lrWeek.toString(i, "THU");
				String lsFRI = lrWeek.toString(i, "FRI").equals("NA") ? "" : lrWeek.toString(i, "FRI");
				String lsSAT = lrWeek.toString(i, "SAT").equals("NA") ? "" : lrWeek.toString(i, "SAT");
				
				String lsColor1 = strToDay.equals(strYear + "-" + strMonth + "-" + LPad(lrWeek.toString(i, "SUN"), 2, '0')) ? "#C0C0C0" : "#FFFFFF";
				String lsColor2 = strToDay.equals(strYear + "-" + strMonth + "-" + LPad(lrWeek.toString(i, "MON"), 2, '0')) ? "#C0C0C0" : "#FFFFFF";
				String lsColor3 = strToDay.equals(strYear + "-" + strMonth + "-" + LPad(lrWeek.toString(i, "TUE"), 2, '0')) ? "#C0C0C0" : "#FFFFFF";
				String lsColor4 = strToDay.equals(strYear + "-" + strMonth + "-" + LPad(lrWeek.toString(i, "WED"), 2, '0')) ? "#C0C0C0" : "#FFFFFF";
				String lsColor5 = strToDay.equals(strYear + "-" + strMonth + "-" + LPad(lrWeek.toString(i, "THU"), 2, '0')) ? "#C0C0C0" : "#FFFFFF";
				String lsColor6 = strToDay.equals(strYear + "-" + strMonth + "-" + LPad(lrWeek.toString(i, "FRI"), 2, '0')) ? "#C0C0C0" : "#FFFFFF";
				String lsColor7 = strToDay.equals(strYear + "-" + strMonth + "-" + LPad(lrWeek.toString(i, "SAT"), 2, '0')) ? "#C0C0C0" : "#FFFFFF";
				
				strOut += "<TR align='center'> \n";
				strOut += "    <td width='24' bgcolor='" + lsColor1 + "'><a href='#' onClick=\"ChoiceD('" + LPad(lrWeek.toString(i, "SUN"), 2, '0') + "')\"><font color='red'>" + lsSUN + "</font></a></td> \n";
				strOut += "    <td width='24' bgcolor='" + lsColor2 + "'><a href='#' onClick=\"ChoiceD('" + LPad(lrWeek.toString(i, "MON"), 2, '0') + "')\">" + lsMON + "</a></td> \n";
				strOut += "    <td width='24' bgcolor='" + lsColor3 + "'><a href='#' onClick=\"ChoiceD('" + LPad(lrWeek.toString(i, "TUE"), 2, '0') + "')\">" + lsTUE + "</a></td> \n";
				strOut += "    <td width='24' bgcolor='" + lsColor4 + "'><a href='#' onClick=\"ChoiceD('" + LPad(lrWeek.toString(i, "WED"), 2, '0') + "')\">" + lsWED + "</a></td> \n";
				strOut += "    <td width='24' bgcolor='" + lsColor5 + "'><a href='#' onClick=\"ChoiceD('" + LPad(lrWeek.toString(i, "THU"), 2, '0') + "')\">" + lsTHU + "</a></td> \n";
				strOut += "    <td width='24' bgcolor='" + lsColor6 + "'><a href='#' onClick=\"ChoiceD('" + LPad(lrWeek.toString(i, "FRI"), 2, '0') + "')\">" + lsFRI + "</a></td> \n";
				strOut += "    <td width='24' bgcolor='" + lsColor7 + "'><a href='#' onClick=\"ChoiceD('" + LPad(lrWeek.toString(i, "SAT"), 2, '0') + "')\"><font color='blue'>" + lsSAT + "</font></a></td> \n";
				strOut += "</TR> \n";
			}
			
			if (lrWeek.getRowsCount() < 6)
			{
				for (int i = lrWeek.getRowsCount(); i < 6; i++)
				{
					strOut += "<TR align='center'> \n";
					strOut += "    <td width='24'>&nbsp;</td> \n";
					strOut += "    <td width='24'>&nbsp;</td> \n";
					strOut += "    <td width='24'>&nbsp;</td> \n";
					strOut += "    <td width='24'>&nbsp;</td> \n";
					strOut += "    <td width='24'>&nbsp;</td> \n";
					strOut += "    <td width='24'>&nbsp;</td> \n";
					strOut += "    <td width='24'>&nbsp;</td> \n";
					strOut += "</TR> \n";
				}
			}
		}
		else if (strType.equals("M"))
		{
			strOut += "<TR align='center'> \n";
			strOut += "    <td width='30'><a href='#' onClick=\"ChoiceM('01')\">01</a></td> \n";
			strOut += "    <td width='30'><a href='#' onClick=\"ChoiceM('02')\">02</a></td> \n";
			strOut += "    <td width='30'><a href='#' onClick=\"ChoiceM('03')\">03</a></td> \n";
			strOut += "    <td width='30'><a href='#' onClick=\"ChoiceM('04')\">04</a></td> \n";
			strOut += "    <td width='30'><a href='#' onClick=\"ChoiceM('05')\">05</a></td> \n";
			strOut += "    <td width='30'><a href='#' onClick=\"ChoiceM('06')\">06</a></td> \n";
			strOut += "</TR> \n";
			strOut += "<TR align='center'> \n";
			strOut += "    <td width='30'><a href='#' onClick=\"ChoiceM('07')\">07</a></td> \n";
			strOut += "    <td width='30'><a href='#' onClick=\"ChoiceM('08')\">08</a></td> \n";
			strOut += "    <td width='30'><a href='#' onClick=\"ChoiceM('09')\">09</a></td> \n";
			strOut += "    <td width='30'><a href='#' onClick=\"ChoiceM('10')\">10</a></td> \n";
			strOut += "    <td width='30'><a href='#' onClick=\"ChoiceM('11')\">11</a></td> \n";
			strOut += "    <td width='30'><a href='#' onClick=\"ChoiceM('12')\">12</a></td> \n";
			strOut += "</TR> \n";
		}
	}
	catch (Exception ex)
	{
		throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>회계관리</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<style type="text/css">
		<!--
			a:link		{ text-decoration: none ; color: #000000; }
			a:visited	{ text-decoration: none ; color: #000000; }
			a:active	{ text-decoration: underline ; color: #000000; }
			a:hover		{ text-decoration: underline ; color: #000000; }
		//-->
		</style>
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript">
		<!--
			var strCalendarID = "<%=strCalendarID%>";
			var strYear = "<%=strYear%>";
			var strMonth = "<%=strMonth%>";
			var strDay = "<%=strDay%>";
			
			function Initialize()
			{
				document.body.topMargin = 0;
				document.body.leftMargin = 0;
			}
			
			// 함수관련---------------------------------------------------------------------//
			function ChoiceM(asValue)
			{
				if (C_isNull(asValue) || asValue == "NA") return;
				
				parent.parent.C_CalendarHide(strCalendarID, strYear + "-" + asValue);
			}
			
			function ChoiceD(asValue)
			{
				if (C_isNull(asValue) || asValue == "NA") return;
				
				parent.parent.C_CalendarHide(strCalendarID, strYear + "-" + strMonth + "-" + asValue);
			}
			
			function Cancle()
			{
				parent.parent.C_CalendarHide(-1);
			}
			
			// 공통 재정의 이벤트관련-------------------------------------------------------//
			
			// 이벤트관련-------------------------------------------------------------------//
			function document_onKeyPress()
			{
				if (event.keyCode == 27)
				{
					Cancle();
				}
			}
			
		//-->
		</script>
		
	</head>
	<body onload="C_Initialize()" onkeypress="javascript:document_onKeyPress()">
		<TABLE id="tableMain" cellSpacing="0" cellPadding="0" width="100%" height="100%" border="0">
			<TR >
				<TD align="center">
					<!-- 표준 팝업 페이지의 최소 DIV 크기(폭:250px 이상, 높이:400px 고정) //-->
					<DIV id="divPopMain" style="WIDTH: 100%; HEIGHT: 100%;">
						<TABLE width="100%" cellSpacing="0" cellPadding="0" border="0" >
							<%=strOut%>
						</TABLE>
					</DIV>
				</TD>
			</TR>
		</TABLE>
	</body>
</html>
<%
	try
	{
		CITCommon.finalPage();
	}
	catch (Exception ex)
	{
		throw new Exception("페이지 종료 오류 -> " + ex.getMessage());
	}
%>