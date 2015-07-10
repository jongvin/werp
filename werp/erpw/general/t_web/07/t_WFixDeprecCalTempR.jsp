<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFixDeprecCalR.jsp(감가상각계산작업)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 감가상각계산작업 
/* 4. 변  경  이  력 : 한재원 작성(2006-01-19)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	String  strDATE  = CITDate.getNow("yyyyMMdd");
	String  strDATE1  = CITDate.getNow("yyyy-MM-dd");
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_WFixDeprecCalTempR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN,I:dsMAIN2=dsMAIN2,I:dsFIX_SHEET=dsFIX_SHEET,I:dsCALC=dsCALC)";
	CITData		lrArgData = null;
	String strOut = "";
	String strSql = "";
	String strAct = "";
	
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String strDEPT_NAME = "";
	String strTARGET_CLS = "";
	String strTRANS_CLS = "";
	String strB_DEPREC_FINISH = "";
	String strDEPREC_FINISH = "";
	String strCAL_CLS = "";

	String strEMP_NO ="";
	String strEMP_NM = "";
	
	try
	{
		CITCommon.initPage(request, response, session);
		
		//사업장 설정
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
		strDEPT_NAME = CITCommon.NvlString(session.getAttribute("long_name"));
		//사번,이름
		strEMP_NO =CITCommon.NvlString(session.getAttribute("emp_no"));
		strEMP_NM = CITCommon.NvlString(session.getAttribute("name"));
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
			strSql += " Where  CODE_GROUP_ID = 'CAL_CLS' \n";
			strSql += " And    USE_TAG = 'T' \n";
			strSql += " Order by SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			// 중요한 부분
			strCAL_CLS = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME"); // 가우스 그리드 Combo인 경우 사용
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 상각완료 Select 오류 -> " + ex.getMessage());
		}
		try
		{
			lrArgData = new CITData();
			strSql  = " Select CODE_LIST_ID as CODE, \n";
			strSql += "        CODE_LIST_NAME as NAME \n";
			strSql += " From   V_T_CODE_LIST \n";
			strSql += " Where  CODE_GROUP_ID = 'TARGET_CLS' \n";
			strSql += " And    USE_TAG = 'T' \n";
			strSql += " Order by SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			// 중요한 부분
			strTARGET_CLS = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME"); // 가우스 그리드 Combo인 경우 사용
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 작업대상 Select 오류 -> " + ex.getMessage());
		}
		try
		{
			lrArgData = new CITData();
			strSql  = " Select CODE_LIST_ID as CODE, \n";
			strSql += "        CODE_LIST_NAME as NAME \n";
			strSql += " From   V_T_CODE_LIST \n";
			strSql += " Where  CODE_GROUP_ID = 'TRANS_CLS' \n";
			strSql += " And    USE_TAG = 'T' \n";
			strSql += " Order by SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			// 중요한 부분
			strTRANS_CLS = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME"); // 가우스 그리드 Combo인 경우 사용
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 적용여부 Select 오류 -> " + ex.getMessage());
		}
			
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
			strDEPREC_FINISH = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
			
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
			strSql += " Where  CODE_GROUP_ID = 'DEPREC_FINISH' \n";
			strSql += " And    USE_TAG = 'T' \n";
			strSql += " Order by SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			// 중요한 부분
			strB_DEPREC_FINISH = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
			
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 완료구분 Select 오류 -> " + ex.getMessage());
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
			var 			olddata1 = "";
			var			olddata2 = "";
			var 			olddata3 = "";
			var			olddata4 = "";
			var			vDATE = "<%=strDATE%>";
			var			vDATE1 = "<%=strDATE1%>";
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			var			sEmpNo ="<%= strEMP_NO %>";
			var			sEmpNm ="<%= strEMP_NM %>";
			
		//-->
		</script>
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsFIX_SHEET classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsCALC classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN2 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN3 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsASSETCLS" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLOV 	classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsWORK_SEQ 	classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id="dsCOMPANY_CODE"  classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id="dsDEPREC_FINISH01"  classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__10); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__11"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      		<param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  	<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__11); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__12"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transBatch"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      		<param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  	<param name="Action"    value="<%=strFileName%>_tr.jsp">
		<object id="transApply"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      		<param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  	<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__12); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		
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
											<td width="60">&nbsp;</td>
 											<td width="15"><img src="../images/bullet3.gif"></td>
 											<td width="60" class=font_green_bold >작업일자</td>
											<td width="75"> <input name="txtWORK_DT_FROM" type="text" datatype="DATE" style="width:70px" VALUE="" onChange="txtWORK_DT_FROM_onChange()"></td>
											<td width="20"><input id="btnWORK_DT_FROM" type="button" class="img_btnCalendar_S" title="달력" onclick="btnWORK_DT_FROM_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
											<td width="12">~</td>
											<td width="75"> <input name="txtWORK_DT_TO" type="text" datatype="DATE" align="Center" style="width:70px" VALUE="" onChange="txtWORK_DT_TO_onChange()"></td>
											<td width="20"><input id="btnWORK_DT_TO" type="button" class="img_btnCalendar_S" title="달력" onclick="btnWORK_DT_TO_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
											<td width="143">&nbsp;</td>
											<td>&nbsp;</td>
											<td width=*>&nbsp;</td>
										</tr>
									</table>
									
								</td>
							</tr>
							<tr> 
								<td width="100%" class="td_green">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="60" class="font_green_bold" >귀속부서</td>
											<td width="52">
												<input id="txtDEPT_CODE" type="text" style="width:50px" onblur="txtDEPT_CODE_onblur()">
											</td>
											<td width="150">
												<input id="txtDEPT_NAME" type="text" readOnly class="ro" style="width:148px">
											</td>
											<td width="30">
												<input id="btnDEPT_CODE" type="button" class="img_btnFind" value="검색" onclick="btnDEPT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width="60">&nbsp;</td>
 											<td width="15"><img src="../images/bullet3.gif"></td>
 											<td width="60" class=font_green_bold >귀속일자</td>
											<td width="75"> <input id="txtSUM_DT_FROM" type="text" datatype=DATE style="width:70px" VALUE="" onChange="txtSUM_DT_FROM_onChange()"></td>
											<td width="20"><input id="btnSUM_DT_FROM" type="button" class="img_btnCalendar_S" title="달력" onclick="btnSUM_DT_FROM_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
											<td width="12">~</td>
											<td width="75"> <input id="txtSUM_DT_TO" type="text" datatype=DATE align="Center" style="width:70px" VALUE=""  onChange="txtSUM_DT_TO_onChange()"></td>
											<td width="20"><input id="btnSUM_DT_TO" type="button" class="img_btnCalendar_S" title="달력" onclick="btnSUM_DT_TO_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
											<td width="143">&nbsp;</td>
											<td>&nbsp;</td>
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
								<td class="font_green_bold">모의감가상각작업일지</td>
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
						<table width="100%" height="200" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%" height="100%">
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__13"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN">
										<PARAM NAME="Editable" VALUE="1">
										<PARAM NAME="ColSelect" VALUE="false">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="UsingOneClick " VALUE="1">
										<PARAM NAME="Format" VALUE=" 
											<C> Name=작업순번 			ID=WORK_SEQ		Align=Center	Width=60   	 	Show='true'
											</C>
											<C> Name=작업일자 		ID=WORK_DT			Align=Left	 Width=80   	 Show='true'
											</C>
											<C> Name=작업명 			ID=WORK_NAME		Align=Left	 Width=200   	 Show='true'
											</C>
											<C> Name=작업대상 		ID=TARGET_CLS		Align=Center	 Width=80  	 Show='true'	EditStyle='Combo' Data='<%=strTARGET_CLS%>'
											</C>
											<C> Name=작업자사번 		ID=WORK_USENO		Align=Center	 Width=80   	Show='true' EditStyle=popup
											</C>
											<C> Name=작업자 			ID=EMP_NM			Align=Center	 Width=80   	Show='true'		
											</C>
											<C> Name=기간시작일 		ID=WORK_FROM_DT	Align=Center	 Width=80   	Show='true'  EditStyle=popup
											</C>
											<C> Name=기간종료일 		ID=WORK_TO_DT		Align=Center	 Width=80   	Show='true' EditStyle=popup
											</C>
											<C> Name=적용여부 		ID=TRANS_CLS		Align=Center	 Width=70   	Show='true'	EditStyle='Combo' Data='<%=strTRANS_CLS%>' Edit='none'
											</C>
											<C> Name=상각기준 		ID=CAL_CLS			Align=Center	 Width=80   	 Show='true'	EditStyle='Combo' Data='<%=strCAL_CLS%>'  Show='false'
											</C>
											<C> Name='비    고' 		ID=REMARK			Align=Left	 Width=250   	 Show='true'
											</C>
											
											">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__13); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
								<td width="60%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold"> 감가상각 작업내역</td>
											<td align="right" width="*">
												<input id="btnCalc" type="button" class="img_btn6_1" value="감가상각계산" onclick="btnCalc_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												<input id="btnApply" type="button" class="img_btn2_1" value="적용" onclick="btnApply_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												<input id="btnApplyCancel" type="button" class="img_btn4_1" value="적용취소" onclick="btnApplyCancel_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr class="head_line">
											<td width="*" height="3"></td>
										</tr>
									</table>
								</td>
								<td width="10">&nbsp;</td>
								<td width="*">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold"> 부서별 상각액</td>
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
								<td width="60%" height="100%">
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__14"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN2 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT codebase="../../../cabfiles/toinbgrid.cab#version=1,1,0,125">
										<PARAM NAME="Editable"  	VALUE="1">
										<PARAM NAME="ColSelect" 	VALUE="-1">
										<PARAM NAME="ColSizing" 	VALUE="-1">
										<PARAM NAME="SortView" 		VALUE="Right">
										<PARAM NAME="Format" 		VALUE="
											<C> Name=작업순번 			ID=WORK_SEQ		Align=Center	Width=60   	 	Show='false'
											</C>	
											<FC> Name=자산관리번호 		ID=ASSET_MNG_NO Align=Center 		Width=80 edit=none
											</FC>
											<FC> Name=고정자산명 			ID=ASSET_NAME 	Align=left 		Width=150 edit=none
											</FC>
											<FC> Name=당기상각액 			ID=CURR_DEPREC_AMT				Align=Right	Width=80   	 	Show='true'
											</FC>
											<C> Name=상각율 				ID=DEPREC_RAT					Align=Center		Width=50   	Show='true'
											</C>
											<C> Name=이전_수량 			ID=BEFORE_ASSET_CNT				Align=Right		Width=60   	Show='true'
											</C>
											<C> Name=이전_작업순번 		ID=BEFORE_WORK_SEQ				Align=Right	Width=85   	 	Show='true'
											</C>
											<C> Name=이전_장부가액 		ID=BEFORE_BASE_AMT				Align=Right	Width=90   	 	Show='true'
											</C>
											<C> Name=이전_기상각액 		ID=BEFORE_OLD_DEPREC_AMT		Align=Right	Width=90   	 	Show='true'
											</C>
											<C> Name=이전_상각완료여부 	ID=BEFORE_DEPREC_FINISH			Align=Center	Width=120   	 	Show='true'	EditStyle='Combo' Data='<%=strB_DEPREC_FINISH%>'
											</C>
											<C> Name=이전_증액누계 		ID=BEFORE_INC_SUM_AMT			Align=Right	Width=85   	 	Show='true'
											</C>
											<C> Name=이전_감액누계 		ID=BEFORE_SUB_SUM_AMT			Align=Right	Width=85   	 	Show='true'
											</C>
											<C> Name=장부가액 			ID=BASE_AMT						Align=Right	Width=80   	 	Show='true'
											</C>
											<C> Name=기상각액 			ID=OLD_DEPREC_AMT				Align=Right	Width=80   	 	Show='true'
											</C>
											<C> Name=상각완료여부 		ID=DEPREC_FINISH					Align=Center	Width=80   	 	Show='true'	EditStyle='Combo' Data='<%=strDEPREC_FINISH%>'
											</C>
											<C> Name=증액누계 			ID=INC_SUM_AMT					Align=Right	Width=80   	 	Show='true'
											</C>
											<C> Name=감액누계 			ID=SUB_SUM_AMT					Align=Right	Width=80   	 	Show='true'
											</C>
											<C> Name=집계수량 			ID=SUM_CNT						Align=Right	Width=60   	 	Show='true'
											</C>
											">
										<PARAM NAME="DataID" VALUE="dsMAIN2">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__14); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
								</td>
								<td width="10">&nbsp;</td>
								<td width="*" height="100%">
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__15"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN3 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT codebase="../../../cabfiles/toinbgrid.cab#version=1,1,0,125">
										<PARAM NAME="Editable"  	VALUE="False">
										<PARAM NAME="ColSelect" 	VALUE="-1">
										<PARAM NAME="ColSizing" 	VALUE="-1">
										<PARAM NAME="SortView" 		VALUE="Right">
										<PARAM NAME="Format" 		VALUE="
											<C> Name=배치부서 		ID=DEPT_NAME	Align=Center	Width=80
											</C>	
											<C> Name=귀속시작일자 	ID=SUM_DT_FROM Align=Center 	Width=80
											</C>
											<C> Name=귀속종료일자 	ID=SUM_DT_TO 	Align=Center 	Width=80
											</C>
											<C> Name=상각액 			ID=DEPREC_AMT	Align=Right	Width=110
											</C>
											">
										<PARAM NAME="DataID" VALUE="dsMAIN3">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__15); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
								</td>
							</tr>
							<tr>
								<td width="60%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr class="head_line">
											<td width="*" height="3"></td>
										</tr>
									</table>
								</td>
								<td width="10">&nbsp;</td>
								<td width="*">
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