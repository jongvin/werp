 /* ============================================================================ */
/* �Լ��� : y_sp_s_slip_prepayment(CJ����)                                       */
/* ��  �� : ���ְ���-���ޱ�������ǥ ����                                         */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ��ǥ���               ==> as_date(DATE)        		               */
/*        : �ۼ��ڻ��             ==> as_date(string)        		               */
/*        : ���ֹ�ȣ               ==> ai_order_number(integer)                  */
/*        : ����  	              ==> ai_seq(integer)			                  */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2006.04.12                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_s_slip_prepayment (as_dept_code    IN   VARCHAR2,
																	  as_date         IN   DATE,
                                                     as_user         IN   VARCHAR2,
																	  ai_order_number IN INTEGER,
																	  ai_seq          IN INTEGER	) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT c.guarantee_amt,c.guarantee_vat,c.guarantee_issueday,b.sbcr_name || '�� ' || a.sbc_name || ' ��� ���ޱ� ����',c.pay_dt,
		 trunc((c.guarantee_amt + c.guarantee_vat) * a.prgs_cash_rt * 0.01,0),
		 c.guarantee_amt + c.guarantee_vat - trunc((c.guarantee_amt + c.guarantee_vat) * a.prgs_cash_rt * 0.01,0),a.bill_day,a.vatcode,
		 b.businessman_number,b.sbcr_name,b.rep_name1,b.kind_bussinesstype,b.kinditem,b.zip_number1,b.address1,b.tel_number1,b.chrg_name1,b.chrg_email
  FROM s_cn_list a,
		 s_sbcr b,
		 s_guarantee_accept c
 WHERE a.sbcr_code = b.sbcr_code
	AND c.dept_code = a.dept_code
	AND c.order_number = a.order_number
	AND c.dept_code = as_dept_code
	AND c.order_number = ai_order_number
	AND c.seq = ai_seq;

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
	V_PAY_DT            DATE;
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
	C_COMP_CODE         VARCHAR2(10);
	C_ACNT_CODE         VARCHAR2(10);
	C_VAT_CODE          VARCHAR2(10);
	C_CR_CODE           VARCHAR2(10);
	C_SEQ               INTEGER;
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
		IsChargePers := PKG_MAKE_SLIP.Get_CHARGE_PERS('S000000001',C_COMP_CODE);

-- �ι��� ���Ѵ�.
		IsClassCode := PKG_MAKE_SLIP.Get_Class_code(as_dept_code);

-- ��ǥ�����͸� �����Ѵ�(������ڵ�,�����ڵ�,��ǥ������,'1'��ü,'E'����,�ۼ��ڻ��,�ڵ���ǥ�ڵ�,ȸ��Ȯ�����,�Է��ڻ��)
		IrHead := PKG_MAKE_SLIP.New_Head(C_COMP_CODE,as_dept_code,as_date,'1','E',as_user,'S000000001',IsChargePers,as_user);

		PKG_MAKE_SLIP.Insert_Head(IrHead);

-- ���̺��� ��ǥ�����͹�ȣ�� Setting �Ѵ�.
		update s_guarantee_accept
			set invoice_num = IrHead.Slip_ID
		 where dept_code = as_dept_code
			AND order_number = ai_order_number
			AND seq = ai_seq;

		InMakeSlipLine := 0;

