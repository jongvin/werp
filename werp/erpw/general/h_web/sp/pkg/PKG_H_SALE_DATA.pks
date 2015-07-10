CREATE OR REPLACE PACKAGE pkg_h_sale_data AS
/******************************************************************************
   NAME:       pkg_h_sale_data
   PURPOSE:    FI �������̽�
              get_dat() �Լ��� ����Ͽ� �о� �����/����/�ݾ��� record ���·� �����Ѵ�. 

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2005.06.13          1. Created this function.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     pkg_h_sale_data
      Sysdate:         2005.06.13
      Date and Time:   2005.06.13, ���� 10:43:51, and 2005.06.13 ���� 10:43:51
      Username:         
      Table Name:       

******************************************************************************/
  TYPE g_sale_data_result     IS RECORD ( dept_code         VARCHAR2(7), --�����ڵ�
                                           sale_cnt          NUMBER,      --�о��� �����
                                           sale_build_area   NUMBER,      --�о��� �ǹ�����
                                           sale_land_area    NUMBER,      --�о��� ��������
                                           sale_supply_amt   NUMBER,      --�о��� �ݾ�(������+�ǹ���)
                                           cont_cnt          NUMBER,      --�о�(���) �����
                                           cont_build_area   NUMBER,      --�о�(���) �ǹ�����
                                           cont_land_area    NUMBER,      --�о�(���) ��������
                                           cont_supply_amt   NUMBER);       --�о�(���) �ݾ�(������+�ǹ���) 

   --TYPE g_ap_validation_result_tbl IS TABLE OF g_ap_validation_result INDEX BY BINARY_INTEGER ;


/******************************************************************************/
/*                                                                            */
/* Function Name : func_h_sale_data                                           */
/* Description    : �о絥��Ÿ ����(�����ڵ�, ������)                         */
/* Change Request Number : 1.0.0.0                                            */
/* Parameter      : (�����ڵ�, ������)�۾����                                */
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

