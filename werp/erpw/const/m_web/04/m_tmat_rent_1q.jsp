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
	dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
	dSet.addDataColumn(new GauceDataColumn("rem_amt",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("rent_cnt",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("month",GauceDataColumn.TB_STRING,18));
	dSet.addDataColumn(new GauceDataColumn("b_qty",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("unitprice",GauceDataColumn.TB_DECIMAL,18,3));
	dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("invoice_num",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("in_spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("in_spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("degree",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("vatamt",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("spec_name",GauceDataColumn.TB_STRING,200));
   dSet.addDataColumn(new GauceDataColumn("slip_st",GauceDataColumn.TB_STRING,1));
	String  query = "  SELECT  a.dept_code ," + 
						 "     		  to_char(a.yymmdd,'yyyy.mm.dd') yymmdd , " +
						 "     		  a.seq , " +
						 "     		  a.input_unq_num , " +
						 "     		  a.detailseq , " +
						 "     		  a.mtrcode , " +
						 "     		  a.name , " +
						 "     		  a.ssize , " +
						 "     		  a.unitcode , " +
						 "     		  a.qty , " +
						 "     		  a.rem_amt , " + 
						 "            a.rent_cnt, " +
						 "     		  to_char(b.month,'yyyy.mm.dd') month, " +
						 "     		  b.qty b_qty, " +
						 "     		  b.unitprice , " +
						 "     		  b.amt , " +
						 "     		  b.spec_no_seq , " +
						 "     		  b.spec_unq_num , " +
						 "     		  b.invoice_num,  " +
						 "            c.spec_no_seq   in_spec_no_seq, " +
						 "            c.spec_unq_num   in_spec_unq_num, " +
						 "            1 degree,0 vatamt, " +
						 "     		  F_PARENT_DETAIL_NAME(a.dept_code,b.spec_unq_num) spec_name,   " +
     					 "            decode(b.invoice_num,null,'A',F_T_SLIP_STAT(to_number(b.invoice_num))) slip_st " +
						 "       from (select a.dept_code,a.yymmdd,a.seq,a.input_unq_num,a.detailseq,a.mtrcode,a.name,a.ssize,a.unitcode, " +
						 "     				   nvl(a.qty,0) + nvl(c.qty,0)  qty, " +
						 "     				   nvl(a.amt,0) + nvl(c.amt,0)  - nvl(f.amt,0) rem_amt, " +
						 "     				   a.years - nvl(f.rent_cnt,0) rent_cnt " +
						 "     			from m_tmat_stock a, " +
				 		 "                 (select *            " +
						 "                    from m_input  " +
						 "                  where dept_code = '" + arg_dept_code + "'" +
						 "                    and (inouttypecode = '3' " +
             		 "                    and trunc(output_yymmdd,'MM') = '" + arg_date + "'" +
						 "                 	 and to_char(output_yymmdd,'DD') <= '15') " +
             		 "                     or (inouttypecode <> '3' " +
             		 "                    and trunc(yymmdd,'MM') < '" + arg_date + "'  )) b,  " +
						 "     				  (select max(a.input_unq_num) input_unq_num,sum(a.qty) qty,sum(a.amt) amt " +
						 "     					  from m_output_detail a, " +
						 "     							 m_output b " +
						 "     					 where b.dept_code = a.dept_code(+) " +
						 "     						and b.yymmdd    = a.yymmdd (+) " +
						 "     						and b.seq       = a.seq (+) " +
						 "     						and a.dept_code = '" + arg_dept_code + "'" +
						 "     						and b.inouttypecode = '4' " +
						 "     						and b.trans_tag = '4' " +
						 "     						and trunc(b.input_yymmdd,'MM') = '" + arg_date + "'" +
						 "     						and to_char(b.input_yymmdd,'DD') > '15'  " +
						 "     					group by a.dept_code,a.input_unq_num ) c, " +
						 "     				  (select max(a.input_unq_num) input_unq_num,sum(a.qty) qty,sum(a.amt) amt " +
						 "     					  from m_output_detail a, " +
						 "     							 m_output b " +
						 "     					 where b.dept_code = a.dept_code(+) " +
						 "     						and b.yymmdd    = a.yymmdd (+) " +
						 "     						and b.seq       = a.seq (+) " +
						 "     						and a.dept_code = '" + arg_dept_code + "'" +
						 "     						and b.inouttypecode = '4' " +
						 "     						and b.trans_tag = '4' " +
						 "     						and trunc(b.input_yymmdd,'MM') = '" + arg_date + "'" +
						 "     						and to_char(b.input_yymmdd,'DD') <= '15' " +
						 "     					group by a.dept_code,a.input_unq_num ) d, " +
						 "     				  (select max(a.input_unq_num) input_unq_num,sum(a.qty) qty,sum(a.amt) amt " +
						 "     					  from m_output_detail a, " +
						 "     							 m_output b " +
						 "     					 where b.dept_code = a.dept_code(+) " +
						 "     						and b.yymmdd    = a.yymmdd (+) " +
						 "     						and b.seq       = a.seq (+) " +
						 "     						and a.dept_code = '" + arg_dept_code + "'" +
						 "     						and b.inouttypecode in ('5','6','7') " +
						 "     						and trunc(b.yymmdd,'MM') = '" + arg_date + "'" +
						 "     					group by a.dept_code,a.input_unq_num ) e, " +
						 "     				  (select max(a.yymmdd) yymmdd,max(a.seq) seq,max(a.input_unq_num) input_unq_num, " +
						 "                          sum(a.qty) qty ,sum(a.amt) amt,count(*) rent_cnt " +
						 "     					  from m_tmat_proj_rent a " +
						 "     					 where a.dept_code = '" + arg_dept_code + "'" +
						 "     						and a.month < '" + arg_date + "'" +
						 "     						and a.invoice_num <> 0 " +
						 "     				  group by a.dept_code,a.yymmdd,a.seq,a.input_unq_num ) f " +
						 "     			where a.dept_code = b.dept_code " +
						 "               and a.yymmdd    = b.yymmdd " +
						 "               and a.seq       = b.seq " +
						 "               and a.yymmdd = f.yymmdd (+) " +
						 "     			  and a.seq = f.seq (+) " +
						 "     			  and a.input_unq_num = f.input_unq_num (+) " +
						 "     			  and a.input_unq_num = c.input_unq_num (+) " +
						 "     			  and a.input_unq_num = d.input_unq_num (+) " +
						 "     			  and a.input_unq_num = e.input_unq_num (+) ) a, " +
						 "     			(select * from m_tmat_proj_rent where degree = '1' " +
						 "                        and dept_code = '" + arg_dept_code + "'" +
						 "                        and month = '" + arg_date + "' ) b, " +
						 "           m_input_detail c " +
						 "     where a.dept_code = b.dept_code (+) " +
						 "       and a.yymmdd    = b.yymmdd (+) " +
						 "       and a.seq       = b.seq (+) " +
						 "       and a.dept_code = c.dept_code " +
						 "       and a.yymmdd    = c.yymmdd " +
						 "       and a.seq       = c.seq " +
						 "       and a.input_unq_num = c.input_unq_num " +
						 "       and a.input_unq_num = b.input_unq_num (+)  " +
						 "       and a.dept_code = '" + arg_dept_code + "'" +
     					 "       and b.MONTH (+) = '" + arg_date + "'" +
						 "       and a.qty <> 0 " +
						 "       and a.rent_cnt <> 0 " +
     					 " order by a.detailseq asc ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>