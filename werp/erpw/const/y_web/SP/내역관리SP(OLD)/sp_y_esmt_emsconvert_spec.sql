/* ============================================================================= */
/* �Լ��� : sp_y_esmt_emsconvert_spec                                            */
/* ��  �� : EMS�ڷ� ��ȯ(EMS -> ���೻��) .                                      */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_receive_code (string)                  */
/*        : �κ�                   ==> as_part      (string)                     */
/*        : ��ȣ                   ==> ai_degree    (string)                     */
/*        : EMS�ܰ�����            ==> as_class     (string)                     */
/*        : ���޴ܰ�����           ==> as_cnt       (string)                     */
/*        : ����ܰ�����           ==> as_exe       (string)                     */
/*        : �����                 ==> as_user      (string)                     */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2001.08.14                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE sp_y_esmt_emsconvert_spec(as_receive_code    IN   VARCHAR2,
                                                      as_part         IN   VARCHAR2,
                                                      ai_no           IN   INTEGER,
                                                      as_class        IN   VARCHAR2,
                                                      as_cnt          IN   VARCHAR2,
                                                      as_user         IN   VARCHAR2) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
  CURSOR DETAIL_CUR IS
  SELECT sum_code
    FROM y_esmt_tmp_detail  
   WHERE receive_code = as_receive_code AND  
         part_class   = as_part AND  
         connect_yn   = 'Y'   
group by receive_code,
         part_class,
         sum_code 
order by receive_code asc,
         part_class asc,
         sum_code asc;

-- ���� ���� 
   V_SUM_CODE          Y_ESMT_SUMMARY.SUM_CODE%TYPE;
   C_MNG_CODE          Y_ESMT_SUMMARY.MNG_CODE%TYPE;
   C_WBS_CODE          Y_ESMT_SUMMARY.WBS_CODE%TYPE;
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   UserErr         EXCEPTION;                  -- Select Data Not Found
   C_CNT           NUMBER(10,3);
   C_SEQ           INTEGER        DEFAULT 0;

BEGIN

 BEGIN
-- ǥ���ڿ��� �ڿ�����,�����ڵ� �� �ܰ��� �����Ѵ�. 
   IF as_class = '1' THEN
      UPDATE y_esmt_tmp_detail a
         SET (a.res_class,a.mat_code,a.mat_price,a.lab_price,a.exp_price) =
              ( SELECT b.res_class,b.mat_code,
                       decode(as_cnt,'1',b.cnt_mat_price1,b.cnt_mat_price2),
                       decode(as_cnt,'1',b.cnt_lab_price1,b.cnt_lab_price2),
                       decode(as_cnt,'1',b.cnt_exp_price1,b.cnt_exp_price2)
                  FROM y_stand_spec b
                 WHERE a.detail_code = b.detail_code)
       WHERE (a.receive_code   = as_receive_code) AND 
             (a.part_class     = as_part) AND
             (a.res_connect_yn = 'Y') AND
             (a.connect_yn     = 'Y');
   ELSE
      UPDATE y_esmt_tmp_detail a
         SET (a.res_class,a.mat_code) =
              ( SELECT b.res_class,b.mat_code
                  FROM y_stand_spec b
                 WHERE a.detail_code = b.detail_code)
       WHERE (a.receive_code   = as_receive_code) AND 
             (a.part_class     = as_part) AND
             (a.res_connect_yn = 'Y') AND
             (a.connect_yn     = 'Y');
   END IF;

   UPDATE y_esmt_tmp_detail 
      SET price   = mat_price + lab_price + exp_price,
          amt     = TRUNC((mat_price + lab_price + exp_price) * qty,0), 
          mat_amt = TRUNC(mat_price * qty,0),          
          lab_amt = TRUNC(lab_price * qty,0),          
          exp_amt = TRUNC(exp_price * qty,0)
    WHERE (receive_code      = as_receive_code) AND 
          (part_class     = as_part) AND
          (res_connect_yn = 'Y') AND
          (connect_yn     = 'Y');

   
	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_SUM_CODE;
		EXIT WHEN DETAIL_CUR%NOTFOUND;

-- ���豸���� ����. 
   UPDATE Y_ESMT_SUMMARY  
      SET INVEST_CLASS = 'Y',   
          DETAIL_YN = 'Y'  
    WHERE receive_code = as_receive_code
      AND no           = ai_no
      AND sum_code     = V_SUM_CODE;

   SELECT max(seq)
     INTO C_SEQ
     FROM Y_ESMT_DETAIL
    WHERE receive_code = as_receive_code
      AND no           = ai_no
      AND sum_code     = V_SUM_CODE;

   SELECT mng_code,wbs_code
     INTO C_MNG_CODE,C_WBS_CODE
     FROM y_esmt_summary
    WHERE receive_code = as_receive_code
      AND no           = ai_no
      AND sum_code     = V_SUM_CODE;


-- ���೻������ ��ȯ.
   INSERT INTO y_esmt_detail
        SELECT receive_code,ai_no,sum_code,y_spec_unq_num.nextval,
	            detail_code,res_class,NVL(C_SEQ,0) + NVL(seq,0),C_MNG_CODE,C_WBS_CODE,mat_code,
			   	name,ssize,unit,qty,price,amt,mat_price,mat_amt,lab_price,lab_amt,exp_price,
   				exp_amt,'','','','','','',sysdate,as_user
          FROM y_esmt_tmp_detail  
         WHERE ( receive_code = as_receive_code ) AND  
               ( part_class   = as_part ) AND  
               ( connect_yn   = 'Y' ) AND
               ( sum_code     = V_SUM_CODE)  ;

	END LOOP;
	CLOSE DETAIL_CUR;

        
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '�������� �ڷắȯ ����! [Line No: 159]';
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
END sp_y_esmt_emsconvert_spec;

/
