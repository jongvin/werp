<%@ page import="java.io.*,java.util.*,java.text.*,com.gauce.*,com.gauce.io.*,com.gauce.log.*,com.gauce.common.*"%>
<%
	ServiceLoader loader = new ServiceLoader(request, response);
	GauceService service = loader.newService();
	GauceContext context = service.getContext();
	GauceResponse res = service.getGauceResponse();
	GauceDataSet dSet = new GauceDataSet();
	try {
		res.enableFirstRow(dSet);
		dSet.addDataColumn(new GauceDataColumn("Tb_img", GauceDataColumn.TB_BLOB));	
		dSet.addDataColumn(new GauceDataColumn("Tb_img_id", GauceDataColumn.TB_STRING));	
		dSet.addDataColumn(new GauceDataColumn("Tb_img_size", GauceDataColumn.TB_INT));	
		
		String dir = "C:\\bea\\user_projects\\domains\\cjdwld\\applications\\werp\\erpw\\TEST\\tr\\Image\\";
		
		String strImgCPath = dir + "folder_c.gif";
		String strImgDPath = dir + "folder_d.gif";
		String strImgOPath = dir + "folder_o.gif";

		FileInputStream is = new FileInputStream(strImgCPath);
		int fileSize = is.available();
		byte[] cImg = new byte[fileSize];
		is.read(cImg);
		is.close();
		is = new FileInputStream(strImgDPath);
		fileSize = is.available();
		byte[] dImg = new byte[fileSize];
		is.read(dImg);
		is.close();
		is = new FileInputStream(strImgOPath);
		fileSize = is.available();
		byte[] oImg = new byte[fileSize];
		is.read(oImg);
		is.close();
		GauceDataRow row = dSet.newDataRow();
		row.addColumnValue(cImg);
		row.addColumnValue("black_c");
		row.addColumnValue(1000);
		dSet.addDataRow(row);
	
		row = dSet.newDataRow();
		row.addColumnValue(dImg);
		row.addColumnValue("blue_d");
		row.addColumnValue(1000);
		dSet.addDataRow(row);
	
		row = dSet.newDataRow();
		row.addColumnValue(oImg);
		row.addColumnValue("red_o");
		row.addColumnValue(1000);
		dSet.addDataRow(row);
		dSet.flush();
		res.flush();
		res.commit();
		res.close();
	} catch(Exception e){
	    System.out.println("Menu이미지생성에러" + e.getMessage());
	    throw e;
	} finally {
	    loader.restoreService(service);
	}
%>
