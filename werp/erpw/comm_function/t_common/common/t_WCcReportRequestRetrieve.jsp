<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 보고서출력
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 강덕율 작성(2005-10-31)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 :
/**************************************************************************/

	CITData lrReturnData = null;
	String strOut = "";
	String strSql = "";

	String strReportResponseUrl = "http://52.10.123.200/WIIS_REPORT/Reports_Temp";
	String strState = "";

	try
	{
		CITCommon.initPage(request, response, session);

		//strReportResponseUrl = CITCommon.getProperty("report.response.url", "");

		CITData lrArgData = new CITData();

		try
		{
			strSql  = " Select '%' as CODE, ";
			strSql += "        '전체' as NAME ";
			strSql += " From   Dual ";
			strSql += " Union All ";
			strSql += " Select CODE_LIST_ID as CODE, ";
			strSql += "        CODE_LIST_NAME as NAME ";
			strSql += " From   V_T_CODE_LIST ";
			strSql += " Where  CODE_GROUP_ID = 'REPORT_REQUEST_STATE' ";
			strSql += " And    USE_TAG = 'T' ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strState = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 지급처 Select 오류 -> " + ex.getMessage());
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
		<script language="javascript">
		<!--
			var strReportResponseUrl = "<%=strReportResponseUrl%>";

			function Initialize()
			{
				G_addDataSet(dsRequest, trans, gridRequest, "", "보고서요청내역");
				gridRequest.focus();
				G_Load(dsRequest, null);
			}

			// 함수관련---------------------------------------------------------------------//

			// 공통 재정의 이벤트관련-------------------------------------------------------//
			function OnLoadBefore(dataset)
			{
				if (dataset == dsRequest)
				{
					dataset.DataID = "t_WCcReportRequestRetrieve_q.jsp?ACT=REQUEST_LIST&REQUEST_NAME=" + txtRequestName.value + "&STATE=" + cboState.value;
				}
			}

			function OnLoadCompleted(dataset, rowcnt)
			{
			}

			function OnRowInserted(dataset, row)
			{
			}

			function OnRowDeleted(dataset, row)
			{
			}

			function OnColumnChanged(dataset, row, colid)
			{
			}

			function OnPopup(dataset, grid, row, colid, data)
			{
			}

			// 이벤트관련-------------------------------------------------------------------//
			function btnReportView_onClick()
			{
				if (dsRequest.RowPosition < 1)
				{
					C_msgOk("요청내역을 선택하십시요.");
					return;
				}

				if (dsRequest.NameString(dsRequest.RowPosition, "STATE") != "C")
				{
					C_msgOk("요청이 완료되지 않았습니다.");
					return;
				}

				window.open(strReportResponseUrl + "/" + dsRequest.NameString(dsRequest.RowPosition, "REQUEST_FILE_NAME"));
			}

			// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
			// 조회
			function btnquery_onclick()
			{
				D_defaultLoad();
				
			}
			
			
			// 저장
			function btnsave_onclick()
			{
				D_defaultSave();
			}
			
			// 취소
			function btncancel_onclick()
			{
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			function btnLoad_onClick()
			{
				G_Load(dsRequest, null);
			}

			function btnDel_onClick()
			{
				G_deleteRow(dsRequest);
			}

			function btnDelAll_onClick()
			{
				G_deleteAllRow(dsRequest);
			}

			function btnSave_onClick()
			{
				G_saveDataMsg(dsRequest);
			}

		//-->
		</script>

		<object id=dsRequest classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object>
		<object id=trans classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F>
	      <param name="KeyValue" value="Service1(I:dsRequest=dsRequest)">
		  <param name="Action" value="./t_WCcReportRequestRetrieve_tr.jsp">
		</object>
	</head>
	<body onload="C_Initialize()">
		<!-- 표준 페이지의 고정 DIV 시작 : 크기(폭:100%px, 높이:530px) //-->
		<div id="divMainFix"  class="main_div">
		<table width="100%" HEIGHT="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="100%">
					<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
					<!-- 조건 테이블 시작 //-->
					<table width="100%" HEIGHT="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr class="head_line">
										<td width="*" height="1"></td>
									</tr>
									<tr>
										<td class="td_green">
											<!-- 프로그래머 디자인 시작 //-->
											<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="15"><img src="../images/bullet3.gif"></td>
													<td width="50" class="font_green_bold">요청명</td>
													<td width="250"><input id="txtRequestName" type="text" style="width:200px"></td>
													<td width="15"><img src="../images/bullet3.gif"></td>
													<td width="65" class="font_green_bold">요청구분</td>
													<td width="*"><select id="cboState" style="width: 80px"><%=strState%></select></td>
												</tr>
											</table>
											<!-- 프로그래머 디자인 종료 //-->
										</td>
									</tr>
									<tr class="head_line">
										<td width="*" height="1"></td>
									</tr>
								</table>
								<!-- 조건 테이블 종료 //-->
							</td>
						</tr>
						<tr>
							<td>
								<!-- 간격조정 테이블 시작 //-->
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="10"></td>
									</tr>
								</table>
								<!-- 간격조정 테이블 종료 //-->
							</td>
						</tr>
						<tr>
							<td>
								<!-- 서브 테이블 시작 //-->
								<!-- 서브 타이틀 시작 //-->
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<!-- 프로그래머 수정 시작 //-->
										<td width="15" height="20"><img src="../images/bullet1.gif" width="9" height="9"></td>
										<td class="font_green_bold"> 요청내역</td>
										<td align="right">
											<input id="btnReportView" type="button" class="img_btn6_1" value="보고서보기" onclick="btnReportView_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											<input id="btnDel" type="button" class="img_btn2_1" value="삭제" onclick="btnDel_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											<input id="btnDelAll" type="button" class="img_btn4_1" value="전체삭제" onclick="btnDelAll_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
										</td>
										<!-- 프로그래머 수정 종료 //-->
									</tr>
								</table>
								<!-- 서브 타이틀 종료 //-->
								<!-- 서브 본문 시작 //-->
							</td>
						</tr>
						<tr>
							<td HEIGHT="100%">
								<table width="100%" HEIGHT="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="100%" HEIGHT="100%">
											<table width="100%" HEIGHT="100%" border="0" cellspacing="0" cellpadding="0">
												<tr class="head_line">
													<td width="*" height="3"></td>
												</tr>
												<tr>
													<td bgcolor="#FFFFFF" HEIGHT="100%">
														<!-- 프로그래머 디자인 시작 //-->
														<table width="100%" HEIGHT="100%" border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td HEIGHT="100%">
																	<OBJECT id=gridRequest WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49>
																		<PARAM NAME="Editable" VALUE="false">
																		<PARAM NAME="ColSelect" VALUE="-1">
																		<PARAM NAME="ColSizing" VALUE="-1">
																		<PARAM NAME="Format" VALUE="
																			<C> Name=요청명 ID=REQUEST_NAME Width=150 Sort=true
																			</C>
																			<C> Name=보고서명 ID=REPORT_NAME Width=150 Sort=true
																			</C>
																			<C> Name=상태 ID=STATE_NAME Width=50 Sort=true
																			</C>
																			<C> Name=요청일자 ID=REQUEST_DATE Width=125 Sort=true
																			</C>
																			<C> Name=완료일자 ID=COMPLETE_DATE Width=125 Sort=true
																			</C>
																			<C> Name=삭제예정일자 ID=DELETE_EXPECT_DATE Width=80
																			</C>
																			<C> Name=비고 ID=REMARK Width=200
																			</C>
																			">
																		<PARAM NAME="DataID" VALUE="dsRequest">
																	</OBJECT>
																</td>
															</tr>
														</table>
														<!-- 프로그래머 디자인 종료 //-->
													</td>
												</tr>
												<tr class="head_line">
													<td width="*" height="3"></td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
								<!-- 서브 본문 종료 //-->
								<!-- 서브 테이블 종료 //-->
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		</div>
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
