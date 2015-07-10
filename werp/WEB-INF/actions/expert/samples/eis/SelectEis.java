/**
 * SelectEis.java : [expert.samples.eis] Created on 2005. 1. 10. ¿ÀÈÄ 4:29:25
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
package expert.samples.eis;

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
public class SelectEis extends GauceAction {

    private String eis1_00_path;
    private String eis1_01_path;
    private String eis1_02_path;
    private String eis1_03_path;
    private String eis1_04_path;
    private String eis1_05_path;
    private String eis1_06_path;
    private String eis1_07_path;
    private String eis1_10_path;
    private String eis1_11_path;
    private String eis1_12_path;
    private String eis1_13_path;
    private String eis1_14_path;
    private String eis1_15_path;
    private String eis1_16_path;
    private String eis1_17_path;    
    
    public void init(ActionConfig config) throws ServletException {
        super.init(config);
        eis1_00_path = config.getServletContext().getRealPath("sample40/eis/eis1_00.dat");
        eis1_01_path = config.getServletContext().getRealPath("sample40/eis/eis1_01.dat");
        eis1_02_path = config.getServletContext().getRealPath("sample40/eis/eis1_02.dat");
        eis1_03_path = config.getServletContext().getRealPath("sample40/eis/eis1_03.dat");
        eis1_04_path = config.getServletContext().getRealPath("sample40/eis/eis1_04.dat");
        eis1_05_path = config.getServletContext().getRealPath("sample40/eis/eis1_05.dat");
        eis1_06_path = config.getServletContext().getRealPath("sample40/eis/eis1_06.dat");
        eis1_07_path = config.getServletContext().getRealPath("sample40/eis/eis1_07.dat");
        eis1_10_path = config.getServletContext().getRealPath("sample40/eis/eis1_10.dat");
        eis1_11_path = config.getServletContext().getRealPath("sample40/eis/eis1_11.dat");
        eis1_12_path = config.getServletContext().getRealPath("sample40/eis/eis1_12.dat");
        eis1_13_path = config.getServletContext().getRealPath("sample40/eis/eis1_13.dat");
        eis1_14_path = config.getServletContext().getRealPath("sample40/eis/eis1_14.dat");
        eis1_15_path = config.getServletContext().getRealPath("sample40/eis/eis1_15.dat");
        eis1_16_path = config.getServletContext().getRealPath("sample40/eis/eis1_16.dat");
        eis1_17_path = config.getServletContext().getRealPath("sample40/eis/eis1_17.dat");        
    }
    
    public void invoke(HttpGauceRequest request, ActionChain chain)
            throws IOException, ServletException {
        
        String parameter = request.getParameter("dsn");
        FileInputStream is = null;
        if ("ds3".equalsIgnoreCase(parameter)) {
            is = new FileInputStream(eis1_00_path);
        } else if ("ds3_1".equalsIgnoreCase(parameter)) {
            is = new FileInputStream(eis1_01_path);
        } else if ("ds3_2".equalsIgnoreCase(parameter)) {
            is = new FileInputStream(eis1_02_path);
        } else if ("ds3_3".equalsIgnoreCase(parameter)) {
            is = new FileInputStream(eis1_03_path);
        } else if ("ds3_4".equalsIgnoreCase(parameter)) {
            is = new FileInputStream(eis1_04_path);
        } else if ("ds3_5".equalsIgnoreCase(parameter)) {
            is = new FileInputStream(eis1_05_path);
        } else if ("ds3_6".equalsIgnoreCase(parameter)) {
            is = new FileInputStream(eis1_06_path);
        } else if ("ds3_7".equalsIgnoreCase(parameter)) {
            is = new FileInputStream(eis1_07_path);
        } else if ("ds4".equalsIgnoreCase(parameter)) {
            is = new FileInputStream(eis1_10_path);
        } else if ("ds4_1".equalsIgnoreCase(parameter)) {
            is = new FileInputStream(eis1_11_path);
        } else if ("ds4_2".equalsIgnoreCase(parameter)) {
            is = new FileInputStream(eis1_12_path);
        } else if ("ds4_3".equalsIgnoreCase(parameter)) {
            is = new FileInputStream(eis1_13_path);
        } else if ("ds4_4".equalsIgnoreCase(parameter)) {
            is = new FileInputStream(eis1_14_path);
        } else if ("ds4_5".equalsIgnoreCase(parameter)) {
            is = new FileInputStream(eis1_15_path);
        } else if ("ds4_6".equalsIgnoreCase(parameter)) {
            is = new FileInputStream(eis1_16_path);
        } else if ("ds4_7".equalsIgnoreCase(parameter)) {
            is = new FileInputStream(eis1_17_path);
        }
        
        String[][] values = CommonUtil.loadCSV(is);
        is.close();
        List l = new ArrayList();
        for (int i = 0; i < values.length; i++) {
            Map m = new HashMap();            
            if ("ds3".equalsIgnoreCase(parameter)) {                
                m.put("gubun", values[i][0]);
                m.put("purpose", new Integer(Integer.parseInt(values[i][1])));    
                m.put("siljuktoday", new Integer(Integer.parseInt(values[i][2])));
                m.put("siljuksum", new Integer(Integer.parseInt(values[i][3])));
                m.put("approach", new Integer(Integer.parseInt(values[i][4])));
                m.put("achieve", new Integer(Integer.parseInt(values[i][5])));
                m.put("beyearcont", new Integer(Integer.parseInt(values[i][6])));    
                m.put("bemonthcont", new Integer(Integer.parseInt(values[i][7])));
                m.put("Color", values[i][8]);                
                l.add(m);
            } else if ("ds4".equalsIgnoreCase(parameter)) {
                m.put("gubun", values[i][0]);
                m.put("selling", new Integer(Integer.parseInt(values[i][1])));    
                m.put("composeper", new Integer(Integer.parseInt(values[i][2])));    
                m.put("growper", new Integer(Integer.parseInt(values[i][3])));
                m.put("humanper", new Integer(Integer.parseInt(values[i][4])));
                m.put("proA", new Integer(Integer.parseInt(values[i][5])));
                m.put("proB", new Integer(Integer.parseInt(values[i][6])));
                m.put("proC", new Integer(Integer.parseInt(values[i][7])));
                l.add(m);
            } else if("ds3_1".equalsIgnoreCase(parameter) 
                    || "ds3_2".equalsIgnoreCase(parameter) || "ds3_3".equalsIgnoreCase(parameter)
                    || "ds3_4".equalsIgnoreCase(parameter) || "ds3_5".equalsIgnoreCase(parameter)
                    || "ds3_6".equalsIgnoreCase(parameter) || "ds3_7".equalsIgnoreCase(parameter)) {                
                m.put("gubun", values[i][0]);
                m.put("stand", values[i][1]);    
                m.put("achieveper", values[i][2]);    
                m.put("growper", values[i][3]);
                l.add(m);                             
            } else if("ds4_1".equalsIgnoreCase(parameter) 
                    || "ds4_2".equalsIgnoreCase(parameter) || "ds4_3".equalsIgnoreCase(parameter)
                    || "ds4_4".equalsIgnoreCase(parameter) || "ds4_5".equalsIgnoreCase(parameter)
                    || "ds4_6".equalsIgnoreCase(parameter) || "ds4_7".equalsIgnoreCase(parameter)) {
                m.put("gubun", values[i][0]);
                m.put("selling", values[i][1]);    
                m.put("composeper", values[i][2]);    
                m.put("growper", values[i][3]);
                m.put("humanper", values[i][4]);
                l.add(m);                
            }
        }
        request.setAttribute("SelectEis", l);
        chain.invokeNext(request);
    }
    
    public void destroy() {
        System.out.println("SelectEis is being destroyed.");
    }

}
