/**
 * Public2Chart.java : [expert.samples.publics] Created on 2005. 1. 12. ¿ÀÈÄ 3:49:2
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
package expert.samples.publics;

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
public class Public2Chart extends GauceAction {

    private String path;
    
    public void init(ActionConfig config) throws ServletException {
        super.init(config);
        path = config.getServletContext().getRealPath("sample40/public/public2_chart.dat");
    }
    
    public void invoke(HttpGauceRequest request, ActionChain chain)
            throws IOException, ServletException {
        
        int cond_year = Integer.parseInt(request.getParameter("cond_year"));  
        int index = Integer.parseInt(request.getParameter("index"));  
        int level = Integer.parseInt(request.getParameter("level"));  
        
        FileInputStream is = new FileInputStream(path);
        String[][] values = CommonUtil.loadCSV(is);
        is.close();
        List l = new ArrayList();
        for (int i = 0; i < values.length; i++) {
            Map m = new HashMap();
            if (level < 3) {
                if (index == 1) {
                    m.put("Yyyymm", values[i][0]);  
                    m.put("A1", new Integer(Integer.parseInt(values[i][1]) *6));    
                    m.put("A2", new Integer(Integer.parseInt(values[i][2]) *2));       
                    m.put("A3", new Integer(Integer.parseInt(values[i][3]) *6));    
                    m.put("A4", new Integer(Integer.parseInt(values[i][4]) *4));   
                    m.put("A5", new Integer(Integer.parseInt(values[i][5]) *4));   
                    m.put("A6", new Integer(Integer.parseInt(values[i][6]) *4));   
                    m.put("A7", new Integer(Integer.parseInt(values[i][7]) *4));     
                    m.put("A8", new Integer(Integer.parseInt(values[i][8]) *5));     
                    m.put("A9", new Integer(Integer.parseInt(values[i][9]) *5));   
                    m.put("A10", new Integer(Integer.parseInt(values[i][10]) *5));   
                    m.put("A11", new Integer(Integer.parseInt(values[i][11]) *5));   
                    m.put("A12", new Integer(Integer.parseInt(values[i][12]) *6));   
                    l.add(m); 
                } else if (index == 2) {
                    m.put("Yyyymm", values[i][0]);  
                    m.put("A1", new Integer(Integer.parseInt(values[i][1]) *4));    
                    m.put("A2", new Integer(Integer.parseInt(values[i][2]) *2));       
                    m.put("A3", new Integer(Integer.parseInt(values[i][3]) *3));    
                    m.put("A4", new Integer(Integer.parseInt(values[i][4]) *2));   
                    m.put("A5", new Integer(Integer.parseInt(values[i][5]) *2));   
                    m.put("A6", new Integer(Integer.parseInt(values[i][6]) *2));   
                    m.put("A7", new Integer(Integer.parseInt(values[i][7]) *2));     
                    m.put("A8", new Integer(Integer.parseInt(values[i][8]) *5));     
                    m.put("A9", new Integer(Integer.parseInt(values[i][9]) *5));   
                    m.put("A10", new Integer(Integer.parseInt(values[i][10]) *4));   
                    m.put("A11", new Integer(Integer.parseInt(values[i][11]) *4));   
                    m.put("A12", new Integer(Integer.parseInt(values[i][12]) *4));   
                    l.add(m); 
                } else if (index == 9) {
                    m.put("Yyyymm", values[i][0]);  
                    m.put("A1", new Integer((int) (Integer.parseInt(values[i][1]) * 1.5)));    
                    m.put("A2", new Integer((int) (Integer.parseInt(values[i][2]) * 1.5)));       
                    m.put("A3", new Integer(Integer.parseInt(values[i][3]) *3));    
                    m.put("A4", new Integer(Integer.parseInt(values[i][4]) *2));   
                    m.put("A5", new Integer(Integer.parseInt(values[i][5]) *3));   
                    m.put("A6", new Integer(Integer.parseInt(values[i][6]) *3));   
                    m.put("A7", new Integer(Integer.parseInt(values[i][7]) *3));     
                    m.put("A8", new Integer(Integer.parseInt(values[i][8]) *3));     
                    m.put("A9", new Integer(Integer.parseInt(values[i][9]) *5));   
                    m.put("A10", new Integer(Integer.parseInt(values[i][10]) *2));   
                    m.put("A11", new Integer(Integer.parseInt(values[i][11]) *2));   
                    m.put("A12", new Integer(Integer.parseInt(values[i][12]) *2));   
                    l.add(m); 
                } else if (index == 14) {
                    m.put("Yyyymm", values[i][0]);  
                    m.put("A1", new Integer((int) (Integer.parseInt(values[i][1]) * 1.5)));    
                    m.put("A2", new Integer((int) (Integer.parseInt(values[i][2]) * 1.5)));       
                    m.put("A3", new Integer(Integer.parseInt(values[i][3]) *2));    
                    m.put("A4", new Integer((int) (Integer.parseInt(values[i][4]) *1.5)));   
                    m.put("A5", new Integer(Integer.parseInt(values[i][5]) *2));   
                    m.put("A6", new Integer(Integer.parseInt(values[i][6]) *3));   
                    m.put("A7", new Integer(Integer.parseInt(values[i][7]) *3));     
                    m.put("A8", new Integer(Integer.parseInt(values[i][8]) *3));     
                    m.put("A9", new Integer(Integer.parseInt(values[i][9]) *2));   
                    m.put("A10", new Integer(Integer.parseInt(values[i][10]) *3));   
                    m.put("A11", new Integer(Integer.parseInt(values[i][11]) *3));   
                    m.put("A12", new Integer(Integer.parseInt(values[i][12]) *3));   
                    l.add(m); 
                } else if (index == 19) {
                    m.put("Yyyymm", values[i][0]);  
                    m.put("A1", new Integer(Integer.parseInt(values[i][1]) * 2));    
                    m.put("A2", new Integer((int) (Integer.parseInt(values[i][2]) * 1.5)));       
                    m.put("A3", new Integer(Integer.parseInt(values[i][3]) *2));    
                    m.put("A4", new Integer((int) (Integer.parseInt(values[i][4]) *1.5)));   
                    m.put("A5", new Integer(Integer.parseInt(values[i][5]) *2));   
                    m.put("A6", new Integer(Integer.parseInt(values[i][6]) *3));   
                    m.put("A7", new Integer(Integer.parseInt(values[i][7]) *3));     
                    m.put("A8", new Integer(Integer.parseInt(values[i][8]) * index));     
                    m.put("A9", new Integer(Integer.parseInt(values[i][9]) * cond_year * 5));   
                    m.put("A10", new Integer(Integer.parseInt(values[i][10]) * cond_year *3));   
                    m.put("A11", new Integer(Integer.parseInt(values[i][11]) *3));   
                    m.put("A12", new Integer(Integer.parseInt(values[i][12]) * cond_year *3));   
                    l.add(m); 
                } else if (index == 24) {
                    m.put("Yyyymm", values[i][0]);  
                    m.put("A1", new Integer(Integer.parseInt(values[i][1]) * 2));    
                    m.put("A2", new Integer(Integer.parseInt(values[i][2]) * 2));       
                    m.put("A3", new Integer(Integer.parseInt(values[i][3]) *2));    
                    m.put("A4", new Integer((int) (Integer.parseInt(values[i][4]) *1.5)));   
                    m.put("A5", new Integer(Integer.parseInt(values[i][5]) *2));   
                    m.put("A6", new Integer(Integer.parseInt(values[i][6]) *2));   
                    m.put("A7", new Integer(Integer.parseInt(values[i][7]) *2));     
                    m.put("A8", new Integer(Integer.parseInt(values[i][8]) * index * 3));     
                    m.put("A9", new Integer(Integer.parseInt(values[i][9]) * cond_year * 2));   
                    m.put("A10", new Integer(Integer.parseInt(values[i][10]) * 2));   
                    m.put("A11", new Integer(Integer.parseInt(values[i][11]) * 2));   
                    m.put("A12", new Integer(Integer.parseInt(values[i][12]) * 2));   
                    l.add(m); 
                }
            } else {
                if (index % 2 == 0) {
                    m.put("Yyyymm", values[i][0]);  
                    m.put("A1", new Integer(Integer.parseInt(values[i][1]) * (level * cond_year)));    
                    m.put("A2", new Integer((int) (Integer.parseInt(values[i][2]) / (1.5 + cond_year))));;       
                    m.put("A3", new Integer((int) Integer.parseInt(values[i][3]) / (index + cond_year)));    
                    m.put("A4", new Integer((int) (Integer.parseInt(values[i][4]) / level)));   
                    m.put("A5", new Integer((int) (Integer.parseInt(values[i][5]) / index)));   
                    m.put("A6", new Integer(Integer.parseInt(values[i][6]) * (level + cond_year)));   
                    m.put("A7", new Integer((int) (Integer.parseInt(values[i][7]) / index )));     
                    m.put("A8", new Integer(Integer.parseInt(values[i][8]) * (level + cond_year)));     
                    m.put("A9", new Integer(Integer.parseInt(values[i][9]) * cond_year));   
                    m.put("A10", new Integer(Integer.parseInt(values[i][10]) * level ));   
                    m.put("A11", new Integer(Integer.parseInt(values[i][11]) * cond_year  ));   
                    m.put("A12", new Integer(Integer.parseInt(values[i][12]) * level));   
                    l.add(m); 
                } else {
                    m.put("Yyyymm", values[i][0]);  
                    m.put("A1", new Integer((int) (Integer.parseInt(values[i][1]) * cond_year / level)));    
                    m.put("A2", new Integer((int) (Integer.parseInt(values[i][2])  / index)));;       
                    m.put("A3", new Integer((int) Integer.parseInt(values[i][3])  / (level * cond_year)));    
                    m.put("A4", new Integer((int) (Integer.parseInt(values[i][4]) / (level * cond_year))));   
                    m.put("A5", new Integer((int) (Integer.parseInt(values[i][5]) / (level * cond_year))));   
                    m.put("A6", new Integer(Integer.parseInt(values[i][6]) * 3));   
                    m.put("A7", new Integer((int) (Integer.parseInt(values[i][7]) / index )));     
                    m.put("A8", new Integer(Integer.parseInt(values[i][8]) * (level + cond_year)));     
                    m.put("A9", new Integer(Integer.parseInt(values[i][9]) * cond_year));   
                    m.put("A10", new Integer(Integer.parseInt(values[i][10]) * level ));   
                    m.put("A11", new Integer(Integer.parseInt(values[i][11]) * cond_year  ));   
                    m.put("A12", new Integer(Integer.parseInt(values[i][12]) * level)); 
                    l.add(m); 
                }
            }     
        }
        request.setAttribute("Public2Chart", l);
        chain.invokeNext(request);
    }

    public void destroy() {
        System.out.println("Public2Chart is being destroyed.");
    }

}
