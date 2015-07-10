<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_comp_code = req.getParameter("arg_comp_code");
     String arg_work_yymm = req.getParameter("arg_work_yymm");
     String arg_pay_kind = req.getParameter("arg_pay_kind");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("total_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("total_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("real_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("inco_tax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("resi_tax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pens_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("medi_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("empl_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("etcx_amt",GauceDataColumn.TB_DECIMAL,18,0));     
     dSet.addDataColumn(new GauceDataColumn("proj_code",GauceDataColumn.TB_STRING,10));
    String query = "  SELECT  a.dept_code ," + 
                   "          b.long_name dept_name ," + 
                   "          a.total_amt ," + 
                   "          a.total_cnt ," + 
                   "          a.real_amt ," + 
                   "          a.inco_tax ," + 
                   "          a.resi_tax ," + 
                   "          a.pens_amt ," + 
                   "          a.medi_amt ," + 
                   "          a.empl_amt ," + 
                   "          a.etcx_amt , " + 
                   "          c.proj_code  " + 
                   "     FROM p_pay_payment  a,  " +
                   "				z_code_dept    b,  " +
                   
                   "          ( SELECT a.dept_code,c.proj_code						" +
                   "  			 	 FROM Z_CODE_DEPT a,									" +
                   "					      (SELECT proj_unq_key,step 					" +
                   "						      FROM r_proj_view_business_form) b,	" +
                   "							R_PROJ c											" +
                   "	  		      WHERE a.proj_unq_key = b.proj_unq_key        " +
                   "				     AND b.proj_unq_key = c.proj_unq_key        " +
                   "				     AND b.step = c.step ) c							" +                    
                   
                   "    where a.dept_code = b.dept_code(+) " +
                   "      and a.dept_code = c.dept_code(+) " +
                   "      and a.comp_code = '"+ arg_comp_code +"' " +
                   "      and to_char(a.paydate,'yyyy.mm') = to_char(to_date('"+ arg_work_yymm +"'),'yyyy.mm') " +
                   "      and a.paykind = '"+ arg_pay_kind +"' " +
                   " order by a.dept_code ";                   
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>