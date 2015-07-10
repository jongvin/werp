<%@ page import="Reflect,AddressDef,AddressRec,com.gauce.*,com.gauce.io.*,com.gauce.log.*"%><%
ServiceLoader loader = new ServiceLoader(request, response);
GauceService service = loader.newService();
GauceContext context = service.getContext();
Logger logger = context.getLogger();

try {
    GauceResponse res = service.getGauceResponse();
    GauceRequest req = service.getGauceRequest();
    GauceDataSet dSet = new GauceDataSet();
    res.enableFirstRow(dSet);
    
    Reflect.initDataColumn(dSet, AddressDef.class);
     
    Object[] dl = {new AddressRec(), new AddressRec(), new AddressRec(),new AddressRec(),new AddressRec()};
    Reflect.addData(dSet, dl);
    dSet.flush();
    res.flush();
    res.commit("성공입니다");
    res.close();
} catch (Exception e) {
    logger.err.println(this, e);
    throw e;
} finally {
    loader.restoreService(service);
}
%>