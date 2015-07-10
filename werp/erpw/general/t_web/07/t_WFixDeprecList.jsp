<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WFixDeprecList.jsp(������ ����Ȳ)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ������ ����Ȳ 
/* 4. ��  ��  ��  �� :  ����� �ۼ�(2006-01-23)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	String  strDATE  = CITDate.getNow("yyyyMMdd");
	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�	
	String strFileName = "./t_WFixDeprecList";
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
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id=dsASSETCLS classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
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
							<tr> 
								<td height="5"></td>
							</tr>
						</table>
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
											<td width="70">  <input name="txtCOMP_CODE" 		type="text" datatype="han" style="width:68px" 	VALUE="" onblur="txtCOMP_CODE_onblur()"></td>
											<td width="200"> <input name="txtCOMPANY_NAME"	type="text" class="ro"	readOnly style="width:198px"	VALUE=""></td>
											<td width="40">
												<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="�˻�" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="60" class="font_green_bold" >�ڻ걸��</td>
											<td width="62">
												<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL ������������//--><OBJECT id="cboASSET_CLS_CODE" style="width:60" classid=clsid:60109D65-70C0-425c-B3A4-4CB001513C69 VIEWASTEXT codebase="../../../cabfiles/LuxeCombo.cab#version=1,1,0,16">
													<PARAM NAME="ComboStyle" VALUE="5">
													<PARAM NAME="EditExprFormat" VALUE="%;ASSET_CLS_NAME">
													<PARAM name="ListExprFormat" value="%;ASSET_CLS_NAME">
													<PARAM NAME="Index" VALUE="0">
													<PARAM NAME="Sort" VALUE="-1">
													<PARAM NAME="SearchColumn" VALUE="ASSET_CLS_CODE">
													<PARAM NAME="SortColumn" VALUE="ASSET_CLS_CODE">
													<PARAM NAME="BindColumn" VALUE="ASSET_CLS_CODE">
													<PARAM NAME="ComboDataID" VALUE="dsASSETCLS">
												</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL ������������//-->
											</td>
											<td width="20">&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="65" class="font_green_bold">ǰ���ڵ�</td>
											<td width="82"> <input name="txtITEM_CODE" type="text" datatype="han" style="width:80px" VALUE="" onblur="txtITEM_CODE_onblur()"></td>
											<td width="160"> <input name="txtITEM_NAME" type="text" class="ro" readOnly style="width:158px" VALUE=""></td>
											<td width="40">
												<input id="btnITEM_CODE" type="button" class="img_btnFind" value="�˻�" onclick="btnITEM_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width="5">&nbsp;</td>
											<td width="20">&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
									</table>
									
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="65" class="font_green_bold">�۾�����</td>
											<td width="70"> <input name="txtWORK_DT_FROM" type="text" Datatype=date style="width:70px" VALUE="" ></td>
											<td width="20"><input id="btnWORK_DT_FROM" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnWORK_DT_FROM_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
											<td width="12">~</td>
											<td width="70"><input name="txtWORK_DT_TO" type="text" Datatype=date align="Center" style="width:70px" VALUE=""></td>
											<td width="20"><input id="btnWORK_DT_TO" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnWORK_DT_TO_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
											<td width="2">&nbsp;</td>
											<td width="50">
												&nbsp;
											</td>
											<td width="72">&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="60" class="font_green_bold">�� �� ��</td>
											<td> <input name="hiWORK_SEQ" type="Hidden"></td>
											<td width="198"> <input name="txtWORK_NAME" type="text" class="ro" readOnly style="width:241px" ></td>
											<td width="2"></td>
											<td width="40">
												<input id="btnIWORK" type="button" class="img_btnFind" value="�˻�" onclick="btnIWORK_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="55" class="font_green_bold">����</td>
											<td></td>
											<td width="150">
												 <select id=cboDEPREC_DIV  style="WIDTH: 80px" class="input_listbox_default">
												 	<option value=S>�ǻ�
												 	<option value=L>���ǻ�
												 </select>
											</td>
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
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
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
									<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN">
										<PARAM NAME="Editable" VALUE="-1">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<param name=SuppressOption value="3">
										<PARAM NAME="Format" VALUE=" 
											<C> Name=ǰ�� 			ID=ITEM_NAME			Align=CENTER	 Width=100   	Edit='none' Suppress=1  BgColor={Decode(div,'12','yellow', '13','gray','14','blue')} 
											</C>
											<C> Name=�ڻ��ȣ 		ID=ASSET_MNG_NO			Align=Left	 Width=100   	Edit='none'
											</C>
											<C> Name=�ڻ�� 		ID=ASSET_NAME		Align=Left	 Width=160   	Edit='none' 	Show='true'	SumText=' ��  �� :' SubColor='RED'
											</C>
											<C> Name=�����ڻ갡�� 	ID=START_ASSET_AMT		Align=Right	 Width=100   	Edit='none' 	SumText=@sum	SumColor=Black	SumBgColor=#FFF270  SumTextAlign=right
											</C>
											<C> Name=����ڻ����� 	ID=CURR_ASSET_INC_AMT	Align=Right	 Width=100   	Edit='none' 	SumText=@sum	SumColor=Black	SumBgColor=#C4E693  SumTextAlign=right
											</C>
											<C> Name=����ڻ갨�� 	ID=CURR_ASSET_SUB_AMT	Align=Right	 Width=100   	Edit='none'     SumText=@sum	SumColor=Black	SumBgColor=#F2A6A6  SumTextAlign=right
											</C>
											<C> Name=�⸻�ڻ갡�� 	ID=LAST_AMT				Align=Right	 Width=100   	Edit='none'		SumText=@sum	SumColor=Black	SumBgColor=#BFB448  SumTextAlign=right
											</C>
											<C> Name='��������'		ID=BEFORE_OLD_DEPREC_AMT		Align=Right	 Width=100   	Edit='none'     SumText=@sum	SumColor=Black	SumBgColor=#FFF270  SumTextAlign=right
											</C>
											<C> Name=���ݰ��Ҿ�  	 ID=CURR_APPROP_SUB_AMT	Align=Right	 Width=100   	Edit='none'     SumText=@sum	SumColor=Black	SumBgColor=#C4E693  SumTextAlign=right
											</C>
											<C> Name=���󰢾� 		ID=CURR_DEPREC_AMT		Align=Right	 Width=100   	Edit='none'		SumText=@sum	SumColor=Black	SumBgColor=#F2A6A6  SumTextAlign=right
											</C>
											<C> Name=���ݴ���� 	ID=OLD_DEPREC_AMT		Align=Right	 Width=100   	Edit='none'		SumText=@sum	SumColor=Black	SumBgColor=#BFB448  SumTextAlign=right
											</C>
											<C> Name=��ΰ��� 		ID=BASE_AMT				Align=Right	 Width=100   	Edit='none'		SumText=@sum	SumColor=Black	SumBgColor=#A8C9FF  SumTextAlign=right
											</C>
											<C> Name=������ 		ID=GET_COST_AMT			Align=Right	 Width=100   	Edit='none'     Show='false'
											</C>
											<C> Name=����� 			ID=COMPANY_CODE			Align=Left	 Width=165   	Edit='none' 	Show='false'
											</C>
											<C> Name=�����ڵ� 		ID=ACC_CODE				Align=Left	 Width=165   	Edit='none' 	Show='false'
											</C>
											<C> Name=���� 			ID=FIX_ASSET_SEQ		Align=Left	 Width=160   	Edit='none' 	Show='false'
											</C>
											<C> Name=�з��ڵ� 		ID=ASSET_CLS_CODE		Align=Left	 Width=160   	Edit='none' 	Show='false'
											</C>
											<C> Name=ǰ���ڵ� 		ID=ITEM_CODE			Align=Left	 Width=160   	Edit='none' 	Show='false'
											</C>
											<C> Name=ǰ���ڵ� 		ID=ITEM_NM_CODE			Align=Left	 Width=160   	Edit='none' 	Show='false'
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