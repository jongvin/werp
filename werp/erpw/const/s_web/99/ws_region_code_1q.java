
import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;

public class SimpleGet extends HttpGaucelet {
    public void init(String domain) throws GauceletException {
        super.init(domain);
    }
    public void doGet(GauceRequest req, GauceResponse res)
            throws IOException, GauceletException {

		GauceDBConnection conn = null;
		conn = domain.getDBConnection();
 //    String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     GauceDataSet dSet = new GauceDataSet();
     res.enableFirstRow(dSet);
     dSet.addDataColumn(new GauceDataColumn("region_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  y_region_code.region_code ," + 
     "          y_region_code.name     FROM y_region_code     " + 
     "          order by  y_region_code.region_code  ";
    GauceStatement stmt = conn.getGauceStatement(query);
    stmt.executeQuery(dSet);
    stmt.close();
    dSet.flush();
    res.commit("성공적으로 마쳤습니다");
    res.close();
    }
}
