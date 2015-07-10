 /* ============================================================================ */
/* �Լ��� : y_sp_f_slip_request(CJ����)                                          */
/* ��  �� : �ڱ�û��-�ڱ�û����ǥ ����                                           */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ��ǥ���               ==> as_date(DATE)        		               */
/*        : �ۼ��ڻ��             ==> as_user(string)        		               */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2006.04.12                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_f_slip_request (as_dept_code    IN   VARCHAR2,
																	  as_date         IN   DATE,
                                                     as_user         IN   VARCHAR2,
                                                     as_slip_dt      IN DATE ) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT amt,vat,receipt_date,rqst_detail,res_class,dr_class,acntcode,
		 replace(cust_code,'-',''),nvl(deduct_amt,0),nvl(cash_amt,0),vatcode,income_type,nvl(income_amt,0),nvl(civi_amt,0)
  from f_request
 where dept_code = as_dept_code
	and trunc(rqst_date,'MM')= as_date
	and res_class = 'X'
	and exe_type = '1'
	and invoice_num is null
   and cost_type = '1'
   and temp_chk = 'T'
	order by cust_code asc;

CURSOR DETAIL_CUR1 IS
SELECT amt,vat,receipt_date,rqst_detail,res_class,dr_class,acntcode,
		 replace(cust_code,'-',''),income_type,nvl(income_amt,0),nvl(civi_amt,0)
  from f_request
 where dept_code = as_dept_code
	and trunc(rqst_date,'MM')= as_date
	and res_class = 'L'
	and exe_type = '1'
	and invoice_num is null
   and cost_type = '1'
   and temp_chk = 'T'
	order by cust_code asc;

-- ���� ����
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
   Wk_Chk              NUMBER(10,0) DEFAULT 0 ;
   WK_Chk_msg          VARCHAR2(100);

-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	V_AMT               NUMBER(20,5);
	V_VAT               NUMBER(20,5);
	V_YYMMDD            DATE;
	V_CONT              VARCHAR2(100);
	V_RES_CLASS         VARCHAR2(1);
	V_DR_CLASS          VARCHAR2(1);
	V_ACNTCODE          VARCHAR2(50);
	V_CUST_CODE         VARCHAR2(20);
	V_DEDUCT_AMT        NUMBER(20,5);
	V_CASH_AMT          NUMBER(20,5);
	V_VATCODE           VARCHAR2(50);
	V_INCOME_TYPE       VARCHAR2(1);
	V_INCOME_AMT        NUMBER(20,5);
	V_CIVI_AMT          NUMBER(20,5);
	C_COMP_CODE         VARCHAR2(10);
	C_ACNT_CODE         VARCHAR2(10);
	C_VAT_CODE          VARCHAR2(10);
	C_CR_CODE           VARCHAR2(10);
	C_INCOME_CODE       VARCHAR2(10);
	C_CIVI_CODE         VARCHAR2(10);
	C_AMT               NUMBER(20,5);
	C_SET_AMT           NUMBER(20,5);
	C_TEMP_AMT          NUMBER(20,5);
	C_SLIP_DT           DATE;
	C_SLIP_ID           NUMBER;
	C_SLIP_IDSEQ        NUMBER;
	C_CUST_SEQ          NUMBER;
	C_CUST_NAME         VARCHAR2(60);
	C_SEQ               INTEGER;
	C_CNT               INTEGER;
-- ��ǥ���� ����
   IrBody              T_ACC_SLIP_BODY%RowType;
   IsClassCode         T_CLASS_CODE.CLASS_CODE%Type;
   IrHead              T_ACC_SLIP_HEAD%RowType;
   IsChargePers        T_ACC_SLIP_HEAD.CHARGE_PERS%Type;
   InMakeSlipLine      Number;
	IsCustName          T_ACC_SLIP_BODY.CUST_NAME%Type;
	InCustSeq           T_CUST_CODE.CUST_SEQ%Type;

BEGIN
 BEGIN
-- ������ڵ带 ������ �´�
   	C_COMP_CODE := PKG_MAKE_SLIP.Get_Comp_code(as_dept_code);

