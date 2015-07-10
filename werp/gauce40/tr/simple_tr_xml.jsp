<%@ page import="com.gauce.*,com.gauce.http.*,com.gauce.io.*,com.gauce.log.*"%><%
System.out.println("test..");
System.out.println(request.getParameter("aaa"));    
System.out.println(request.getParameter("ddd")); 
GauceInputStream gis = ((HttpGauceRequest) request).getGauceInputStream();
GauceOutputStream gos = ((HttpGauceResponse) response).getGauceOutputStream();
GauceDataSet mainSet = gis.read("USER");
if (mainSet != null) {
    if (((HttpGauceRequest) request).isBuilderRequest()) {
        mainSet.setUsage(true);   
        mainSet.addDataColumn(new GauceDataColumn("emp_name", GauceDataColumn.TB_STRING));
        mainSet.addDataColumn(new GauceDataColumn("emp_id", GauceDataColumn.TB_INT));
        mainSet.addDataColumn(new GauceDataColumn("emp_code", GauceDataColumn.TB_INT));
        mainSet.addDataColumn(new GauceDataColumn("emp_hiredate", GauceDataColumn.TB_STRING));
        mainSet.addDataColumn(new GauceDataColumn("emp_age", GauceDataColumn.TB_INT));
        mainSet.addDataColumn(new GauceDataColumn("emp_pay", GauceDataColumn.TB_DECIMAL,10,3));
        gos.write(mainSet);
    }

    GauceDataColumn[] cols = mainSet.getDataColumns();
    System.out.print("job, ");
    for (int i = 0; i < cols.length; i++) {
        System.out.print(cols[i].getColName() + ", ");
    }
    System.out.println("");
    
    GauceDataRow[] rows = mainSet.getDataRows();
    for (int i = 0; i < rows.length; i++) {
        System.out.print(rows[i].getJobType() + ", ");
        System.out.print(rows[i].getString(0) + ", ");
        System.out.print(rows[i].getInt(1) + ", ");
        System.out.print(rows[i].getInt(2) + ", ");
        System.out.print(rows[i].getString(3) + ", ");
        System.out.print(rows[i].getInt(4) + ", ");
        System.out.print(rows[i].getFloat(5));
        System.out.println("");
    }
}
gos.close();
%>