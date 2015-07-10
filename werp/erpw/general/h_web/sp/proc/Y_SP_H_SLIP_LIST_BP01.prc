CREATE OR REPLACE PROCEDURE Y_Sp_H_Slip_List_Bp01(as_dept_code    IN   VARCHAR2,
                                        		as_sell_code    IN   VARCHAR2,
                                        		adt_from_date   IN   DATE,
															adt_to_date     IN   DATE,
															as_dept         IN   VARCHAR2,
															as_slip_name    IN   VARCHAR2 ) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
-- �ߵ���/�ܱ� ���� ����
CURSOR DETAIL_CUR IS
		SELECT a.sell_code,
		       a.dongho,
		       a.contract_code,
		       b.agree_date,
		       a.cust_code,
		       c.cust_name,
		       SUM(b.agree_amt)  sell_amt
		  FROM H_SALE_MASTER a,
		       H_SALE_ONTIME_AGREE  b,
		       H_CODE_CUST   c,
             H_CODE_COMMON d
		 WHERE a.dept_code = b.dept_code
		   AND a.sell_code = b.sell_code
		   AND a.dongho    = b.dongho
		   AND a.seq       = b.seq
		   AND a.cust_code = c.cust_code (+)
         AND b.degree_code = d.code (+)
         AND d.code_div    = '02'
		   AND a.dept_code = as_dept_code
		   AND a.sell_code = as_sell_code
		   AND b.agree_date  BETWEEN adt_from_date AND adt_to_date
		   AND a.last_contract_date <= adt_to_date
		   AND a.chg_date    > adt_to_date
		   AND a.chg_div     <> '00'
		 GROUP BY a.sell_code,
		       a.dongho,
		       a.contract_code,
		       b.agree_date,
		       a.cust_code,
		       c.cust_name,
		       d.code_name
   ORDER BY  dongho ;
-- ���� ����
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   v_dept_name        Z_CODE_DEPT.long_name%TYPE;
   v_desc             VARCHAR2(100);
   v_sell_code        VARCHAR2(2);
   v_dongho           VARCHAR2(10);
   v_dongho_tmp       VARCHAR2(10);
   v_contract_code    VARCHAR2(2);
   v_cust_code        VARCHAR2(15);
   v_cust_name        VARCHAR2(90);
   v_code_name        VARCHAR2(20);
   v_vatcode          VARCHAR2(2);
   v_occ_date         DATE;
   v_deptdetail_code  VARCHAR2(3);
   v_acnt_tmp1        VARCHAR2(10);
   v_acnt_tmp2        VARCHAR2(10);
   v_acntcode_01_1    VARCHAR2(10);
   v_acntcode_01_2    VARCHAR2(10);
   v_acntcode_01_3    VARCHAR2(10);
   v_acntcode_02_1    VARCHAR2(10);
   v_acntcode_02_2    VARCHAR2(10);
   v_acntcode_02_3    VARCHAR2(10);
   v_seq              NUMBER(10,0);
   v_sell_amt         NUMBER(15,0);
   v_amt              NUMBER(15,0);
   v_vat              NUMBER(15,0);
   v_tot              NUMBER(15,0);
   UserErr         EXCEPTION;                  -- Select Data Not Found
	V_DATE			 DATE;
   C_CHK           VARCHAR2(1);
   C_CNT           NUMBER(10,3);
   C_WORK_NO       NUMBER(6,0);
	C_KIND_CODE     VARCHAR2(3);
	C_EVIDENCE_KIND VARCHAR2(3);
   C_SEQ           INTEGER        DEFAULT 0;
   C_START_SEQ     INTEGER        DEFAULT 0;
   C_DT_SEQ        INTEGER        DEFAULT 0;
   C_LAB_CNT       INTEGER        DEFAULT 0;
