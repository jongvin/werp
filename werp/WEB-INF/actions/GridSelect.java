package gauce.samples.grid;

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
public class GridSelect extends GauceAction {
    private String path;
    
    public void init(ActionConfig config) throws ServletException {
        super.init(config);
        path = config.getServletContext().getRealPath("gauce40/grid1.dat");
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
            m.put("deptnm", values[i][0]);     // deptnm
            m.put("year", values[i][1]);    // year
            m.put("amt1", values[i][2]);    // amt1
            m.put("amt2", values[i][3]);    // amt2
            l.add(m);
        }
        request.setAttribute("SelectList", l);
        chain.invokeNext(request);
    }

    public void destroy() {
        System.out.println("GridSelect is being destroyed.");
    }

}
