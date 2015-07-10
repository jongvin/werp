/**
 * Insa2Tr.java : [expert.samples.insa] Created on 2005. 1. 20. ¿ÀÈÄ 4:19:47
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
public class Insa2Tr extends GauceAction {
    
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
        String query = " insert into " +
        		"TB_JOB_2 (DEPT_CD, DUTY_CD, DEPLOY_DT, CLOSE_DT, CLOSE_OP, JOB_DESC) " +
        		"values(ltrim(rtrim(?)) ,?,?,?,?,?)";
        PreparedStatement insert = con.prepareStatement(query);  
        try {
            System.out.println(row.size());
            insert.setString(1, row.getString(0));        
            insert.setString(2, row.getString(2));
            insert.setString(3, row.getString(4));
            insert.setString(4, row.getString(5));
            insert.setString(5, row.getString(6));
            insert.setString(6, row.getString(7));
            return insert.executeUpdate();
        } finally {
            insert.close();
        }
    }
    
    public int updateMaster(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = "update TB_JOB_2 " +
        		"set DEPLOY_DT= ?, CLOSE_DT=?, CLOSE_OP=?, JOB_DESC=? " +
        		"where DEPT_CD= ? and DUTY_CD= ?";
        PreparedStatement update = con.prepareStatement(query);
        try {
            update.setString(1, row.getString(4));
            update.setString(2, row.getString(5));
            update.setString(3, row.getString(6));
            update.setString(4, row.getString(7));
            update.setString(5, row.getString(0));     
            update.setString(6, row.getString(2));     
            return update.executeUpdate();
        } finally {
            update.close();
        }
    }
    
    public int deleteMaster(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = "delete from TB_JOB_2 where DEPT_CD=? and DUTY_CD=?";
        PreparedStatement delete = con.prepareStatement(query);
        try {
            delete.setString(1, row.getString(0));     
            delete.setString(2, row.getString(2));
            return delete.executeUpdate();    
        } finally {
            delete.close();
        }
    }
    
}
