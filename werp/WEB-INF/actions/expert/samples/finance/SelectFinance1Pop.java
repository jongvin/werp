/**
 * SelectFinance1Pop.java : [expert.samples.finance] Created on 2005. 1. 10. ¿ÀÀü 11:14:34
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

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;

import com.gauce.gsaf.ActionChain;
import com.gauce.gsaf.ActionConfig;
import com.gauce.gsaf.GauceAction;
import com.gauce.http.HttpGauceRequest;

/**
 * @author sunny
 */
public class SelectFinance1Pop extends GauceAction {
    
    public void init(ActionConfig config) throws ServletException {
        super.init(config);
    }

    public void invoke(HttpGauceRequest request, ActionChain chain)
            throws IOException, ServletException {
        
    	String arg = request.getParameter("arg");
    	int year = Integer.parseInt(request.getParameter("year"));
    	int month = Integer.parseInt(request.getParameter("month"));
    	
        List list = (List)request.getAttribute("SelectFinance1");
        List l = new ArrayList();

    	int choice = 0;
    	switch (Integer.parseInt(arg)) {
    	    case 10 :
    	        choice = 0 ;
    	        break;
    	    case 20 :
    	        choice = 1 ;
    	        break;
    	    case 30 :
    	        choice = 2 ;
    	        break;
    	    case 40 :
    	        choice = 3 ;
    	        break;
    	    case 50 :
    	        choice = 4 ;
    	        break;
    	    case 60 :
    	        choice = 5;
    	        break;
    	    case 70 :
    	        choice = 6;
    	        break;
    	}
    	
    	Map map = (HashMap)list.get(choice);
        for (int i =0; i < map.size(); i++) {
            Map m = new HashMap();
            m.put("A", (String)map.get("A"));    
            m.put("B", new Integer(Integer.parseInt((String)map.get("B"))*month+year*month));    
            m.put("C", new Integer(Integer.parseInt((String)map.get("C"))*month+year*month));     
            m.put("D", new Integer(Integer.parseInt((String)map.get("D"))*month+year*month));     
            m.put("E", new Integer(Integer.parseInt((String)map.get("E"))*month+year*month));      
            m.put("F", new Integer(Integer.parseInt((String)map.get("F"))*month+year*month));    
            m.put("G", new Integer(Integer.parseInt((String)map.get("G"))*month+year*month));     
            m.put("H", new Integer(Integer.parseInt((String)map.get("H"))*month+year*month));    
            m.put("I",  new Integer(Integer.parseInt((String)map.get("I"))*month+year*month));    
            m.put("J", new Integer(Integer.parseInt((String)map.get("J"))*month+year*month));    
            m.put("K", new Integer(Integer.parseInt((String)map.get("K"))*month+year*month));    
            l.add(m);
        }
        request.setAttribute("SelectFinance1Pop", l);
        chain.invokeNext(request);
    }
    
    public void destroy() {
        System.out.println("SelectFinance1Pop is being destroyed.");
    }
}
