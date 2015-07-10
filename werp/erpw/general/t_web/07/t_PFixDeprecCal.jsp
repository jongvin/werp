<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_PFixDeprecCal";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";
	CITData lrArgData = null;
	String strOut = "";
	String strSql = "";
	String strDEPREC_CLS = "";
	String strDEPREC_FINISH = "";
    try
    {
    	CITCommon.initPage(request, response, session);

    		
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
			strDEPREC_FINISH = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME"); // 가우스 그리드 Combo인 경우 사용
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 구매구분 Select 오류 -> " + ex.getMessage());
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
			strDEPREC_CLS = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME"); // 가우스 그리드 Combo인 경우 사용
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 구매구분 Select 오류 -> " + ex.getMessage());
		}
	}
	catch (Exception ex)
	{
		throw new Exception("페이지 초기화 오류 -> " + ex.getMessage());
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>기등록업체찾기</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript" src="../script/DefaultActions.js"></script>
		<script language="javascript" src="<%=strFileName%>.js"></script>
		<script language="javascript">
		<!--
			var lrArgs;
			var flag = false;
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			
		//-->
		</script>
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id="dsDEPREC_FINISH"  classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		  <PARAM NAME="SyncLoad" VALUE="-1">
		</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
	</head>
	<body onload="C_Initialize();">
		<TABLE id="tableMain" cellSpacing="0" cellPadding="0" width="792" height="374" border="0">
			<TR >
				<TD align="center">
					<!-- 표준 팝업 페이지의 최소 DIV 크기(폭:250px 이상, 높이:400px 고정) //-->
					<DIV id="divPopMain" style="WIDTH: 100%; HEIGHT: 100%;">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="left" background="../images/pop_tit_bg.gif">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="23"><img src="../images/pop_tit_normal2.gif"></td>
											<td class="title_default">감가상각 대상찾기</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr >
								<td height="100%" width="100%" bgcolor="#CCCCCC">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr  bgcolor="ECECEC">
											<td align="center" bgcolor="ECECEC">
												<!-- 검색어 시작 //-->
	 											<table width="100%" border="0" cellspacing="0" cellpadding="0">
	 												<tr>
	 													<td width="15"><img src="../images/bullet1.gif"></td>
	 													<td width="75" class=font_green_bold >고정자산명</td>
	 													<td width="150"> <input id="txtASSET_NAME" type="text" Left class="box_ma5_white" VALUE="" style="width:148px"></td>
	 													<td align="left">
	 														<input id="btnLoad" type="button" class="img_btn2_1" value="조회" onclick="btnLoad_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
	 														<input id="btnSelectAll" type="button" class="img_btn4_1" value="전체선택" onclick="btnSelectAll_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
	 														<input id="btnCancelAll" type="button" class="img_btn4_1" value="선택취소" onclick="btnCancelAll_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
	 													</td>
														<td>&nbsp;</td>
	 												</tr>
	 											</table>
												<!-- 검색어 종료 //-->
											</td>
										</tr>
										<tr  height="100%">
											<td width="100%" height="100%" align="center" bgcolor="ECECEC">
												<!-- 프로그래머 디자인 시작 //-->
												<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN style="HEIGHT: 100% ; WIDTH: 100%"  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT codebase="../../../cabfiles/toinbgrid.cab#version=1,1,0,125">
													  <PARAM NAME="Editable" VALUE="-1">
													  <PARAM NAME="ColSelect" VALUE="-1">
													  <PARAM NAME="ColSizing" VALUE="-1">
													  <param name="MultiRowSelect"   value=true>
													  <param name="UsingOneClick"   value="1">
													  <PARAM NAME="Format" VALUE="
															<C> Name=선택 ID=CHKTAG	 EditStyle=CheckBox 	Width=50
															</C>
															<C> Name=취득순번 ID=FIX_ASSET_SEQ Align=CENTER Width=120 Show='false'
															</C>
															<C> Name=상각완료여부 ID=DEPREC_FINISH Align=CENTER Width=80 edit=none	EditStyle='Combo' Data='<%=strDEPREC_FINISH%>'
															</C>
															<C> Name=자산관리번호 ID=ASSET_MNG_NO Align=Center Width=80 edit=none
															</C>
															<C> Name=고정자산명 ID=ASSET_NAME Align=left Width=150 edit=none
															</C>
															<C> Name=취득일자 ID=GET_DT Align=Center Width=80 edit=none Mask='XXXX-XX-XX'
															</C>
															<C> Name=상각구분 ID=DEPREC_CLS Align=Center Width=60 edit=none		EditStyle='Combo' Data='<%=strDEPREC_CLS%>'
															</C>
															<C> Name=상각년수 ID=SRVLIFE Align=Right Width=60 edit=none
															</C>
															<C> Name=수량 ID=ASSET_CNT Align=Right Width=60 edit=none
															</C>
															<C> Name=상각율 ID=DEPREC_RAT Align=Right Width=80 edit=none
															</C>
															<C> Name=장부가액 ID=BASE_AMT Align=Right Width=100 edit=none
															</C>
															<C> Name=기상각액 ID=OLD_DEPREC_AMT Align=Right Width=100 edit=none
															</C>
															<C> Name=취득원가 ID=GET_COST_AMT Align=Right Width=100 edit=none
															</C>
															<C> Name=증액누계 ID=INC_SUM_AMT Align=Right Width=100 edit=none
															</C>
															<C> Name=감액누계 ID=SUB_SUM_AMT Align=Right Width=100 edit=none
															</C>
															<C> Name=신/구자산 ID=NEW_OLD_ASSET Align=left Width=120 edit=none  Show='false'
															</C>
															<C> Name=변경취득금액 ID=CHG_GET_AMT Align=left Width=120 edit=none  Show='false'
															</C>
															<C> Name=배치부서 ID=DEPT_CODE Align=left Width=120 edit=none Show='false'
															</C>
															<C> Name=배치부서 ID=DEPT_NAME Align=left Width=120 edit=none
															</C>
															<C> Name=규격 ID=ASSET_SIZE Align=left Width=100 edit=none  Show='false'
															</C>
															<C> Name=작업순번 ID=WORK_SEQ Align=left Width=120 edit=none  Show='false'
															</C>
															<C> Name=매각/폐기일자 ID=SALE_DT Align=left Width=120 edit=none  Show='false'
															</C> 	
															<C> Name=처분년수 ID=DISPOSE_YEAR Align=Center Width=120 edit=none  Show='false'
															</C>
														">
												  	<PARAM NAME="DataID" VALUE="dsMAIN">
												</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
												<!-- 프로그래머 디자인 종료 //-->
											</td>
										</tr>
										<tr>
											<td height="5" bgcolor="ECECEC"></td>
										</tr>
										<tr>
											<td align="right" bgcolor="ECECEC">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<TR align="right">
														<TD>
															<input id="btnImgOk" type="button" class="img_btn4_1" value="확인" onclick="imgOk_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnImgCancel" type="button" class="img_btn4_1" value="취소" onclick="imgCancel_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</TD>
													</TR>
												</TABLE>
											</td>
										</tr>
										<tr>
											<td height="8" bgcolor="ECECEC"></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</DIV>
				</TD>
			</TR>
		</TABLE>
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
