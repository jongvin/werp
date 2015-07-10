<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     
 String arg_dept_code = req.getParameter("arg_dept_code");
 String arg_sell_code = req.getParameter("arg_sell_code");
 String arg_work_date = req.getParameter("arg_work_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("class",GauceDataColumn.TB_STRING,2));
	  dSet.addDataColumn(new GauceDataColumn("py_unit",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("sale_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sale_pyong_sum",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("agree_supply_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("agree_vat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("agree_sell_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cont_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cont_pyong_sum",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cont_supply_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cont_vat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cont_sell_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("income_r_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("income_delay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("income_discount_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "" + 
     "SELECT sale.pyong, sale.CLASS," + 
	  "    sale.pyong||'('||sale.CLASS||')' py_unit, "+
     "	 NVL(sale.sale_cnt,0)sale_cnt," + 
     "               ROUND(NVL(sale.SUM_PYONG,0)*NVL(sale.sale_cnt,0),3) sale_PYoNG_SUM," + 
     "               TRUNC(NVL(sale.agree_supply_amt,0)/1000000,0) agree_supply_amt," + 
     "               TRUNC(NVL(sale.agree_vat_amt,0)/1000000,0) agree_vat_amt," + 
     "	 TRUNC(NVL(sale.agree_sell_amt,0)/1000000,0) agree_sell_amt," + 
     "	 NVL(cont.cont_cnt,0)cont_cnt," + 
     "               ROUND(NVL(cont.SUM_PYONG,0)*NVL(cont.cont_cnt,0), 3) cont_PYONG_SUM," + 
     "	 TRUNC(NVL(cont.agree_supply_amt,0)/1000000,0) cont_supply_amt," + 
     "	 TRUNC(NVL(cont.agree_vat_amt,0)/1000000,0) cont_vat_amt," + 
     "	 TRUNC(NVL(cont.agree_sell_amt,0)/1000000,0) cont_sell_amt," + 
     "	 TRUNC(NVL(cont_income.income_r_amt,0)/1000000,0) income_r_amt," + 
     "               TRUNC(NVL(cont_income.income_delay_amt,0)/1000000,0) income_delay_amt," + 
     "               TRUNC(NVL(cont_income.income_discount_amt,0)/1000000,0) income_discount_amt" + 
     "  FROM (	SELECT MASTER.pyong, MASTER.CLASS," + 
     "	             NVL(COUNT(UNIQUE MASTER.dongho), 0) sale_cnt," + 
     "                MASTER.py SUM_PYONG," + 
     "                SUM(NVL(agree.land_amt,0)+NVL(agree.build_amt,0)) agree_supply_amt," + 
     "	             SUM(NVL(agree.vat_amt,0)) agree_vat_amt," + 
     "		          SUM(NVL(agree.sell_amt,0)) agree_sell_amt" + 
     "	        FROM (SELECT MASTER.dept_code, MASTER.sell_code, MASTER.dongho, MASTER.seq,MASTER.pyong, MASTER.CLASS," + 
     "                        MASTER.cntr_tag, " + 
     "                        ROUND((py.private_square+py.common_square+py.etc_square) * 0.3025,3) py" + 
     "                   FROM H_SALE_MASTER MASTER," + 
     "                        H_BASE_PYONG_MASTER py" + 
     "                  WHERE MASTER.dept_code = '"+arg_dept_code+"'" + 
     "                    AND MASTER.sell_code = '"+arg_sell_code+"'" + 
     "                    AND MASTER.last_contract_date <= '"+arg_work_date+"'" + 
     "				        AND MASTER.chg_date > '"+arg_work_date+"'" + 
     "                    AND MASTER.dept_code = py.dept_code" + 
     "                    AND MASTER.sell_code = py.sell_code" + 
     "                    AND MASTER.pyong = py.pyong(+)" + 
     "                    AND MASTER.style = py.style(+)" + 
     "                    AND MASTER.CLASS = py.CLASS(+)" + 
     "                    AND MASTER.option_code = py.option_code(+)" + 
     "                    " + 
     "                ) MASTER," + 
     "	             H_SALE_AGREE agree" + 
     "      	 WHERE MASTER.dept_code = agree.dept_code" + 
     "      	   AND MASTER.sell_code = agree.sell_code" + 
     "      		AND MASTER.dongho    = agree.dongho" + 
     "      		AND MASTER.seq       = agree.seq" + 
     "	     GROUP BY MASTER.dept_code, MASTER.sell_code,  MASTER.pyong, MASTER.CLASS, MASTER.py" + 
     "		  ORDER BY MASTER.pyong, MASTER.CLASS" + 
     "       ) sale," + 
     " 	    ( SELECT MASTER.pyong, MASTER.CLASS," + 
     "                NVL(COUNT(UNIQUE MASTER.dongho), 0) cont_cnt," + 
     "                MASTER.py SUM_PYONG," + 
     "	             SUM(NVL(agree.land_amt,0)+NVL(agree.build_amt,0)) agree_supply_amt," + 
     "		          SUM(NVL(agree.vat_amt,0)) agree_vat_amt," + 
     "		          SUM(NVL(agree.sell_amt,0)) agree_sell_amt" + 
     "	        FROM (SELECT MASTER.dept_code, MASTER.sell_code, MASTER.dongho, MASTER.seq,MASTER.pyong, MASTER.CLASS," + 
     "                        MASTER.cntr_tag, " + 
     "                        (py.private_square+py.common_square+py.etc_square) * 0.3025 py" + 
     "                   FROM H_SALE_MASTER MASTER," + 
     "                        H_BASE_PYONG_MASTER py" + 
     "                  WHERE MASTER.dept_code = '"+arg_dept_code+"'" + 
     "                    AND MASTER.sell_code = '"+arg_sell_code+"'" + 
     "                    AND MASTER.last_contract_date <= '"+arg_work_date+"'" + 
     "				        AND MASTER.chg_date > '"+arg_work_date+"'" + 
     "                    AND MASTER.chg_div <> '00'" + 
     "                    AND MASTER.dept_code = py.dept_code" + 
     "                    AND MASTER.sell_code = py.sell_code" + 
     "                    AND MASTER.pyong = py.pyong(+)" + 
     "                    AND MASTER.style = py.style(+)" + 
     "                    AND MASTER.CLASS = py.CLASS(+)" + 
     "                    AND MASTER.option_code = py.option_code(+)" + 
     "                    " + 
     "                ) MASTER," + 
     "                H_SALE_AGREE agree" + 
     "      	  WHERE MASTER.dept_code = agree.dept_code" + 
     "	         AND MASTER.sell_code = agree.sell_code" + 
     "		      AND MASTER.dongho    = agree.dongho" + 
     "		      AND MASTER.seq       = agree.seq" + 
     "		   GROUP BY MASTER.pyong, MASTER.CLASS,MASTER.py     ) cont," + 
     "" + 
     "       ( SELECT MASTER.pyong, MASTER.CLASS," + 
     "	             SUM(NVL(income.r_amt,0)) income_r_amt," + 
     "                SUM(NVL(income.delay_amt,0)) income_delay_amt," + 
     "                SUM(NVL(income.discount_amt,0)) income_discount_amt" + 
     "           FROM H_SALE_MASTER MASTER," + 
     "	             H_SALE_AGREE agree," + 
     "	             H_SALE_INCOME income" + 
     "          WHERE MASTER.dept_code = '"+arg_dept_code+"'" + 
     "	         AND MASTER.sell_code = '"+arg_sell_code+"'" + 
     "      		AND MASTER.last_contract_date <= '"+arg_work_date+"'" + 
     "      		AND MASTER.chg_date > '"+arg_work_date+"'" + 
     "      		AND MASTER.chg_div <> '00'" + 
     "      		AND MASTER.dept_code = agree.dept_code" + 
     "      		AND MASTER.sell_code = agree.sell_code" + 
     "      		AND MASTER.dongho    = agree.dongho" + 
     "      		AND MASTER.seq       = agree.seq" + 
     "      		AND agree.dept_code = income.dept_code" + 
     "      		  AND agree.sell_code = income.sell_code" + 
     "      		AND agree.dongho    = income.dongho" + 
     "      		AND agree.seq       = income.seq " + 
     "      		AND agree.degree_code = income.degree_code" + 
     "            AND income.receipt_date <= '"+arg_work_date+"'" + 
     "            AND  income.degree_seq < 70" + 
     "            " + 
     "	     GROUP BY MASTER.pyong, MASTER.CLASS" + 
     "       ) cont_income	" + 
     "  WHERE sale.pyong = cont.pyong(+)" + 
     "    AND sale.CLASS = cont.CLASS(+)" + 
     "	 AND sale.pyong = cont_income.pyong(+)" + 
     "    AND sale.CLASS = cont_income.CLASS(+)" + 
     "ORDER BY sale.pyong, sale.CLASS     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>