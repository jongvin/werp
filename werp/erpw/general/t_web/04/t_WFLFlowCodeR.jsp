<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFLFlowCodeR(현장자금수지분류코드등록)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-02)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
	CITData lrReturnData1 = null;
	CITData lrReturnData2 = null;
	CITData lrReturnData3 = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_WFLFlowCodeR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN,I:dsMAIN_D=dsMAIN_D,I:dsSUB01=dsSUB01)";
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	
	try
	{
		CITCommon.initPage(request, response, session);

		try
		{
			CITData		lrArgData = new CITData();
			strSql = 
				"Select"+"\n"+
				"	a.CODE_LIST_ID CODE,"+"\n"+
				"	a.CODE_LIST_NAME NAME"+"\n"+
				"From	V_T_CODE_LIST a"+"\n"+
				"Where	a.CODE_GROUP_ID = 'FLOW_ITEM_KIND'"+"\n"+
				"Order By"+"\n"+
				"	a.SEQ"+"\n";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
		}
		catch (Exception ex)
		{
			throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
		}
		try
		{
			CITData		lrArgData = new CITData();
			strSql = 
				"Select"+"\n"+
				"	a.DEPT_PLN_FUNC_NO CODE,"+"\n"+
				"	a.FUNC_TITLE NAME"+"\n"+
				"From	T_FL_DEPT_PLN_FUNCTIONS a"+"\n"+
				"Order By"+"\n"+
				"	a.FUNC_TITLE"+"\n";
			lrReturnData1 = CITDatabase.selectQuery(strSql, lrArgData);
		}
		catch (Exception ex)
		{
			throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
		}
		try
		{
			CITData		lrArgData = new CITData();
			strSql = 
				"Select"+"\n"+
				"	a.DEPT_EXE_FUNC_NO CODE,"+"\n"+
				"	a.FUNC_TITLE NAME"+"\n"+
				"From	T_FL_DEPT_EXE_FUNCTIONS a"+"\n"+
				"Order By"+"\n"+
				"	a.FUNC_TITLE"+"\n";
			lrReturnData2 = CITDatabase.selectQuery(strSql, lrArgData);
		}
		catch (Exception ex)
		{
			throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
		}
		try
		{
			CITData		lrArgData = new CITData();
			strSql = 
				"Select"+"\n"+
				"	a.DEPT_FOR_FUNC_NO CODE,"+"\n"+
				"	a.FUNC_TITLE NAME"+"\n"+
				"From	T_FL_DEPT_FORE_FUNCTIONS a"+"\n"+
				"Order By"+"\n"+
				"	a.FUNC_TITLE"+"\n";
			lrReturnData3 = CITDatabase.selectQuery(strSql, lrArgData);
		}
		catch (Exception ex)
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
		<script language="javascript" src="../script/flexgridint.js"></script>
		<script language="javascript" src="../script/ContextMenu.js"></script>
		<script language="javascript" src="<%=strFileName%>.js"></script>
		<script language="javascript">
		<!--
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			var			arTF = null;
			var			arCODE1 = null;
			var			arCODE2 = null;
			var			arCODE3 = null;

			arTF = new Array();
<%
			for(int i = 0 ; i < lrReturnData.getRowsCount(); ++i)
			{
				String		sCode = lrReturnData.toString(i, "CODE");
				String		sName = lrReturnData.toString(i, "NAME");
%>
				arTF.push(new F_CodeName("<%=sCode%>","<%=sName%>"));
<%
			}
%>			

			arCODE1 = new Array();
<%
			for(int i = 0 ; i < lrReturnData1.getRowsCount(); ++i)
			{
				String		sCode = lrReturnData1.toString(i, "CODE");
				String		sName = lrReturnData1.toString(i, "NAME");
%>
				arCODE1.push(new F_CodeName("<%=sCode%>","<%=sName%>"));
<%
			}
%>			
			arCODE2 = new Array();
<%
			for(int i = 0 ; i < lrReturnData2.getRowsCount(); ++i)
			{
				String		sCode = lrReturnData2.toString(i, "CODE");
				String		sName = lrReturnData2.toString(i, "NAME");
%>
				arCODE2.push(new F_CodeName("<%=sCode%>","<%=sName%>"));
<%
			}
%>			
			arCODE3 = new Array();
<%
			for(int i = 0 ; i < lrReturnData3.getRowsCount(); ++i)
			{
				String		sCode = lrReturnData3.toString(i, "CODE");
				String		sName = lrReturnData3.toString(i, "NAME");
%>
				arCODE3.push(new F_CodeName("<%=sCode%>","<%=sName%>"));
<%
			}
%>			
			
			// 이벤트관련-------------------------------------------------------------------//
			
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSUB01 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN_D classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsACC_CODE classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsFLOW_CODE classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsAPPLY_SEQ classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
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
								<td height="50%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20"><img src="../images/bullet1.gif"></td>
														<td class="font_green_bold"> 현장자금수지항목</td>
														<td align="right" width="*">
															<input id="btnAddChild" type="button" class="img_btn4_1" value="하위추가" title="Alt+F1" onclick="btnAddChild_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnAddSibling" type="button" class="img_btn4_1" value="동일추가" title="Alt+F2" onclick="btnAddSibling_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnDeleteNode" type="button" class="img_btn4_1" value="삭제" title="Alt+D" onclick="btnDeleteNode_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
												<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT style="width:0px; height:0px; margin:0px; padding:0px;" CLASSID="clsid:5220cb21-c88d-11cf-b347-00aa00a28331">
													<PARAM NAME="LPKPath" VALUE="vsflex8l.lpk">
												</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
												<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id="fg" height="100%" width="100%" classid=clsid:0F026C11-5A66-4c2b-87B5-88DDEBAE72A1 VIEWASTEXT style="font-size:12px" codebase="./vsflex8l.cab#Version=8,0,20044,210">
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
												</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__10); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
														<td class="font_green_bold">실적집계 기준 계정정의</td>
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
												<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__12"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridSUB01 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsSUB01">
													<PARAM NAME="Editable" VALUE="-1">
													<PARAM NAME="ColSelect" VALUE="-1">
													<PARAM NAME="ColSizing" VALUE="-1">
													<PARAM NAME="Format" VALUE=" 
														<FC> Name=계정코드 ID=ACC_CODE Align=Center Width=90
														</FC> 
														<FC> Name=계정명 ID=ACC_NAME Align=Left Width=200 
														</FC> 
														<FC> Name=집계방법 ID=SUM_MTHD_TAG EditStyle=Combo Data='1:현금추적,2:계정집계,3:상계추적' Align=Center Width=80
														</FC> 
														<C> Name=상계계정코드 ID=SETOFF_ACC_CODE Align=Center Width=90
														</C> 
														<C> Name=상계계정명 ID=SETOFF_ACC_NAME Align=Left Width=200 
														</C> 
														<C> Name=집계구분 ID=SLIP_SUM_MTHD_TAG EditStyle=Combo Data='1:차변합,2:대변합,3:차변-대변,4:대변-차변' Align=Center Width=90
														</C> 
														<C> Name=부호구분 ID=SIGN_TAG EditStyle=Combo Data='P:+,N:-' Align=Center Width=60
														</C>
														<C> Name=비고 ID=REMARKS Align=Left Width=200
														</C> 
														">
												</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__12); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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