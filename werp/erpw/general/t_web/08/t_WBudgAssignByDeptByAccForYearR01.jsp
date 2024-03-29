<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WBudgAssignByDeptByAccForYearR.jsp(부서별계정별월별현황(년))
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 한재원 작성(2005-12-29)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_WBudgAssignByDeptByAccForYearR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";
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
			// 이벤트관련-------------------------------------------------------------------//
			
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->

		<!--사업장별 부서목록 Dataset-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLIST00 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->

		<!--프로젝트코드 Dataset-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLIST01 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->

		<!--사업장목록 Dataset-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLIST02 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>     
			
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
											<td width="15"><img src="../images/bullet1.gif"></td>
											<td width="60" class="font_green_bold" >부서</td>
											<td width="110">
												<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id="cboDeptCode" style="width:100" classid=clsid:60109D65-70C0-425c-B3A4-4CB001513C69 VIEWASTEXT codebase="../../../cabfiles/LuxeCombo.cab#version=1,1,0,16">
													<PARAM NAME="ComboStyle" VALUE="5">
													<PARAM NAME="EditExprFormat" VALUE="%;DEPT_NAME">
													<PARAM name="ListExprFormat" value="%;DEPT_NAME">
													<PARAM NAME="Index" VALUE="0">
													<PARAM NAME="Sort" VALUE="-1">
													<PARAM NAME="SearchColumn" VALUE="DEPT_CODE">
													<PARAM NAME="SortColumn" VALUE="DEPT_CODE">
													<PARAM NAME="BindColumn" VALUE="DEPT_CODE">
													<PARAM NAME="ComboDataID" VALUE="dsLIST00">
												</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
											</td>
											
											<td width="15"><img src="../images/bullet1.gif"></td>
											<td width="60" class="font_green_bold" >출력구분</td>
											<td width="*">
												<select id="selDeptFlag" style="width:100" onChange="deptFlag_onChange()">
													<option value="ALL">전   체</option>
													<option value="CHK_DEPT">팀별</option> 
													<option value="DEPT">부서별</option>
												</select>
											</td>
										</tr>
									</table>
									
									<!-- 프로그래머 디자인 종료 //-->
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
											<td class="font_green_bold"> 부서별계정별월별현황</td>
											<td align="right" width="*">
												<input id="btnPreView" type="button" class="img_btn4_1" value="출력" onclick="btnPreView_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridLIST02 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT codebase="../../../cabfiles/toinbgrid.cab#version=1,1,0,125">
																		<Param Name="SortView" VALUE="Left">
																		<PARAM NAME="Editable" VALUE="0">
																		<PARAM NAME="ColSelect" VALUE="-1">
																		<PARAM NAME="ColSizing" VALUE="-1">
																		<PARAM name=ViewSummary value=1>
																		<PARAM NAME="Format" VALUE="

<FC> Name=계정코드 ID=ACC_CODE Sort=true Align=Center HeadAlign=Center     Width=80
	 Show=false
</FC>
<FC> Name=계정명칭 ID=ACC_NAME Sort=true Align=Left HeadAlign=Center     Width=140
</FC>
<G>name={'1월'} ID=MON_1
	<C> Name=예산 ID=pb1 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=사용 ID=s1 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=%    ID=r1 Align=Right HeadAlign=Center  Width=40</C>
</G>
<G>name={'2월'} ID=MON_2
	<C> Name=예산 ID=pb2 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=사용 ID=s2 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=%    ID=r2 Align=Right HeadAlign=Center  Width=40</C>
</G>
<G>name={'3월'} ID=MON_3
	<C> Name=예산 ID=pb3 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=사용 ID=s3 Align=Right HeadAlign=Center  Width=80</C> 
	<C> Name=%    ID=r3 Align=Right HeadAlign=Center  Width=40</C>
</G>
<G>name={'1/4 분기'}  ID=MON_41
	<C> Name=예산 ID=pb14 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=사용 ID=s14 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=%    ID=r14 Align=Right HeadAlign=Center  Width=40</C>
</G>
<G>name={'4월'}  ID=MON_4
	<C> Name=예산 ID=pb4 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=사용 ID=s4 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=%    ID=r4 Align=Right HeadAlign=Center  Width=40</C>
</G>
<G>name={'5월'}  ID=MON_5
	<C> Name=예산 ID=pb5 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=사용 ID=s5 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=%    ID=r5 Align=Right HeadAlign=Center  Width=40</C>
</G>
<G>name={'6월'}  ID=MON_6
	<C> Name=예산 ID=pb6 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=사용 ID=s6 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=%    ID=r6 Align=Right HeadAlign=Center  Width=40</C>
</G>
<G>name={'2/4 분기'}  ID=MON_24
	<C> Name=예산 ID=pb24 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=사용 ID=s24 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=%    ID=r24 Align=Right HeadAlign=Center  Width=40</C>
</G>
<G>name={'전반기'}  ID=MON_b
	<C> Name=예산 ID=pb012 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=사용 ID=s012 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=%    ID=r012 Align=Right HeadAlign=Center  Width=40</C>
</G>
<G>name={'7월'}  ID=MON_7
	<C> Name=예산 ID=pb7 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=사용 ID=s7 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=%    ID=r7 Align=Right HeadAlign=Center  Width=40</C>
</G>
<G>name={'8월'}  ID=MON_8
	<C> Name=예산 ID=pb8 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=사용 ID=s8 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=%    ID=r8 Align=Right HeadAlign=Center  Width=40</C>
</G>
<G>name={'9월'}  ID=MON_9
	<C> Name=예산 ID=pb9 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=사용 ID=s9 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=%    ID=r9 Align=Right HeadAlign=Center  Width=40</C>
</G>
<G>name={'3/4 분기'}  ID=MON_34
	<C> Name=예산 ID=pb34 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=사용 ID=s34 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=%    ID=r34 Align=Right HeadAlign=Center  Width=40</C>
</G>
<G>name={'10월'}  ID=MON_10
	<C> Name=예산 ID=pb10 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=사용 ID=s10 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=%    ID=r10 Align=Right HeadAlign=Center  Width=40</C>
</G>
<G>name={'11월'}  ID=MON_11
	<C> Name=예산 ID=pb11 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=사용 ID=s11 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=%    ID=r11 Align=Right HeadAlign=Center  Width=40</C>
</G>
<G>name={'12월'}  ID=MON_12
	<C> Name=예산 ID=pb12 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=사용 ID=s12 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=%    ID=r12 Align=Right HeadAlign=Center  Width=40</C>
</G>
<G>name={'4/4 분기'}  ID=MON_44
	<C> Name=예산 ID=pb44 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=사용 ID=s44 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=%    ID=r44 Align=Right HeadAlign=Center  Width=40</C>
</G>
<G>name={'후반기'}  ID=MON_p
	<C> Name=예산 ID=pb022 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=사용 ID=s022 Align=Right HeadAlign=Center  Width=80</C>
	<C> Name=%    ID=r022 Align=Right HeadAlign=Center  Width=40</C>
</G>
																			">
																		<PARAM NAME="DataID" VALUE="dsLIST02">
																	</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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