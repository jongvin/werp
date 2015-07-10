/* ============================================================================= */
/* �Լ��� : y_sp_m_output_junk                                                   */
/* ��  �� : ����Ű���ǥ�����Ѵ�. 			                                     */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code   (string)                   */
/*        : �Ű�����               ==> as_yymmdd      (date)                     */
/*        : �Ϸù�ȣ               ==> as_seq         (INTEGER)                  */
/*        : ��ǥ�����ȣ           ==> ai_unq_num     (NUMBER)                   */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �̰���                                                               */
/* �ۼ��� : 2005.10.18                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_m_output_junk (
	as_dept_code IN   VARCHAR2,
	as_yymmdd    IN   DATE ,
	as_seq       IN   INTEGER,
	ai_unq_num   IN   NUMBER ) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
-- ��ǥ���� ��� Ŀ��
CURSOR DETAIL_CUR IS
    SELECT
		B.SALE_AMT,B.SALE_VAT,B.RQST_DATE,
		'' CUST_CODE,
		'' CUST_NAME,
    	(
        SELECT SUM(AMT) AMT FROM M_OUTPUT_DETAIL
        WHERE
        	DEPT_CODE = as_dept_code
        AND YYMMDD = as_yymmdd
        AND SEQ = as_seq
    	) AMT
    FROM
    	M_OUTPUT A,
    	M_OUTPUT_SALE B,
		efin_invoice_header_itf D
    WHERE
    	A.DEPT_CODE = B.DEPT_CODE AND A.YYMMDD = B.YYMMDD AND A.SEQ = B.SEQ
	AND B.invoice_num = D.invoice_group_id (+)
    AND A.DEPT_CODE = as_dept_code
    AND A.YYMMDD = as_yymmdd
    AND A.SEQ = as_seq
	AND decode(D.complete_flag,null,'Y',decode(D.complete_flag,'3','Y',decode(D.complete_flag,'9',decode(D.relation_invoice_group_id,null,'N','Y'),'N'))) = 'Y';
-- ���� ����
Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
e_msg               VARCHAR2(100);
UserErr             EXCEPTION;                  -- Select Data Not Found

CHK_CUNT            INTEGER;                    -- �ڷḦ ������ �Դ��� üũ�Ѵ�
DATA_CUNT           INTEGER;                    -- ��ǥ���� �ڷῩ�� üũ

V_SALE_AMT          NUMBER(10,0);
V_SALE_VAT          NUMBER(10,0);
V_RQST_DATE         DATE;
V_CUST_CODE         VARCHAR2(20);
V_SBCR_NAME         VARCHAR2(50);
V_AMT               NUMBER(13,0);
V_RST_AMT           NUMBER(13,0);

C_COMP_CODE         VARCHAR2(10);
C_DEPT_NAME         VARCHAR2(50);
C_PROJ              VARCHAR2(10);
C_ORG_ID            VARCHAR2(10);
C_GROUP_ID          INTEGER;
C_TAX_TAG           VARCHAR2(1);
C_TAX_CNT           NUMBER(20,5);
C_FOLDER_ID         VARCHAR2(10);

BEGIN
	BEGIN

	-- ���庰 ������ڵ带 ������ �´�
    select comp_code ,long_name into C_COMP_CODE,C_DEPT_NAME
    from z_code_dept where dept_code = as_dept_code;
	-- ���庰������Ʈ�ڵ带 ���Ѵ�.
    select a.proj_code
    into C_PROJ
    from ( select a.dept_code,c.proj_code
    		 from  z_code_dept a,
    		  ( select proj_unq_key,step     
    				from r_proj_view_business_form) b,
    			r_proj c
       where a.proj_unq_key = b.proj_unq_key
    	  and b.proj_unq_key = c.proj_unq_key
    	  and b.step = c.step ) a
    where a.dept_code =  as_dept_code;  
    SELECT attribute1
    INTO C_ORG_ID
    FROM efin_corporations_v
    WHERE corporation_code = C_COMP_CODE;
	-- ��ǥ �����͹�ȣ�� ���Ѵ�.
	select efin_invoice_header_itf_s.nextval
    into C_GROUP_ID
    from dual;

	-- ���缱 ������ �����Ѵ�.
	y_sp_d_efin_invoice_copy(C_GROUP_ID,ai_unq_num,'A',last_day(as_yymmdd));
	DATA_CUNT := 0;

	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_SALE_AMT,V_SALE_VAT,V_RQST_DATE,V_CUST_CODE,V_SBCR_NAME,V_AMT;
		EXIT WHEN DETAIL_CUR%NOTFOUND;
		DATA_CUNT := DATA_CUNT + 1;
		--�ŷ�ó ���� ���� üũ
		IF V_AMT = 0 THEN
			e_msg      := '�ݾ��� ���� ���� �ʽ��ϴ�! [Line No: 159]';
        	Wk_errflag := -20020;
	        GOTO EXIT_ROUTINE;
		END IF;

		-- 115351 (������)
		-- 472511 (��ս�)
		C_FOLDER_ID := C_COMP_CODE || '99999';
    	C_TAX_TAG := '';
    	C_TAX_CNT := null;

		-- ��ս� �߰�
		-- ��սǰ����Է�(��)
		V_RST_AMT := V_AMT - V_SALE_AMT; --��ս� ���ݾ�
       	y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' ���Ա�',last_day(as_yymmdd),as_yymmdd,
       								  V_SBCR_NAME,V_CUST_CODE,V_RST_AMT,'','',as_dept_code,
       								  C_PROJ,'','472511','���Ա�','����','','',
       								  C_FOLDER_ID,'',C_ORG_ID,C_DEPT_NAME,C_DEPT_NAME || ' ���������','C');
		-- ����������Է�(��)
        y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' ���Ա�',last_day(as_yymmdd),as_yymmdd,
       								  V_SBCR_NAME,V_CUST_CODE,'',V_RST_AMT,'',as_dept_code,
       								  C_PROJ,'','115351','���Ա�','����','','',
       								  C_FOLDER_ID,'',C_ORG_ID,C_DEPT_NAME,C_DEPT_NAME || ' ���������','C');
	END LOOP;
	CLOSE DETAIL_CUR;

	IF DATA_CUNT = 0 THEN
		e_msg      := '��ǥ ���� ����� �������� �ʽ��ϴ�.! [Line No: 159]';
		Wk_errflag := -20020;
		GOTO EXIT_ROUTINE;
	END IF;

	UPDATE M_OUTPUT_SALE SET INVOICE_NUM = C_GROUP_ID
    WHERE DEPT_CODE = as_dept_code AND YYMMDD = as_yymmdd AND SEQ = as_seq;

	UPDATE M_OUTPUT SET trans_tag = ''
    WHERE DEPT_CODE = as_dept_code AND YYMMDD = as_yymmdd AND SEQ = as_seq;

	-- ��ġȭ���� Update �Ѵ�.
	y_sp_comm_slip_batch_flag(C_ORG_ID,'Journal');

	EXCEPTION
		WHEN others THEN
			IF SQL%NOTFOUND THEN
				e_msg      := '�����ǥ���� ����! [Line No: 159]';
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
	WHEN UserErr THEN
		RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);
END y_sp_m_output_junk;
