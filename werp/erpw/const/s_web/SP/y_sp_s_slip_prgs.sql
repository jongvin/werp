/* ============================================================================ */
/* �Լ��� : y_sp_s_slip_prgs(CJ����)                                            */
/* ��  �� : ���ְ���-�⼺��ǥ ����                                               */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ��ǥ���               ==> as_date(DATE)        		               */
/*        : ����                   ==> ai_seq(INTEGER)        		               */
/*        : �ۼ��ڻ��             ==> as_date(string)        		               */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2006.04.12                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_s_slip_prgs (as_dept_code    IN   VARCHAR2,
																	  as_date         IN   DATE,
																	  ai_seq          IN   INTEGER,
                                                     as_user         IN   VARCHAR2) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
select a.tm_prgs,a.tm_vat,a.tm_prgs_notax + a.tm_purchase_vat,a.tm_cash,a.tm_bill,a.tm_pre_tax,a.tm_pre_vat,a.tm_pre_notax,a.pay_dt,a.check_dt,
		 b.sbc_name || ' ' || to_char(a.yymm,'YYYY.MM') || '�� �⼺',b.sbc_name || ' ' || to_char(a.yymm,'YYYY.MM') || '�� ���ޱݰ���',b.acc_tag,b.comm_tag,b.vatcode,b.bill_day,
		 c.businessman_number,c.sbcr_name,c.rep_name1,c.kind_bussinesstype,c.kinditem,c.zip_number1,c.address1,c.tel_number1,c.chrg_name1,c.chrg_email,a.order_number
  from s_pay a,
       s_cn_list b,
       s_sbcr c
 where b.sbcr_code = c.sbcr_code
   and a.dept_code = b.dept_code
   and a.order_number = b.order_number
   and a.dept_code = as_dept_code
   and a.yymm = as_date
   and a.seq = ai_seq
order by c.sbcr_name asc;

-- ���� ����
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
   Wk_Chk              NUMBER(10,0) DEFAULT 0 ;
   WK_Chk_msg          VARCHAR2(100);

-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	V_TM_PRGS           NUMBER(20,5);
	V_TM_VAT            NUMBER(20,5);
	V_TM_PRGS_NOTAX     NUMBER(20,5);
	V_CASH              NUMBER(20,5);
	V_BILL              NUMBER(20,5);
	V_TM_PRE_TAX        NUMBER(20,5);
	V_TM_PRE_VAT        NUMBER(20,5);
	V_TM_PRE_NOTAX      NUMBER(20,5);
	V_PAY_DT            DATE;
	V_CHECK_DT          DATE;
	V_CONT              VARCHAR2(100);
	V_CONT1             VARCHAR2(100);
	V_ACC_TAG           VARCHAR2(1);
	V_COMM_TAG          VARCHAR2(1);
	V_VATCODE           VARCHAR2(8);
	V_BILL_DAY          NUMBER(20,0);
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
	V_ORDER_NUMBER      s_pay.order_number%type;
	C_SLIP_DT           DATE;
	C_MAKE_DT           DATE;
   C_COMP_CODE         VARCHAR2(10);
	C_ACNT_CODE         VARCHAR2(10);
	C_VAT_CODE          VARCHAR2(10);
	C_CR_CODE           VARCHAR2(10);
	C_SEQ               INTEGER;
	C_AMT               NUMBER(20,5);
	C_SET_AMT           NUMBER(20,5);
	C_TEMP_AMT          NUMBER(20,5);
   C_CHK         VARCHAR2(10);
	C_SLIP_ID           NUMBER;
	C_SLIP_IDSEQ        NUMBER;
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
		select slip_dt,sysdate
		  into C_SLIP_DT,C_MAKE_DT
		  from s_prgs_yymm
		 where dept_code = as_dept_code
			and yymm = as_date
			and seq = ai_seq;

-- ��ǥ�����͸� �����Ѵ�(������ڵ�,�����ڵ�,��ǥ������,'1'��ü,'E'����,�ۼ��ڻ��,�ڵ���ǥ�ڵ�,ȸ��Ȯ�����,�Է��ڻ��)
		IrHead := PKG_MAKE_SLIP.New_Head(C_COMP_CODE,as_dept_code,C_SLIP_DT,'1','E',as_user,'S000000001',IsChargePers,as_user);
