<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WFLDayFundInOutR.jsp.jsp(����ݳ������)
/* 2. ����(�ó�����) : ����ݳ��� ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ����ݳ������ 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-21)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	
	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�	
	String strFileName = "./t_WFLDayFundInOutR";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";
	String strDate = CITDate.getNow(); //("yyyy-MM-DD");
	String strOut = "";
	String strSql = "";
	String strAct = "";
	
	try
	{
		CITCommon.initPage(request, response, session);
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
			var			sDate = "<%= strDate %>";
			// �̺�Ʈ����-------------------------------------------------------------------//
			
		//-->
		</script>
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--><comment id="__NSID__3"><!--CONVPAGE_HEAD ������������//-->
		<object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object>
		<!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script><!--CONVPAGE_HEAD ������������//-->

		<!--CONVPAGE_HEAD ������������//--><comment id="__NSID__13"><!--CONVPAGE_HEAD ������������//-->
		<object id=dsCOPY classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object>
		<!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__13); </script><!--CONVPAGE_HEAD ������������//-->

		<!--CONVPAGE_HEAD ������������//--><comment id="__NSID__2"><!--CONVPAGE_HEAD ������������//-->
		<object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      		<param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  	<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object>
		<!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script><!--CONVPAGE_HEAD ������������//-->
		<!--CONVPAGE_HEAD ������������//--><comment id="__NSID__32"><!--CONVPAGE_HEAD ������������//-->
		<object id="transCOPY"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      		<param name="KeyValue" value="Service1(I:dsCOPY=dsCOPY)">
		  	<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object>
		<!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__32); </script><!--CONVPAGE_HEAD ������������//-->
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
											<td width="100" class=font_green_bold>��������</td>
											<td width="82">
												<input id="txtWORK_DT" type="text"  DATATYPE="DATE" style="width:80px" >
											</td>
											<td width="70">
												<input id="btnWORK_DT" type="button" class="img_btnCalendar_S"  title="�޷�"  onclick="btnWORK_DT_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width=*>&nbsp;</td>
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
											<td class="font_green_bold"> �Ϻ�����ݳ���</td>
											<td align="right" width="*">
												<input id="btnPreView" type="button" class="img_btn2_1" value="����" onclick="btnPreView_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
									<!--CONVPAGE_HEAD ������������//-->
									<comment id="__NSID__1"><!--CONVPAGE_HEAD ������������//-->
									<OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN">
										<PARAM NAME="ColSelect" VALUE="1">
										<PARAM NAME="Editable" VALUE="true">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="Format" VALUE=" 
											<C> Name=���� ID=ITEM_NAME Width=150
											</C>
											<C> Name=�ݾ� ID=AMT Width=200
											</C>
											<C> Name=������� ID=MONTH_AMT Width=200 Value={AMT_B + AMT}
											</C>
											<C> Name=��� ID=REMARKS Width=200
											</C>
											">
									</OBJECT>
									<!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script><!--CONVPAGE_HEAD ������������//-->
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