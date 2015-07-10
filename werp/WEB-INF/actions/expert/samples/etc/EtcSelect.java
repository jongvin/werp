/**
 * EtcSelect.java : [expert.samples.etc] Created on 2005. 1. 10. ¿ÀÈÄ 4:15:16
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
package expert.samples.etc;

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
public class EtcSelect extends GauceAction {

    private String path;
    
    public void init(ActionConfig config) throws ServletException {
        super.init(config);
        path = config.getServletContext().getRealPath("sample40/etc/crosstab.csv");
    }
    
    public void invoke(HttpGauceRequest request, ActionChain chain)
            throws IOException, ServletException {        
        
        FileInputStream is = new FileInputStream(path);
        String[][] values = CommonUtil.loadCSV(is);
        is.close();
        List l = new ArrayList();
        for (int i = 0; i < values.length; i++) {
            Map m = new HashMap();            
            m.put("Partno", values[i][0]);
            m.put("Partnm", values[i][1]);    
            m.put("Month", values[i][2]);
            m.put("Qty", values[i][3]);
            m.put("Amt", values[i][4]);
            l.add(m);
        }
        request.setAttribute("EtcSelect", l);
        chain.invokeNext(request);
    }
    
    public void destroy() {
        System.out.println("EtcSelect is being destroyed.");
    }

}
