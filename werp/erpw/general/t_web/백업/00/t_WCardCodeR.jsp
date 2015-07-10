<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WCardCodeR(신용카드관리)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2003-02-01)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_WCardCodeR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN,I:dsSUB01=dsSUB01)";
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String strBANK_MAIN_G = "";
	String	strDTF = "";
	String	strDTT = "";
	CITData lrArgData = null;
	
	try
	{
		CITCommon.initPage(request, response, session);
		//사업장 설정
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
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
		lrArgData = new CITData();
		try
		{
			strSql =
				"Select"+"\n"+
				"	F_T_DATETOSTRING(Trunc(Sysdate,'YYYY')) DTF,"+"\n"+
				"	F_T_DATETOSTRING(Sysdate) DTT"+"\n"+
				"From	Dual "+"\n";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strDTF = lrReturnData.toString(0,"DTF");
			strDTT = lrReturnData.toString(0,"DTT");
		}
		catch(Exception ex)
		{
			throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
		}
		lrArgData = new CITData();
		
		try
		{
			strSql  = 
				"select "+"\n"+
				"	2 GB,"+"\n"+
				"	a.BANK_MAIN_CODE CODE, "+"\n"+
				"	'['||a.BANK_MAIN_CODE||']'||a.BANK_MAIN_NAME NAME"+"\n"+
				"from	T_BANK_MAIN a "+"\n"+
				"Union All"+"\n"+
				"Select"+"\n"+
				"	1,"+"\n"+
				"	'',"+"\n"+
				"	''"+"\n"+
				"From	Dual"+"\n"+
				"order by"+"\n"+
				"	1,2"+"\n";
				
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strBANK_MAIN_G = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
			
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 직간구분 Select 오류 -> " + ex.getMessage());
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
			var			sDeptCode = "<%=CITCommon.enSC(strDEPT_CODE)%>";
			var			sDTF = "<%=strDTF%>";
			var			sDTT = "<%=strDTT%>";

		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object>
		<object id=dsSUB01 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object>
		<object id="dsLOV" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ></object>
		<object id="dsCARD_SEQ" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object>
		<object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="<%=strUpdateKeyValue%>">
			<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object>
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
														<td width="35" class=font_green_bold >구분</td>
														<td width="104">
															<select  name="cboCODE_CLASS"  style="WIDTH: 100px">
																<OPTION value='1'> 카드번호</OPTION>
																<OPTION value='2'> 신용카드명</OPTION>
																<OPTION value='3'> 소유자</OPTION>
															</select>
														</td>
														<td width="200"> <input name="txtSEARCH_CONDITION" type="text" Left class="box_ma5_white" VALUE="" style="width:190px"></td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60" class=font_green_bold>카드구분</td>
														<td width="100">
															<select  id="cboCARD_CLS"  style="WIDTH: 100px">
																<OPTION value='%'> 전체</OPTION>
																<OPTION value='1'> 법인</OPTION>
																<OPTION value='2'> 개인</OPTION>
															</select>
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
								<td height="70%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20"><img src="../images/bullet1.gif"></td>
														<td class="font_green_bold"> 신용카드목록</td>
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
												<OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsMAIN">
													<PARAM NAME="Editable" VALUE="true">
													<PARAM NAME="ColSelect" VALUE="true">
													<PARAM NAME="ColSizing" VALUE="true">
													<PARAM NAME="Format" VALUE="
														<C> Name=신용카드사 ID=BANK_MAIN_NAME Align=Left Width=100 	EditStyle=Popup
														</C>
														<C> Name=신용카드번호 ID=CARDNO Align=Left Width=130
														</C>
														<C> Name=신용카드명 ID=CARD_NAME	Align=Left Width=80
														</C>
														<C> Name=소유자 ID=CARD_OWNER Align=Center Width=80
														</C>
														<C> Name=카드구분 ID=CARD_CLS EditStyle=Combo Data='1:법인,2:개인' Align=Center  Width=60
														</C>
														<C> Name=결제일 ID=PAY_DATE Align=Center Width=50
														</C>
														<C> Name=만료년월 ID=EXPR_MONTH Align=Center Width=60 EditStyle=Popup
														</C>
														<C> Name=한도액 ID=LIMIT_AMT Align=Right Width=80
														</C>
														<C> Name=사용구분	ID=USE_TG Align=Center	EditStyle=CheckBox Width=60
														</C>
														<C> Name=폐기일 ID=UNUSED_DT Align=Center Width=100 EditStyle=Popup
														</C>
														">
												</OBJECT>
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
								<td height="70%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20"><img src="../images/bullet1.gif"></td>
														<td class="font_green_bold"> 카드보유이력</td>
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
												<OBJECT id=gridSUB01 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsSUB01">
													<PARAM NAME="Editable" VALUE="-1">
													<PARAM NAME="ColSelect" VALUE="-1">
													<PARAM NAME="ColSizing" VALUE="-1">
													<PARAM NAME="Format" VALUE="
														<C> Name='사용시작일' ID=USESTARTDATE	  Align=Center Width=90 EditStyle=Popup
														</C>
														<C> Name='소유자사번' ID=CARDOWNEREMPNO Align=Center Width=70
														</C>
														<C> Name='소유자명' ID=CARDOWNEREMPNAME Align=Left  Width=90
														</C>
														<C> Name='대리자사번' ID=CARDSUBSTITUTEEMPNO Align=Center Width=70
														</C>
														<C> Name='대리자명' ID=CARDSUBSTITUTEEMPNAME Align=Left  Width=90
														</C>
														<C> Name=걸제은행 ID=BANK_MAIN_CODE Align=Center   Width=120  EditStyle=Combo Data='<%=strBANK_MAIN_G%>'
														</C>
														<C> Name=결제계좌 ID=ACCNO Align=Center   Width=160
														</C>
														<C> Name=예금주 ID=ACCNO_OWNER Align=Center   Width=100
														</C>
														<C> Name='변경사유' ID=CHANGEREASON Align=Left  Width=300
														</C>
														">
												</OBJECT>
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