-- ��ǥ������ ����� ���� Ŀ��
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO V_AMT,V_VAT,V_YYMMDD,V_CONT,V_PAY_DT,V_CASH,V_BILL,V_BILL_DAY,V_VAT_CLASS,V_CUST_CODE,V_SBCR_NAME,
										 V_REP_NAME,V_KIND_TYPE,V_KINDITEM,V_ZIP_NUM,V_ADDR,V_TEL_NUM,V_CHRG_NAME,V_CHRG_EMAIL;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
	
			C_ACNT_CODE := '111250100';
			C_CR_CODE   := '210030100';
			IF V_VAT_CLASS = '1' THEN      -- ����
				C_VAT_CODE := '111220100';
			END IF;
			IF V_VAT_CLASS = '2' THEN      -- �鼼
				C_VAT_CODE := '111220200';
			END IF;
			IF V_VAT_CLASS = '3' THEN      -- �Ұ���
				C_VAT_CODE := '111221300';
			END IF;
			IF V_VAT_CLASS = '4' THEN      -- ����
				C_VAT_CODE := '111220100';
			END IF;

			-- �ŷ�ó������ ���Ѵ�.
			InCustSeq := PKG_MAKE_SLIP.Get_Cust_Seq(V_CUST_CODE);
			IF InCustSeq is null THEN       -- ȸ��ŷ�ó�� ������� �ŷ�ó ���̺��� �����Ѵ�.
				InCustSeq := F_T_NEW_CUST(V_CUST_CODE,V_SBCR_NAME,V_REP_NAME,'1',V_KIND_TYPE,V_KINDITEM,V_ZIP_NUM,V_ADDR,
												  '',V_TEL_NUM,'ZZ',null,null,V_CHRG_NAME,V_CHRG_EMAIL,as_user);
			END IF;
			-- �ŷ�ó��Ī�� ���Ѵ�.
			IsCustName := PKG_MAKE_SLIP.Get_Cust_Name(InCustSeq);

			-- ��ǥ������ ���Ѵ�.
			InMakeSlipLine := InMakeSlipLine + 1;

			-- �� Body�� ���Ѵ�(����).
			IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_ACNT_CODE,IsClassCode,Null);
			
			-- Body�� ������ �־��ش�.
			IF V_VAT_CLASS = '3' THEN      -- �Ұ���
				IrBody.DB_AMT            := V_AMT + V_VAT;        -- �����ݾ�
			ELSE
				IrBody.DB_AMT            := V_AMT;        -- �����ݾ�
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
			IrBody.PAY_CON_CASH      := V_CASH;       -- ����
			IrBody.PAY_CON_BILL      := V_BILL;       -- ����
			IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;   -- ���������ϼ�
			IrBody.RESET_SLIP_ID     := IrBody.SLIP_ID; -- ������ǥ
			IrBody.RESET_SLIP_IDSEQ  := IrBody.SLIP_IDSEQ; -- ������ǥ
			IrBody.ANTICIPATION_DT   := V_PAY_DT; -- ���������

			update s_guarantee_accept
				set invoice_num1 = IrBody.SLIP_IDSEQ
			 where dept_code = as_dept_code
				AND order_number = ai_order_number
				AND seq = ai_seq;
	
			-- Body�� �����Ѵ�.
			PKG_MAKE_SLIP.Insert_Body(IrBody);
	
			InMakeSlipLine := InMakeSlipLine + 1;

			-- �� Body�� ���Ѵ�(����:�ΰ�������)
			IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_VAT_CODE,IsClassCode,Null);
			
			-- Body�� ������ �־��ش�.
			IF V_VAT_CLASS = '3' THEN      -- �Ұ���
				IrBody.DB_AMT            := 0;        -- �����ݾ�
			ELSE
				IrBody.DB_AMT            := V_VAT;        -- �����ݾ�
			END IF;
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
			IrBody.ANTICIPATION_DT   := V_PAY_DT; -- ���������

			-- Body�� �����Ѵ�.
			PKG_MAKE_SLIP.Insert_Body(IrBody);


			InMakeSlipLine := InMakeSlipLine + 1;

			-- �� Body�� ���Ѵ�(�뺯)
			IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CR_CODE,IsClassCode,Null);
			
			-- Body�� ������ �־��ش�.
			IrBody.CR_AMT            := V_AMT + V_VAT; -- �뺯�ݾ�
			IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- ����������ڵ�
			IrBody.COMP_CODE         := C_COMP_CODE;   -- �ͼӻ�����ڵ�
			IrBody.DEPT_CODE         := as_dept_code;  -- �ͼӺμ�
			IrBody.VAT_DT            := V_YYMMDD;      -- ��������
			IrBody.SUPAMT            := 0;         -- ���ް�(�ΰ��� ���ο����� �Է�)
			IrBody.VATAMT            := 0;         -- �ΰ���(�ΰ��� ���ο����� �Է�)
			IrBody.CUST_SEQ          := InCustSeq;     -- �ŷ�ó����
			IrBody.CUST_NAME         := IsCustName;    -- �ŷ�ó��Ī
			IrBody.SUMMARY1          := V_CONT;        -- ����
			IrBody.PAY_CON_CASH      := V_CASH;        -- ����
			IrBody.PAY_CON_BILL      := V_BILL;        -- ����
			IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;    -- ���������ϼ�
			IrBody.ANTICIPATION_DT   := V_PAY_DT; -- ���������
			IrBody.MNG_ITEM_DT1      := V_YYMMDD; -- ��꼭����

			-- Body�� �����Ѵ�.
			PKG_MAKE_SLIP.Insert_Body(IrBody);

		END LOOP;
		CLOSE DETAIL_CUR;

-- ��ǥ�� �����Ѵ�.
		PKG_MAKE_SLIP.Check_Slip(IrHead.Slip_ID);

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '���ޱ���ǥ���� ����! [Line No: 2]';
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
when others then
raise;
END y_sp_s_slip_prepayment;