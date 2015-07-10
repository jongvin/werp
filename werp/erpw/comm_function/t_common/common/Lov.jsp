<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : Lov(공통팝업)
/* 2. 유형(시나리오) : 공통팝업
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 강덕율 작성(2005-10-31)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 :
/**************************************************************************/

	CITData lrLov = null;
	CITData lrArgs = null;
	CITData lrCols = null;
	CITData lrFilters = null;
	CITData lrFilterArgs = null;
	CITData lrFilterRels = null;
	CITData lrNotRelFilters = null;
	
	String strSql = "";
	String strOut = "";
	String strLovName = "";
	String strState = "";
	String strErrMsg = "";
	
	String strFilterHeight = "30";
	String strFilterHtml = "";
	String strFilterDatasetHtml = "";
	String strFilterAddDatasetScript = "";
	String strFilterAddRelScript = "";
	String strMainLoadBeforeScript = "";
	String strDefaultValueScript = "";
	String strComboDefaultValueScript = "";
	String strLoadDatasetScript = "";
	String strFilterLoadBeforeScript = "";
	String strCalendarResultScript = "";
	String strSessionValueScript = "";
	
	String strLovNo = "0";
	String strTitle = "";
	String strWidth = "0";
	String strHeight = "0";
	String strX = "0";
	String strY = "0";
	String strAutoLoad = "";
	String strMultiSelect = "";
	
	String strLastFilterId = "";
	
	
	
	try
	{
		CITCommon.initPage(request, response, session);
		
		strLovName = CITCommon.toKOR(request.getParameter("LOV_NAME"));
		strAutoLoad = CITCommon.toKOR(request.getParameter("AUTO_LOAD"));
		strMultiSelect = CITCommon.toKOR(request.getParameter("MULTI_SELECT"));
		
		CITData lrArgData = new CITData();
		
		// Lov 정보
		lrArgData.addColumn("NAME", CITData.VARCHAR2);
		lrArgData.addRow();
		lrArgData.setValue("NAME", strLovName);
		
		strSql  = " Select * \n";
		strSql += " From   T_LOV \n";
		strSql += " Where  NAME = ? \n";
		
		lrLov = CITDatabase.selectQuery(strSql, lrArgData);
		
		if (CITCommon.isNull(strLovName) || lrLov.getRowsCount() < 1)
		{
			strState = "E";
			strErrMsg = "LOV가 존재하지 않습니다.";
		}
		else
		{
			strLovNo = lrLov.toString(0, "LOV_NO");
			strTitle = lrLov.toString(0, "TITLE");
			strWidth = lrLov.toString(0, "WIDTH");
			strHeight = lrLov.toString(0, "HEIGHT");
			strX = lrLov.toString(0, "LOCATION_X");
			strY = lrLov.toString(0, "LOCATION_Y");
			strAutoLoad = CITCommon.isNull(strAutoLoad) ? lrLov.toString(0, "AUTO_LOAD") : strAutoLoad;
			
			lrArgData.removeAll();
			
			// 인자 정보
			lrArgData.addColumn("LOV_NO", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("LOV_NO", strLovNo);
			
			strSql  = " Select * \n";
			strSql += " From   T_LOV_ARGS \n";
			strSql += " Where  LOV_NO = ? \n";
			strSql += " Order by DIS_SEQ ";
			
			lrArgs = CITDatabase.selectQuery(strSql, lrArgData);
			
			// 컬럼 정보
			strSql  = " Select * \n";
			strSql += " From   T_LOV_COLS \n";
			strSql += " Where  LOV_NO = ? \n";
			strSql += " Order by DIS_SEQ ";
			
			lrCols = CITDatabase.selectQuery(strSql, lrArgData);
			
			// 필터 정보
			strSql  = " Select * \n";
			strSql += " From   T_LOV_FILTERS \n";
			strSql += " Where  LOV_NO = ? \n";
			strSql += " Order by DIS_SEQ ";
			
			lrFilters = CITDatabase.selectQuery(strSql, lrArgData);
			
			// 필터인자 정보
			strSql  = " Select * \n";
			strSql += " From   T_LOV_FILTER_ARGS \n";
			strSql += " Where  LOV_NO = ? \n";
			strSql += " Order by DIS_SEQ ";
			
			lrFilterArgs = CITDatabase.selectQuery(strSql, lrArgData);
			
			// 필터관계 정보
			strSql  = " Select a.LOV_NO, \n";
			strSql += "        a.FILTER_REL_SEQ, \n";
			strSql += "        a.M_FILTER_SEQ, \n";
			strSql += "        b.FILTER_NAME as M_FILTER_NAME, \n";
			strSql += "        a.D_FILTER_SEQ, \n";
			strSql += "        c.FILTER_NAME as D_FILTER_NAME \n";
			strSql += " From   T_LOV_FILTER_RELS a, \n";
			strSql += "        T_LOV_FILTERS b, \n";
			strSql += "        T_LOV_FILTERS c \n";
			strSql += " Where  a.LOV_NO = ? \n";
			strSql += "  And   a.LOV_NO = b.LOV_NO \n";
			strSql += "  And   a.M_FILTER_SEQ = b.FILTER_SEQ \n";
			strSql += "  And   a.LOV_NO = c.LOV_NO \n";
			strSql += "  And   a.D_FILTER_SEQ = c.FILTER_SEQ \n";
			strSql += " Order by a.FILTER_REL_SEQ \n";
			
			lrFilterRels = CITDatabase.selectQuery(strSql, lrArgData);
			
			// 독립적인 콤보필터 정보
			strSql  = " Select * \n";
			strSql += " From   T_LOV_FILTERS a \n";
			strSql += " Where  a.LOV_NO = ? \n";
			strSql += "  And   a.TYPE = 'C' \n";
			strSql += "  And   Not Exists (Select Null \n";
			strSql += "                    From   T_LOV_FILTER_RELS c \n";
			strSql += "                    Where  c.LOV_NO = a.LOV_NO \n";
			strSql += "                     And   c.D_FILTER_SEQ = a.FILTER_SEQ) \n";
			strSql += " Order by DIS_SEQ ";
			
			lrNotRelFilters = CITDatabase.selectQuery(strSql, lrArgData);
			
			// 필터 HTML 생성
			if (lrFilters.getRowsCount() < 1)
			{
				strFilterHtml += "<TABLE width='100%' cellSpacing='0' cellPadding='0' border='0'> \n";
				strFilterHtml += "\t<TR> \n";
				strFilterHtml += "\t\t<TD Width='100%' align='right'> \n";
				strFilterHtml += "&nbsp;<input id='btnRetrieve' type='button' class='img_btnFind' value='검색' title='Alt+R' onclick='btnRetrieve_onClick()' onmouseover='this.style.color=MOUSE_OVER;' onmouseout='this.style.color=MOUSE_OUT;'>&nbsp; \n";
				strFilterHtml += "\t\t</TD> \n";
				strFilterHtml += "\t</TR> \n";
				strFilterHtml += "</TABLE> \n";
			}
			else if (lrFilters.getRowsCount() > 2)
			{
				strFilterHeight = Integer.toString(Math.round((float)lrFilters.getRowsCount() / 2) * 20 + 10);
			}
			
			for (int i = 0; i < lrFilters.getRowsCount(); i++)
			{
				String lsFilterName = lrFilters.toString(i, "FILTER_NAME");
				String lsType = lrFilters.toString(i, "TYPE");
				String lsDateType = lrFilters.toString(i, "DATE_TYPE");
				String lsDefaultArgName = lrFilters.toString(i, "DEFAULT_ARG_NAME");
				String lsLabelName = lrFilters.toString(i, "LABEL_NAME");
				String lsLabelWidth = lrFilters.toString(i, "LABEL_WIDTH");
				String lsWidth = lrFilters.toString(i, "WIDTH");
				String lsSql = lrFilters.toString(i, "SQL");
				String lsTextCol = lrFilters.toString(i, "TEXT_COL");
				String lsValueCol = lrFilters.toString(i, "VALUE_COL");
				
				strLastFilterId = lsFilterName;
				
				// HTML 관련
				if (i % 2 == 0)
				{
					strFilterHtml += "<TABLE width='100%' cellSpacing='0' cellPadding='0' border='0'> \n";
					strFilterHtml += "\t<TR> \n";
				}
				else if (i % 2 > 0)
				{
					strFilterHtml += "\t\t<TD width='20'>&nbsp;</TD> \n";
				}
				
				strFilterHtml += "\t\t<TD width='10'><IMG src='../images/bullet3.gif'></TD> \n";
				strFilterHtml += "\t\t<TD width='" + lsLabelWidth + "'>" + lsLabelName + "</TD> \n";
				strFilterHtml += "\t\t<TD width='" + lsWidth + "'>";
				
				if (lsType.equals("S"))
				{
					strFilterHtml += "<INPUT type='text' id='" + lsFilterName + "' style='Width:100%'>";
				}
				else if (lsType.equals("N"))
				{
					strFilterHtml += "<INPUT type='text' id='" + lsFilterName + "' datatype='N' Mask='-' style='Width:100%'>";
				}
				else if (lsType.equals("D"))
				{
					if (lsDateType.equals("D"))
					{
						strFilterHtml += "<INPUT type='text' id='" + lsFilterName + "' datatype='DATE' center style='Width:80px'>";
						strFilterHtml += "<INPUT type='button' id='btn" + lsFilterName + "' class='img_btnCalendar_S' title='달력' onclick=\"javascript:C_Calendar('" + lsFilterName + "', 'D', " + lsFilterName + ".value);\">";
					}
					else if (lsDateType.equals("M"))
					{
						strFilterHtml += "<INPUT type='text' id='" + lsFilterName + "' datatype='DATEYM' center style='Width:60px'>";
						strFilterHtml += "<INPUT type='button' id='btn" + lsFilterName + "' class='img_btnCalendar_S' title='달력' onclick=\"javascript:C_Calendar('" + lsFilterName + "', 'M', " + lsFilterName + ".value);\">";
					}
					else if (lsDateType.equals("Y"))
					{
						strFilterHtml += "<INPUT type='text' id='" + lsFilterName + "' datatype='N' Mask='N' center maxLength='4' lowBound='1900' highBound='2999' style='Width:40px'>";
					}
					else
					{
						strFilterHtml += "&nbsp;";
					}
				}
				else if (lsType.equals("C"))
				{
					// 필터 콤보 HTML 생성
					//strFilterHtml += "<SELECT id='" + lsFilterName + "' style='Width:100%'></SELECT>";
					strFilterHtml += "<object id=" + lsFilterName + " width=100% classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69> \n";
					strFilterHtml += "\t<param name=ComboDataID		value='ds" + lsFilterName + "'> \n";
					strFilterHtml += "\t<param name=ListExprFormat	value='%;" + lsTextCol + "'> \n";
					strFilterHtml += "\t<param name=Index			value='1'> \n";
					strFilterHtml += "\t<param name=ComboStyle		value='5'> \n";
					strFilterHtml += "\t<param name=ListCount		value='10'> \n";
					strFilterHtml += "</object> \n";
					
					// 필터 Dataset HTML 생성
					strFilterDatasetHtml += "<object id=ds" + lsFilterName + " classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object> \n";
				}
				else
				{
					strFilterHtml += "&nbsp;";
				}
				
				strFilterHtml += "</TD> \n";
				
				if (lrFilters.getRowsCount() == 1 || i == 1)
				{
					strFilterHtml += "\t\t<TD width='*' align='right'>";
					strFilterHtml += "&nbsp;<input id='btnRetrieve' type='button' class='img_btnFind' value='검색' title='Alt+R' onclick='btnRetrieve_onClick()' onmouseover='this.style.color=MOUSE_OVER;' onmouseout='this.style.color=MOUSE_OUT;'>&nbsp;";
					strFilterHtml += "</TD> \n";
					strFilterHtml += "\t</TR> \n";
					strFilterHtml += "</TABLE> \n";
				}
				else if (i % 2 > 0)
				{
					strFilterHtml += "\t\t<TD width='*' align='right'>&nbsp;</TD> \n";
					strFilterHtml += "\t</TR> \n";
					strFilterHtml += "</TABLE> \n";
				}
				else if (lrFilters.getRowsCount() - 1 == i && i % 2 == 0)
				{
					strFilterHtml += "\t\t<TD width='*' align='right'>&nbsp;</TD> \n";
					strFilterHtml += "\t</TR> \n";
					strFilterHtml += "</TABLE> \n";
				}
				
				// Script 관련
				if (lsType.equals("S") || lsType.equals("N") || lsType.equals("D"))
				{
					// Main OnLoadBefore Script 생성(일반)
					strMainLoadBeforeScript += "dataset.DataID += \"&" + lsFilterName + "=\" + " + lsFilterName + ".value; \n";
					
					// 필터의 초기값 Script 생성(일반)
					if (lsDefaultArgName != null && !CITCommon.isNull(lsDefaultArgName))
					{
						for (int j = 0; j < lrArgs.getRowsCount(); j++)
						{
							if (!lrArgs.toString(j, "NAME").equals(lsDefaultArgName)) continue;
							
							strDefaultValueScript += lsFilterName + ".value = lrArgs.get(\"" + lsDefaultArgName + "\"); \n";
						}
					}
					
					// 날짜 필터의 CalendarResult 스크립트 생성
					if (lsType.equals("D") && (lsDateType.equals("D") || lsDateType.equals("M")))
					{
						strCalendarResultScript += "else if (asCalendarID == \"" + lsFilterName + "\") " + lsFilterName + ".value = asDate; \n";
					}
				}
				else if (lsType.equals("C"))
				{
					// 필터 add Dataset Script 생성
					strFilterAddDatasetScript += "G_addDataSet(ds" + lsFilterName + ", null, null, null, '" + lsFilterName + "'); \n";
					
					// Main OnLoadBefore Script 생성(콤보)
					strMainLoadBeforeScript += "dataset.DataID += \"&" + lsFilterName + "=\" + ds" + lsFilterName + ".NameString(ds" + lsFilterName + ".RowPosition, \"" + lsValueCol + "\"); \n";
				}
			}
			
			// 콤보필터의 OnLoadBefore 스크립트 생성(모든 필터의 현재값을 넘긴다.)
			for (int i = 0; i < lrFilters.getRowsCount(); i++)
			{
				String lsFilterSeq = lrFilters.toString(i, "FILTER_SEQ");
				String lsFilterName = lrFilters.toString(i, "FILTER_NAME");
				
				if (lrFilters.toString(i, "TYPE").equals("C"))
				{
					strFilterLoadBeforeScript += "else if (dataset == ds" + lsFilterName + ") \n";
					strFilterLoadBeforeScript += "{ \n";
					strFilterLoadBeforeScript += "dataset.DataID = \"Lov_q.jsp?ACT=FILTER&LOV_NO=\" + strLovNo; \n";
					strFilterLoadBeforeScript += "dataset.DataID += \"&FILTER_SEQ=" + lsFilterSeq + "\"; \n";
					strFilterLoadBeforeScript += strMainLoadBeforeScript;
					strFilterLoadBeforeScript += "} \n";
				}
			}
			
			// 입력인자가 세션변수를 사용할 경우 세션변수 값을 인자객체에 추가
			for (int i = 0; i < lrArgs.getRowsCount(); i++)
			{
				if (lrArgs.toString(i, "SESSION_TAG").equals("T"))
				{
					// 세션 변수를 가져와 인자객체에 추가하는 스크립트 생성
					if (session.getAttribute(lrArgs.toString(i, "SESSION_NAME")) == null)
					{
						strSessionValueScript += "lrArgs.set(\"" + lrArgs.toString(i, "SESSION_NAME") + "\", \"\"); \n";
					}
					else
					{
						strSessionValueScript += "lrArgs.set(\"" + lrArgs.toString(i, "SESSION_NAME") + "\", \"" + CITCommon.toKOR((String)session.getAttribute(lrArgs.toString(i, "SESSION_NAME"))) + "\"); \n";
					}
				}
			}
			
			// 필터의 종속관계를 Dataset 종속관계로 설정
			for (int i = 0; i < lrFilterRels.getRowsCount(); i++)
			{
				strFilterAddRelScript += "G_addRel(ds" + lrFilterRels.toString(i, "M_FILTER_NAME") + ", ds" + lrFilterRels.toString(i, "D_FILTER_NAME") + "); \n";
			}
			
			// 종속관계가 없거나 최상위 콤보필터를 초기 Load 및 초기값 설정
			for (int i = 0; i < lrNotRelFilters.getRowsCount(); i++)
			{
				String lsFilterName = lrNotRelFilters.toString(i, "FILTER_NAME");
				String lsDefaultArgName = lrNotRelFilters.toString(i, "DEFAULT_ARG_NAME");
				String lsValueCol = lrNotRelFilters.toString(i, "VALUE_COL");
				
				strLoadDatasetScript += "G_Load(ds" + lsFilterName + ", null); \n";
				
				// 콤보 초기값 설정 스크립트 생성
				if (lsDefaultArgName != null && !CITCommon.isNull(lsDefaultArgName))
				{
					strComboDefaultValueScript += "ds" + lsFilterName + ".RowPosition = ds" + lsFilterName + ".NameValueRow(\"" + lsValueCol + "\", lrArgs.get(\"" + lsDefaultArgName + "\")); \n";
				}
			}
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
		<title><%=strTitle%></title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript" src="../script/DefaultActions.js"></script>
		<script language="javascript">
		<!--
			var strLovNo = "<%=strLovNo%>";
			var strLovName = "<%=strLovName%>";
			var strTitle = "<%=strTitle%>";
			var intWidth = <%=strWidth%>;
			var intHeight = <%=strHeight%>;
			var intX = <%=strX%>;
			var intY = <%=strY%>;
			var strAutoLoad = "<%=strAutoLoad%>";
			var strState = "<%=strState%>";
			var lrArgs = window.dialogArguments.lrArgs;
			var strArgs = "";
			
			var opener = window.dialogArguments.opener;
			var ctrl = window.dialogArguments.ctrl;
			
			function Initialize()
			{
				// 추후 삭제
				/*
				lrArgs = new C_Dictionary();
				lrArgs.set("LOV_NO", "82");
				lrArgs.set("TITLE", "");
				lrArgs.set("FILTER_SEQ", "33");
				*/
				
				if (strState == "E")
				{
					C_msgOk("<%=strErrMsg%>", "에러");
					window.returnValue = strState;
					window.close();
				}
				
				document.body.topMargin = 0;
				document.body.leftMargin = 0;
				
				if (intX == 0 && intY == 0 )
				{
					window.dialogTop = (window.screen.availHeight / 2) - ((intHeight + 25) / 2);
					window.dialogLeft = (window.screen.availWidth / 2) - ((intWidth + 6) / 2);
				}
				else
				{
					window.dialogTop = intY;
					window.dialogLeft = intX;
				}
				
				window.dialogHeight = (intHeight + 25).toString() + "px";
				window.dialogWidth = (intWidth + 6).toString() + "px";
				
				setArgs();
				
				G_addDataSet(dsMain, null, gridMain, null, strTitle);
				<%=strFilterAddDatasetScript%>
				<%=strFilterAddRelScript%>
				<%=strDefaultValueScript%>
				<%=strLoadDatasetScript%>
				<%=strComboDefaultValueScript%>
				
				C_EventObject = gridMain;
				
				if (strAutoLoad == "T")
				{
					btnRetrieve_onClick()
				}
			}
			
			// 함수관련---------------------------------------------------------------------//
			function setArgs()
			{
				var arrKeys = null;
				var arrItems = null;
				
				if (lrArgs != null)
				{
					<%=strSessionValueScript%>
					
					arrKeys = lrArgs.keys();
					arrItems = lrArgs.items();
					
					for (var i = 0; i < arrKeys.length; i++)
					{
						strArgs += i == 0 ? arrKeys[i] + "\t" + arrItems[i] : "\n" + arrKeys[i] + "\t" + arrItems[i];
					}
					
					ifrmLovSession.SetSessionValue(strArgs);
				}
			}
			
			function ConfirmSelected(row)
			{
<%
	if ("T".equals(strMultiSelect))
	{
%>
				var lrArray = new Array();
				var _lrArgs = null;
				var idx = 0;
				for (idx = 1; idx <= dsMain.CountRow; idx++)
				{
					if( dsMain.RowMark(idx) == 1) {
						_lrArgs = new opener.C_Dictionary();
						for (var i = 1; i <= dsMain.CountColumn; i++)
						{
							_lrArgs.set(dsMain.ColumnID(i), dsMain.ColumnString(idx, i));
						}
						lrArray[lrArray.length] = _lrArgs;
					}
				}

				var rtnMsg = null;
				
				try
				{
					rtnMsg = opener.LovRetrunBefore("<%=strLovName%>", ctrl, lrArray);
				}
				catch(e)
				{
				}
				
				if(rtnMsg==null) {
					window.returnValue = lrArray;
					window.close();
				} else {
					C_msgError(rtnMsg, "확인");
				}

<%
	} else {
%>
				lrArgs.removeAll();
				
				for (var i = 1; i <= dsMain.CountColumn; i++)
				{
					lrArgs.set(dsMain.ColumnID(i), dsMain.ColumnString(row, i));
				}
				var rtnMsg = null;
				
				try
				{
					rtnMsg = opener.LovRetrunBefore("<%=strLovName%>", ctrl, lrArgs);
				}
				catch(e)
				{
				}
				
				if(rtnMsg==null) {
					window.returnValue = lrArgs;
					window.close();
				} else {
					C_msgError(rtnMsg, "확인");
				}
<%
	}
%>
			}
			
			function getSession()
			{
				ifrmLovSession.GetSessionValue();
				alert("GetSessionValue : " + ifrmLovSession.frmList.VALUES.value);
			}
			
			// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
			// 조회
			function btnquery_onclick()
			{
				G_Load(dsMain, null);
				gridMain.focus();
			}
			
			// 추가
			function btnadd_onclick()
			{
			}
			
			// 삽입
			function btninsert_onclick()
			{
			}
			
			// 삭제
			function btndelete_onclick()
			{
			}
			
			// 저장
			function btnsave_onclick()
			{
			}
			
			// 공통 재정의 이벤트관련-------------------------------------------------------//
			function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
			{
				if (asCalendarID == "") return;
				<%=strCalendarResultScript%>
			}
			
			function OnLoadBefore(dataset)
			{
				if (dataset == dsMain)
				{
					dataset.DataID = "Lov_q.jsp?ACT=MAIN&LOV_NAME=" + strLovName;
					<%=strMainLoadBeforeScript%>
				}
				<%=strFilterLoadBeforeScript%>
			}
			
			function OnKeyPress(dataset, grid, kcode)
			{
				if (grid == gridMain)
				{
					if (kcode == 13)
					{
						if (gridMain.RowPosition < 1) return;
						ConfirmSelected(dsMain.RowPosition);
					}
					else if (kcode == 27)
					{
						imgCancle_onClick();
					}
				}
			}
			
			function OnDblClick(dataset, grid, row, colid)
			{
				if (grid == gridMain)
				{
					if (row < 1) return;
					ConfirmSelected(row);
				}
			}
			
			// 이벤트관련-------------------------------------------------------------------//
			function document_onKeyDown()
			{
				if (event.keyCode == 27)
				{
					imgCancle_onClick();
				}
				else if (event.ctrlLeft == true && event.shiftLeft == true && event.keyCode == 76)
				{
					C_msgError("LOV No : " + intLovNo + "\nLOV Name : " + strLovName, "LOV 정보");
				}
				else if (event.keyCode == 13)
				{
					if(event.srcElement.id=='<%=strLastFilterId%>') btnRetrieve_onClick();
				}
				else {
				}
			}


			function btnRetrieve_onClick()
			{
				G_Load(dsMain, null);
				gridMain.focus();
			}
			
			function imgOk_onClick()
			{
				if(dsMain.RowPosition < 1)
				{
					C_msgOk("리스트상의 데이터를 선택하시기 바랍니다.");
					return;
				}
				
				ConfirmSelected(dsMain.RowPosition);
			}
			
			function imgCancle_onClick()
			{
				window.returnValue = null;
				window.close();
			}
			
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<object id=dsMain classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object>
		<%=strFilterDatasetHtml%>
		<!-- 가우스 Dataset 및 Tranaction 객체정의 종료 //-->
	</head>
	<body onload="C_Initialize()">
		<iframe width="0" height="0" name="ifrmLovSession" src="../common/LovSession.jsp" frameborder="0" tabindex="-1"></iframe>
		<DIV id="divPopMain" style="WIDTH: 100%; HEIGHT: 100%;">
			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
				<tr> 
					<td align="left" background="../images/pop_tit_bg.gif">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="52"><img src="../images/pop_tit_normal1.gif"></td>
								<td class="title_default"><%=strTitle%></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr> 
					<td height="100%" width="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%" height="<%=strFilterHeight%>" bgcolor="#ECECEC">
									<%=strFilterHtml%>
								</td>
							</tr>
							<tr>
								<td width="100%" height="*">
									<OBJECT id=gridMain style="HEIGHT: 100% ; WIDTH: 100%"  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT codebase="../../../cabfiles/toinbgrid.cab#version=1,1,0,125">
										<PARAM NAME="Editable" VALUE="false">
										<PARAM NAME="ColSelect" VALUE="false">
										<PARAM NAME="ColSizing" VALUE="-1">
										<%
											if ("T".equals(strMultiSelect))
											{
										%>
										<PARAM name="MultiRowSelect"   value=true>
										<%
											}
										%>
										<PARAM NAME="DataID" VALUE="dsMain">
										<PARAM NAME="Format" VALUE=" 
										<%
											if (lrCols != null)
											{
												for (int i = 0; i < lrCols.getRowsCount(); i++)
												{
													if (!lrCols.toString(i, "VISIBLE").equals("T")) continue;
													
													strOut = "<C> Name=" + lrCols.toString(i, "TITLE");
													strOut += " ID=" + lrCols.toString(i, "NAME");
													strOut += CITCommon.isNull(lrCols.toString(i, "MASK")) ? "" : " Mask='" + lrCols.toString(i, "MASK") + "'";
													
													if (lrCols.toString(i, "ALIGN").equals("L"))
													{
														strOut += " Align=Left";
													}
													else if (lrCols.toString(i, "ALIGN").equals("C"))
													{
														strOut += " Align=Center";
													}
													else if (lrCols.toString(i, "ALIGN").equals("R"))
													{
														strOut += " Align=Right";
													}
													
													strOut += " Width=" + lrCols.toString(i, "WIDTH") + " </C>";
													
													out.println(strOut);
												}
											}
										%>
										">
									</OBJECT>
									<script> __ws__(gridMain); </script>
								</td>
							</tr>
							<tr>
								<td width="100%" height="30" bgcolor="#ECECEC">
									<table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0">
										<tr>
											<TD width="*">
												<font color="red">※검색조건을 입력하시고 검색버튼을 누르세요.</font>
											</TD>
											<TD width="120" align="right">
												<input id="imgOk" type="button" class="img_btnOk" value="확인" onclick="imgOk_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												<input id="imgCancle" type="button" class="img_btnClose" value="닫기" onclick="imgCancle_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">&nbsp;
											</TD>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</DIV>
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