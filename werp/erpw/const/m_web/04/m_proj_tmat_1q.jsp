<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
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
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("proc_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("unitprice",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("buy_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ditag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("rent_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("k_rent_cnt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  a.dept_code ," + 
     					 "          to_char(a.yymmdd,'yyyy.mm.dd') yymmdd ," + 
     					 "          a.seq ," + 
     					 "          a.input_unq_num ," + 
     					 "          a.detailseq ," + 
     					 "          a.mtrcode ," + 
     					 "          a.name ," + 
     					 "          a.ssize ," + 
     					 "          a.unitcode ," + 
     					 "          a.qty ," + 
     					 "          a.proc_yn ," + 
     					 "          b.unitprice, " +
     					 "          decode(b.inouttypecode,'3','1','2') buy_tag, " +
     					 "          decode(b.inouttypecode,'3',e.long_name,d.sbcr_name) sbcr_name, " +
     					 "          f.ditag ,a.years - nvl(g.rent_cnt,0) rent_cnt,a.amt, " +
     					 "				nvl(g.rent_cnt,0) k_rent_cnt " +
     					 "     FROM m_tmat_stock a , " +
     					 "          m_input_detail b, " +
     					 "          m_input c, " +
     					 "          s_sbcr d, " +
     					 "          z_code_dept e, " +
     					 "          m_code_material f ," +
						 "   		  (select max(a.yymmdd) yymmdd,max(a.seq) seq,max(a.input_unq_num) input_unq_num, " +
						 "                      sum(a.qty) qty ,sum(a.amt) amt,count(*) rent_cnt " +
						 "   			  from m_tmat_proj_rent a " +
						 "   			 where a.dept_code = '" + arg_dept_code + "'" +
						 "   				and a.invoice_num <> 0 " +
						 "   		  group by a.dept_code,a.yymmdd,a.seq,a.input_unq_num ) g " +
     					 "    WHERE b.dept_code = c.dept_code (+) " +
     					 "      and b.yymmdd    = c.yymmdd (+) " +
     					 "      and b.seq       = c.seq (+) " +
     					 "      and b.sbcr_code = d.sbcr_code (+) " +
     					 "      and a.yymmdd    = g.yymmdd (+) " +
     					 "      and a.seq       = g.seq (+) " +
     					 "      and a.input_unq_num = g.input_unq_num (+) " +
     					 "      and c.relative_proj_code = e.dept_code (+) " +
     					 "      and a.dept_code = b.dept_code " +
     					 "      and a.input_unq_num = b.input_unq_num " +
     					 "      and a.mtrcode = f.mtrcode (+) " +
     					 "      and a.DEPT_CODE = '" + arg_dept_code + "'" +
     					 "      and a.qty <> 0 " +
     					 " order by a.name,a.ssize,a.unitcode,a.yymmdd,a.seq" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>