--		IrHead.MAKE_DT     := C_MAKE_DT;  -- �ۼ�����

		PKG_MAKE_SLIP.Insert_Head(IrHead);

-- ���̺� ��ǥ�����͹�ȣ�� Setting �Ѵ�.
		update s_pay
			set invoice_num = IrHead.Slip_ID
		 where dept_code = as_dept_code
			and yymm = as_date
			and seq  = ai_seq;

		InMakeSlipLine := 0;

-- ��ǥ������ ����� ���� Ŀ��
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO V_TM_PRGS,V_TM_VAT,V_TM_PRGS_NOTAX,V_CASH,V_BILL,V_TM_PRE_TAX,V_TM_PRE_VAT,
										 V_TM_PRE_NOTAX,V_PAY_DT,V_CHECK_DT,V_CONT,V_CONT1,V_ACC_TAG,V_COMM_TAG,V_VATCODE,
										 V_BILL_DAY,V_CUST_CODE,V_SBCR_NAME,V_REP_NAME,V_KIND_TYPE,V_KINDITEM,
										 V_ZIP_NUM,V_ADDR,V_TEL_NUM,V_CHRG_NAME,V_CHRG_EMAIL,V_ORDER_NUMBER;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
	
			-- �ŷ�ó������ ���Ѵ�.
			InCustSeq := PKG_MAKE_SLIP.Get_Cust_Seq(V_CUST_CODE);
			IF InCustSeq is null THEN       -- ȸ��ŷ�ó�� ������� �ŷ�ó ���̺� �����Ѵ�.
				InCustSeq := F_T_NEW_CUST(V_CUST_CODE,V_SBCR_NAME,V_REP_NAME,'1',V_KIND_TYPE,V_KINDITEM,V_ZIP_NUM,V_ADDR,
												  '',V_TEL_NUM,'ZZ',null,null,V_CHRG_NAME,V_CHRG_EMAIL,as_user);
			END IF;
			-- �ŷ�ó��Ī�� ���Ѵ�.
			IsCustName := PKG_MAKE_SLIP.Get_Cust_Name(InCustSeq);

			CASE  V_ACC_TAG 
				WHEN '1' THEN                        -- ���
         		C_ACNT_CODE := '450010100';
				WHEN '2' THEN                        -- ����
					C_ACNT_CODE := '450020100';
				WHEN '3' THEN                        -- ���
					C_ACNT_CODE := '450030100';
				WHEN '4' THEN                        -- ����
					C_ACNT_CODE := '450040100';
				WHEN '5' THEN                        -- ����
					C_ACNT_CODE := '450050100';
				WHEN '6' THEN                        -- ����
					C_ACNT_CODE := '450060100';
				ELSE                                 -- ��Ÿ
					C_ACNT_CODE := '450900100';
			END CASE;

     		C_CR_CODE   := '210030100';
