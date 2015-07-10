<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_date = req.getParameter("arg_date");
     String arg_to_date = req.getParameter("arg_to_date");
     String arg_name = '%' + req.getParameter("arg_name") + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("estimateyymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("estimateseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("estimatedate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("esttitle",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("vattag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("enddatetime",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("estmethod1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("estmethod2",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("paycondition",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("deliverycondition",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("selectcondition",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("buytag",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,300));
     dSet.addDataColumn(new GauceDataColumn("recommend",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("deliverylimitdate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("requestseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ebid_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("order_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("bid_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("open_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("const_guarantee_clasee",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("pre_amt_guarantee",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("as_guarantee",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("const_cond",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("sibangsoe",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("spec_cond",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("etc_file",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("open_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("open_dt",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("open_per",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("choicetag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("tender_place",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("siteexplain_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("siteexplain_place",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("explain_per",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("join_per",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT  to_char(a.estimateyymm,'yyyy.mm.dd') estimateyymm ," + 
     					 "          a.estimateseq ," + 
     					 "          to_char(a.estimatedate,'yyyy.mm.dd') estimatedate ," + 
     					 "          a.esttitle ," + 
     					 "          a.vattag ," + 
     					 "          to_char(a.enddatetime,'yyyy.mm.dd hh24:mi') enddatetime," + 
     					 "          a.estmethod1 ," + 
     					 "          a.estmethod2 ," + 
     					 "          a.paycondition ," + 
     					 "          a.deliverycondition ," + 
     					 "          a.selectcondition ," + 
     					 "          a.buytag ," + 
     					 "          a.remark ," + 
     					 "          a.recommend ," + 
     					 "          to_char(a.deliverylimitdate,'yyyy.mm.dd') deliverylimitdate," + 
     					 "          a.requestseq ," + 
     					 "          a.ebid_yn ," + 
     					 "          a.order_class ," + 
     					 "          a.bid_class ," + 
     					 "          a.open_class ," + 
     					 "          a.const_guarantee_clasee ," + 
     					 "          a.pre_amt_guarantee ," + 
     					 "          a.as_guarantee ," + 
     					 "          a.const_cond ," + 
     					 "          a.sibangsoe ," + 
     					 "          a.spec_cond ," + 
     					 "          a.etc_file ," + 
     					 "          decode(a.ebid_yn,'1',nvl(a.open_yn,'N'),a.open_yn)  open_yn," + 
     					 "          to_char(a.open_dt,'yyyy.mm.dd hh24:mi') open_dt," + 
     					 "          a.open_per, " +
     					 "				a.tender_place, " +
     					 "				to_char(a.siteexplain_dt, 'yyyy.mm.dd hh24:mi') siteexplain_dt, " +
     					 "				a.siteexplain_place, " +
     					 "				a.explain_per, " +
     					 "				a.join_per, " +
     					 "          decode(nvl(b.chk,0),0,'N','Y') choicetag " +
     					 "     FROM m_estimation a ," +
						 "			  ( select max(estimateyymm) estimateyymm, max(estimateseq) estimateseq, count(*) chk " +
						 "				   from m_vender_est " +
						 "				  where choicetag = 'Y' " +
						 "			  group by estimateyymm,estimateseq ) b " +
     					 "    WHERE a.estimateyymm  = b.estimateyymm (+) " +
						 "		  and a.estimateseq   = b.estimateseq (+) " +
						 "		  and a.ESTIMATEYYMM >= '" + arg_date + "'" +
						 "      and a.ESTIMATEYYMM <= '" + arg_to_date + "'" +
						 "      and ( a.esttitle is null " +
						 "      or a.esttitle like '" + arg_name + "' )" +
     					 " ORDER BY a.estimateyymm          DESC," + 
     					 "          a.estimateseq          DESC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>