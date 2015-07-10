CREATE OR REPLACE PROCEDURE y_sp_h_slip_list_jd02(as_dept_code    IN   VARCHAR2,
                                        		as_sell_code    IN   VARCHAR2,
                                        		adt_from_date   IN   DATE,
															adt_to_date     IN   DATE,
															as_dept         IN   VARCHAR2,
															as_slip_name    IN   VARCHAR2 ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 계약금 입금 사항
--  tag   1:할인료 발생    2:할인/연체 없음     3:연체료 발생    9:과오납 발생
CURSOR DETAIL_CUR IS
		select '1' tag,
             a.sell_code,
		       a.dongho,
		       a.seq,
		       a.contract_code,
		       c.receipt_date,
		       a.cust_code,
		       d.cust_name,
		       max(b.degree_code) degree_code,
		       sum(c.delay_amt)     delay_amt,
		       sum(c.discount_amt)  discount_amt,
		       sum(c.r_amt + c.delay_amt - c.discount_amt)  sell_amt
		  from h_sale_master  a,
		       h_sale_agree   b,
		       h_sale_income  c,
		       h_code_cust    d
		 where a.dept_code = b.dept_code
		   and a.sell_code = b.sell_code
		   and a.dongho    = b.dongho
		   and a.seq       = b.seq
		   and b.dept_code = c.dept_code
		   and b.sell_code = c.sell_code
		   and b.dongho    = c.dongho
		   and b.seq       = c.seq
		   and b.degree_code = c.degree_code
		   and a.cust_code = d.cust_code (+)
		   and a.dept_code = as_dept_code
		   and a.sell_code = as_sell_code
		   and c.receipt_date between adt_from_date and adt_to_date
		   and a.last_contract_date <= adt_to_date
		   and a.chg_date    > adt_to_date
		   and a.chg_div     <> '00'
		   and c.degree_code > '09'
		   and c.degree_seq  < 70
		   and c.discount_amt <> 0
		 group by a.sell_code,
		       a.dongho,
		       a.seq,
		       a.contract_code,
		       c.receipt_date,
		       a.cust_code,
		       d.cust_name
		 having sum(c.r_amt) <> 0 or sum(c.delay_amt) <> 0 or sum(c.discount_amt) <> 0
    UNION
		select '2' tag,
             a.sell_code,
		       a.dongho,
		       a.seq,
		       a.contract_code,
		       c.receipt_date,
		       a.cust_code,
		       d.cust_name,
		       max(b.degree_code) degree_code,
		       sum(c.delay_amt)     delay_amt,
		       sum(c.discount_amt)  discount_amt,
		       sum(c.r_amt + c.delay_amt - c.discount_amt)  sell_amt
		  from h_sale_master  a,
		       h_sale_agree   b,
		       h_sale_income  c,
		       h_code_cust    d
		 where a.dept_code = b.dept_code
		   and a.sell_code = b.sell_code
		   and a.dongho    = b.dongho
		   and a.seq       = b.seq
		   and b.dept_code = c.dept_code
		   and b.sell_code = c.sell_code
		   and b.dongho    = c.dongho
		   and b.seq       = c.seq
		   and b.degree_code = c.degree_code
		   and a.cust_code = d.cust_code (+)
		   and a.dept_code = as_dept_code
		   and a.sell_code = as_sell_code
		   and c.receipt_date between adt_from_date and adt_to_date
		   and a.last_contract_date <= adt_to_date
		   and a.chg_date    > adt_to_date
		   and a.chg_div     <> '00'
		   and c.degree_code > '09'
		   and c.degree_seq  < 70
		   and c.discount_amt = 0 and c.delay_amt = 0
		 group by a.sell_code,
		       a.dongho,
		       a.seq,
		       a.contract_code,
		       c.receipt_date,
		       a.cust_code,
		       d.cust_name
		 having sum(c.r_amt) <> 0 or sum(c.delay_amt) <> 0 or sum(c.discount_amt) <> 0
    UNION
		select '3' tag,
             a.sell_code,
		       a.dongho,
		       a.seq,
		       a.contract_code,
		       c.receipt_date,
		       a.cust_code,
		       d.cust_name,
		       max(b.degree_code) degree_code,
		       sum(c.delay_amt)     delay_amt,
		       sum(c.discount_amt)  discount_amt,
		       sum(c.r_amt + c.delay_amt - c.discount_amt)  sell_amt
		  from h_sale_master  a,
		       h_sale_agree   b,
		       h_sale_income  c,
		       h_code_cust    d
		 where a.dept_code = b.dept_code
		   and a.sell_code = b.sell_code
		   and a.dongho    = b.dongho
		   and a.seq       = b.seq
		   and b.dept_code = c.dept_code
		   and b.sell_code = c.sell_code
		   and b.dongho    = c.dongho
		   and b.seq       = c.seq
		   and b.degree_code = c.degree_code
		   and a.cust_code = d.cust_code (+)
		   and a.dept_code = as_dept_code
		   and a.sell_code = as_sell_code
		   and c.receipt_date between adt_from_date and adt_to_date
		   and a.last_contract_date <= adt_to_date
		   and a.chg_date    > adt_to_date
		   and a.chg_div     <> '00'
		   and c.degree_code > '09'
		   and c.degree_seq  < 70
		   and c.delay_amt   <> 0
		 group by a.sell_code,
		       a.dongho,
		       a.seq,
		       a.contract_code,
		       c.receipt_date,
		       a.cust_code,
		       d.cust_name
		 having sum(c.r_amt) <> 0 or sum(c.delay_amt) <> 0 or sum(c.discount_amt) <> 0
    UNION
		select '9' tag,
             a.sell_code,
		       a.dongho,
		       a.seq,
		       a.contract_code,
		       c.receipt_date,
		       a.cust_code,
		       d.cust_name,
		       max(b.degree_code) degree_code,
		       sum(c.delay_amt)     delay_amt,
		       sum(c.discount_amt)  discount_amt,
		       sum(c.r_amt + c.delay_amt - c.discount_amt)  sell_amt
		  from h_sale_master  a,
		       h_sale_agree   b,
		       h_sale_income  c,
		       h_code_cust    d
		 where a.dept_code = b.dept_code
		   and a.sell_code = b.sell_code
		   and a.dongho    = b.dongho
		   and a.seq       = b.seq
		   and b.dept_code = c.dept_code
		   and b.sell_code = c.sell_code
		   and b.dongho    = c.dongho
		   and b.seq       = c.seq
		   and b.degree_code = c.degree_code
		   and a.cust_code = d.cust_code (+)
		   and a.dept_code = as_dept_code
		   and a.sell_code = as_sell_code
		   and c.receipt_date between adt_from_date and adt_to_date
		   and a.last_contract_date <= adt_to_date
		   and a.chg_date    > adt_to_date
		   and a.chg_div     <> '00'
		   and c.degree_code > '09'
		   and c.degree_seq  > 69
		 group by a.sell_code,
		       a.dongho,
		       a.seq,
		       a.contract_code,
		       c.receipt_date,
		       a.cust_code,
		       d.cust_name
		 having sum(c.r_amt) <> 0 or sum(c.delay_amt) <> 0 or sum(c.discount_amt) <> 0
   ORDER BY  receipt_date, dongho, degree_code, tag  ;
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   v_dept_name        z_code_dept.long_name%TYPE;
   v_desc             VARCHAR2(100);
   v_tag              VARCHAR2(1);
   v_sell_code        VARCHAR2(2);
   v_degree           VARCHAR2(2);
   v_dongho           VARCHAR2(10);
   v_dongho_tmp       VARCHAR2(10);
   v_contract_code    VARCHAR2(2);
   v_cust_code        VARCHAR2(15);
   v_cust_name        VARCHAR2(90);
   v_vatcode          VARCHAR2(2);
   v_pay_yn           VARCHAR2(2);
   v_code_name        VARCHAR2(30);
   v_occ_date         DATE;
   v_deptdetail_code  VARCHAR2(3);
   v_acnt_tmp1        VARCHAR2(10);
   v_acnt_tmp2        VARCHAR2(10);
   v_acntcode_01_1    VARCHAR2(10);
   v_acntcode_01_2    VARCHAR2(10);
   v_acntcode_01_3    VARCHAR2(10);
   v_acntcode_01_4    VARCHAR2(10);
   v_acntcode_01_5    VARCHAR2(10);
   v_acntcode_02_1    VARCHAR2(10);
   v_acntcode_02_2    VARCHAR2(10);
   v_acntcode_02_3    VARCHAR2(10);
   v_acntcode_02_4    VARCHAR2(10);
   v_acntcode_02_5    VARCHAR2(10);
   v_acntcode_02_6    VARCHAR2(10);
   v_seq              NUMBER(10,0);
   v_delay            NUMBER(15,0);
   v_discount         NUMBER(15,0);
   v_sell_amt         NUMBER(15,0);
   v_r_amt            NUMBER(15,0);
   v_org_amt          NUMBER(15,0);
   v_amt              NUMBER(15,0);
   v_amt1             NUMBER(15,0);
   v_amt2             NUMBER(15,0);
   v_vat              NUMBER(15,0)   DEFAULT 0;
   v_tot              NUMBER(15,0);
  	v_w_cnt            NUMBER(15,0);
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
		  and  CODE     = '18' ;       --   선수금(분양대금) 계정
		if v_acntcode_01_1 is null then
			e_msg := '선수금(분양대금) 계정 없음 ct01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_01_2
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '92' ;       --   매출할인(아파트) 계정
		if v_acntcode_01_2 is null then
			e_msg := '매출할인(아파트) 계정 없음 ct01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_01_3
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '93' ;       --   매출할인(상가)  계정
		if v_acntcode_01_3 is null then
			e_msg := '매출할인(상가) 계정 없음 ct01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_01_4
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '95' ;       --   매출할인(임대주택)
		if v_acntcode_01_4 is null then
			e_msg := '매출할인(임대주택) 계정 없음 ct01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_01_5
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '31' ;       --   임대선수금 계정
		if v_acntcode_01_5 is null then
			e_msg := '임대선수금 계정 없음 ct01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_02_1
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '05' ;        -- 분양미수금(아파트) 계정
		if v_acntcode_02_1 is null then
			e_msg := '분양미수금(아파트) 계정 없음 ct01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_02_2
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '06' ;        -- 분양미수금(상가)
		if v_acntcode_02_2 is null then
			e_msg := '분양미수금(상가) 계정 없음 ct01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_02_3
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '15' ;        -- 임대보증금(임대주택) 계정
		if v_acntcode_02_3 is null then
			e_msg := '임대보증금(임대주택) 계정 없음 ct01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_02_4
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '85' ;        -- 연체료 계정
		if v_acntcode_02_4 is null then
			e_msg := '연체료 계정 없음 ct01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_02_5
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '83' ;        -- 임대연체료 계정
		if v_acntcode_02_5 is null then
			e_msg := '임대연체료 계정 없음 ct01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_02_6
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '43' ;        -- 예수금(과납,오류입금) 계정
		if v_acntcode_02_6 is null then
			e_msg := '예수금(과납,오류입금) 계정 없음 ct01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
      v_w_cnt := 999;    -- 전표 write  건수가 99 건이 넘으면 새로운 전표를 만든다.
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO v_tag, v_sell_code, v_dongho, v_seq, v_contract_code, v_occ_date,
			                      v_cust_code, v_cust_name, v_degree, v_delay, v_discount, v_org_amt;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
			IF v_cust_code is not null THEN
				select COUNT(*)
				  into C_CNT
				  from sm_code_cust
				 where cust_code = v_cust_code;
				IF C_CNT < 1 THEN
					e_msg      := '거래처 생성 실패! ct01 [Line No: -3]' || v_cust_code;
						INSERT INTO ERPC.SM_CODE_CUST
						  SELECT CUST_CODE,'Y','Y',decode(CUST_DIV, '01', '002', '02', '001', '099'),CUST_NAME,CUST_NAME,'','','',
									'','','',HOME_PHONE,'',CONTRACT_ZIP_CODE, CONTRACT_ADDR1,
									'','','',sysdate,'',null
							 FROM H_CODE_CUST
							WHERE CUST_CODE = v_cust_code ;
				END IF;
			END IF;
			-- 전표 insert 건수가 99 를 넘으면 새로운 전표를 만든다.
			IF v_w_cnt > 99 THEN
					v_w_cnt  := 0;
					C_DT_SEQ := 0;
					select COUNT(*)
					  into C_CNT
					  from am_work_workno
		 		    where work_date = v_occ_date;
					IF C_CNT < 1 THEN
					   e_msg      := '전표번호 생성 실패! ct01 [Line No: -1]';
						INSERT INTO ERPC.AM_WORK_WORKNO
						VALUES ( v_occ_date,1 )  ;
						C_SEQ := 1;
					ELSE
						select work_no_last
						  into C_SEQ
						  from am_work_workno
				   	 where work_date = v_occ_date;
						C_SEQ := C_SEQ + 1;
					   e_msg      := '전표번호 수정 실패! ct01 [Line No: -2]';
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
				   e_msg      := '가전표 마스타 생성 실패! ct01 [Line No: 3]';
					INSERT INTO ERPC.AM_WORK_MASTER
					VALUES ( v_occ_date,C_SEQ,C_START_SEQ,'01',as_dept,C_KIND_CODE,'003',as_slip_name,sysdate,'01',v_cust_code,
								v_occ_date,C_EVIDENCE_KIND,null,'N',null,null,'N',null,null,'N',null,null,null,null,null,null,'N',null,null )  ;
			END IF;
-- 가전표_디테일을 입력한다
			select  c.code_name, a.sell_amt, sum(b.r_amt)
			  into  v_code_name, v_sell_amt, v_r_amt
			  from h_sale_agree a, h_sale_income b, h_code_common c
		    where a.dept_code   = as_dept_code
		      and a.sell_code   = as_sell_code
		      and a.dongho      = v_dongho
		      and a.seq         = v_seq
		      and a.degree_code = v_degree
		      and b.dept_code   = as_dept_code
		      and b.sell_code   = as_sell_code
		      and b.dongho      = v_dongho
		      and b.seq         = v_seq
		      and b.degree_code = v_degree
		      and b.receipt_date between adt_from_date and adt_to_date
		      and c.code_div(+) = '02'
		      and c.code(+)     = v_degree
          group by c.code_name, a.sell_amt  ;
			v_dongho_tmp := substr(v_dongho, 1, 4) || '-' || substr(v_dongho, 5, 4);
			v_desc := v_code_name || '-' || v_cust_name || ' ' || v_dongho_tmp;
			if v_tag = '9' then
				v_desc := v_desc || ' 과납,오류입금';
	      	v_amt1 := v_org_amt - v_discount ;   -- 과납,오류 발생한 경우
	      	v_amt2 := v_discount ;
			else
				if v_r_amt >= v_sell_amt then
					v_desc := v_desc || ' 완납';
				end if;
				-- 차변 시작
		      if v_tag = '1' then
		      	v_amt1 := v_org_amt - v_discount ;   -- 할인료 발생한 경우
		      	v_amt2 := v_discount ;
		      else
		      	v_amt1 := v_org_amt ;
		      	v_amt2 := 0 ;
		      end if;
	      end if;
			if v_contract_code = '02' then
				v_acnt_tmp1 := v_acntcode_01_5;     -- 임대선수금
			else
				v_acnt_tmp1 := v_acntcode_01_1;     -- 선수금(분양대금)
			end if;
         v_amt := v_amt1;
			v_vat := 0;
			v_tot := v_amt1;
		   e_msg      := '가전표 디테일 생성 실패! ct01 [Line No: 5]'|| C_SEQ || ' 1';
			C_DT_SEQ := C_DT_SEQ + 1;
			v_w_cnt  := v_w_cnt + 1;
			-- 차변
			INSERT INTO erpc.AM_WORK_DETAIL
			VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
					 v_acnt_tmp1,v_acnt_tmp1,v_tot,v_vat,v_amt,0,0,0,v_desc,v_desc,
					 '01',v_cust_code,v_vatcode,v_occ_date,null,null,null,null,null,null,null,null,null,null,null,null,null,
					 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,v_dongho_tmp,null,null,null,null,
					 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ;
			if v_tag = '1' then
				if v_contract_code = '02' then
					v_acnt_tmp1 := v_acntcode_01_4;     -- 매출할인(임대주택)
				else
					if v_sell_code = '03' then
						v_acnt_tmp1 := v_acntcode_01_3;  -- 매출할인(상가)
					else
						v_acnt_tmp1 := v_acntcode_01_2;  -- 매출할인(아파트)
					end if;
				end if;
	         v_amt := v_amt2;
				v_vat := 0;
				v_tot := v_amt2;
			   e_msg      := '가전표 디테일 생성 실패! ct01 [Line No: 5]'|| C_SEQ || ' 1';
				C_DT_SEQ := C_DT_SEQ + 1;
				v_w_cnt  := v_w_cnt + 1;
				INSERT INTO erpc.AM_WORK_DETAIL
				VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
						 v_acnt_tmp1,v_acnt_tmp1,v_tot,v_vat,v_amt,0,0,0,v_desc,v_desc,
						 '01',v_cust_code,v_vatcode,v_occ_date,null,null,null,null,null,null,null,null,null,null,null,null,null,
						 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,null,null,null,null,null,
						 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ;
			end if;
			-- 대변 시작
	      if v_tag = '3' then
	      	v_amt1 := v_org_amt - v_delay ;   -- 연체료 발생한 경우
	      	v_amt2 := v_delay ;
	      else
	      	v_amt1 := v_org_amt ;
	      	v_amt2 := 0 ;
	      end if;
			if v_tag = '9' then
				v_acnt_tmp2 := v_acntcode_02_6;        -- 예수금(과납,오류입금)
			else
				if v_contract_code = '02' then
					v_acnt_tmp2 := v_acntcode_02_3;     -- 임대보증금(임대주택)
				else
					if v_sell_code = '03' then
						v_acnt_tmp2 := v_acntcode_02_2;  -- 분양미수금(상가)
					else
						v_acnt_tmp2 := v_acntcode_02_1;  -- 분양미수금(아파트)
					end if;
				end if;
			end if;
         v_amt := v_amt1;
			v_vat := 0;
			v_tot := v_amt1;
		   e_msg      := '가전표 디테일 생성 실패! ct01 [Line No: 4]'|| C_SEQ || ' 1';
			C_DT_SEQ := C_DT_SEQ + 1;
			v_w_cnt  := v_w_cnt + 1;
			-- 대변
			INSERT INTO erpc.AM_WORK_DETAIL
			VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
					 v_acnt_tmp2,v_acnt_tmp2,0,0,0,v_tot,0,v_tot,v_desc,v_desc,
					 '01',v_cust_code,null,v_occ_date,null,null,null,null,null,null,null,null,null,null,null,null,null,
					 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,v_dongho_tmp,null,null,null,null,
					 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ;
			if v_tag = '3' then
				if v_contract_code = '02' then
					v_acnt_tmp2 := v_acntcode_02_5;     -- 임대연체료
				else
					v_acnt_tmp2 := v_acntcode_02_4;     -- 연체료
				end if;
	         v_amt := v_amt2;
				v_vat := 0;
				v_tot := v_amt2;
			   e_msg      := '가전표 디테일 생성 실패! ct01 [Line No: 5]'|| C_SEQ || ' 1';
				C_DT_SEQ := C_DT_SEQ + 1;
				v_w_cnt  := v_w_cnt + 1;
				INSERT INTO erpc.AM_WORK_DETAIL
				VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
						 v_acnt_tmp2,v_acnt_tmp2,0,0,0,v_tot,0,v_tot,v_desc,v_desc,
						 '01',v_cust_code,null,v_occ_date,null,null,null,null,null,null,null,null,null,null,null,null,null,
						 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,v_dongho_tmp,null,null,null,null,
						 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ;
			end if;
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
END y_sp_h_slip_list_jd02;
/

