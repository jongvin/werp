<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_from_date = req.getParameter("arg_from_date");
     String arg_comp_code = req.getParameter("arg_comp_code") + "%";
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("welfare_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("welfare_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("welfare_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("invoice_num",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("approval_num",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("chk_1",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("chk_2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("proj_code",GauceDataColumn.TB_STRING,10));
    String query = "  SELECT   " + 
     "			 a.emp_no ," + 
     "          b.emp_name ," + 
     "          a.spec_no_seq ," + 
     "          a.seq ," + 
     "          a.welfare_code ," + 
     "          to_char(a.welfare_date, 'YYYY.MM.DD') welfare_date, " + 
     "          a.comp_code ," + 
     "          a.dept_code ," + 
     "          a.welfare_amt ," + 
     "          a.remark ," + 
     "          a.grade_code,   " +
     "          c.long_name dept_name ," + 
     "          d.grade_name, " + 
     "          a.invoice_num, " + 
     "          e.approval_num, " +
     "          decode(e.complete_flag,'1','결재중',decode(e.complete_flag,'3','반송',decode(e.complete_flag,'9',decode(e.relation_invoice_group_id,null,'결재완료','취소전표')))) chk_1, " + 
	  "          decode(e.complete_flag,null,'Y',decode(e.complete_flag,'3','Y',decode(e.complete_flag,'9',decode(e.relation_invoice_group_id,null,'N','Y'),'N'))) chk_2, " + 
	  "          f.proj_code  " + 
	  "     FROM p_gen_welfare a, p_pers_master b, " +
     "			 z_code_dept c, p_code_grade d, " +
     "          efin_invoice_header_itf  e, " +
     "          ( SELECT a.dept_code,c.proj_code						" +
     "  			 	 FROM Z_CODE_DEPT a,									" +
     "					      (SELECT proj_unq_key,step 					" +
     "						      FROM r_proj_view_business_form) b,	" +
     "							R_PROJ c											" +
     "	  		      WHERE a.proj_unq_key = b.proj_unq_key        " +
     "				     AND b.proj_unq_key = c.proj_unq_key        " +
     "				     AND b.step = c.step ) f							" +                    
     "  where a.emp_no = b.emp_no(+)    "  +
     "    and a.dept_code = c.dept_code(+) " +
     "    and a.dept_code = f.dept_code(+) " +
     "    and a.grade_code = d.grade_code(+) " +
     "    and a.invoice_num = e.invoice_group_id (+) " +
     "    and trunc(a.welfare_date,'mm') = '" + arg_from_date + "' " + 
     "    and a.comp_code like '" + arg_comp_code + "' " +
     "  ORDER BY  a.welfare_date, a.seq     ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>