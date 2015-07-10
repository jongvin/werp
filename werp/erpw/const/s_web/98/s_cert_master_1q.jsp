<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_approval =  req.getParameter("arg_approval");
     String arg_sbcr =  req.getParameter("arg_sbcr");
     arg_approval = '%' + arg_approval + '%';
     arg_sbcr = '%' + arg_sbcr + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("cert_id",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("smt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("app_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("exp_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cert_auth",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("cert_authcode",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("cert_dn",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("cert_info",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("cert_hash",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("cert_serial",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("cert_old",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("cnf_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cnf_gb",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("use_gb",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("cert_media",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("corp_id",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("cre_by",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cre_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("upd_by",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("upd_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("org_value",GauceDataColumn.TB_STRING,80));
     dSet.addDataColumn(new GauceDataColumn("sign_value",GauceDataColumn.TB_STRING,3000));
     dSet.addDataColumn(new GauceDataColumn("verify_value",GauceDataColumn.TB_STRING,80));
     dSet.addDataColumn(new GauceDataColumn("signer_value",GauceDataColumn.TB_STRING,80));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  a.cert_id ," + 
					    "          to_char(a.smt_date,'yyyy.mm.dd') smt_date ," + 
					    "          to_char(a.app_date,'yyyy.mm.dd') app_date ," + 
					    "          to_char(a.exp_date,'yyyy.mm.dd') exp_date ," + 
					    "          a.cert_auth ," + 
					    "          a.cert_authcode ," + 
					    "          a.cert_dn ," + 
					    "          a.cert_info ," + 
					    "          a.cert_hash ," + 
					    "          a.cert_serial ," + 
					    "          a.cert_old ," + 
					    "          to_char(a.cnf_date,'yyyy.mm.dd') cnf_date ," + 
					    "          a.cnf_gb ," + 
					    "          a.use_gb ," + 
					    "          a.cert_media ," + 
					    "          a.corp_id ," + 
					    "          a.cre_by ," + 
					    "          to_char(a.cre_date,'yyyy.mm.dd') cre_date ," + 
					    "          a.upd_by ," + 
					    "          to_char(a.upd_date,'yyyy.mm.dd') upd_date ," + 
					    "          a.org_value ," + 
					    "          a.sign_value ," + 
					    "          a.verify_value ," + 
					    "          a.signer_value,  " +
					    "          b.sbcr_name " +
					    "     FROM s_cert_master a, " +
					    "          s_sbcr b " +
					    "    WHERE a.corp_id = b.sbcr_code " +
					    "      and nvl(a.CNF_GB,' ') like '" + arg_approval + "'" +
					    "      and nvl(b.sbcr_name,' ') like '" + arg_sbcr + "'" +
					    "      and a.smt_date is not null " +
					    " ORDER BY a.smt_date desc       ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>