<%@ page language="java" import="java.net.*, com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*" errorPage="Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/***************************************************/
/* 최초작성자 : 강덕율
/* 최초작성일 : 2005-10-31
/* 최종수정자 : 
/* 최종수정일 : 
/***************************************************/

	CITData lrLov = null;
	CITData lrArgs = null;
	CITData lrCols = null;
	
	String strAct = "";
	String strSql = "";
	String strOut = "";
	String strLovName = "";
	String strSearch = "NO_SEARCH";
	String strState = "N";
	
	String strLovNo = "0";
	String strTitle = "";
	String strWidth = "300";
	String strHeight = "300";
	String strX = "0";
	String strY = "0";
	String strAutoLoad = "";
	
	try
	{
		CITCommon.initPage(request, response, session, false);
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		strLovName = CITCommon.URLDecoding(request.getParameter("LOV_NAME"));
		
		if (!CITCommon.isNull(strLovName))
		{
			CITData lrArgData = new CITData();
			
			lrArgData.addColumn("NAME", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("NAME", strLovName);
			
			strSql   = " Select * \n";
			strSql  += " From   T_LOV \n";
			strSql  += " Where  NAME = ? \n";
			
			lrLov = CITDatabase.selectQuery(strSql, lrArgData);
			
			if (lrLov.getRowsCount() > 0)
			{
				strLovNo = lrLov.toString(0, "LOV_NO");
				strTitle = lrLov.toString(0, "TITLE");
				strWidth = lrLov.toString(0, "WIDTH");
				strHeight = lrLov.toString(0, "HEIGHT");
				strX = lrLov.toString(0, "LOCATION_X");
				strY = lrLov.toString(0, "LOCATION_Y");
				strAutoLoad = lrLov.toString(0, "AUTO_LOAD");
				
				lrArgData.removeAll();
				
				lrArgData.addColumn("LOV_NO", CITData.NUMBER);
				lrArgData.addRow();
				lrArgData.setValue("LOV_NO", strLovNo);
				
				strSql   = " Select * \n";
				strSql  += " From   T_LOV_ARGS \n";
				strSql  += " Where  LOV_NO = ? \n";
				strSql  += " Order by DIS_SEQ ";
				
				lrArgs = CITDatabase.selectQuery(strSql, lrArgData);
				
				for (int i = 0; i < lrArgs.getRowsCount(); i++)
				{
					if (lrArgs.toString(i, "SESSION_TAG").equals("T"))
					{
						strSearch = lrArgs.toString(i, "NAME");
						break;
					}
				}
				
				strSql   = " Select * \n";
				strSql  += " From   T_LOV_COLS \n";
				strSql  += " Where  LOV_NO = ? \n";
				strSql  += " Order by DIS_SEQ ";
				
				lrCols = CITDatabase.selectQuery(strSql, lrArgData);
			}
			else
			{
				strState = "E";
			}
		}
		else
		{
			strState = "E";
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
		<title><%=strTitle%></title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript">
		<!--
			var intLovNo = <%=strLovNo%>;
			var strLovName = "<%=strLovName%>";
			var strTitle = "<%=strTitle%>";
			var intWidth = <%=strWidth%>;
			var intHeight = <%=strHeight%>;
			var intX = <%=strX%>;
			var intY = <%=strY%>;
			var strAutoLoad = "<%=strAutoLoad%>";
			var strSearch = "<%=strSearch%>";
			var strState = "<%=strState%>";
			
			var strArgs = "";
			
			function Initialize()
			{
				if (strState == "E")
				{
					C_msgOk("LOV가 존재하지 않습니다.(<%=strLovName%>)", "에러");
					window.returnValue = strState;
					window.close();
				}
				
				document.body.topMargin = 0;
				document.body.leftMargin = 0;
				
				if (intX == 0 && intY == 0 )
				{
					window.dialogTop = (window.screen.availHeight / 2) - ((intHeight + 25) / 2);
					window.dialogLeft = (window.screen.availWidth / 2) - ((intWidth + 6) / 2);
				}
				else
				{
					window.dialogTop = intY;
					window.dialogLeft = intX;
				}
				
				window.dialogHeight = (intHeight + 25).toString() + "px";
				window.dialogWidth = (intWidth + 6).toString() + "px";
				
				setArgs();
				
				G_addDataSet(dsMAIN, null, gridMAIN, null, strTitle);
				
				if (strAutoLoad == "T")
				{
					btnRetrieve_onClick()
				}
				else
				{
					txtSearch.focus();
				}
			}
			
			// 함수관련---------------------------------------------------------------------//
			function setArgs()
			{
				var lrArgs = window.dialogArguments;
				var arrKeys = null;
				var arrItems = null;
				
				if (lrArgs != null)
				{
					arrKeys = lrArgs.keys();
					arrItems = lrArgs.items();
					
					for (var i = 0; i < arrKeys.length; i++)
					{
						if (arrKeys[i] == strSearch)
						{
							txtSearch.value = arrItems[i];
							continue;
						}
						
						strArgs += "&" + arrKeys[i] + "=" + arrItems[i];
					}
				}
			}
			
			function ConfirmSelected(row)
			{
				var lrRet = window.dialogArguments;
				
				lrRet.removeAll();
				
				for (var i = 1; i <= dsMAIN.CountColumn; i++)
				{
					lrRet.set(dsMAIN.ColumnID(i), dsMAIN.ColumnString(row, i));
				}

				window.returnValue = lrRet;
				window.close();
			}
			
			// 공통 재정의 이벤트관련-------------------------------------------------------//
			function OnLoadBefore(dataset)
			{
				if (dataset == dsMAIN)
				{
					dataset.DataID = "Lov_q.jsp?LOV_NAME=" + strLovName + strArgs + "&" + strSearch + "=" + txtSearch.value;
				}
			}
			
			function OnKeyPress(dataset, grid, kcode)
			{
				if (grid == gridMAIN)
				{
					if (kcode == 13)
					{
						if (dsMAIN.RowPosition < 1) return;
						ConfirmSelected(dsMAIN.RowPosition);
					}
					else if (kcode == 27)
					{
						imgCancle_onClick();
					}
				}
			}
			
			function OnDblClick(dataset, grid, row, colid)
			{
				if (grid == gridMAIN)
				{
					if (row < 1) return;
					ConfirmSelected(row);
				}
			}
			
			// 이벤트관련-------------------------------------------------------------------//
			function document_onKeyDown()
			{
				if (event.keyCode == 27)
				{
					imgCancle_onClick();
				}
				if (event.ctrlLeft == true && event.shiftLeft == true && event.keyCode == 76)
				{
					C_msgError("LOV No : " + intLovNo + "\nLOV Name : " + strLovName, "LOV 정보");
				}
			}
			
			function btnRetrieve_onClick()
			{
				G_Load(dsMAIN, null);
				gridMAIN.focus();
			}
			
			function txtSearch_onKeyDown()
			{
				if (event.keyCode != 13) return;
				btnRetrieve_onClick();
			}
			
			function imgOk_onClick()
			{
				if(dsMAIN.CountRow < 1)
				{
					C_msgOk("리스트상의 데이터를 선택하시기 바랍니다.");
					return;
				}
				
				ConfirmSelected(dsMAIN.RowPosition);
			}
			
			function imgCancle_onClick()
			{
				window.returnValue = null;
				window.close();
			}
			
		//-->
		</script>
		
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
	</head>
	<body onload="C_Initialize()">
		<TABLE id="tableMain" cellSpacing="0" cellPadding="0" width="100%" height="100%" border="0">
			<TR >
				<TD align="center">
					<!-- 표준 팝업 페이지의 최소 DIV 크기(폭:250px 이상, 높이:400px 고정) //-->
					<DIV id="divPopMain" style="WIDTH: 100%; HEIGHT: 100%;">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr > 
								<td align="left" background="../images/pop_tit_bg.gif">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="52"><img src="../images/pop_tit_normal1.gif"></td>
											<td class="title_default"><%=strTitle%></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr > 
								<td height="100%" width="100%" bgcolor="#CCCCCC">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr valign="top"> 
											<td align="center" height="100%" bgcolor="#FFFFFF">
												<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
													<tr  bgcolor="ECECEC">
														<td align="center" bgcolor="ECECEC">
															<!-- 검색어 시작 //-->
															<TABLE width="100%" height="30" cellSpacing="0" cellPadding="0" border="0" >
																<TR>
																	<TD width="10" ><IMG src="../images/bullet3.gif" ></TD>
																	<TD width="55" noWrap="true">검색조건</TD>
																	<TD WIDTH="*"><INPUT type="text" id="txtSearch" style="WIDTH:100%" onKeyDown="txtSearch_onKeyDown()"></TD>
																	<TD width="2">&nbsp;</TD>
																	<TD width="50">
																		<input id="btnRetrieve" type="button" class="img_btnFind" value="검색" onclick="btnRetrieve_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																	</TD>
																	<td width="4">&nbsp;</td>
																</TR>
															</TABLE>
															<!-- 검색어 종료 //-->
														</td>
													</tr>
													<tr height="100%">
														<td width="100%" height="100%" align="center" bgcolor="ECECEC"> 
															<!-- 프로그래머 디자인 시작 //-->
																<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN style="HEIGHT: 100% ; WIDTH: 100%"  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT codebase="../../../cabfiles/toinbgrid.cab#version=1,1,0,125">
																	<PARAM NAME="Editable" VALUE="false">
																	<PARAM NAME="ColSelect" VALUE="false">
																	<PARAM NAME="ColSizing" VALUE="-1">
																	<PARAM NAME="DataID" VALUE="dsMAIN">
																	<PARAM NAME="Format" VALUE=" 
																	<%
																		if (lrCols != null)
																		{
																			for (int i = 0; i < lrCols.getRowsCount(); i++)
																			{
																				if (!lrCols.toString(i, "VISIBLE").equals("T")) continue;
																				
																				strOut = "<C> Name=" + lrCols.toString(i, "TITLE");
																				strOut += " ID=" + lrCols.toString(i, "NAME");
																				strOut += CITCommon.isNull(lrCols.toString(i, "MASK")) ? "" : " Mask='" + lrCols.toString(i, "MASK") + "'";
																				
																				if (lrCols.toString(i, "ALIGN").equals("L"))
																				{
																					strOut += " Align=Left";
																				}
																				else if (lrCols.toString(i, "ALIGN").equals("C"))
																				{
																					strOut += " Align=Center";
																				}
																				else if (lrCols.toString(i, "ALIGN").equals("R"))
																				{
																					strOut += " Align=Right";
																				}
																				
																				strOut += " Width=" + lrCols.toString(i, "WIDTH") + " </C>";
																				
																				out.println(strOut);
																			}
																		}
																	%>
																	">
																</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
															<!-- 프로그래머 디자인 종료 //-->
														</td>
													</tr>
													<tr height="34"> 
														<td bgcolor="ECECEC">
														    <table width="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<TD width="*">
																		<font color="red">※검색조건을 입력하시고 검색버튼을 누르세요.</font>
																	</TD>
																	<TD width="120" align="right">
																		<input id="imgOk" type="button" class="img_btnOk" value="확인" onclick="imgOk_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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