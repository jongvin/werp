CREATE OR REPLACE FORCE VIEW V_H_SALE_DATA
(DEPT_CODE, SALE_CNT_APT, SALE_BUILD_AREA_APT, SALE_LAND_AREA_APT, SALE_SUPPLY_AMT_APT, 
 CONT_CNT_APT, CONT_BUILD_AREA_APT, CONT_LAND_AREA_APT, CONT_SUPPLY_AMT_APT, SALE_CNT_ETC, 
 SALE_BUILD_AREA_ETC, SALE_LAND_AREA_ETC, SALE_SUPPLY_AMT_ETC, CONT_CNT_ETC, CONT_BUILD_AREA_ETC, 
 CONT_LAND_AREA_ETC, CONT_SUPPLY_AMT_ETC)
AS 
SELECT dept_code,
       SUM(NVL(sale_cnt_apt,0))   sale_cnt_apt,
       SUM(NVL(sale_build_area_apt,0)) 	sale_build_area_apt,
       SUM(NVL(sale_land_area_apt,0))  	sale_land_area_apt,
       SUM(NVL(sale_supply_amt_apt,0))	sale_supply_amt_apt,
       SUM(NVL(cont_cnt_apt,0))               	       cont_cnt_apt,
       SUM(NVL(cont_build_area_apt,0)) 	       cont_build_area_apt,
       SUM(NVL(cont_land_area_apt,0))  	       cont_land_area_apt,
       SUM(NVL(cont_supply_amt_apt,0))	cont_supply_amt_apt,
       SUM(NVL(sale_cnt_etc,0))               	        sale_cnt_etc,
       SUM(NVL(sale_build_area_etc,0)) 	      sale_build_area_etc,
       SUM(NVL(sale_land_area_etc,0))  	        sale_land_area_etc,
       SUM(NVL(sale_supply_amt_etc,0))	sale_supply_amt_etc,
       SUM(NVL(cont_cnt_etc,0))                	cont_cnt_etc,
       SUM(NVL(cont_build_area_etc,0)) 	       cont_build_area_etc,
       SUM(NVL(cont_land_area_etc,0))  	       cont_land_area_etc,
       SUM(NVL(cont_supply_amt_etc,0)) 	cont_supply_amt_etc
  FROM
       (
SELECT sale.dept_code,
       DECODE(sale.apt_or_etc, 'apt', sale.sale_cnt , 0) sale_cnt_apt,
       DECODE(sale.apt_or_etc, 'apt', sale.build_area, 0) sale_build_area_apt,
       DECODE(sale.apt_or_etc, 'apt', sale.land_area, 0)  sale_land_area_apt,
		 DECODE(sale.apt_or_etc, 'apt', sale.sale_supply_amt, 0) sale_supply_amt_apt,
		 DECODE(cont.apt_or_etc, 'apt', cont.cont_cnt, 0) cont_cnt_apt,
       DECODE(cont.apt_or_etc, 'apt', cont.build_area, 0) cont_build_area_apt,
       DECODE(cont.apt_or_etc, 'apt', cont.land_area, 0)  cont_land_area_apt,
		 DECODE(cont.apt_or_etc, 'apt', cont.cont_supply_amt, 0) cont_supply_amt_apt,
       DECODE(sale.apt_or_etc, 'etc', sale.sale_cnt , 0) sale_cnt_etc,
       DECODE(sale.apt_or_etc, 'etc', sale.build_area, 0) sale_build_area_etc,
       DECODE(sale.apt_or_etc, 'etc', sale.land_area, 0)  sale_land_area_etc,
		 DECODE(sale.apt_or_etc, 'etc', sale.sale_supply_amt, 0) sale_supply_amt_etc,
		 DECODE(cont.apt_or_etc, 'etc', cont.cont_cnt, 0) cont_cnt_etc,
       DECODE(cont.apt_or_etc, 'etc', cont.build_area, 0) cont_build_area_etc,
       DECODE(cont.apt_or_etc, 'etc', cont.land_area, 0)  cont_land_area_etc,
		 DECODE(cont.apt_or_etc, 'etc', cont.cont_supply_amt, 0) cont_supply_amt_etc
  FROM (	SELECT MASTER.dept_code,
                DECODE(MASTER.sell_code, '01', 'apt', 'etc') apt_or_etc,
                NVL(COUNT(UNIQUE MASTER.dongho), 0) sale_cnt,
                SUM(NVL(MASTER.build_area, 0)) build_area,
                SUM(NVL(MASTER.land_area, 0))  land_area,
                SUM(NVL(agree.land_amt,0)+NVL(agree.build_amt,0)) sale_supply_amt
			  FROM (SELECT MASTER.dept_code, MASTER.sell_code, MASTER.dongho, MASTER.seq,
                        NVL(py.private_square,0)+NVL(py.common_square,0)+NVL(py.etc_square,0)+
                        NVL(py.parking_square,0)+NVL(py.service_square, 0) build_area,
                        py.grand_square land_area
                   FROM H_SALE_MASTER MASTER,
                        H_BASE_PYONG_MASTER py
                  WHERE MASTER.last_contract_date <= TO_DATE('2999.01.01','yyyy.mm.dd')
				        AND MASTER.chg_date > TO_DATE('2999.01.01','yyyy.mm.dd')
                    AND MASTER.dept_code = py.dept_code(+)
                    AND MASTER.sell_code = py.sell_code(+)
                    AND MASTER.pyong = py.pyong(+)
                    AND MASTER.style = py.style(+)
                    AND MASTER.CLASS = py.CLASS(+)
                    AND MASTER.option_code = py.option_code(+)
                ) MASTER,
			         H_SALE_AGREE agree
		    WHERE MASTER.dept_code = agree.dept_code(+)
			   AND MASTER.sell_code = agree.sell_code(+)
				AND MASTER.dongho    = agree.dongho(+)
				AND MASTER.seq       = agree.seq(+)

			GROUP BY MASTER.dept_code,
                DECODE(MASTER.sell_code, '01', 'apt', 'etc')
		 ) sale,
		 ( SELECT MASTER.dept_code,
                DECODE(MASTER.sell_code, '01', 'apt', 'etc') apt_or_etc,
                NVL(COUNT(UNIQUE MASTER.dongho), 0) cont_cnt,
                SUM(NVL(MASTER.build_area, 0)) build_area,
                SUM(NVL(MASTER.land_area, 0))  land_area,
                SUM(NVL(agree.land_amt,0)+NVL(agree.build_amt,0)) cont_supply_amt
			  FROM (SELECT MASTER.dept_code, MASTER.sell_code, MASTER.dongho, MASTER.seq,
                        NVL(py.private_square,0)+NVL(py.common_square,0)+NVL(py.etc_square,0)+
                        NVL(py.parking_square,0)+NVL(py.service_square, 0) build_area,
                        py.grand_square land_area
                   FROM H_SALE_MASTER MASTER,
                        H_BASE_PYONG_MASTER py
                  WHERE MASTER.last_contract_date <= TO_DATE('2999.01.01','yyyy.mm.dd')
				        AND MASTER.chg_date > TO_DATE('2999.01.01', 'yyyy.mm.dd')
                    AND MASTER.chg_div <> '00'
                    AND MASTER.dept_code = py.dept_code(+)
                    AND MASTER.sell_code = py.sell_code(+)
                    AND MASTER.pyong = py.pyong(+)
                    AND MASTER.style = py.style(+)
                    AND MASTER.CLASS = py.CLASS(+)
                    AND MASTER.option_code = py.option_code(+)
                ) MASTER,
			         H_SALE_AGREE agree
		    WHERE MASTER.dept_code = agree.dept_code(+)
			   AND MASTER.sell_code = agree.sell_code(+)
				AND MASTER.dongho    = agree.dongho(+)
				AND MASTER.seq       = agree.seq(+)

			GROUP BY MASTER.dept_code,
                DECODE(MASTER.sell_code, '01', 'apt', 'etc')
       ) cont
  WHERE sale.dept_code = cont.dept_code(+)
	 AND sale.apt_or_etc = cont.apt_or_etc(+)

ORDER BY sale.dept_code
)

GROUP BY dept_code;



