CREATE OR REPLACE PROCEDURE y_sp_h_slip_list_ch01(as_dept_code    IN   VARCHAR2,
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
   v_cust_code        VARCHAR2(15);
   v_cust_name        VARCHAR2(90);
   v_pay_tag          VARCHAR2(2);
   v_pay_tag_save     VARCHAR2(2);
   v_vatcode          VARCHAR2(2);
   v_occ_date         DATE;
   v_deptdetail_code  VARCHAR2(3);
   v_acntcode_01_1    VARCHAR2(10);
   v_acntcode_01_2    VARCHAR2(10);
   v_acntcode_01_3    VARCHAR2(10);
   v_acntcode_01      VARCHAR2(10);
   v_acntcode_02      VARCHAR2(10);
   v_seq              NUMBER(10,0);
   v_amt              NUMBER(15,0);
   v_vat              NUMBER(15,0);
   v_tot              NUMBER(15,0);
   v_save_amt         NUMBER(15,0);
   v_cnt              NUMBER(15,0);
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
CURSOR DT_CUR IS
	SELECT DISTINCT a.subs_date, a.pay_tag
	 FROM h_subs_master a,
	      h_code_cust   b,
	      h_code_class  c
	WHERE  a.dept_code = c.dept_code (+) and
	       a.sell_code = c.sell_code (+) and
	       a.class     = c.class (+)     and
	       b.cust_code = a.cust_code     and
	       a.subs_amt <> 0               and
	       a.dept_code = as_dept_code    and
	       a.sell_code = as_sell_code    and
	       a.subs_date between adt_from_date and adt_to_date
	   ORDER BY a.subs_date, a.pay_tag ;
CURSOR DETAIL_CUR IS
	SELECT a.subs_date,
	       a.cust_code,
	       b.cust_name,
	       a.subs_amt
	 FROM h_subs_master a,
	      h_code_cust   b,
	      h_code_class  c
	WHERE  a.dept_code = c.dept_code (+) and
	       a.sell_code = c.sell_code (+) and
	       a.class     = c.class (+)     and
	       b.cust_code = a.cust_code     and
	       a.subs_amt <> 0               and
	       a.dept_code = as_dept_code    and
	       a.sell_code = as_sell_code    and
	       a.subs_date = v_occ_date      and
	       a.pay_tag   = v_pay_tag
	   ORDER BY a.subs_no ;
BEGIN
   BEGIN
		select substr(code_name, 1, 8)
		  into v_acntcode_01_1
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '53' ;       -- 보통예금 계정
		if v_acntcode_01_1 is null then
			e_msg := '보통예금 계정 없음 ch01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_01_2
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '55' ;       -- 미수금(카드) 계정
		if v_acntcode_01_2 is null then
			e_msg := '미수금(카드) 계정 없음 ch01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_01_3
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '51' ;       -- 현금 계정
		if v_acntcode_01_3 is null then
			e_msg := '현금 계정 없음 ch01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_02
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '33' ;        -- 예수금(청약) 계정
		if v_acntcode_02 is null then
			e_msg := '예수금(청약) 계정 없음 ch01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		C_KIND_CODE := 'AM1';
		C_EVIDENCE_KIND := '999';
		C_DT_SEQ := 0;
      v_save_amt := 0;
		v_cnt := 9999;
		OPEN	DT_CUR;
		LOOP
			FETCH  DT_CUR  INTO  v_occ_date, v_pay_tag ;
			EXIT WHEN DT_CUR%NOTFOUND;
				if v_cnt < 9999 then
					v_cnt := 0;
					C_DT_SEQ := C_DT_SEQ + 1;
					if v_pay_tag_save = '01' then
						v_acntcode_01 := v_acntcode_01_1;  -- 보통예금
					else
						if v_pay_tag_save = '02' then
							v_acntcode_01 := v_acntcode_01_2;  -- 미수금(카드)
						else
							v_acntcode_01 := v_acntcode_01_3;  -- 현금
						end if;
					end if;
					INSERT INTO erpc.AM_WORK_DETAIL
					VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
							 v_acntcode_01,v_acntcode_01,v_save_amt,0,v_save_amt,0,0,0,'청약금 입금','청약금 입금',
							 '01',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
							 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,null,null,null,null,null,
							 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ;
				end if;
				v_pay_tag_save := v_pay_tag;
				select COUNT(*)
					  into C_CNT
					  from am_work_workno
		 		    where work_date = v_occ_date;
				IF C_CNT < 1 THEN
				   e_msg      := '전표번호 생성 실패! ch01 [Line No: -1]';
					INSERT INTO ERPC.AM_WORK_WORKNO
					VALUES ( v_occ_date,1 )  ;
					C_SEQ := 1;
				ELSE
					select work_no_last
					  into C_SEQ
					  from am_work_workno
			   	 where work_date = v_occ_date;
					C_SEQ := C_SEQ + 1;
				   e_msg      := '전표번호 수정 실패! ch01 [Line No: -2]';
					UPDATE ERPC.AM_WORK_WORKNO
					  SET WORK_NO_LAST = C_SEQ
					WHERE WORK_DATE = v_occ_date;
				END IF;
				IF C_START_SEQ = 0 THEN
					C_START_SEQ := C_SEQ;
				END IF;
				e_msg      := '가전표 마스타 생성 실패! ch01 [Line No: 4]';
				INSERT INTO ERPC.AM_WORK_MASTER
				    VALUES ( v_occ_date,C_SEQ,C_START_SEQ,'01',as_dept,C_KIND_CODE,'003',as_slip_name,sysdate,'01',null,
								null,null,null,'N',null,null,'N',null,null,'N',null,null,null,null,null,null,'N',null,null )  ;
				C_DT_SEQ := 0;
		      v_save_amt := 0;
		BEGIN
			OPEN	DETAIL_CUR;
			LOOP
				FETCH DETAIL_CUR INTO v_occ_date, v_cust_code, v_cust_name, v_amt;
				EXIT WHEN DETAIL_CUR%NOTFOUND;
				v_cnt := v_cnt + 1;
				IF v_cust_code is not null THEN
					select COUNT(*)
					  into C_CNT
					  from sm_code_cust
					 where cust_code = v_cust_code;
					IF C_CNT < 1 THEN
						e_msg      := '거래처 생성 실패! ch01 [Line No: -3]' || v_cust_code;
							INSERT INTO ERPC.SM_CODE_CUST
							  SELECT CUST_CODE,'Y','Y',decode(CUST_DIV, '01', '002', '02', '001', '099'),CUST_NAME,CUST_NAME,'','','',
										'','','',HOME_PHONE,'',CONTRACT_ZIP_CODE, CONTRACT_ADDR1,
										'','','',sysdate,'',null
								 FROM H_CODE_CUST
								WHERE CUST_CODE = v_cust_code ;
					END IF;
				END IF;
	-- 가전표_디테일을 입력한다
				SELECT MIN(DEPTDETAIL_CODE)
		        INTO v_deptdetail_code
		 		   FROM ERPC.AM_CODE_DEPT_RELA
		        WHERE dept_code = as_dept_code
		          and DEPTDETAIL_CODE <> '530'
		        ;
				v_desc     := v_cust_name || ' 청약금 입금';
			   e_msg      := '가전표 디테일 생성 실패! ch01 [Line No: 5]'|| C_SEQ || ' 1';
				C_DT_SEQ := C_DT_SEQ + 1;
				INSERT INTO erpc.AM_WORK_DETAIL
				VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
						 v_acntcode_02,v_acntcode_02,0,0,0,v_amt,0,v_amt,v_desc,v_desc,
						 '01',v_cust_code,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
						 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,null,null,null,null,null,
						 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ;
				v_save_amt := v_save_amt + v_amt ;
		   e_msg      := '가전표 디테일 생성 실패! ch01 [Line No: 6]'|| C_SEQ || ' 3';
			END LOOP;
			CLOSE DETAIL_CUR;
	      EXCEPTION
	      WHEN others THEN
	           IF SQL%NOTFOUND THEN
	              Wk_errflag := -20020;
	              GOTO EXIT_ROUTINE;
	           END IF;
	   END;
		   e_msg      := '가전표 디테일 생성 실패! ch01 [Line No: 6]'|| C_SEQ || ' 4';
			C_DT_SEQ := C_DT_SEQ + 1;
			if v_pay_tag_save = '01' then
				v_acntcode_01 := v_acntcode_01_1;  -- 보통예금
			else
				if v_pay_tag_save = '02' then
					v_acntcode_01 := v_acntcode_01_2;  -- 미수금(카드)
				else
					v_acntcode_01 := v_acntcode_01_3;  -- 현금
				end if;
			end if;
			INSERT INTO erpc.AM_WORK_DETAIL
			VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
					 v_acntcode_01,v_acntcode_01,v_save_amt,0,v_save_amt,0,0,0,'청약금 입금','청약금 입금',
					 '01',v_cust_code,v_vatcode,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
					 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,null,null,null,null,null,
					 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ;
		   e_msg      := '가전표 디테일 생성 실패! ch01 [Line No: 6]'|| C_SEQ || ' 5';
		END LOOP;
		CLOSE DT_CUR;
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
END y_sp_h_slip_list_ch01;
/

