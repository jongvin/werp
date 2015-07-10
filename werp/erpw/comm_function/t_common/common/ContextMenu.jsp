<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : FlexGridContextMenu(FlexGrid의 ContextMenu)
/* 2. 유형(시나리오) : FlexGrid의 ContextMenu
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-28)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
	String strOut = "";
	String strSql = "";
	
	String strContextMenuID = "";
	
	try
	{
		CITCommon.initPage(request, response, session);
		
		strContextMenuID = CITCommon.toKOR(request.getParameter("CMID"));
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
			.menuItem		{ cursor:default; width:100%; height:18px; padding-top:3px; padding-left:15px; background-Color:menu; color:black; }
			.highlightItem	{ cursor:default; width:100%; height:18px; padding-top:3px; padding-left:15px; background-Color:highlight; color:white; }
			.lineItem		{ cursor:default; width:100%; height:18px; padding-top:3px; padding-left:4px; background-Color:menu; color:#808080; }
		//-->
		</style>
		<script language="javascript">
		<!--
			var strContextMenuID = "<%=strContextMenuID%>";
			
			function Initialize()
			{
				divMenuMain.innerHTML = parent.CM_MENU_HTML;
			}
			
			// 함수관련---------------------------------------------------------------------//
			function switchMenu()
			{
				var obj = event.srcElement;
				
				if (obj.disabled == false && obj.className == "menuItem")
				{
					obj.className = "highlightItem";
				}
				else if (obj.className == "highlightItem")
				{
					obj.className = "menuItem";
				}
			}
			
			function selectMenu(aMenuID)
			{
				parent.CM_ContextMenuHide(strContextMenuID, aMenuID);
			}
			
			// 공통 재정의 이벤트관련-------------------------------------------------------//
			
			// 이벤트관련-------------------------------------------------------------------//
			
		//-->
		</script>
		
	</head>
	<body onload="Initialize()" onselectstart="return false" oncontextmenu="return false">
		<TABLE id="tableMain" cellSpacing="0" cellPadding="0" width="100%" height="100%" border="0">
			<TR>
				<TD>
					<!-- 표준 팝업 페이지의 최소 DIV 크기(폭:250px 이상, 높이:400px 고정) //-->
					<div id="divMenuMain" Hidefocus onmouseover="switchMenu()" onmouseout="switchMenu()" style="width:170px; background-Color:menu; border:outset 2px">
					</div>
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