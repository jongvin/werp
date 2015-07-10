<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_work_yymm = req.getParameter("arg_work_yymm");
     String arg_pay_kind = req.getParameter("arg_pay_kind");
     String arg_comp_code = req.getParameter("arg_comp_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("paydate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("paykind",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("total_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("total_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("real_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("inco_tax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("resi_tax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pens_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("medi_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("empl_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("etcx_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("invoice_num",GauceDataColumn.TB_STRING,50));  
     dSet.addDataColumn(new GauceDataColumn("chk_2",GauceDataColumn.TB_STRING,50));   
    String query = "  SELECT  to_char(a.paydate,'yyyy.mm.dd') paydate  ," + 
					    "          a.paykind ," + 
					    "          a.comp_code ," + 
					    "          a.dept_code ," + 
					    "          a.total_amt ," + 
					    "          a.total_cnt ," + 
					    "          a.real_amt ," + 
					    "          a.inco_tax ," + 
					    "          a.resi_tax ," + 
					    "          a.pens_amt ," + 
					    "          a.medi_amt ," + 
					    "          a.empl_amt ," + 
					    "          a.etcx_amt , " + 
					    "          a.invoice_num,  " +
     					 "          decode(d.complete_flag,null,'Y',decode(d.complete_flag,'3','Y',decode(d.complete_flag,'9',decode(d.relation_invoice_group_id,null,'N','Y'),'N'))) chk_2 " + 
					    "      FROM p_pay_payment   a, " +
					    "           efin_invoice_header_itf  d " +
     					 "      where a.invoice_num = d.invoice_group_id (+) " +
     					 "        and a.paydate = '"+ arg_work_yymm +"'  " +
					    "        and a.paykind = '"+ arg_pay_kind +"'  " ;
					    
					    if(! arg_comp_code.equals("")) {   //검색조건으로 찾기 
							   query += " and a.comp_code = '" + arg_comp_code + "' ";
						 }
							
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>