-- �ι��� ���Ѵ�.
		IsClassCode := PKG_MAKE_SLIP.Get_Class_code(as_dept_code);

		SELECT NVL(COUNT(*),0)
		  into C_CNT
		  from f_request
		 where dept_code = as_dept_code
			and trunc(rqst_date,'MM')= as_date
			and res_class = 'X'
			and exe_type = '1'
		   and cost_type = '1'
		   and temp_chk = 'T'
			and invoice_num is null;

		IF C_CNT > 0 THEN
	-- ȸ�� Ȯ�� ����ڸ� ������ �´�	
			IsChargePers := PKG_MAKE_SLIP.Get_CHARGE_PERS('X000000001',C_COMP_CODE);
	
	-- ��ǥ�����͸� �����Ѵ�(������ڵ�,�����ڵ�,��ǥ������,'1'��ü,'C'���,�ۼ��ڻ��,�ڵ���ǥ�ڵ�,ȸ��Ȯ�����,�Է��ڻ��)
			IrHead := PKG_MAKE_SLIP.New_Head(C_COMP_CODE,as_dept_code,as_slip_dt,'1','C',as_user,'X000000001',IsChargePers,as_user);
	
			PKG_MAKE_SLIP.Insert_Head(IrHead);
	
			InMakeSlipLine := 0;
	
	
	-- ��ǥ������ ����� ���� Ŀ��
			OPEN	DETAIL_CUR;
			LOOP
				FETCH DETAIL_CUR INTO V_AMT,V_VAT,V_YYMMDD,V_CONT,V_RES_CLASS,V_DR_CLASS,V_ACNTCODE,V_CUST_CODE,V_DEDUCT_AMT,V_CASH_AMT,V_VATCODE,
                                  V_INCOME_TYPE,V_INCOME_AMT,V_CIVI_AMT;
				EXIT WHEN DETAIL_CUR%NOTFOUND;
	
				IF V_DR_CLASS = '1' THEN
					C_ACNT_CODE := V_ACNTCODE;
					C_VAT_CODE  := V_VATCODE;
					C_CR_CODE   := '111210200';
				ELSE
					C_ACNT_CODE := '111210200';
					C_VAT_CODE  := '210131700';
					C_CR_CODE   := V_ACNTCODE;
				END IF;

				C_CIVI_CODE := '210080200'; -- �ֹμ�

				CASE  V_INCOME_TYPE 
					WHEN '1' THEN                        -- �Ͽ���
						C_INCOME_CODE := '210080103';
					WHEN '2' THEN                        -- �����ҵ�
						C_INCOME_CODE := '210080105';
					WHEN '3' THEN                        -- ��Ÿ�ҵ�
						C_INCOME_CODE := '210080107';
					ELSE                                 -- 
						C_INCOME_CODE := '';
				END CASE;
				-- �ŷ�ó������ ���Ѵ�.
				InCustSeq := PKG_MAKE_SLIP.Get_Cust_Seq(V_CUST_CODE);
				-- �ŷ�ó��Ī�� ���Ѵ�.
				IsCustName := PKG_MAKE_SLIP.Get_Cust_Name(InCustSeq);
	
				-- ��ǥ������ ���Ѵ�.
				InMakeSlipLine := InMakeSlipLine + 1;
	
				-- �� Body�� ���Ѵ�(����).
				IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_ACNT_CODE,IsClassCode,Null);
				
				-- Body�� ������ �־��ش�.
				IF V_DR_CLASS = '1' THEN    
					IrBody.DB_AMT            := V_AMT;        -- �����ݾ�
				ELSE
					IrBody.DB_AMT            := V_AMT + V_VAT;        -- �����ݾ�(�뺯)
					IrBody.RESET_SLIP_ID     := IrBody.SLIP_ID;
					IrBody.RESET_SLIP_IDSEQ  := IrBody.SLIP_IDSEQ;
				END IF;
				IrBody.TAX_COMP_CODE     := C_COMP_CODE;  -- ����������ڵ�
				IrBody.COMP_CODE         := C_COMP_CODE;  -- �ͼӻ�����ڵ�
				IrBody.DEPT_CODE         := as_dept_code; -- �ͼӺμ�
				IrBody.VAT_DT            := V_YYMMDD;     -- ��������
				IrBody.SUPAMT            := 0;            -- ���ް�(�ΰ��� ���ο����� �Է�)
				IrBody.VATAMT            := 0;            -- �ΰ���(�ΰ��� ���ο����� �Է�)
				IrBody.CUST_SEQ          := InCustSeq;    -- �ŷ�ó����
				IrBody.CUST_NAME         := IsCustName;   -- �ŷ�ó��Ī
				IrBody.SUMMARY1          := V_CONT;       -- ����
		
				-- Body�� �����Ѵ�.
				PKG_MAKE_SLIP.Insert_Body(IrBody);
		
				IF C_VAT_CODE is not null THEN
					InMakeSlipLine := InMakeSlipLine + 1;
					-- �� Body�� ���Ѵ�(����:�ΰ�������)
					IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_VAT_CODE,IsClassCode,Null);
					
					-- Body�� ������ �־��ش�.
					IF V_DR_CLASS = '1' THEN
						IrBody.DB_AMT            := V_VAT;        -- �����ݾ�
					ELSE
						IrBody.CR_AMT            := V_VAT;        -- �����ݾ�
					END IF;
					IrBody.TAX_COMP_CODE     := C_COMP_CODE;  -- ����������ڵ�
					IrBody.COMP_CODE         := C_COMP_CODE;  -- �ͼӻ�����ڵ�
					IrBody.DEPT_CODE         := as_dept_code; -- �ͼӺμ�
					IrBody.VAT_DT            := V_YYMMDD;     -- ��������
					IrBody.SUPAMT            := V_CASH_AMT;        -- ���ް�(�ΰ��� ���ο����� �Է�)
					IrBody.VATAMT            := V_VAT;        -- �ΰ���(�ΰ��� ���ο����� �Է�)
					IrBody.CUST_SEQ          := InCustSeq;    -- �ŷ�ó����
					IrBody.CUST_NAME         := IsCustName;   -- �ŷ�ó��Ī
					IrBody.SUMMARY1          := V_CONT;       -- ����
		
					-- Body�� �����Ѵ�.
					PKG_MAKE_SLIP.Insert_Body(IrBody);
				END IF;
	
					-- Body�� ������ �־��ش�.
				IF V_DR_CLASS = '1' THEN

					C_AMT := V_AMT + V_VAT;

					IF V_DEDUCT_AMT <> 0 THEN
					-- ��ǥ������ ���Ѵ�.
						InMakeSlipLine := InMakeSlipLine + 1;
					-- �� Body�� ���Ѵ�(�뺯)
						IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,'540210100',IsClassCode,Null);

						IrBody.CR_AMT            := V_DEDUCT_AMT; -- �뺯�ݾ�
						IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- ����������ڵ�
						IrBody.COMP_CODE         := C_COMP_CODE;   -- �ͼӻ�����ڵ�
						IrBody.DEPT_CODE         := as_dept_code;  -- �ͼӺμ�
						IrBody.VAT_DT            := V_YYMMDD;      -- ��������
						IrBody.SUPAMT            := 0;         -- ���ް�(�ΰ��� ���ο����� �Է�)
						IrBody.VATAMT            := 0;         -- �ΰ���(�ΰ��� ���ο����� �Է�)
						IrBody.CUST_SEQ          := InCustSeq;     -- �ŷ�ó����
						IrBody.CUST_NAME         := IsCustName;    -- �ŷ�ó��Ī
						IrBody.SUMMARY1          := V_CONT;        -- ����
		
						-- Body�� �����Ѵ�.
						PKG_MAKE_SLIP.Insert_Body(IrBody);

						C_AMT := C_AMT - V_DEDUCT_AMT;
					END IF;
					IF V_INCOME_AMT > 0 THEN -- �ҵ漼�� ������� ó��
					-- ��ǥ������ ���Ѵ�.
						InMakeSlipLine := InMakeSlipLine + 1;
					-- �� Body�� ���Ѵ�(�뺯)
						IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_INCOME_CODE,IsClassCode,Null);

						IrBody.CR_AMT            := V_INCOME_AMT; -- �뺯�ݾ�
						IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- ����������ڵ�
						IrBody.COMP_CODE         := C_COMP_CODE;   -- �ͼӻ�����ڵ�
						IrBody.DEPT_CODE         := as_dept_code;  -- �ͼӺμ�
						IrBody.VAT_DT            := V_YYMMDD;      -- ��������
						IrBody.SUPAMT            := 0;         -- ���ް�(�ΰ��� ���ο����� �Է�)
						IrBody.VATAMT            := 0;         -- �ΰ���(�ΰ��� ���ο����� �Է�)
						IrBody.CUST_SEQ          := InCustSeq;     -- �ŷ�ó����
						IrBody.CUST_NAME         := IsCustName;    -- �ŷ�ó��Ī
						IrBody.SUMMARY1          := V_CONT;        -- ����
		
						-- Body�� �����Ѵ�.
						PKG_MAKE_SLIP.Insert_Body(IrBody);

						C_AMT := C_AMT - V_INCOME_AMT;
					END IF;
					IF V_CIVI_AMT > 0 THEN -- �ֹμ��� ������� ó��
					-- ��ǥ������ ���Ѵ�.
						InMakeSlipLine := InMakeSlipLine + 1;
					-- �� Body�� ���Ѵ�(�뺯)
						IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CIVI_CODE,IsClassCode,Null);

						IrBody.CR_AMT            := V_CIVI_AMT; -- �뺯�ݾ�
						IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- ����������ڵ�
						IrBody.COMP_CODE         := C_COMP_CODE;   -- �ͼӻ�����ڵ�
						IrBody.DEPT_CODE         := as_dept_code;  -- �ͼӺμ�
						IrBody.VAT_DT            := V_YYMMDD;      -- ��������
						IrBody.SUPAMT            := 0;         -- ���ް�(�ΰ��� ���ο����� �Է�)
						IrBody.VATAMT            := 0;         -- �ΰ���(�ΰ��� ���ο����� �Է�)
						IrBody.CUST_SEQ          := InCustSeq;     -- �ŷ�ó����
						IrBody.CUST_NAME         := IsCustName;    -- �ŷ�ó��Ī
						IrBody.SUMMARY1          := V_CONT;        -- ����
		
						-- Body�� �����Ѵ�.
						PKG_MAKE_SLIP.Insert_Body(IrBody);

						C_AMT := C_AMT - V_CIVI_AMT;
					END IF;
					-- ��ǥ������ ���Ѵ�.
					InMakeSlipLine := InMakeSlipLine + 1;
					-- �� Body�� ���Ѵ�(�뺯)
					IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CR_CODE,IsClassCode,Null);
					LOOP
						select a.slip_id,a.slip_idseq,a.SET_AMT - (a.RESET_AMT+a.NOT_RESET_AMT),a.cust_seq,a.cust_name
						  into C_SLIP_ID,C_SLIP_IDSEQ,C_SET_AMT,C_CUST_SEQ,C_CUST_NAME
							from ( SELECT X.ACC_CODE,X.COMP_CODE,X.DEPT_CODE,X.CUST_SEQ,X.CUST_NAME,X.SLIP_ID,X.SLIP_IDSEQ,X.SET_AMT SET_AMT,X.RESET_AMT RESET_AMT,    
											  X.NOT_RESET_AMT NOT_RESET_AMT,X.RESET_AMT+X.NOT_RESET_AMT TOTAL_RESET_AMT,rownum aa
										FROM ( SELECT A.ACC_CODE,A.COMP_CODE,A.DEPT_CODE,A.CUST_SEQ,A.CUST_NAME,A.SLIP_ID,A.SLIP_IDSEQ,D.ACC_REMAIN_POSITION,
														  DECODE(D.ACC_REMAIN_POSITION, 'D', 1, 0)*NVL(A.DB_AMT,0) + DECODE(D.ACC_REMAIN_POSITION, 'C', 1, 0)*NVL(A.CR_AMT,0) SET_AMT, 
														  DECODE(D.ACC_REMAIN_POSITION, 'D', -1, 1)*NVL(B1.DB_AMT,0) + DECODE(D.ACC_REMAIN_POSITION, 'C', -1, 1)*NVL(B1.CR_AMT,0) RESET_AMT,  
														  DECODE(D.ACC_REMAIN_POSITION, 'D', -1, 1)*NVL(B2.DB_AMT,0) + DECODE(D.ACC_REMAIN_POSITION, 'C', -1, 1)*NVL(B2.CR_AMT,0) NOT_RESET_AMT   
													FROM T_ACC_SLIP_BODY1 A,    
														 ( SELECT A.RESET_SLIP_ID,A.RESET_SLIP_IDSEQ,NVL(SUM(A.DB_AMT),0) DB_AMT,NVL(SUM(A.CR_AMT),0) CR_AMT 
															  FROM T_ACC_SLIP_BODY1 A
															 WHERE A.COMP_CODE = C_COMP_CODE
																AND A.DEPT_CODE = as_dept_code
																AND A.ACC_CODE  = C_CR_CODE
																AND A.SLIP_IDSEQ <> A.RESET_SLIP_IDSEQ    
																AND A.KEEP_DT IS NOT NULL 
																AND A.TRANSFER_TAG <> 'T'
																AND A.IGNORE_SET_RESET_TAG <> 'T'
														 GROUP BY A.RESET_SLIP_ID,A.RESET_SLIP_IDSEQ) B1,   
														 ( SELECT A.RESET_SLIP_ID,A.RESET_SLIP_IDSEQ,NVL(SUM(A.DB_AMT),0) DB_AMT,NVL(SUM(A.CR_AMT),0) CR_AMT 
															  FROM T_ACC_SLIP_BODY1 A
															 WHERE A.COMP_CODE = C_COMP_CODE
																AND A.DEPT_CODE = as_dept_code
																AND A.ACC_CODE  = C_CR_CODE
																AND A.SLIP_IDSEQ <> A.RESET_SLIP_IDSEQ    
																AND A.KEEP_DT IS NULL 
																AND A.TRANSFER_TAG <> 'T'
																AND A.IGNORE_SET_RESET_TAG <> 'T'
														 GROUP BY A.RESET_SLIP_ID,A.RESET_SLIP_IDSEQ) B2,   
													T_ACC_CODE D 
									  WHERE A.SLIP_ID = A.RESET_SLIP_ID    
										 AND A.SLIP_IDSEQ = A.RESET_SLIP_IDSEQ    
										 AND A.SLIP_ID = B1.RESET_SLIP_ID (+) 
										 AND A.SLIP_IDSEQ = B1.RESET_SLIP_IDSEQ (+)   
										 AND A.SLIP_ID = B2.RESET_SLIP_ID (+) 
										 AND A.SLIP_IDSEQ = B2.RESET_SLIP_IDSEQ (+)   
										 AND A.ACC_CODE = D.ACC_CODE   
										 AND A.KEEP_DT IS NOT NULL   
										 AND A.COMP_CODE = C_COMP_CODE
										 AND A.DEPT_CODE = as_dept_code
										 AND A.ACC_CODE  = C_CR_CODE
										 AND A.TRANSFER_TAG <> 'T'
										 AND A.IGNORE_SET_RESET_TAG <> 'T'
										 AND D.Acc_REMAIN_MNG = 'T' ) X	  
								 WHERE X.SET_AMT - (X.RESET_AMT+X.NOT_RESET_AMT) > 0
								order by X.SLIP_ID asc) a
							where a.aa = 1;
						IF C_AMT <= C_SET_AMT THEN
							EXIT;
						END IF;
						C_TEMP_AMT := C_AMT - C_SET_AMT;
	
						IrBody.CR_AMT            := C_SET_AMT; -- �뺯�ݾ�
						IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- ����������ڵ�
						IrBody.COMP_CODE         := C_COMP_CODE;   -- �ͼӻ�����ڵ�
						IrBody.DEPT_CODE         := as_dept_code;  -- �ͼӺμ�
						IrBody.VAT_DT            := V_YYMMDD;      -- ��������
						IrBody.SUPAMT            := 0;         -- ���ް�(�ΰ��� ���ο����� �Է�)
						IrBody.VATAMT            := 0;         -- �ΰ���(�ΰ��� ���ο����� �Է�)
						IrBody.CUST_SEQ          := C_CUST_SEQ;     -- �ŷ�ó����
						IrBody.CUST_NAME         := C_CUST_NAME;    -- �ŷ�ó��Ī
						IrBody.SUMMARY1          := V_CONT;        -- ����
						IrBody.RESET_SLIP_ID     := C_SLIP_ID;
						IrBody.RESET_SLIP_IDSEQ  := C_SLIP_IDSEQ;
			
						-- Body�� �����Ѵ�.
						PKG_MAKE_SLIP.Insert_Body(IrBody);
						C_AMT := C_TEMP_AMT;
		
						-- ��ǥ������ ���Ѵ�.
						InMakeSlipLine := InMakeSlipLine + 1;
						-- �� Body�� ���Ѵ�(�뺯)
						IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CR_CODE,IsClassCode,Null);
					END LOOP;
	
					IrBody.CR_AMT            := C_AMT; -- �뺯�ݾ�
					IrBody.RESET_SLIP_ID     := C_SLIP_ID;
					IrBody.RESET_SLIP_IDSEQ  := C_SLIP_IDSEQ;
				ELSE
				-- ��ǥ������ ���Ѵ�.
					InMakeSlipLine := InMakeSlipLine + 1;
				-- �� Body�� ���Ѵ�(�뺯)
					IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,'540210100',IsClassCode,Null);
					IrBody.CR_AMT            := V_AMT; -- �뺯�ݾ�
				END IF;
				IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- ����������ڵ�
				IrBody.COMP_CODE         := C_COMP_CODE;   -- �ͼӻ�����ڵ�
				IrBody.DEPT_CODE         := as_dept_code;  -- �ͼӺμ�
				IrBody.VAT_DT            := V_YYMMDD;      -- ��������
				IrBody.SUPAMT            := 0;         -- ���ް�(�ΰ��� ���ο����� �Է�)
				IrBody.VATAMT            := 0;         -- �ΰ���(�ΰ��� ���ο����� �Է�)
				IrBody.CUST_SEQ          := C_CUST_SEQ;     -- �ŷ�ó����
				IrBody.CUST_NAME         := C_CUST_NAME;    -- �ŷ�ó��Ī
				IrBody.SUMMARY1          := V_CONT;        -- ����
	
				-- Body�� �����Ѵ�.
				PKG_MAKE_SLIP.Insert_Body(IrBody);
	
			END LOOP;
			CLOSE DETAIL_CUR;
	
	-- ���̺� ��ǥ�����͹�ȣ�� Setting �Ѵ�.
			update f_request
				set invoice_num = IrHead.Slip_ID,temp_chk = 'F',work_date = as_slip_dt
			 where dept_code = as_dept_code
				and trunc(rqst_date,'MM')= as_date
				and res_class = 'X'
				and exe_type = '1'
			   and cost_type = '1'
			   and temp_chk = 'T'
				and invoice_num is null;
	
	-- ��ǥ�� �����Ѵ�.
			PKG_MAKE_SLIP.Check_Slip(IrHead.Slip_ID);
		END IF;

		SELECT NVL(COUNT(*),0)
		  into C_CNT
		  from f_request
		 where dept_code = as_dept_code
			and trunc(rqst_date,'MM')= as_date
			and res_class = 'L'
			and exe_type = '1'
		   and cost_type = '1'
		   and temp_chk = 'T'
			and invoice_num is null;

		IF C_CNT > 0 THEN
	-- �빫����ǥ����
	-- ȸ�� Ȯ�� ����ڸ� ������ �´�	
			IsChargePers := PKG_MAKE_SLIP.Get_CHARGE_PERS('L000000001',C_COMP_CODE);
	
	-- ��ǥ�����͸� �����Ѵ�(������ڵ�,�����ڵ�,��ǥ������,'1'��ü,'C'���,�ۼ��ڻ��,�ڵ���ǥ�ڵ�,ȸ��Ȯ�����,�Է��ڻ��)
			IrHead := PKG_MAKE_SLIP.New_Head(C_COMP_CODE,as_dept_code,as_slip_dt,'1','C',as_user,'L000000001',IsChargePers,as_user);
	
			PKG_MAKE_SLIP.Insert_Head(IrHead);
	
			InMakeSlipLine := 0;
	
	
	-- ��ǥ������ ����� ���� Ŀ��
			OPEN	DETAIL_CUR1;
			LOOP
				FETCH DETAIL_CUR1 INTO V_AMT,V_VAT,V_YYMMDD,V_CONT,V_RES_CLASS,V_DR_CLASS,V_ACNTCODE,V_CUST_CODE,V_INCOME_TYPE,V_INCOME_AMT,V_CIVI_AMT;
				EXIT WHEN DETAIL_CUR1%NOTFOUND;
	
				C_ACNT_CODE := '431030100';
				C_CR_CODE   := '111210200';
				C_CIVI_CODE := '210080200'; -- �ֹμ�
				C_INCOME_CODE := '210080103';    -- �Ͽ���
				-- �ŷ�ó������ ���Ѵ�.
				InCustSeq := PKG_MAKE_SLIP.Get_Cust_Seq('0000000000');
				-- �ŷ�ó��Ī�� ���Ѵ�.
				IsCustName := PKG_MAKE_SLIP.Get_Cust_Name(InCustSeq);
	
				-- ��ǥ������ ���Ѵ�.
				InMakeSlipLine := InMakeSlipLine + 1;
	
				-- �� Body�� ���Ѵ�(����).
				IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_ACNT_CODE,IsClassCode,Null);
				
				-- Body�� ������ �־��ش�.
				IrBody.DB_AMT            := V_AMT;        -- �����ݾ�
				IrBody.TAX_COMP_CODE     := C_COMP_CODE;  -- ����������ڵ�
				IrBody.COMP_CODE         := C_COMP_CODE;  -- �ͼӻ�����ڵ�
				IrBody.DEPT_CODE         := as_dept_code; -- �ͼӺμ�
				IrBody.VAT_DT            := V_YYMMDD;     -- ��������
				IrBody.SUPAMT            := 0;            -- ���ް�(�ΰ��� ���ο����� �Է�)
				IrBody.VATAMT            := 0;            -- �ΰ���(�ΰ��� ���ο����� �Է�)
				IrBody.SUMMARY1          := V_CONT;       -- ����
		
				-- Body�� �����Ѵ�.
				PKG_MAKE_SLIP.Insert_Body(IrBody);
			
				C_AMT := V_AMT;

				IF V_INCOME_AMT > 999 THEN -- �ҵ漼�� ������� ó��
				-- ��ǥ������ ���Ѵ�.
					InMakeSlipLine := InMakeSlipLine + 1;
				-- �� Body�� ���Ѵ�(�뺯)
					IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_INCOME_CODE,IsClassCode,Null);

					IrBody.CR_AMT            := V_INCOME_AMT; -- �뺯�ݾ�
					IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- ����������ڵ�
					IrBody.COMP_CODE         := C_COMP_CODE;   -- �ͼӻ�����ڵ�
					IrBody.DEPT_CODE         := as_dept_code;  -- �ͼӺμ�
					IrBody.VAT_DT            := V_YYMMDD;      -- ��������
					IrBody.SUPAMT            := 0;         -- ���ް�(�ΰ��� ���ο����� �Է�)
					IrBody.VATAMT            := 0;         -- �ΰ���(�ΰ��� ���ο����� �Է�)
					IrBody.CUST_SEQ          := InCustSeq;     -- �ŷ�ó����
					IrBody.CUST_NAME         := IsCustName;    -- �ŷ�ó��Ī
					IrBody.SUMMARY1          := V_CONT;        -- ����
	
					-- Body�� �����Ѵ�.
					PKG_MAKE_SLIP.Insert_Body(IrBody);

					C_AMT := C_AMT - V_INCOME_AMT;
				END IF;
				IF V_CIVI_AMT > 0 AND V_INCOME_AMT > 999 THEN -- �ֹμ��� ������� ó��
				-- ��ǥ������ ���Ѵ�.
					InMakeSlipLine := InMakeSlipLine + 1;
				-- �� Body�� ���Ѵ�(�뺯)
					IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CIVI_CODE,IsClassCode,Null);

					IrBody.CR_AMT            := V_CIVI_AMT; -- �뺯�ݾ�
					IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- ����������ڵ�
					IrBody.COMP_CODE         := C_COMP_CODE;   -- �ͼӻ�����ڵ�
					IrBody.DEPT_CODE         := as_dept_code;  -- �ͼӺμ�
					IrBody.VAT_DT            := V_YYMMDD;      -- ��������
					IrBody.SUPAMT            := 0;         -- ���ް�(�ΰ��� ���ο����� �Է�)
					IrBody.VATAMT            := 0;         -- �ΰ���(�ΰ��� ���ο����� �Է�)
					IrBody.CUST_SEQ          := InCustSeq;     -- �ŷ�ó����
					IrBody.CUST_NAME         := IsCustName;    -- �ŷ�ó��Ī
					IrBody.SUMMARY1          := V_CONT;        -- ����
	
					-- Body�� �����Ѵ�.
					PKG_MAKE_SLIP.Insert_Body(IrBody);

					C_AMT := C_AMT - V_CIVI_AMT;
				END IF;
				InMakeSlipLine := InMakeSlipLine + 1;
				-- �� Body�� ���Ѵ�(�뺯)
				IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CR_CODE,IsClassCode,Null);
				
				-- Body�� ������ �־��ش�.
				LOOP
					select a.slip_id,a.slip_idseq,a.SET_AMT - (a.RESET_AMT+a.NOT_RESET_AMT),a.cust_seq,a.cust_name
					  into C_SLIP_ID,C_SLIP_IDSEQ,C_SET_AMT,C_CUST_SEQ,C_CUST_NAME
						from ( SELECT X.ACC_CODE,X.COMP_CODE,X.DEPT_CODE,X.SLIP_ID,X.SLIP_IDSEQ,X.SET_AMT SET_AMT,X.RESET_AMT RESET_AMT,    
										  X.NOT_RESET_AMT NOT_RESET_AMT,X.RESET_AMT+X.NOT_RESET_AMT TOTAL_RESET_AMT,rownum aa,X.CUST_SEQ,X.CUST_NAME
									FROM ( SELECT A.ACC_CODE,A.COMP_CODE,A.DEPT_CODE,A.SLIP_ID,A.SLIP_IDSEQ,D.ACC_REMAIN_POSITION,A.CUST_SEQ,A.CUST_NAME,
													  DECODE(D.ACC_REMAIN_POSITION, 'D', 1, 0)*NVL(A.DB_AMT,0) + DECODE(D.ACC_REMAIN_POSITION, 'C', 1, 0)*NVL(A.CR_AMT,0) SET_AMT, 
													  DECODE(D.ACC_REMAIN_POSITION, 'D', -1, 1)*NVL(B1.DB_AMT,0) + DECODE(D.ACC_REMAIN_POSITION, 'C', -1, 1)*NVL(B1.CR_AMT,0) RESET_AMT,  
													  DECODE(D.ACC_REMAIN_POSITION, 'D', -1, 1)*NVL(B2.DB_AMT,0) + DECODE(D.ACC_REMAIN_POSITION, 'C', -1, 1)*NVL(B2.CR_AMT,0) NOT_RESET_AMT   
												FROM T_ACC_SLIP_BODY1 A,    
													 ( SELECT A.RESET_SLIP_ID,A.RESET_SLIP_IDSEQ,NVL(SUM(A.DB_AMT),0) DB_AMT,NVL(SUM(A.CR_AMT),0) CR_AMT 
														  FROM T_ACC_SLIP_BODY1 A
														 WHERE A.COMP_CODE = C_COMP_CODE
															AND A.DEPT_CODE = as_dept_code
															AND A.ACC_CODE  = C_CR_CODE
															AND A.SLIP_IDSEQ <> A.RESET_SLIP_IDSEQ    
															AND A.KEEP_DT IS NOT NULL 
															AND A.TRANSFER_TAG <> 'T'
															AND A.IGNORE_SET_RESET_TAG <> 'T'
													 GROUP BY A.RESET_SLIP_ID,A.RESET_SLIP_IDSEQ) B1,   
													 ( SELECT A.RESET_SLIP_ID,A.RESET_SLIP_IDSEQ,NVL(SUM(A.DB_AMT),0) DB_AMT,NVL(SUM(A.CR_AMT),0) CR_AMT 
														  FROM T_ACC_SLIP_BODY1 A
														 WHERE A.COMP_CODE = C_COMP_CODE
															AND A.DEPT_CODE = as_dept_code
															AND A.ACC_CODE  = C_CR_CODE
															AND A.SLIP_IDSEQ <> A.RESET_SLIP_IDSEQ    
															AND A.KEEP_DT IS NULL 
															AND A.TRANSFER_TAG <> 'T'
															AND A.IGNORE_SET_RESET_TAG <> 'T'
													 GROUP BY A.RESET_SLIP_ID,A.RESET_SLIP_IDSEQ) B2,   
													T_ACC_CODE D 
								  WHERE A.SLIP_ID = A.RESET_SLIP_ID    
									 AND A.SLIP_IDSEQ = A.RESET_SLIP_IDSEQ    
									 AND A.SLIP_ID = B1.RESET_SLIP_ID (+) 
									 AND A.SLIP_IDSEQ = B1.RESET_SLIP_IDSEQ (+)   
									 AND A.SLIP_ID = B2.RESET_SLIP_ID (+) 
									 AND A.SLIP_IDSEQ = B2.RESET_SLIP_IDSEQ (+)   
									 AND A.ACC_CODE = D.ACC_CODE   
									 AND A.KEEP_DT IS NOT NULL   
									 AND A.COMP_CODE = C_COMP_CODE
									 AND A.DEPT_CODE = as_dept_code
									 AND A.ACC_CODE  = C_CR_CODE
									 AND A.TRANSFER_TAG <> 'T'
									 AND A.IGNORE_SET_RESET_TAG <> 'T'
									 AND D.Acc_REMAIN_MNG = 'T' ) X	  
							 WHERE X.SET_AMT - (X.RESET_AMT+X.NOT_RESET_AMT) > 0
							order by X.SLIP_ID asc) a
						where a.aa = 1;
					IF C_AMT <= C_SET_AMT THEN
						EXIT;
					END IF;
					C_TEMP_AMT := C_AMT - C_SET_AMT;
	
					IrBody.CR_AMT            := C_SET_AMT; -- �뺯�ݾ�
					IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- ����������ڵ�
					IrBody.COMP_CODE         := C_COMP_CODE;   -- �ͼӻ�����ڵ�
					IrBody.DEPT_CODE         := as_dept_code;  -- �ͼӺμ�
					IrBody.VAT_DT            := V_YYMMDD;      -- ��������
					IrBody.SUPAMT            := 0;         -- ���ް�(�ΰ��� ���ο����� �Է�)
					IrBody.VATAMT            := 0;         -- �ΰ���(�ΰ��� ���ο����� �Է�)
					IrBody.SUMMARY1          := V_CONT;        -- ����
					IrBody.RESET_SLIP_ID     := C_SLIP_ID;
					IrBody.RESET_SLIP_IDSEQ  := C_SLIP_IDSEQ;
					IrBody.CUST_SEQ          := C_CUST_SEQ;     -- �ŷ�ó����
					IrBody.CUST_NAME         := C_CUST_NAME;    -- �ŷ�ó��Ī
		
					-- Body�� �����Ѵ�.
					PKG_MAKE_SLIP.Insert_Body(IrBody);
					C_AMT := C_TEMP_AMT;
	
					-- ��ǥ������ ���Ѵ�.
					InMakeSlipLine := InMakeSlipLine + 1;
					-- �� Body�� ���Ѵ�(�뺯)
					IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CR_CODE,IsClassCode,Null);
				END LOOP;
	
				IrBody.CR_AMT            := C_AMT; -- �뺯�ݾ�
				IrBody.RESET_SLIP_ID     := C_SLIP_ID;
				IrBody.RESET_SLIP_IDSEQ  := C_SLIP_IDSEQ;
				IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- ����������ڵ�
				IrBody.COMP_CODE         := C_COMP_CODE;   -- �ͼӻ�����ڵ�
				IrBody.DEPT_CODE         := as_dept_code;  -- �ͼӺμ�
				IrBody.VAT_DT            := V_YYMMDD;      -- ��������
				IrBody.SUPAMT            := 0;         -- ���ް�(�ΰ��� ���ο����� �Է�)
				IrBody.VATAMT            := 0;         -- �ΰ���(�ΰ��� ���ο����� �Է�)
				IrBody.SUMMARY1          := V_CONT;        -- ����
				IrBody.CUST_SEQ          := C_CUST_SEQ;     -- �ŷ�ó����
				IrBody.CUST_NAME         := C_CUST_NAME;    -- �ŷ�ó��Ī
	
				-- Body�� �����Ѵ�.
				PKG_MAKE_SLIP.Insert_Body(IrBody);
	
			END LOOP;
			CLOSE DETAIL_CUR1;
	
	-- ���̺� ��ǥ�����͹�ȣ�� Setting �Ѵ�.
			update f_request
				set invoice_num = IrHead.Slip_ID,temp_chk = 'F',work_date = as_slip_dt
			 where dept_code = as_dept_code
				and trunc(rqst_date,'MM')= as_date
				and res_class = 'L'
				and exe_type = '1'
			   and cost_type = '1'
			   and temp_chk = 'T'
				and invoice_num is null;
	
	-- ��ǥ�� �����Ѵ�.
			PKG_MAKE_SLIP.Check_Slip(IrHead.Slip_ID);
		END IF;

--      EXCEPTION
--      WHEN others THEN 
--           IF SQL%NOTFOUND THEN
--              e_msg      := '��������ǥ���� ����! [Line No: 2]';
--              Wk_errflag := -20020;
         
--              GOTO EXIT_ROUTINE;
--           END IF;   
--				Raise;

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
END y_sp_f_slip_request;
