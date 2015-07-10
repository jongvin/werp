import java.io.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.PrintStream;
import java.io.PrintWriter;
import CommonUtil.*;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.log.*;
import com.gauce.common.*;
import logF.*;

public class Gauce_fileup extends HttpServlet {

    private ServiceLoader loader    = null;
	private GauceService service    = null;
	private GauceDataSet Gdset      = null;
	private String logFn   			= "edu_demo.log";
	private String logNm            = "[Gauce_file]";
	private GauceRequest g_req      = null;
	private GauceResponse g_res     = null;

    public void doPost(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException  {

		res.setContentType("text/html;charset=ISO-8859-1");
		log.writeLog(logNm,logFn);

		long StartTime = 0;
		long EndTime = 0;

        StartTime = System.currentTimeMillis();

		try {
			loader = new ServiceLoader(req, res);
			service = loader.newService();
			g_req = service.getGauceRequest();
			g_res = service.getGauceResponse();
			Gdset = g_req.getGauceDataSet("POST");

			if (Gdset != null) {
			    GauceDataColumn[] cols = Gdset.getDataColumns();
                GauceDataRow[] rows = Gdset.getDataRows();
                int data_name = Gdset.indexOfColumn("info");
                int data_url  = Gdset.indexOfColumn("File_Url");

                for (int j = 0; j < rows.length; j++) {
                    if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
    					 String d_name = rows[j].getString(data_name);

    					 log.writeLog(File.separator,logFn);

    					 String o_name = d_name.substring(d_name.lastIndexOf(File.separator)+1, d_name.length()).trim();

    					 log.writeLog(o_name,logFn);

    					 InputStream is = (InputStream) rows[j].getInputStream(data_url);
    					 FileOutputStream os = new FileOutputStream("g:/tmp/"+o_name);
    					 //CommonUtil.copy(is, os);
    					 copy(is, os, 5000);
    					 is.close();
    					 os.close();
			        }
			    }
			}
		}catch(Exception e){
			log.writeLog(logNm + e.toString(),logFn);

			StringBuffer strLog = new StringBuffer();

            strLog.append("[").append(req.getRemoteAddr()).append("]");
            strLog.append("[").append(req.getRequestedSessionId()).append("]");
            strLog.append("[error]");
            strLog.append("[").append(this.getClass().getName()).append("]");
			e.printStackTrace();
		}
		g_res.commit("Success");
		g_res.close();

		EndTime = System.currentTimeMillis();

		System.out.println(EndTime - StartTime);
	}

    public static final void copy(InputStream in, OutputStream out) {
        copy(in, out, 1024);
    }

	public static final void copy(InputStream in, OutputStream out, int bufferSize) {
        try {
            synchronized (in) {
                synchronized (out) {
                    byte[] buffer = new byte[bufferSize];
                    while (true) {
                        int bytesRead = in.read(buffer);
                        if (bytesRead == -1) break;
                        out.write(buffer, 0, bytesRead);
                    }
                }
            }
        } catch (IOException ioe) {
            throw new RuntimeException ("Can not copy stream\n\t"+ioe.toString());
        }
    }
}
