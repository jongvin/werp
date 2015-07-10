CREATE OR REPLACE PACKAGE pkg_h_sale_data AS
/******************************************************************************
   NAME:       pkg_h_sale_data
   PURPOSE:    FI 인터페이스
              get_dat() 함수를 사용하여 분양 세대수/면적/금액을 record 형태로 제공한다. 

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2005.06.13          1. Created this function.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     pkg_h_sale_data
      Sysdate:         2005.06.13
      Date and Time:   2005.06.13, 오전 10:43:51, and 2005.06.13 오전 10:43:51
      Username:         
      Table Name:       

******************************************************************************/
  TYPE g_sale_data_result     IS RECORD ( dept_code         VARCHAR2(7), --현장코드
                                           sale_cnt          NUMBER,      --분양대상 세대수
                                           sale_build_area   NUMBER,      --분양대상 건물면적
                                           sale_land_area    NUMBER,      --분양대상 토지면적
                                           sale_supply_amt   NUMBER,      --분양대상 금액(토지가+건물가)
                                           cont_cnt          NUMBER,      --분양(계약) 세대수
                                           cont_build_area   NUMBER,      --분양(계약) 건물면적
                                           cont_land_area    NUMBER,      --분양(계약) 토지면적
                                           cont_supply_amt   NUMBER);       --분양(계약) 금액(토지가+건물가) 

   --TYPE g_ap_validation_result_tbl IS TABLE OF g_ap_validation_result INDEX BY BINARY_INTEGER ;


/******************************************************************************/
/*                                                                            */
/* Function Name : func_h_sale_data                                           */
/* Description    : 분양데이타 집계(현장코드, 기준일)                         */
/* Change Request Number : 1.0.0.0                                            */
/* Parameter      : (현장코드, 기준일)작업대상                                */
/*                                                                            */
/*----------------------------------------------------------------------------*/
/* Date       In Charge         Description                                   */
/*----------------------------------------------------------------------------*/
/* 2005-06-13                   Initial Release                               */
/******************************************************************************/
   FUNCTION get_data(as_dept_code IN VARCHAR2, 
                     as_work_date IN DATE) RETURN g_sale_data_result ;

END pkg_h_sale_data ;
/

