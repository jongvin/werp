<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFixAssetClsCodeR.jsp(자산종류코드등록)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 한재원작성(2006-01-16)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_WFixAssetClsCodeR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";
	
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
		<title>회계관리</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript" src="../script/DefaultActions.js"></script>
		<script language="javascript" src="<%=strFileName%>.js"></script>
		<script language="javascript">
		<!--
			var oldData ="";
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			
			// 이벤트관련-------------------------------------------------------------------//
			
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!-- 가우스 Dataset 및 Tranaction 객체정의 종료 //-->
	</head>
	<body onload="C_Initialize()">
		<div id="divMainFix" class="main_div">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top"> 
					<td width="100%">
						<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
						<!-- 조건 테이블 시작 //-->
						
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
											<td class="font_green_bold"> 고정자산종류코드</td>
											<td align="right" width="*">
												&nbsp;
											</td>
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
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN">
										<PARAM NAME="Editable" VALUE="-1">
										<PARAM NAME="ColSelect" VALUE="1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="Format" VALUE=" 
											<FC> Name=자산종류코드 ID=ASSET_CLS_CODE Align=Center Width=90 
											</FC> 
											<FC> Name=자산종류명 ID=ASSET_CLS_NAME Width=100
											</FC> 
											<C> Name=계정코드 ID=ASSET_ACC_CODE Width=80   Align=Center  
											</C> 
											<C> Name=계정명 ID=ASSET_ACC_NAME Width=150  Align=left  EditStyle=popup
											</C>  
											<C> Name=내용년수 ID=SRVLIFE Width=70 align=center
											</C>
											<C> Name=처분년수 ID=DISLIFE Width=70 align=center
											</C>
											<C> Name=취득부가세계정 ID=VAT_ACC_CODE Width=100 show=false
											</C>
											<C> Name=취득부가세계정 ID=VAT_ACC_NAME Width=120  EditStyle=popup
											</C>
											<C> Name=상각누계액계정 ID=SUM_ACC_CODE Width=100 show=false
											</C>
											<C> Name=상각누계액계정 ID=SUM_ACC_NAME Width=120  EditStyle=popup
											</C>
											<C> Name=처분익계정 ID=SELL_PORF_ACC_CODE Width=100 show=false
											</C>
											<C> Name=처분익계정 ID=SELL_PORF_ACC_NAME Width=120  EditStyle=popup
											</C>
											<C> Name=처분손계정 ID=SELL_LOSS_ACC_CODE  Width=100 show=false
											</C>
											<C> Name=처분손계정 ID=SELL_LOSS_ACC_NAME  Width=120  EditStyle=popup
											</C>
											<C> Name=평가익계정 ID=APPR_PROF_ACC_CODE  Width=100 show=false
											</C>
											<C> Name=평가익계정 ID=APPR_PROF_ACC_NAME  Width=120  EditStyle=popup
											</C> 
											<C> Name=평가손계정 ID=APPR_LOSS_ACC_CODE Width=100 show=false
											</C>
											<C> Name=평가손계정 ID=APPR_LOSS_ACC_NAME Width=120  EditStyle=popup
											</C>
											<C> Name=자본적지출계정 ID=CAP_EXP_ACC_CODE Width=100 show=false
											</C>
											<C> Name=자본적지출계정 ID=CAP_EXP_ACC_NAME Width=120  EditStyle=popup
											</C>  
											<C> Name=자본적지출부가세계정 ID=CAP_EXP_VAT_ACC_CODE Width=100 show=false
											</C>
											<C> Name=자본적지출부가세계정 ID=CAP_EXP_VAT_ACC_NAME Width=130  EditStyle=popup
											</C>
											<C> Name=매각계정 ID=SELL_ACC_CODE Width=100 show=false
											</C>
											<C> Name=매각계정 ID=SELL_ACC_NAME Width=120  EditStyle=popup
											</C>
											<C> Name=매각부가세계정 ID=SELL_VAT_ACC_CODE Width=100 show=false
											</C>
											<C> Name=매각부가세계정 ID=SELL_VAT_ACC_NAME Width=120  EditStyle=popup
											</C>
											<C> Name=폐기계정 ID=TRA_ACC_CODE Width=100 show=false
											</C>
											<C> Name=폐기계정 ID=TRA_ACC_NAME Width=100  EditStyle=popup
											</C>    
											">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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