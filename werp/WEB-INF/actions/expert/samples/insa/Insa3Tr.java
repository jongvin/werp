/**
 * Insa3Tr.java : [expert.samples.insa] Created on 2005. 1. 12. ¿ÀÀü 11:23:50
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
package expert.samples.insa;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.sql.DataSource;

import com.gauce.GauceDataRow;
import com.gauce.gsaf.ActionChain;
import com.gauce.gsaf.GauceAction;
import com.gauce.gsaf.TxEvent;
import com.gauce.http.HttpGauceRequest;

/**
 * @author sunny
 */
public class Insa3Tr extends GauceAction {

    public void invoke(HttpGauceRequest request, ActionChain chain)
            throws IOException, ServletException {
        
        Connection con = null;
        try {
            DataSource ds = (DataSource) request.getAttribute("GauceDB$sampledb");
            con = ds.getConnection();
            fireTxEvent(request, con);
        } catch (SQLException sqle) {
            throw new ServletException("Failed to execute transaction", sqle);
        } finally {
            if (con != null) {
                try { con.close(); } catch (Exception e) {}
            }
        }        
        chain.invokeNext(request);
    }
    
    public int insertMaster(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = "insert into TB_SALES_3 " +
        		"(SALESDEPT_CD, CHARGE_CD, YYYY, SALES_AMT, SALES_CNT, PROFIT_AMT, COST_AMT) " +
        		"values (ltrim (rtrim(?)) ,?,?,?,?,?,?)";
        PreparedStatement insert = con.prepareStatement(query);  
        try {
            insert.setString(1, row.getString(0));        
            insert.setString(2, row.getString(1));
            insert.setString(3, row.getString(2));
            insert.setDouble(4, row.getDouble(3));
            insert.setDouble(5, row.getDouble(4));
            insert.setDouble(6, row.getDouble(5));
            insert.setDouble(7, row.getDouble(6));
            return insert.executeUpdate();
        } finally {
            insert.close();
        }
    }
    
    public int updateMaster(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = "update TB_SALES_3 " +
        		"set SALES_AMT=?, SALES_CNT=?, PROFIT_AMT=?, COST_AMT=?  " +
        		"where SALESDEPT_CD=? and CHARGE_CD=? and YYYY=?";
        PreparedStatement update = con.prepareStatement(query);
        try {
            update.setDouble(1, row.getDouble(3));
            update.setDouble(2, row.getDouble(4));
            update.setDouble(3, row.getDouble(5));
            update.setDouble(4, row.getDouble(6));
            update.setString(5, row.getString(0));     
            update.setString(6, row.getString(1));     
            update.setString(7, row.getString(2));        
            return update.executeUpdate();
        } finally {
            update.close();
        }
    }
    
    public int deleteMaster(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = "delete from TB_SALES_3 " +
        		"where SALESDEPT_CD=?  and CHARGE_CD=? and YYYY=?";
        PreparedStatement delete = con.prepareStatement(query);
        try {
            delete.setString(1, row.getString(0));     
            delete.setString(2, row.getString(1));     
            delete.setString(3, row.getString(2));        
            return delete.executeUpdate();    
        } finally {
            delete.close();
        }
    }

}
