<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_PLovFilterRelR(공통팝업의 필터관계등록)
/* 2. 유형(시나리오) : 공통팝업의 필터관계 조회 및 입력
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/

	CITData lrReturnData = null;
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	
	String strLovNo = "";
	String strFilters = "";
	
	try
	{
		CITCommon.initPage(request, response, session);
		
		strLovNo = CITCommon.toKOR(request.getParameter("LOV_NO"));
		
		CITData lrArgData = new CITData();
		
		try
		{
			strSql  = " Select FILTER_SEQ, ";
			strSql += "        FILTER_NAME ";			
			strSql += " From   T_LOV_FILTERS ";
			strSql += " Where  LOV_NO = ? ";
			strSql += "  And   TYPE = 'C' ";
			strSql += " Order by DIS_SEQ ";
			
			lrArgData.addColumn("LOV_NO", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("LOV_NO", strLovNo);
			
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			
			strFilters = CITCommon.toGauceComboString(lrReturnData, "FILTER_SEQ", "FILTER_NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:필터 Select 오류 -> " + ex.getMessage());
		}
	}
	catch (Exception ex)
	{
		throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>회계관리</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript">
		<!--
			var strLovNo = "<%=strLovNo%>";
			
			function Initialize()
			{
				G_addDataSet(dsFilterRels, trans, gridFilterRels, null, "필터관계");
				G_addDataSet(dsFilterRelSeq, null, null, "t_PLovFilterRelR_q.jsp?ACT=FILTER_REL_SEQ", "필터관계번호");
				
				G_Load(dsFilterRels, null);
				gridFilterRels.focus();
			}
			
			// 세션관련 함수----------------------------------------------------------------//
			function SetSession()
			{
			}
			
			function GetSession()
			{
			}
			
			function ReportSession(asName, asValue)
			{
			}
			
			// 함수관련---------------------------------------------------------------------//
			
			// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
			// 조회
			function btnquery_onclick()
			{
				if (G_FocusDataset == dsFilterRels)
				{
					G_Load(dsFilterRels, null);
				}
				
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// 추가
			function btnadd_onclick()
			{
				if (G_FocusDataset == dsFilterRels)
				{
					G_addRow(dsFilterRels);
				}
				
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// 삽입
			function btninsert_onclick()
			{
				if (G_FocusDataset == dsFilterRels)
				{
					G_insertRow(dsFilterRels);
				}
				
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// 삭제
			function btndelete_onclick()
			{
				if (G_FocusDataset == dsFilterRels)
				{
					G_deleteRow(dsFilterRels);
				}
				
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// 저장
			function btnsave_onclick()
			{
				if (G_FocusDataset == dsFilterRels)
				{
					G_saveDataMsg(dsFilterRels);
				}
				
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// 공통 재정의 이벤트관련-------------------------------------------------------//
			function OnLoadBefore(dataset)
			{
				if (dataset == dsFilterRels)
				{
					dataset.DataID = "t_PLovFilterRelR_q.jsp?ACT=FILTER_RELS";
					dataset.DataID += "&LOV_NO=" + strLovNo;
				}
			}
			
			function OnRowInserted(dataset, row)
			{
				if (dataset == dsFilterRels)
				{
					G_Load(dsFilterRelSeq, null);
					
					dsFilterRels.NameValue(row, "LOV_NO") = strLovNo;
					dsFilterRels.NameValue(row, "FILTER_REL_SEQ") = dsFilterRelSeq.NameString(dsFilterRelSeq.RowPosition, "FILTER_REL_SEQ");
					dsFilterRels.NameValue(row, "DIS_SEQ") = dsFilterRels.NameMax("DIS_SEQ", 0, 0) + 1;
				}
			}
			
			function OnColumnChanged(dataset, row, colid)
			{
				
			}
			
			// 이벤트관련-------------------------------------------------------------------//
			function document_onKeyDown()
			{
				if (event.keyCode == 27)
				{
					imgCancle_onClick();
				}
			}
			
			function imgCancle_onClick()
			{
				if (dsFilterRels.IsUpdated || G_isChanged(dsFilterRels.id))
				{
					var ret = C_msgYesNo("변경된 내용을 저장 하시겠습니까?", "저장");
			
					if (ret == "Y")
					{
						if (!G_saveAllData(dsFilterRels)) return;
					}
				}
				
				window.returnValue = null;
				window.close();
			}
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsFilterRels classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsFilterRelSeq classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=trans  classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F>
			<param name="KeyValue" value="Service1(I:dsFilterRels=dsFilterRels)">
			<param name="Action" value="./t_PLovFilterRelR_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!-- 가우스 Dataset 및 Tranaction 객체정의 종료 //-->
	</head>
	<body onload="C_Initialize()"">
		<DIV id="divPopMain" style="WIDTH: 100%; HEIGHT: 100%;">
			<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
				<tr> 
					<td align="left" background="../images/pop_tit_bg.gif">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="52"><img src="../images/pop_tit_normal1.gif"></td>
								<td class="title_default">공통팝업 필터관계등록</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr> 
					<td height="100%" width="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr valign="bottom">
								<td width="100%" height="26">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold">필터관계</td>
											<td align="right">
												<input id="btnRETRIEVE" type="button" class="img_btn2_1" value="조회" onclick="btnquery_onclick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												<input id="btnADD" type="button" class="img_btn2_1" value="추가" onclick="btnadd_onclick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												<input id="btnINSERT" type="button" class="img_btn2_1" value="삽입" onclick="btninsert_onclick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												<input id="btnDELETE" type="button" class="img_btn2_1" value="삭제" onclick="btndelete_onclick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												<input id="btnSAVE" type="button" class="img_btn2_1" value="저장" onclick="btnsave_onclick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridFilterRels WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsFilterRels">
										<PARAM NAME="Editable" VALUE="true">
										<PARAM NAME="ColSelect" VALUE="true">
										<PARAM NAME="ColSizing" VALUE="true">
										<PARAM NAME="Format" VALUE=" 
											<C> Name=순번 ID=DIS_SEQ Width=40 Align=Center
											</C> 
											<C> Name=부모필터 ID=M_FILTER_SEQ Width=120 EditStyle=Combo Data='<%=strFilters%>'
											</C>
											<C> Name=자식필터 ID=D_FILTER_SEQ Width=120 EditStyle=Combo Data='<%=strFilters%>'
											</C>
											">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
								</td>
							</tr>
							<tr>
								<td width="100%" height="30" bgcolor="#ECECEC">
									<table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0">
										<tr>
											<TD width="100%" align="right">
												<input id="imgCancle" type="button" class="img_btnClose" value="닫기" onclick="imgCancle_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">&nbsp;
											</TD>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</DIV>
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