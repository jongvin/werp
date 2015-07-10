CREATE OR REPLACE PROCEDURE y_sp_h_slip_list_ch02(as_dept_code    IN   VARCHAR2,
                                        		as_sell_code    IN   VARCHAR2,
                                        		adt_from_date   IN   DATE,
															adt_to_date     IN   DATE,
															as_dept         IN   VARCHAR2,
															as_slip_name    IN   VARCHAR2 ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
	SELECT a.sell_code,
	       a.contract_code,
	       a.dongho,
          b.receipt_date,
	       a.cust_code,
	       c.cust_name,
	       b.r_amt + b.delay_amt - b.discount_amt  amt
	 FROM h_sale_master a,
	      h_sale_income b,
	      h_code_cust   c
	WHERE a.dept_code = b.dept_code
     and a.sell_code = b.sell_code
     and a.dongho    = b.dongho
     and a.seq       = b.seq
     and a.cust_code = c.cust_code
     and a.dept_code = as_dept_code
     and a.sell_code = as_sell_code
     and a.last_contract_date <= adt_to_date
     and a.chg_date           >  adt_to_date
     and a.chg_div            <> '00'
     and b.receipt_code =  '22'
     and b.receipt_date  between adt_from_date  and  adt_to_date
	   ORDER BY b.receipt_date, a.dongho ;
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   v_dept_name        z_code_dept.long_name%TYPE;
   v_sell_code        VARCHAR2(2);
   v_contract_code    VARCHAR2(2);
   v_dongho           VARCHAR2(8);
   v_dongho_desc      VARCHAR2(9);
   v_desc             VARCHAR2(100);
   v_cust_code        VARCHAR2(15);
   v_cust_name        VARCHAR2(90);
   v_vatcode          VARCHAR2(2);
   v_occ_date         DATE;
   v_deptdetail_code  VARCHAR2(3);
   v_acntcode_01      VARCHAR2(10);
   v_acntcode_02_1    VARCHAR2(10);
   v_acntcode_02_2    VARCHAR2(10);
   v_acntcode_02_3    VARCHAR2(10);
   v_acntcode_tmp     VARCHAR2(10);
   v_seq              NUMBER(10,0);
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
		select substr(code_name, 1, 8)
		  into v_acntcode_01
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '33' ;       -- 예수금(청약)
		if v_acntcode_01 is null then
			e_msg := '예수금(청약) 계정 없음 ch02';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_02_1
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '05' ;        -- 분양미수금(아파트) 계정
		if v_acntcode_02_1 is null then
			e_msg := '분양미수금(아파트) 계정 없음 ch02';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_02_2
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '06' ;        -- 분양미수금(상가) 계정
		if v_acntcode_02_2 is null then
			e_msg := '분양미수금(상가) 계정 없음 ch02';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_02_3
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '31' ;        -- 임대선수금 계정
		if v_acntcode_02_3 is null then
			e_msg := '임대선수금 계정 없음 ch02';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO v_sell_code,v_contract_code,v_dongho, v_occ_date, v_cust_code, v_cust_name, v_amt;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
			select COUNT(*)
			  into C_CNT
			  from am_work_workno
 		    where work_date = v_occ_date;
			IF C_CNT < 1 THEN
			   e_msg      := '전표번호 생성 실패! ch02 [Line No: -1]';
				INSERT INTO ERPC.AM_WORK_WORKNO
				VALUES ( v_occ_date,1 )  ;
				C_SEQ := 1;
			ELSE
				select work_no_last
				  into C_SEQ
				  from am_work_workno
		   	 where work_date = v_occ_date;
				C_SEQ := C_SEQ + 1;
			   e_msg      := '전표번호 수정 실패! ch02 [Line No: -2]';
				UPDATE ERPC.AM_WORK_WORKNO
				  SET WORK_NO_LAST = C_SEQ
				WHERE WORK_DATE = v_occ_date;
			END IF;
			IF v_cust_code is not null THEN
				select COUNT(*)
				  into C_CNT
				  from sm_code_cust
				 where cust_code = v_cust_code;
				IF C_CNT < 1 THEN
					e_msg      := '거래처 생성 실패! ch02 [Line No: -3]' || v_cust_code;
						INSERT INTO ERPC.SM_CODE_CUST
						  SELECT CUST_CODE,'Y','Y',decode(CUST_DIV, '01', '002', '02', '001', '099'),CUST_NAME,CUST_NAME,'','','',
									'','','',HOME_PHONE,'',CONTRACT_ZIP_CODE, CONTRACT_ADDR1,
									'','','',sysdate,'',null
							 FROM H_CODE_CUST
							WHERE CUST_CODE = v_cust_code ;
				END IF;
			END IF;
			C_KIND_CODE := 'AM1';
			IF substrb(v_vatcode,1,1) = '2' THEN
				C_EVIDENCE_KIND := '011';
			ELSE IF substrb(v_vatcode,1,1) = 'B' THEN
					C_EVIDENCE_KIND := '021';
				ELSE
					C_EVIDENCE_KIND := '999';
				END IF;
			END IF;
			IF C_START_SEQ = 0 THEN
				C_START_SEQ := C_SEQ;
			END IF;
		   e_msg      := '가전표 마스타 생성 실패! ch02 [Line No: 4]';
			INSERT INTO ERPC.AM_WORK_MASTER
			VALUES ( v_occ_date,C_SEQ,C_START_SEQ,'01',as_dept,C_KIND_CODE,'003',as_slip_name,sysdate,'01',v_cust_code,
						v_occ_date,C_EVIDENCE_KIND,null,'N',null,null,'N',null,null,'N',null,null,null,null,null,null,'N',null,null )  ;
-- 가전표_디테일을 입력한다
			SELECT MIN(DEPTDETAIL_CODE)
	        INTO v_deptdetail_code
	 		   FROM ERPC.AM_CODE_DEPT_RELA
	        WHERE dept_code = as_dept_code
	          and DEPTDETAIL_CODE <> '530'
	        ;
			v_desc        := '동호지정 ' || substr(v_dongho, 1, 4) || '-' || substr(v_dongho, 5, 4) || ' ' || v_cust_name ;
			v_dongho_desc := substr(v_dongho, 1, 4) || '-' || substr(v_dongho, 5, 4);
		   e_msg      := '가전표 디테일 생성 실패! ch02 [Line No: 5]'|| C_SEQ || ' 1';
			C_DT_SEQ := 1;
			INSERT INTO erpc.AM_WORK_DETAIL
			VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
					 v_acntcode_01,v_acntcode_01,v_amt,0,v_amt,0,0,0,v_desc,v_desc,
					 '01',v_cust_code,v_vatcode,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
					 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,v_dongho_desc,null,null,null,null,
					 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ;
		   e_msg      := '가전표 디테일 생성 실패! ch02 [Line No: 6]'|| C_SEQ || ' 2';
			C_DT_SEQ := C_DT_SEQ + 1;
			if v_contract_code = '02' then
				v_acntcode_tmp := v_acntcode_02_3;
			else
				if v_sell_code = '05' then
					v_acntcode_tmp := v_acntcode_02_2;
            else
					v_acntcode_tmp := v_acntcode_02_1;
            end if;
			end if;
			INSERT INTO erpc.AM_WORK_DETAIL
			VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
					 v_acntcode_tmp,v_acntcode_tmp,0,0,0,v_amt,0,v_amt,v_desc,v_desc,
					 '01',v_cust_code,v_vatcode,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
					 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,v_dongho_desc,null,null,null,null,
					 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ;
		   e_msg      := '가전표 디테일 생성 실패! ch02 [Line No: 6]'|| C_SEQ || ' 2';
		END LOOP;
		CLOSE DETAIL_CUR;
      EXCEPTION
      WHEN others THEN
           IF SQL%NOTFOUND THEN
              Wk_errflag := -20020;
              GOTO EXIT_ROUTINE;
           END IF;
   END;
   -- *****************************************************************************
   -- PROCESS ENDDING ... !
   -- *****************************************************************************
   <<EXIT_ROUTINE>>
   -- ENDING...[0.1] CURSOR CLOSE 재 확인 처리 !
   IF Wk_errflag = 0 THEN
      Wk_errmsg  := '';                        -- 사용자 정의 Error Message
      Wk_errflag := 0;                         -- 사용자 정의 Error Code
   ELSE
      Wk_errmsg := RTRIM(e_msg) || '/>';
      RAISE UserErr;
   END IF;
EXCEPTION
  WHEN UserErr       THEN
       RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);
END y_sp_h_slip_list_ch02;
/

