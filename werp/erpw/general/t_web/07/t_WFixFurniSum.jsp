<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WFixFurniSum.jsp(�μ��� �󰢾�)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : �μ��� �󰢾� 
/* 4. ��  ��  ��  �� :  ����� �ۼ�(2006-01-23)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	String  strDATE  = CITDate.getNow("yyyyMMdd");
	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�	
	String strFileName = "./t_WFixFurniSum";
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
			var			olddata1 ="";
			var			olddata2 ="";
			var			olddata3 ="";
			var			olddata4 ="";
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			var			vDATE = "<%=strDATE%>";
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
			// �̺�Ʈ����-------------------------------------------------------------------//
			
		//-->
		</script>
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN2 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL ������������//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL ������������//-->
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
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="65"  class="font_green_bold" >�� �� ��</td>
											<td width="70">  <input name="txtCOMP_CODE" 		type="text" datatype="han" style="width:68px" 	VALUE="" onblur="txtCOMPANY_CODE_onblur()"></td>
											<td width="200"> <input name="txtCOMPANY_NAME"	type="text" class="ro"	readOnly style="width:198px"	VALUE=""></td>
											<td width="40">
												<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="�˻�" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td>&nbsp;</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="65" class="font_green_bold">�۾�����</td>
											<td width="70"> <input name="txtWORK_DT_FROM" type="text" datatype="date" style="width:70px" VALUE="" ></td>
											<td width="20"><input id="btnWORK_DT_FROM" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnWORK_DT_FROM_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
											<td width="12">~</td>
											<td width="70"><input name="txtWORK_DT_TO" type="text" datatype="date" align="Center" style="width:70px" VALUE=""></td>
											<td width="20"><input id="btnWORK_DT_TO" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnWORK_DT_TO_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
											<td width="2">&nbsp;</td>
											<td width="40">
												<input id="btnIWORK" type="button" class="img_btnFind" value="�˻�" onclick="btnIWORK_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width="97">&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="65" class="font_green_bold">�� �� ��</td>
											<td> <input name="hiWORK_SEQ" type="Hidden"></td>
											<td width="250"> <input name="txtWORK_NAME" type="text" class="ro" readOnly style="width:241px" ></td>
											<td>&nbsp;</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="65"  class="font_green_bold" >�ͼӺμ�</td>
											<td width="70">  <input name="txtDEPT_CODE" 		type="text"  style="width:68px" 	VALUE="" onblur="txtDEPT_CODE_onblur()"></td>
											<td width="200"> <input name="txtDEPT_NAME"	type="text" class="ro"	readOnly style="width:198px"	VALUE=""></td>
											<td width="40">
												<input id="btnDEPT_CODE" type="button" class="img_btnFind" value="�˻�" onclick="btnDEPT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width="25">&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="65" class="font_green_bold">�ͼ�����</td>
											<td width="70"> <input name="txtSUM_DT_FROM" type="text" datatype="date" style="width:70px" VALUE="" ></td>
											<td width="20"><input id="btnSUM_DT_FROM" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnSUM_DT_FROM_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
											<td width="12">~</td>
											<td width="70"><input name="txtSUM_DT_TO" type="text" datatype="date" align="Center" style="width:70px" VALUE=""></td>
											<td width="20"><input id="btnSUM_DT_TO" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnSUM_DT_TO_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
											<td width="2">&nbsp;</td>
											
											<td>&nbsp;</td>
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
						<table width="100%" height="50%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold"> ������������Ȳ</td>
											<td align="right" width="*">
												&nbsp;
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
									<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN">
										<PARAM NAME="Editable" VALUE="-1">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="Format" VALUE=" 
											<C> Name=������ 		ID=ACC_NAME				Align=Left	 Width=160   	Edit='none' 	Show='true'		SumText=' ��  �� :' SubColor='RED'
											</C>
											<C> Name=�����ڻ갡�� 	ID=START_ASSET_AMT		Align=Right	 Width=100   	Edit='none' 	SumText=@sum	SumColor=Black	SumBgColor=#FFF270  SumTextAlign=right
											</C>
											<C> Name=����ڻ����� 	ID=CURR_ASSET_INC_AMT	Align=Right	 Width=100   	Edit='none' 	SumText=@sum	SumColor=Black	SumBgColor=#C4E693  SumTextAlign=right
											</C>
											<C> Name=����ڻ갨�� 	ID=CURR_ASSET_SUB_AMT	Align=Right	 Width=100   	Edit='none'     SumText=@sum	SumColor=Black	SumBgColor=#F2A6A6  SumTextAlign=right
											</C>
											<C> Name=�⸻�ڻ갡�� 	ID=LAST_AMT				Align=Right	 Width=100   	Edit='none'		SumText=@sum	SumColor=Black	SumBgColor=#BFB448  SumTextAlign=right
											</C>
											<C> Name='��������'	ID=BEFORE_OLD_DEPREC_AMT		Align=Right	 Width=100   	Edit='none'     SumText=@sum	SumColor=Black	SumBgColor=#FFF270  SumTextAlign=right
											</C>
											<C> Name=���ݰ��Ҿ�   ID=CURR_APPROP_SUB_AMT	Align=Right	 Width=100   	Edit='none'     SumText=@sum	SumColor=Black	SumBgColor=#C4E693  SumTextAlign=right
											</C>
											<C> Name=�����󰢾� 	ID=CURR_DEPREC_AMT		Align=Right	 Width=100   	Edit='none'		SumText=@sum	SumColor=Black	SumBgColor=#F2A6A6  SumTextAlign=right
											</C>
											<C> Name=���ݴ���� 	ID=OLD_DEPREC_AMT		Align=Right	 Width=100   	Edit='none'		SumText=@sum	SumColor=Black	SumBgColor=#BFB448  SumTextAlign=right
											</C>
											<C> Name=��ΰ��� 		ID=BASE_AMT			Align=Right	 Width=100   	Edit='none'		SumText=@sum	SumColor=Black	SumBgColor=#A8C9FF  SumTextAlign=right
											</C>
											<C> Name=������ 		ID=GET_COST_AMT			Align=Right	 Width=100   	Edit='none'     Show='false'	SumText=@sum	SumColor=Black	SumBgColor=#C4E693  SumTextAlign=right
											</C>
											<C> Name='���״���' 	ID=INC_SUM_AMT			Align=Right	 Width=100   	Edit='none'     Show='false'	SumText=@sum	SumColor=Black	SumBgColor=#C4E693  SumTextAlign=right
											</C>
											<C> Name=�����ڵ� 		ID=ACC_CODE				Align=Left	 Width=165   	Edit='none' 	Show='false'
											</C>
											<C> Name=����� 		ID=COMPANY_CODE			Align=Left	 Width=165   	Edit='none' 	Show='false'
											</C>
											
											">
									</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL ������������//-->
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
						
						<table width="100%" height="50%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold"> ȸ�⺰ �󰢾�</td>
											<td align="right" width="*">
												&nbsp;
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
									<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN2 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN2">
										<PARAM NAME="Editable" VALUE="-1">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="Format" VALUE=" 
											<C> Name=��ġ�μ� 		ID=DEPT_NAME	Align=Left	 Width=160   	Edit='none' 	Show='true'		 
											</C>
											<C> Name=�ͼӽ������� 	ID=SUM_DT_FROM	Align=Center	 Width=100   	Edit='none' 	Show='true' 
											</C>
											<C> Name=�ͼ��������� 	ID=SUM_DT_TO	Align=center	 Width=100   	Edit='none' 	Show='true'
											</C>
											<C> Name=�󰢾� 			ID=DEPREC_AMT	Align=Left	 Width=160   	Edit='none' 	Show='true'
											</C>
											
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