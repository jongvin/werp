/**
 * LogisticsTR.java : [expert.samples.logistics] Created on 2005. 1. 21. ¿ÀÈÄ 1:56:39
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
public class LogisticsTR extends GauceAction {

    private String year;
    private String gubun;

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
    	year = request.getParameter("year");
    	gubun = request.getParameter("gubun");
        chain.invokeNext(request);
    }
    
    public int insertDataset1(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = "insert into T_HM3001(ToSite, FromSite, SC, Category, January, " +
        		"Feburary, March, April, May, June, July, August, September, October, " +
        		"November, December, Yyyy, gubun) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement insert = con.prepareStatement(query);  
        try {            
            insert.setString(1, row.getString(event.indexOfColumn("ToSite")));        
            insert.setString(2, row.getString(event.indexOfColumn("FromSite")));
            insert.setString(3, row.getString(event.indexOfColumn("SC")));
            insert.setString(4, row.getString(event.indexOfColumn("Category")));
            insert.setDouble(5, row.getDouble(event.indexOfColumn("January")));
            insert.setDouble(6, row.getDouble(event.indexOfColumn("Feburary")));
            insert.setDouble(7, row.getDouble(event.indexOfColumn("March")));        
            insert.setDouble(8, row.getDouble(event.indexOfColumn("April")));
            insert.setDouble(9, row.getDouble(event.indexOfColumn("May")));
            insert.setDouble(10, row.getDouble(event.indexOfColumn("June")));
            insert.setDouble(11, row.getDouble(event.indexOfColumn("July")));
            insert.setDouble(12, row.getDouble(event.indexOfColumn("August")));
            insert.setDouble(13, row.getDouble(event.indexOfColumn("September")));        
            insert.setDouble(14, row.getDouble(event.indexOfColumn("October")));
            insert.setDouble(15, row.getDouble(event.indexOfColumn("November")));
            insert.setDouble(16, row.getDouble(event.indexOfColumn("December")));
            insert.setString(17, year);
            insert.setString(18, gubun);
            return insert.executeUpdate();
        } finally {
            insert.close();
        }
    }
    
    public int updateDataset1(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = "UPDATE T_HM3001 SET FromSite = ?, SC = ?, January = ?, Feburary = ?, " +
        		"March = ?, April = ?, May	= ?, June = ?, July = ?, August = ?, September = ?, " +
        		"October = ?, November = ?, December	= ? " +
        		"where ToSite = ? and Category = ? and Yyyy = ?";
        PreparedStatement update = con.prepareStatement(query);
        try {
            update.setString(1, row.getString(event.indexOfColumn("FromSite")));        
            update.setString(2, row.getString(event.indexOfColumn("SC")));
            update.setString(3, row.getString(event.indexOfColumn("January")));
            update.setString(4, row.getString(event.indexOfColumn("Feburary")));
            update.setDouble(5, row.getDouble(event.indexOfColumn("March")));
            update.setDouble(6, row.getDouble(event.indexOfColumn("April")));
            update.setDouble(7, row.getDouble(event.indexOfColumn("May")));        
            update.setDouble(8, row.getDouble(event.indexOfColumn("June")));
            update.setDouble(9, row.getDouble(event.indexOfColumn("July")));
            update.setDouble(10, row.getDouble(event.indexOfColumn("August")));
            update.setDouble(11, row.getDouble(event.indexOfColumn("September")));
            update.setDouble(12, row.getDouble(event.indexOfColumn("October")));
            update.setDouble(13, row.getDouble(event.indexOfColumn("November")));        
            update.setDouble(14, row.getDouble(event.indexOfColumn("December")));
            update.setString(15, row.getString(event.indexOfColumn("ToSite")));
            update.setString(16, row.getString(event.indexOfColumn("Category")));
            update.setString(17, year);
            return update.executeUpdate();
        } finally {
            update.close();
        }
    }
    
    public int deleteDataset1(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = "delete from T_HM3001 where ToSite = ? and Category = ? and Yyyy = ?";
        PreparedStatement delete = con.prepareStatement(query);
        try {
            delete.setString(1, row.getString(event.indexOfColumn("ToSite")));     
            delete.setString(2, row.getString(event.indexOfColumn("Category")));
            delete.setString(3, year);
            return delete.executeUpdate();    
        } finally {
            delete.close();
        }
    }
    
    public int insertDataset2(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = "insert into T_HM3000(ToSite, FromSite, SC, Category, January, " +
        		"Feburary, March, April, May, June, July, August, September, October, " +
                "November, December, Yyyy, gubun) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement insert = con.prepareStatement(query);  
        try {            
            insert.setString(1, row.getString(event.indexOfColumn("ToSite")));        
            insert.setString(2, row.getString(event.indexOfColumn("FromSite")));
            insert.setString(3, row.getString(event.indexOfColumn("SC")));
            insert.setString(4, row.getString(event.indexOfColumn("Category")));
            insert.setString(5, row.getString(event.indexOfColumn("January")));
            insert.setString(6, row.getString(event.indexOfColumn("Feburary")));
            insert.setString(7, row.getString(event.indexOfColumn("March")));        
            insert.setString(8, row.getString(event.indexOfColumn("April")));
            insert.setString(9, row.getString(event.indexOfColumn("May")));
            insert.setString(10, row.getString(event.indexOfColumn("June")));
            insert.setString(11, row.getString(event.indexOfColumn("July")));
            insert.setString(12, row.getString(event.indexOfColumn("August")));
            insert.setString(13, row.getString(event.indexOfColumn("September")));        
            insert.setString(14, row.getString(event.indexOfColumn("October")));
            insert.setString(15, row.getString(event.indexOfColumn("November")));
            insert.setString(16, row.getString(event.indexOfColumn("December")));
            insert.setString(17, year);
            insert.setString(18, gubun);
            return insert.executeUpdate();
        } finally {
            insert.close();
        }
    }
    
    public int updateDataset2(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = "update T_HM3000 set FromSite = ? , SC = ?, January	= ?," +
        		"Feburary = ?, March = ?, April 	= ?, May = ?, June = ?, July = ?, August = ?, " +
        		"September = ?, October = ?, November	= ?, December = ? " +
        		"where ToSite =  ? and Category = ? and YYYY = ?";

        PreparedStatement update = con.prepareStatement(query);
        try {
            update.setString(1, row.getString(event.indexOfColumn("FromSite")));        
            update.setString(2, row.getString(event.indexOfColumn("SC")));
            update.setString(3, row.getString(event.indexOfColumn("January")));
            update.setString(4, row.getString(event.indexOfColumn("Feburary")));
            update.setString(5, row.getString(event.indexOfColumn("March")));
            update.setString(6, row.getString(event.indexOfColumn("April")));
            update.setString(7, row.getString(event.indexOfColumn("May")));        
            update.setString(8, row.getString(event.indexOfColumn("June")));
            update.setString(9, row.getString(event.indexOfColumn("July")));
            update.setString(10, row.getString(event.indexOfColumn("August")));
            update.setString(11, row.getString(event.indexOfColumn("September")));
            update.setString(12, row.getString(event.indexOfColumn("October")));
            update.setString(13, row.getString(event.indexOfColumn("November")));        
            update.setString(14, row.getString(event.indexOfColumn("December")));
            update.setString(15, row.getString(event.indexOfColumn("ToSite")));
            update.setString(16, row.getString(event.indexOfColumn("Category")));
            update.setString(17, year);
            return update.executeUpdate();
        } finally {
            update.close();
        }
    }
    
    public int deleteDataset2(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = "delete from T_HM3000 where ToSite = ? and Category = ? and YYYY = ?";
        PreparedStatement delete = con.prepareStatement(query);
        try {
            delete.setString(1, row.getString(event.indexOfColumn("ToSite")));     
            delete.setString(2, row.getString(event.indexOfColumn("Category")));
            delete.setString(3, year);
            return delete.executeUpdate();    
        } finally {
            delete.close();
        }
    }

}
