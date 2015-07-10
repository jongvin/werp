/**
 * Public2Main.java : [expert.samples.publics] Created on 2005. 1. 12. ¿ÀÈÄ 4:22:4
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
public class Public2Main extends GauceAction {

    private String path;
    
    public void init(ActionConfig config) throws ServletException {
        super.init(config);
        path = config.getServletContext().getRealPath("sample40/public/public2_main.dat");
    }
    
    public void invoke(HttpGauceRequest request, ActionChain chain)
            throws IOException, ServletException {
        
        int cond_year = Integer.parseInt(request.getParameter("cond_year"));
        int v_index = Integer.parseInt(request.getParameter("index"));
        int v_level = Integer.parseInt(request.getParameter("level"));
        
        FileInputStream is = new FileInputStream(path);
        String[][] values = CommonUtil.loadCSV(is);
        is.close();
        List l = new ArrayList();
        for (int i = 0; i < values.length; i++) {
            Map m = new HashMap();
            if (v_level < 3) {
                switch(v_index) {
                    case 1:                        
                        m.put("Gubn", values[i][0]);  
                        m.put("Py10", values[i][1]);    
                        m.put("Py11", values[i][2]);       
                        m.put("Py", String.valueOf(Integer.parseInt(values[i][3]) * cond_year*6));    
                        m.put("Amt1", String.valueOf(Integer.parseInt(values[i][4]) * cond_year*2));   
                        m.put("Amt2", String.valueOf(Integer.parseInt(values[i][5]) * cond_year*6));   
                        m.put("Amt3", String.valueOf(Integer.parseInt(values[i][6]) * cond_year*4));   
                        m.put("Amt4", String.valueOf(Integer.parseInt(values[i][7]) * cond_year*4));     
                        m.put("Amt5", String.valueOf(Integer.parseInt(values[i][8]) * cond_year*4));     
                        m.put("Amt6", String.valueOf(Integer.parseInt(values[i][9]) * cond_year*4));   
                        m.put("Amt7", String.valueOf(Integer.parseInt(values[i][10]) * cond_year*5));   
                        m.put("Amt8", String.valueOf(Integer.parseInt(values[i][11]) * cond_year*5));   
                        m.put("Amt9", String.valueOf(Integer.parseInt(values[i][12]) * cond_year*5));   
                        m.put("Amt10", String.valueOf(Integer.parseInt(values[i][13]) * cond_year*6));   
                        m.put("Amt11", String.valueOf(Integer.parseInt(values[i][14]) * cond_year*6));   
                        m.put("Amt12", String.valueOf(Integer.parseInt(values[i][15]) * cond_year*6));     
                        m.put("Color", values[i][16]);     
                        m.put("Branch", values[i][17]);   
                        m.put("Yyyy", values[i][18]);   
                        m.put("Flag", values[i][19]);   
                        m.put("Toinb_client_ip", values[i][20]);   
                        l.add(m); 
                        break;
                    case 2:
                        m.put("Gubn", values[i][0]);  
                        m.put("Py10", values[i][1]);    
                        m.put("Py11", values[i][2]);       
                        m.put("Py", String.valueOf(Integer.parseInt(values[i][3]) * cond_year* 5));    
                        m.put("Amt1", String.valueOf(Integer.parseInt(values[i][4]) * cond_year*3));   
                        m.put("Amt2", String.valueOf(Integer.parseInt(values[i][5]) * cond_year*3));   
                        m.put("Amt3", String.valueOf(Integer.parseInt(values[i][6]) * cond_year*3));   
                        m.put("Amt4", String.valueOf(Integer.parseInt(values[i][7]) * cond_year*3));     
                        m.put("Amt5", String.valueOf(Integer.parseInt(values[i][8]) * cond_year*5));     
                        m.put("Amt6", String.valueOf(Integer.parseInt(values[i][9]) * cond_year*5));   
                        m.put("Amt7", String.valueOf(Integer.parseInt(values[i][10]) * cond_year*4));   
                        m.put("Amt8", String.valueOf(Integer.parseInt(values[i][11]) * cond_year*4));   
                        m.put("Amt9", String.valueOf(Integer.parseInt(values[i][12]) * cond_year*4));   
                        m.put("Amt10", String.valueOf(Integer.parseInt(values[i][13]) * cond_year*4));   
                        m.put("Amt11", String.valueOf(Integer.parseInt(values[i][14]) * cond_year*5));   
                        m.put("Amt12", String.valueOf(Integer.parseInt(values[i][15]) * cond_year*5));     
                        m.put("Color", values[i][16]);     
                        m.put("Branch", values[i][17]);   
                        m.put("Yyyy", values[i][18]);   
                        m.put("Flag", values[i][19]);   
                        m.put("Toinb_client_ip", values[i][20]);
                        l.add(m); 
                        break;
                    case 9:
                        m.put("Gubn", values[i][0]);  
                        m.put("Py10", values[i][1]);    
                        m.put("Py11", values[i][2]);       
                        m.put("Py", String.valueOf(Integer.parseInt(values[i][3]) * cond_year*4));    
                        m.put("Amt1", String.valueOf(Integer.parseInt(values[i][4]) * cond_year*3));   
                        m.put("Amt2", String.valueOf(Integer.parseInt(values[i][5]) * cond_year*3));   
                        m.put("Amt3", String.valueOf(Integer.parseInt(values[i][6]) * cond_year*3));   
                        m.put("Amt4", String.valueOf(Integer.parseInt(values[i][7]) * cond_year*3));     
                        m.put("Amt5", String.valueOf(Integer.parseInt(values[i][8]) * cond_year*4));     
                        m.put("Amt6", String.valueOf(Integer.parseInt(values[i][9]) * cond_year*4));   
                        m.put("Amt7", String.valueOf(Integer.parseInt(values[i][10]) * cond_year*4));   
                        m.put("Amt8", String.valueOf(Integer.parseInt(values[i][11]) * cond_year*2));   
                        m.put("Amt9", String.valueOf(Integer.parseInt(values[i][12]) * cond_year*2));   
                        m.put("Amt10", String.valueOf(Integer.parseInt(values[i][13]) * cond_year*2));   
                        m.put("Amt11", String.valueOf(Integer.parseInt(values[i][14]) * cond_year*2));   
                        m.put("Amt12", String.valueOf(Integer.parseInt(values[i][15]) * cond_year*4));     
                        m.put("Color", values[i][16]);     
                        m.put("Branch", values[i][17]);   
                        m.put("Yyyy", values[i][18]);   
                        m.put("Flag", values[i][19]);   
                        m.put("Toinb_client_ip", values[i][20]); 
                        l.add(m); 
                        break;
                    case 14:
                        m.put("Gubn", values[i][0]);  
                        m.put("Py10", values[i][1]);    
                        m.put("Py11", values[i][2]);       
                        m.put("Py", String.valueOf(Integer.parseInt(values[i][3]) * cond_year*3));    
                        m.put("Amt1", String.valueOf(Integer.parseInt(values[i][4]) * cond_year*2));   
                        m.put("Amt2", String.valueOf(Integer.parseInt(values[i][5]) * cond_year*2));   
                        m.put("Amt3", String.valueOf(Integer.parseInt(values[i][6]) * cond_year*2));   
                        m.put("Amt4", String.valueOf(Integer.parseInt(values[i][7]) * cond_year*2));     
                        m.put("Amt5", String.valueOf(Integer.parseInt(values[i][8]) * cond_year*2));     
                        m.put("Amt6", String.valueOf(Integer.parseInt(values[i][9]) * cond_year*2));   
                        m.put("Amt7", String.valueOf(Integer.parseInt(values[i][10]) * cond_year*2));   
                        m.put("Amt8", String.valueOf(Integer.parseInt(values[i][11]) * cond_year*2));   
                        m.put("Amt9", String.valueOf(Integer.parseInt(values[i][12]) * cond_year*2));   
                        m.put("Amt10", String.valueOf(Integer.parseInt(values[i][13]) * cond_year*2));   
                        m.put("Amt11", String.valueOf(Integer.parseInt(values[i][14]) * cond_year*2));   
                        m.put("Amt12", String.valueOf(Integer.parseInt(values[i][15]) * cond_year*2));     
                        m.put("Color", values[i][16]);     
                        m.put("Branch", values[i][17]);   
                        m.put("Yyyy", values[i][18]);   
                        m.put("Flag", values[i][19]);   
                        m.put("Toinb_client_ip", values[i][20]);   
                        l.add(m); 
                        break;
                    case 19:
                        m.put("Gubn", values[i][0]);  
                        m.put("Py10", values[i][1]);    
                        m.put("Py11", values[i][2]);       
                        m.put("Py", String.valueOf(Integer.parseInt(values[i][3]) * cond_year*2));    
                        m.put("Amt1", String.valueOf(Integer.parseInt(values[i][4]) * cond_year*2));   
                        m.put("Amt2", String.valueOf(Integer.parseInt(values[i][5]) * cond_year*3));   
                        m.put("Amt3", String.valueOf(Integer.parseInt(values[i][6]) * cond_year*3));   
                        m.put("Amt4", String.valueOf(Integer.parseInt(values[i][7]) * cond_year*3));     
                        m.put("Amt5", String.valueOf(Integer.parseInt(values[i][8]) * cond_year*3));     
                        m.put("Amt6", String.valueOf(Integer.parseInt(values[i][9]) * cond_year*3));   
                        m.put("Amt7", String.valueOf(Integer.parseInt(values[i][10]) * cond_year*2));   
                        m.put("Amt8", String.valueOf(Integer.parseInt(values[i][11]) * cond_year*2));   
                        m.put("Amt9", String.valueOf(Integer.parseInt(values[i][12]) * cond_year*2));   
                        m.put("Amt10", String.valueOf(Integer.parseInt(values[i][13]) * cond_year*2));   
                        m.put("Amt11", String.valueOf(Integer.parseInt(values[i][14]) * cond_year*2));   
                        m.put("Amt12", String.valueOf(Integer.parseInt(values[i][15]) * cond_year*2));     
                        m.put("Color", values[i][16]);     
                        m.put("Branch", values[i][17]);   
                        m.put("Yyyy", values[i][18]);   
                        m.put("Flag", values[i][19]);   
                        m.put("Toinb_client_ip", values[i][20]);
                        l.add(m); 
                    case 24:
                        m.put("Gubn", values[i][0]);  
                        m.put("Py10", values[i][1]);    
                        m.put("Py11", values[i][2]);       
                        m.put("Py", String.valueOf(Integer.parseInt(values[i][3]) *3));    
                        m.put("Amt1", String.valueOf(Integer.parseInt(values[i][4]) * cond_year*1.5));   
                        m.put("Amt2", String.valueOf(Integer.parseInt(values[i][5]) * cond_year*1.5));   
                        m.put("Amt3", String.valueOf(Integer.parseInt(values[i][6]) * cond_year*1.5));   
                        m.put("Amt4", String.valueOf(Integer.parseInt(values[i][7]) * cond_year*1.5));     
                        m.put("Amt5", String.valueOf(Integer.parseInt(values[i][8]) * cond_year*2));     
                        m.put("Amt6", String.valueOf(Integer.parseInt(values[i][9]) * cond_year*2));   
                        m.put("Amt7", String.valueOf(Integer.parseInt(values[i][10]) * cond_year*1));   
                        m.put("Amt8", String.valueOf(Integer.parseInt(values[i][11]) * cond_year*1));   
                        m.put("Amt9", String.valueOf(Integer.parseInt(values[i][12]) * cond_year*1));   
                        m.put("Amt10", String.valueOf(Integer.parseInt(values[i][13]) * cond_year*1));   
                        m.put("Amt11", String.valueOf(Integer.parseInt(values[i][14]) * cond_year*1));   
                        m.put("Amt12", String.valueOf(Integer.parseInt(values[i][15]) * cond_year*1));     
                        m.put("Color", values[i][16]);     
                        m.put("Branch", values[i][17]);   
                        m.put("Yyyy", values[i][18]);   
                        m.put("Flag", values[i][19]);   
                        m.put("Toinb_client_ip", values[i][20]); 
                        l.add(m);
                }
            } else {
                if (v_index % 2 == 0) {
                    m.put("Gubn", values[i][0]);  
                    m.put("Py10", values[i][1]);    
                    m.put("Py11", values[i][2]);       
                    m.put("Py", String.valueOf(Integer.parseInt(values[i][3]) * cond_year / v_index + 5000));    
                    m.put("Amt1", String.valueOf(Integer.parseInt(values[i][4]) * cond_year / v_index + 1000));   
                    m.put("Amt2", String.valueOf(Integer.parseInt(values[i][5]) * cond_year / v_index + 5000));   
                    m.put("Amt3", String.valueOf(Integer.parseInt(values[i][6]) * cond_year / v_index + 5000));   
                    m.put("Amt4", String.valueOf(Integer.parseInt(values[i][7]) * cond_year / v_index + 5000));     
                    m.put("Amt5", String.valueOf(Integer.parseInt(values[i][8]) * cond_year / v_index + 5000));     
                    m.put("Amt6", String.valueOf(Integer.parseInt(values[i][9]) * cond_year / v_index + 2000));   
                    m.put("Amt7", String.valueOf(Integer.parseInt(values[i][10])  * cond_year / v_index));   
                    m.put("Amt8", String.valueOf(Integer.parseInt(values[i][11])  * cond_year / v_index));   
                    m.put("Amt9", String.valueOf(Integer.parseInt(values[i][12])  * cond_year / v_index));   
                    m.put("Amt10", String.valueOf(Integer.parseInt(values[i][13])  * cond_year / v_index));   
                    m.put("Amt11", String.valueOf(Integer.parseInt(values[i][14])  * cond_year / v_index));   
                    m.put("Amt12", String.valueOf(Integer.parseInt(values[i][15])  * cond_year / v_index));     
                    m.put("Color", values[i][16]);     
                    m.put("Branch", values[i][17]);   
                    m.put("Yyyy", values[i][18]);   
                    m.put("Flag", values[i][19]);   
                    m.put("Toinb_client_ip", values[i][20]);
                    l.add(m); 
                } else {
                    m.put("Gubn", values[i][0]);  
                    m.put("Py10", values[i][1]);    
                    m.put("Py11", values[i][2]);       
                    m.put("Py", String.valueOf(Integer.parseInt(values[i][3]) * cond_year / v_index - 1000));    
                    m.put("Amt1", String.valueOf(Integer.parseInt(values[i][4]) * cond_year / v_index * 1));   
                    m.put("Amt2", String.valueOf(Integer.parseInt(values[i][5]) * cond_year / v_index * 2));   
                    m.put("Amt3", String.valueOf(Integer.parseInt(values[i][6]) * cond_year / v_index - 1000));   
                    m.put("Amt4", String.valueOf(Integer.parseInt(values[i][7]) * cond_year / v_index - 2000));     
                    m.put("Amt5", String.valueOf(Integer.parseInt(values[i][8]) * cond_year / v_index - 1000));     
                    m.put("Amt6", String.valueOf(Integer.parseInt(values[i][9]) * cond_year / v_index - 3000));   
                    m.put("Amt7", String.valueOf(Integer.parseInt(values[i][10]) * cond_year * 2));   
                    m.put("Amt8", String.valueOf(Integer.parseInt(values[i][11]) * cond_year + 5000));   
                    m.put("Amt9", String.valueOf(Integer.parseInt(values[i][12]) * cond_year + 5000));   
                    m.put("Amt10", String.valueOf(Integer.parseInt(values[i][13]) * cond_year + 5000));   
                    m.put("Amt11", String.valueOf(Integer.parseInt(values[i][14]) * cond_year * 2));   
                    m.put("Amt12", String.valueOf(Integer.parseInt(values[i][15]) * cond_year * 2));     
                    m.put("Color", values[i][16]);     
                    m.put("Branch", values[i][17]);   
                    m.put("Yyyy", values[i][18]);   
                    m.put("Flag", values[i][19]);   
                    m.put("Toinb_client_ip", values[i][20]);
                    l.add(m); 
                }
            }     
        }
        request.setAttribute("Public2Main", l);
        chain.invokeNext(request);
    }

    public void destroy() {
        System.out.println("Public2Main is being destroyed.");
    }

}
