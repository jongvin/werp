package com.gauce;
import com.gauce.*;
import com.gauce.db.*;
import java.sql.*;
import java.io.IOException;
public class rescopy {
    public  static boolean copydataset(ResultSet rset, GauceDataSet dset) throws java.sql.SQLException {
       int i,j; 
       String colvalue;
       GauceDataColumn[] dColumn =  dset.getDataColumns();
       while(rset.next()){ 
             GauceDataRow row = dset.newDataRow();
             for (i=0; i< dset.getDataColCnt();i++) {
                 colvalue =  dColumn[i].getColName();
                 row.addColumnValue(rset.getString(colvalue));
             }
       }
     return true;
    }
}