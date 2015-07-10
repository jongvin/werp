<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     
 String arg_dept_code = req.getParameter("arg_dept_code");
 String arg_sell_code = req.getParameter("arg_sell_code");
 String arg_work_date = req.getParameter("arg_work_date");
 String arg_process_tag = req.getParameter("arg_process_tag");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("code_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sale_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sale_pyong_sum",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("agree_sell_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cont_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cont_pyong_sum",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cont_sell_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("income_r_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("income_delay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("income_discount_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("midore_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("dore_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "" + 
     "SELECT sale.dept_code, dept.long_name, sale.sell_code, sell.code_name," + 
     "            NVL(sale.sale_cnt,0) sale_cnt," + 
     "            NVL(sale.SUM_PYONG,0) sale_PYoNG_SUM," + 
     "            TRUNC(NVL(sale.agree_sell_amt,0)/1000000,0) agree_sell_amt," + 
     "            NVL(cont.sale_cnt,0) cont_cnt," + 
     "            NVL(cont.SUM_PYONG,0) cont_PYONG_SUM," + 
     "            TRUNC(NVL(cont.agree_sell_amt,0)/1000000,0) cont_sell_amt," + 
     "            TRUNC(NVL(cont_income.income_r_amt,0)/1000000,0) income_r_amt," + 
     "            TRUNC(NVL(cont_income.income_delay_amt,0)/1000000,0) income_delay_amt," + 
     "            TRUNC(NVL(cont_income.income_discount_amt,0)/1000000,0) income_discount_amt," + 
     "            TRUNC(NVL(midore.midore_amt,0)/1000000,0) midore_amt," + 
     "            TRUNC(NVL(midore.dore_amt,0)/1000000,0) dore_amt" + 
     "  FROM" + 
     "      ( SELECT MASTER.dept_code, MASTER.sell_code," + 
     "	       NVL(COUNT(MASTER.dongho), 0) AS sale_cnt," + 
     "                     SUM(NVL(MASTER.py,0)) AS SUM_PYONG," + 
     "	       SUM(NVL(MASTER. agree_sell_amt,0)) agree_sell_amt" + 
     "         FROM (SELECT MASTER.dept_code, MASTER.sell_code, MASTER.dongho, MASTER.seq," + 
     "                                ROUND((py.private_square*0.3025)+(py.common_square*0.3025)+(py.etc_square*0.3025),4) AS py," + 
     "                                SUM(NVL(agree.sell_amt,0)) agree_sell_amt" + 
     "                     FROM H_SALE_MASTER MASTER," + 
     "                               H_BASE_PYONG_MASTER py," + 
     "                               H_SALE_AGREE agree," + 
     "		    H_CODE_DEPT dept" + 
     "                  WHERE MASTER.dept_code LIKE '"+arg_dept_code+"'||'%'" + 
     "                    AND MASTER.sell_code LIKE '"+arg_sell_code+"'||'%'" + 
     "                    and MASTER.last_contract_date <= '"+arg_work_date+"'" + 
     "	       AND MASTER.chg_date > '"+arg_work_date+"'" + 
     "                    AND MASTER.dept_code = py.dept_code" + 
     "                    AND MASTER.sell_code = py.sell_code" + 
     "                    AND MASTER.pyong = py.pyong(+)" + 
     "                    AND MASTER.style = py.style(+)" + 
     "                    AND MASTER.CLASS = py.CLASS(+)" + 
     "                    AND MASTER.option_code = py.option_code(+)" + 
     "                    " + 
     "" + 
     "                    AND dept.process_code LIKE DECODE('"+arg_process_tag+"', 'ALL', '%', '"+arg_process_tag+"')" + 
     "					AND MASTER.dept_code = dept.dept_code" + 
     "" + 
     "                    AND MASTER.dept_code = agree.dept_code" + 
     "                    AND MASTER.sell_code = agree.sell_code" + 
     "                    AND MASTER.dongho = agree.dongho" + 
     "                    AND MASTER.seq = agree.seq" + 
     "					" + 
     "                  GROUP BY MASTER.dept_code, MASTER.sell_code, MASTER.dongho, MASTER.seq," + 
     "                               ROUND((py.private_square*0.3025)+(py.common_square*0.3025)+(py.etc_square*0.3025),4) " + 
     "             ) MASTER" + 
     "	            " + 
     "                 GROUP BY MASTER.dept_code, MASTER.sell_code" + 
     "       ) sale ,  " + 
     "	   " + 
     " 	    ( SELECT MASTER.dept_code, MASTER.sell_code," + 
     "	            NVL(COUNT(MASTER.dongho), 0) AS sale_cnt," + 
     "                           SUM(NVL(MASTER.py,0)) AS SUM_PYONG," + 
     "	             SUM(NVL(MASTER. agree_sell_amt,0)) agree_sell_amt" + 
     "                         FROM " + 
     "		(SELECT MASTER.dept_code, MASTER.sell_code, MASTER.dongho, MASTER.seq, " + 
     "                                ROUND((py.private_square*0.3025)+(py.common_square*0.3025)+(py.etc_square*0.3025),4) AS py," + 
     "                                 SUM(NVL(agree.sell_amt,0)) agree_sell_amt" + 
     "                              FROM " + 
     "                                 H_SALE_MASTER MASTER," + 
     "                                H_BASE_PYONG_MASTER py," + 
     "                                 H_SALE_AGREE agree," + 
     "                                 H_CODE_DEPT dept" + 
     "                         WHERE MASTER.dept_code LIKE '"+arg_dept_code+"'||'%'" + 
     "                    AND MASTER.sell_code LIKE '"+arg_sell_code+"'||'%'" + 
     "                           AND MASTER.last_contract_date <= '"+arg_work_date+"'" + 
     "	            AND MASTER.chg_date > '"+arg_work_date+"'" + 
     "                         AND MASTER.chg_div <> '00'" + 
     "                         AND MASTER.dept_code = py.dept_code" + 
     "                        AND MASTER.sell_code = py.sell_code" + 
     "                        AND MASTER.pyong = py.pyong(+)" + 
     "                        AND MASTER.style = py.style(+)" + 
     "                    AND MASTER.CLASS = py.CLASS(+)" + 
     "                    AND MASTER.option_code = py.option_code(+)" + 
     "                    " + 
     "" + 
     "                    AND dept.process_code LIKE DECODE('"+arg_process_tag+"', 'ALL', '%', '"+arg_process_tag+"')" + 
     "					AND MASTER.dept_code = dept.dept_code" + 
     "					" + 
     "                    AND MASTER.dept_code = agree.dept_code" + 
     "                    AND MASTER.sell_code = agree.sell_code" + 
     "                    AND MASTER.dongho = agree.dongho" + 
     "                    AND MASTER.seq = agree.seq" + 
     "					" + 
     "		     GROUP BY MASTER.dept_code, MASTER.sell_code, MASTER.dongho, MASTER.seq," + 
     "                      ROUND((py.private_square*0.3025)+(py.common_square*0.3025)+(py.etc_square*0.3025),4)				" + 
     "                ) MASTER" + 
     "	     GROUP BY MASTER.dept_code, MASTER.sell_code		   " + 
     "		    ) cont," + 
     "" + 
     "       ( SELECT MASTER.dept_code, MASTER.sell_code," + 
     "                SUM(NVL(income.r_amt,0)) income_r_amt," + 
     "                SUM(NVL(income.delay_amt,0)) income_delay_amt," + 
     "                SUM(NVL(income.discount_amt,0)) income_discount_amt" + 
     "           FROM H_SALE_MASTER MASTER," + 
     "	             H_SALE_AGREE agree," + 
     "	             H_SALE_INCOME income," + 
     "                 H_CODE_DEPT dept" + 
     "" + 
     "          WHERE MASTER.dept_code LIKE '"+arg_dept_code+"'||'%'" + 
     "                    AND MASTER.sell_code LIKE '"+arg_sell_code+"'||'%'" + 
     "      		AND MASTER.last_contract_date <= '"+arg_work_date+"'" + 
     "      		AND MASTER.chg_date > '"+arg_work_date+"'" + 
     "      		AND MASTER.chg_div <> '00'" + 
     "      		AND MASTER.dept_code = agree.dept_code" + 
     "      		AND MASTER.sell_code = agree.sell_code" + 
     "      		AND MASTER.dongho    = agree.dongho" + 
     "      		AND MASTER.seq       = agree.seq" + 
     "      		AND agree.dept_code = income.dept_code" + 
     "      		AND agree.sell_code = income.sell_code" + 
     "      		AND agree.dongho    = income.dongho" + 
     "      		AND agree.seq       = income.seq " + 
     "      		AND agree.degree_code = income.degree_code" + 
     "            AND income.receipt_date <= '"+arg_work_date+"'" + 
     "            AND income.degree_seq < 70" + 
     "            " + 
     "            AND dept.process_code LIKE DECODE('"+arg_process_tag+"', 'ALL', '%', '"+arg_process_tag+"')" + 
     "			AND MASTER.dept_code = dept.dept_code" + 
     "			" + 
     "			" + 
     "	     GROUP BY MASTER.dept_code, MASTER.sell_code" + 
     "       ) cont_income,	" + 
     "	   " + 
     "	    ( SELECT MASTER.dept_code, MASTER.sell_code, " + 
     "                     SUM(CASE WHEN agree.agree_date > '"+arg_work_date+"' THEN NVL(agree.sell_amt,0) ELSE 0 END ) midore_amt," + 
     "                     SUM(CASE WHEN agree.agree_date <= '"+arg_work_date+"' THEN NVL(agree.sell_amt,0) ELSE 0 END ) dore_amt" + 
     "                   FROM H_SALE_MASTER MASTER," + 
     "						H_SALE_AGREE agree," + 
     "                        H_CODE_DEPT dept" + 
     "" + 
     "" + 
     "                   WHERE MASTER.dept_code LIKE '"+arg_dept_code+"'||'%'" + 
     "                    AND MASTER.sell_code LIKE '"+arg_sell_code+"'||'%'" + 
     "                    AND MASTER.chg_div <> '00' AND (MASTER.contract_date  <='"+arg_work_date+"'" + 
     "					AND MASTER.chg_date >= '"+arg_work_date+"' AND MASTER.last_contract_date < '"+arg_work_date+"'  )" + 
     "                    " + 
     "                    AND dept.process_code LIKE DECODE('"+arg_process_tag+"', 'ALL', '%', '"+arg_process_tag+"')" + 
     "		            AND MASTER.dept_code = dept.dept_code					" + 
     "                    AND MASTER.dept_code = agree.dept_code" + 
     "                    AND MASTER.sell_code = agree.sell_code" + 
     "                    AND MASTER.dongho = agree.dongho" + 
     "                    AND MASTER.seq = agree.seq" + 
     "					" + 
     "		     GROUP BY MASTER.dept_code, MASTER.sell_code ) midore," + 
     "" + 
     "        H_CODE_DEPT dept," + 
     "		H_CODE_COMMON sell" + 
     "	   " + 
     "  WHERE sale.dept_code = cont.dept_code(+)" + 
     "    AND sale.sell_code = cont.sell_code(+)" + 
     "	 AND sale.dept_code = cont_income.dept_code(+)" + 
     "    AND sale.sell_code = cont_income.sell_code(+)" + 
     "	 AND sale.dept_code = midore.dept_code(+)" + 
     "    AND sale.sell_code = midore.sell_code(+)" + 
     "	 AND sale.dept_code = dept.dept_code(+)" + 
     "    AND sale.sell_code = sell.code" + 
     "	AND sell.code_div = '03'" + 
     " order by long_name, sell_code	" + 
     "     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>