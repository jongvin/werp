<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFixMoveR.jsp(고정자산증감사항등록)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 고정자산배치현황등록 
/* 4. 변  경  이  력 : 한재원 작성(2006-01-19)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_WFixMoveR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN2=dsMAIN2)";
	CITData	lrArgData = null;
	String strOut = "";
	String strSql = "";
	String strAct = "";
	
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String strDEPT_NAME = "";
	String strDEPREC_FINISH 		= "";
	String strINCREDU_CLS		 	= "";
	String strDEPREC_FINISH_NAME	= "";

	
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
			strSql += " Where  CODE_GROUP_ID = 'INCREDU_CLS' \n";
			strSql += " And    USE_TAG = 'T' \n";
			strSql += " Order by SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			// 중요한 부분
			strINCREDU_CLS = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 증감구분 Select 오류 -> " + ex.getMessage());
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
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			
			
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN2 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsASSETCLS classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsDEPREC_FINISH classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMOVE_SEQ classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsCUR_DATE classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
												<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id="cboASSET_CLS_CODE" style="width:100" classid=clsid:60109D65-70C0-425c-B3A4-4CB001513C69 VIEWASTEXT codebase="../../../cabfiles/LuxeCombo.cab#version=1,1,0,16">
													<PARAM NAME="ComboStyle" VALUE="5">
													<PARAM NAME="EditExprFormat" VALUE="%;ASSET_CLS_NAME">
													<PARAM name="ListExprFormat" value="%;ASSET_CLS_NAME">
													<PARAM NAME="Index" VALUE="0">
													<PARAM NAME="Sort" VALUE="-1">
													<PARAM NAME="SearchColumn" VALUE="ASSET_CLS_CODE">
													<PARAM NAME="SortColumn" VALUE="ASSET_CLS_CODE">
													<PARAM NAME="BindColumn" VALUE="ASSET_CLS_CODE">
													<PARAM NAME="ComboDataID" VALUE="dsASSETCLS">
												</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="60" class="font_green_bold" >완료구분</td>
											<td width="102">
												<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id="cboDEPREC_FINISH" style="width:100" classid=clsid:60109D65-70C0-425c-B3A4-4CB001513C69 VIEWASTEXT codebase="../../../cabfiles/LuxeCombo.cab#version=1,1,0,16">
													<PARAM NAME="ComboStyle" VALUE="5">
													<PARAM NAME="EditExprFormat" VALUE="%;CODE_LIST_NAME">
													<PARAM name="ListExprFormat" value="%;CODE_LIST_NAME">
													<PARAM NAME="Index" VALUE="0">
													<PARAM NAME="Sort" VALUE="-1">
													<PARAM NAME="SearchColumn" VALUE="CODE_LIST_ID">
													<PARAM NAME="SortColumn" VALUE="CODE_LIST_ID">
													<PARAM NAME="BindColumn" VALUE="CODE_LIST_ID">
													<PARAM NAME="ComboDataID" VALUE="dsDEPREC_FINISH">
												</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__10); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
									&nbsp;
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
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__11"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN">
										<PARAM NAME="Editable" VALUE="false">
										<PARAM NAME="ColSelect" VALUE="false">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="Format" VALUE=" 
											<C> Name=순번 		ID=FIX_ASSET_SEQ			Align=Center	 Width=100   	  	Show='false'
											</C>
											<C> Name=자산번호 		ID=ASSET_MNG_NO			Align=Center	 Width=100   	 	Show='true'
											</C>
											<C> Name=자산명칭 		ID=ASSET_NAME		Align=Left	 Width=230   	  	Show='true'
											</C>
											<C> Name=장부가액 		ID=BASE_AMT		Align=Right	 Width=100   	 	Show='true'
											</C>
											<C> Name=기초충당금누계 		ID=OLD_DEPREC_AMT		Align=Right	 Width=100   	 	Show='true'
											</C>
											<C> Name=취득일자 		ID=GET_DT		Align=Center	 Width=80   	 	Show='true'
											</C>
											<C> Name=구매부서 		ID=MNG_DEPT_NAME		Align=Left	 Width=150   	 	Show='true'
											</C>
											
											
											">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__11); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
											<td class="font_green_bold"> 배치내역</td>
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
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__12"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN2 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT codebase="../../../cabfiles/toinbgrid.cab#version=1,1,0,125">
										<PARAM NAME="Editable"  	VALUE="-1">
										<PARAM NAME="ColSelect" 	VALUE="-1">
										<PARAM NAME="ColSizing" 	VALUE="-1">
										<PARAM NAME="SortView" 		VALUE="Right">
										<PARAM NAME="Format" 		VALUE="
											<C> Name=순번 				ID=FIX_ASSET_SEQ		Align=Center	Width=60   	 	Show='false'
											</C>
											<C> Name=배치순번 			ID=MOVE_SEQ		Align=Center	Width=60   	 	Show='false'
											</C>
											<C> Name=배치시작일자 		ID=MOVE_DT_FROM		Align=Center	Width=80   	 	Show='true'		EditStyle=Popup
											</C>
											<C> Name=배치종료일자 		ID=MOVE_DT_TO			Align=Center	Width=80   	 	Show='true'		EditStyle=Popup
											</C>
											<C> Name=관리부서 			ID=DEPT_CODE			Align=Left	Width=180   	 	Show='false'		 EditStyle=Popup
											</C>
											<C> Name=관리부서 			ID=DEPT_NAME			Align=Left	Width=180   	 	Show='true'		 EditStyle=Popup
											</C>
											<C> Name=사원명 				ID=EMP_NM			Align=Center	 Width=100   		Show='true'		 EditStyle=Popup
											</C>
											<C> Name='관리자(정)' 			ID=MNG_MAIN_NM			Align=Center	 Width=100   		Show='true'	 	EditStyle=Popup
											</C>
											<C> Name='관리자(부)' 			ID=MNG_SUB_NM			Align=Center	 Width=100   		Show='true'	 	EditStyle=Popup
											</C>
											<C> Name=실제순번 			ID=real_move_seq		Align=Center	Width=60   	 	Show='false'
											</C>
											">
										<PARAM NAME="DataID" VALUE="dsMAIN2">
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