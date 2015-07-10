<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.io.*, com.oreilly.servlet.*, com.oreilly.servlet.multipart.*" errorPage="Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/***************************************************/
/* �� ���α׷��� �뺸�ý���(��) �� ����Դϴ�.
/* �����ۼ��� : ������
/* �����ۼ��� : 2005-06-24
/* ���������� : 
/* ���������� : 
/***************************************************/
	
	CITData lrReturnData = null;
	Connection conn = null;
	
	MultipartRequest multi = null;
	
	String strAct = "";
	String strSql = "";
	
	String strUserNo = "";
	String strUserName = "";
	
	String strEmpNo = "";
	String strImageFileName = "";
	String strNewFileName = "";
	String strResult = "";
	String strErrMsg = "";
	
	String strFilePath = "";
	String strImageUrl = "";
	int sizeLimit = 1024 * 1024 * 50;
	
	try
	{
		CITCommon.initPage(request, response, session);
		/* �������� */
		strUserNo = session.getAttribute("user_no") == null ? "" : session.getAttribute("user_no").toString();
		strUserName = session.getAttribute("user_nm") == null ? "" : session.getAttribute("user_nm").toString();
		
		conn = CITConnectionManager.getConnection(false);
		
		strFilePath = CITCommon.getProperty("hrms.image.dir");
		strImageUrl = CITCommon.getProperty("hrms.image.url");
		
		if (CITCommon.isNull(strFilePath))
		{
			throw new Exception("USER-900002:ȯ�漳�� ���� -> ȯ�漳�� ����(server.conf)�� 'hrms.image.dir'��(��) �������� �ʾҽ��ϴ�.");
		}
		
		if (CITCommon.isNull(strImageUrl))
		{
			throw new Exception("USER-900002:ȯ�漳�� ���� -> ȯ�漳�� ����(server.conf)�� 'hrms.image.url'��(��) �������� �ʾҽ��ϴ�.");
		}
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		strEmpNo = CITCommon.toKOR(request.getParameter("EMP_NO"));
		
		if (strAct.equals("VIEW") || strAct.equals("ADD") || strAct.equals("DEL"))
		{
			try
			{
				CITData lrArgData = new CITData();
				
				strSql  = " Select FILE_NAME ";
				strSql += " From   THR_PICTURE_MNG ";
				strSql += " Where  EMP_NO = ? ";
				
				lrArgData.addColumn("EMP_NO", CITData.NUMBER);
				lrArgData.addRow();
				lrArgData.setValue("EMP_NO",  strEmpNo);
				
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData, conn);
				
				if (lrReturnData != null && lrReturnData.getRowsCount() > 0 && !CITCommon.isNull(lrReturnData.toString(0, "FILE_NAME")))
				{
					strImageFileName = lrReturnData.toString(0, "FILE_NAME");
				}
			}
			catch (Exception ex)
			{
				throw new Exception("USER-900002:��� �̹��� ���� Select ���� -> " + ex.getMessage());
			}
			
			if (strAct.equals("ADD") || strAct.equals("DEL"))
			{
				try
				{
					// ��Ͻ� : ������ ��ϵ� �̹��� �����ϰ� �� ����Ѵ�.
					// ������ : ��ϵ� �̹��� ����
					File lrFile = new File(strFilePath + "\\" + strImageFileName);
					
					if (lrFile.exists() && lrFile.isFile())
					{
						lrFile.delete();
					}
					
					if (strAct.equals("ADD"))
					{
						multi = new MultipartRequest(request, strFilePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());
						
						strImageFileName = CITCommon.NvlString(multi.getFilesystemName("PhotoFileName"));
						
						// ���ο� �̹��� ���ϸ� �� ���ϰ�ü ����
						strNewFileName = strFilePath + "\\" + CITDate.getNow("yyyyMMddHHmmssS") + "_" + strEmpNo + strImageFileName.substring(strImageFileName.lastIndexOf("."));
						File lrImageFile = new File(strNewFileName);
						
						// ���ο� �̹��� ���ϸ����� ����
						multi.getFile("PhotoFileName").renameTo(lrImageFile);
						
						// ����� �̹��� ���ϸ����� ����
						strImageFileName = lrImageFile.getName();
					}
					else if (strAct.equals("DEL"))
					{
						strImageFileName = "";
					}
				}
				catch (Exception ex)
				{
					throw new Exception("USER-900002:�̹��� ���� �� ���� ���� -> " + ex.getMessage());
				}
				
				try
				{
					CITData lrArgData = new CITData();
					
					strSql  = " Update THR_PICTURE_MNG ";
					strSql += " Set    MODUSERNO = ?, ";
					strSql += "        MODDATE = sysdate, ";
					strSql += "        FILE_NAME = ? ";
					strSql += " Where  EMP_NO = ? ";
		
					lrArgData.addColumn("MODUSERNO", CITData.NUMBER);
					lrArgData.addColumn("FILE_NAME", CITData.VARCHAR2);
					lrArgData.addColumn("EMP_NO", CITData.NUMBER);
					lrArgData.addRow();
					lrArgData.setValue("MODUSERNO", strUserNo);
					lrArgData.setValue("FILE_NAME", strImageFileName);
					lrArgData.setValue("EMP_NO", strEmpNo);
					
					CITDatabase.updateQuery(strSql, lrArgData, conn);
				}
				catch (Exception ex)
				{
					throw new Exception("USER-900002:�̹��� ���� ���� ���� -> " + ex.getMessage());
				}
			}
		}
		
		conn.commit();
		
		strResult = "OK";
	}
	catch (Exception ex)
	{
		strResult = "ERR";
		strErrMsg = ex.getMessage();
		//throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
	}
	finally
	{
		try
		{
			CITConnectionManager.freeConnection(conn);
		}
	    catch (Exception ex)
	    {
	    	throw new Exception("SYS-100002:������ ���� ���� -> " + ex.getMessage());
	    }
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title><%=CITCommon.getProperty("company.name")%> - <%=CITCommon.getProperty("application.name")%></title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript">
		<!--
			var strAct = "<%=strAct%>";
			var strImageUrl = "<%=strImageUrl%>";
			var strImageFileName = "<%=strImageFileName%>";
			var strResult = "<%=strResult%>";
			
			function Initialize()
			{
				document.body.topMargin = 0;
				document.body.leftMargin = 0;
				
				if (strResult != "OK")
				{
					C_msgError("<%=strErrMsg%>");
					return;
				}
				
				Photo.src = strImageUrl + "/" + strImageFileName;
			}
			
			// �Լ�����---------------------------------------------------------------------//

			// ���� ������ �̺�Ʈ����-------------------------------------------------------//
			
		//-->
		</script>
	</head>
	<body onload="Initialize()">
		<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td width="100%" height="100%"><img name="Photo" src="" width="100%" height="100%"></td>
			</tr>
		</table>
	</body>
</html>
