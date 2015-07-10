 /* ============================================================================ */
/* �Լ��� : y_sp_q_slip(CJ����)                                      */
/* ��  �� : �������-�԰���ǥ ����                                               */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ��ǥ���               ==> as_date(DATE)        		               */
/*        : �ۼ��ڻ��             ==> as_date(string)        		               */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2006.04.12                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_q_slip (as_dept_code    IN   VARCHAR2,
																	  as_date         IN   DATE,
                                                     as_user         IN   VARCHAR2) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT a.monthly_amt,a.vat,a.yymm,b.eqp_vender_name || to_char(a.yymm,'YYYY.MM') || '�� ����',a.pay_cash,a.pay_bill,a.bill_day,
		 b.regist_no,b.eqp_vender_name,b.pregident_name,'' kind_bussinesstype,'' kinditem,'' zip_number1,b.address,b.tel_no,'' chrg_name1,'' chrg_email,cust_type
  FROM q_monthly_payment a,
		 q_code_eqp_vender b
 WHERE a.regist_no = b.regist_no
	AND a.dept_code = as_dept_code
	AND trunc(a.yymm,'MM')= as_date
ORDER BY a.regist_no;

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
	V_CASH              NUMBER(20,5);
	V_BILL              NUMBER(20,5);
	V_BILL_DAY          NUMBER(20,0);
	V_DITAG             VARCHAR2(2);
	V_VAT_CLASS         VARCHAR2(2);
	V_CUST_CODE         VARCHAR2(20);
   V_SBCR_NAME         s_sbcr.sbcr_name%type;
   V_REP_NAME          s_sbcr.rep_name1%type;
   V_KIND_TYPE         s_sbcr.kind_bussinesstype%type;
   V_KINDITEM          s_sbcr.kinditem%type;
   V_ZIP_NUM           s_sbcr.zip_number1%type;
   V_ADDR              s_sbcr.address1%type;
   V_TEL_NUM           s_sbcr.tel_number1%type;
   V_CHRG_NAME         s_sbcr.chrg_name1%type;
   V_CHRG_EMAIL        s_sbcr.chrg_email%type;
   V_CUST_TYPE         q_code_eqp_vender.cust_type%type;
	C_COMP_CODE         VARCHAR2(10);
	C_ACNT_CODE         VARCHAR2(10);
	C_VAT_CODE          VARCHAR2(10);
	C_CR_CODE           VARCHAR2(10);
	C_AMT               NUMBER(20,5);
	C_SET_AMT           NUMBER(20,5);
	C_TEMP_AMT          NUMBER(20,5);
	C_SLIP_ID           NUMBER;
	C_SLIP_IDSEQ        NUMBER;
	C_SEQ               INTEGER;
	C_CUST_SEQ          NUMBER;
	C_CUST_NAME         VARCHAR2(60);
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

-- ȸ�� Ȯ�� ����ڸ� ������ �´�	
		IsChargePers := PKG_MAKE_SLIP.Get_CHARGE_PERS('Q000000001',C_COMP_CODE);

-- �ι��� ���Ѵ�.
		IsClassCode := PKG_MAKE_SLIP.Get_Class_code(as_dept_code);

-- ��ǥ�����͸� �����Ѵ�(������ڵ�,�����ڵ�,��ǥ������,'1'��ü,'C'���,�ۼ��ڻ��,�ڵ���ǥ�ڵ�,ȸ��Ȯ�����,�Է��ڻ��)
		IrHead := PKG_MAKE_SLIP.New_Head(C_COMP_CODE,as_dept_code,as_date,'1','C',as_user,'Q000000001',IsChargePers,as_user);

		PKG_MAKE_SLIP.Insert_Head(IrHead);

-- ���̺� ��ǥ�����͹�ȣ�� Setting �Ѵ�.
		update q_monthly_payment
			set invoice_num = IrHead.Slip_ID
		 where dept_code = as_dept_code
			AND trunc(yymm,'MM')= as_date;

		InMakeSlipLine := 0;

