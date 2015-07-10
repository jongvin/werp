<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WDeptBudgAssignByDeptR(부서예산편성부서별)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 한재원 작성(2005-12-15)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_WDeptBudgAssignByDeptR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMASTER=dsMASTER,I:dsMAIN=dsMAIN,I:dsSUB01=dsSUB01)";
	
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


		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMASTER classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSUB01 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsLOV" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsBUDG_ITEM" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsCOPY" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsITEM_COST" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsDVD_MONTHS" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsCONFIRM" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsCONFIRM_ALL" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__10); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__11"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsDEPT_ALL" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__11); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__12"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsBUDG_ITEM_ALL" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__12); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__13"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsDEPT_COPY" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__13); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__14"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="<%=strUpdateKeyValue%>">
			<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__14); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__15"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transCopy"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsCOPY=dsCOPY)">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
			<param name=Parameter  value="ACT=COPY">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__15); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__16"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transItemCost"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsITEM_COST=dsITEM_COST)">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
			<param name=Parameter  value="ACT=ITEM_COST">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__16); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__17"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transDvd"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsDVD_MONTHS=dsDVD_MONTHS)">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
			<param name=Parameter  value="ACT=DVD">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__17); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__18"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transConfirm"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsCONFIRM=dsCONFIRM)">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
			<param name=Parameter  value="ACT=CONFIRM">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__18); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__19"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transConfirmAll"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsCONFIRM_ALL=dsCONFIRM_ALL)">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
			<param name=Parameter  value="ACT=CONFIRM_ALL">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__19); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__20"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transDeptAll"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsDEPT_ALL=dsDEPT_ALL)">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
			<param name=Parameter  value="ACT=DEPT_ALL">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__20); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__21"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transBudgItemAll"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsBUDG_ITEM_ALL=dsBUDG_ITEM_ALL)">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
			<param name=Parameter  value="ACT=BUDG_ITEM_ALL">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__21); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__22"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transDeptCopy"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsDEPT_COPY=dsDEPT_COPY)">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
			<param name=Parameter  value="ACT=COPY">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__22); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
											<td class=td_green>
												<!-- 프로그래머 디자인 시작 //-->
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
														<td width="55" class=font_green_bold>편성부서</td>
														<td width="52">
															<input id="txtMAKE_DEPT_CODE" type="text"  readOnly class="ro" style="width:50px">
														</td>
														<td width="200">
															<input id="txtMAKE_DEPT_NAME" type="text" readOnly class="ro" style="width:198px">
														</td>
														
														<td>&nbsp; </td>
													</tr>
												</table>
												<!-- 프로그래머 디자인 종료 //-->
											</td>
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
								<td width="380">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20">&nbsp;</td>
														<td class="font_green_bold">&nbsp;</td>
														<td align="right" width="*">
															&nbsp;
														</td>
													</tr>
													<tr>
														<td width="15" height="20"><img src="../images/bullet1.gif"></td>
														<td class="font_green_bold"> 신청부서</td>
														<td align="right" width="*">
															<input id="btnDeptCopy" type="button" class="img_btn6_1" value="발령정보설정"  onclick="btnDeptCopy_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnAssignAll" type="button" class="img_btn7_1" value="전부서가져오기"  onclick="btnAddDeptAll_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnAddDeptAllDel" type="button" class="img_btn5_1" value="전부서삭제"  onclick="btnDelDeptAll_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
												<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__23"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMASTER WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsMASTER">
													<PARAM NAME="Editable" VALUE="true">
													<PARAM NAME="ColSelect" VALUE="true"> 
													<PARAM NAME="ColSizing" VALUE="true">
													<PARAM NAME="MultiRowSelect" VALUE="true">
													<PARAM NAME="Format" VALUE="
														<C> Name=부서코드 ID=DEPT_CODE Align=Left Width=70  Edit=none show=false
														</C>
														<C> Name=부서명 ID=DEPT_NAME Align=Left Width=140 Edit=none
														</C>
														<C> Name=신청금액합 ID=BUDG_ITEM_REQ_AMT_SUM	Width=200  Edit=none
														</C>
														<C> Name=배정금액합  ID=BUDG_ITEM_ASSIGN_AMT_SUM	Width=100  Edit=none show=false
														</C>
														<C> Name='확정' ID=CONFIRM_TAG	Width=60 EditStyle='checkbox' Edit=none show=false
														</C>
														">
												</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__23); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
											<td height="50%">
												<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="100%">
															<table width="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="15" height="20">&nbsp;</td>
																	<td class="font_green_bold"> &nbsp;</td>
																	<td align="right" width="*">
																		<!--<input id="chkNumber" type="checkbox" value=1 >금액불일치검증 -->
																		 <input id="btnAddBudgItemAll" type="button" class="img_btn9_1" value="부서일괄항목등록"  onclick="btnAddBudgItemAll()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																		 <input id="btnGetFromItemCost" type="button" class="img_btn6_1" value="단가적용"  onclick="btnGetFromItemCost()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																		 <input id="btnGetFromItemCostAll" type="button" class="img_btn9_1" value="전부서단가적용"  onclick="btnGetFromItemCostAll_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">	
																	</td>
																</tr>
																<tr>
																	<td width="15" height="20"><img src="../images/bullet1.gif"></td>
																	<td class="font_green_bold"> 예산신청내역</td>
																	<td align="right" width="*">
																		 <input id="btnAddBudgItemAllForAllDept" type="button" class="img_btn9_1" value="전부서일괄항목등록"  onclick="btnAddBudgItemAllForAllDept()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																		 <input id="btnGetFromItemCost" type="button" class="img_btn6_1" value="단가적용취소"  onclick="btnGetFromItemCostCan_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																		 <input id="btnGetFromItemCostAllCan" type="button" class="img_btn9_1" value="전부서단가적용취소"  onclick="btnGetFromItemCostAllCan_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
															<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__24"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
																<PARAM NAME="DataID" VALUE="dsMAIN">
																<PARAM NAME="Editable" VALUE="true">
																<PARAM NAME="ColSelect" VALUE="true">
																<PARAM NAME="ColSizing" VALUE="true">
																<PARAM NAME="ViewSummary" VALUE="1">
																<PARAM NAME="Format" VALUE="
																	<C> Name=예산코드 ID=COMP_CODE Align=Left Width=70 show=false
																	</C>
																	<C> Name=예산코드 ID=CLSE_ACC_ID Align=Left Width=70  show=false
																	</C>
																	<C> Name=예산코드 ID=DEPT_CODE Align=Left Width=70  show=false
																	</C>
																	<C> Name=예산코드 ID=CHG_SEQ Align=Left Width=70  show=false
																	</C>
																	<C> Name=예산코드번호 ID=BUDG_CODE_NO Align=Left Width=70  show=false
																	</C>
																	<C> Name=예산코드 ID=RESERVED_SEQ Align=Left Width=70  show=false
																	</C>
																	<C> Name=예산항목코드 ID=BUDG_ITEM_CODE Align=Left Width=90 show=false
																	</C>
																	<C> Name=예산항목명 ID=BUDG_CODE_NAME Align=Left Width=100 SumText='합계' BgColor={Decode(ITEM_NO, 0 , '#FFFCE0', '#E0F4FF') } Edit=none
																	</C>
										
																	<C> Name=예산신청금액 ID=BUDG_ITEM_REQ_AMT	Width=200 SumText=@Sum  Edit=none
																	</C>
																	<C> Name=예산배정금액 ID=BUDG_ITEM_ASSIGN_AMT	Width=150 SumText=@Sum  Edit=none show=false
																	</C>
																	
																	<C> Name=항목전체명 ID=FULL_PATH	Width=260
																	</C>
																	">
															</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__24); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
										<tr>
											<td height="50%">
												<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="100%">
															<table width="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="15" height="20"><img src="../images/bullet1.gif"></td>
																	<td class="font_green_bold"> 월별신청내역</td>
																	<td align="right" width="*">
																	      
																		<!--<input id="btnDvdMonths" type="button" class="img_btn4_1" value="월별분할"  onclick="btnDvdMonths_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">-->
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
															<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__25"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridSUB01 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
																<PARAM NAME="DataID" VALUE="dsSUB01">
																<PARAM NAME="Editable" VALUE="true">
																<PARAM NAME="ColSelect" VALUE="true">
																<PARAM NAME="ColSizing" VALUE="true">
																<PARAM NAME="ViewSummary" VALUE="1">
																<PARAM NAME="Format" VALUE="
																	<C> Name=예산월 ID=BUDG_YM Align=Left Width=70 SumText='합계' align=center
																	</C>
																	
																	<C> Name=예산신청금액 ID=BUDG_MONTH_REQ_AMT	Width=200 SumText=@Sum
																	</C>
																	<C> Name=예산배정금액 ID=BUDG_MONTH_ASSIGN_AMT	Width=150 SumText=@Sum   Edit=none show=false
																	</C>
																	<C> Name=비고 ID=REMARKS	Width=200 
																	</C>
																	">
															</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__25); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
									</tble>
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