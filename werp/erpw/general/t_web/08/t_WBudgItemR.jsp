<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WBudgItemR(예산항목등록)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-21)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_WBudgItemR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN,I:dsMAIN_D=dsMAIN_D)";
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strDEPT_NAME = "";
	String strCOMPANY_NAME = "";
	CITData		lrArgData = null;
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
		<script language="javascript" src="../script/flexgridint.js"></script>
		<script language="javascript" src="../script/ContextMenu.js"></script>
		<script language="javascript" src="<%=strFileName%>.js"></script>
		<script language="javascript">
		<!--
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			var			sCompCode = "<%= strCOMP_CODE %>";
			var			sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
			
			// 이벤트관련-------------------------------------------------------------------//
			
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN_D classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsBUDG_CODE_NO classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold"> 예산항목목록</td>
											<td align="right" width="*">
												<input id="btnAddChild" type="button" class="img_btn6_1" value="하위레벨추가" title="Alt+F1" onclick="btnAddChild_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												<input id="btnAddSibling" type="button" class="img_btn6_1" value="동일레벨추가" title="Alt+F2" onclick="btnAddSibling_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												<input id="btnDelete" type="button" class="img_btn4_1" value="삭제" title="Alt+D" onclick="btnDelete_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												<input id="btnMoveUp" type="button" class="img_btn4_1" value="위로이동" title="Alt+↑" onclick="btnMoveUp_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												<input id="btnMoveDn" type="button" class="img_btn5_1" value="아래로이동" title="Alt+↓" onclick="btnMoveDn_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT style="width:0px; height:0px; margin:0px; padding:0px;" CLASSID="clsid:5220cb21-c88d-11cf-b347-00aa00a28331">
										<PARAM NAME="LPKPath" VALUE="vsflex8l.lpk">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id="fg" height="100%" width="100%" classid=clsid:0F026C11-5A66-4c2b-87B5-88DDEBAE72A1 VIEWASTEXT style="font-size:12px" codebase="./vsflex8l.cab#Version=8,0,20044,210">
										<PARAM NAME="_cx" VALUE="5080">
										<PARAM NAME="_cy" VALUE="5080">
										<PARAM NAME="Appearance" VALUE="0">
										<PARAM NAME="BorderStyle" VALUE="0">
										<PARAM NAME="Enabled" VALUE="-1">
										<PARAM NAME="Font" VALUE="굴림체">
										<PARAM NAME="MousePointer" VALUE="0">
										<PARAM NAME="BackColor" VALUE="-2147483643">
										<PARAM NAME="ForeColor" VALUE="-2147483640">
										<PARAM NAME="BackColorFixed" VALUE="-2147483633">
										<PARAM NAME="ForeColorFixed" VALUE="-2147483630">
										<PARAM NAME="BackColorSel" VALUE="-2147483635">
										<PARAM NAME="ForeColorSel" VALUE="-2147483634">
										<PARAM NAME="BackColorBkg" VALUE="-2147483636">
										<PARAM NAME="BackColorAlternate" VALUE="-2147483643">
										<PARAM NAME="GridColor" VALUE="-2147483633">
										<PARAM NAME="GridColorFixed" VALUE="-2147483632">
										<PARAM NAME="TreeColor" VALUE="-2147483632">
										<PARAM NAME="FloodColor" VALUE="192">
										<PARAM NAME="SheetBorder" VALUE="-2147483642">
										<PARAM NAME="FocusRect" VALUE="1">
										<PARAM NAME="HighLight" VALUE="1">
										<PARAM NAME="AllowSelection" VALUE="-1">
										<PARAM NAME="AllowBigSelection" VALUE="-1">
										<PARAM NAME="AllowUserResizing" VALUE="0">
										<PARAM NAME="SelectionMode" VALUE="0">
										<PARAM NAME="GridLines" VALUE="1">
										<PARAM NAME="GridLinesFixed" VALUE="2">
										<PARAM NAME="GridLineWidth" VALUE="1">
										<PARAM NAME="Rows" VALUE="50">
										<PARAM NAME="Cols" VALUE="10">
										<PARAM NAME="FixedRows" VALUE="1">
										<PARAM NAME="FixedCols" VALUE="1">
										<PARAM NAME="RowHeightMin" VALUE="0">
										<PARAM NAME="RowHeightMax" VALUE="0">
										<PARAM NAME="ColWidthMin" VALUE="0">
										<PARAM NAME="ColWidthMax" VALUE="0">
										<PARAM NAME="ExtendLastCol" VALUE="0">
										<PARAM NAME="FormatString" VALUE="(Format)&#11;10&#11;960&#9;9&#9;9&#9;&#9;&#9;&#9;0&#9;0&#9;&#9;0&#9;&#11;960&#9;5&#9;9&#9;&#9;&#9;&#9;0&#9;0&#9;&#9;0&#9;&#11;960&#9;9&#9;9&#9;&#9;&#9;&#9;0&#9;0&#9;&#9;0&#9;&#11;960&#9;9&#9;9&#9;&#9;&#9;&#9;0&#9;0&#9;&#9;0&#9;&#11;960&#9;9&#9;9&#9;&#9;&#9;&#9;0&#9;0&#9;&#9;0&#9;&#11;960&#9;9&#9;9&#9;&#9;&#9;&#9;0&#9;0&#9;&#9;0&#9;&#11;960&#9;9&#9;9&#9;&#9;&#9;&#9;0&#9;0&#9;&#9;0&#9;&#11;960&#9;9&#9;9&#9;&#9;&#9;&#9;0&#9;0&#9;&#9;0&#9;&#11;960&#9;9&#9;9&#9;&#9;&#9;&#9;0&#9;0&#9;&#9;0&#9;&#11;960&#9;9&#9;9&#9;&#9;&#9;&#9;0&#9;0&#9;&#9;0&#9;&#11;(Text)&#11;">
										<PARAM NAME="ScrollTrack" VALUE="0">
										<PARAM NAME="ScrollBars" VALUE="3">
										<PARAM NAME="ScrollTips" VALUE="0">
										<PARAM NAME="MergeCells" VALUE="0">
										<PARAM NAME="MergeCompare" VALUE="0">
										<PARAM NAME="AutoResize" VALUE="-1">
										<PARAM NAME="AutoSizeMode" VALUE="0">
										<PARAM NAME="AutoSearch" VALUE="0">
										<PARAM NAME="AutoSearchDelay" VALUE="2">
										<PARAM NAME="MultiTotals" VALUE="-1">
										<PARAM NAME="SubtotalPosition" VALUE="1">
										<PARAM NAME="OutlineBar" VALUE="0">
										<PARAM NAME="OutlineCol" VALUE="0">
										<PARAM NAME="Ellipsis" VALUE="0">
										<PARAM NAME="ExplorerBar" VALUE="0">
										<PARAM NAME="PicturesOver" VALUE="0">
										<PARAM NAME="FillStyle" VALUE="0">
										<PARAM NAME="RightToLeft" VALUE="0">
										<PARAM NAME="PictureType" VALUE="0">
										<PARAM NAME="TabBehavior" VALUE="1">
										<PARAM NAME="OwnerDraw" VALUE="0">
										<PARAM NAME="Editable" VALUE="2">
										<PARAM NAME="ShowComboButton" VALUE="2">
										<PARAM NAME="WordWrap" VALUE="0">
										<PARAM NAME="TextStyle" VALUE="0">
										<PARAM NAME="TextStyleFixed" VALUE="0">
										<PARAM NAME="OleDragMode" VALUE="0">
										<PARAM NAME="OleDropMode" VALUE="0">
										<PARAM NAME="ComboSearch" VALUE="3">
										<PARAM NAME="AutoSizeMouse" VALUE="-1">
										<PARAM NAME="FrozenRows" VALUE="0">
										<PARAM NAME="FrozenCols" VALUE="0">
										<PARAM NAME="AllowUserFreezing" VALUE="0">
										<PARAM NAME="BackColorFrozen" VALUE="0">
										<PARAM NAME="ForeColorFrozen" VALUE="0">
										<PARAM NAME="WallPaperAlignment" VALUE="9">
										<PARAM NAME="AccessibleName" VALUE="">
										<PARAM NAME="AccessibleDescription" VALUE="">
										<PARAM NAME="AccessibleValue" VALUE="">
										<PARAM NAME="AccessibleRole" VALUE="24">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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