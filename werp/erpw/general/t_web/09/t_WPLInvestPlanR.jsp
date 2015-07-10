<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WPLInvestPlanR(����濵��ȹ���ڰ�ȹ����)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-29)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	
	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�	
	String strFileName = "./t_WPLInvestPlanR";
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


		//-->
		</script>
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
			<param NAME=SubSumExpr          value="1:INV_TAG:INV_TAG_NAME ">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id="dsLOV" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
		
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="<%=strUpdateKeyValue%>">
			<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->
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
														<td width="52">
															<input id="txtCOMP_CODE" type="text" style="width:50px" onblur="txtCOMP_CODE_onblur()">
														</td>
														<td width="150">
															<input id="txtCOMPANY_NAME" type="text" readOnly class="ro" style="width:148px">
														</td>
														<td width="70">
															<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="�˻�" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="45" class=font_green_bold>ȸ��</td>
														<td width="52">
															<input id="txtCLSE_ACC_ID" type="text" style="width:50px" onblur="txtCLSE_ACC_ID_onblur()">
														</td>
														<td width="60">
															<input id="txtACC_ID" type="text" readOnly class="ro" style="width:40px"> ��
														</td>
														<td width="70">
															<input id="btnACC_ID" type="button" class="img_btnFind" value="�˻�" onclick="btnACC_ID_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
														<td class="font_green_bold"> ���ڰ�ȹ/����/���� ����</td>
														<td align="right" width="*">
															<input id="chkPLAN" type="CheckBox" class="check" onclick="chkPLAN_onClick()">
																��ȹ
															<input id="chkFORE" type="CheckBox" class="check" onclick="chkFORE_onClick()">
																����
															<input id="chkEXEC" type="CheckBox" class="check" onclick="chkEXEC_onClick()">
																����
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
												<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsMAIN">
													<PARAM NAME="Editable" VALUE="true">
													<PARAM NAME="ColSelect" VALUE="true">
													<PARAM NAME="ColSizing" VALUE="true">
													<PARAM NAME="ViewSummary" VALUE="1">
													<param name=SuppressOption value="1">
													<PARAM NAME="Format" VALUE="
														<FC> Name=���ڱ��� ID=INV_TAG_NAME Width=100 suppress=1 Color={Decode(KIND_CODE,'','red','black')}
														</FC>
														<FC> Name=�׸�� ID=KIND_NAME Width=120 suppress=2 Color={Decode(KIND_CODE,'','red','black')}
														</FC>
														<FC> Name=���� ID=LV_NAME Align=Center Width=60 Color={Decode(KIND_CODE,'','red','black')}
														</FC>
														<G> Name='1��' ID=G1
															<C> Name='��ȹ' ID=PLAN_AMT_01	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
															<C> Name='����' ID=FORECAST_AMT_01	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
															<C> Name='����' ID=EXEC_AMT_01	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
														</G>
														<G> Name='2��' ID=G2
															<C> Name='��ȹ' ID=PLAN_AMT_02	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
															<C> Name='����' ID=FORECAST_AMT_02	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
															<C> Name='����' ID=EXEC_AMT_02	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
														</G>
														<G> Name='3��' ID=G3
															<C> Name='��ȹ' ID=PLAN_AMT_03	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
															<C> Name='����' ID=FORECAST_AMT_03	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
															<C> Name='����' ID=EXEC_AMT_03	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
														</G>
														<G> Name='4��' ID=G4
															<C> Name='��ȹ' ID=PLAN_AMT_04	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
															<C> Name='����' ID=FORECAST_AMT_04	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
															<C> Name='����' ID=EXEC_AMT_04	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
														</G>
														<G> Name='5��' ID=G5
															<C> Name='��ȹ' ID=PLAN_AMT_05	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
															<C> Name='����' ID=FORECAST_AMT_05	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
															<C> Name='����' ID=EXEC_AMT_05	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
														</G>
														<G> Name='6��' ID=G6
															<C> Name='��ȹ' ID=PLAN_AMT_06	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
															<C> Name='����' ID=FORECAST_AMT_06	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
															<C> Name='����' ID=EXEC_AMT_06	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
														</G>
														<G> Name='7��' ID=G7
															<C> Name='��ȹ' ID=PLAN_AMT_07	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
															<C> Name='����' ID=FORECAST_AMT_07	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
															<C> Name='����' ID=EXEC_AMT_07	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
														</G>
														<G> Name='8��' ID=G8
															<C> Name='��ȹ' ID=PLAN_AMT_08	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
															<C> Name='����' ID=FORECAST_AMT_08	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
															<C> Name='����' ID=EXEC_AMT_08	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
														</G>
														<G> Name='9��' ID=G9
															<C> Name='��ȹ' ID=PLAN_AMT_09	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
															<C> Name='����' ID=FORECAST_AMT_09	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
															<C> Name='����' ID=EXEC_AMT_09	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
														</G>
														<G> Name='10��' ID=G10
															<C> Name='��ȹ' ID=PLAN_AMT_10	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
															<C> Name='����' ID=FORECAST_AMT_10	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
															<C> Name='����' ID=EXEC_AMT_10	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
														</G>
														<G> Name='11��' ID=G11
															<C> Name='��ȹ' ID=PLAN_AMT_11	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
															<C> Name='����' ID=FORECAST_AMT_11	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
															<C> Name='����' ID=EXEC_AMT_11	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
														</G>
														<G> Name='12��' ID=G12
															<C> Name='��ȹ' ID=PLAN_AMT_12	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
															<C> Name='����' ID=FORECAST_AMT_12	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
															<C> Name='����' ID=EXEC_AMT_12	Width=90 Color={Decode(KIND_CODE,'','red','black')} SumText=@Sum
															</C>
														</G>
														">
												</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL ������������//-->
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