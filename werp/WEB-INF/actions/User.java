package gauce.samples.tr;

import java.io.IOException;
import java.io.FileInputStream;

import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;

import javax.servlet.ServletException;

import com.gauce.GauceDataRow;
import com.gauce.common.CommonUtil;
import com.gauce.http.HttpGauceRequest;
import com.gauce.gsaf.GauceAction;
import com.gauce.gsaf.ActionChain;
import com.gauce.gsaf.ActionConfig;
import com.gauce.gsaf.TxEvent;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class User extends GauceAction {
    private String path;
    
    public void init(ActionConfig config) throws ServletException {
        super.init(config);
        path = config.getServletContext().getRealPath("gauce40/tr_o1.dat");
    }
    /* (non-Javadoc)
     * @see com.gauce.gsaf.Action#invoke(com.gauce.http.HttpGauceRequest, com.gauce.gsaf.ActionChain)
     */
    public void invoke(HttpGauceRequest request, ActionChain chain)
            throws IOException, ServletException {
        FileInputStream is = new FileInputStream(path);
        String[][] values = CommonUtil.loadCSV(is);
        is.close();
        List l = new ArrayList();
        String empno = request.getParameter("empno");
        for (int i = 0; i < values.length; i++) {
            if (empno != null) {
                if (!empno.equals(values[i][0]))
                    continue;
                Map m = new HashMap();
                m.put("empno", values[i][0]);     // deptno
                m.put("ename", values[i][1]);    // dname
                m.put("job", values[i][2]);    // job
                m.put("mgr", values[i][3]);    // mgr
                m.put("sal", values[i][4]);    // sal
                m.put("comm", values[i][5]);    // comm
                m.put("deptno", values[i][6]);    // deptno
                l.add(m);
                break;
            }
            Map m = new HashMap();
            m.put("empno", values[i][0]);     // deptno
            m.put("ename", values[i][1]);    // dname
            m.put("job", values[i][2]);    // job
            m.put("mgr", values[i][3]);    // mgr
            m.put("sal", values[i][4]);    // sal
            m.put("comm", values[i][5]);    // comm
            m.put("deptno", values[i][6]);    // deptno
            l.add(m);
        }
        request.setAttribute("UserList", l);
        chain.invokeNext(request);
    }

    public void destroy() {
        System.out.println("User is being destroyed.");
    }

}
