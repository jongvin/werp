 /* ============================================================================ */
/* �Լ��� : y_sp_m_slip_tmat_rent(CJ����)                                        */
/* ��  �� : �������-�շ���ǥ ����                                               */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ��ǥ���               ==> as_date(DATE)        		               */
/*        : �ۼ��ڻ��             ==> as_date(string)        		               */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2006.04.12                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_m_slip_tmat_rent (as_dept_code    IN   VARCHAR2,
																	  as_date         IN   DATE,
                                                     as_user         IN   VARCHAR2) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT nvl(sum(a.amt),0),max(a.month),to_char(max(a.month),'YYYY.MM') || '�� �շ�'
  FROM m_tmat_proj_rent a
 WHERE a.dept_code = as_dept_code
	AND trunc(a.month,'MM')= as_date
group by a.dept_code,a.month;

-- ���� ����
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
   Wk_Chk              NUMBER(10,0) DEFAULT 0 ;
   WK_Chk_msg          VARCHAR2(100);

-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	V_AMT               NUMBER(20,5);
	V_YYMMDD            DATE;
	V_CONT              VARCHAR2(100);
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
		IsChargePers := PKG_MAKE_SLIP.Get_CHARGE_PERS('MATR000002',C_COMP_CODE);

-- �ι��� ���Ѵ�.
		IsClassCode := PKG_MAKE_SLIP.Get_Class_code(as_dept_code);

-- ��ǥ�����͸� �����Ѵ�(������ڵ�,�����ڵ�,��ǥ������,'1'��ü,'F'����,�ۼ��ڻ��,�ڵ���ǥ�ڵ�,ȸ��Ȯ�����,�Է��ڻ��)
		IrHead := PKG_MAKE_SLIP.New_Head(C_COMP_CODE,as_dept_code,as_date,'1','F',as_user,'MATR000002',IsChargePers,as_user);

		PKG_MAKE_SLIP.Insert_Head(IrHead);

-- ���̺� ��ǥ�����͹�ȣ�� Setting �Ѵ�.
		update m_tmat_proj_rent
			set invoice_num = IrHead.Slip_ID
		 where dept_code = as_dept_code
			AND trunc(month,'MM')= as_date;

		InMakeSlipLine := 0;

-- ��ǥ������ ����� ���� Ŀ��
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO V_AMT,V_YYMMDD,V_CONT;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
	
			C_ACNT_CODE := '420030100';
			C_CR_CODE   := '112090100';

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
	
			InMakeSlipLine := InMakeSlipLine + 1;


			-- �� Body�� ���Ѵ�(�뺯)
			IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CR_CODE,IsClassCode,Null);
			
			-- Body�� ������ �־��ش�.
			IrBody.CR_AMT            := V_AMT; -- �뺯�ݾ�
			IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- ����������ڵ�
			IrBody.COMP_CODE         := C_COMP_CODE;   -- �ͼӻ�����ڵ�
			IrBody.DEPT_CODE         := as_dept_code;  -- �ͼӺμ�
			IrBody.VAT_DT            := V_YYMMDD;      -- ��������
			IrBody.SUPAMT            := 0;         -- ���ް�(�ΰ��� ���ο����� �Է�)
			IrBody.VATAMT            := 0;         -- �ΰ���(�ΰ��� ���ο����� �Է�)
			IrBody.SUMMARY1          := V_CONT;        -- ����

			-- Body�� �����Ѵ�.
			PKG_MAKE_SLIP.Insert_Body(IrBody);

		END LOOP;
		CLOSE DETAIL_CUR;

-- ��ǥ�� �����Ѵ�.
		PKG_MAKE_SLIP.Check_Slip(IrHead.Slip_ID);

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '�շ���ǥ���� ����! [Line No: 2]';
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
END y_sp_m_slip_tmat_rent;
