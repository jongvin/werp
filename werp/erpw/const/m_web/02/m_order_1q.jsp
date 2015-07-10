<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept = req.getParameter("arg_dept");
     String arg_date = req.getParameter("arg_date");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("approseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("deliverylimitdate",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("paymentmethod",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("eye",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("main_charge",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("main_pos",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("proj_charge",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("proj_pos",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("chrg_name1",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("chrg_hp",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("chrg_tel_number2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("fax_number",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("deliverymethod",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("place",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jukyo",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vatamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("totamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("remark1",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("approym",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("unitprice",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  select 0 unq_num,														               " +
      	"  		 0 no_seq, 												 					                  " +
      	"  		 a.approseq, 																			         " +
			"	       c.long_name,                                                                 " +
			"	       b.sbcr_name,                                                                 " +
			"	       to_char(a.deliverylimitdate, 'yyyy.mm.dd') deliverylimitdate,                " +
			"	       a.paymentmethod,                                                             " +
			"	       '육안검사' eye,                                                              " +
			"	       c.main_charge,                                                               " +
			"	       c.main_pos,                                                                  " +
			"			 c.proj_charge,                                                               " +
			"			 c.proj_pos,                                                                  " +
			"			 b.chrg_name1,                                                                " +
			"			 b.chrg_hp,                                                                   " +
			"			 b.chrg_tel_number2,                                                          " +
			"			 b.fax_number,                                                                " +
			"			 a.deliverymethod,                                                            " +
			"	       '현장' place,                                                                " +
			"	       '' jukyo,                                                                    " +
			"	       a.amt,                                                                       " +
			"	       a.vatamt,                                                                    " +
			"				 a.amt + a.vatamt totamt,                                                  " +
			"	       a.remark1,                                                                   " +
			"	       to_char(a.approym, 'yyyy.mm.dd') approym,                                    " +
			"	       d.name,                                                                      " +
			"	       d.ssize,                                                                     " +
			"	       d.unitcode,                                                                  " +
			"	       d.qty,                                                                       " +
			"	       d.unitprice,                                                                 " +
			"	       d.amt mat_amt                                                                " +
			"	    from m_approval a,                                                              " +
			"	    		s_sbcr b,                                                                  " +
			"	    		z_code_dept c,                                                             " +
			"	    		m_approval_detail d,                                                       " +
			"	    		m_approval_sbcr e                                                          " +
			"	   where e.sbcr_code 		= b.sbcr_code(+)                                         " +
			"	    and a.dept_code 		= c.dept_code                                               " +
			"		  and a.dept_code 		= d.dept_code                                            " +
			"		  and a.approym 			= d.approym                                              " +
			"		  and a.approseq 			= d.approseq                                             " +
			"		  and a.chg_cnt 			= d.chg_cnt                                              " +
			"		  and a.dept_code 		= e.dept_code                                            " +
			"		  and a.approym 			= e.approym                                              " +
			"		  and a.approseq 			= e.approseq                                             " +
			"		  and a.chg_cnt 			= e.chg_cnt                                              " +
			"		  and a.dept_code 		= '" + arg_dept +  "'                                    " +
			"		  and a.approym 			= '" + arg_date +  "'                                    " +
			"		  and a.approseq 			= " + arg_seq +  "                                       " +
			"		  and a.chg_cnt 			= 1                                                      " +
			"	order by b.sbcr_code asc                                                            " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>