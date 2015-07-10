<%@page import="java.io.*,com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*"%><%
    ServiceLoader loader = new ServiceLoader(request, response);
    GauceService service = loader.newService();
    GauceContext context = service.getContext();
    Logger logger = context.getLogger();
    try {
        GauceRequest req = service.getGauceRequest();
        GauceResponse rew = service.getGauceResponse();
        GauceDataSet dataset = req.getGauceDataSet("input");
        if (dataset != null) {
            GauceDataColumn[] cols = dataset.getDataColumns();
            GauceDataRow[] rows = dataset.getDataRows();
            int data_name = dataset.indexColumn("data_name");
            int data_url  = dataset.indexColumn("data_url");
            for (int i=0; i<rows.length; i++) {
                if (rows[i].getJobType == GauceDataRow.TB_JOB_INSERT) {
                    String d_name = row[i].getString(data_name);
                    InputStream is = (InputStream)rows[i].getInputStream(data_url);
                    FileOutputStream os = new FileOutputStream("C:\\");
                    CommonUtil.copy(is, os);
                    //CommonUtil.copy(is, os, (int 원하는 사이즈 지정) );
                    is.close();
                    os.close();
                }
                if (rows[i].getJobType == GauceDataRow.TB_JOB_UPDATE) {
                }
                if (rows[i].getJobType == GauceDataRow.TB_JOB_DELETE) {
                }
            }
        } else {
            res.writeException("Native", "9999", "GauceDataSet is Null!!!");
        }
        res.commit();
        
        
    } catch(Exception e) {
    
    }
%>
