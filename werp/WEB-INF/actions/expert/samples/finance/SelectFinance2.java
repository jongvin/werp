/**
 * SelectFinance2.java : [expert.samples.finance] Created on 2005. 1. 10. ¿ÀÈÄ 1:23:18
 * 
 * Copyright (c) 2000-2004 Shift Information & Communication Co.
 * 3F, Seongsu Venture town, 231-1, Seongsu2-Gam Seongdong-Gu, Seoul, Korea 133-826
 * All rights reserved.
 *
 * This software is the confidential and proprietary information of
 * Shift Information & Communication Co. ("Confidential Information").  You shall not
 * disclose such Confidential Information and shall use it only in
 * accordance with the terms of the license agreement you entered into
 * with Shift Information & Communication.
 */
package expert.samples.finance;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;

import com.gauce.common.CommonUtil;
import com.gauce.gsaf.ActionChain;
import com.gauce.gsaf.ActionConfig;
import com.gauce.gsaf.GauceAction;
import com.gauce.http.HttpGauceRequest;

/**
 * @author sunny
 */
public class SelectFinance2 extends GauceAction {
    private String path1;
    private String path2;
    private String path3;
    
    public void init(ActionConfig config) throws ServletException {
        super.init(config);
        path1 = config.getServletContext().getRealPath("sample40/finance/finance2_xchart.dat");
        path2 = config.getServletContext().getRealPath("sample40/finance/finance2_waterfall.dat");
        path3 = config.getServletContext().getRealPath("sample40/finance/finance2_waterfall2.dat");
    }
    
    public void invoke(HttpGauceRequest request, ActionChain chain)
            throws IOException, ServletException {
        
        String parameter = request.getParameter("dsn");        
        FileInputStream is = null;
        if ("2dchart".equalsIgnoreCase(parameter)) {
            is = new FileInputStream(path1);
        } else if ("3dchart".equalsIgnoreCase(parameter)) {
            is = new FileInputStream(path2);
        } else if ("grid1".equalsIgnoreCase(parameter)) {
            is = new FileInputStream(path3);
        }
        String[][] values = CommonUtil.loadCSV(is);
        is.close();
        List l = new ArrayList();
        for (int i = 0; i < values.length; i++) {
            Map m = new HashMap();
            if ("2dchart".equalsIgnoreCase(parameter)) {
	            m.put("DD", values[i][0]);
	            m.put("SILJUK", new Integer(Integer.parseInt(values[i][1])));    
	            m.put("SILJUKL", new Integer(Integer.parseInt(values[i][2]) *544 ));    
	            m.put("INCRATE", new Double(Double.parseDouble(values[i][3])));
	            l.add(m);
            } else if ("3dchart".equalsIgnoreCase(parameter)) {
                m.put("Index", values[i][0]);
                m.put("X", values[i][1]);    
                m.put("Y", values[i][2]);    
                m.put("Z", values[i][3]);
                l.add(m);
            } else if ("grid1".equalsIgnoreCase(parameter)) {
                m.put("Index", values[i][0]);
                m.put("X", new Integer(Integer.parseInt(values[i][1])));    
                m.put("Y", new Double(Double.parseDouble(values[i][2])));
                m.put("Z", new Double(Double.parseDouble(values[i][3])));          
                l.add(m);
            }
        }
        request.setAttribute("SelectFinance2", l);
        chain.invokeNext(request);
    }
    
    public void destroy() {
        System.out.println("SelectFinance2 is being destroyed.");
    }

}
