<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_where = req.getParameter("arg_where");
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
    String query = "  " + 
    " SELECT    b.dept_code ,                                                                " + 
    "           a.chg_no_seq ,                                                               " + 
    "           a.name ,                                                                     " + 
    "           to_char(b.chg_const_start_date,'yyyy.mm.dd') chg_const_start_date ,          " + 
    "           to_char(b.chg_const_end_date,'yyyy.mm.dd')  chg_const_end_date ,             " + 
    "           b.ground_area,                                                               " + 
    "           b.gross_floor_area_sum,                                                      " + 
    "           b.floor,                                                                     " + 
    "          to_char(b.CHG_CONST_START_DATE,'YYYY.MM.DD') chg_const_start_date,            " + 
    "          to_char(b.CHG_CONST_END_DATE,'YYYY.MM.DD')   chg_const_end_date,              " + 
    "          b.long_name,                                                                  " + 
    "          nvl(a.gong_per,0) gong_per,                                                   " + 
    "          nvl(a.won_per,0) won_per,                                                     " + 
    "          nvl(a.yymm,' ') yymm                                                          " + 
    "        FROM                                                                            " + 
    "            z_code_dept b,                                                              " + 
    "            (select a.dept_code,a.chg_no_seq,max(a.name) name, sum(a.gong_per) gong_per, sum(a.won_per) won_per, max(a.yymm) yymm " + 
    "            from  ( SELECT  A.DEPT_CODE dept_code,A.chg_no_seq chg_no_seq ,a.name name ,0 gong_per,0 won_per ,null yymm           " + 
    "                         from c_chg_progress a                                                                                    " + 
    "                      UNION ALL                                                                                                   " + 
    "                      SELECT A.DEPT_CODE,1,null,                                                                                  " + 
    "                            DECODE(A.AMT,0,0,TRUNC((A.RESULT_AMT + A.LS_RESULT_AMT) / A.AMT * 100,2)) GONG_PER,                   " + 
    "                            DECODE(A.AMT,0,0,TRUNC((A.COST_AMT + A.LS_COST_AMT) / A.AMT * 100,2)) WON_PER,                        " + 
    "                            TO_CHAR(C.YYMM,'YYYY.MM') YYMM                                                                        " + 
    "                                  FROM  C_SPEC_CONST_PARENT A,                                                                    " + 
    "                                              Y_BUDGET_PARENT B,                                                                  " + 
    "                                              ( SELECT A.DEPT_CODE,B.SUM_CODE,MAX(A.YYMM) YYMM                                    " + 
    "                                                  FROM C_SPEC_CONST_PARENT A, Y_CHG_BUDGET_PARENT B                               " + 
    "                                                 WHERE A.DEPT_CODE = B.DEPT_CODE                                                  " + 
    "                                                   AND A.SPEC_NO_SEQ = B.SPEC_NO_SEQ                                              " + 
    "                                                   AND B.SUM_CODE = '01'                                                          " + 
    "                                                 GROUP BY A.DEPT_CODE,B.SUM_CODE order by a.dept_code,B.sum_code) C               " +     
    "                                          WHERE A.DEPT_CODE = B.DEPT_CODE                                                         " + 
    "                                          AND A.SPEC_NO_SEQ = B.SPEC_NO_SEQ                                                       " + 
    "                                          AND B.SUM_CODE = C.SUM_CODE                                                             " + 
    "                                          AND B.DEPT_CODE = C.DEPT_CODE                                                           " + 
    "                                          AND B.SUM_CODE = '01'                                                                   " + 
    "                                          AND A.YYMM  = C.YYMM  ) a group by a.dept_code,a.chg_no_seq order by a.dept_code) a     " + 
     "      WHERE       " + 
     "  " + arg_where + " " + 
     "    " ;     
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>