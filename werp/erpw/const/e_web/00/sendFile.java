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
    	//�ʱ�ȭ�� �Ѵ�.
    	init_variable(req, res);

	try{
	    	//id�� passwd���� �����´�.
	    	parseParam();

   		//���ۿϷ� �޽����� ���δ�.
   		DisplayMSG(null);
   	}catch(Exception e)
   	{
   		//���� �߻��� ���� �޽����� ���� �ش�.
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
	        	out.println("\""+m_filename+"\" File�� UPLOAD �Ͽ����ϴ�.");
	        	out.println("Uploader : " + m_from);
	        } else
	        {
	        	out.println("������ Upload�ϴ� ���� ������ �߻��߽��ϴ�.");
	        	out.println("<BR>������ ������ : "+e.toString());
	        }
	    	out.close();
	    }catch(Exception e1){e1.printStackTrace();}
    }

	private void init_variable(HttpServletRequest req, HttpServletResponse res)
	{
		m_from = "";
		m_filename = "";
		//÷�������� ������ ��ġ.
		m_fileBase = "c:\\upfilebox";
 	   	m_request = req;
 	   	m_response = res;
	}


    private boolean parseParam() throws Exception
    {
		//����ڷ� ���� �Է¹��� ���� �޾ƿ´�.
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
