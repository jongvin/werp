<%@ page import="java.io.*,com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*"%><%
System.out.println("select blob...");
String dir = (String) session.getAttribute("dir");
ServiceLoader loader = new ServiceLoader(request, response);
GauceService service = loader.newService();
Logger logger = service.getContext().getLogger();
try {
	response.setContentType("image/jpeg");
    GauceResponse res = service.getGauceResponse();
    GauceRequest req = service.getGauceRequest();
	try {
		String id = req.getParameter("data_name");
        FileInputStream is = new FileInputStream(dir + "blob/"+id);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        CommonUtil.copy(is, baos);
        res.write(baos.toByteArray());
        is.close();
        baos.close();
		res.close();
	} catch (Exception e) {
		res.writeException("Native", "9999", e.toString());
	}
} catch (Exception e) {
	e.printStackTrace();
} finally {
	loader.restoreService(service);
}
%>