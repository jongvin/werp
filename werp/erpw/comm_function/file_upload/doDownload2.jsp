<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.io.*,java.util.*,javax.sql.*,javax.naming.InitialContext" errorPage="Error.jsp" contentType="text/html;charset=euc-kr" %>
<%

	String filename = request.getParameter("filename");
	
	CITData lrReturnData = null;
    String strOut = "";
	String strAct = "";
	String strFileName = "C:\\Project\\DONGRIM\\AdbeRdr70_kor.exe";
	String strMsg = "";

    try
    {      
		    CITCommon.initPage(request, response, session, false);

    		File lrFile = new File(strFileName);
    		
    		if (lrFile.exists())
    		{
				BufferedInputStream bin = new BufferedInputStream(new FileInputStream(lrFile));
        		BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
				
				response.setHeader("Content-Type", "application/x-msdownload");
				response.setHeader("Content-Disposition", "attachment; filename=" + filename); /* CITCommon.URLEncoding(filename));*/
				response.setHeader("Content-Length", Long.toString(lrFile.length()));

                                
				
				byte[] buf = new byte[2048]; //buffer size 2K.
				int read = 0;
				
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
	catch (Exception ex)
	{
		throw new Exception("페이지 초기화 오류 -> " + ex.getMessage());
	}
%>
