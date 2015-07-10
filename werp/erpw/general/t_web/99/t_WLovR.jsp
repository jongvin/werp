<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WLovR(공통팝업 등록)
/* 2. 유형(시나리오) : 공통팝업의 조회 및 입력
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 강덕율 작성(2005-10-31)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 :
/**************************************************************************/

	CITData lrReturnData = null;
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	
	try
	{
		CITCommon.initPage(request, response, session);
	}
	catch (Exception ex)
	{
		throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>회계관리 - 공통팝업</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript">
		<!--
			function Initialize()
			{
				G_addDataSet(dsLov, trans, gridLov, null, "공통팝업");
				G_addDataSet(dsLovArgs, trans, gridArgs, null, "입력인자");
				G_addDataSet(dsLovCols, trans, gridCols, null, "컬럼");
				G_addDataSet(dsLovNo, null, null, "t_WLovR_q.jsp?ACT=LOV_NO", "LOV번호");
				G_addDataSet(dsLovArgsSeq, null, null, "t_WLovR_q.jsp?ACT=LOV_ARGS_SEQ", "인자번호");
				G_addDataSet(dsNEW_NAME,null,null,"t_WLovR_q.jsp?ACT=NEW_NAME","새이름");

				G_addDataSet(dsCOPY_LOV, transCopy, null, null, "복사생성");
				

				G_addRel(dsLov, dsLovArgs);
				G_addRelCol(dsLovArgs, "LOV_NO", "LOV_NO");
				
				G_addRel(dsLov, dsLovCols);
				G_addRelCol(dsLovCols, "LOV_NO", "LOV_NO");
				
				//G_Load(dsLov, null);
				gridLov.focus();
				
				G_setReadOnlyCol(gridCols, "DIS_SEQ");
				//G_setReadOnlyCol(gridCols, "NAME");
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
			function checkLOV()
			{
				if (dsLov.RowPosition < 1)
				{
					C_msgOk("공통팝업을 선택하십시요.");
					return false;
				}
				
				return true;
			}
			
			function checkSave()
			{
				if (dsLov.IsUpdated || G_isChanged(dsLov.id))
				{
					var ret = C_msgYesNo("변경된 내용을 반드시 저장하셔야 합니다.<br><br>" + G_MSG_SAVE, "저장");
			
					if (ret == "Y")
					{
						G_saveAllData(dsLov);
					}
					else
					{
						return false;
					}
				}
				
				return true;
			}
			
			// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
			// 조회
			function btnquery_onclick()
			{
				if (G_FocusDataset == dsLov)
				{
					G_Load(dsLov, null);
				}
				else if (G_FocusDataset == dsLovArgs)
				{
					if (checkLOV()) G_Load(dsLovArgs, null);
				}
				else if (G_FocusDataset == dsLovCols)
				{
					if (checkLOV()) G_Load(dsLovCols, null);
				}
				
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// 추가
			function btnadd_onclick()
			{
				if (G_FocusDataset == dsLov)
				{
					G_addRow(dsLov);
				}
				else if (G_FocusDataset == dsLovArgs)
				{
					if (checkLOV()) G_addRow(dsLovArgs);
				}
				else if (G_FocusDataset == dsLovCols)
				{
					C_msgOk("추가 또는 삽입할 수 없습니다.");
					return;
				}
				
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// 삽입
			function btninsert_onclick()
			{
				if (G_FocusDataset == dsLov)
				{
					G_insertRow(dsLov);
				}
				else if (G_FocusDataset == dsLovArgs)
				{
					if (checkLOV()) G_insertRow(dsLovArgs);
				}
				else if (G_FocusDataset == dsLovCols)
				{
					C_msgOk("추가 또는 삽입할 수 없습니다.");
					return;
				}
				
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// 삭제
			function btndelete_onclick()
			{
				if (G_FocusDataset == dsLov)
				{
					if (dsLov.CountRow < 1) return;
				
					var ret = C_msgYesNo("삭제하시겠습니까?", "선택");
					
					if (ret == "Y")
					{
						dsLovArgs.ClearData();
						dsLovCols.ClearData();
						G_deleteRow(dsLov);
					}
				}
				else if (G_FocusDataset == dsLovArgs)
				{
					if (checkLOV()) G_deleteRow(dsLovArgs);
				}
				else if (G_FocusDataset == dsLovCols)
				{
					C_msgOk("삭제할 수 없습니다.");
					return;
				}
				
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// 저장
			function btnsave_onclick()
			{
				if (G_FocusDataset == dsLov)
				{
					G_saveDataMsg(dsLov);
				}
				else if (G_FocusDataset == dsLovArgs)
				{
					if (checkLOV()) G_saveDataMsg(dsLovArgs);
				}
				else if (G_FocusDataset == dsLovCols)
				{
					if (checkLOV()) G_saveDataMsg(dsLovCols);
				}
				
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// 취소
			function btncancel_onclick()
			{
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// 공통 재정의 이벤트관련-------------------------------------------------------//
			function OnLoadBefore(dataset)
			{
				if (dataset == dsLov)
				{
					dataset.DataID = "t_WLovR_q.jsp?ACT=MAIN&NAME=" + txtSLovName.value + "&TITLE=" + txtSTitle.value;
				}
				else if (dataset == dsLovArgs)
				{
					dataset.DataID = "t_WLovR_q.jsp?ACT=ARGS&LOV_NO=" + dsLov.NameString(dsLov.RowPosition, "LOV_NO");
				}
				else if (dataset == dsLovCols)
				{
					dataset.DataID = "t_WLovR_q.jsp?ACT=COLS&LOV_NO=" + dsLov.NameString(dsLov.RowPosition, "LOV_NO");
				}
				else if (dataset == dsNEW_NAME)
				{
					dataset.DataID = "t_WLovR_q.jsp?ACT=NEW_NAME&LOV_NO=" + dsLov.NameString(dsLov.RowPosition, "LOV_NO");
				}
				else if (dataset == dsCOPY_LOV)
				{
					dataset.DataID = "t_WLovR_q.jsp?ACT=COPY_LOV";
				}
			}
			
			function OnRowInserted(dataset, row)
			{
				if (dataset == dsLov)
				{
					G_Load(dsLovNo, null);
					dsLov.NameValue(row, "LOV_NO") = dsLovNo.NameString(dsLovNo.RowPosition,"LOV_NO");
					dsLov.NameValue(row, "WIDTH") = 400;
					dsLov.NameValue(row, "HEIGHT") = 350;
					dsLov.NameValue(row, "LOCATION_X") = 0;
					dsLov.NameValue(row, "LOCATION_Y") = 0;
					dsLov.NameValue(row, "AUTO_LOAD") = "F";
				}
				else if (dataset == dsLovArgs)
				{
					G_Load(dsLovArgsSeq, null);
					dsLovArgs.NameValue(row, "ARG_SEQ") = dsLovArgsSeq.NameString(dsLovArgsSeq.RowPosition,"ARG_SEQ");
					dsLovArgs.NameValue(row, "DIS_SEQ") = dsLovArgs.NameMax("DIS_SEQ", 0, 0) + 1;
					dsLovArgs.NameValue(row, "TYPE") = "S";
					dsLovArgs.NameValue(row, "SESSION_TAG") = "F";
				}
				else if (dataset == dsLovCols)
				{
				}
			}
			
			function OnColumnChanged(dataset, row, colid)
			{
			}
			
			// 이벤트관련-------------------------------------------------------------------//
			function btnPreView_onClick()
			{
				if (!checkLOV()) return;
				if (!checkSave()) return;
				
				var lrArgs = new C_Dictionary();
				
				for (var i = 1; i <= dsLovArgs.CountRow; i++)
				{
					lrArgs.set(dsLovArgs.NameString(i, "NAME"), dsLovArgs.NameString(i, "DEFAULT_VALUE"));
				}
				
				C_LOV(dsLov.NameString(dsLov.RowPosition, "NAME"), lrArgs);
			}
			
			function btnExeSql_onClick()
			{
				if (!checkLOV()) return;
				if (!checkSave()) return;
				
				dsLovCols.DataID = "t_WLovR_q.jsp?ACT=SQL&LOV_NO=" + dsLov.NameString(dsLov.RowPosition, "LOV_NO");
				dsLovCols.reset();
			}
			
			function btnFilter_onClick()
			{
				if (!checkLOV()) return;
				if (!checkSave()) return;
				
				var lsURL = "./t_PLovFilterR.jsp?LOV_NO=" + dsLov.NameString(dsLov.RowPosition, "LOV_NO") + "&" + C_ProgAuthority;
				var lsRtn = window.showModalDialog(lsURL, null, "center:yes; dialogWidth:840px; dialogHeight:500px; status:yes; help:no; scroll:no");
			}
			
			function btnFilterRel_onClick()
			{
				if (!checkLOV()) return;
				if (!checkSave()) return;
				
				var lsURL = "./t_PLovFilterRelR.jsp?LOV_NO=" + dsLov.NameString(dsLov.RowPosition, "LOV_NO") + "&" + C_ProgAuthority;
				var lsRtn = window.showModalDialog(lsURL, null, "center:yes; dialogWidth:400px; dialogHeight:300px; status:yes; help:no; scroll:no");
			}
			
			function	btnCopyLov_onClick()
			{
				if (!checkLOV()) return;
				if (!checkSave()) return;
				var			liRow = dsLov.RowPosition;
				G_Load(dsNEW_NAME);
				var			lsNewName = dsNEW_NAME.NameString(dsNEW_NAME.RowPosition,"NEW_NAME");
				var			lstrOldLovNo = dsLov.NameString(liRow,"LOV_NO");
				G_addRow(dsLov);
				var			liNewRow = dsLov.RowPosition;
				var			lstrNewLovNo = dsLov.NameString(liNewRow,"LOV_NO");
				dsLov.NameString(liNewRow,"TITLE") = dsLov.NameString(liRow,"TITLE");
				dsLov.NameString(liNewRow,"WIDTH") = dsLov.NameString(liRow,"WIDTH");
				dsLov.NameString(liNewRow,"HEIGHT") = dsLov.NameString(liRow,"HEIGHT");
				dsLov.NameString(liNewRow,"LOCATION_X") = dsLov.NameString(liRow,"LOCATION_X");
				dsLov.NameString(liNewRow,"LOCATION_Y") = dsLov.NameString(liRow,"LOCATION_Y");
				dsLov.NameString(liNewRow,"SQL") = dsLov.NameString(liRow,"SQL");
				dsLov.NameString(liNewRow,"AUTO_LOAD") = dsLov.NameString(liRow,"AUTO_LOAD");
				dsLov.NameString(liNewRow,"REMARK") = dsLov.NameString(liRow,"REMARK");
				dsLov.NameString(liNewRow,"NAME") = lsNewName;
				if(!G_saveAllData(dsLov)) return;
				G_Load(dsCOPY_LOV);
				dsCOPY_LOV.NameString(dsCOPY_LOV.RowPosition,"F") = lstrOldLovNo;
				dsCOPY_LOV.NameString(dsCOPY_LOV.RowPosition,"T") = lstrNewLovNo;
				G_saveData(dsCOPY_LOV);
				G_Load(dsLovArgs);
				G_Load(dsLovCols);
			}
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLov classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLovArgs classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLovCols classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLovNo classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLovArgsSeq classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsNEW_NAME classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsCOPY_LOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=trans  classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F>
	      <param name="KeyValue" value="Service1(I:dsLov=dsLov, I:dsLovArgs=dsLovArgs, I:dsLovCols=dsLovCols)">
		  <param name="Action" value="./t_WLovR_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=transCopy  classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F>
	      <param name="KeyValue" value="Service1(I:dsCOPY_LOV=dsCOPY_LOV)">
		  <param name="Action" value="./t_WLovR_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
											<td width="45" class="font_green_bold" >팝업명</td>
											<td width="170"><input id="txtSLovName" type="text" style="width:150px"></td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="45" class="font_green_bold" >타이틀</td>
											<td width="*"><input id="txtSTitle" type="text" style="width:150px"></td>
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
								<td class="font_green_bold">공통팝업</td>
								<td align="right">
									<input id="btnPreView" type="button" class="img_btn4_1" value="미리보기" onclick="btnPreView_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
									<input id="btnExeSql" type="button" class="img_btn4_1" value="SQL실행" onclick="btnExeSql_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">&nbsp;&nbsp;
									<input id="btnFilter" type="button" class="img_btn4_1" value="필터등록" onclick="btnFilter_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
									<input id="btnFilterRel" type="button" class="img_btn4_1" value="필터관계" onclick="btnFilterRel_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
									<input id="btnCopyLov" type="button" class="img_btn4_1" value="복사생성" onclick="btnCopyLov_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
								</td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="head_line">
								<td width="*" height="3"></td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="*" height="100%">
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridLov WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsLov">
										<PARAM NAME="Editable" VALUE="false">
										<PARAM NAME="ColSelect" VALUE="false">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="Format" VALUE=" 
											<FC> Name=팝업명 ID=NAME Width=170 Sort=true
											</FC> 
											<C> Name=타이틀 ID=TITLE Width=210 Sort=true
											</C> 
											">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__10); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
									&nbsp;
								</td>
								<td width="10">&nbsp;</td>
								<td width="560" height="100%" onActivate="G_focusDataset(dsLov)" onContextMenu="return false">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="40">팝업명</td>
											<td width="250"><input id="txtName" type="text" notnull style="width:200px"></td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="40">타이틀</td>
											<td width="*"><input id="txtTitle" type="text" notnull style="width:200px"></td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="40">폭</td>
											<td width="85"><input id="txtWidth" type="text" datatype="N" style="width:60px" right maxlength="6" lowbound="100"></td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="40">높이</td>
											<td width="110"><input id="txtHeight" type="text" datatype="N" style="width:60px" right maxlength="4" lowbound="100"></td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="40">X위치</td>
											<td width="85"><input id="txtX" type="text" datatype="N" style="width:60px" right maxlength="4"></td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="40">Y위치</td>
											<td width="*"><input id="txtY" type="text" datatype="N" style="width:60px" right maxlength="4"></td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="40">SQL</td>
											<td width="*"><textarea id="txtSql" style="width:505; height:216" wrap="off"></textarea></td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="40">비고</td>
											<td width="390"><input id="txtRemark" type="text" style="width:365px"></td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="55">자동읽기</td>
											<td width="*">
												<input id="chkTest" type="checkbox" class="check" onfocus="this.blur()" onclick="javascript:dsLov.NameValue(dsLov.RowPosition, 'AUTO_LOAD') = this.checked ? 'T' : 'F'">
											</td>
										</tr>
									</table>
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
								<td width="440">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold"> 입력인자</td>
											<td align="right" width="*">&nbsp;</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr class="head_line">
											<td width="*" height="3"></td>
										</tr>
									</table>
								</td>
								<td width="10"></td>
								<td width="*">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold"> 컬럼</td>
											<td align="right" width="*">&nbsp;</td>
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
								<td width="440" height="100%">
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__11"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridArgs WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsLovArgs">
										<PARAM NAME="Editable" VALUE="-1">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="Format" VALUE=" 
											<FC> Name=순번 ID=DIS_SEQ Align=Center Width=30 
											</FC> 
											<FC> Name=인자명 ID=NAME Width=105
											</FC> 
											<C> Name=타입 ID=TYPE Width=40 EditStyle=Combo Data='S:문자,N:숫자,D:날짜'
											</C> 
											<C> Name=기본값 ID=DEFAULT_VALUE Width=75
											</C> 
											<C> Name=세션? ID=SESSION_TAG Width=40 EditStyle=CheckBox
											</C> 
											<C> Name=세션변수명 ID=SESSION_NAME Width=100
											</C> 
											">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__11); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
								</td>
								<td width="10"></td>
								<td width="*">
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__12"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridCols WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsLovCols">
										<PARAM NAME="Editable" VALUE="-1">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="Format" VALUE=" 
											<FC> Name=순번 ID=DIS_SEQ Align=Center Width=30 
											</FC> 
											<FC> Name=컬럼명 ID=NAME Width=115 
											</FC> 
											<C> Name=타이틀 ID=TITLE Width=115 
											</C> 
											<C> Name=폭 ID=WIDTH Width=30 
											</C> 
											<C> Name=정렬 ID=ALIGN Width=40 EditStyle=Combo Data='L:좌측,C:중앙,R:우측'
											</C> 
											<C> Name=마스크 ID=MASK Width=70 
											</C> 
											<C> Name=표시 ID=VISIBLE Width=30 EditStyle=CheckBox
											</C> 
											">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__12); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
								</td>
							</tr>
							<tr>
								<td width="440">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr class="head_line">
											<td width="*" height="3"></td>
										</tr>
									</table>
								</td>
								<td width="10"></td>
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
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__13"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=binLov classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>
			<param name="DataID" value="dsLov">
			<param name="BindInfo" value="
				<C>Col=NAME Ctrl=txtName Param=Value</C>
				<C>Col=TITLE Ctrl=txtTitle Param=Value</C>
				<C>Col=WIDTH Ctrl=txtWidth Param=Value</C>
				<C>Col=HEIGHT Ctrl=txtHeight Param=Value</C>
				<C>Col=LOCATION_X Ctrl=txtX Param=Value</C>
				<C>Col=LOCATION_Y Ctrl=txtY Param=Value</C>
				<C>Col=SQL Ctrl=txtSql Param=Value</C>
				<C>Col=REMARK Ctrl=txtRemark Param=Value</C>
				<C>Col=AUTO_LOAD Ctrl=chkTest Param=checked</C>
				">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__13); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
