<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WETaxSaleR(세금계산서건별등록)
/* 2. 유형(시나리오) : 화면디자인
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 최언회 작성(2005-11-09)
/* 5. 관련  프로그램 : 발의전표를 등록 및 조회
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명
	String strDt_Trans = CITDate.getNow("yyyyMMdd");
	String strDate = CITDate.getNow("yyyy-MM-dd");
	String strFileName = "./t_WETaxSaleR";
	String strFileName01 = "t_WETaxSaleR";
	
//저장 액션
	String strUpdateKeyValue = "";
	strUpdateKeyValue  = "Service1(";
	strUpdateKeyValue += "I:dsSLIP_H=dsSLIP_H, ";
	strUpdateKeyValue += "I:dsSLIP_D=dsSLIP_D";
	strUpdateKeyValue += ")";

	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strCOMPANY_NAME = "";
	String strDEPT_CODE = "";
	String strDEPT_NAME = "";
	String strEMP_NO = "";
	String strNAME = "";
	String strCombo1 = "";
	String strCombo2 = "";
	String strCombo3 = "";
	String strCOM_ID = "";
	String strEMP_ID = "";	
	String strREG_NUM = "";
	String strSECT_NAME = "";
	String strEMP_NAME = "";
	String strEMAIL = "";
	String strMOBILE = "";
	String strCOMPANY = "";
	String strEMPLOYER = "";
	String strADDRESS = "";
	String strBIZCOND = "";
	String strBIZITEM = "";

	try
	{
/*
out.println(""+(String)session.getAttribute("file_upload_dir"));
out.println(""+(String)session.getAttribute("emp_no"));
out.println(""+(String)session.getAttribute("name"));
out.println(""+(String)session.getAttribute("slip_trans_cls"));
out.println(""+(String)session.getAttribute("dept_chg_cls"));
out.println(""+(String)session.getAttribute("comp_code"));
out.println(""+(String)session.getAttribute("dept_code"));
out.println(""+(String)session.getAttribute("long_name"));
*/
			
		CITCommon.initPage(request, response, session, false);
		
		CITData lrArgData = new CITData();

		//사용자
		strEMP_NO = CITCommon.NvlString(session.getAttribute("emp_no"));
		strNAME = CITCommon.NvlString(session.getAttribute("name"));
		
		//사업장 설정
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
		strDEPT_NAME = CITCommon.NvlString(session.getAttribute("long_name"));

		//회사코드
		lrArgData = new CITData();
 		try
		{
				lrArgData.addColumn("EMP_NO",CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("EMP_NO", strEMP_NO);

				strSql  = " select com_id ,   \n"; 
				strSql += " 			 emp_id ,  	\n"; 
				strSql += " 			 reg_num ,  \n"; 
				strSql += " 			 sect_name ,\n"; 
				strSql += " 			 emp_name ,	\n"; 
				strSql += " 			 emp_no ,		\n"; 
				strSql += " 			 email ,		\n"; 
				strSql += " 			 mobile			\n"; 
				strSql += " from   tb_wt_user \n";
				strSql += " where  emp_no = ? \n";
	
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				if(lrReturnData.getRowsCount() >= 1)
				{
					strCOM_ID  		= lrReturnData.toString(0,"COM_ID");
					strEMP_ID  		= lrReturnData.toString(0,"EMP_ID");
					strREG_NUM 		= lrReturnData.toString(0,"REG_NUM");
					strSECT_NAME 	= lrReturnData.toString(0,"SECT_NAME");
					strEMP_NAME 	= lrReturnData.toString(0,"EMP_NAME");
					strEMAIL 			= lrReturnData.toString(0,"EMAIL");
					strMOBILE 		= lrReturnData.toString(0,"MOBILE"); 
				}	
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:회사코드 Select 오류 -> " + ex.getMessage());
		}			
	
		//회사정보
		lrArgData = new CITData();
 		try
		{
				lrArgData.addColumn("COM_ID",CITData.VARCHAR2);
				lrArgData.addColumn("REG_NUM",CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("COM_ID", strCOM_ID);
				lrArgData.setValue("REG_NUM",strREG_NUM);

				strSql  = " select company ,   	\n"; 
				strSql += " 			 employer ,  	\n"; 
				strSql += " 			 address ,		\n"; 
				strSql += " 			 biz_cond ,		\n"; 
				strSql += " 			 biz_item  		\n"; 
				strSql += " from   TB_WT_PLANT 	\n";
				strSql += " where  com_id = ? 	\n";
				strSql += " and    reg_num = ? 	\n";
	
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				if(lrReturnData.getRowsCount() >= 1)
				{
					strCOMPANY 	= lrReturnData.toString(0,"COMPANY");
					strEMPLOYER = lrReturnData.toString(0,"EMPLOYER");
					strADDRESS 	= lrReturnData.toString(0,"ADDRESS");
					strBIZCOND 	= lrReturnData.toString(0,"BIZ_COND");
					strBIZITEM 	= lrReturnData.toString(0,"BIZ_ITEM");
				}	
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:회사정보 Select 오류 -> " + ex.getMessage());
		}	
	
		//청구/영수
		lrArgData = new CITData();
 		try
		{
				strSql  = " Select \n";
				strSql += "     CD_CODE CODE, \n";
				strSql += "     KN_CODE NAME \n";
				strSql += " From	 TB_WT_COMMON_CODE  \n";
				strSql += " Where	 CD_CLASS = 'TAX004'  \n";
	
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				strCombo1 = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");

		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 청구/영수 Select 오류 -> " + ex.getMessage());
		}		

		//세무구분
		lrArgData = new CITData();
 		try
		{
				strSql  = " Select \n";
				strSql += "     CD_CODE CODE, \n";
				strSql += "     KN_CODE NAME \n";
				strSql += " From	 TB_WT_COMMON_CODE  \n";
				strSql += " Where	 CD_CLASS = 'TAX002'  \n";
	
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				strCombo2 = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");

		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
		}		

		//발행방향
		lrArgData = new CITData();
 		try
		{
				strSql  = " Select \n";
				strSql += "     CD_CODE CODE, \n";
				strSql += "     KN_CODE NAME \n";
				strSql += " From	 TB_WT_COMMON_CODE  \n";
				strSql += " Where	 CD_CLASS = 'TAX005'  \n";
	
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				strCombo3 = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");

		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
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
			var			sDate  		= "<%=strDate%>";
			var			sEmpno 		= "<%=strEMP_NO%>";
			var			sComid 		= "<%=strCOM_ID%>";
			var			sEmpid 		= "<%=strEMP_ID%>";
			var			sRegnum 	= "<%=strREG_NUM%>";
			var			sSectname = "<%=strSECT_NAME%>";
			var			sEmpname 	= "<%=strEMP_NAME%>";
			var			sEmail 		= "<%=strEMAIL%>";
			var			sMobile 	= "<%=strMOBILE%>";
			var			sCompany 	= "<%=strCOMPANY%>";
			var			sEmployer = "<%=strEMPLOYER%>";
			var			sAddress 	= "<%=strADDRESS%>";
			var			sBizcond 	= "<%=strBIZCOND%>";
			var			sBizitem 	= "<%=strBIZITEM%>";
			
		//-->
		</script>
		
<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSERIAL classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSLIP_H classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSLIP_D classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsITEM classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->

<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	<param name="KeyValue" value="<%=strUpdateKeyValue%>">
	<param name="Action"    value="<%=strFileName%>_tr.jsp">
</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->

<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transMAIN"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	<param name="KeyValue" value="Service1(I:dsMAIN=dsMAIN)">
	<param name="Action"    value="./t_WSlipSelPrintR_tr.jsp">
</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!-- 가우스 Dataset 및 Tranaction 객체정의 종료 //-->
	</head>
	<body onload="C_Initialize()" tabindex="-1">
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
					<td width="100%">
						<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
						<iframe width="0" height="0" name="hidden" src="" frameborder="0" tabindex="-1"></iframe>
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
											<td width="70" class="font_green_bold" >문서번호</td>
											<td width="152">
												<input id="txtDOC_NUMBER"	type="text" center datatype="n"  maxlength=32 onblur="btnDOCU_NO_onblur()" style="width:150px" tabindex="2" />
											</td>
											<td width="21">
												<input id="btnDOCU_NO" type="button" class="img_btnFind" value="검색" onclick="btnDOCU_NO_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td>&nbsp;</td>
										</tr>
									</table>

									<div id="divSLIP_H"  style="display:none">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="*">
													<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
														<PARAM NAME="DataID" 		VALUE="dsSLIP_H">
														<PARAM NAME="Editable"  	VALUE="true">
														<PARAM NAME="ColSelect" 	VALUE="true">
														<PARAM NAME="ColSizing" 	VALUE="true">
														<PARAM NAME="ViewSummary" 	VALUE=1>
														<PARAM NAME="Format" 		VALUE="
															<C> Name=문서번호 					ID=DOC_NUMBER	Width=100
															</C>
															<C> Name=회사코드 	  			ID=DOC_COM_ID	Width=100
															</C>
															<C> Name=작성년월 					ID=DOC_YYMM 	Width=100
															</C>
															<C> Name=데이콤관리번호 		ID=MTSID			Width=100
															</C>
															<C> Name=상태 							ID=STATUS			Width=100
															</C>
															<C> Name=거래명세처리요구		ID=TX_REQ 		Width=100
															</C>
															<C> Name=삭제여부						ID=DEL_STATUS Width=100
															</C>
															">
													</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
													
												</td>
											</tr>
										</table>
									</div>
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
											<td class="font_green_bold"> 세금계산서</td>
											<td align="right" width="*">
<input id="btnDISPLAY"	type="button" tabindex="-1" class="img_btn4_1" onClick="btnquery_prt_onclick();"	value="미리보기"	onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
<input id="btnCANCEL"		type="button" tabindex="-1" class="img_btn4_1" onClick="btnCANCEL_onclick();"		value="발행취소"		onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
<input id="btnCREATE"	type="button" tabindex="-1" class="img_btn9_1" onClick="btnCREATE_onclick();"	value="전자세금계산서발행"	onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td width="100%" height="100%" onActivate="G_focusDataset(dsSLIP_H)">
									<div id="divSLIP_H">
										<table width="100%" height="35%" border="1" bordercolor="black" cellspacing="0" cellpadding="2">
											<tr>
												<td colspan="2" style="background:#F6F6F6">
													<table border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="80">책번호</td>
															<td width="80"><input id="txtREF_VOLUME" type="text" Datatype="N" right readOnly adsreadonly tabindex="-1" style="width:100px;background:#ECF5EB"/></td>
															<td width="10">권</td>
															<td width="80"><input id="txtREF_NUMBER" type="text" Datatype="N" right readOnly adsreadonly tabindex="-1" style="width:100px;background:#ECF5EB"/></td>
															<td width="10">호</td>
															<td width="30">&nbsp;</td>
															
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="65">일련번호</td>
															<td width="102">
											   				<input id="txtREF_SERIAL" type="text" tabindex="120" readOnly adsreadonly style="width:100px;background:#ECF5EB" />
															</td>
															<td width="*">&nbsp;</td>
														</tr>
													</table>
													<table border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15" height="30"><img src="../images/bullet2.gif"></td>
															<td width="420" class="font_green_bold"> 공급자</td>
															<td width="15" height="30"><img src="../images/bullet2.gif"></td>
															<td width="*" class="font_green_bold"> 공급받는자</td>															
														</tr>
													</table>
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80" >등록번호</td>
														<td width="152">
														<input id="txtSUP_REGNUM" type="text" class="han" style="width:150px;background:#E0F4FF" readOnly ></td>
														<input id="txtSUP_ID" type="hidden" style="width:150px" ></td>
														<input id="txtDOC_COM_ID" type="hidden" style="width:150px" ></td>
														<input id="txtDOC_YYMM" type="hidden" style="width:150px" ></td>
														<input id="txtDEL_STATUS" type="hidden" style="width:150px" ></td>
														<input id="txtSENDER" type="hidden" style="width:150px" ></td>
														<input id="txtSUP_EMPID" type="hidden" style="width:150px" ></td>
														<input id="txtSUP_EMPEMAIL" type="hidden" style="width:150px" ></td>
														<input id="txtSUP_EMPMOBILE" type="hidden" style="width:150px" ></td>
														<td width="50">
														<input id="btnSUP_REGNUM" type="button" class="img_btnFind" value="검색" onclick="btnSUP_REGNUM_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>
														<td width="138">&nbsp;</td>
														
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80" >등록번호</td>
														<td width="152">
														<input id="txtBUY_REGNUM" type="text" class="han" style="width:150px;background:#FFECEC" readOnly ></td>
														<input id="txtBUYCOM_ID" type="hidden" style="width:150px" ></td>
														<input id="txtRECEIVER" type="hidden" style="width:150px" ></td>
														<td width="*">
														<input id="btnBUY_REGNUM" type="button" class="img_btnFind" value="검색"  onclick="btnBUY_REGNUM_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>
													</tr>
												</table>
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80" >상호(법인명)</td>
														<td width="162">
														<input id="txtSUP_COMPANY" type="text" class="ro" readOnly style="width:150px" ></td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="40" >성명</td>
														<td width="100">
														<input id="txtSUP_EMPLOYER" type="text" class="ro" readOnly style="width:100px"></td>
														<td width="23">&nbsp;</td>
														
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80" >상호(법인명)</td>
														<td width="162">
														<input id="txtBUY_COMPANY" type="text" class="ro" readOnly style="width:150px" ></td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="40" >성명</td>
														<td width="*">
														<input id="txtBUY_EMPLOYER" type="text" class="ro" readOnly style="width:100px" ></td>
													</tr>
												</table>
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80" >사업장주소</td>
														<td width="317">
														<input id="txtSUP_ADDRESS" type="text" class="ro" readOnly style="width:317px" ></td>
														<td width="23">&nbsp;</td>
														
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80" >사업장주소</td>
														<td width="*">
														<input id="txtBUY_ADDRESS" type="text" class="ro" readOnly style="width:317px" ></td>
													</tr>
												</table>	
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80" >업태</td>
														<td width="162">
														<input id="txtSUP_BIZCOND" type="text" class="ro" readOnly style="width:150px" ></td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="40" >종목</td>
														<td width="100">
														<input id="txtSUP_BIZITEM" type="text" class="ro" readOnly style="width:100px" ></td>
														<td width="23">&nbsp;</td>
														
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80" >업태</td>
														<td width="162">
														<input id="txtBUY_BIZCOND" type="text" class="ro" readOnly style="width:150px" ></td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="40" >종목</td>
														<td width="*">
														<input id="txtBUY_BIZITEM" type="text" class="ro" readOnly style="width:100px" ></td>														
													</tr>
												</table>
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80" >담당부서</td>
														<td width="162">
														<input id="txtSUP_SECTOR" type="text" class="ro" readOnly style="width:150px" ></td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="40" >성명</td>
														<td width="100">
														<input id="txtSUP_EMPLOYEE" type="text" class="ro" readOnly style="width:100px" ></td>
														<td width="23">&nbsp;</td>
														
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80" >담당부서</td>
														<td width="162">
														<input id="txtBUY_SECTOR" type="text" class="ro" readOnly style="width:150px" ></td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="40" >성명</td>
														<td width="*">
														<input id="txtBUY_EMPLOYEE" type="text" class="ro" readOnly style="width:100px" >
														<input id="btnBUY_EMPLOYEE" type="button" class="img_btnFind" value="검색"  onclick="btnBUY_EMPLOYEE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>
													</tr>
												</table>
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">작성일자</td>
														<td width="72"><input id="txtGEN_TM" type="text" datatype="date" style="width:70px"></td>
														<td width="90"><input id="btnGEN_TM" type="button" class="img_btnCalendar_S" onClick="btnGEN_TM_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/></td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="40">공란수</td>
														<td width="123"><input id="txtBLANK_NUM" type="text" class="ro" readOnly center style="width:30px" onchange="calcVATAMT();"/></td>

														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">비고</td>
														<td width="*"> <input id="txtTAX_BIGO" type="text" style="width:317px"/></td>													
													</tr>
												</table>
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">공급가액</td>
														<td width="162"><input id="txtTAX_SUPPRICE" type="text" class="ro" readOnly right style="width:150px" />
														<input id="txtPAY_TOTALPRICE" type="hidden" style="width:150px" ></td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="40">세액</td>
														<td width="100"> <input id="txtTAX_TAXPRICE" type="text" class="ro" readOnly right style="width:100px"/></td>

													</tr>
												</table>						
												</td>
											</tr>
										</table>
										<table width="100%" height="5%" border="0" cellspacing="0" cellpadding="0">
											<form name="fileUploadForm" method="post" target="hidden" enctype="multipart/form-data">
												<tr align=right >
													<td width="15" height="20" ><img src="../images/bullet1.gif"></td>
													<td class="font_green_bold"> 거래명세서</td>
																<td width="200">&nbsp;</td>
																<td width="15"><img src="../images/bullet3.gif"></td>
																<td width="110" class="font_green_bold">거래명세 UPLOAD</td>
																<td width="230"><input type="file" name="fileCMS" length='8' value=""></td>
																<td width="5" class=font_green_bold >&nbsp;</td>
																<td width="*"><input id="btnFileLoad" type="button" class="img_btn8_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="파일불러오기" onclick="btnFileLoad_onClick();" />
																<input id="btnADDROW"	type="button" tabindex="-1" class="img_btn6_1" onClick="btnADDROW_onclick();"		value="거래명세추가"	onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
																<input id="btnDELETEROW"	type="button" tabindex="-1" class="img_btn6_1" onClick="btnDELETEROW_onClick()"			value="거래명세삭제" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
																</td>																
												  </tr>				
											</form>
										</table>
																																
										<table width="100%" height="59%" border="1" bordercolor="black" cellspacing="0" cellpadding="2">										
											<tr>
												<td width="690" height="100%">
													<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridSUB WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
														<PARAM NAME="DataID" 		VALUE="dsSLIP_D">
														<PARAM NAME="Editable"  	VALUE="true">
														<PARAM NAME="ColSelect" 	VALUE="true">
														<PARAM NAME="ColSizing" 	VALUE="true">
														<PARAM NAME="ViewSummary" 	VALUE=-1>
														<PARAM NAME="MultiRowSelect"VALUE="true">
														<PARAM NAME="Format" 		VALUE="
<FC> Name=순번 			ID=ITEM_SEQ	BgColor=#ECF5EB Width=34 Align=Center Edit='none'</FC>
<FC> Name=거래일 		ID=TAX_GENDATE			BgColor=#FFFCE0 Align=Center width=75 </FC>
<FC> Name=상품코드 	ID=ITEM_CODE			BgColor=#FFFCE0 Align=Center width=120 </FC>
<FC> Name=상품명 		ID=ITEM_NAME 		BgColor=#FFFCE0 Width=150 </FC>
<C>  Name=규격 			ID=ITEM_UNIT 		Align=right Width=50 </C>
<C>  Name=수량			ID=ITEM_NUM			width=100 </C>
<C>  Name=단가			ID=ITEM_DANGA		width=100 </C>
<C>  Name=공급가액		ID=TAX_SUPPRICE		BgColor=#ECF5EB	width=100 </C>
<C>  Name=세액			ID=TAX_TAXPRICE	BgColor=#ECF5EB	width=100 </C>
<C>  Name=비고			ID=ITEM_BIGO 		width=200 </C>
															">
													</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
													<script> __ws__(gridSUB); </script>
												</td>
												<td width="*" height="100%" valign="top" onActivate="G_focusDataset(dsSLIP_H)">
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="100">데이콤관리번호</td>
															<td width="*"> <input id="txtMTSID" type="text" class="ro" readOnly style="width:150px"/></td>
														</tr>
													</table>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="100">거래명세처리여부</td>
															<td width="*"> <input id="txtTX_REQ" type="checkbox" style="width:50px"/></td>
														</tr>
													</table>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="100">아이템수</td>
															<td width="*"> <input id="txtITEM_NUM" type="text" class="ro" readOnly center style="width:50px"/></td>
														</tr>
													</table>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="100">처리상태</td>
															<td width="*"> <input id="txtSTATUS" type="hidden"  style="width:100px"/></td>															
															<td width="*"> <input id="txtSTATUS_NAME" type="text"  class="ro" readOnly style="width:100px"/></td>
														</tr>
													</table>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="100">청구/영수</td>
															<td width="*">
															<select  id="cboREF_TYPE"  style="WIDTH: 100px">
																<%=strCombo1%>
															</select></td>
														</tr>
													</table>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="100">세무구분</td>
															<td width="*">
															<select  id="cboTAX_TYPE"  onchange="cboTAX_TYPE_onChange()"  style="WIDTH: 100px">
																<%=strCombo2%>
															</select></td>
														</tr>
													</table>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="100">발행방향</td>
															<td width="*">
															<select  id="cboMSG_TYPE"  style="WIDTH: 100px">
																<%=strCombo3%>
															</select></td>
														</tr>
													</table>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="100">수정구분</td>
															<td width="*">
															<select  id="cboRES_FLAG"  style="WIDTH: 100px">
																<OPTION value='1'>1 : ALL</OPTION>
																<OPTION value='0'>0 : Comfirm only</OPTION>
															</select></td>															
														</tr>
													</table>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="100">공급받는자ID</td>
															<td width="*"> <input id="txtBUY_ID" type="text" class="ro" readOnly style="width:100px"/></td>
														</tr>
													</table>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="100">공급받는자사번</td>
															<td width="*"> <input id="txtBUY_EMPID" type="text" class="ro" readOnly style="width:100px"/></td>
														</tr>
													</table>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="100">공급받는자이메일</td>
															<td width="*"> <input id="txtBUY_EMPEMAIL" type="text" style="width:100px"/></td>
														</tr>
													</table>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="100">공급받는자모바일</td>
															<td width="*"> <input id="txtBUY_EMPMOBILe" type="text"  style="width:100px"/></td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<!-- 프로그래머 디자인 종료 //-->
			</table>
		</div>
		<!-- 가우스 Bind 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=ADE_Bind_1 style="Z-INDEX: 107; LEFT: 335px; POSITION: absolute; TOP: 158px" classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT codebase="../../../cabfiles/toinbbind.cab#version=1,1,0,13">
			<PARAM NAME="DataID" 		VALUE="dsSLIP_H">
			<PARAM NAME="BindInfo"	VALUE="
				<C> Col=DOC_NUMBER 				Ctrl=txtDOC_NUMBER 									Param=value</C><!--저장시 set//-->
				<C> Col=DOC_COM_ID 				Ctrl=txtDOC_COM_ID 									Param=value</C>
				<C> Col=DOC_YYMM 					Ctrl=txtDOC_YYMM 										Param=value</C>
				<C> Col=MTSID 						Ctrl=txtMTSID												Param=value</C>
				<C> Col=STATUS						Ctrl=txtSTATUS											Param=value</C>
				<C> Col=STATUS_NAME				Ctrl=txtSTATUS_NAME									Param=value</C>
				<C> Col=TX_REQ  					Ctrl=txtTX_REQ											Param=checked</C>
				<C> Col=DEL_STATUS  			Ctrl=txtDEL_STATUS									Param=value</C>
				<C> Col=SENDER   					Ctrl=txtSENDER	 										Param=value</C>
				<C> Col=RECEIVER					Ctrl=txtRECEIVER 										Param=value</C>
				<C> Col=ERR_INDEX					Ctrl=txtERR_INDEX 									Param=value</C><!--사용안함 //-->
				<C> Col=ERR_MSG 			 		Ctrl=txtERR_MSG		 									Param=value</C><!--사용안함 //-->
				<C> Col=REF_VOLUME 		 		Ctrl=txtREF_VOLUME 									Param=value</C><!--사용안함 //-->
				<C> Col=REF_NUMBER				Ctrl=txtREF_NUMBER		 							Param=value</C><!--사용안함 //-->
				<C> Col=REF_SERIAL  			Ctrl=txtREF_SERIAL	 								Param=value</C><!--저장시 set//-->
				<C> Col=REF_TYPE   				Ctrl=cboREF_TYPE	 									Param=value</C>
				<C> Col=TAX_TYPE					Ctrl=cboTAX_TYPE 										Param=value</C>				
				<C> Col=MSG_TYPE   				Ctrl=cboMSG_TYPE	 									Param=value</C>
				<C> Col=RES_FLAG					Ctrl=cboRES_FLAG 										Param=value</C>
				<C> Col=SUP_ID						Ctrl=txtSUP_ID 											Param=value</C>
				<C> Col=SUP_REGNUM 				Ctrl=txtSUP_REGNUM									Param=value</C>
				<C> Col=SUP_COMPANY 			Ctrl=txtSUP_COMPANY									Param=value</C>
				<C> Col=SUP_EMPLOYER			Ctrl=txtSUP_EMPLOYER								Param=value</C>
				<C> Col=SUP_ADDRESS  			Ctrl=txtSUP_ADDRESS									Param=value</C>
				<C> Col=SUP_BIZCOND  			Ctrl=txtSUP_BIZCOND									Param=value</C>
				<C> Col=SUP_BIZITEM  			Ctrl=txtSUP_BIZITEM									Param=value</C>
				<C> Col=SUP_SECTOR				Ctrl=txtSUP_SECTOR									Param=value</C>
				<C> Col=SUP_EMPLOYEE			Ctrl=txtSUP_EMPLOYEE								Param=value</C>
				<C> Col=SUP_EMPID 				Ctrl=txtSUP_EMPID										Param=value</C>
				<C> Col=SUP_EMPEMAIL 			Ctrl=txtSUP_EMPEMAIL								Param=value</C>
				<C> Col=SUP_EMPMOBILE			Ctrl=txtSUP_EMPMOBILE								Param=value</C>
				<C> Col=BUY_COM_ID  			Ctrl=txtBUY_COM_ID									Param=value</C>
				<C> Col=BUY_ID  					Ctrl=txtBUY_ID											Param=value</C>
				<C> Col=BUY_COM_ID  			Ctrl=txtBUYCOM_ID										Param=value</C> 
				<C> Col=BUY_ID  					Ctrl=txtBUY_ID											Param=value</C>
				<C> Col=BUY_REGNUM   			Ctrl=txtBUY_REGNUM									Param=value</C>
				<C> Col=BUY_COMPANY				Ctrl=txtBUY_COMPANY									Param=value</C>
				<C> Col=BUY_EMPLOYER			Ctrl=txtBUY_EMPLOYER								Param=value</C>
				<C> Col=BUY_ADDRESS 			Ctrl=txtBUY_ADDRESS									Param=value</C>
				<C> Col=BUY_BIZCOND 			Ctrl=txtBUY_BIZCOND									Param=value</C>
				<C> Col=BUY_BIZITEM				Ctrl=txtBUY_BIZITEM									Param=value</C>
				<C> Col=BUY_SECTOR  			Ctrl=txtBUY_SECTOR									Param=value</C>
				<C> Col=BUY_EMPLOYEE  		Ctrl=txtBUY_EMPLOYEE								Param=value</C>
				<C> Col=BUY_EMPID 		   	Ctrl=txtBUY_EMPID   								Param=value</C>
				<C> Col=BUY_EMPEMAIL 	   	Ctrl=txtBUY_EMPEMAIL 								Param=value</C>
				<C> Col=BUY_EMPMOBILE	   	Ctrl=txtBUY_EMPMOBILE 							Param=value</C>
				<C> Col=SBM_TM  			   	Ctrl=txtSBM_TM  										Param=value</C><!-- systemdatetime //-->
				<C> Col=GEN_TM  			   	Ctrl=txtGEN_TM   										Param=value</C>
				<C> Col=DLV_TM   			   	Ctrl=txtDLV_TM   										Param=value</C><!-- 배달일 //-->
				<C> Col=RCV_TM				    Ctrl=txtRCV_TM 											Param=value</C><!-- 수신일 //-->
				<C> Col=ACT_TM				    Ctrl=txtACT_TM  										Param=value</C><!-- 처리일(승인또는반려)//-->
				<C> Col=DEL_TM 						Ctrl=txtDEL_TM											Param=value</C><!-- 삭제일  //-->
				<C> Col=XMLFILE 					Ctrl=txtXMLFILE											Param=value</C>
				<C> Col=ADDFILE 			    Ctrl=txtADDFILE        							Param=value</C>   
				<C> Col=TAX_SUPPRICE	    Ctrl=txtTAX_SUPPRICE        				Param=value</C><!-- 거래명세 저장시 set //-->
				<C> Col=TAX_TAXPRICE      Ctrl=txtTAX_TAXPRICE        				Param=value</C><!-- 거래명세 저장시 set //-->
				<C> Col=PAY_TOTALPRICE    Ctrl=txtPAY_TOTALPRICE       				Param=value</C><!-- 거래명세 저장시 set //-->
				<C> Col=TAX_BIGO   		  	Ctrl=txtTAX_BIGO     								Param=value</C>
				<C> Col=ITEM_NUM			  	Ctrl=txtITEM_NUM     								Param=value</C><!-- 거래명세 저장시 set //-->
				<C> Col=BLANK_NUM			  	Ctrl=txtBLANK_NUM     							Param=value</C>				
			">
		</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__10); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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