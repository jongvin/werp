<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept = req.getParameter("arg_dept");
     String arg_date = req.getParameter("arg_date");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("deliverylimitdate",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("deliverymethod",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("paymentmethod",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name1",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name2",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name3",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("bud_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rate_1",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("rate_2",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("rate_3",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("remark1",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("title",GauceDataColumn.TB_STRING,100));
    String query = "  select 0 unq_num,																								" +
      "			 max(d.long_name) long_name, 																							" +	
		"	       max(to_char(a.deliverylimitdate,'yyyy.mm.dd')) deliverylimitdate,                                                    " +
		"	       max(a.deliverymethod) deliverymethod,                                                          " +
		"	       max(a.paymentmethod) paymentmethod,                                                            " +
		"	       max(e.name) name,                                                                              " +
		"	       max(c.sbcr_name) sbcr_name1,                                                                   " +
		"	       max(c.sbcr_name2) sbcr_name2,                                                                  " +
		"	       max(c.sbcr_name3) sbcr_name3,                                                                  " +
		"	       max(nvl(f.bud_amt,0)) bud_amt,                                                                 " +
		"	       max(nvl(g.amt,0)) amt1,                                                                        " +
		"			 max(nvl(a.amt,0)) amt,                                                                         " +
		"			 max(nvl(a.vatamt,0)) vat,                                                                      " +
		"			 max(nvl(a.amt,0) + nvl(a.vatamt,0)) tot_amt,                                                   " +
		"	      decode(max(nvl(f.bud_amt,0)), 0, 0, (max(nvl(g.amt,0))/max(nvl(f.bud_amt,0))) * 100) rate_1,    " + 
		"	      decode(max(nvl(f.bud_amt,0)), 0, 0, (max(nvl(a.amt,0))/max(nvl(f.bud_amt,0))) * 100) rate_2,    " + 
		"	      decode(max(nvl(f.bud_amt,0)), 0, 0, (max(nvl(a.amt,0))/max(nvl(g.amt,0))) * 100) rate_3,        " + 
		"			 max(a.remark1) remark1,                                                                        " +
      "             '    ' title                                               											" + 
		"	    from m_approval a,                                                                                " +
		"	         m_approval_detail b,                                                                         " +
		"	         (select a.sbcr_name, b.sbcr_name2, c.sbcr_name3																" +
      "					from	(select max(sbcr_name) sbcr_name                                                    " +
      "							 		from  m_vender_est a, s_sbcr b, m_approval c                                  " +
      "								 where a.sbcr_code = b.sbcr_code(+)                                              " +
      "							     and c.order_class = '1'                                                        " +
      "							     and c.dept_code = '" + arg_dept +  "'                                          " +
      "							     and c.approym = '" + arg_date +  "'                                            " +
      "								  and c.approseq = " + arg_seq +  "                                              " +
      "		  						  and a.ESTIMATEYYMM = c.estimateyymm                                            " +
      "								  and a.ESTIMATESEQ = c.estimateseq) a,                                          " +
      "						(select max(b.sbcr_name) sbcr_name2                                                    " +
      "						     from  m_vender_est a, s_sbcr b, m_approval c,                                     " +
      "							 		 (select max(sbcr_name) sbcr_name                                             " +
      "							 		from  m_vender_est a, s_sbcr b, m_approval c                                  " +
      "								 where a.sbcr_code = b.sbcr_code(+)                                              " +
      "							     and c.order_class = '1'                                                        " +
      "							     and c.dept_code = '" + arg_dept +  "'                                          " +
      "							     and c.approym = '" + arg_date +  "'                                            " +
      "								  and c.approseq = " + arg_seq +  "                                              " +
      "		  						  and a.ESTIMATEYYMM = c.estimateyymm                                            " +
      "								  and a.ESTIMATESEQ = c.estimateseq) max_1                                       " +
      "							 where a.sbcr_code = b.sbcr_code(+)                                                 " +
      "							     and c.order_class = '1'                                                        " +
      "							     and c.dept_code = '" + arg_dept +  "'                                          " +
      "							     and c.approym = '" + arg_date +  "'                                            " +
      "								  and c.approseq = " + arg_seq +  "                                              " +
      "		  						  and a.ESTIMATEYYMM = c.estimateyymm                                            " +
      "								  and a.ESTIMATESEQ = c.estimateseq                                              " +
      "								  and b.sbcr_name <> max_1.sbcr_name) b,                                         " +
      "						(select max(b.sbcr_name) sbcr_name3                                                    " +
      "						    from  m_vender_est a, s_sbcr b, m_approval c,                                      " +
      "								 		 (select max(b.sbcr_name) sbcr_name2, max(max_1.sbcr_name) sbcr_name1      " +
      "						     from  m_vender_est a, s_sbcr b, m_approval c,                                     " +
      "							 		 (select max(sbcr_name) sbcr_name                                             " +
      "									 		from  m_vender_est a, s_sbcr b, m_approval c                            " +
      "										 where a.sbcr_code = b.sbcr_code(+)                                        " +
      "									     and c.order_class = '1'                                                  " +
      "									     and c.dept_code = '" + arg_dept +  "'                                    " +
      "									     and c.approym = '" + arg_date +  "'                                      " +
      "										  and c.approseq = " + arg_seq +  "                                        " +
      "				  						  and a.ESTIMATEYYMM = c.estimateyymm                                      " +
      "										  and a.ESTIMATESEQ = c.estimateseq) max_1                                 " +
      "									 where a.sbcr_code = b.sbcr_code(+)                                           " +
      "									     and c.order_class = '1'                                                  " +
      "									     and c.dept_code = '" + arg_dept +  "'                                    " +
      "									     and c.approym = '" + arg_date +  "'                                      " +
      "										  and c.approseq = " + arg_seq +  "                                        " +
      "				  						  and a.ESTIMATEYYMM = c.estimateyymm                                      " +
      "										  and a.ESTIMATESEQ = c.estimateseq                                        " +
      "										  and b.sbcr_name <> max_1.sbcr_name) max_2                                " +
      "								where a.sbcr_code = b.sbcr_code(+)                                               " +
      "								  and c.order_class = '1'                                                        " +
      "								  and c.dept_code = '" + arg_dept +  "'                                          " +
      "								  and c.approym = '" + arg_date +  "'                                            " +
      "								  and c.approseq = " + arg_seq +  "                                              " +
      "				  				  and a.ESTIMATEYYMM = c.estimateyymm                                            " +
      "								  and a.ESTIMATESEQ = c.estimateseq                                              " +
      "						        and b.sbcr_name <> max_2.sbcr_name2                                            " +
      "								  and b.sbcr_name <> max_2.sbcr_name1) c) c,                                     " +
		"		      z_code_dept d,                                                                               " +
		"		      m_code_material e,                                                                           " +
		"			 (select sum(nvl(b.bud_amt,0)) bud_amt                                                          " +
		"			    from m_approval_detail a,                                                                   " +
		"			    		m_request_detail b                                                                     " +
		"			   where a.request_unq_num = b.request_unq_num                                                  " +
		"			     and a.dept_code = '" + arg_dept +  "'                                                      " +
		"				  and a.approym = '" + arg_date +  "'                                                        " +
		"				  and a.approseq = " + arg_seq +  ") f,                                                      " +
		"			 (select sum(a.qty * b.bud_price) amt                                                           " +
		"			    from m_approval_detail a,                                                                   " +
		"			         m_request_detail b                                                                     " +
		"				where a.request_unq_num = b.request_unq_num                                                  " +
		"				  and a.dept_code = '" + arg_dept +  "'                                                      " +
		"				  and a.approym = '" + arg_date +  "'                                                        " +
		"				  and a.approseq = " + arg_seq +  ") g                                                       " +
		"	   where a.dept_code = b.dept_code                                                                    " +
		"	     and a.approym = b.approym                                                                        " +
		"		  and a.approseq = b.approseq                                                                      " +
		"		  and a.chg_cnt = b.chg_cnt                                                                        " +
		"	     and a.dept_code = d.dept_code(+)                                                                 " +
		"		  and b.mtrcode = e.mtrcode(+)                                                                     " +
		"	     and a.order_class = '1'                                                                          " +
		"	     and a.dept_code = '" + arg_dept +  "'                                                            " +
		"	     and a.approym = '" + arg_date +  "'                                                              " +
		"		  and a.approseq = " + arg_seq +  "                                                                " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>