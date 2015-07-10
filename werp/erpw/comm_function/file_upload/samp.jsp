<%@ page language="java" import="com.daebo.common.*, com.daebo.util.*, com.daebo.database.*, java.io.*" errorPage="Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
	CITData lrReturnData = null;
	String strOut = "";
	String strAct = "";
	String strFileName = "C:\\Project\\DONGRIM\\AdbeRdr70_kor.exe";
	String strMsg = "";

    try
    {
    	CITCommon.initPage(request, response, session, false);
    	
    	strAct = CITCommon.toKOR(request.getParameter("ACT"));
    	
    	if (strAct.equals("DOWNLOAD"))
    	{
    		File lrFile = new File(strFileName);
    		
    		if (lrFile.exists())
    		{
				BufferedInputStream bin = new BufferedInputStream(new FileInputStream(lrFile));
        		BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
				
				response.setHeader("Content-Type", "application/octet-stream");
				response.setHeader("Content-Disposition", "attachment; filename=" + CITCommon.URLEncoding("AdbeRdr70_kor.exe"));
				response.setHeader("Content-Length", Long.toString(lrFile.length()));

                                
				
				byte[] buf = new byte[2048]; //buffer size 2K.
				int read = 0;

                bin.read1(4);
				
				while ((read = bin.read(buf)) != -1)
				{
					bos.write(buf,0,read);
				}
				
				bos.close();
            	bin.close();
    		}
    		else
    		{
    			strMsg = "파일이 존재하지 않습니다.";
    		}
    	}
	}
	catch (Exception ex)
	{
		throw new Exception("페이지 초기화 오류 -> " + ex.getMessage());
	}
%>