-- ��ǥ������ ����� ���� Ŀ��
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO V_AMT,V_VAT,V_YYMMDD,V_CONT,V_CASH,V_BILL,V_BILL_DAY,V_CUST_CODE,V_SBCR_NAME,
										 V_REP_NAME,V_KIND_TYPE,V_KINDITEM,V_ZIP_NUM,V_ADDR,V_TEL_NUM,V_CHRG_NAME,V_CHRG_EMAIL,V_CUST_TYPE;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
	
			C_ACNT_CODE := '432270100';
			C_CR_CODE   := '111210200';
			C_VAT_CODE  := '111220100';

			-- �ŷ�ó������ ���Ѵ�.
			InCustSeq := PKG_MAKE_SLIP.Get_Cust_Seq(V_CUST_CODE);
			IF InCustSeq is null THEN       -- ȸ��ŷ�ó�� ������� �ŷ�ó ���̺� �����Ѵ�.
				InCustSeq := F_T_NEW_CUST(V_CUST_CODE,V_SBCR_NAME,V_REP_NAME,V_CUST_TYPE,V_KIND_TYPE,V_KINDITEM,V_ZIP_NUM,V_ADDR,
												  '',V_TEL_NUM,'ZZ',null,null,V_CHRG_NAME,V_CHRG_EMAIL,as_user);
			END IF;
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
			IrBody.CUST_SEQ          := InCustSeq;    -- �ŷ�ó����
			IrBody.CUST_NAME         := IsCustName;   -- �ŷ�ó��Ī
			IrBody.SUMMARY1          := V_CONT;       -- ����
			IrBody.PAY_CON_CASH      := V_CASH;       -- ����
			IrBody.PAY_CON_BILL      := V_BILL;       -- ����
			IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;   -- ���������ϼ�
	
			-- Body�� �����Ѵ�.
			PKG_MAKE_SLIP.Insert_Body(IrBody);
	
			InMakeSlipLine := InMakeSlipLine + 1;

			-- �� Body�� ���Ѵ�(����:�ΰ�������)
			IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_VAT_CODE,IsClassCode,Null);
			
			-- Body�� ������ �־��ش�.
			IrBody.DB_AMT            := V_VAT;        -- �����ݾ�
			IrBody.TAX_COMP_CODE     := C_COMP_CODE;  -- ����������ڵ�
			IrBody.COMP_CODE         := C_COMP_CODE;  -- �ͼӻ�����ڵ�
			IrBody.DEPT_CODE         := as_dept_code; -- �ͼӺμ�
			IrBody.VAT_DT            := V_YYMMDD;     -- ��������
			IrBody.SUPAMT            := V_AMT;        -- ���ް�(�ΰ��� ���ο����� �Է�)
			IrBody.VATAMT            := V_VAT;        -- �ΰ���(�ΰ��� ���ο����� �Է�)
			IrBody.CUST_SEQ          := InCustSeq;    -- �ŷ�ó����
			IrBody.CUST_NAME         := IsCustName;   -- �ŷ�ó��Ī
			IrBody.SUMMARY1          := V_CONT;       -- ����
			IrBody.PAY_CON_CASH      := V_CASH;       -- ����
			IrBody.PAY_CON_BILL      := V_BILL;       -- ����
			IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;   -- ���������ϼ�

			-- Body�� �����Ѵ�.
			PKG_MAKE_SLIP.Insert_Body(IrBody);


			InMakeSlipLine := InMakeSlipLine + 1;

			-- �� Body�� ���Ѵ�(�뺯)
			IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CR_CODE,IsClassCode,Null);
			C_AMT := V_AMT + V_VAT;
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
														AND A.TRANSFER_TAG <> 'T'
														AND A.IGNORE_SET_RESET_TAG <> 'T'
														AND A.KEEP_DT IS NOT NULL 
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

				-- �� Body�� ���Ѵ�(�뺯)
				IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CR_CODE,IsClassCode,Null);
			END LOOP;
			
			-- Body�� ������ �־��ش�.
			IrBody.CR_AMT            := C_AMT; -- �뺯�ݾ�
			IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- ����������ڵ�
			IrBody.COMP_CODE         := C_COMP_CODE;   -- �ͼӻ�����ڵ�
			IrBody.DEPT_CODE         := as_dept_code;  -- �ͼӺμ�
			IrBody.VAT_DT            := V_YYMMDD;      -- ��������
			IrBody.SUPAMT            := 0;         -- ���ް�(�ΰ��� ���ο����� �Է�)
			IrBody.VATAMT            := 0;         -- �ΰ���(�ΰ��� ���ο����� �Է�)
			IrBody.CUST_SEQ          := C_CUST_SEQ;     -- �ŷ�ó����
			IrBody.CUST_NAME         := C_CUST_NAME;    -- �ŷ�ó��Ī
			IrBody.SUMMARY1          := V_CONT;        -- ����
			IrBody.PAY_CON_CASH      := V_CASH;        -- ����
			IrBody.PAY_CON_BILL      := V_BILL;        -- ����
			IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;    -- ���������ϼ�
			IrBody.RESET_SLIP_ID     := C_SLIP_ID;
			IrBody.RESET_SLIP_IDSEQ  := C_SLIP_IDSEQ;

			-- Body�� �����Ѵ�.
			PKG_MAKE_SLIP.Insert_Body(IrBody);

		END LOOP;
		CLOSE DETAIL_CUR;

-- ��ǥ�� �����Ѵ�.
		PKG_MAKE_SLIP.Check_Slip(IrHead.Slip_ID);

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '�����ǥ���� ����! [Line No: 2]';
              Wk_errflag := -20020;
         
              GOTO EXIT_ROUTINE;
           END IF;   
				Raise;
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
END y_sp_q_slip;
