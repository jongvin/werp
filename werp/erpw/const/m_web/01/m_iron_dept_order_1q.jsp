<%@ page session="true"  contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("month",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("meta",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("week_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("proj_tel",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("bigo",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("comp_week",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  a.dept_code ," + 
    					 "          a.tag, " +
						 "          to_char(a.month,'YYYY.MM.DD') month , " +
						 "          a.mtrcode ,  " +
						 "          a.seq , " +
						 "          a.meta , " +
						 "          a.week_qty ,  " +
						 "          a.sbcr_code , " +
						 "          a.sbcr_name , " +
						 "          b.tel_number1 proj_tel , " +
						 "          a.bigo, " +
						 "          a.comp_week,  " +
						 "          c.ssize " +
						 "  	FROM ( select '1' tag,dept_code,month,mtrcode,seq,meta,week1 week_qty,bigo, " +
						 "  					  sbcr_code1 sbcr_code,sbcr_name1 sbcr_name, to_char(month,'MM') || '월1주' comp_week " +
						 "  			   from m_iron_plan_detail " +
						 "  			  where dept_code = '" + arg_dept_code + "'" +
						 "					 and to_char(month,'yyyy.mm.dd') = '" + arg_yymm + "'" + 
						 "  			    and week1 > 0 " +
						 "  			 union all " +
						 "  			 select '2' tag,dept_code,month,mtrcode,seq,meta,week2 week_qty,bigo, " +
						 "  					  sbcr_code2 sbcr_code,sbcr_name2 sbcr_name, to_char(month,'MM') || '월2주' comp_week " +
						 "  			   from m_iron_plan_detail " +
						 "  			  where dept_code = '" + arg_dept_code + "'" +
						 "					 and to_char(month,'yyyy.mm.dd') = '" + arg_yymm + "'" + 
						 "  			    and week2 > 0 " +
						 "  			 union all " +
						 "  			 select '3' tag,dept_code,month,mtrcode,seq,meta,week3 week_qty,bigo, " +
						 "  					  sbcr_code3 sbcr_code,sbcr_name3 sbcr_name, to_char(month,'MM') || '월3주' comp_week " +
						 "  			   from m_iron_plan_detail " +
						 "  			  where dept_code = '" + arg_dept_code + "'" +
						 "					 and to_char(month,'yyyy.mm.dd') = '" + arg_yymm + "'" + 
						 "  			    and week3 > 0 " +
						 "  			 union all " +
						 "  			 select '4' tag,dept_code,month,mtrcode,seq,meta,week4 week_qty,bigo, " +
						 "  					  sbcr_code4 sbcr_code,sbcr_name4 sbcr_name, to_char(month,'MM') || '월4주' comp_week " +
						 "  			   from m_iron_plan_detail " +
						 "  			  where dept_code = '" + arg_dept_code + "'" +
						 "					 and to_char(month,'yyyy.mm.dd') = '" + arg_yymm + "'" + 
						 "  			    and week4 > 0 ) a, " +
						 "  		  s_sbcr b,  " +
						 "  		  m_code_material c , " +
						 "  		  m_iron_plan d  " +
						 "    WHERE a.sbcr_code = b.sbcr_code(+)  " +
						 "  	  and a.mtrcode  = c.mtrcode " +
						 "  	  and a.dept_code = d.dept_code " +
						 "  	  and a.month = d.month " +
						 "  	  and a.mtrcode = d.mtrcode " + 
						 "  	  and d.send_yn = 'Y' " +
     					 " ORDER BY a.seq          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>