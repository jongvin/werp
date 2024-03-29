<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("input_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("detailseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("noout_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("proc_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("unitprice",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("input_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("input_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("re_amt",GauceDataColumn.TB_DECIMAL,18,0));

    String query = "  SELECT  a.dept_code ," + 
     					 "          to_char(a.yymmdd,'yyyy.mm.dd') yymmdd ," + 
     					 "          a.seq ," + 
     					 "          a.input_unq_num ," + 
     					 "          a.detailseq ," + 
     					 "          a.mtrcode ," + 
     					 "          a.name ," + 
     					 "          a.ssize ," + 
     					 "          a.unitcode ," + 
     					 "          a.qty  noout_qty," + 
     					 "          a.proc_yn, " + 
     					 "          trunc(nvl(a.amt,0)  / a.qty,0) unitprice, " +
     					 "          a.amt amt, " +
				       "          0       input_qty," +
				       "          0       input_amt," +
				       "          ''           comp_chk,a.amt re_amt " +
     					 "     FROM m_tmat_stock a,"  +
  			          "          ( select max(input_unq_num) input_unq_num, nvl(sum(amt),0) amt " +
  			          "              from m_tmat_proj_rent " +
  			          "             where spec_unq_num <> 0 " +
  			          "               and dept_code = '" + arg_dept_code + "'" +
  			          "            group by input_unq_num ) b, " +
					    "            m_input_detail c " +
     					 "    WHERE a.input_unq_num = b.input_unq_num (+)" +
     					 "      and a.dept_code = c.dept_code " +
						 "      and a.input_unq_num = c.input_unq_num " +
     					 "      and a.DEPT_CODE = '" + arg_dept_code + "'" +
     					 "      and a.QTY <> 0  " +
     					 "      and trunc(a.yymmdd,'MM') <= trunc(to_date('" + arg_date + "'),'MM') " +
     					 " order by a.name,a.ssize, a.input_unq_num asc ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>