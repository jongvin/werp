<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     
 String arg_dept_code = req.getParameter("arg_dept_code");
 String arg_sell_code = req.getParameter("arg_sell_code");
 String arg_work_date = req.getParameter("arg_work_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_STRING,18,0));
	  dSet.addDataColumn(new GauceDataColumn("sale_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cont_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("regi_bef_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("regi_today_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     
    String query = "" + 
     " SELECT  sale.pyong,                                                                                                     "+
	 " NVL(sale.sale_cnt,0) sale_cnt,																													 "+
	 " NVL(cont.cont_cnt,0) cont_cnt,																													  "+
	 " NVL(regi_bef.regi_bef_cnt,0) regi_bef_cnt,																						   "+
	 " NVL(regi_today.regi_today_cnt,0) regi_today_cnt																			 "+
    " FROM																																													 "+
    "      (SELECT MASTER.pyong, NVL(COUNT( MASTER.dongho), 0) sale_cnt				 "+
    "                FROM H_SALE_MASTER MASTER																						  "+
    "               WHERE MASTER.dept_code = '"+arg_dept_code+"'"+
    "                 AND MASTER.sell_code = '"+arg_sell_code+"'"+
    "                 AND MASTER.last_contract_date <= '"+arg_work_date+"'"+
	 "     AND MASTER.chg_date > '"+arg_work_date+"'"+
    "                																																												 "+
	 "     GROUP BY  MASTER.pyong																															 "+
    "    ) sale,																																													 "+
 	 "    ( SELECT MASTER.pyong, 																																 "+
    "             NVL(COUNT( MASTER.dongho), 0) cont_cnt																			 "+
    "                FROM H_SALE_MASTER MASTER																							   "+
    "               WHERE MASTER.dept_code = '"+arg_dept_code+"'"+
    "                 AND MASTER.sell_code = '"+arg_sell_code+"'"+
    "                 AND MASTER.last_contract_date <= '"+arg_work_date+"'"+
    "                AND MASTER.chg_date > '"+arg_work_date+"'"+
    "                 AND MASTER.chg_div <> '00'																									  "+
	" 	   GROUP BY MASTER.pyong																															  "+
	" 	        ) cont,																																										 "+
	" 																																																 "+
 	"     ( SELECT MASTER.pyong, 																															 "+
   "              NVL(COUNT( UNIQUE MASTER.dongho), 0) regi_bef_cnt									  "+
   "                 FROM H_SALE_MASTER MASTER																						 "+
   "                WHERE MASTER.dept_code = '"+arg_dept_code+"'"+
   "                  AND MASTER.sell_code = '"+arg_sell_code+"'"+
   "                  AND MASTER.regist_date < '"+arg_work_date+"'"+
  " 		   GROUP BY MASTER.pyong																													   "+
	" 	        ) regi_bef,																																								 "+
	" 																																																	 "+
 	"     ( SELECT MASTER.pyong, 																															 "+
   "              NVL(COUNT( MASTER.dongho), 0) regi_today_cnt													   "+
   "                 FROM H_SALE_MASTER MASTER																						 "+
   "                WHERE MASTER.dept_code = '"+arg_dept_code+"'"+
   "                   AND MASTER.sell_code = '"+arg_sell_code+"'"+
   "                  AND MASTER.regist_date =  '"+arg_work_date+"'"+
   " 		   GROUP BY MASTER.pyong																													   "+
	" 	        ) regi_today																																						   "+
   "  WHERE sale.pyong = cont.pyong(+) AND																							   "+
   "         sale.pyong = regi_bef.pyong(+) AND																								  "+
   "         sale.pyong = regi_today.pyong(+)    ";																								 
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>