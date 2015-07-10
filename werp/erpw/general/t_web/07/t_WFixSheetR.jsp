<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFixSheetR.jsp(고정자산대장등록)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 고정자산대장등록 
/* 4. 변  경  이  력 : 한재원 작성(2006-01-17)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData 	lrReturnData = null;
	String strDate = CITDate.getNow("yyyy-MM-dd");
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String 	strFileName = "./t_WFixSheetR";
//저장 액션
	String 	strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";
	CITData	lrArgData = null;
	String 	strOut = "";
	String 	strSql = "";
	String 	strAct = "";
	
	String 	strCOMP_CODE = "";
	String 	strDEPT_CODE = "";
	String 	strCOMPANY_NAME = "";
	String 	strDEPT_NAME = "";
	String 	strDEPREC_FINISH 			= "";
	String 	strFIXED_CLS		 		= "";
	String 	strGET_CLS		 		= "";
	String 	strDEPREC_CLS	 		= "";
	String 	strNEW_OLD_ASSET	 	= "";
	String 	strDEPREC_FINISH_NAME	= "";
	String 	strINCNTRY_OUTCNTRY_CLS  = "";
	String 	strMONEY_CLS			   	= "";
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
			
		try
		{
			lrArgData = new CITData();
			strSql  = " Select CODE_LIST_ID as CODE, \n";
			strSql += "        CODE_LIST_NAME as NAME \n";
			strSql += " From   V_T_CODE_LIST \n";
			strSql += " Where  CODE_GROUP_ID = 'DEPREC_FINISH' \n";
			strSql += " And    USE_TAG = 'T' \n";
			strSql += " Order by SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			// 중요한 부분
			strDEPREC_FINISH = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
			strDEPREC_FINISH_NAME = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 완료구분 Select 오류 -> " + ex.getMessage());
		}
		try
		{
			lrArgData = new CITData();
			strSql  = " Select CODE_LIST_ID as CODE, \n";
			strSql += "        CODE_LIST_NAME as NAME \n";
			strSql += " From   V_T_CODE_LIST \n";
			strSql += " Where  CODE_GROUP_ID = 'FIXED_CLS' \n";
			strSql += " And    USE_TAG = 'T' \n";
			strSql += " Order by SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			// 중요한 부분
			strFIXED_CLS = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 완료구분 Select 오류 -> " + ex.getMessage());
		}
		try
		{
			lrArgData = new CITData();
			strSql  = " Select CODE_LIST_ID as CODE, \n";
			strSql += "        CODE_LIST_NAME as NAME \n";
			strSql += " From   V_T_CODE_LIST \n";
			strSql += " Where  CODE_GROUP_ID = 'GET_CLS' \n";
			strSql += " And    USE_TAG = 'T' \n";
			strSql += " Order by SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			// 중요한 부분
			strGET_CLS = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 완료구분 Select 오류 -> " + ex.getMessage());
		}
		try
		{
			lrArgData = new CITData();
			strSql  = " Select CODE_LIST_ID as CODE, \n";
			strSql += "        CODE_LIST_NAME as NAME \n";
			strSql += " From   V_T_CODE_LIST \n";
			strSql += " Where  CODE_GROUP_ID = 'DEPREC_CLS' \n";
			strSql += " And    USE_TAG = 'T' \n";
			strSql += " Order by SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			// 중요한 부분
			strDEPREC_CLS = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 완료구분 Select 오류 -> " + ex.getMessage());
		} 
		try
		{
			lrArgData = new CITData();
			strSql  = " Select CODE_LIST_ID as CODE, \n";
			strSql += "        CODE_LIST_NAME as NAME \n";
			strSql += " From   V_T_CODE_LIST \n";
			strSql += " Where  CODE_GROUP_ID = 'NEW_OLD_ASSET' \n";
			strSql += " And    USE_TAG = 'T' \n";
			strSql += " Order by SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			// 중요한 부분
			strNEW_OLD_ASSET = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 완료구분 Select 오류 -> " + ex.getMessage());
		}
		try
		{
			lrArgData = new CITData();	
			strSql  = " Select CODE_LIST_ID as CODE, \n";
			strSql += "        CODE_LIST_NAME as NAME \n";
			strSql += " From   V_T_CODE_LIST \n";
			strSql += " Where  CODE_GROUP_ID = 'INCNTRY_OUTCNTRY_CLS' \n";
			strSql += " And    USE_TAG = 'T' \n";
			strSql += " Order by SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			// 중요한 부분
			strINCNTRY_OUTCNTRY_CLS = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 국내외구분 Select 오류 -> " + ex.getMessage());
		} 
		
		try
		{
			lrArgData = new CITData();	
			strSql = " select '' code, '' name \n";
			strSql += " from dual \n";
			strSql += " union \n";
			strSql += " Select CODE_LIST_ID as CODE, \n";
			strSql += "        CODE_LIST_NAME as NAME \n";
			strSql += " From   V_T_CODE_LIST \n";
			strSql += " Where  CODE_GROUP_ID = 'MONEY_CLS' \n";
			strSql += " And    USE_TAG = 'T' \n";
			strSql += " Order by 1 desc\n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			// 중요한 부분
			strMONEY_CLS = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 국내외구분 Select 오류 -> " + ex.getMessage());
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
			var			vDate = "<%=strDate%>";
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			
			
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsASSETCLS classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsDEPREC_FINISH classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsFIX_ASSET_SEQ classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsFIX_ASSET_NO classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsFIX_SHEET_COPY classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsREMOVE classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      		<param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  	<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transFixSheetCopy"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsFIX_SHEET_COPY=dsFIX_SHEET_COPY)">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
			<param name=Parameter  value="ACT=FIX_SHEET_COPY">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__10); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__11"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transREMOVE"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      		<param name="KeyValue" value="Service1(I:dsREMOVE=dsREMOVE)">
		  	<param name="Action"    value="<%=strFileName%>_tr.jsp">
		  	<param name=Parameter  value="ACT=REMOVE">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__11); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!-- 가우스 Dataset 및 Tranaction 객체정의 종료 //-->
	</head>
	<body onload="C_Initialize()">
		<div id="divMainFix" class="main_div">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top"> 
					<td width="100%">
						<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
						<iframe width="0" height="0" name="ifrmBarCode" src="../common/BarCode.jsp" frameborder="0" tabindex="-1"></iframe>
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
											<td width="60" class="font_green_bold" >사업장</td>
											<td width="52">
												<input id="txtCOMP_CODE" type="text" style="width:50px" onblur="txtCOMP_CODE_onblur()">
											</td>
											<td width="150">
												<input id="txtCOMPANY_NAME" type="text" readOnly class="ro" style="width:148px">
											</td>
											<td width="30">
												<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="검색" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width=60>&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="60" class="font_green_bold" >자산구분</td>
											<td width="186">
												<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__12"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id="cboASSET_CLS_CODE" style="width:100" classid=clsid:60109D65-70C0-425c-B3A4-4CB001513C69 VIEWASTEXT codebase="../../../cabfiles/LuxeCombo.cab#version=1,1,0,16">
													<PARAM NAME="ComboStyle" VALUE="5">
													<PARAM NAME="EditExprFormat" VALUE="%;ASSET_CLS_NAME">
													<PARAM name="ListExprFormat" value="%;ASSET_CLS_NAME">
													<PARAM NAME="Index" VALUE="0">
													<PARAM NAME="Sort" VALUE="-1">
													<PARAM NAME="SearchColumn" VALUE="ASSET_CLS_CODE">
													<PARAM NAME="SortColumn" VALUE="ASSET_CLS_CODE">
													<PARAM NAME="BindColumn" VALUE="ASSET_CLS_CODE">
													<PARAM NAME="ComboDataID" VALUE="dsASSETCLS">
												</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__12); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="60" class="font_green_bold" >완료구분</td>
											<td width="102">
												<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__13"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id="cboDEPREC_FINISH" style="width:100" classid=clsid:60109D65-70C0-425c-B3A4-4CB001513C69 VIEWASTEXT codebase="../../../cabfiles/LuxeCombo.cab#version=1,1,0,16">
													<PARAM NAME="ComboStyle" VALUE="5">
													<PARAM NAME="EditExprFormat" VALUE="%;CODE_LIST_NAME">
													<PARAM name="ListExprFormat" value="%;CODE_LIST_NAME">
													<PARAM NAME="Index" VALUE="0">
													<PARAM NAME="Sort" VALUE="-1">
													<PARAM NAME="SearchColumn" VALUE="CODE_LIST_ID">
													<PARAM NAME="SortColumn" VALUE="CODE_LIST_ID">
													<PARAM NAME="BindColumn" VALUE="CODE_LIST_ID">
													<PARAM NAME="ComboDataID" VALUE="dsDEPREC_FINISH">
												</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__13); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
											</td>
											<td width=*>&nbsp;</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="60" class="font_green_bold" >품목구분</td>
											<td width="52">
												<input id="txtITEM_CODE" type="text" style="width:50px" onblur="txtITEM_CODE_onblur()">
											</td>
											<td width="150">
												<input id="txtITEM_NAME" type="text" readOnly class="ro" style="width:148px">
											</td>
											<td width="30">
												<input id="btnITEM_CODE" type="button" class="img_btnFind" value="검색" onclick="btnITEM_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width="3">&nbsp;</td>
											<td width="20">&nbsp;</td>
											<td width="28">&nbsp;</td>
											<td width="5">&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="60" class="font_green_bold" >품명구분</td>
											<td width="52">
												<input id="txtSRVLIFE_H" type="hidden">
												<input id="txtDEPREC_CLS_H" type="hidden">
												<input id="txtITEM_NM_CODE" type="text" style="width:50px" onblur="txtITEM_NM_CODE_onblur()">
											</td>
											<td width="150">
												<input id="txtITEM_NM_NAME" type="text" readOnly class="ro" style="width:148px">
											</td>
											<td width="30">
												<input id="btnITEM_NM_CODE" type="button" class="img_btnFind" value="검색" onclick="btnITEM_NM_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width="3">&nbsp;</td>
											<td width="20">&nbsp;</td>
											<td width="30">&nbsp;</td>
											<td width="10">&nbsp;</td>
											<td width=*>&nbsp;</td>
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
								<td class="font_green_bold">자산명칭</td>
								<td align="right">
									<input id="btnPrintBarCode" type="button" class="img_btn6_1" value="바코드인쇄" onclick="btnPrintBarCode_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
									&nbsp;&nbsp;
									<input id="btnFixSheetCopy" type="button" class="img_btn6_1" value="자산복사추가" onclick="btnFixSheetCopy_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
									<input id="btnMakeInSlip" type="button" class="img_btn4_1" value="전표발행" onclick="btnMakeInSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
									<input id="btnShowSlip" type="button" class="img_btn4_1" value="전표보기" onclick="btnShowSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
									<input id="btnRemoveSlip" type="button" class="img_btn4_1" value="전표삭제" onclick="btnRemoveSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
								</td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="head_line">
								<td width="*" height="3"></td>
							</tr>
						</table>
						<table width="100%" height="250" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%" height="100%">
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__14"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN">
										<PARAM NAME="Editable" VALUE="true">
										<PARAM NAME="UsingOneClick" VALUE="true">
										<PARAM NAME="ColSelect" VALUE="false">
										<param name=SortView  value="Left">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="Format" VALUE=" 
											<C> Name=자산번호 		ID=ASSET_MNG_NO	Align=Center	 Width=100   	Show='true'     Sort='true'
											</C>
											<C> Name=자산명칭 		ID=ASSET_NAME		Align=Left	 Width=250   	Show='true'  Sort='true'
											</C>
											<C> Name=완료구분 		ID=DEPREC_FINISH	EditStyle='Combo' Data='<%=strDEPREC_FINISH_NAME%>'	Align=Center	 Width=100 Show='true'
											</C>
											<C> Name=전표ID  		ID=SLIP_ID		Align=Left	 Width=80   	Show='false'
											</C>
											<C> Name=취득일   		ID=GET_DT		Align=CENTER	 Width=100   	Show='true'  Sort='true'
											</C>
											<C> Name='전표번호' 		ID='MAKE_SLIPNO'			Width=120
											</C> 
											">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__14); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold"> 세부내역</td>
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
							<tr  valign="top"
>
								<td width="100%"  height="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td bgcolor="#FFFFFF">
												<!-- 프로그래머 디자인 시작 //-->
												<!-- 간격조정 테이블 시작 //-->
												
												<!-- 간격조정 테이블 종료 //-->
												
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="10">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">고정자산구분</td>
														<td width="200"><select id="cbo_FIXED_CLS"  style="WIDTH: 100px" class="input_listbox_default" ><%=strFIXED_CLS%></select></td>
														<td width="50">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">비품</td>
														<td width="175"><input id=chkFIXTURES_CLS type=checkbox class="check"></td>
														<td width="20">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">부외자산</td>
														<td width="100"><input id=chkETC_ASSET_TAG type=checkbox class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'ETC_ASSET_TAG') = this.checked ? 'T' : 'F'"></td>
														<td width=*>&nbsp;</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="10">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">자산명칭</td>
														<td width="200"> <input id="txtASSET_NAME" type="text" style="width:199px" notnull></td>
														<td width="50">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">규 격</td>
														<td width="175"> <input id="txtASSET_SIZE" type="text" style="width:172px" ></td>
														<td width="20">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">수 량</td>
														<td width="100">
														      <input id="txtASSET_CNT" type="text"  style="width : 98px" RIGHT notnull>
														</td>
														<td>&nbsp;</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="10">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">취득구분</td>
														<td width="102"><select id="cbo_GET_CLS"  style="WIDTH: 100px" class="input_listbox_default" ><%=strGET_CLS%></select></td>
														<td width="148">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">취득일자</td>
														<td width="100"> <input id="txtGET_DT" type="text" datatype="date" style="width:98px" center notnull></td>
														<td width="95">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">폐기/매각일자</td>
														<td width="100"> <input id="txtSALE_DT" type="text" datatype="date" style="width:98px" center></td>
														
														<td>&nbsp;</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="10">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">구매부서</td>
														<td width="70"><input id="txtMNG_DEPT_CODE" type="text"  style="width : 68px"  onblur="txtMNG_DEPT_CODE_onblur()"></td>
														<td width="191"><input id="txtMNG_DEPT_NAME" type="text"  style="width : 189px" class="ro" readOnly="true" ></td>
														<td width="40" align="Left">
															<input id="btnMNG_DEPT_CODE" 	type="button" class="btn2_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="찾기" onclick="btnMNG_DEPT_CODE_onClick()"/>
														</td>
														<td width="59">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60">귀속부서</td>
														<td width="70"><input id="txtDEPT_CODE" type="text"  style="width : 68px"  onblur="txtDEPT_CODE_onblur()" notnull></td>
														<td width="191"><input id="txtDEPT_NAME" type="text"  style="width : 189px" class="ro" readOnly="true" ></td>
														<td width="35"  align="Left">
															<input id="btnDEPT_CODE" 	type="button" class="btn2_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="찾기" onclick="btnDEPT_CODE_onClick()"/>
														</td>
														<td>&nbsp;</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="10">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">견적처</td>
														<input id="hiCUST_SEQ2" type="hidden">
														<td width="100"><input id="txtEST_CUST_CODE" type="text"  datatype="CUSTNO" center style="width : 98px"  onblur="txtEST_CUST_CODE_onblur()"></td>
														<td width="198"><input id="txtEST_CUST_NAME" type="text"  style="width : 196px" class="ro" readOnly="true" ></td>
														<td width="40" align="Left">
															<input id="btnEST_CUST_CODE" 	type="button" class="btn2_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="찾기" onclick="btnEST_CUST_CODE_onClick()"/>
														</td>
														<td width="22">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60">견적가</td>
														<td width="100">
															<input id="txtESTIMATE_AMT1" type="text"  datatype=DOTCURRENCY style="width : 98px" right>
														</td>
														<td width="23">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60">복수견적가</td>
														<td width="100">
															<input id="txtESTIMATE_AMT2" type="text"  datatype=DOTCURRENCY style="width : 98px" right>
														</td>
														<td>&nbsp;</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="10">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">구입처</td>
														<input id="hiCUST_SEQ" type="hidden">
														<td width="100"><input id="txtCUST_CODE" type="text"  datatype="CUSTNO" center style="width : 98px"  onblur="txtCUST_CODE_onblur()"></td>
														<td width="198"><input id="txtCUST_NAME" type="text"  style="width : 196px" class="ro" readOnly="true" ></td>
														<td width="40" align="Left">
															<input id="btnCUST_CODE" 	type="button" class="btn2_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="찾기" onclick="btnCUST_CODE_onClick()"/>
														</td>
														<td width="22">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60">화폐구분</td>
														<td width="102"><select id="cbo_MONEY_CLS"  style="WIDTH: 100px" class="input_listbox_default" ><%=strMONEY_CLS%></select></td>
														<td width="21">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60">외환가격</td>
														<td width="100">
															<input id="txtFOREIGN_AMT" type="text"  datatype=CURRENCY style="width : 98px" right>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="10">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">취득원가</td>
														<td width="100">
														    <input id="txtGET_COST_AMT" type="text"  datatype=DOTCURRENCY style="width : 98px" notnull>
														</td>
														<td width="43">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60">내용년수</td>
														<td width="100">
															<input id="txtSRVLIFE" type="text"  style="width : 98px" right>
														<td width="42">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60">처분년수</td>
														<td width="100">
															<input id="txtDISPOSE_YEAR" type="text"  style="width : 98px" right>
														<td>&nbsp;</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="10">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">증액누계</td>
														<td width="100">
															<input id="txtINC_SUM_AMT" type="text"  datatype=DOTCURRENCY style="width : 98px" right notnull>
														<td width="43">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60">감액누계</td>
														<td width="100">
															<input id="txtSUB_SUM_AMT" type="text"  datatype=DOTCURRENCY style="width : 98px" right notnull>
														</td>
														<td width="42">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60">상각누계</td>
														<td width="100">
															<input id="txtOLD_DEPREC_AMT" type="text"  datatype=DOTCURRENCY style="width : 98px" right notnull>
														</td>
														<td width="23">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60">잔존가액</td>
														<td width="100">
															<input id="txtBASE_AMT" type="text"  datatype=CURRENCY style="width : 98px" right notnull>
														<td>&nbsp;</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="10">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">상각구분</td>
														<td width="102"><select id="cbo_DEPREC_CLS"  style="WIDTH: 100px" class="input_listbox_default" ><%=strDEPREC_CLS%></select></td>
														<td width="41">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60">자산구분</td>
														<td width="102"><select id="cbo_NEW_OLD_ASSET"  style="WIDTH: 100px" class="input_listbox_default" ><%=strNEW_OLD_ASSET%></select></td>
														<td width="40">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60">완료구분</td>
														<td width="102"><select id="cbo_DEPREC_FINISH"  style="WIDTH: 100px" class="input_listbox_default" ><%=strDEPREC_FINISH%></select></td>
														<td width="21">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60">국내외구분</td>
														<td width="102"><select id="cbo_INCNTRY_OUTCNTRY_CLS"  style="WIDTH: 100px" class="input_listbox_default" ><%=strINCNTRY_OUTCNTRY_CLS%></select></td>
														<td>&nbsp;</td>
													</tr>
												</table>
												
												
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="10">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">제작회사</td>
														<td width="318"> <input id="txtPRODUCTION" type="text"  style="width:316px"></td>
														<td width="42">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60">용도</td>
														<td width="297"> <input id="txtUSAGE" type="text"  style="width:295px"></td>
														<td>&nbsp;</td>
													</tr>
												</table>
												
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="10">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">비고</td>
														<td width="700"> <input id="txtREMARK" type="text" style="width:316px"></td>
														<td>&nbsp;</td>
													</tr>
												</table>
												<!-- 간격조정 테이블 시작 //-->
												<table width="800" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td height="10"></td>
													</tr>
												</table>
												<!-- 간격조정 테이블 종료 //-->
												<!-- 프로그래머 디자인 종료 //-->
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
							
						</table>
					</td>
				</tr>
				<!-- 프로그래머 디자인 종료 //-->
			</table>
		</div>
		<!-- 가우스 Bind 객체정의 시작 //-->
		<!-- 가우스 Bind 객체정의 종료 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__15"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=ADE_Bind_1 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
	<PARAM NAME="DataID" VALUE="dsMAIN">
	<PARAM NAME="BindInfo" VALUE="
		<C>Col=GET_DT                         Ctrl=txtGET_DT                  Param=value
		</C>
		<C>Col=ASSET_NAME                   Ctrl=txtASSET_NAME              Param=value
		</C>
		<C>Col=ASSET_SIZE                   Ctrl=txtASSET_SIZE              Param=value
		</C>
		<C>Col=PRODUCTION                   Ctrl=txtPRODUCTION              Param=value
		</C>
		<C>Col=CUST_SEQ                    Ctrl=hiCUST_SEQ               Param=value
		</C>
		<C>Col=CUST_SEQ2                    Ctrl=hiCUST_SEQ2               Param=value
		</C>
		<C>Col=CUST_CODE                   Ctrl=txtCUST_CODE               Param=value
		</C>
		<C>Col=EST_CUST_CODE                   Ctrl=txtEST_CUST_CODE               Param=value
		</C>
		<C>Col=USAGE                       Ctrl=txtUSAGE                  Param=value
		</C>
		<C>Col=GET_CLS                      Ctrl=cbo_GET_CLS                Param=value
		</C>
		<C>Col=DEPREC_CLS                   Ctrl=cbo_DEPREC_CLS             Param=value
		</C>
		<C>Col=SRVLIFE                      Ctrl=txtSRVLIFE                 Param=value
		</C>
		<C>Col=ASSET_CNT                    Ctrl=txtASSET_CNT               Param=value
		</C>
		<C>Col=BASE_AMT                     Ctrl=txtBASE_AMT                Param=value
		</C>
		<C>Col=ESTIMATE_AMT1            Ctrl=txtESTIMATE_AMT1                Param=value
		</C>
		<C>Col=ESTIMATE_AMT2            Ctrl=txtESTIMATE_AMT2               Param=value
		</C>
		<C>Col=FOREIGN_AMT                     Ctrl=txtFOREIGN_AMT                Param=value
		</C>
		<C>Col=OLD_DEPREC_AMT               Ctrl=txtOLD_DEPREC_AMT          Param=value
		</C>
		<C>Col=GET_COST_AMT                 Ctrl=txtGET_COST_AMT            Param=value
		</C>
		<C>Col=INC_SUM_AMT                  Ctrl=txtINC_SUM_AMT             Param=value
		</C>
		<C>Col=SUB_SUM_AMT                  Ctrl=txtSUB_SUM_AMT             Param=value
		</C>
		<C>Col=NEW_OLD_ASSET                Ctrl=cbo_NEW_OLD_ASSET           Param=value
		</C>
		<C>Col=INCNTRY_OUTCNTRY_CLS       Ctrl=cbo_INCNTRY_OUTCNTRY_CLS           Param=value
		</C>
		<C>Col=MONEY_CLS     				Ctrl=cbo_MONEY_CLS           Param=value
		</C>
		<C>Col=FIXED_CLS                    		Ctrl=cbo_FIXED_CLS               		Param=value
		</C>
		<C>Col=FIXTURES_CLS             	 	Ctrl=chkFIXTURES_CLS               	Param=checked
		</C>
		<C>Col=ETC_ASSET_TAG                    Ctrl=chkETC_ASSET_TAG     Param=checked
		</C>
		<C>Col=DISPOSE_YEAR                      Ctrl=txtDISPOSE_YEAR            Param=value
		</C>
		<C>Col=DEPREC_FINISH                Ctrl=cbo_DEPREC_FINISH           Param=value
		</C>
		<C>Col=MNG_DEPT_CODE                Ctrl=txtMNG_DEPT_CODE           Param=value
		</C>
		<C>Col=DEPT_CODE                Ctrl=txtDEPT_CODE           Param=value
		</C>
		<C>Col=SALE_DT                      Ctrl=txtSALE_DT                 Param=value
		</C>
		
		<C>Col=REMARK                       Ctrl=txtREMARK                  Param=value
		</C>
		
		
		
		<C>Col=CUST_NAME                    Ctrl=txtCUST_NAME               Param=value
		</C>
		<C>Col=EST_CUST_NAME             Ctrl=txtEST_CUST_NAME               Param=value
		</C>
		<C>Col=DEPREC_FINISH_NAME      Ctrl=txtDEPREC_FINISH_NAME      Param=value
		</C>
		<C>Col=ACC_NAME                      Ctrl=txtACC_NAME               Param=value
		</C>
		<C>Col=MNG_DEPT_NAME            Ctrl=txtMNG_DEPT_NAME       Param=value
		</C>
		<C>Col=DEPT_NAME                    Ctrl=txtDEPT_NAME               Param=value
		</C>
		">
</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__15); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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