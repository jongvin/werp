CREATE OR REPLACE PACKAGE BODY Pkg_H_Sale_Data AS

/******************************************************************************/
/*                                                                            */
/* Function Name : func_h_sale_data                                           */
/* Description    : 분양데이타 집계(현장코드, 기준일)                         */
/* Change Request Number : 1.0.0.0                                            */
/* Parameter      : (현장코드, 기준일)                                        */
/*                                                                            */
/*----------------------------------------------------------------------------*/
/* Date       In Charge         Description                                   */
/*----------------------------------------------------------------------------*/
/* 2005-06-13                   Initial Release                               */
/******************************************************************************/   
   FUNCTION get_data(as_dept_code IN VARCHAR2, 
                     as_work_date IN DATE) RETURN g_sale_data_result IS

   rec_sale_data g_sale_data_result;
      
   BEGIN
     SELECT sale.dept_code,
          sale.sale_cnt        sale_cnt,         --분양대상 세대수
          sale.build_area      sale_build_area,  --분양대상 건물면적
          sale.land_area       sale_land_area,   --분양대상 토지면적
          sale.sale_supply_amt sale_supply_amt,  --분양대상 금액(토지가+건물가)
          cont.cont_cnt        cont_cnt,         --분양(계약) 세대수
          cont.build_area      cont_build_area,  --분양(계약) 건물면적
          cont.land_area       cont_land_area,   --분양(계약) 토지면적
          cont.cont_supply_amt cont_supply_amt   --분양(계약) 금액(토지가+건물가)
     INTO rec_sale_data.dept_code,
          rec_sale_data.sale_cnt,
          rec_sale_data.sale_build_area,
          rec_sale_data.sale_land_area,
          rec_sale_data.sale_supply_amt,
          rec_sale_data.cont_cnt,
          rec_sale_data.cont_build_area,
          rec_sale_data.cont_land_area,
          rec_sale_data.cont_supply_amt
     FROM ( SELECT MASTER.dept_code,
                   --DECODE(MASTER.sell_code, '01', 'apt', 'etc') apt_or_etc,
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
                     WHERE MASTER.last_contract_date <= as_work_date
   				        AND MASTER.chg_date > as_work_date
                       AND MASTER.dept_code = as_dept_code 
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
   
   			GROUP BY MASTER.dept_code
   		 ) sale,
   		 ( SELECT MASTER.dept_code,
                   --DECODE(MASTER.sell_code, '01', 'apt', 'etc') apt_or_etc,
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
                     WHERE MASTER.last_contract_date <= as_work_date
   				        AND MASTER.chg_date > as_work_date
                       AND MASTER.dept_code = as_dept_code
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
   
   			GROUP BY MASTER.dept_code
          ) cont
    WHERE sale.dept_code = cont.dept_code(+)
    ORDER BY sale.dept_code
   
    ;   
    RETURN rec_sale_data;
    
    EXCEPTION WHEN NO_DATA_FOUND THEN
      RETURN NULL;
    

   END get_data ;
END;
/

