import java.io.*;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.*;

public class sendFile extends HttpServlet
{
	private String m_from;
	private String m_filename;
	private String m_fileBase;
	private String m_absoluteFileName;

	private HttpServletRequest m_request;
	private HttpServletResponse m_response;

	public void init(ServletConfig config) throws ServletException
  	{
 	   super.init(config);
	}

    public void doPost(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException
    {
    	//초기화를 한다.
    	init_variable(req, res);

	try{
	    	//id와 passwd값을 가져온다.
	    	parseParam();

   		//전송완료 메시지를 보인다.
   		DisplayMSG(null);
   	}catch(Exception e)
   	{
   		//에러 발생시 에러 메시지를 보여 준다.
   		DisplayMSG(e);
   	}
   	finally
   	{
   		clear();
   	}
    }

    private void clear()
    {
		m_from = null;
		m_filename = null;
		m_fileBase = null;
		m_absoluteFileName = null;
    }
    
    private void DisplayMSG(Exception e)
    {
    	try{
	    	m_response.setContentType("text/html; charset=euc-kr");
	        PrintWriter out = m_response.getWriter();
	        if(e == null) {
	        	out.println("\""+m_filename+"\" File을 UPLOAD 하였습니다.");
	        	out.println("Uploader : " + m_from);
	        } else
	        {
	        	out.println("파일을 Upload하는 도중 에러가 발생했습니다.");
	        	out.println("<BR>에러의 이유는 : "+e.toString());
	        }
	    	out.close();
	    }catch(Exception e1){e1.printStackTrace();}
    }

	private void init_variable(HttpServletRequest req, HttpServletResponse res)
	{
		m_from = "";
		m_filename = "";
		//첨부파일을 저장할 위치.
		m_fileBase = "c:\\upfilebox";
 	   	m_request = req;
 	   	m_response = res;
	}


    private boolean parseParam() throws Exception
    {
		//사용자로 부터 입력받은 값을 받아온다.
    	FileUpload fileup=new FileUpload(m_request.getInputStream());

	m_from      = fileup.getParameter("sender");
  		m_filename = a2k(fileup.getFileName());
  		if(m_filename != null)
  		{
  			m_absoluteFileName = m_fileBase+"\\"+System.currentTimeMillis()+m_filename;
			FileOutputStream OutFile = new FileOutputStream(m_absoluteFileName);
			fileup.UpFile(OutFile);
			OutFile.close();
		}
		return true;
    }

	private String a2k(String str)
	{
		if( str != null)
		{
       		String result = null;
	       	try {
            		result = new String(str.getBytes("8859_1"), "KSC5601");
        	}catch (java.io.UnsupportedEncodingException e) {System.err.println(e.toString());}
      		return  result;
      	}
      	else
      		return null;
   	}
}
