<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WLoanSheetR.jsp(차입대장관리)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-05) 
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_PFinLoanSheetR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN,I:dsSUB01=dsSUB01,I:dsSUB02=dsSUB02)";
	
	String strOut = "";
	String strSql = ""; 
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String strDATE  = CITDate.getNow("yyyyMMdd");
	
	String strLOAN_ACC_CODE = "";
	String strLOAN_ACC_CODE_G = "";
	String strINTR_ACC_CODE = "";
	String strINTR_ACC_CODE_G = "";
	String strFUND_PAY_ACC_CODE = "";	
	String strFUND_PAY_ACC_CODE_G = "";	

	CITData		lrArgData = new CITData();
	try
	{
		CITCommon.initPage(request, response, session);
		//사업장 설정
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		if(CITCommon.isNull(strCOMP_CODE))
		{
			strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
			
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
		
		lrArgData = new CITData();
		try
		{
			strSql = 
				"Select"+"\n"+
				"	a.LOAN_KIND_CODE CODE,"+"\n"+
				"	a.LOAN_KIND_NAME NAME"+"\n"+
				"From	T_FIN_LOAN_KIND a"+"\n"+
				"Order By"+"\n"+
				"	a.LOAN_KIND_CODE"+"\n";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strLOAN_ACC_CODE_G = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
			strLOAN_ACC_CODE = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch(Exception ex)
		{
			throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
		}
		lrArgData = new CITData();
		try
		{
			strSql = 
				"Select"+"\n"+
				"	a.CODE_LIST_ID CODE,"+"\n"+
				"	a.CODE_LIST_NAME NAME"+"\n"+
				"From	V_T_CODE_LIST a"+"\n"+
				"Where	a.CODE_GROUP_ID = 'INTR_ACC_CODE'"+"\n"+
				"Order By"+"\n"+
				"	a.SEQ"+"\n";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strINTR_ACC_CODE_G = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
			strINTR_ACC_CODE = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch(Exception ex)
		{
			throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
		}
		lrArgData = new CITData();
		try
		{
			strSql = 
				"Select"+"\n"+
				"	a.CODE_LIST_ID CODE,"+"\n"+
				"	a.CODE_LIST_NAME NAME"+"\n"+
				"From	V_T_CODE_LIST a"+"\n"+
				"Where	a.CODE_GROUP_ID = 'FUND_PAY_ACC_CODE'"+"\n"+
				"Order By"+"\n"+
				"	a.SEQ"+"\n";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strFUND_PAY_ACC_CODE_G = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
			strFUND_PAY_ACC_CODE = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch(Exception ex)
		{
			throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
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
			var sTab ="1";
			var vDATE 			 = '<%=strDATE%>';
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
			var			sDeptCode = "<%=CITCommon.enSC(strDEPT_CODE)%>";
			// 이벤트관련-------------------------------------------------------------------//
			
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSUB01 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSUB02 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLOAN_REFUND_SEQ classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsGUAR_SEQ classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsDVD classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transDvd"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsDVD=dsDVD)">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
			<param name=Parameter  value="ACT=DVD">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!-- 가우스 Dataset 및 Tranaction 객체정의 종료 //-->
	</head>
	<body onload="C_Initialize();">
		<div id="divMainFix" class="main_div">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top"> 
					<td width="100%">
						<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
						<!-- 조건 테이블 시작 //-->
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="head_line"> 
								<td width="*" height="0"></td>
							</tr>
							<tr> 
								<td width="100%" class="td_green">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="45" class="font_green_bold" >사업장</td>
											<td width="52">
												<input id="txtCOMP_CODE" type="text" style="width:50px" readOnly class="ro">
											</td>
											<td width="150">
												<input id="txtCOMPANY_NAME" type="text" readOnly class="ro" style="width:148px">
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="55" class="font_green_bold" >은행코드</td>
											<td width="52">
												<input id="txtBANK_CODE" type="text" style="width:50px" readOnly class="ro">
											</td>
											<td width="150">
												<input id="txtBANK_NAME" type="text" readOnly class="ro" style="width:148px">
											</td>
											<td width=*>
												&nbsp;
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr class="head_line"> 
								<td width="*" height="1"></td>
							</tr>
							<tr> 
								<td width="*" height="3"></td>
							</tr>
							<tr>
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold"> 차입대장</td>
											
											<td align="right" width="*">
												<input id="btnRETRIEVE" type="button" class="img_btn2_1" value="조회" onclick="btnquery_onclick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												<!--
												<input id="btnADD" type="button" class="img_btn2_1" value="추가" onclick="btnadd_onclick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												<input id="btnINSERT" type="button" class="img_btn2_1" value="삽입" onclick="btninsert_onclick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												<input id="btnDELETE" type="button" class="img_btn2_1" value="삭제" onclick="btndelete_onclick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												<input id="btnSAVE" type="button" class="img_btn2_1" value="저장" onclick="btnsave_onclick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												-->
												&nbsp;&nbsp;
												<input id="btnSELECT" type="button" class="img_btn2_1" value="선택" onclick="btnselect_onclick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												<input id="btnCANCEL" type="button" class="img_btn2_1" value="취소" onclick="btnCANCEL_onclick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
								<td height="50%">
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN">
										<PARAM NAME="Editable" VALUE="0">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<param name=UsingOneClick  value="1">
										<PARAM NAME="Format" VALUE=" 
											<FG> Name='기본사항' ID=BASE1
												<FC> Name='차입번호' ID=LOAN_NO Align=Left Width=100 
												</FC> 
												<FC> Name='차입계좌' ID=REAL_LOAN_NO Align=Left Width=120 
												</FC> 
												<C> Name=차입종류 ID=LOAN_KIND_CODE Width=120 EditStyle=Combo Data='<%=strLOAN_ACC_CODE_G%>'
												</C> 
												<FC> Name=차입명 ID=LOAN_NAME Width=120
												</FC> 
											</FG>
											<G> Name='차입정보' ID=BASE2
												<C> Name=차입금액 ID=LOAN_AMT Width=90
												</C>
												<C> Name=차입일 ID=LOAN_FDT Width=90 align=Center editStyle=Popup 
												</C>
												<C> Name=만기일 ID=LOAN_EXPR_DT Width=90 align=Center editStyle=Popup
												</C>
												<C> Name=변경만기일 ID=CHG_EXPR_DT Width=90 align=Center editStyle=Popup
												</C>
											<G> Name='원금상환' ID=ORG
												<C> Name='거치(년)' ID=ORG_REFUND_YEAR Width=70 align=center
												</C>
												<C> Name='상환기간(년)' ID=ORG_REFUND_DIV_YEAR Width=80 align=center
												</C>
												<C> Name='상환주기(월)' ID=ORG_REFUND_MONTH Width=80 align=center
												</C>
												<C> Name='최초상환일' ID=ORG_REFUND_FIRST_MONTH Width=90  align=Center  editStyle=Popup
												</C>
											</G>
											<G> Name='이자납입' ID=INTR
												<C> Name=명목이율 ID=TITLE_INTR_RATE Width=60
												</C>
												<C> Name=실질이율 ID=REAL_INTR_RATE Width=60
												</C>
												<C> Name=이자계정 ID=INTR_ACC_CODE Width=160 EditStyle=Combo Data='<%=strINTR_ACC_CODE_G%>'
												</C>
												<C> Name='최초지급일' ID=INTR_REFUND_FIRST_DT Width=90  align=Center  editStyle=Popup
												</C>
												<C> Name='지급일자' ID=INTR_REFUND_DAY Width=70 align=center
												</C>
												<C> Name='납입주기(월)' ID=INTR_REFUND_DIV_MONTH Width=80 align=center
												</C>
											</G>
											<G> Name='기타사항' ID=ETC
												<C> Name=비고 ID=REMARKS Width=200
												</C> 
											</G>
											">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__10); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
								</td>
							</tr>
							<tr>
								<td width="50%">
									<!-- 서브 테이블 시작 //-->
									<!-- 서브 타이틀 시작 //-->
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr height="23">
												<!-- 프로그래머 수정 시작 //-->
											<td width="6"><img id="imgTabLeft1" src="../images/Content_tab_after_r.gif"></td>
											<td width="140" id="tab1" align="center" background="../images/Content_tab_bgimage_r.gif" class="font_tab"><a onclick="javascript:selectTab(1, 2);" onfocus="this.blur()">차입 및 상환 내역</a></td>
											<td width="6"><img id="imgTabRight1" src="../images/Content_tab_back_r.gif"></td>
											<td width="6"><img id="imgTabLeft2" src="../images/Content_tab_after.gif"></td>
											<td width="70" id="tab2" align="center" background="../images/Content_tab_bgimage.gif" class="font_tab"><a onclick="javascript:selectTab(2, 2);" onfocus="this.blur()">보증내역</a></td>
											<td width="6"><img id="imgTabRight2" src="../images/Content_tab_back.gif"></td>
											<td width="*" >
												&nbsp;
											</td>
										</tr>
									</table>
									<!-- 서브 타이틀 종료 //-->
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
								<td height="2"></td>
							</tr>
							<tr>
								<td height="100%" width="100%">
									<div id=divTabPage1  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%">
										<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="100%" height="100%">
													<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__11"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridSUB01 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
														<PARAM NAME="DataID" VALUE="dsMAIN">
														<PARAM NAME="Editable" VALUE="0">
														<PARAM NAME="ViewSummary" VALUE="1">
														<PARAM NAME="ColSelect" VALUE="-1">
														<PARAM NAME="ColSizing" VALUE="-1">
														<param name=UsingOneClick  value="1">
														<PARAM NAME="Format" VALUE=" 
															<G> Name='차입/상환내용' ID=BASE21
																<C> Name='차입/상환일' ID=REFUND_INTR_DT Align=Center Width=100 EditStyle=Popup SumText='합  계'
																</C> 
																<C> Name=차입금액 ID=LOAN_AMT Width=90  SumText=@Sum
																</C> 
																<C> Name=원금상환 ID=REFUND_AMT Width=90  SumText=@Sum
																</C> 
																<C> Name=잔액 ID=LOAN_REMAIN_AMT Width=90  
																</C> 
																<C> Name=이자지급 ID=INTR_AMT Width=90  SumText=@Sum
																</C> 
															</G>
															<G> Name='예정사항' ID=BASE22
																<C> Name='예정일' ID=REFUND_SCH_DT Align=Center Width=90 EditStyle=Popup
																</C> 
																<C> Name=원금상환 ID=REFUND_SCH_ORG_AMT Width=90   SumText=@Sum
																</C> 
																<C> Name=예정잔액 ID=SCH_LOAN_REMAIN_AMT Width=90  
																</C> 
																<C> Name=이자지급 ID=REFUND_SCH_INTR_AMT Width=90   SumText=@Sum
																</C> 
															</G>
															<G> Name='이자대상계산기간' ID=BASE23
																<C> Name='시작일' ID=INTR_START_DT Align=Center Width=90 EditStyle=Popup
																</C> 
																<C> Name='종료일' ID=INTR_END_DT Align=Center Width=90 EditStyle=Popup
																</C> 
															</G>
															<G> Name='전표관련' ID=BASE24
																<C> Name='지불계정' ID=ACC_CODE Align=Center Width=160 EditStyle=Combo  Data='<%=strFUND_PAY_ACC_CODE_G%>'
																</C> 
																<C> Name='차입전표번호' ID=LOAN_SLIP_NO Align=Center Width=120 
																</C> 
																<C> Name='상환전표번호' ID=REFUND_SLIP_NO Align=Center Width=120 
																</C> 
																<C> Name='이자지급전표번호' ID=INTR_SLIP_NO Align=Center Width=120 
																</C> 
															</G>
															">
													</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__11); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
									</div>
									<div id=divTabPage2  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%">
										<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="100%" height="100%">
													<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__12"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridSUB02 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
														<PARAM NAME="DataID" VALUE="dsSUB01">
														<PARAM NAME="Editable" VALUE="0">
														<PARAM NAME="ColSelect" VALUE="-1">
														<PARAM NAME="ColSizing" VALUE="-1">
														<param name=UsingOneClick  value="1">
														<PARAM NAME="Format" VALUE=" 
															<FC> Name='증서번호' ID=GUAR_NO Align=Center Width=100 
															</FC> 
															<FC> Name=보증처 ID=GUARANTOR Width=120
															</FC> 
															<C> Name=보증내역 ID=GUAR_NOTE Width=200 
															</C> 
															<C> Name=보증시작일 ID=GUAR_START_DT Width=90  align=Center EditStyle=Popup
															</C> 
															<C> Name=보증만료일 ID=GUAR_END_DT Width=90  align=Center EditStyle=Popup  
															</C>
															<C> Name=보증원금 ID=GUAR_ORG_AMT Width=90
															</C>
															<C> Name=보증료 ID=GUAR_AMT Width=90
															</C>
															<C> Name=보증료율 ID=GUAR_RATE Width=90
															</C>
															<C> Name=보증료납부일 ID=GUAR_PAYMENT_DT Width=90 align=Center  EditStyle=Popup  
															</C>
															<C> Name=설정일 ID=GUAR_ESTAB_DT Width=90 align=Center  EditStyle=Popup  
															</C>
															<C> Name=해제일 ID=GUAR_CANCEL_DT Width=90 align=Center  EditStyle=Popup  
															</C>
															">
													</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__12); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
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