/**
 * SelectFinance1.java : [expert.samples.finance] Created on 2005. 1. 10. ¿ÀÀü 10:53:16
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
public class SelectFinance1 extends GauceAction {
    
    private String path;
    
    public void init(ActionConfig config) throws ServletException {
        super.init(config);
        path = config.getServletContext().getRealPath("sample40/finance/finance1_data.dat");
    }

    public void invoke(HttpGauceRequest request, ActionChain chain)
            throws IOException, ServletException {
        
        FileInputStream is = new FileInputStream(path);
        String[][] values = CommonUtil.loadCSV(is);
        is.close();
        List l = new ArrayList();
        for (int i = 0; i < values.length; i++) {
            Map m = new HashMap();
            m.put("A", values[i][0]);    
            m.put("B", values[i][1]);    
            m.put("C", values[i][2]);    
            m.put("D", values[i][3]);    
            m.put("E", values[i][4]);    
            m.put("F", values[i][5]);  
            m.put("G", values[i][6]);    
            m.put("H", values[i][7]);    
            m.put("I", values[i][8]);    
            m.put("J", values[i][9]);    
            m.put("K", values[i][10]);  
            l.add(m);
        }
        request.setAttribute("SelectFinance1", l);
        chain.invokeNext(request);
    }
    
    public void destroy() {
        System.out.println("SelectFinance1 is being destroyed.");
    }
}
