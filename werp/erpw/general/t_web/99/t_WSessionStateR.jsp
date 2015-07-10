<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WSessionStateR(세션변수 등록)
/* 2. 유형(시나리오) : 세션변수 조회 및 등록
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-25)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 :
/**************************************************************************/

	CITData lrReturnData = null;
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	
	try
	{
		CITCommon.initPage(request, response, session);
	}
	catch (Exception ex)
	{
		throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>회계관리 - 공통팝업</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript">
		<!--
			function Initialize()
			{
				G_addDataSet(dsSession, trans, gridSession, null, "공통팝업");
				
				G_Load(dsSession, null);
				gridSession.focus();
			}

			// 세션관련 함수----------------------------------------------------------------//
			function SetSession()
			{
			}
			
			function GetSession()
			{
			}
			
			function ReportSession(asName, asValue)
			{
			}
			
			// 함수관련---------------------------------------------------------------------//
			
			// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
			// 조회
			function btnquery_onclick()
			{
				if (G_FocusDataset == dsSession)
				{
					G_Load(dsSession, null);
				}
				
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// 추가
			function btnadd_onclick()
			{
				if (G_FocusDataset == dsSession)
				{
					G_addRow(dsSession);
				}
				
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// 삽입
			function btninsert_onclick()
			{
				if (G_FocusDataset == dsSession)
				{
					G_insertRow(dsSession);
				}
				
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// 삭제
			function btndelete_onclick()
			{
				if (G_FocusDataset == dsSession)
				{
					if (dsSession.CountRow < 1) return;
				
					var ret = C_msgYesNo("삭제하시겠습니까?", "선택");
					
					if (ret == "Y")
					{
						G_deleteRow(dsSession);
					}
				}
				
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// 저장
			function btnsave_onclick()
			{
				if (G_FocusDataset == dsSession)
				{
					G_saveDataMsg(dsSession);
				}
				
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// 취소
			function btncancel_onclick()
			{
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// 공통 재정의 이벤트관련-------------------------------------------------------//
			function OnLoadBefore(dataset)
			{
				if (dataset == dsSession)
				{
					dataset.DataID = "t_WSessionStateR_q.jsp?ACT=MAIN&SESSION_NAME=" + txtSessionName.value;
				}
			}
			
			function OnRowInserted(dataset, row)
			{
				if (dataset == dsSession)
				{
				}
			}
			
			function OnColumnChanged(dataset, row, colid)
			{
			}
			
			// 이벤트관련-------------------------------------------------------------------//
			
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSession classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=trans  classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F>
	      <param name="KeyValue" value="Service1(I:dsSession=dsSession)">
		  <param name="Action" value="./t_WSessionStateR_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!-- 가우스 Dataset 및 Tranaction 객체정의 종료 //-->
	</head>
	<body onload="C_Initialize()">
		<div id="divMainFix" class="main_div">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top"> 
					<td width="100%">
						<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
						<!-- 조건 테이블 시작 //-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="head_line"> 
								<td width="*" height="1"></td>
							</tr>
							<tr> 
								<td width="100%" class="td_green">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="45" class="font_green_bold" >세션명</td>
											<td width="*"><input id="txtSessionName" type="text" style="width:150px"></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr class="head_line"> 
								<td width="*" height="1"></td>
							</tr>
						</table>
						<!-- 조건 테이블 종료 //-->
						<!-- 간격조정 테이블 시작 //-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr> 
								<td height="5"></td>
							</tr>
						</table>
						<!-- 간격조정 테이블 종료 //-->
					</td>
				</tr>
				<!-- 프로그래머 디자인 시작 //-->
				<tr valign="top"> 
					<td width="100%" height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold"> 세션변수</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr class="head_line">
											<td width="*" height="3"></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td width="100%" height="100%">
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridSession WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsSession">
										<PARAM NAME="Editable" VALUE="-1">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="Format" VALUE=" 
											<C> Name=세션변수명 ID=SESSION_NAME Width=250
											</C> 
											<C> Name=값 ID=SESSION_VALUE Width=650
											</C> 
											">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
								</td>
							</tr>
							<tr>
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr class="head_line">
											<td width="*" height="3"></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<!-- 프로그래머 디자인 종료 //-->
			</table>
		</div>
		<!-- 가우스 Bind 객체정의 시작 //-->
		<!-- 가우스 Bind 객체정의 종료 //-->
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