BEGIN
   BEGIN
		SELECT SUBSTR(code_name, 1, 8)
		  INTO v_acntcode_01_1
		  FROM H_CODE_COMMON
		 WHERE code_div = '25'
		  AND  CODE     = '05' ;       --   �о�̼���(����Ʈ)
		IF v_acntcode_01_1 IS NULL THEN
			e_msg := '�о�̼���(����Ʈ) ���� ���� ct01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      END IF;
		SELECT SUBSTR(code_name, 1, 8)
		  INTO v_acntcode_01_2
		  FROM H_CODE_COMMON
		 WHERE code_div = '25'
		  AND  CODE     = '06' ;       --   �о�̼���(��)
		IF v_acntcode_01_2 IS NULL THEN
			e_msg := '�о�̼���(��) ���� ���� ct01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      END IF;
		SELECT SUBSTR(code_name, 1, 8)
		  INTO v_acntcode_01_3
		  FROM H_CODE_COMMON
		 WHERE code_div = '25'
		  AND  CODE     = '03' ;       --   �Ӵ�̼���
		IF v_acntcode_01_3 IS NULL THEN
			e_msg := '�Ӵ�̼��� ���� ���� ct01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      END IF;
		SELECT SUBSTR(code_name, 1, 8)
		  INTO v_acntcode_02_1
		  FROM H_CODE_COMMON
		 WHERE code_div = '25'
		  AND  CODE     = '11' ;        -- �о缱����(����Ʈ)
		IF v_acntcode_02_1 IS NULL THEN
			e_msg := '�о缱����(����Ʈ) ���� ���� ct01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      END IF;
		SELECT SUBSTR(code_name, 1, 8)
		  INTO v_acntcode_02_2
		  FROM H_CODE_COMMON
		 WHERE code_div = '25'
		  AND  CODE     = '12' ;        -- �о缱����(��)
		IF v_acntcode_02_2 IS NULL THEN
			e_msg := '�о缱����(��) ���� ���� ct01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      END IF;
		SELECT SUBSTR(code_name, 1, 8)
		  INTO v_acntcode_02_3
		  FROM H_CODE_COMMON
		 WHERE code_div = '25'
		  AND  CODE     = '15' ;        -- �Ӵ뺸���� ����
		IF v_acntcode_02_3 IS NULL THEN
			e_msg := '�Ӵ뺸���� ���� ���� ct01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      END IF;
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO v_sell_code, v_dongho, v_contract_code, v_occ_date, v_cust_code,
			                      v_cust_name, v_sell_amt;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
			SELECT COUNT(*)
			  INTO C_CNT
			  FROM am_work_workno
 		    WHERE work_date = v_occ_date;
			IF C_CNT < 1 THEN
			   e_msg      := '��ǥ��ȣ ���� ����! ct01 [Line No: -1]';
				INSERT INTO ERPC.AM_WORK_WORKNO
				VALUES ( v_occ_date,1 )  ;
				C_SEQ := 1;
			ELSE
				SELECT work_no_last
				  INTO C_SEQ
				  FROM am_work_workno
		   	 WHERE work_date = v_occ_date;
				C_SEQ := C_SEQ + 1;
			   e_msg      := '��ǥ��ȣ ���� ����! ct01 [Line No: -2]';
				UPDATE ERPC.AM_WORK_WORKNO
				  SET WORK_NO_LAST = C_SEQ
				WHERE WORK_DATE = v_occ_date;
			END IF;
			IF v_cust_code IS NOT NULL THEN
				SELECT COUNT(*)
				  INTO C_CNT
				  FROM sm_code_cust
				 WHERE cust_code = v_cust_code;
				IF C_CNT < 1 THEN
					e_msg      := '�ŷ�ó ���� ����! ct01 [Line No: -3]' || v_cust_code;
						INSERT INTO ERPC.SM_CODE_CUST
						  SELECT CUST_CODE,'Y','Y',DECODE(CUST_DIV, '01', '002', '02', '001', '099'),CUST_NAME,CUST_NAME,'','','',
									'','','',HOME_PHONE,'',CONTRACT_ZIP_CODE, CONTRACT_ADDR1,
									'','','',SYSDATE,'',NULL
							 FROM H_CODE_CUST
							WHERE CUST_CODE = v_cust_code ;
				END IF;
			END IF;
			C_KIND_CODE := 'AM1';
			v_vatcode := NULL;
			IF SUBSTRB(v_vatcode,1,1) = '2' THEN
				C_EVIDENCE_KIND := '011';
			ELSE IF SUBSTRB(v_vatcode,1,1) = 'B' THEN
					C_EVIDENCE_KIND := '021';
				ELSE
					C_EVIDENCE_KIND := '999';
				END IF;
			END IF;
			IF C_START_SEQ = 0 THEN
				C_START_SEQ := C_SEQ;
			END IF;
		   e_msg      := '����ǥ ����Ÿ ���� ����! ct01 [Line No: 4]';
			INSERT INTO ERPC.AM_WORK_MASTER
			VALUES ( v_occ_date,C_SEQ,C_START_SEQ,'01',as_dept,C_KIND_CODE,'003',as_slip_name,SYSDATE,'01',NULL,
						NULL,NULL,NULL,'N',NULL,NULL,'N',NULL,NULL,'N',NULL,NULL,NULL,NULL,NULL,NULL,'N',NULL,NULL )  ;
