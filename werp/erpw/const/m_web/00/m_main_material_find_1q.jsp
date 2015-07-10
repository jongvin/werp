<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_name = req.getParameter("arg_name");
     arg_name = "%" + arg_name + "%";
//---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("seqmtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
    String query = "  SELECT substr('           ',1,(llevel-1) *2) || code seqmtrcode, " +
    	   "						  code mtrcode,                                             " +
    	   "						  name,                                                  " +
    	   "						  ssize,                                                 " +
    	   "						  unitcode                                               " +
			"			FROM ( select to_number(b.llevel) llevel,                         " +
			"							 b.mtrgrand seqcode,                                  " +
			"							 b.mtrgrand code,                                     " +
			"							 b.name,                                              " +
			"							 '' ssize,                                            " +
			"							 '' unitcode                                          " +
			"						from m_code_material_high b                              " +
			"						where b.llevel = 2                                       " +
			"					UNION ALL                                                   " +
			"					select to_number(b.llevel) + 1 llevel,                      " +
			"							 b.mtrgrand seqcode,                                  " +
			"							 a.mtrcode code,                                      " +
			"							 a.name,                                              " +
			"							 a.ssize,                                             " +
			"							 a.unitcode                                           " +
			"						from m_code_material a,                                  " +
			"							  m_code_material_high b                              " +
			"					where a.mtrgrand = b.mtrgrand )		                        " +
			"		where substr('           ',1,(llevel-1) *2) || code like '" + arg_name + "' or " +
			"           name like '" + arg_name + "'	" +  
			"	order by seqcode                                                       " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>