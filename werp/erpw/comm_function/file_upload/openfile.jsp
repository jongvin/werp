<%@ page language="java" import=" java.io.*" errorPage="" contentType="text/html;charset=euc-kr" %><%@ page import=" java.util.*" 
%>

<%! String file_url; %>

<%
 String fileName = request.getParameter("file_url");
 fileName=new String(fileName.getBytes("8859_1"), "KSC5601");
 file_url = fileName;
 
 String strMsg="";  
 //out.print("abcd");
 try{
			
			//String strFileName=CITCommon.toKOR(request.getParameter("arg_filename"));
			//String strFileName=request.getParameter("arg_filename");
             String strFileName=fileName;
             //String strFileName=fileName;
            //out.print(strFileName);
            
            //File lrFile = new File(CITCommon.URLEncoding(strFileName));
			File lrFile = new File(strFileName);
    		
			
    		if (lrFile.exists())
    		{
				BufferedInputStream bin = new BufferedInputStream(new FileInputStream(lrFile));
        		BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
				response.reset();  //�ݵ�� �� �ؾ���..!!   ���� ���� �յڷ� ������ �߰���(������) => 0D 0A 0D 0A 0D 0A 0D 0A -�� 0D 0A 0D 0A -�� 

					
				//response.setHeader("Content-Description", "File Transfer"); 
                //response.setHeader("Content-Type", "application/force-download"); 

				
				//response.setHeader("Content-Type", "application/octet-stream;charset=UTF-8");
				//response.setHeader("Content-Type", "image/jpeg");
				//response.setHeader("Content-Type", "application/octet-stream;charset=8859_1");
				//response.setHeader("Content-Type", "application/unknown");
				response.setHeader("Content-Type", "application/octet-stream;charset=euc-kr");
				response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(lrFile.getName(), "UTF-8") );
				//response.setHeader("Content-Length", Long.toString(lrFile.length()));

                
				byte[] buf = new byte[8*1024]; //buffer size 2K.
				int read = 0;

                
                //bos2.write(buf,0,8);

				while ((read = bin.read(buf)) != -1)
				{
					//read = bin.read(buf);
					bos.write(buf,0,read);
				}
				
				try{
					bos.flush(); 
					bos.close();
				} catch (Exception ex1) {
					throw new Exception( ex1.getMessage());
			    }
				try{  
            		bin.close();
				} catch (Exception ex2) {
					throw new Exception( ex2.getMessage());
			    }

    		}
    		else
    		{
    			out.print("������ �������� �ʽ��ϴ�.");
    		}
 } catch(Exception ex) {
	//out.print("error");
	//out.print("end");
	throw new Exception( ex.getMessage());
 } 
%>