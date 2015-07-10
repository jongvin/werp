<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("part_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("item_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("part_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("item_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("or_item",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("or_point",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("d_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("contents",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("ol_point",GauceDataColumn.TB_STRING,3,0));
     dSet.addDataColumn(new GauceDataColumn("b_point",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("n_a",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("point_2",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("point_1",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("point_0",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("p_count",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("class",GauceDataColumn.TB_STRING,1));

    String query = " select a.dept_code, " +
		"							 to_char(a.yymm,'yyyymmdd') yymm, " +
		"							 a.part_code, " +
		"							 a.item_code, " +
		"							 a.seq, " +
		"							 a.part_name, " +
		"							 a.item_name, " +
		"							 a.or_item, " +
		"							 a.or_point, " +
		"							 (case when a.or_point <= 0 then 3 else mod(a.seq,2) end ) chk," +
		"							 b.d_seq, " +
		"							 b.contents, " +
		"							 decode(n_a,'T','N/A',a.or_point) ol_point, " +
		"							 b.or_point b_point ,"+
		"                     b.n_a, " +
		"                     b.point_2, " +
		"                     b.point_1, " +
		"                     b.point_0, " +
		"                     b.p_count, " +
		"							 b.remark , " +
		"							 '1'  class  " +
		"						from e_opinion_list a, e_opinion_detail b, " +
		"                      (select substr(a.safety_code,1,2) part_code, b.child_name, a.safety_code, a.child_name item_name from e_safety_code_child a, (select safety_code, child_name from e_safety_code_child where class_tag=077) b where a.class_tag=078 and substr(a.safety_code,1,2)=b.safety_code) c " +
		"						where a.item_code=b.item_code and a.seq=b.seq " +
		"                  		and a.part_code=c.part_code and a.item_code=c.safety_code " +
		"                       and a.dept_code = b.dept_code and a.yymm = b.yymm " +
		"                       and a.dept_code = '" + arg_dept_code + "' and a.yymm = '" + arg_yymm + "' " +
		"union all																													" +
		"																																" +	
		"select																														" +
		"   dept_code ,																											" +
		"   to_char(yymm,'yyyymmdd') yymm,																					" +
		"   '' part_code,  																										" +	
		"   '' item_code,  																										" +
		"   seq,																														" +	
		"   '감정항목' part_name , 																								" +
		"   '감점요인' item_name , 																								" +	
		"   contents ,																												" +
		"   or_point , 																											" +
		"   3 chk , 																												" +	
		"   null d_seq,																											" +
		"   null contents,																										" +
		"   to_char(or_point) ol_point,																						" +	
		"   or_point ,																												" +	
		"   null n_a,																												" +
		"   null point_2,																											" +
		"   null	point_1,																											" +
		"   null point_0,																											" +	
		"   null	p_count,																											" +	
		"   remark ,																												" +
		"   '2' class																												" +	
		"from e_opinion_minus_detail																							" +
		"where																														" +
		"   dept_code = '" + arg_dept_code + "' and yymm = '" + arg_yymm + "'									" +	
		" order by class ASC, item_code ASC, seq ASC, d_seq ASC 														" ;



%><%@ include file="../../../comm_function/conn_q_end.jsp"%>