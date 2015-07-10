<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WBudgChgRequestApproveR.jsp(예산변경승인)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 예산변경승인
/* 4. 변  경  이  력 : 한재원 작성(2005-12-20)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_WBudgChgRequestApproveR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN,I:dsSUB01=dsSUB01,I:dsSUB02=dsSUB02)";
	
	CITData		lrArgData = null;
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String strDEPT_NAME = "";
	String strCLSE_ACC_ID = "";
	String strACC_ID = "";
	String strREASON_CODE = "";
	String strCONFIRM_KIND = "";
	try
	{
		CITCommon.initPage(request, response, session);
		//사업장 설정
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
		strDEPT_NAME = CITCommon.NvlString(session.getAttribute("long_name"));
		if(CITCommon.isNull(strCOMP_CODE))
		{
			lrArgData = new CITData();
			try
			{
				lrArgData.addColumn("DEPT_CODE",CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("DEPT_CODE", strDEPT_CODE);
				
				strSql = " select a.COMP_CODE,b.COMPANY_NAME from t_dept_code a,t_company b where a.DEPT_CODE = ? and a.COMP_CODE = b.COMP_CODE (+) ";

				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				if(lrReturnData.getRowsCount() >= 1)
				{
					strCOMP_CODE = lrReturnData.toString(0,"COMP_CODE");
					strCOMPANY_NAME = lrReturnData.toString(0,"COMPANY_NAME");
	
					session.setAttribute("comp_code", strCOMP_CODE);
					session.setAttribute("comp_name", strCOMPANY_NAME);
				}
				
			}
			catch (Exception ex)
			{
				throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
			}
		}
		else
		{
			strCOMPANY_NAME = CITCommon.NvlString(session.getAttribute("comp_name"));
		}
		//사업장 설정 종료
		//회기 검색
		try
		{
			lrArgData = new CITData();
			lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			
			strSql = 
				"Select"+"\n"+
				"	a.CLSE_ACC_ID ,"+"\n"+
				"	a.ACC_ID"+"\n"+
				"From	T_YEAR_CLOSE a,"+"\n"+
				"		("+"\n"+
				"			Select"+"\n"+
				"				b.COMP_CODE,"+"\n"+
				"				Max(b.CLSE_ACC_ID) CLSE_ACC_ID"+"\n"+
				"			From	T_BUDG_YEAR b"+"\n"+
				"			Where	b.COMP_CODE = ?"+"\n"+
				"			Group By "+"\n"+
				"				b.COMP_CODE"+"\n"+
				"		) b"+"\n"+
				"Where	a.COMP_CODE = b.COMP_CODE"+"\n"+
				"And		a.CLSE_ACC_ID = b.CLSE_ACC_ID"+"\n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			if(lrReturnData.getRowsCount() >= 1)
			{
				strCLSE_ACC_ID = lrReturnData.toString(0,"CLSE_ACC_ID");
				strACC_ID = lrReturnData.toString(0,"ACC_ID");
			}
		}
		catch (Exception ex)
		{
			throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
		}
		//회기 검색 종료
		
		//공통코드 검색
		try
		{
			lrArgData = new CITData();
			
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'REASON_CODE' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order by	a.SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strREASON_CODE = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전용구분코드 Select 오류 -> " + ex.getMessage());
		}
		
		//공통코드 검색
		try
		{
			lrArgData = new CITData();
			
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'CONFIRM_KIND' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order by	a.SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strCONFIRM_KIND = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 확정구분코드 Select 오류 -> " + ex.getMessage());
		}
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
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
			var			sDeptCode = "<%=strDEPT_CODE%>";
			var			sDeptName = "<%=CITCommon.enSC(strDEPT_NAME)%>";
			var			sClseAccId = "<%=strCLSE_ACC_ID%>";
			var			sAccId = "<%=strACC_ID%>";
			var			oldData1 = "";
			var			oldData2 = "";
			
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSUB01 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSUB02 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsREASON_NO classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsCHG_SEQ classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsBUDG_APPLY_YM classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsCONFIRM_KIND_ALL classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsCONFIRM_TAG classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsCONFIRM_TAG_ALL classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__10); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__11"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsCONFIRM_KIND classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__11); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__12"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transConfirmKindAll"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsCONFIRM_KIND_ALL=dsCONFIRM_KIND_ALL)">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
			<param name=Parameter  value="ACT=CONFIRM_KIND_ALL">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__12); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__13"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transConfirmTag"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsCONFIRM_TAG=dsCONFIRM_TAG)">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
			<param name=Parameter  value="ACT=CONFIRM_TAG">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__13); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__14"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transConfirmTagAll"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsCONFIRM_TAG_ALL=dsCONFIRM_TAG_ALL)">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
			<param name=Parameter  value="ACT=CONFIRM_TAG_ALL">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__14); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__15"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transConfirmKind"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsCONFIRM_KIND=dsCONFIRM_KIND)">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
			<param name=Parameter  value="ACT=CONFIRM_KIND">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__15); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__16"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__16); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
											<td width="45" class=font_green_bold>사업장</td>
											<td width="52">
												<input id="txtCOMP_CODE" type="text" style="width:50px" onblur="txtCOMP_CODE_onblur()">
											</td>
											<td width="150">
												<input id="txtCOMPANY_NAME" type="text" readOnly class="ro" style="width:148px">
											</td>
											<td width="70">
												<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="검색" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="45" class=font_green_bold>회기</td>
											<td width="52">
												<input id="txtCLSE_ACC_ID" type="text" style="width:50px" onblur="txtCLSE_ACC_ID_onblur()">
											</td>
											<td width="60">
												<input id="txtACC_ID" type="text" readOnly class="ro" style="width:40px"> 기
											</td>
											<td width="70">
												<input id="btnACC_ID" type="button" class="img_btnFind" value="검색" onclick="btnACC_ID_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="55" class=font_green_bold>확정여부</td>
											<td width="52">
												<select id="cboCONFIRM_TAG" style="WIDTH: 80px" class="input_listbox_default" onchange=selectBUDG_APPLY_YM()>
													<OPTION VALUE='%'>전체
													<OPTION VALUE='T'>확정
													<OPTION VALUE='F'>미확정
												</select>
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="85" class=font_green_bold>예산적용년월</td>
											<td width="52">
												<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__17"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=cboBUDG_APPLY_YM width=80 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 >
													<PARAM NAME="ComboStyle" VALUE="5">
													<param name=ComboDataID		value=dsBUDG_APPLY_YM>
													<PARAM NAME="EditExprFormat" VALUE="%;budg_apply_ym_disp">
													<PARAM name="ListExprFormat" value="%;budg_apply_ym_disp">			
													<param name=SearchColumn	value=CLSE_ACC_ID>
													<param name=Sort			value=True>			
												</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__17); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
												
											</td>
											
											<td>&nbsp; </td>
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
					<td width="100%">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="15" height="20"><img src="../images/bullet1.gif"></td>
								<td class="font_green_bold">예산변경차수</td>
								<td align="right">
								       <input id="btnBudgChgRequestSignAll" type="button" class="img_btn4_1" value="일괄승인" onclick="btnBudgChgRequestSignAll_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
								       <input id="btnBudgChgRequestSignAllCancel" type="button" class="img_btn6_1" value="일괄승인취소" onclick="btnBudgChgRequestSignAllCancel_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
									<input id="btnBudgChgRequestSettlementAll" type="button" class="img_btn4_1" value="일괄조정" onclick="btnBudgChgRequestSettlementAll_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
									<input id="btnBudgChgRequestRejectAll" type="button" class="img_btn4_1" value="일괄기각" onclick="btnBudgChgRequestRejectAll_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
									<input id="btnBudgChgRequestConfirm" type="button" class="img_btn6_1" value="예산변경확정" onclick="btnBudgChgRequestConfirm_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
									<input id="btnBudgChgRequestConfirmCancel" type="button" class="img_btn8_1" value="예산변경확정취소" onclick="btnBudgChgRequestConfirmCancel_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
									<input id="btnBudgChgRequestConfirm" type="button" class="img_btn8_1" value="예산변경일괄확정" onclick="btnBudgChgRequestConfirmAll_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
									<input id="btnBudgChgRequestConfirmCancel" type="button" class="img_btn10_1" value="예산변경일괄확정취소" onclick="btnBudgChgRequestConfirmCancelAll_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
								</td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="head_line">
								<td width="*" height="3"></td>
							</tr>
						</table>
						<table width="100%" height="180" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%" height="100%">
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__18"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN">
										<PARAM NAME="Editable" VALUE="false">
										<PARAM NAME="ColSelect" VALUE="true">
										<PARAM NAME="ColSizing" VALUE="true">
										<PARAM NAME="Format" VALUE="
											<C> Name=변경차수 ID=CHG_SEQ Align=CENTER Width=70 
											</C>
											<C> Name=부서  ID=DEPT_NAME Align=LEFT Width=150 
											</C>
											<C> Name=예산변경적용시작월 ID=BUDG_APPLY_YM	 Align=CENTER Width=140
											</C>
											<C> Name=신청완료여부 ID=REQUEST_TAG Width=80  Align=CENTER EditStyle=Checkbox
											</C>
											<C> Name=확정여부 ID=CONFIRM_TAG Align=CENTER Width=60  EditStyle=Checkbox
											</C>
											">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__18); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
								</td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="head_line">
								<td width="*" height="3"></td>
							</tr>
						</table>
						<!-- 간격조정 테이블 시작 //-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr> 
								<td height="5"></td>
							</tr>
						</table>
						<!-- 간격조정 테이블 종료 //-->
					</td>
				</tr>
				<tr valign="top"> 
					<td width="100%" height="100%">
					    <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="500">
	                    						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
	                    							<tr>
	                    								<td width="100%">
	                    									<table width="100%" border="0" cellspacing="0" cellpadding="0">
	                    										<tr>
	                    											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
	                    											<td class="font_green_bold"> 월별예산신청</td>
	                    											<td align="right" width="*">
	                    												<input id="btnBudgChgRequestSign" type="button" class="img_btn4_1" value="신청승인" onclick="btnBudgChgRequestSign_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
	                    												<input id="btnBudgChgRequestSignCancel" type="button" class="img_btn6_1" value="신청승인취소" onclick="btnBudgChgRequestSignCancel_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnBudgChgRequestSettlement" type="button" class="img_btn4_1" value="신청조정" onclick="btnBudgChgRequestSettlement_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnBudgChgRequestReject" type="button" class="img_btn4_1" value="신청기각" onclick="btnBudgChgRequestReject_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
	                    											</td>
	                    										</tr>
	                    									</table>
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
										<tr>
											<td width="100%" height="100%">
												<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__19"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridSUB01 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsSUB01">
													<PARAM NAME="Editable" VALUE="true">
													<PARAM NAME="ColSelect" VALUE="true">
													<PARAM NAME="ColSizing" VALUE="true">
													<PARAM NAME="ViewSummary" VALUE="1">
													<PARAM NAME="UsingOneClick" VALUE="1">
													<PARAM NAME="MultiRowSelect" VALUE="true">
													<PARAM NAME="Format" VALUE="
														<FC> Name=예산월 ID=BUDG_YM Align=CENTER Width=60
														</FC>
														<FC> Name=예산항목 ID=BUDG_CODE_NAME Align=Left Width=80
														</FC>
														<FC> Name=예산풀경로 ID=FULL_PATH Align=Left Width=120 
														</FC>
														<C> Name=변경사유 ID=REASON_CODE Align=Left Width=70   show=false
														</C>
														<C> Name=변경사유 ID=REASON_CODE_NAME Align=CENTER Width=70 
														</C>
														<C> Name=변경금액 ID=CHG_AMT	Width=100 SumText=@Sum
														</C>
														<C> Name=월별신청금액 ID=BUDG_MONTH_REQ_AMT	Width=100 SumText=@Sum
														</C>
														<C> Name=월별배정금액 ID=BUDG_MONTH_ASSIGN_AMT	Width=100 SumText=@Sum
														</C>
														<C> Name=확정구분 ID=CONFIRM_KIND	Width=40 show=false
														</C>
														<C> Name=확정구분 ID=CONFIRM_KIND_NAME	Align=CENTER Width=60 show=true
														</C>
														">
												</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__19); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
								<td width="10">
									&nbsp;
								</td>
								<td width="*">
	                    						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
	                    							<tr>
	                    								<td width="100*">
	                    									<table width="100%" border="0" cellspacing="0" cellpadding="0">
	                    										<tr>
	                    											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
	                    											<td class="font_green_bold"> 월별예산신청내역</td>
	                    											<td align="right" width="*">
	                    												&nbsp;
	                    											</td>
	                    										</tr>
	                    									</table>
	                    									
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
										<tr>
											<td width="100%" height="100%">
												<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__20"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridSUB02 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsSUB02">
													<PARAM NAME="Editable" VALUE="true">
													<PARAM NAME="ColSelect" VALUE="true">
													<PARAM NAME="ColSizing" VALUE="true">
													<PARAM NAME="UsingOneClick" VALUE="1">
													<PARAM NAME="Format" VALUE="
														<C> Name=원천예산월  ID=R_BUDG_YM Width=70  align=center  
														</C>
														<C> Name=원천신청금액  ID=BUDG_MONTH_REQ_AMT Width=100
														</C>
														<C> Name=원천배정금액 ID=BUDG_MONTH_ASSIGN_AMT Value={If( (BUDG_MONTH_REQ_AMT- CHG_AMT)< 0, 0, BUDG_MONTH_REQ_AMT- CHG_AMT)}	 	Width=100
														</C>
														<C> Name=변경금액 ID=CHG_AMT Width=100 
														</C>
														<C> Name=비고 ID=REMARKS	Width=100 
														</C>
														">
												</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__20); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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