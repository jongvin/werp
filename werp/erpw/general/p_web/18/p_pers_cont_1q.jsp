<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_tag = req.getParameter("arg_tag");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("school_car_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("last_school_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("contract_sdate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("contract_edate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("zip_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("addr1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("addr2",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("house_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cell_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("e_mail",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,2000));
    String query = "  SELECT  a.emp_no ," + 
					    "          a.resident_no ," + 
					    "          a.emp_name ," + 
					    "          a.comp_code ," + 
					    "          a.dept_code ," + 
					    "          b.short_name dept_name ," + 
					    "          a.grade_code ," + 
					    "          a.school_car_code ," + 
					    "          a.last_school_name ," + 
					    "          a.contract_sdate ," + 
					    "          a.contract_edate ," + 
					    "          a.zip_code ," + 
					    "          a.addr1 ," + 
					    "          a.addr2 ," + 
					    "          a.house_phone ," + 
					    "          a.cell_phone ," + 
					    "          a.e_mail ," + 
					    "          a.remark  " +
					    "	    FROM p_pers_cont a,       " +
					    "	         z_code_dept b        " +
					    "		where a.dept_code = b.dept_code(+) " ;
					    
     					 if (arg_tag.equals("1")) {   // 재직
		   				 query += " and contract_sdate <= to_date(sysdate) ";
  							 query += "	and (contract_edate >= to_date(sysdate) or contract_edate is null) ";
						 }
						 
						 if (arg_tag.equals("2")) {   // 퇴직
		   				 query += " and contract_edate <= to_date(sysdate) ";
						 }
						 
     					 query += "	order by emp_name";
     					 
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>