-- ����ǥ_�������� �Է��Ѵ�
			SELECT MIN(DEPTDETAIL_CODE)
	        INTO v_deptdetail_code
	 		   FROM ERPC.AM_CODE_DEPT_RELA
	        WHERE dept_code = as_dept_code
	          AND DEPTDETAIL_CODE <> '530'
	        ;
			IF v_contract_code = '02' THEN
				v_acnt_tmp1 := v_acntcode_01_3;     -- �Ӵ�̼���
				v_acnt_tmp2 := v_acntcode_02_3;     -- �Ӵ뺸����
			ELSE
				IF v_sell_code = '03' THEN
					v_acnt_tmp1 := v_acntcode_01_2;  -- �о�̼���(��)
					v_acnt_tmp2 := v_acntcode_02_2;  -- �о缱����(��)
				ELSE
					v_acnt_tmp1 := v_acntcode_01_1;  -- �о�̼���(����Ʈ)
					v_acnt_tmp2 := v_acntcode_02_1;  -- �о缱����(����Ʈ)
				END IF;
			END IF;
			v_dongho_tmp := SUBSTR(v_dongho, 1, 4) || '-' || SUBSTR(v_dongho, 5, 4);
			v_desc := v_dongho_tmp || ' ����ǰ�� ' || v_cust_name || ' ' || v_code_name ;
			v_amt  := v_sell_amt;
			v_vat  := 0;
			v_tot := v_amt + v_vat;
		   e_msg      := '����ǥ ������ ���� ����! ct01 [Line No: 5]'|| C_SEQ || ' 1';
			C_DT_SEQ := 1;
			INSERT INTO erpc.AM_WORK_DETAIL
			VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
					 v_acnt_tmp1,v_acnt_tmp1,v_tot,v_vat,v_amt,0,0,0,v_desc,v_desc,
					 '01',v_cust_code,v_vatcode,v_occ_date,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
					 NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,v_dongho_tmp,NULL,NULL,NULL,NULL,
					 NULL,NULL,NULL,as_slip_name,SYSDATE,as_slip_name,SYSDATE,NULL) ;
		   e_msg      := '����ǥ ������ ���� ����! ct01 [Line No: 6]'|| C_SEQ || ' 2';
			C_DT_SEQ := C_DT_SEQ + 1;
			INSERT INTO erpc.AM_WORK_DETAIL
			VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
					 v_acnt_tmp2,v_acnt_tmp2,0,0,0,v_tot,0,v_tot,v_desc,v_desc,
					 '01',v_cust_code,NULL,v_occ_date,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
					 NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,v_dongho_tmp,NULL,NULL,NULL,NULL,
					 NULL,NULL,NULL,as_slip_name,SYSDATE,as_slip_name,SYSDATE,NULL) ;
		   e_msg      := '����ǥ ������ ���� ����! ct01 [Line No: 6]'|| C_SEQ || ' 2';
		END LOOP;
		CLOSE DETAIL_CUR;
      EXCEPTION
      WHEN OTHERS THEN
           IF SQL%NOTFOUND THEN
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
END Y_Sp_H_Slip_List_Bp01;
/

