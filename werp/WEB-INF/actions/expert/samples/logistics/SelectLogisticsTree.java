/**
 * SelectLogisticsTree.java : [expert.samples.logistics] Created on 2005. 1. 11. ¿ÀÈÄ 3:33:29
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
package expert.samples.logistics;

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
public class SelectLogisticsTree extends GauceAction {

    private String path;
    
    public void init(ActionConfig config) throws ServletException {
        super.init(config);
        path = config.getServletContext().getRealPath("sample40/logistics/tree.dat");
    }
    
    public void invoke(HttpGauceRequest request, ActionChain chain)
            throws IOException, ServletException {
        FileInputStream is = new FileInputStream(path);
        String[][] values = CommonUtil.loadCSV(is);
        is.close();
        List l = new ArrayList();
        for (int i = 0; i < values.length; i++) {
            Map m = new HashMap();
            m.put("V_level", values[i][0]);  
            m.put("V_title", values[i][1]);    
            m.put("V_type", values[i][2]);    
            m.put("V_index", values[i][3]);  
            m.put("ImgC", values[i][4]);
            m.put("ImgD", values[i][5]);
            m.put("ImgO", values[i][4]);
            m.put("A", values[i][5]);    
            l.add(m);            
        }
        request.setAttribute("SelectLogisticsTree", l);
        chain.invokeNext(request);
    }

    public void destroy() {
        System.out.println("SelectLogisticsTree is being destroyed.");
    }
}
