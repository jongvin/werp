<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.net.*, java.io.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : �������
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-10-31)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
%>
<%!
	class CITRequestReport implements Runnable
	{
		public boolean isError = false;
		public String Message = "";
		public String ExportType = "";
		public String RunTag = "";
		public String ReportRequestUrl = "";
		public String ReportRequestNo = "";
		public String ExportFileName = "";
		public String RequestName = "";
		public String ReportNo = "";
		public String ConditionPage = "";
		public String ReportFileName = "";
		public String SysID = "";
		public String UserNo = "";
		public String UserId = "";
		public String UserName = "";
		public String Parameters = "";
		
		public JspWriter lrWriter = null;
		
		public CITRequestReport()
		{
		}
		
		public void run()
		{
			try
			{
				CITData lrArgData = new CITData();
				CITData lrReturnData = null;
				
				String strKey = "";
				String strSql = "";
				
				//CITDebug.PrintMessages("Report_Request");
				// ���� ��ȣ
				/*
				try
				{
					lrArgData.removeAll();

					lrArgData.addColumn("CONDITION_PAGE", CITData.VARCHAR2);
					lrArgData.addRow();
					lrArgData.setValue("CONDITION_PAGE", this.ConditionPage);
					
					strSql  = 
						"Select"+"\n"+
						"	a.REPORT_NO "+"\n"+
						"From	T_REPORT a"+"\n"+
						"Where	a.CONDITION_PAGE Like '%' || ? || '%'"+"\n"+
						"And		RowNum < 2";
					
					lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
					
					if (lrReturnData.getRowsCount() < 1) throw new Exception("ReportNo �����ϴ�");
					this.ReportNo = lrReturnData.toString(0, "REPORT_NO");
				}
				catch (Exception ex)
				{
					throw new Exception("SQ_T_REPORT_REQUEST_NO Sequence Select ���� : " + ex.getMessage());
				}
				*/
				this.ReportNo = "0";

				//CITDebug.PrintMessages("this.ReportNo");
				//CITDebug.PrintMessages(this.ReportNo);
				// ���� ��û��ȣ
				try
				{
					lrArgData.removeAll();
					
					strSql  = " Select SQ_T_REPORT_REQUEST_NO.nextval as REPORT_REQUEST_NO ";
					strSql += " From   DUAL ";
					
					lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
					
					if (lrReturnData.getRowsCount() < 1) throw new Exception("ReportRequestNo�� �����ϴ�");
					this.ReportRequestNo = lrReturnData.toString(0, "REPORT_REQUEST_NO");
				}
				catch (Exception ex)
				{
					throw new Exception("SQ_T_REPORT_REQUEST_NO Sequence Select ���� : " + ex.getMessage());
				}
				
				// ���� ExportFileName
				try
				{
					lrArgData.removeAll();
					
					strSql  = " Select TO_CHAR(sysdate,'yyyymmddhhmiss') || TO_CHAR(sysdate+2,'yyyymmdd') || TO_CHAR(" + this.ReportRequestNo + ",'fm00000') as EXPORT_FILE_NAME ";
					strSql += " From   dual ";
					
					lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
					
					if (lrReturnData.getRowsCount() < 1) throw new Exception("ExportFileName�� �����ϴ�");
					
					if (this.ExportType.equals("E"))
					{
						this.ExportFileName = lrReturnData.toString(0, "EXPORT_FILE_NAME") + ".xls";
					}
					else if (this.ExportType.equals("W"))
					{
						this.ExportFileName = lrReturnData.toString(0, "EXPORT_FILE_NAME") + ".doc";
					}
					else
					{
						this.ExportFileName = lrReturnData.toString(0, "EXPORT_FILE_NAME") + ".pdf";
					}
					
				}
				catch (Exception ex)
				{
					throw new Exception("���� ExportFileName ���� : " + ex.getMessage());
				}
				//CITDebug.PrintMessages("this.RunTag");
				//CITDebug.PrintMessages(this.RunTag);
				
				// ���� ��û���� Insert
				if (this.RunTag.equals("2"))
				{
				//CITDebug.PrintMessages("����");
					try
					{
						lrArgData.removeAll();
						
						lrArgData.addColumn("REPORT_REQUEST_NO", CITData.NUMBER);
						lrArgData.addColumn("USER_NO", CITData.VARCHAR2);
						lrArgData.addColumn("REPORT_NO", CITData.NUMBER);
						lrArgData.addColumn("SYS_ID", CITData.VARCHAR2);
						lrArgData.addColumn("REQUEST_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("REQUEST_FILE_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("STATE", CITData.VARCHAR2);
						lrArgData.addRow();
						lrArgData.setValue("REPORT_REQUEST_NO", this.ReportRequestNo);
						lrArgData.setValue("USER_NO", this.UserNo);
						lrArgData.setValue("REPORT_NO", this.ReportNo);
						lrArgData.setValue("SYS_ID", this.SysID);
						lrArgData.setValue("REQUEST_NAME", this.RequestName);
						lrArgData.setValue("REQUEST_FILE_NAME", this.ExportFileName);
						lrArgData.setValue("STATE", "R");
						
				//CITDebug.PrintMessages(CITXml.CITData2XML_CR(lrArgData));
						strSql = "{call SP_T_USER_REPORT_REQUEST_I(?,?,?,?,?,?,?)}";
			
						CITDatabase.executeProcedure(strSql, lrArgData);
					}
					catch (Exception ex)
					{
				//CITDebug.PrintMessages(ex.getMessage());
						throw new Exception("���� ��û���� Insert ���� : " + ex.getMessage());
					}
				}
				
				String lsError = "";
				String lsErrorMessage = "";
				String lsReportRequestNo = "";
				String lsUserNo = "";
				String lsReportNo = "";
				String lsExportFileName = "";
				URL url =  null;
				HttpURLConnection urlConn = null;
				OutputStream os = null;
				// ���� ��û
				try
				{
					url = new URL(this.ReportRequestUrl);
					urlConn = (HttpURLConnection)url.openConnection();
					
					
					urlConn.setDoOutput(true);
					
					urlConn.setRequestMethod("POST");
					
					os = urlConn.getOutputStream();
					
					
					
					strKey  = "REPORT_REQUEST_NO=" + this.ReportRequestNo + "&";
					strKey += "EXPORT_FILE_NAME=" + this.ExportFileName + "&";
					strKey += "EXPORT_TYPE=" + this.ExportType + "&";
					strKey += "REPORT_FILE_NAME=" + this.ReportFileName + "&";
					strKey += "REPORT_NO=" + this.ReportNo + "&";
					strKey += "USER_NO=" + this.UserNo + "&";
					strKey += "USER_ID=" + this.UserId + "&";
					strKey += "USER_NAME=" + CITCommon.URLEncoding(this.UserName) + "&";
					strKey += "PARAMETERS=" + CITCommon.URLEncoding(this.Parameters);
					
					lrWriter.println(strKey);
					
					os.write(strKey.getBytes());
					os.close();
					
					//lsError="a";
					// ��û���
					
					lsError = urlConn.getHeaderField("ERROR");
					
					lsErrorMessage = CITCommon.URLDecoding(urlConn.getHeaderField("ERROR_MESSAGE"));
					lsReportRequestNo = urlConn.getHeaderField("REPORT_REQUEST_NO");
					lsUserNo = urlConn.getHeaderField("USER_NO");
					lsReportNo = urlConn.getHeaderField("REPORT_NO");
					lsExportFileName = urlConn.getHeaderField("EXPORT_FILE_NAME");
					
					if (CITCommon.isNull(lsError)) throw new Exception("�ش� URL�� �������� �ʽ��ϴ�.(" + this.ReportRequestUrl + ")");
				}
				catch (Exception ex)
				{
					if (this.RunTag.equals("2"))
					{
						lsError = "1";
						lsErrorMessage = "���� ��û ���� : " + ex.toString();
						lsReportRequestNo = this.ReportRequestNo;
						lsUserNo = this.UserNo;
						lsReportNo = this.ReportNo;
						lsExportFileName = this.ExportFileName;
					}
					else
					{
						throw new Exception("���� ��û ���� : " + ex.toString() + " üũ:" + os);
					}
				}
				
				// ��û��� Update
				if (this.RunTag.equals("2"))
				{
					try
					{
						lrArgData.removeAll();
						
						lrArgData.addColumn("REPORT_REQUEST_NO", CITData.NUMBER);
						lrArgData.addColumn("USER_NO", CITData.NUMBER);
						lrArgData.addColumn("REPORT_NO", CITData.NUMBER);
						lrArgData.addColumn("STATE", CITData.VARCHAR2);
						lrArgData.addColumn("REMARK", CITData.VARCHAR2);
						lrArgData.addRow();
						lrArgData.setValue("REPORT_REQUEST_NO", lsReportRequestNo);
						lrArgData.setValue("USER_NO", lsUserNo);
						lrArgData.setValue("REPORT_NO", lsReportNo);
						
			    		if (lsError != null && lsError.equals("0"))
						{
							lrArgData.setValue("STATE", "C");
							lrArgData.setValue("REMARK", "");
						}
						else
						{
							lrArgData.setValue("STATE", "E");
							lrArgData.setValue("REMARK", lsErrorMessage);
						}
						
						strSql = "{call SP_T_USER_REPORT_REQUEST_U(?,?,?,?,?)}";
			
						CITDatabase.executeProcedure(strSql, lrArgData);
					}
					catch (Exception ex)
					{
						throw new Exception("��û��� Update ���� : " + ex.getMessage());
					}
				}
				else if (lsError != null && lsError.equals("1"))
				{
					throw new Exception(lsErrorMessage);
				}
			}
			catch (Exception ex)
			{
				this.isError = true;
				this.Message = "CITRequestReport ���� -> " + ex.getMessage();
			}
		}
	}
%>
<%
	CITData lrReturnData = null;
	String strOut = "";
	
	CITRequestReport lrRequestReport = null;
	
	String strAct = "";
	String strExportTag = "";
	String strRunTag = "";
	String strRequestName = "";
	String strConditionPageName = "";
	String strReportNo = "";
	String strReportFileName = "";
	String strSysID = "";
	String strUserNo = "";
	String strUserId = "";
	String strUserName = "";
	String strParameters = "";
	
	String strReportRequestUrl = "";
	String strReportResponseUrl = "";

	try
	{
		CITCommon.initPage(request, response, session, false);
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		// ��������
		//strSysID = session.getAttribute("sys_id") == null ? "0" : session.getAttribute("sys_id").toString();
		strUserNo = session.getAttribute("emp_no") == null ? "0" : session.getAttribute("emp_no").toString();
		strUserId = session.getAttribute("user_id") == null ? "�׽�ƮID" : session.getAttribute("emp_no").toString();
		strUserName = session.getAttribute("name") == null ? "�׽�Ʈ����" : CITCommon.URLEncoding(session.getAttribute("name").toString());
		
			CITDebug.PrintMessages("strUserNo");
			CITDebug.PrintMessages(strUserNo);
		strSysID = "0";
		
		// ���� ���� ������Ƽ
		//strReportRequestUrl = CITCommon.getProperty("report.request.url", "");
		//strReportResponseUrl = CITCommon.getProperty("report.response.url", "");

		strReportRequestUrl = "http://52.2.43.41/WIIS_REPORT/ServiceReport.aspx";
		strReportResponseUrl ="http://52.2.43.41/WIIS_REPORT/Reports_Temp";
		
		// ���� ���� �Ķ����
		strExportTag = CITCommon.toKOR(request.getParameter("EXPORT_TAG"), "P");
		strRunTag = CITCommon.toKOR(request.getParameter("RUN_TAG"), "1");
		strReportNo = CITCommon.toKOR(request.getParameter("REPORT_NO"));
		strConditionPageName = CITCommon.toKOR(request.getParameter("CONDITION_PAGE"));
		strReportFileName = CITCommon.toKOR(request.getParameter("REPORT_FILE_NAME"));
		strRequestName = CITCommon.toKOR(request.getParameter("REQUEST_NAME"));
		strParameters = CITCommon.toKOR(request.getParameter("PARAMETERS"));
		
		if (strAct.equals("REQUEST"))
		{
			strAct = "PROCESS";
			strOut = "frmList.submit();";
		}
		else if (strAct.equals("PROCESS"))
		{
			// Parameters
			if (!CITCommon.isNull(strParameters))
			{
				// Parameters ������
    			String [] arrParams = strParameters.split("&&");
    			String lsTemp = "";
				
    			for (int i = 0; i < arrParams.length; i++)
    			{
    				String [] arrParamsFields = arrParams[i].split("__");
    				
    				if (arrParamsFields.length < 2) throw new Exception("���� Parameter ���� : " + strParameters);
    				
    				String lsServerParamName = arrParamsFields[0];
    				String lsServerParamValue = arrParamsFields[1].replaceAll("\t","").replaceAll("\n","");
    				
    				lsTemp += lsServerParamName + "=" + lsServerParamValue + "\t";
    			}
    			
    			strParameters = lsTemp.substring(0, lsTemp.length() - 1);
    		}
    		
			// Request Report
			lrRequestReport = new CITRequestReport();
			
			lrRequestReport.ExportType = strExportTag;
			lrRequestReport.RunTag = strRunTag;
			lrRequestReport.ReportRequestUrl = response.encodeURL(strReportRequestUrl);
			lrRequestReport.RequestName = strRequestName;
			lrRequestReport.ReportNo = strReportNo;
			lrRequestReport.ConditionPage = strConditionPageName;
			lrRequestReport.ReportFileName = strReportFileName;
			lrRequestReport.SysID = strSysID;
			lrRequestReport.UserNo = strUserNo;
			CITDebug.PrintMessages("lrRequestReport.UserNo");
			CITDebug.PrintMessages(lrRequestReport.UserNo);
			lrRequestReport.UserId = strUserId;
			lrRequestReport.UserName = strUserName;
			lrRequestReport.Parameters = strParameters;
			lrRequestReport.lrWriter = out;
			
			if (strRunTag.equals("1"))
			{
				// ���� ����
				lrRequestReport.run();
				
				if (lrRequestReport.isError)
				{
					throw new Exception(lrRequestReport.Message);
				}
				else
				{
					response.sendRedirect(strReportResponseUrl + "/" + lrRequestReport.ExportFileName);
				}
			}
			else if (strRunTag.equals("2"))
			{
				// ���� ��û
				new Thread(lrRequestReport).start();
				strOut = "window.close();";
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
		<script language="javascript">
		<!--
			function Initialize()
			{
				<%=strOut%>
			}

			// �Լ�����---------------------------------------------------------------------//
			
			// ���� ������ �̺�Ʈ����-------------------------------------------------------//
			
			// �̺�Ʈ����-------------------------------------------------------------------//

		//-->
		</script>
	</head>
	<body onload="C_Initialize()">
		<form name="frmList" action="t_WCcReportRequestProcess.jsp" target="_self" method="post">
			<input type='hidden' name='ACT' value="<%=strAct%>">
			<input type='hidden' name='KEY' value="">
			<input type='hidden' name='EXPORT_TAG' value="<%=strExportTag%>">
			<input type='hidden' name='RUN_TAG' value="<%=strRunTag%>">
			<input type='hidden' name='REQUEST_NAME' value="<%=strRequestName%>">
			<input type='hidden' name='REPORT_NO' value="<%=strReportNo%>">
			<input type='hidden' name='CONDITION_PAGE' value="<%=strConditionPageName%>">
			<input type='hidden' name='REPORT_FILE_NAME' value="<%=strReportFileName%>">
			<input type='hidden' name='PARAMETERS' value="<%=strParameters%>">
		</form>

		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
			<tr height="*"> 
				<td width="100%" height="100%" align="center">���� ��û��...</td>
			</tr>
		</table>
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