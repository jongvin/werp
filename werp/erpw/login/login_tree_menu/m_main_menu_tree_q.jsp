<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%>
ServiceLoader loader = new ServiceLoader(request, response);
GauceService service = loader.newService();
GauceContext context = service.getContext();
Logger logger = context.getLogger();
GauceDBConnection conn = null;
try {
     conn = service.getDBConnection();GauceStatement stmt = null;
     GauceRequest req = service.getGauceRequest();
     GauceResponse res = service.getGauceResponse();
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_group_key = req.getParameter("arg_group_key");
 //---------------------------------------------------------- 
     GauceDataSet dSet = new GauceDataSet();
     res.enableFirstRow(dSet);
     dSet.addDataColumn(new GauceDataColumn("group_seq_key",GauceDataColumn.TB_DECIMAL, 18, 0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL, 18, 0));
     dSet.addDataColumn(new GauceDataColumn("rw_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("level1",GauceDataColumn.TB_DECIMAL, 18, 0));
     dSet.addDataColumn(new GauceDataColumn("title_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("pgrm_id",GauceDataColumn.TB_STRING,60));
    String query = "select group_seq_key," + 
     "       no_seq," + 
     "       rw_tag," + 
     "       level1, " + 
     "       title_name," + 
     "       pgrm_id  " + 
     "  from" + 
     "     (SELECT z_group_pgrm_title.group_seq_key,   " + 
     "         z_group_pgrm_title.no_seq * 1000  no_seq,    " + 
     "         z_group_pgrm_title.rw_tag," + 
     "         to_number(z_group_pgrm_title.level1) level1,   " + 
     "         z_group_pgrm_title.title_name," + 
     "         '                                        ' pgrm_id " + 
     "        FROM z_group_pgrm_title  " + 
     "        WHERE z_group_pgrm_title.group_key = " + arg_group_key + "  " + 
     "     union all" + 
     "      SELECT z_group_pgrm_content.pgrm_seq_key,   " + 
     "          z_group_pgrm_title.no_seq  * 1000 + z_group_pgrm_content.no_seq no_seq,   " + 
     "          z_group_pgrm_content.rw_tag, " + 
     "          to_number(z_group_pgrm_title.level1) + 1 level1,   " + 
     "          z_pgrm_content.pgrm_name,   " + 
     "          z_pgrm_content.pgrm_id  " + 
     "      FROM z_group_pgrm_content,   " + 
     "          z_pgrm_content,   " + 
     "          z_group_pgrm_title  " + 
     "      WHERE ( z_group_pgrm_title.group_seq_key = z_group_pgrm_content.group_seq_key ) and  " + 
     "            ( z_group_pgrm_content.pgrm_seq_key = z_pgrm_content.pgrm_seq_key ) and  " + 
     "            ( ( z_group_pgrm_title.group_key = " + arg_group_key + " ) )   )" + 
     "" + 
     "order by no_seq     ";
    stmt = conn.getGauceStatement(query);
    stmt.executeQuery(dSet);
    stmt.close();
    dSet.flush();
    res.commit("���������� ���ƽ��ϴ�");
    res.close();
} catch (Exception e) {
    logger.err.println(this, e);
    throw e;
} finally {
    if (conn != null) {
        try {
            conn.close();
        } catch (Exception e) {}
    }
    loader.restoreService(service);
}
%>
