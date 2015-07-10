CREATE OR REPLACE PROCEDURE y_sp_h_slip_list_ct01(as_dept_code    IN   VARCHAR2,
                                        		as_sell_code    IN   VARCHAR2,
                                        		adt_from_date   IN   DATE,
															adt_to_date     IN   DATE,
															as_dept         IN   VARCHAR2,
															as_slip_name    IN   VARCHAR2 ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 계약금 약정 사항
CURSOR DETAIL_CUR IS
		select '토지가'  tag,
		       a.sell_code,
		       a.dongho,
		       a.contract_code,
		       a.last_contract_date,
		       a.cust_code,
		       c.cust_name,
		       sum(b.land_amt)  land_amt,
		       sum(b.build_amt) build_amt,
		       sum(b.vat_amt)   vat_amt,
		       sum(b.sell_amt)  sell_amt
		  from h_sale_master a,
		       h_sale_agree  b,
		       h_code_cust   c
		 where a.dept_code = b.dept_code
		   and a.sell_code = b.sell_code
		   and a.dongho    = b.dongho
		   and a.seq       = b.seq
		   and a.cust_code = c.cust_code (+)
		   and a.dept_code = as_dept_code
		   and a.sell_code = as_sell_code
		   and a.last_contract_date between adt_from_date and adt_to_date
		   and a.chg_date    > adt_to_date
		   and a.chg_div     <> '00'
		   and b.degree_code < '10'
		 group by a.sell_code,
		       a.dongho,
		       a.contract_code,
		       a.last_contract_date,
		       a.cust_code,
		       c.cust_name
		 having sum(b.land_amt) <> 0
		    and sum(b.vat_amt)  <> 0
		    and (sum(b.sell_amt) = (sum(b.land_amt) + sum(b.build_amt) + sum(b.vat_amt)))
		UNION
		select '건물가'  tag,
		       a.sell_code,
		       a.dongho,
		       a.contract_code,
		       a.last_contract_date,
		       a.cust_code,
		       c.cust_name,
		       sum(b.land_amt)  land_amt,
		       sum(b.build_amt) build_amt,
		       sum(b.vat_amt)   vat_amt,
		       sum(b.sell_amt)  sell_amt
		  from h_sale_master a,
		       h_sale_agree  b,
		       h_code_cust   c
		 where a.dept_code = b.dept_code
		   and a.sell_code = b.sell_code
		   and a.dongho    = b.dongho
		   and a.seq       = b.seq
		   and a.cust_code = c.cust_code (+)
		   and a.dept_code = as_dept_code
		   and a.sell_code = as_sell_code
		   and a.last_contract_date between adt_from_date and adt_to_date
		   and a.chg_date    > adt_to_date
		   and a.chg_div     <> '00'
		   and b.degree_code < '10'
		 group by a.sell_code,
		       a.dongho,
		       a.contract_code,
		       a.last_contract_date,
		       a.cust_code,
		       c.cust_name
		 having sum(b.build_amt) <> 0
		    and sum(b.vat_amt)   <> 0
		    and (sum(b.sell_amt) = (sum(b.land_amt) + sum(b.build_amt) + sum(b.vat_amt)))
		UNION
		select '공통'  tag,
		       a.sell_code,
		       a.dongho,
		       a.contract_code,
		       a.last_contract_date,
		       a.cust_code,
		       c.cust_name,
		       sum(b.land_amt)  land_amt,
		       sum(b.build_amt) build_amt,
		       sum(b.vat_amt)   vat_amt,
		       sum(b.sell_amt)  sell_amt
		  from h_sale_master a,
		       h_sale_agree  b,
		       h_code_cust   c
		 where a.dept_code = b.dept_code
		   and a.sell_code = b.sell_code
		   and a.dongho    = b.dongho
		   and a.seq       = b.seq
		   and a.cust_code = c.cust_code (+)
		   and a.dept_code = as_dept_code
		   and a.sell_code = as_sell_code
		   and a.last_contract_date between adt_from_date and adt_to_date
		   and a.chg_date    > adt_to_date
		   and a.chg_div     <> '00'
		   and b.degree_code < '10'
		 group by a.sell_code,
		       a.dongho,
		       a.contract_code,
		       a.last_contract_date,
		       a.cust_code,
		       c.cust_name
		 having sum(b.sell_amt) <> 0
          and (sum(b.vat_amt) = 0
               or (sum(b.sell_amt) <> (sum(b.land_amt) + sum(b.build_amt) + sum(b.vat_amt))))
   ORDER BY  dongho, tag ;
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   v_dept_name        z_code_dept.long_name%TYPE;
   v_desc             VARCHAR2(100);
   v_tag              VARCHAR2(10);
   v_sell_code        VARCHAR2(2);
   v_dongho           VARCHAR2(10);
   v_dongho_tmp       VARCHAR2(10);
   v_contract_code    VARCHAR2(2);
   v_cust_code        VARCHAR2(15);
   v_cust_name        VARCHAR2(90);
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
   v_land_amt         NUMBER(15,0);
   v_build_amt        NUMBER(15,0);
   v_vat_amt          NUMBER(15,0);
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
		select substr(code_name, 1, 8)
		  into v_acntcode_01_1
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '05' ;       --   분양미수금(아파트)
		if v_acntcode_01_1 is null then
			e_msg := '분양미수금(아파트) 계정 없음 ct01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_01_2
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '06' ;       --   분양미수금(상가)
		if v_acntcode_01_2 is null then
			e_msg := '분양미수금(상가) 계정 없음 ct01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_01_3
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '31' ;       --   임대선수금
		if v_acntcode_01_3 is null then
			e_msg := '임대선수금 계정 없음 ct01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_02_1
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '11' ;        -- 분양선수금(아파트)
		if v_acntcode_02_1 is null then
			e_msg := '분양선수금(아파트) 계정 없음 ct01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_02_2
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '12' ;        -- 분양선수금(상가)
		if v_acntcode_02_2 is null then
			e_msg := '분양선수금(상가) 계정 없음 ct01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_02_3
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '15' ;        -- 임대보증금 계정
		if v_acntcode_02_3 is null then
			e_msg := '임대보증금 계정 없음 ct01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO v_tag, v_sell_code, v_dongho, v_contract_code, v_occ_date, v_cust_code,
			                      v_cust_name, v_land_amt, v_build_amt, v_vat_amt, v_sell_amt;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
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
			C_KIND_CODE := 'AM1';
			if v_tag = '건물가' then
				v_vatcode := '11';
			else
				if v_tag = '토지가' then
					v_vatcode := 'K1';
				else
					v_vatcode := null;
				end if;
			end if;
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
		   e_msg      := '가전표 마스타 생성 실패! ct01 [Line No: 4]';
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
			if v_contract_code = '02' then
				v_acnt_tmp1 := v_acntcode_01_3;     -- 임대선수금
				v_acnt_tmp2 := v_acntcode_02_3;     -- 임대보증금
			else
				if v_sell_code = '03' then
					v_acnt_tmp1 := v_acntcode_01_2;  -- 분양미수금(상가)
					v_acnt_tmp2 := v_acntcode_02_2;  -- 분양선수금(상가)
				else
					v_acnt_tmp1 := v_acntcode_01_1;  -- 분양미수금(아파트)
					v_acnt_tmp2 := v_acntcode_02_1;  -- 분양선수금(아파트)
				end if;
			end if;
			v_dongho_tmp := substr(v_dongho, 1, 4) || '-' || substr(v_dongho, 5, 4);
			if v_tag = '건물가' then
				v_desc := '계약금-건물분';
				v_amt  := v_build_amt;
				v_vat  := v_vat_amt;
			else
				if v_tag = '토지가' then
					v_desc := '계약금-토지분';
					v_amt  := v_land_amt;
					v_vat  := 0;
				else
					v_desc := '계약금';
					v_amt  := v_sell_amt;
					v_vat  := 0;
				end if;
			end if;
			v_tot := v_amt + v_vat;
		   e_msg      := '가전표 디테일 생성 실패! ct01 [Line No: 5]'|| C_SEQ || ' 1';
			C_DT_SEQ := 1;
			INSERT INTO erpc.AM_WORK_DETAIL
			VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
					 v_acnt_tmp1,v_acnt_tmp1,v_tot,v_vat,v_amt,0,0,0,v_desc,v_desc,
					 '01',v_cust_code,v_vatcode,v_occ_date,null,null,null,null,null,null,null,null,null,null,null,null,null,
					 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,v_dongho_tmp,null,null,null,null,
					 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ;
		   e_msg      := '가전표 디테일 생성 실패! ct01 [Line No: 6]'|| C_SEQ || ' 2';
			C_DT_SEQ := C_DT_SEQ + 1;
			INSERT INTO erpc.AM_WORK_DETAIL
			VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
					 v_acnt_tmp2,v_acnt_tmp2,0,0,0,v_tot,0,v_tot,v_desc,v_desc,
					 '01',v_cust_code,null,v_occ_date,null,null,null,null,null,null,null,null,null,null,null,null,null,
					 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,v_dongho_tmp,null,null,null,null,
					 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ;
		   e_msg      := '가전표 디테일 생성 실패! ct01 [Line No: 6]'|| C_SEQ || ' 2';
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
END y_sp_h_slip_list_ct01;
/

