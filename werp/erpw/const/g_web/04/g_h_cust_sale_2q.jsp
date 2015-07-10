<%@ page session="true"		   contentType="text/html; charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     
 String arg_dept_code = req.getParameter("arg_dept_code");
 String arg_sell_code = req.getParameter("arg_sell_code");
 String arg_sido = req.getParameter("arg_sido");
 String arg_gugun = req.getParameter("arg_gugun");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sort_tag",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("sido",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("gugun",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("sex",GauceDataColumn.TB_STRING,10));
	  dSet.addDataColumn(new GauceDataColumn("sex_color",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sex_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     String query = "SELECT aa.sort_tag,    				 "+
  "               aa.sido,    																 "+
  "               aa.gugun,																  "+
  "               DECODE(aa.sex, '1', '남', '2', '여', '기타')sex,    "+
  "               DECODE(aa.sex, '1', 'blue', '2', 'red', 'grey')sex_color,    "+
  "               SUM(NVL(aa.cnt,0)) sex_cnt										 "+
  "    FROM(  																										 "+
  "    SELECT  DISTINCT c.long_name,   									  "+
  "           a.dongho AS dongho,   																"+
  "           DECODE(f.sido, '서울', '1', '경기', '2', '제주', '8', NULL, '9', '3') || NVL(f.sido, '기타') || f.gugun  sort_tag,   "+
  "           NVL(f.sido, '기타')  sido,    														 "+
  "           NVL(f.gugun, '기타') gugun,    												  "+
  "           0  subs_cnt,      																				  "+
  "           DECODE(a.contract_code, '03', 1, 0) lease_cnt,    "+  
  "           DECODE(a.contract_code, '01', 1, 0) sale_cnt,  		"+
  "           DECODE(a.contract_code, '02', 1, 0) union_cnt,    "+  
  "           SUBSTR(REPLACE(b.cust_code,'-',''),7,1) sex,      "+ 
  "           1 cnt    																									  "+
  "               																													"+
  "   	FROM H_SALE_MASTER   a,  														 "+
  "   	     H_CODE_CUST	 	b,  																		  "+
  "   	     H_CODE_DEPT     c,  																	 "+
  "   	     Z_CODE_ZIP      f  																				  "+
  "   	WHERE a.cust_code = b.cust_code 	   								  "+
  "   	  AND a.dept_code = c.dept_code 	   										 "+
  "   	  AND b.cur_zip_code = f.zipcode (+)	   									 "+
  "   	  AND a.contract_yn = 'Y'   																	 "+
  "   	  AND a.dept_code = '"+arg_dept_code  +"'"+
  "   	  AND a.sell_code = '"+arg_sell_code+"'"+
  "      ) AA																														  "+
  "   WHERE  aa.sido = '"+arg_sido+"'"+																	
  "   AND aa.gugun = '"+arg_gugun+"'"+  
  "    GROUP BY aa.sort_tag,                                                        "+
  "               aa.sido,    																							  "+
  "               aa.gugun,aa.sex          																  "+
"	     ORDER BY aa.sort_tag    ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>