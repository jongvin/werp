/* ============================================================================= */
/* �Լ��� : y_sp_m_output_trans                                                  */
/* ��  �� : ��������ó���� �Ѵ�. 			                                       */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ��������               ==> ad_to_dept      (string)                  */
/*        : ����                   ==> ad_date      (date)                       */
/*        : ����                   ==> ai_seq      (INTEGER)                     */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2005.07.21                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_m_output_trans(as_dept_code IN   VARCHAR2,
												as_to_dept      IN   VARCHAR2,
												as_date         IN   DATE,
												ai_seq          IN   INTEGER ) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
-- ���� ���� 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   V_OUTPUT_UNQ_NUM    m_input_detail.input_unq_num%TYPE;
   V_INPUT_UNQ_NUM     m_input_detail.input_unq_num%TYPE;
   V_AQTY              m_input_detail.qty%TYPE;                -- ����
   V_QTY               m_input_detail.qty%TYPE;                -- ����
   V_PRICE             m_input_detail.amt%TYPE;                -- �ݾ�
   V_AMT               m_input_detail.amt%TYPE;                -- �ݾ�
   V_VAT_AMT           m_input_detail.amt%TYPE;                -- �ݾ�

   C_SEQ               INTEGER;  -- 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
	BEGIN

	select m_spec_unq_no.nextval into C_SEQ from dual;

	update m_output
	set trans_tag = '4',
	input_yymmdd = as_date,
	relative_seq = C_SEQ
	where dept_code = as_dept_code
	and yymmdd  = as_date
	and seq     = ai_seq;

	insert into m_input
	select as_to_dept,as_date,C_SEQ,outputtitle,dept_code,yymmdd,seq,'','3','',total_amt,memo,''
	from m_output
	where dept_code = as_dept_code
	and yymmdd = as_date
	and seq = ai_seq;

	insert into m_input_detail
	select a.relative_proj_code,a.input_yymmdd,a.relative_seq, 
	m_spec_unq_no.nextval,b.detailseq,b.mtrcode,b.name,b.ssize, 
	b.unitcode,b.ditag,b.qty,b.unitprice,b.amt,0,0, 
	'3','','1',0,0,0,0,0,0,'',b.qty ,b.tmat_unq_num,''
	FROM m_output a,  
	m_output_detail b 
	WHERE a.dept_code = b.dept_code 
	AND a.yymmdd    = b.yymmdd 
	AND a.seq       = b.seq 
	AND b.DEPT_CODE = as_dept_code
	AND b.yymmdd = as_date
	AND b.seq = ai_seq;

	insert into m_tmat_stock
	select a.dept_code,a.yymmdd,a.seq,a.input_unq_num,
	a.detailseq,a.mtrcode,a.name,a.ssize, 
	a.unitcode,a.qty,b.years,b.proc_yn,a.amt
	FROM m_input_detail a,
	( select b.detailseq,a.proc_yn,a.years
		 from m_tmat_stock a,
				m_output_detail b
		where b.dept_code = a.dept_code
		  and b.input_unq_num = a.input_unq_num
	  	  and b.dept_code = as_dept_code
		  and b.yymmdd = as_date
		  and b.seq    = ai_seq
		  and b.ditag = '2' ) b
	WHERE a.detailseq = b.detailseq
	AND a.DEPT_CODE = as_to_dept
	AND a.yymmdd = as_date
	AND a.seq = C_SEQ
	AND a.ditag = '2';

	EXCEPTION
		WHEN others THEN
			IF SQL%NOTFOUND THEN
				e_msg      := '����ó�� ����! [Line No: 159]';
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
END y_sp_m_output_trans;
/