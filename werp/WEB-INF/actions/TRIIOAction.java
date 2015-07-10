package gauce.samples.tr;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletException;

import com.gauce.GauceDataSet;
import com.gauce.GauceDataRow;
import com.gauce.http.HttpGauceRequest;
import com.gauce.gsaf.GauceAction;
import com.gauce.gsaf.ActionChain;
import com.gauce.gsaf.ActionConfig;
import com.gauce.gsaf.TxEvent;
import com.gauce.io.GauceInputStream;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import javax.sql.DataSource;

public class TRIIOAction extends GauceAction {
    
    public void init() throws ServletException {

    }

    public void invoke(HttpGauceRequest request, ActionChain chain)
            throws IOException, ServletException {

        Connection con = null;
        try {
            DataSource ds = (DataSource) request.getAttribute("GauceDB");
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
    
    public int insertUser(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = "insert into emp(empno, ename, job, mgr, sal, comm, deptno) values(?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement insert = con.prepareStatement(query);  
        try {
            insert.setInt(1, row.getInt(0));        // empno
            insert.setString(2, row.getString(1));// ename
            insert.setString(3, row.getString(2));// job
            insert.setInt(4, row.getInt(3));        // mgr
            insert.setInt(5, row.getInt(4));        // sal
            insert.setInt(6, row.getInt(5));        // comm
            insert.setInt(7, row.getInt(6));        // deptno
            return insert.executeUpdate();
        } finally {
            insert.close();
        }
    }
    
    public int updateUser(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = "update emp set empno=?, ename=?, job=?, mgr=?, sal=?, comm=?, deptno=? where empno=?";
        PreparedStatement update = con.prepareStatement(query);
        try {
            update.setInt(1, row.getInt(0));        // empno
            update.setString(2, row.getString(1));// ename
            update.setString(3, row.getString(2));// job
            update.setInt(4, row.getInt(3));        // mgr
            update.setInt(5, row.getInt(4));        // sal
            update.setInt(6, row.getInt(5));        // comm
            update.setInt(7, row.getInt(6));        // deptno
            update.setInt(8, row.getInt(0));        // empno
            return update.executeUpdate();
        } finally {
            update.close();
        }
    }
    
    public int deleteUser(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = "delete from emp where empno=?";
        PreparedStatement delete = con.prepareStatement(query);
        try {
            delete.setInt(1, row.getInt(0));        // empno
            return delete.executeUpdate();    
        } finally {
            delete.close();
        }
    }
    
    public int insertGroup(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = "insert into dept(deptno, dname, loc) values(?, ?, ?)";
        PreparedStatement insert = con.prepareStatement(query);
        try {
            insert.setInt(1, row.getInt(0));        // deptno
            insert.setString(2, row.getString(1));// dname
            insert.setString(3, row.getString(2));// loc
            return insert.executeUpdate();
        } finally {
            insert.close();
        }
    }
    
    public int updateGroup(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = "update dept set deptno=?, dname=?, loc=? where deptno=?";
        PreparedStatement update = con.prepareStatement(query);
        try {
            update.setInt(1, row.getInt(0));        // deptno
            update.setString(2, row.getString(1));// dname
            update.setString(3, row.getString(2));// loc
            update.setInt(4, row.getInt(0));        // deptno
            int result =  update.executeUpdate();
            return result;
        } finally {
            update.close();
        }
    }

    public int deleteGroup(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = "delete from dept where deptno=?";
        PreparedStatement delete = con.prepareStatement(query);
        try {
            delete.setInt(1, row.getInt(0));        // empno
            return delete.executeUpdate();    
        } finally {
            delete.close();
        }
    }
}
