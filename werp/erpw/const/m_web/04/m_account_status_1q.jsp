<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_inv = req.getParameter("arg_inv");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("inv_id",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("cst_doc_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("corp_reg_no",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("pub_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("sup_tamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sup_ttax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("iss_gb",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("proc_gb",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("tax_gb",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("off_gb",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("prepay_gb",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("biz_id",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cst_info_id",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cord_id",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("iss_by",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("iss_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("snd_by",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("snd_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("rjt_by",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rjt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("rjt_desc",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("cert_dn",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("sign",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cert_hash",GauceDataColumn.TB_STRING,40));
    String query = "  SELECT  a.inv_id ," + 
     					 "          a.dept_code ," + 
     					 "          a.cst_doc_no ," + 
     					 "          a.corp_reg_no ," + 
     					 "          to_char(a.pub_date,'yyyy.mm.dd') pub_date," + 
     					 "          nvl(a.sup_tamt,0) sup_tamt ," + 
     					 "          nvl(a.sup_ttax,0) sup_ttax ," + 
     					 "          a.iss_gb ," + 
     					 "          a.proc_gb ," + 
     					 "          a.tax_gb ," + 
     					 "          a.off_gb ," + 
     					 "          a.prepay_gb ," + 
     					 "          nvl(a.biz_id,0) biz_id ," + 
     					 "          nvl(a.cst_info_id,0) cst_info_id ," + 
     					 "          nvl(a.cord_id,0) cord_id ," + 
     					 "          nvl(a.iss_by,0) iss_by ," + 
     					 "          to_char(a.iss_date,'yyyy.mm.dd') iss_date ," + 
     					 "          nvl(a.snd_by,0) snd_by ," + 
     					 "          to_char(a.snd_date,'yyyy.mm.dd') snd_date ," + 
     					 "          nvl(a.rjt_by,0) rjt_by ," + 
     					 "          to_char(a.rjt_date,'yyyy.mm.dd') rjt_date ," + 
     					 "          a.rjt_desc ," + 
     					 "          a.cert_dn ," + 
     					 "          a.sign, " +
     					 "          b.sbcr_name, " +
     					 "          c.cert_hash " +
     					 "     FROM s_account_process a," +
     					 "          s_sbcr b, " +
     					 "          s_elec_account c " +
     					 "    WHERE a.corp_reg_no = b.sbcr_code " +
     					 "      and a.inv_id = c.inv_id " +
     					 "      and a.INV_ID = " +  arg_inv ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>