<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WBizPlan06(�վǰ�꼭���(���))
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-16)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	
	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�	
	String strFileName = "./t_WBizPlan06R";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";
	
	CITData		lrArgData = null;
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String strDEPT_NAME = "";
	String strCLSE_ACC_ID = "";
	String strACC_ID = "";
	String strQUARTER_YEAR = "";
	String strDEPT_PROJ_TAG = "";
	
	try
	{
		CITCommon.initPage(request, response, session);
		//����� ����
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
				throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
			}
		}
		else
		{
			strCOMPANY_NAME = CITCommon.NvlString(session.getAttribute("comp_name"));
		}
		//����� ���� ����
		//ȸ�� �˻�
		try
		{
			lrArgData = new CITData();
			lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			
			strSql = 
				"Select"+"\n"+
				"	a.CLSE_ACC_ID ,"+"\n"+
				"	a.ACC_ID"+"\n"+
				"From	T_YEAR_CLOSE a "+"\n"+
				"Where	a.COMP_CODE = ? "+"\n"+
				"And	Trunc(SysDate,'DD') Between a.ACCOUNT_FDT And a.ACCOUNT_EDT  "+"\n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			if(lrReturnData.getRowsCount() >= 1)
			{
				strCLSE_ACC_ID = lrReturnData.toString(0,"CLSE_ACC_ID");
				strACC_ID = lrReturnData.toString(0,"ACC_ID");
			}
		}
		catch (Exception ex)
		{
			throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
		}
		//ȸ�� �˻� ����

		//�б� �˻�
		try
		{
			lrArgData = new CITData();
			
			strSql = "Select to_char(sysdate,'mm') q from  dual ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strQUARTER_YEAR = lrReturnData.toString(0,"Q");
			strQUARTER_YEAR = lrReturnData.toString(0,"Q");
			if(strQUARTER_YEAR.equals("1"))
			{
				strQUARTER_YEAR = "2";
			}

		}
		catch (Exception ex)
		{
			throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
		}
		//�б� �˻� ����
		if(!CITCommon.isNull(strDEPT_CODE))
		{
			lrArgData = new CITData();
			try
			{
				lrArgData.addColumn("DEPT_CODE",CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("DEPT_CODE", strDEPT_CODE);
				
				strSql = " select DEPT_PROJ_TAG from t_dept_code  where DEPT_CODE = ?  ";

				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				if(lrReturnData.getRowsCount() >= 1)
				{
					strDEPT_PROJ_TAG = lrReturnData.toString(0,"DEPT_PROJ_TAG");
					if(strDEPT_PROJ_TAG.equals("P"))
					{
					}
					else
					{
						strDEPT_CODE = "";
						strDEPT_NAME = "";
					}
				}
				
			}
			catch (Exception ex)
			{
				throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
			}
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
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
			var			sDeptCode = "<%=strDEPT_CODE%>";
			var			sDeptName = "<%=CITCommon.enSC(strDEPT_NAME)%>";
			var			sClseAccId = "<%=strCLSE_ACC_ID%>";
			var			sAccId = "<%=strACC_ID%>";
			var			sQUARTER_YEAR = "<%=strQUARTER_YEAR%>";


		//-->
		</script>
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
	</head>
	<body onload="C_Initialize()">
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
											<td class=td_green>
												<!-- ���α׷��� ������ ���� //-->
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>												
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="45" class=font_green_bold>�����</td>
														<td width="47">
															<input id="txtCOMP_CODE" type="text" style="width:45px" onblur="txtCOMP_CODE_onblur()">
														</td>
														<td width="140">
															<input id="txtCOMPANY_NAME" type="text" readOnly class="ro" style="width:138px">
														</td>
														<td width="50">
															<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="�˻�" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>
														<td width="40">&nbsp;</td>												
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="40" class=font_green_bold>ȸ��</td>
														<td width="40">
															<input id="txtCLSE_ACC_ID" type="text" style="width:38px" onblur="txtCLSE_ACC_ID_onblur()">
														</td>
														<td width="60">
															<input id="txtACC_ID" type="text" readOnly class="ro" style="width:40px"> ��
														</td>
														<td width="50">
															<input id="btnACC_ID" type="button" class="img_btnFind" value="�˻�" onclick="btnACC_ID_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>
														<td width="40">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60" class=font_green_bold>���ؿ�</td>
														<td width="72">
															<select  id="cboQUARTER_YEAR"  style="WIDTH: 70px" onchange="cboQUARTER_YEAR_onChange()">
																<OPTION value='01'> 1��</OPTION>
																<OPTION value='02'> 2��</OPTION>
																<OPTION value='03'> 3��</OPTION>
																<OPTION value='04'> 4��</OPTION>
																<OPTION value='05'> 5��</OPTION>
																<OPTION value='06'> 6��</OPTION>
																<OPTION value='07'> 7��</OPTION>
																<OPTION value='08'> 8��</OPTION>
																<OPTION value='09'> 9��</OPTION>
																<OPTION value='10'> 10��</OPTION>
																<OPTION value='11'> 11��</OPTION>
																<OPTION value='12'> 12��</OPTION>
															</select>
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
					</td>
				</tr>
				<!-- ���α׷��� ������ ���� //-->
				<tr valign="top"> 
					<td width="100%" height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="*">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20"><img src="../images/bullet1.gif"></td>
														<td class="font_green_bold"> �ڱݼ���</td>
														<td align="right" width="*" >����:�鸸��(1000000)</td>
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
												<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsMAIN">
													<PARAM NAME="Editable" VALUE="-1">
													<PARAM NAME="ColSelect" VALUE="-1">
													<PARAM NAME="ColSizing" VALUE="-1">
													<PARAM NAME="SuppressOption" 	VALUE=1>
<%
String  strBgColor1 = "BgColor ={Decode(MAIN_ORDER,1,'#ECF5EB',2,'#ECF5EB',4,'#ECF5EB',7,'#ECF5EB',13,'#ECF5EB','#FFFCE0')}";
String  strBgColor2 = "BgColor ={Decode(MAIN_ORDER,1,'#ECF5EB',2,'#ECF5EB',4,'#ECF5EB',7,'#ECF5EB',13,'#ECF5EB','white')}";
String  strColor = "Color   ={Decode(MAIN_ORDER,1,'blue',2,'blue',4,'blue',7,'blue',13,'blue',  'black')}";
%>
													<PARAM NAME="Format" VALUE="
														<FC> Name='�׸�' id='NAME'	Width=95  <%=strBgColor1%> <%=strColor%>
														</FC>
														<G> Name='�Ǽ�' id='G1'
															<C> Name='����' ID=EXEC_AMT_TOT_BF1		decao='4'	Width=95 <%=strBgColor2%> <%=strColor%>
															</C>
															<C> Name='��ȹ' ID=PLAN_AMT_TOT1			decao='4'	Width=95 <%=strBgColor2%> <%=strColor%>	
															</C>
															<C> Name='����' ID=EXEC_AMT_TOT1			decao='4'	Width=95 <%=strBgColor2%> <%=strColor%>
															</C>
															<C> Name='�޼�' ID=PRG_1							decao='4'	Width=95 <%=strBgColor2%> <%=strColor%>
															</C>
														</G>	
														<G> Name='ENG' id='G2'
															<C> Name='����' 		ID=EXEC_AMT_TOT_BF2	Width=95	decao='4'	<%=strBgColor2%> <%=strColor%>
															</C>
														</G>
														<G> Name='����Ʈ' id='G3'
															<C> Name='����' ID=EXEC_AMT_TOT_BF3			Width=95 	decao='4'	<%=strBgColor2%> <%=strColor%>
															</C>
															<C> Name='��ȹ' ID=PLAN_AMT_TOT3				Width=95 	decao='4'	<%=strBgColor2%> <%=strColor%>
															</C>
															<C> Name='����' ID=EXEC_AMT_TOT3				Width=95 	decao='4'	<%=strBgColor2%> <%=strColor%>
															</C>
															<C> Name='�޼�' ID=PRG_3								Width=95 	decao='4'	<%=strBgColor2%> <%=strColor%>
															</C>
														</G>
														<G> Name='����' id='G4'
															<C> Name='����' ID=EXEC_AMT_TOT_BF_ALL	Width=95 	decao='4'	<%=strBgColor2%> <%=strColor%>
															</C>
															<C> Name='��ȹ' ID=PLAN_AMT_TOT_ALL			Width=95 	decao='4'	<%=strBgColor2%> <%=strColor%>
															</C>
															<C> Name='����' ID=EXEC_AMT_TOT_ALL			Width=95 	decao='4'	<%=strBgColor2%> <%=strColor%>
															</C>
															<C> Name='�޼�' ID=PRG_ALL							Width=95 	decao='4'	<%=strBgColor2%> <%=strColor%>
															</C>
														</G>														
												</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
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