-- ���ֺ�ó��
--			IF V_COMM_TAG = 'Y' OR V_VATCODE = '3' THEN
			IF V_VATCODE = '3' THEN
				-- ��ǥ������ ���Ѵ�.
				InMakeSlipLine := InMakeSlipLine + 1;
	
				-- �� Body�� ���Ѵ�(����).
				IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_ACNT_CODE,IsClassCode,Null);

				IF V_VATCODE = '3' THEN
					C_VAT_CODE := '111221300';
				ELSE
					C_VAT_CODE := '111220300';
				END IF;
				C_AMT := V_TM_PRGS + V_TM_PRGS_NOTAX;

				-- Body�� ������ �־��ش�.
				IF V_VATCODE = '3' THEN
					IrBody.DB_AMT            := C_AMT + V_TM_VAT;        -- �����ݾ�
				ELSE
					IrBody.DB_AMT            := C_AMT;        -- �����ݾ�
				END IF;
				IrBody.TAX_COMP_CODE     := C_COMP_CODE;  -- ����������ڵ�
				IrBody.COMP_CODE         := C_COMP_CODE;  -- �ͼӻ�����ڵ�
				IrBody.DEPT_CODE         := as_dept_code; -- �ͼӺμ�
				IrBody.VAT_DT            := V_PAY_DT;     -- ��������
				IrBody.SUPAMT            := 0;            -- ���ް�(�ΰ��� ���ο����� �Է�)
				IrBody.VATAMT            := 0;            -- �ΰ���(�ΰ��� ���ο����� �Է�)
				IrBody.CUST_SEQ          := InCustSeq;    -- �ŷ�ó����
				IrBody.CUST_NAME         := IsCustName;   -- �ŷ�ó��Ī
				IrBody.SUMMARY1          := V_CONT;       -- ����
				IrBody.PAY_CON_CASH      := V_CASH;       -- ����
				IrBody.PAY_CON_BILL      := V_BILL;       -- ����
				IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;   -- ���������ϼ�
				IrBody.ANTICIPATION_DT   := V_CHECK_DT; -- ���������
		
				-- Body�� �����Ѵ�.
				PKG_MAKE_SLIP.Insert_Body(IrBody);
		
				InMakeSlipLine := InMakeSlipLine + 1;
	
				-- �� Body�� ���Ѵ�(����:�ΰ�������)
				IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_VAT_CODE,IsClassCode,Null);
				
				-- Body�� ������ �־��ش�.
				IF V_VATCODE = '3' THEN
					IrBody.DB_AMT            := 0;        -- �����ݾ�
				ELSE
					IrBody.DB_AMT            := V_TM_VAT;        -- �����ݾ�
				END IF;
				IrBody.TAX_COMP_CODE     := C_COMP_CODE;  -- ����������ڵ�
				IrBody.COMP_CODE         := C_COMP_CODE;  -- �ͼӻ�����ڵ�
				IrBody.DEPT_CODE         := as_dept_code; -- �ͼӺμ�
				IrBody.VAT_DT            := V_PAY_DT;     -- ��������
				IrBody.SUPAMT            := C_AMT;        -- ���ް�(�ΰ��� ���ο����� �Է�)
				IrBody.VATAMT            := V_TM_VAT;        -- �ΰ���(�ΰ��� ���ο����� �Է�)
				IrBody.CUST_SEQ          := InCustSeq;    -- �ŷ�ó����
				IrBody.CUST_NAME         := IsCustName;   -- �ŷ�ó��Ī
				IrBody.SUMMARY1          := V_CONT;       -- ����
				IrBody.PAY_CON_CASH      := V_CASH;       -- ����
				IrBody.PAY_CON_BILL      := V_BILL;       -- ����
				IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;   -- ���������ϼ�
				IrBody.ANTICIPATION_DT   := V_CHECK_DT; -- ���������
	
				-- Body�� �����Ѵ�.
				PKG_MAKE_SLIP.Insert_Body(IrBody);
	
	
				InMakeSlipLine := InMakeSlipLine + 1;
	
				-- �� Body�� ���Ѵ�(�뺯)
				IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CR_CODE,IsClassCode,Null);
				
				-- Body�� ������ �־��ش�.
				IrBody.CR_AMT            := C_AMT + V_TM_VAT; -- �뺯�ݾ�
				IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- ����������ڵ�
				IrBody.COMP_CODE         := C_COMP_CODE;   -- �ͼӻ�����ڵ�
				IrBody.DEPT_CODE         := as_dept_code;  -- �ͼӺμ�
				IrBody.VAT_DT            := V_PAY_DT;      -- ��������
				IrBody.SUPAMT            := 0;         -- ���ް�(�ΰ��� ���ο����� �Է�)
				IrBody.VATAMT            := 0;         -- �ΰ���(�ΰ��� ���ο����� �Է�)
				IrBody.CUST_SEQ          := InCustSeq;     -- �ŷ�ó����
				IrBody.CUST_NAME         := IsCustName;    -- �ŷ�ó��Ī
				IrBody.SUMMARY1          := V_CONT;        -- ����
				IrBody.PAY_CON_CASH      := V_CASH;        -- ����
				IrBody.PAY_CON_BILL      := V_BILL;        -- ����
				IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;    -- ���������ϼ�
				IrBody.ANTICIPATION_DT   := V_CHECK_DT; -- ���������
				IrBody.MNG_ITEM_DT1      := V_PAY_DT; -- ��꼭����
	
				-- Body�� �����Ѵ�.
				PKG_MAKE_SLIP.Insert_Body(IrBody);
			ELSE
				IF V_TM_PRGS <> 0 THEN
					-- ��ǥ������ ���Ѵ�.
					InMakeSlipLine := InMakeSlipLine + 1;
		
					-- �� Body�� ���Ѵ�(����).
					IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_ACNT_CODE,IsClassCode,Null);
	
					C_VAT_CODE := '111220100';
	
					-- Body�� ������ �־��ش�.
					IrBody.DB_AMT            := V_TM_PRGS;        -- �����ݾ�
					IrBody.TAX_COMP_CODE     := C_COMP_CODE;  -- ����������ڵ�
					IrBody.COMP_CODE         := C_COMP_CODE;  -- �ͼӻ�����ڵ�
					IrBody.DEPT_CODE         := as_dept_code; -- �ͼӺμ�
					IrBody.VAT_DT            := V_PAY_DT;     -- ��������
					IrBody.SUPAMT            := 0;            -- ���ް�(�ΰ��� ���ο����� �Է�)
					IrBody.VATAMT            := 0;            -- �ΰ���(�ΰ��� ���ο����� �Է�)
					IrBody.CUST_SEQ          := InCustSeq;    -- �ŷ�ó����
					IrBody.CUST_NAME         := IsCustName;   -- �ŷ�ó��Ī
					IrBody.SUMMARY1          := V_CONT;       -- ����
					IrBody.PAY_CON_CASH      := V_CASH;       -- ����
					IrBody.PAY_CON_BILL      := V_BILL;       -- ����
					IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;   -- ���������ϼ�
					IrBody.ANTICIPATION_DT   := V_CHECK_DT; -- ���������
			
					-- Body�� �����Ѵ�.
					PKG_MAKE_SLIP.Insert_Body(IrBody);
			
					InMakeSlipLine := InMakeSlipLine + 1;
		
					-- �� Body�� ���Ѵ�(����:�ΰ�������)
					IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_VAT_CODE,IsClassCode,Null);
					
					-- Body�� ������ �־��ش�.
					IrBody.DB_AMT            := V_TM_VAT;        -- �����ݾ�
					IrBody.TAX_COMP_CODE     := C_COMP_CODE;  -- ����������ڵ�
					IrBody.COMP_CODE         := C_COMP_CODE;  -- �ͼӻ�����ڵ�
					IrBody.DEPT_CODE         := as_dept_code; -- �ͼӺμ�
					IrBody.VAT_DT            := V_PAY_DT;     -- ��������
					IrBody.SUPAMT            := V_TM_PRGS;        -- ���ް�(�ΰ��� ���ο����� �Է�)
					IrBody.VATAMT            := V_TM_VAT;        -- �ΰ���(�ΰ��� ���ο����� �Է�)
					IrBody.CUST_SEQ          := InCustSeq;    -- �ŷ�ó����
					IrBody.CUST_NAME         := IsCustName;   -- �ŷ�ó��Ī
					IrBody.SUMMARY1          := V_CONT;       -- ����
					IrBody.PAY_CON_CASH      := V_CASH;       -- ����
					IrBody.PAY_CON_BILL      := V_BILL;       -- ����
					IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;   -- ���������ϼ�
					IrBody.ANTICIPATION_DT   := V_CHECK_DT; -- ���������
		
					-- Body�� �����Ѵ�.
					PKG_MAKE_SLIP.Insert_Body(IrBody);
		
					InMakeSlipLine := InMakeSlipLine + 1;
		
					-- �� Body�� ���Ѵ�(�뺯)
					IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CR_CODE,IsClassCode,Null);
					
					-- Body�� ������ �־��ش�.
					IrBody.CR_AMT            := V_TM_PRGS + V_TM_VAT; -- �뺯�ݾ�
					IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- ����������ڵ�
					IrBody.COMP_CODE         := C_COMP_CODE;   -- �ͼӻ�����ڵ�
					IrBody.DEPT_CODE         := as_dept_code;  -- �ͼӺμ�
					IrBody.VAT_DT            := V_PAY_DT;      -- ��������
					IrBody.SUPAMT            := 0;         -- ���ް�(�ΰ��� ���ο����� �Է�)
					IrBody.VATAMT            := 0;         -- �ΰ���(�ΰ��� ���ο����� �Է�)
					IrBody.CUST_SEQ          := InCustSeq;     -- �ŷ�ó����
					IrBody.CUST_NAME         := IsCustName;    -- �ŷ�ó��Ī
					IrBody.SUMMARY1          := V_CONT;        -- ����
					IrBody.PAY_CON_CASH      := V_CASH;        -- ����
					IrBody.PAY_CON_BILL      := V_BILL;        -- ����
					IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;    -- ���������ϼ�
					IrBody.ANTICIPATION_DT   := V_CHECK_DT; -- ���������
					IrBody.MNG_ITEM_DT1      := V_PAY_DT; -- ��꼭����
		
					-- Body�� �����Ѵ�.
					PKG_MAKE_SLIP.Insert_Body(IrBody);
				END IF;
				IF V_TM_PRGS_NOTAX <> 0 THEN
					-- ��ǥ������ ���Ѵ�.
					InMakeSlipLine := InMakeSlipLine + 1;
		
					-- �� Body�� ���Ѵ�(����).
					IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_ACNT_CODE,IsClassCode,Null);
	
					C_VAT_CODE := '111220200';
	
					-- Body�� ������ �־��ش�.
					IrBody.DB_AMT            := V_TM_PRGS_NOTAX;        -- �����ݾ�
					IrBody.TAX_COMP_CODE     := C_COMP_CODE;  -- ����������ڵ�
					IrBody.COMP_CODE         := C_COMP_CODE;  -- �ͼӻ�����ڵ�
					IrBody.DEPT_CODE         := as_dept_code; -- �ͼӺμ�
					IrBody.VAT_DT            := V_PAY_DT;     -- ��������
					IrBody.SUPAMT            := 0;            -- ���ް�(�ΰ��� ���ο����� �Է�)
					IrBody.VATAMT            := 0;            -- �ΰ���(�ΰ��� ���ο����� �Է�)
					IrBody.CUST_SEQ          := InCustSeq;    -- �ŷ�ó����
					IrBody.CUST_NAME         := IsCustName;   -- �ŷ�ó��Ī
					IrBody.SUMMARY1          := V_CONT;       -- ����
					IrBody.PAY_CON_CASH      := V_CASH;       -- ����
					IrBody.PAY_CON_BILL      := V_BILL;       -- ����
					IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;   -- ���������ϼ�
					IrBody.ANTICIPATION_DT   := V_CHECK_DT; -- ���������
			
					-- Body�� �����Ѵ�.
					PKG_MAKE_SLIP.Insert_Body(IrBody);
			
					InMakeSlipLine := InMakeSlipLine + 1;
		
					-- �� Body�� ���Ѵ�(����:�ΰ�������)
					IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_VAT_CODE,IsClassCode,Null);
					
					-- Body�� ������ �־��ش�.
					IrBody.DB_AMT            := 0;        -- �����ݾ�
					IrBody.TAX_COMP_CODE     := C_COMP_CODE;  -- ����������ڵ�
					IrBody.COMP_CODE         := C_COMP_CODE;  -- �ͼӻ�����ڵ�
					IrBody.DEPT_CODE         := as_dept_code; -- �ͼӺμ�
					IrBody.VAT_DT            := V_PAY_DT;     -- ��������
					IrBody.SUPAMT            := V_TM_PRGS_NOTAX;        -- ���ް�(�ΰ��� ���ο����� �Է�)
					IrBody.VATAMT            := 0;        -- �ΰ���(�ΰ��� ���ο����� �Է�)
					IrBody.CUST_SEQ          := InCustSeq;    -- �ŷ�ó����
					IrBody.CUST_NAME         := IsCustName;   -- �ŷ�ó��Ī
					IrBody.SUMMARY1          := V_CONT;       -- ����
					IrBody.PAY_CON_CASH      := V_CASH;       -- ����
					IrBody.PAY_CON_BILL      := V_BILL;       -- ����
					IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;   -- ���������ϼ�
					IrBody.ANTICIPATION_DT   := V_CHECK_DT; -- ���������
		
					-- Body�� �����Ѵ�.
					PKG_MAKE_SLIP.Insert_Body(IrBody);
		
		
					InMakeSlipLine := InMakeSlipLine + 1;
		
					-- �� Body�� ���Ѵ�(�뺯)
					IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CR_CODE,IsClassCode,Null);
					
					-- Body�� ������ �־��ش�.
					IrBody.CR_AMT            := V_TM_PRGS_NOTAX; -- �뺯�ݾ�
					IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- ����������ڵ�
					IrBody.COMP_CODE         := C_COMP_CODE;   -- �ͼӻ�����ڵ�
					IrBody.DEPT_CODE         := as_dept_code;  -- �ͼӺμ�
					IrBody.VAT_DT            := V_PAY_DT;      -- ��������
					IrBody.SUPAMT            := 0;         -- ���ް�(�ΰ��� ���ο����� �Է�)
					IrBody.VATAMT            := 0;         -- �ΰ���(�ΰ��� ���ο����� �Է�)
					IrBody.CUST_SEQ          := InCustSeq;     -- �ŷ�ó����
					IrBody.CUST_NAME         := IsCustName;    -- �ŷ�ó��Ī
					IrBody.SUMMARY1          := V_CONT;        -- ����
					IrBody.PAY_CON_CASH      := V_CASH;        -- ����
					IrBody.PAY_CON_BILL      := V_BILL;        -- ����
					IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;    -- ���������ϼ�
					IrBody.ANTICIPATION_DT   := V_CHECK_DT; -- ���������
					IrBody.MNG_ITEM_DT1      := V_PAY_DT; -- ��꼭����
		
					-- Body�� �����Ѵ�.
					PKG_MAKE_SLIP.Insert_Body(IrBody);
				END IF;
			END IF;
