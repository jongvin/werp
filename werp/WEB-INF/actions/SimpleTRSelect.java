package gauce.samples.tr;

import java.io.IOException;
import java.io.FileInputStream;

import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;

import javax.servlet.ServletException;

import com.gauce.common.CommonUtil;
import com.gauce.http.HttpGauceRequest;
import com.gauce.gsaf.GauceAction;
import com.gauce.gsaf.ActionChain;
import com.gauce.gsaf.ActionConfig;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class SimpleTRSelect extends GauceAction {
    private String path;
    
    public void init(ActionConfig config) throws ServletException {
        super.init(config);
        path = config.getServletContext().getRealPath("gauce40/simple_tr.dat");
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
        for (int i = 0; i < values.length; i++) {
            Map m = new HashMap();
            m.put("emp_name", values[i][0]);     // emp_name
            m.put("emp_id", values[i][1]);    // emp_id
            m.put("emp_code", values[i][2]);    // emp_code
            m.put("emp_hiredate", values[i][3]);    // emp_hiredate
            m.put("emp_age", values[i][4]);    // emp_age
            m.put("emp_pay", values[i][5]);    // emp_pay
            l.add(m);
        }
        request.setAttribute("TRSelectList", l);
        chain.invokeNext(request);
    }

    public void destroy() {
        System.out.println("SimpleTRSelect is being destroyed.");
    }

}
