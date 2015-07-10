package com.gauce;
import java.sql.*;

public class rescopy {
    public  static GauceDataSet copydataset(ResultSet rset, GauceDataSet dset) throws java.sql.SQLException {
       int i,j;
       int coltype[] = new int[300];
       String colvalue[] = new String[300];
       GauceDataColumn[] dColumn =  dset.getDataColumns();
       for (i=0; i< dset.getDataColCnt(); i++) {           // column name과 column type 보관.
           coltype [i] = dColumn[i].getColType();
           colvalue[i] =  dColumn[i].getColName();
       }
       while(rset.next()){ 
             GauceDataRow row = dset.newDataRow();
             for (i=0; i< dset.getDataColCnt();i++) {
                 switch (coltype[i]) {                           //아래의 각 타입을 더 추가하시요(현재 우리회사에서쓰는것만했슴)
	                 case GauceDataColumn.TB_STRING:
	                      row.addColumnValue(rset.getString(colvalue[i]));
	                      break;
	                 case GauceDataColumn.TB_DECIMAL:
	                      row.addColumnValue(rset.getDouble(colvalue[i]));
	                      break;
	                 case GauceDataColumn.TB_INT:
	                      row.addColumnValue(rset.getInt(colvalue[i]));
	                      break;
	                 case GauceDataColumn.TB_URL:
	                      row.addColumnValue(rset.getString(colvalue[i]));
	                      break;
                    default:
	                      row.addColumnValue(rset.getString(colvalue[i]));
	                      break;
                }
             }
        dset.addDataRow(row);
       }
     return dset;
    }
}