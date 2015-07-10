CREATE OR REPLACE PROCEDURE y_sp_h_slip_list_ls02(as_dept_code    IN   VARCHAR2,
                                        		as_sell_code    IN   VARCHAR2,
                                        		adt_from_date   IN   DATE,
															adt_to_date     IN   DATE,
															as_dept         IN   VARCHAR2,
															as_slip_name    IN   VARCHAR2 ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   v_dept_name        z_code_dept.long_name%TYPE;
   v_desc             VARCHAR2(100);
   v_sell_code        VARCHAR2(2);
   v_dongho           VARCHAR2(10);
   v_degree_code      VARCHAR2(2);
   v_dongho_tmp       VARCHAR2(10);
   v_contract_code    VARCHAR2(2);
   v_cust_code        VARCHAR2(15);
   v_cust_name        VARCHAR2(90);
   v_process_code     VARCHAR2(90);
   v_vatcode          VARCHAR2(2);
   v_pay_yn           VARCHAR2(2);
   v_temp_d           VARCHAR2(20);
   v_agree_yymm       VARCHAR2(20);
   v_temp_date        DATE;
   v_occ_date         DATE;
   v_deptdetail_code  VARCHAR2(3);
   v_acnt_tmp1        VARCHAR2(10);
   v_acnt_tmp2        VARCHAR2(10);
   v_acntcode_01_1    VARCHAR2(10);
   v_acntcode_02_1    VARCHAR2(10);
   v_acntcode_02_2    VARCHAR2(10);
   v_seq              NUMBER(10,0);
   v_save_amt         NUMBER(15,0);
   v_amt              NUMBER(15,0);
   v_vat              NUMBER(15,0)   DEFAULT 0;
   v_tot              NUMBER(15,0);
   v_total_r_amt      NUMBER(15,0);
   v_lease_amt        NUMBER(15,0);
   v_r_amt            NUMBER(15,0);
   v_delay_amt        NUMBER(15,0);
  	v_w_cnt            NUMBER(15,0);
  	v_spec_unq_num     NUMBER(18,0);
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
CURSOR DETAIL_CUR IS
		SELECT a.dongho,
		       a.seq,
		       a.CUST_CODE,
				 e.CUST_NAME,
				 b.receipt_date,
		       sum(nvl(b.r_amt, 0))     r_amt,
		       sum(nvl(b.delay_amt, 0)) delay_amt
		  FROM H_SALE_MASTER a,
				 H_LEAS_LEASE_INCOME  b,
				 H_CODE_CUST   e
		 WHERE a.CUST_CODE   = e.CUST_CODE
			and a.DEPT_CODE   = b.DEPT_CODE
			and a.SELL_CODE   = b.SELL_CODE
			and a.DONGHO      = b.DONGHO
			and a.SEQ         = b.SEQ
			and a.DEPT_CODE   = as_dept_code
			and a.SELL_CODE   = as_sell_code
			and a.LAST_CONTRACT_DATE  <= adt_to_date
			and a.CHG_DATE   > adt_to_date
			and a.CHG_DIV   <> '00'
			and b.RECEIPT_DATE  between adt_from_date  and  adt_to_date
      group by a.dongho,
		       a.seq,
		       a.CUST_CODE,
				 e.CUST_NAME,
				 b.receipt_date
		ORDER BY b.receipt_date, a.dongho ;
BEGIN
   BEGIN
		SELECT MIN(DEPTDETAIL_CODE)
        INTO v_deptdetail_code
 		   FROM ERPC.AM_CODE_DEPT_RELA
        WHERE dept_code = as_dept_code
          and DEPTDETAIL_CODE <> '530'
        ;
		select substr(code_name, 1, 8)
		  into v_acntcode_01_1
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '53' ;        -- 보통예금  계정
		if v_acntcode_01_1 is null then
			e_msg := '보통예금 계정 없음 ot01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_02_1
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '03' ;        -- 임대미수금 계정
		if v_acntcode_02_1 is null then
			e_msg := '임대미수금 계정 없음 ot01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_02_2
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '83' ;        -- 임대연체료 계정
		if v_acntcode_02_2 is null then
			e_msg := '임대연체료 계정 없음 ot01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
      v_w_cnt := 999;    -- 전표 write  건수가 99 건이 넘으면 새로운 전표를 만든다.
    	v_save_amt := 0;
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO v_dongho, v_seq, v_cust_code, v_cust_name, v_occ_date, v_r_amt, v_delay_amt ;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
			IF v_cust_code is not null THEN
				select COUNT(*)
				  into C_CNT
				  from sm_code_cust
				 where cust_code = v_cust_code;
				IF C_CNT < 1 THEN
					e_msg      := '거래처 생성 실패! ot01 [Line No: -3]' || v_cust_code;
						INSERT INTO ERPC.SM_CODE_CUST
						  SELECT CUST_CODE,'Y','Y',decode(CUST_DIV, '01', '002', '02', '001', '099'),CUST_NAME,CUST_NAME,'','','',
									'','','',HOME_PHONE,'',CONTRACT_ZIP_CODE, CONTRACT_ADDR1,
									'','','',sysdate,'',null
							 FROM H_CODE_CUST
							WHERE CUST_CODE = v_cust_code ;
				END IF;
			END IF;
			-- 전표 insert 건수가 99 를 넘으면 새로운 전표를 만든다.
			IF v_w_cnt < 100 and v_temp_date <> v_occ_date  THEN
			   v_w_cnt := 999 ;
			end if;
			IF v_w_cnt > 99 THEN
					v_temp_date := v_occ_date ;
					v_w_cnt  := 0;
					C_DT_SEQ := 0;
					select COUNT(*)
					  into C_CNT
					  from am_work_workno
		 		    where work_date = v_occ_date;
					IF C_CNT < 1 THEN
					   e_msg      := '전표번호 생성 실패! ot01 [Line No: -1]';
						INSERT INTO ERPC.AM_WORK_WORKNO
						VALUES ( v_occ_date,1 )  ;
						C_SEQ := 1;
					ELSE
						select work_no_last
						  into C_SEQ
						  from am_work_workno
				   	 where work_date = v_occ_date;
						C_SEQ := C_SEQ + 1;
					   e_msg      := '전표번호 수정 실패! ot01 [Line No: -2]';
						UPDATE ERPC.AM_WORK_WORKNO
						  SET WORK_NO_LAST = C_SEQ
						WHERE WORK_DATE = v_occ_date;
					END IF;
					C_KIND_CODE := 'AM1';
					v_vatcode := null;
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
				   e_msg      := '가전표 마스타 생성 실패! ot01 [Line No: 3]';
					INSERT INTO ERPC.AM_WORK_MASTER
					VALUES ( v_occ_date,C_SEQ,C_START_SEQ,'01',as_dept,C_KIND_CODE,'003',as_slip_name,sysdate,'01',v_cust_code,
								v_occ_date,C_EVIDENCE_KIND,null,'N',null,null,'N',null,null,'N',null,null,null,null,null,null,'N',null,null )  ;
			END IF;
-- 가전표_디테일을 입력한다
			v_dongho_tmp := substr(v_dongho, 1, 4) || '-' || substr(v_dongho, 5, 4);
			v_desc := v_agree_yymm || ' 임대료 입금 ' || v_cust_name || '-' || v_dongho_tmp ;
			-- 대변 시작
			v_acnt_tmp2 := v_acntcode_02_1;  -- 임대미수금
			v_save_amt := v_save_amt + v_r_amt + v_delay_amt;
         v_amt := v_r_amt;
			v_vat := 0;
			v_tot := v_amt ;
		   e_msg      := '가전표 디테일 생성 실패! ot01 [Line No: 5]'|| C_SEQ || ' 2';
			C_DT_SEQ := C_DT_SEQ + 1;
			v_w_cnt  := v_w_cnt + 1;
			v_vatcode := null;
			INSERT INTO erpc.AM_WORK_DETAIL
			VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
					 v_acnt_tmp2,v_acnt_tmp2,0,0,0,v_tot,0,v_amt,v_desc,v_desc,
					 '01',v_cust_code,v_vatcode,v_occ_date,null,null,null,null,null,null,null,null,null,null,null,null,null,
					 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,v_dongho_tmp,null,null,null,null,
					 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ;
			if v_delay_amt <> 0 then
				v_acnt_tmp2 := v_acntcode_02_2;  -- 임대연체료
	         v_amt := v_delay_amt;
				v_vat := 0;
				v_tot := v_amt ;
			   e_msg      := '가전표 디테일 생성 실패! ot01 [Line No: 5]'|| C_SEQ || ' 2';
				C_DT_SEQ := C_DT_SEQ + 1;
				v_w_cnt  := v_w_cnt + 1;
				v_vatcode := null;
				INSERT INTO erpc.AM_WORK_DETAIL
				VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
						 v_acnt_tmp2,v_acnt_tmp2,0,0,0,v_tot,0,v_amt,v_desc,v_desc,
						 '01',v_cust_code,v_vatcode,v_occ_date,null,null,null,null,null,null,null,null,null,null,null,null,null,
						 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,null,null,null,null,null,
						 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ;
			end if;
			if v_save_amt <> 0 and v_w_cnt > 99 then
				-- 차변 시작
				v_acnt_tmp1 := v_acntcode_01_1;  -- 보통예금
	         v_amt := v_save_amt;
				v_vat := 0;
				v_tot := v_amt ;
				v_desc := '임대료 입금';
				v_save_amt := 0;
			   e_msg      := '가전표 디테일 생성 실패! ot01 [Line No: 4]'|| C_SEQ || ' 1';
				C_DT_SEQ := C_DT_SEQ + 1;
				v_w_cnt  := v_w_cnt + 1;
				v_vatcode := null;
				INSERT INTO erpc.AM_WORK_DETAIL
				VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
						 v_acnt_tmp1,v_acnt_tmp1,v_tot,0,v_amt,0,0,0,v_desc,v_desc,
						 '01',v_cust_code,v_vatcode,v_occ_date,null,null,null,null,null,null,null,null,null,null,null,null,null,
						 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,null,null,null,null,null,
						 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ;
			end if;
		END LOOP;
			if v_save_amt <> 0 then
				-- 차변 시작
				v_acnt_tmp1 := v_acntcode_01_1;  -- 보통예금
	         v_amt := v_save_amt;
				v_vat := 0;
				v_tot := v_amt ;
				v_desc := '임대료 입금';
				v_save_amt := 0;
			   e_msg      := '가전표 디테일 생성 실패! ot01 [Line No: 4]'|| C_SEQ || ' 1';
				C_DT_SEQ := C_DT_SEQ + 1;
				v_w_cnt  := v_w_cnt + 1;
				v_vatcode := null;
				INSERT INTO erpc.AM_WORK_DETAIL
				VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
						 v_acnt_tmp1,v_acnt_tmp1,v_tot,0,v_amt,0,0,0,v_desc,v_desc,
						 '01',v_cust_code,v_vatcode,v_occ_date,null,null,null,null,null,null,null,null,null,null,null,null,null,
						 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,null,null,null,null,null,
						 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ;
			end if;
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
END y_sp_h_slip_list_ls02;
/

