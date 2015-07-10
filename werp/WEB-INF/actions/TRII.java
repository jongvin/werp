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
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;


public class TRII extends GauceAction {
    
    public void init() throws ServletException {

    }

    public void invoke(HttpGauceRequest request, ActionChain chain)
            throws IOException, ServletException {
        fireTxEvent(request, null);

        chain.invokeNext(request);
    }
    
    public int insertUser(TxEvent event) throws SQLException {
        System.out.println("insert...");
        GauceDataRow row = event.getDataRow();
        for (int i = 0; i < row.size(); i++) {
            if (i != 0) System.out.print(", ");
            System.out.print(row.getColumnValue(i));
        }
        System.out.println();
        return 0;
    }
    
    public int updateUser(TxEvent event) throws SQLException {
        System.out.println("update...");
        GauceDataRow row = event.getDataRow();
        for (int i = 0; i < row.size(); i++) {
            if (i != 0) System.out.print(", ");
            System.out.print(row.getColumnValue(i));
        }
        System.out.println();
        return 0;
    }
    
    public int deleteUser(TxEvent event) throws SQLException {
        System.out.println("delete...");
        GauceDataRow row = event.getDataRow();
        for (int i = 0; i < row.size(); i++) {
            if (i != 0) System.out.print(", ");
            System.out.print(row.getColumnValue(i));
        }
        System.out.println();
        return 0;
    }
    
    public int insertGroup(TxEvent event) throws SQLException {
        System.out.println("insert...");
        GauceDataRow row = event.getDataRow();
        for (int i = 0; i < row.size(); i++) {
            if (i != 0) System.out.print(", ");
            System.out.print(row.getColumnValue(i));
        }
        System.out.println();
        return 0;
    }
    
    public int updateGroup(TxEvent event) throws SQLException {
        System.out.println("update...");
        GauceDataRow row = event.getDataRow();
        for (int i = 0; i < row.size(); i++) {
            if (i != 0) System.out.print(", ");
            System.out.print(row.getColumnValue(i));
        }
        System.out.println();
        return 0;
    }

    public int deleteGroup(TxEvent event) throws SQLException {
        System.out.println("delete...");
        GauceDataRow row = event.getDataRow();
        for (int i = 0; i < row.size(); i++) {
            if (i != 0) System.out.print(", ");
            System.out.print(row.getColumnValue(i));
        }
        System.out.println();
        return 0;
    }
}
