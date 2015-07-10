<%@ page import="java.io.*,java.util.*,java.text.*,com.gauce.*,com.gauce.io.*,com.gauce.log.*,com.gauce.common.*"%><%

    ServiceLoader loader = new ServiceLoader(request, response);
    GauceService service = loader.newService();
    GauceContext context = service.getContext();
    Logger logger = context.getLogger();
    
    File fImage1                 = null;
    FileInputStream isImage1     = null;
    File fImage2                 = null;
    FileInputStream isImage2     = null;
    
    try {
        response.setContentType("application/octet-stream;charset=ISO-8859-1");
        GauceResponse res = service.getGauceResponse();
        GauceDataSet dSet = new GauceDataSet();
        res.enableFirstRow(dSet);
        dSet.addDataColumn(new GauceDataColumn("Tb_img",GauceDataColumn.TB_BLOB));
        dSet.addDataColumn(new GauceDataColumn("Tb_img_id",GauceDataColumn.TB_STRING));
		dSet.addDataColumn(new GauceDataColumn("Tb_img_size",GauceDataColumn.TB_INT));
				

   		//String dir = "C:\\";
		String dir = "C:\\bea\\user_projects\\domains\\cjdwld\\applications\\werp\\erpw\\TEST\\trv_img\\";

		try {
    		//Testing Dir
    		fImage1 = new File(dir + "apple.ico");
    		isImage1 = new FileInputStream(fImage1);
    		fImage2 = new File(dir + "JavaCup.ico");
    		isImage2 = new FileInputStream(fImage2);
	    } catch (Exception fe) {
	        fe.printStackTrace();
	    }
	    
        GauceDataRow row1 = dSet.newDataRow();
		row1.addColumnValue(isImage1);
		row1.addColumnValue("apple");
		row1.addColumnValue(fImage1.length());
		dSet.addDataRow(row1);

        GauceDataRow row2 = dSet.newDataRow();
		row2.addColumnValue(isImage2);
		row2.addColumnValue("JavaCup");
		row2.addColumnValue(fImage2.length());
		dSet.addDataRow(row2);

        dSet.flush();
        res.flush();
        res.commit();
        res.close();
        
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            isImage1.close();
            isImage2.close();
            loader.restoreService(service);
        } catch(Exception e) {
            e.printStackTrace();        
        }
    }
%>