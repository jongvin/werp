package com.gauce.db;
import java.sql.*;
import com.gauce.*;
import com.gauce.db.*;

public class gpstatement {
     public static GauceDataSet gp_dataset;
     public static int    gp_row;
     public static PreparedStatement gp_stmt;
     public static GauceStatement gp_pstmt;
     public static GauceDataRow gp_datarow;
    public  static void bindColumn(int db_col, int dataset_col)  throws java.sql.SQLException {
       int i,j;
       int coltype ;
       String colvalue;
       GauceDataColumn dColumn =  gp_dataset.getDataColumn(dataset_col);
       coltype  = dColumn.getColType();
       colvalue =  dColumn.getColName();
       gp_datarow = gp_dataset.getDataRow(gp_row);
       
       switch (coltype) {                           //아래의 각 타입을 더 추가하시요(현재 우리회사에서쓰는것만했슴)
          case GauceDataColumn.TB_STRING:
               gp_stmt.setString(db_col,gp_datarow.getString(dataset_col));
               break;
          case GauceDataColumn.TB_DECIMAL:
               gp_stmt.setDouble(db_col,gp_datarow.getDouble(dataset_col));
               break;
          case GauceDataColumn.TB_INT:
               gp_stmt.setInt(db_col,gp_datarow.getInt(dataset_col));
               break;
          case GauceDataColumn.TB_URL:
               gp_stmt.setString(db_col,gp_datarow.getString(dataset_col));
               break;
          default:
               gp_stmt.setString(db_col,gp_datarow.getString(dataset_col));
               break;
       }
    }
}