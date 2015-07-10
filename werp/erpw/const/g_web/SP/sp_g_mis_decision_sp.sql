/* ============================================================================= */
/* �Լ��� : sp_g_mis_decision_sp	                                                */
/* ��  �� : Ȯ�����SP��Ȳ ����                                                 */
/* ----------------------------------------------------------------------------- */
/* ��  �� : ���޳��               ==> ad_work_yymm  (DATE)                      */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : ����                                                               */
/* �ۼ��� : 2005.06.27                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE sp_g_mis_decision_sp(ad_work_yymm  IN  DATE) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
-- ���� ����
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error
   C_DATE              P_GEN_driver_filial_piety.WORK_YYMM%TYPE;    -- ����
   C_LEVEL             NUMBER(20,5);  --
   C_CNT               NUMBER(20,5);  --

   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN

		INSERT INTO g_mis_decision_sp(work_yymm,
									         proj_bus_type,
									         proj_prog_type,
									         proj_unq_key,
									         sta_const_tot_m2,
									         sta_sale_m2,
									         con_sale_yymm,proj_name)
		        SELECT TO_DATE(ad_work_yymm, 'YYYY.MM.DD'),
            			b.proj_bus_type,
			            b.proj_prog_type,
            			b.proj_unq_key,
            			a.bus_const_tot_m2,
            			a.bus_sale_m2,
            			a.rec_sale_dt,
            			b.proj_name
	  			    FROM r_proj a,
	  			    	   r_proj_view_business_form b,
	  			    	   view_r_a_cash_degree c
	   		   WHERE a.proj_unq_key = b.proj_unq_key
		           and a.step = b.step
	   		     and b.proj_prog_type <> '3'
		           and b.proj_unq_key = c.proj_unq_key
	   		     and c.proj_unq_key <> 0
		           and not exists ( select work_yymm
		            					   from g_mis_decision_sp c
	            						  where a.proj_bus_type = c.proj_bus_type
												 and a.proj_prog_type  = c.proj_prog_type
												 and a.proj_unq_key = c.proj_unq_key 
												 and c.work_yymm = ad_work_yymm);

      EXCEPTION
      WHEN others THEN
           IF SQL%NOTFOUND THEN
              e_msg      := 'BOM �ڷ����� ����! [Line No: 159]';
              Wk_errflag := -20020;

              GOTO EXIT_ROUTINE;
           END IF;
 END;

   -- *****************************************************************************
   -- PROCESS ENDDING ... !
   -- *****************************************************************************
   <<EXIT_ROUTINE>>

   -- ENDING...[0.1] CURSOR CLOSE �� Ȯ�� ó�� !
   IF Wk_errflag = 0 THEN
      Wk_errmsg  := '';                        -- ����� ���� Error Message
      Wk_errflag := 0;                         -- ����� ���� Error Code
   ELSE
      Wk_errmsg := RTRIM(e_msg) || '/>';
      RAISE UserErr;
   END IF;

EXCEPTION
  WHEN UserErr       THEN
       RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);
END sp_g_mis_decision_sp;
/