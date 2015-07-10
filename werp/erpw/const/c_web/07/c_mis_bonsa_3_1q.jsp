<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_where = req.getParameter("arg_where");
     String arg_empno     = req.getParameter("arg_empno");
     String arg_authority_dept = req.getParameter("arg_authority_dept");
     String arg_yymm = req.getParameter("arg_yymm");
     
     arg_where = arg_where.replace('!','+'); 
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("chg_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("chg_const_start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("chg_const_end_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("ground_area",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("gross_floor_area_sum",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("floor",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("gong_per",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("won_per",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("proj_unq_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_result_per",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("chg_class",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  b.dept_code ," + 
     "          a.chg_no_seq ," + 
     "          a.name ," + 
     "          to_char(a.chg_const_start_date,'yyyy.mm.dd') chg_const_start_date ," + 
     "          to_char(a.chg_const_end_date,'yyyy.mm.dd')  chg_const_end_date , " + 
     "          b.ground_area,    " + 
     "          b.gross_floor_area_sum,    " + 
     "          b.floor,    " + 
     "         to_char(b.CHG_CONST_START_DATE,'YYYY.MM.DD') chg_const_start_date,   " + 
     "         to_char(b.CHG_CONST_END_DATE,'YYYY.MM.DD')   chg_const_end_date,   " + 
     "         b.long_name, " + 
     "         nvl(c.gong_per,0) gong_per, " + 
     "         nvl(c.won_per,0) won_per, " + 
     "         nvl(c.yymm,' ') yymm, " + 
     "         nvl(b.proj_unq_key,0)  proj_unq_key, " + 
     "         c.amt,        " +                       //실행금액(본실행)
     "         c.pre_result_amt," +                    //준공추정
     "         decode(nvl(c.amt,0),0,0,trunc(nvl(c.pre_result_amt,0) / c.amt * 100,1)) pre_result_per, " +   //준공추정율계산
     "         z.chg_class  " + 
     "       FROM c_chg_progress a, " + 
     "           z_code_dept b, " + 
     "           (SELECT A.DEPT_CODE,DECODE(A.PRE_RESULT_AMT,0,0,TRUNC((A.COST_AMT + A.LS_COST_AMT) / A.PRE_RESULT_AMT * 100,2)) GONG_PER, " + 
     "                                   DECODE(A.AMT,0,0,TRUNC((A.COST_AMT + A.LS_COST_AMT) / A.AMT * 100,2)) WON_PER,TO_CHAR(C.YYMM,'YYYY.MM') YYMM,  " +
     "                               B.amt amt, a.pre_result_amt  " + 
     "                               FROM  C_SPEC_CONST_PARENT A,                                   " + 
     "                                     Y_BUDGET_PARENT B,                                       " + 
     "                                     ( SELECT A.DEPT_CODE,B.SUM_CODE,A.YYMM YYMM         " + 
     "                                         FROM C_SPEC_CONST_PARENT A, Y_BUDGET_PARENT B    " + 
     "                                        WHERE A.DEPT_CODE = B.DEPT_CODE                       " + 
     "                                          AND A.SPEC_NO_SEQ = B.SPEC_NO_SEQ                   " + 
     "                                          AND B.SUM_CODE = '01'                               " + 
     "                                          and a.yymm >= '" + arg_yymm + "'   " + 
     "                                          and a.yymm <= add_months(to_date('" + arg_yymm + "'),3)   " + 
     "                                         ) C                   " + 
     "                                 WHERE A.DEPT_CODE = B.DEPT_CODE                              " + 
     "                                 AND A.SPEC_NO_SEQ = B.SPEC_NO_SEQ                            " + 
     "                                 AND B.SUM_CODE = C.SUM_CODE                                  " + 
     "                                 AND B.DEPT_CODE = C.DEPT_CODE  " + 
     "                                 AND B.SUM_CODE = '01'  " + 
     "                                 AND A.YYMM  = C.YYMM  order by a.dept_code)  c, " +
     "       (select dept_code,max(chg_no_seq) chg_no_seq from c_chg_progress group by dept_code) d, " + 
     "       (select a.dept_code,b.chg_class  " + 
     "               from (select dept_code,max(chg_no_seq) chg_no_seq " +  
     "                       from y_chg_degree  " + 
     "                       where approve_class = '4' " + 
     "                       group by dept_code) a, " +
     "                   y_chg_degree b " + 
     "               where a.dept_code = b.dept_code " + 
     "                 and a.chg_no_seq = b.chg_no_seq ) z, "; 
     query = query + " ( SELECT  view_dept_code.dept_code dept_code " + 
     "     FROM view_dept_code,  ";
     if ( arg_authority_dept.equals("A") ) {
     	   query = query + " z_authority_user " ;
     }
     else  {   
     	   query = query + " z_authority_userprojcode " ;
     }	   
     query = query + " " + 
     "     WHERE  ( view_dept_code.dept_proj_tag = 'P' )    and  ";
     if ( arg_authority_dept.equals("0") ) {
     	   query = query + " z_authority_userprojcode.empno(+) = '" + arg_empno + "' and  " +
     		                " view_dept_code.dept_code = z_authority_userprojcode.dept_code(+) " ;
     }
     else if ( arg_authority_dept.equals("A") ) {
     		query = query + " z_authority_user.empno = '" + arg_empno + "' and  " +
     		                " view_dept_code.dept_code = z_authority_user.dept_code" ;
     	 
     }
     else 
     {
     		query = query + " z_authority_userprojcode.empno = '" + arg_empno + "' and  " +
     		                " view_dept_code.dept_code = z_authority_userprojcode.dept_code " ;
     	}
     query = query + "         order by   view_dept_code.dept_code ) e    " ;
     query = query + "      WHERE a.dept_code = d.dept_code " +
     "        and a.chg_no_seq = d.chg_no_seq " + 
     "        and e.dept_code = d.dept_code " +  
     "        and e.dept_code = z.dept_code " +  
     "        and c.yymm  >= substr('" + arg_yymm + "',1,7) " +  
     "        and   " + 
     "  " + arg_where + " " + 
     "    " ;      
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>