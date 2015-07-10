<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WFBCardAccountR.jsp(����ī��������)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ����ī��������
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-03)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/

	CITData lrReturnData = null;
	String strDate = CITDate.getNow("yyyy-MM-dd");
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�
	String strFileName = "./t_WFBCardAccQR";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";

	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String strCombo = "";
	String strAdjust = "";
	String strPayStatus = "";
	String	strDTF = "";
	String	strUserNo = "";
	CITData		lrArgData = null;
	try
	{
		CITCommon.initPage(request, response, session);
		//����� ����
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
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
				throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
			}
		}
		else
		{
			strCOMPANY_NAME = CITCommon.NvlString(session.getAttribute("comp_name"));
		}
		//����� ���� ����
		lrArgData = new CITData();
		try
		{
			strSql  = " Select \n";
			strSql += "     2 GB, \n";
			strSql += "     a.LOOKUP_CODE  CODE , \n";
			strSql += "     a.LOOKUP_VALUE NAME   \n";
			strSql += " From	 T_FB_LOOKUP_VALUES a \n";
			strSql += " Where	 a.LOOKUP_TYPE = 'AdjustStatus'  \n";
			strSql += " And  	 a.USE_YN = 'Y'  \n";
			strSql += " UNION All \n";
			strSql += " Select \n";
			strSql += "     1, \n";
			strSql += "     '%', \n";
			strSql += "     '��ü' \n";
			strSql += " From	Dual \n";
			strSql += " order by 1,2 \n";
				
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strAdjust = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");

		}
		catch(Exception ex)
		{
			throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
		}		
		lrArgData = new CITData();
		try
		{
			strSql  = " Select \n";
			strSql += "     2 GB, \n";
			strSql += "     a.LOOKUP_CODE  CODE , \n";
			strSql += "     a.LOOKUP_VALUE NAME   \n";
			strSql += " From	 T_FB_LOOKUP_VALUES a \n";
			strSql += " Where	 a.LOOKUP_TYPE = 'HR_PAY_TRAN_STATUS' \n";
			strSql += " And  	 a.USE_YN = 'Y'  \n";
			strSql += " UNION All \n";
			strSql += " Select \n";
			strSql += "     1, \n";
			strSql += "     '%', \n";
			strSql += "     '��ü' \n";
			strSql += " From	Dual \n";
			strSql += " order by 1,2 \n";
				
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strPayStatus = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");

		}
		catch(Exception ex)
		{
			throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
		}				
		lrArgData = new CITData();
		try
		{
			strSql =
				"Select"+"\n"+
				"	to_char(sysdate ,'yyyy')||'-'||to_char(sysdate ,'MM') DTF "+"\n"+
				"From	Dual "+"\n";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strDTF = lrReturnData.toString(0,"DTF");
		}
		catch(Exception ex)
		{
			throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
		}
	}
	catch (Exception ex)
	{
		throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>ȸ�����</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript" src="../script/DefaultActions.js"></script>
		<script language="javascript" src="<%=strFileName%>.js"></script>
		<script language="javascript">
		<!--
			var 		oldData1 = "";
			var			oldData2 = "";
			var			vDate = "<%=strDate%>";
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
			var			sDeptCode = "<%=CITCommon.enSC(strDEPT_CODE)%>";
			var			sDTF = "<%=strDTF%>";
			var     sEmpNo = "<%=strUserNo%>";

			// �̺�Ʈ����-------------------------------------------------------------------//

		//-->
		</script>

		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><object id="dsCOPY" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL ������������//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL ������������//--><object id="transCopy"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	    <param name="KeyValue" value="Service1(I:dsCOPY=dsCOPY)">
		  <param name="Action"   value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL ������������//-->		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
	</head>
	<body onload="C_Initialize()">
		<form name="frmList" action="../common/t_WCcReportRequestProcess.jsp" target="_blank" method="post">
			<input type='hidden' name='ACT' value="REQUEST">
			<Input type='hidden' name='KEY' value="">
			<input type='hidden' name='EXPORT_TAG' value="">
			<input type='hidden' name='RUN_TAG' value="">
			<input type='hidden' name='CONDITION_PAGE' value="<%=strFileName%>">
			<input type='hidden' name='REQUEST_NAME' value="">
			<Input type='hidden' name='REPORT_NO' value="">
			<Input type='hidden' name='REPORT_FILE_NAME' value="">
			<Input type='hidden' name='PARAMETERS' value="">
		</form>	
		<div id="divMainFix" class="main_div">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<td width="100%">
						<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
						<!-- ���� ���̺� ���� //-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="head_line">
								<td width="*" height="1"></td>
							</tr>
							<tr>
								<td width="100%" class="td_green">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="50" class=font_green_bold>�����</td>
											<td width="254">
											<table width="254" border="0" cellspacing="0" cellpadding="0">
											<td width="62">
											<input name="txtCOMP_CODE" type="text" class="ro" readOnly style="width:60px" VALUE="<%=strCOMP_CODE%>" ></td>
											<td width="152">
											<input name="txtCOMP_NAME" type="text" class="ro" readOnly style="width:150px" VALUE="<%=strCOMPANY_NAME%>" ></td>
											<td width="70">
											<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="�˻�" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>																						
											<td>&nbsp; </td>
											</table>
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="70" class="font_green_bold" >������</td>
											<td width="72">
												<input id="txtDATE_FROM" type="text" style="width:70px" datatype="DATEYM" >
											</td>
											<td width=40>
												<input id="btnDATE_FROM" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnDATE_FROM_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="70" class="font_green_bold" >ī���ȣ</td>
											<td width="254">
											<table width="214" border="0" cellspacing="0" cellpadding="0">
											<td width="112"> <input name="txtCARD_CODE" type="text" datatype="han" style="width:110px" VALUE="" onblur="txtCARD_CODE_onblur()"></td>
											<td width="102"> <input name="txtCARD_NAME" type="text" class="ro" readOnly style="width:100px" VALUE="">
											</td>
											<td width="40">
												<input name="btnCARD_CODE" type="button" class="img_btnFind" onclick="btnCARD_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="ã��" /></td>
											<td>&nbsp; </td>	
											</table>
											</td>											
                      <td>&nbsp; </td>
										</tr>
									</table>
								</td>
							</tr>
							<tr class="head_line">
								<td width="*" height="1"></td>
							</tr>
						</table>
						<!-- ���� ���̺� ���� //-->
						<!-- �������� ���̺� ���� //-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="5"></td>
							</tr>
						</table>
						<!-- �������� ���̺� ���� //-->
					</td>
				</tr>
				<!-- ���α׷��� ������ ���� //-->
				<tr valign="top">
					<td width="100%" height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="100%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20"><img src="../images/bullet1.gif"></td>
														<td class="font_green_bold"> ����ī��û������</td>
														<td align="right" width="*">
														<input id="btnSELECT_ACC"		type="button" tabindex="-1" class="img_btn6_1" onClick="btnSELECT_ACC_onClick()" 	value="��ǥ������ȸ" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
    												<input id="btnCARD_PRINT" 	type="button" tabindex="-1" class="img_btn4_1" onClick="btnCARD_PRINT_onClick()" 	value="���" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" 
														</td>
													</tr>
												</table>
									<!-- SUM ���̺� ���� //-->
									<!-- �������� ���̺� ���� //-->
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td height="5"></td>
										</tr>
									</table>
									<!-- �������� ���̺� ���� //-->	
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr class="head_line"> 
											<td width="*" height="1"></td>
										</tr>
										<tr> 
											<td width="100%"  style="background:#F6F6F6">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td >
															<!-- ���α׷��� ������ ���� //-->
															<table width="100%" border="0" cellspacing="0" cellpadding="0" bordercolor="black">
																<tr>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="45" >�ѱݾ�</td>
																	<td width="165">
																	<input name="txtTOTAL_SUM" type="text" class="ro" readOnly right style="width:155px;background:#FFECEC" ></td>
																	</td>													
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="84" >û�����հ�</td>
																	<td width="165">
																	<input name="txtNOUSE_SUM" type="text" class="ro" readOnly right style="width:155px;background:#FFECEC"  ></td>
																	</td>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="84" >���κ��հ�</td>
																	<td width="165">
																	<input name="txtPERSON_SUM" type="text" class="ro" readOnly right style="width:155px;background:#FFECEC" ></td>
																	</td>																	
																	<td>&nbsp; </td>			
																</tr>
															</table>
															<!-- ���α׷��� ������ ���� //-->
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr class="head_line"> 
											<td width="*" height="1"></td>
										</tr>
									</table>
									<!-- ���� ���̺� ���� //-->
									<!-- �������� ���̺� ���� //-->
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td height="5"></td>
										</tr>
									</table>
									<!-- �������� ���̺� ���� //-->	
									<!-- SUM ���̺� ���� //-->												
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr class="head_line">
														<td width="*" height="3"></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td width="100%" height="100%">
												<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsMAIN">
													<PARAM NAME="Editable" VALUE="-1">
													<PARAM NAME="ColSelect" VALUE="-1">
													<PARAM NAME="ColSizing" VALUE="-1">
													<PARAM NAME="ViewSummary" 	VALUE=1>
													<PARAM NAME="Format" VALUE="
														<C> Name='����'       ID='SELECT_YN'				EditStyle=checkbox	Align=Center	Width=30	show=false</C>													
														<FC> Name=ī���ȣ 		ID='CARDNUMBER'				Align=Center	Width=160 									  </FC>
														<FC> Name=������ 		ID='ADJUSTYEARMONTH'	Align=Center	Width=160  show=false   </FC>
														<C> Name='������' 	  ID='EMPNAME'					SumText='      �Ѱ�  : ' Align=Center	 Width=100		  </C>
														<C> Name='�ѱݾ�' 		ID=TOTALSUM						SumText=@sum	Width=100 														</C>
														<C> Name='û���ݾ�' 	ID=COMPANYSUM					SumText=@sum	Width=100 </C>
														<C> Name='���αݾ�' 	ID=PERSONSUM					SumText=@sum	Width=100 </C>
														<C> Name='��������' 	ID=AccNo							Width=100   </C>
														<C> Name='��������' 	ID=Bank_Main_Name			Width=100         </C>
														<C> Name='��ǥ��ȣ' 	ID=SLIP								Width=120 	</C>
														<C> Name='��ǥ��ȣ' 	ID=Slip_id						Width=70 	show=false </C>
														<C> Name='��ǥ��ȣ' 	ID=Slip_idseq					Width=70 	show=false </C>
														<C> Name='�ۼ�����' 	ID=MAKE_DT						Width=70 	show=false </C>
														<C> Name='�ۼ�����' 	ID=MAKE_SEQ						Width=70 	show=false </C>
														<C> Name='�ۼ�����' 	ID=SLIP_KIND_TAG				Width=70 	show=false </C>
														<C> Name='��ǥ����' 	ID=ADJUSTFinishDateTime		Width=70	</C>
														">
												</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL ������������//-->
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
						</table>
					</td>
				</tr>
				<!-- ���α׷��� ������ ���� //-->
			</table>
		</div>
		<!-- ���콺 Bind ��ü���� ���� //-->
		<!-- ���콺 Bind ��ü���� ���� //-->
	</body>
</html>
<%
	try
	{
		CITCommon.finalPage();
	}
	catch (Exception ex)
	{
		throw new Exception("������ ���� ���� -> " + ex.getMessage());
	}
%>