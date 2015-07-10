<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WDeptR(부서코드)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-30)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_RSheetReport0003";
	String strFileName01 = "t_RSheetReport0003";
	String strReportName = "r_t_020003";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";

	String strDate = CITDate.getNow("yyyy-MM-dd");
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String strACC_GRP_CODE = "";

	String strSLIP_TRANS_CLS = "";
	try
	{
		CITCommon.initPage(request, response, session);
		
		try
		{
			CITData lrArgData = new CITData();
			strSql += "SELECT \n";
			strSql += "	''||ACC_GRP_CODE CODE, \n";
			strSql += "	ACC_GRP_NAME NAME \n";
			strSql += "FROM \n";
			strSql += "	T_ACC_GRP \n";
			strSql += "WHERE \n";
			strSql += "	USE_TAG = 'T' \n";
			strSql += "ORDER BY \n";
			strSql += "	ACC_GRP_CODE \n";
			
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strACC_GRP_CODE = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 계정그룹코드1 Select 오류 -> " + ex.getMessage());
		}
		
		//권한
		strSLIP_TRANS_CLS = CITCommon.NvlString(session.getAttribute("slip_trans_cls"));

		//사업장 설정
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
		
		if(CITCommon.isNull(strCOMP_CODE))
		{
			strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
			CITData		lrArgData = new CITData();
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
			var			sReportName = "<%=strReportName%>";
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
			var			sDeptCode = "<%=CITCommon.enSC(strDEPT_CODE)%>";
			var			sSlip_Trans_Cls = "<%=strSLIP_TRANS_CLS%>";
			
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsLOV" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="<%=strUpdateKeyValue%>">
			<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!-- 가우스 Dataset 및 Tranaction 객체정의 종료 //-->
	</head>
	<body onload="C_Initialize()">
		<form name="frmList" action="../common/t_WCcReportRequestProcess.jsp" target="_blank" method="post">
			<input type='hidden' name='ACT' value="REQUEST">
			<Input type='hidden' name='KEY' value="">
			<input type='hidden' name='EXPORT_TAG' value="">
			<input type='hidden' name='RUN_TAG' value="">
			<input type='hidden' name='CONDITION_PAGE' value="<%=strFileName01%>">
			<input type='hidden' name='REQUEST_NAME' value="">
			<Input type='hidden' name='REPORT_NO' value="">
			<Input type='hidden' name='REPORT_FILE_NAME' value="">
			<Input type='hidden' name='PARAMETERS' value="">
		</form>
		<div id="divMainFix" class="main_div">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<td height="25">
						<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
						<table width="100%"  border="0" cellpadding="0" cellspacing="0">
							<tr class="head_line">
								<td width="*" height="1"></td>
							</tr>
							<tr>
								<td class="td_green">
									<!-- 프로그래머 디자인 시작 //-->
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="70" class="font_green_bold" >출력구분</td>
											<td width="80">
												<SELECT id="cboExportTag" style="WIDTH: 60px">
													<OPTION VALUE='P' selected>PDF
													<OPTION VALUE='E'>EXCEL
													<OPTION VALUE='W'>WORD
												</SELECT>
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="60" class="font_green_bold" >실행구분</td>
											<td width="100">
												<SELECT id="cboRunTag" style="WIDTH: 80px">
													<OPTION VALUE='1' selected>바로실행
													<OPTION VALUE='2'>요청
												</SELECT>
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="50" class="font_green_bold" >요청명</td>
											<td width="*"><input id="txtRequestName" type="text" style="width:220px"></td>
										</tr>
									</table>
									<!-- 프로그래머 디자인 종료 //-->
								</td>
							</tr>
							<tr class="head_line">
								<td width="*" height="1"></td>
							</tr>
						</table>
					</tr>
				</tr>
				<tr valign="top"> 
					<td width="100%">
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
		<td width="70" class=font_green_bold>귀속사업장</td>
		<td width="112">
			<input id="txtCOMP_CODE" type="text" style="width:110px" onblur="txtCOMP_CODE_onblur()">
		</td>
		<td width="161">
			<input id="txtCOMPANY_NAME" type="text" readOnly class="ro" style="width:160px">
		</td>
		<td width="30">
			<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="검색" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
		</td>
		<td width="30">&nbsp;</td>		
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >전표일자</td>
		<td width="72"><input id="txtDT_F" type="text" datatype="date" style="width:70px" value = "<%=strDate%>"/></td>
		<td width="30">
			<input id="btnDT_F" type="button" class="img_btnCalendar_S" onClick="btnDT_F_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
		</td>
		<td width="15">~</td>
		<td width="72"><input id="txtDT_T" type="text" datatype="date" style="width:70px" value = "<%=strDate%>"/></td>
		<td width="30">
			<input id="btnDT_T" type="button" class="img_btnCalendar_S" onClick="btnDT_T_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
		</td>
		<td width="*">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >귀속부서</td>
		<td width="112"> <input name="txtDEPT_CODE" type="text" datatype="han" style="width:110px" VALUE="" onblur="txtDEPT_CODE_onblur()"></td>
		<td width="161"> <input name="txtDEPT_NAME" type="text" class="ro" readOnly style="width:160px" VALUE=""></td>
		<td width="40">
			<input name="btnDEPT" type="button" class="img_btnFind" onclick="btnDEPT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="찾기" />
		</td>
		<td width="30">&nbsp;</td>	
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >거래처</td>
		<td width="112"> <input name="txtCUST_CODE" type="text" datatype="han" style="width:110px" VALUE="" onblur="txtCUST_CODE_onblur()"></td>
		<td width="161"> <input name="txtCUST_NAME" type="text" class="ro" readOnly style="width:159px" VALUE=""></td>
		<td width="40">
			<input name="btnCUST_CODE" type="button" class="img_btnFind" onclick="btnCUST_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="찾기" />
		</td>
		<td width="*">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >계정과목</td>
		<td width="112"> <input name="txtACC_CODE" type="text" datatype="han" style="width:110px" VALUE="" onblur="txtACC_CODE_onblur()"></td>
		<td width="161"> <input name="txtACC_NAME" type="text" class="ro" readOnly style="width:159px" VALUE=""></td>
		<td width="40">
			<input name="btnACC_CODE" type="button" class="img_btnFind" onclick="btnACC_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="찾기" />
		</td>
		<td width="30">&nbsp;</td>
		<td width="15">&nbsp;</td>
		<td width="70" class="font_green_bold" >&nbsp;</td>
		<td width="70">&nbsp;</td>
		<td width="*">&nbsp;</td>
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
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold"> 계정과목내역</td>
											<td align="right" width="*">
<input name="btnSearch" type="button" class="img_btn6_1" onclick="btnquery_onclick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="출력계정조회" />
&nbsp;
<input name="btnAllSelect" type="button" class="img_btn6_1" onclick="btnAllSelect_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="전 체 선 택" />
<input name="btnAllSelCancle" type="button" class="img_btn6_1" onclick="btnAllSelCancle_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="전체선택취소" />
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
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="ViewSummary" 	VALUE=0>
										<PARAM NAME="SuppressOption" 	VALUE=1>
<%
String  strBgColor = "BgColor ={Decode(ACC_NAME,'  전 체 계   ','#E0F4FF','  전 표 계   ','#FFFCE0','white')}";
String  strColor=    "Color   ={Decode(ACC_NAME,'  전 체 계   ','red',    '  전 표 계   ','green',  'black')}";
%>
										<PARAM NAME="Format" VALUE="
<FC> Name=선택 ID=CHK_CLS Align=Center EditStyle=CheckBox Width=30
</FC>
<FC> Name=그룹 ID=ACC_GRP_NAME Align=Center Width=70 Edit='none' suppress=1
</FC>
<FC> Name=계정코드 ID=ACC_CODE Align=Center Width=80 EditLimit=10 Edit='none'
</FC>
<FC> Name=레벨 ID=ACC_LVL_NAME Align=Center Width=70 Edit='none'
</FC>
<FC> Name='계  정  명' ID=ACC_NAME Align=Left Width=250 Edit='none' Color={Decode(ACC_LVL,1,'#990000',2,'#FF0000',3,'#FF7E00',4,'#457700',5,'blue',6,'#000066')}
</FC>
<C> Name=계정축소명 ID=ACC_SHRT_NAME Align=Left Width=250 Edit='none'
</C>
<C> Name=계정잔액위치 ID=ACC_REMAIN_POSITION_NAME Align=Center Width=90 Edit='none'
</C>
<C> Name=입력구분 ID=FUND_INPUT_CLS Align=Center EditStyle=CheckBox Width=60 Edit='none'
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