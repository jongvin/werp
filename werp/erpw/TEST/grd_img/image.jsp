<%@ page contentType="text/html;charset=euc-kr" %><%@ page import="java.io.*,java.util.*,java.text.*,com.gauce.*,com.gauce.io.*,com.gauce.log.*,com.gauce.common.*"%><%

  ServiceLoader loader = new ServiceLoader(request, response);
  GauceService service = loader.newService();
		File fImageA1 = null;
		File fImageA2 = null;
		File fImageA3 = null;

		FileInputStream isImageA1 = null;
		FileInputStream isImageA2 = null;
		FileInputStream isImageA3 = null;

	try {
		response.setContentType("application/octet-stream;charset=utf-8");
		GauceRequest req = service.getGauceRequest();
		GauceResponse res = service.getGauceResponse();
		
		GauceDataSet dSet = new GauceDataSet();
		res.enableFirstRow(dSet);
		dSet.addDataColumn( new GauceDataColumn( "Tb_img", GauceDataColumn.TB_BLOB ) );
		dSet.addDataColumn( new GauceDataColumn( "Tb_img_id", GauceDataColumn.TB_STRING ) );
		dSet.addDataColumn( new GauceDataColumn( "Tb_img_size", GauceDataColumn.TB_INT ) );
		try {
			//String dir = "C:\\jakarta-tomcat-5.0.28\\webapps\\ROOT\\blob_max\\Image\\";
			String dir = "C:\\bea\\user_projects\\domains\\cjdwld\\applications\\werp\\erpw\\TEST\\grd_img\\Image\\";
			fImageA1 = new File(dir + "A1.gif");
			isImageA1 = new FileInputStream(fImageA1);

			fImageA2 = new File(dir + "B1.gif");
			isImageA2 = new FileInputStream(fImageA2);

			fImageA3 = new File(dir + "C1.gif");
			isImageA3 = new FileInputStream(fImageA3);

		} catch (Exception fe){
			fe.printStackTrace();
		}
			GauceDataRow rowA1 = dSet.newDataRow();
			rowA1.addColumnValue(isImageA1);
			rowA1.addColumnValue("I01");
			rowA1.addColumnValue(fImageA1.length());
			dSet.addDataRow(rowA1);

			GauceDataRow rowA2 = dSet.newDataRow();
			rowA2.addColumnValue(isImageA2);
			rowA2.addColumnValue("I02");
			rowA2.addColumnValue(fImageA2.length());
			dSet.addDataRow(rowA2);

			GauceDataRow rowA3 = dSet.newDataRow();
			rowA3.addColumnValue(isImageA3);
			rowA3.addColumnValue("I03");
			rowA3.addColumnValue(fImageA3.length());
			dSet.addDataRow(rowA3);

			dSet.flush();
			res.flush();
			res.commit();
			res.close();

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try	{
			isImageA1.close();
			isImageA2.close();
			
			loader.restoreService(service);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
%>