-- ���ޱݰ���ó��
     		C_CR_CODE   := '111250100';
			IF V_TM_PRE_TAX <> 0 THEN -- ����ó��
				IF V_VATCODE = '3' THEN
					C_VAT_CODE := '111221300';
				ELSE
					C_VAT_CODE := '111220100';
				END IF;

				-- ��ǥ������ ���Ѵ�.
				InMakeSlipLine := InMakeSlipLine + 1;
	
				-- �� Body�� ���Ѵ�(����).
				IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_ACNT_CODE,IsClassCode,Null);

				-- Body�� ������ �־��ش�.
				IF V_VATCODE = '3' THEN
					C_AMT            := V_TM_PRE_TAX + V_TM_PRE_VAT;        -- �����ݾ�
				ELSE
					C_AMT            := V_TM_PRE_TAX;        -- �����ݾ�
				END IF;
				IrBody.DB_AMT            := C_AMT;        -- �����ݾ�
				IrBody.TAX_COMP_CODE     := C_COMP_CODE;  -- ����������ڵ�
				IrBody.COMP_CODE         := C_COMP_CODE;  -- �ͼӻ�����ڵ�
				IrBody.DEPT_CODE         := as_dept_code; -- �ͼӺμ�
				IrBody.VAT_DT            := V_PAY_DT;     -- ��������
				IrBody.SUPAMT            := 0;            -- ���ް�(�ΰ��� ���ο����� �Է�)
				IrBody.VATAMT            := 0;            -- �ΰ���(�ΰ��� ���ο����� �Է�)
				IrBody.CUST_SEQ          := InCustSeq;    -- �ŷ�ó����
				IrBody.CUST_NAME         := IsCustName;   -- �ŷ�ó��Ī
				IrBody.SUMMARY1          := V_CONT1;       -- ����
		
				-- Body�� �����Ѵ�.
				PKG_MAKE_SLIP.Insert_Body(IrBody);
		
				InMakeSlipLine := InMakeSlipLine + 1;
				-- �� Body�� ���Ѵ�(�뺯)
				IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CR_CODE,IsClassCode,Null);

				LOOP 
					select a.invoice_num,a.invoice_num1,a.rem_amt
					  into C_SLIP_ID,C_SLIP_IDSEQ,C_SET_AMT
					  from ( select a.invoice_num,a.invoice_num1,a.rem_amt,rownum ll_seq
								  from ( select max(a.invoice_num) invoice_num,max(a.invoice_num1) invoice_num1,nvl(sum(db_amt),0) - nvl(sum(cr_amt),0) rem_amt
											  from s_guarantee_accept a,
													 t_acc_slip_body1 b
											 where a.invoice_num = b.reset_slip_id (+)
												and a.invoice_num1 = b.reset_slip_idseq (+)
												and a.dept_code = as_dept_code
												and a.order_number = V_ORDER_NUMBER
												and a.guarantee_class = '2'
												and a.invoice_num is not null
										group by a.invoice_num,a.invoice_num1 ) a
								 where a.rem_amt <> 0
								 order by a.invoice_num,a.invoice_num1 ) a
					 where a.ll_seq = 1;
					IF C_AMT <= C_SET_AMT THEN
						EXIT;
					END IF;
					C_TEMP_AMT := C_AMT - C_SET_AMT;

					IrBody.CR_AMT            := C_SET_AMT;     -- �뺯�ݾ�
					IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- ����������ڵ�
					IrBody.COMP_CODE         := C_COMP_CODE;   -- �ͼӻ�����ڵ�
					IrBody.DEPT_CODE         := as_dept_code;  -- �ͼӺμ�
					IrBody.VAT_DT            := V_PAY_DT;      -- ��������
					IrBody.SUPAMT            := 0;             -- ���ް�(�ΰ��� ���ο����� �Է�)
					IrBody.VATAMT            := 0;             -- �ΰ���(�ΰ��� ���ο����� �Է�)
					IrBody.CUST_SEQ          := InCustSeq;     -- �ŷ�ó����
					IrBody.CUST_NAME         := IsCustName;    -- �ŷ�ó��Ī
					IrBody.SUMMARY1          := V_CONT1;       -- ����
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

				-- Body�� ������ �־��ش�.
				IrBody.CR_AMT            := C_AMT; -- �뺯�ݾ�
				IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- ����������ڵ�
				IrBody.COMP_CODE         := C_COMP_CODE;   -- �ͼӻ�����ڵ�
				IrBody.DEPT_CODE         := as_dept_code;  -- �ͼӺμ�
				IrBody.VAT_DT            := V_PAY_DT;      -- ��������
				IrBody.SUPAMT            := 0;         -- ���ް�(�ΰ��� ���ο����� �Է�)
				IrBody.VATAMT            := 0;         -- �ΰ���(�ΰ��� ���ο����� �Է�)
				IrBody.CUST_SEQ          := InCustSeq;     -- �ŷ�ó����
				IrBody.CUST_NAME         := IsCustName;    -- �ŷ�ó��Ī
				IrBody.SUMMARY1          := V_CONT1;        -- ����
				IrBody.RESET_SLIP_ID     := C_SLIP_ID;
				IrBody.RESET_SLIP_IDSEQ  := C_SLIP_IDSEQ;
	
				-- Body�� �����Ѵ�.
				PKG_MAKE_SLIP.Insert_Body(IrBody);
					
			END IF;

			IF V_TM_PRE_NOTAX <> 0 THEN -- �鼼ó��
				C_VAT_CODE := '111220200';

				C_AMT := V_TM_PRE_NOTAX;

					-- ��ǥ������ ���Ѵ�.
				InMakeSlipLine := InMakeSlipLine + 1;
	
				-- �� Body�� ���Ѵ�(����).
				IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_ACNT_CODE,IsClassCode,Null);

				IrBody.DB_AMT            := C_AMT;        -- �����ݾ�
				IrBody.TAX_COMP_CODE     := C_COMP_CODE;  -- ����������ڵ�
				IrBody.COMP_CODE         := C_COMP_CODE;  -- �ͼӻ�����ڵ�
				IrBody.DEPT_CODE         := as_dept_code; -- �ͼӺμ�
				IrBody.VAT_DT            := V_PAY_DT;     -- ��������
				IrBody.SUPAMT            := 0;            -- ���ް�(�ΰ��� ���ο����� �Է�)
				IrBody.VATAMT            := 0;            -- �ΰ���(�ΰ��� ���ο����� �Է�)
				IrBody.CUST_SEQ          := InCustSeq;    -- �ŷ�ó����
				IrBody.CUST_NAME         := IsCustName;   -- �ŷ�ó��Ī
				IrBody.SUMMARY1          := V_CONT1;       -- ����
		
				-- Body�� �����Ѵ�.
				PKG_MAKE_SLIP.Insert_Body(IrBody);
		
				InMakeSlipLine := InMakeSlipLine + 1;
	
				-- �� Body�� ���Ѵ�(�뺯)
				IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CR_CODE,IsClassCode,Null);
				LOOP 
					select a.invoice_num,a.invoice_num1,a.rem_amt
					  into C_SLIP_ID,C_SLIP_IDSEQ,C_SET_AMT
					  from ( select a.invoice_num,a.invoice_num1,a.rem_amt,rownum ll_seq
								  from ( select max(a.invoice_num) invoice_num,max(a.invoice_num1) invoice_num1,nvl(sum(db_amt),0) - nvl(sum(cr_amt),0) rem_amt
											  from s_guarantee_accept a,
													 t_acc_slip_body1 b
											 where a.invoice_num = b.reset_slip_id (+)
												and a.invoice_num1 = b.reset_slip_idseq (+)
												and a.dept_code = as_dept_code
												and a.order_number = V_ORDER_NUMBER
												and a.guarantee_class = '2'
												and a.invoice_num is not null
										group by a.invoice_num,a.invoice_num1 ) a
								 where a.rem_amt <> 0
								 order by a.invoice_num,a.invoice_num1 ) a
					 where a.ll_seq = 1;
					IF C_AMT <= C_SET_AMT THEN
						EXIT;
					END IF;
					C_TEMP_AMT := C_AMT - C_SET_AMT;

					IrBody.CR_AMT            := C_SET_AMT;     -- �뺯�ݾ�
					IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- ����������ڵ�
					IrBody.COMP_CODE         := C_COMP_CODE;   -- �ͼӻ�����ڵ�
					IrBody.DEPT_CODE         := as_dept_code;  -- �ͼӺμ�
					IrBody.VAT_DT            := V_PAY_DT;      -- ��������
					IrBody.SUPAMT            := 0;             -- ���ް�(�ΰ��� ���ο����� �Է�)
					IrBody.VATAMT            := 0;             -- �ΰ���(�ΰ��� ���ο����� �Է�)
					IrBody.CUST_SEQ          := InCustSeq;     -- �ŷ�ó����
					IrBody.CUST_NAME         := IsCustName;    -- �ŷ�ó��Ī
					IrBody.SUMMARY1          := V_CONT1;       -- ����
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
				
				-- Body�� ������ �־��ش�.
				IrBody.CR_AMT            := C_AMT ; -- �뺯�ݾ�
				IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- ����������ڵ�
				IrBody.COMP_CODE         := C_COMP_CODE;   -- �ͼӻ�����ڵ�
				IrBody.DEPT_CODE         := as_dept_code;  -- �ͼӺμ�
				IrBody.VAT_DT            := V_PAY_DT;      -- ��������
				IrBody.SUPAMT            := 0;         -- ���ް�(�ΰ��� ���ο����� �Է�)
				IrBody.VATAMT            := 0;         -- �ΰ���(�ΰ��� ���ο����� �Է�)
				IrBody.CUST_SEQ          := InCustSeq;     -- �ŷ�ó����
				IrBody.CUST_NAME         := IsCustName;    -- �ŷ�ó��Ī
				IrBody.SUMMARY1          := V_CONT1;        -- ����
				IrBody.RESET_SLIP_ID     := C_SLIP_ID;
				IrBody.RESET_SLIP_IDSEQ  := C_SLIP_IDSEQ;
	
				-- Body�� �����Ѵ�.
				PKG_MAKE_SLIP.Insert_Body(IrBody);
					
			END IF;
		END LOOP;
		CLOSE DETAIL_CUR;

-- ��ǥ�� �����Ѵ�.
		PKG_MAKE_SLIP.Check_Slip(IrHead.Slip_ID);

--    EXCEPTION
--      WHEN others THEN 
--           IF SQL%NOTFOUND THEN
--              e_msg      := '���ֱ⼺��ǥ���� ����! [Line No: 2]' || C_TEMP_AMT || '-' || C_SET_AMT || '-'  ;
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
END y_sp_s_slip_prgs;
