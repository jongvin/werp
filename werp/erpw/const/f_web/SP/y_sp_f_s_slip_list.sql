CREATE OR REPLACE PROCEDURE y_sp_f_s_slip_list(as_dept_code    IN   VARCHAR2,
                                        		adt_from_date   IN   DATE,
															adt_to_date     IN   DATE,
															adt_slip_date   IN   DATE,
															as_process      IN   VARCHAR2, 
															as_slip_name    IN   VARCHAR2 ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 외주비는 별도처리를 한다.
CURSOR DETAIL_CUR IS
  SELECT a.RES_TYPE,   
     		a.RQST_DETAIL,
         a.cust_code, 
     		a.VATCODE,  
     		a.RECEIPT_DATE,
			a.rqst_date,
			a.seq   
	FROM  ( SELECT max(a.RES_TYPE) res_type,  
						max(a.RQST_DETAIL) RQST_DETAIL,
						max(a.cust_code) cust_code,
						max(a.VATCODE) VATCODE,
						max(a.RECEIPT_DATE) RECEIPT_DATE,
						max(a.rqst_date) rqst_date,
						max(a.seq)  seq, 
						max(z.short_name) dept_name    
				 FROM F_REQUEST a, Z_CODE_DEPT z 
				WHERE ( a.DEPT_CODE =  z.DEPT_CODE ) AND  
				      ( a.DEPT_CODE =  as_dept_code  ) AND  
						( a.RQST_DATE >= adt_from_date  )  AND
						( a.RQST_DATE <= adt_to_date    ) and 
						( a.RES_TYPE = as_process or as_process = 'A') and 
						( a.ACNTCODE is not null) and 
						( a.vatcode is null) and 
						( a.res_type <> 'S') 
			GROUP BY a.dept_code ,a.res_type,a.cust_code
			union all 
			  SELECT a.RES_TYPE,   
						a.RQST_DETAIL,
						a.cust_code, 
						a.VATCODE,  
						a.RECEIPT_DATE,
						a.rqst_date,
						a.seq, 
						z.short_name  dept_name 
				 FROM F_REQUEST a, Z_CODE_DEPT z 
				WHERE ( a.DEPT_CODE =  z.DEPT_CODE ) AND  
				      ( a.DEPT_CODE =  as_dept_code  ) AND  
						( a.RQST_DATE >= adt_from_date )  AND 
						( a.RQST_DATE <=  adt_to_date  ) and 
						( a.RES_TYPE = as_process or as_process = 'A') and 
						( a.ACNTCODE is not null) and 
						( a.vatcode is not null) and 
						( a.res_type <> 'S')  
	) a					
  ORDER BY a.RES_TYPE asc,a.cust_code asc;
-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error 
   v_nodecode         VARCHAR2(4);
   v_company          VARCHAR2(4);
   v_costkind         VARCHAR2(1);
   v_dept_name        z_code_dept.long_name%TYPE;
   v_res_type         f_request.res_type%TYPE;
   v_rqst_detail      f_request.rqst_detail%TYPE;
   v_cust_code        VARCHAR2(10);   
   v_cust_no          NUMBER(10, 0)  DEFAULT 0;
   v_s_idno           VARCHAR2(20);   
   v_cust_name        VARCHAR2(50);
   v_rep_name         VARCHAR2(50);
   v_kindtype         VARCHAR2(50);
   v_kinditem         VARCHAR2(50);
   v_bank_code        VARCHAR2(10);
   v_deposit          VARCHAR2(50);
   v_tel		          VARCHAR2(20);
   v_fax		          VARCHAR2(20);
   v_zip			       VARCHAR2(10);
   v_add		          VARCHAR2(100);
   v_vatcode          f_request.vatcode%TYPE;
   v_receipt_date     f_request.receipt_date%TYPE;
   v_rqst_date        f_request.rqst_date%TYPE;
   v_seq              f_request.seq%TYPE;
   UserErr         EXCEPTION;                  -- Select Data Not Found
	V_DATE			 DATE;
   C_CHK           VARCHAR2(1);
   C_CNT           NUMBER(10,3);
   C_WORK_NO       NUMBER(6,0);
	C_EVIDENCE_KIND VARCHAR2(3);
   C_SEQ           INTEGER        DEFAULT 0;
   v_temp1         INTEGER        DEFAULT 1000;
BEGIN
   BEGIN
		e_msg      := '공사관리 자동 전표 목록 시작! [Line No: 1]';
		-- 회사코드
      select a.comp_code  
        into v_company 
        from z_code_dept_title a,  
             z_code_dept b 
       where a.dept_seq_key = b.dept_seq_key 
         and b.dept_code = as_dept_code ; 
		if v_company is null then
			v_company := '1000' ;
		end if;
		v_nodecode := v_company ;

      select a.constkind_tag   
        into v_costkind 
        from z_code_dept  a 
       where a.dept_code = as_dept_code ; 
		if v_costkind is null then
			v_costkind := '1' ;
		end if;
		if v_costkind = '4' then
			v_costkind := '3' ;   -- 하자 현장은 일반관리비로 처리함
		end if;

		select long_name 
		  into v_dept_name
		  from z_code_dept 
		 where dept_code = as_dept_code ;

		OPEN	DETAIL_CUR;
		LOOP
			e_msg      := '전표 자료 FETCH ! [Line No: 1]';
			FETCH DETAIL_CUR INTO v_res_type,v_rqst_detail,v_s_idno,v_vatcode,v_receipt_date,v_rqst_date,v_seq ;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
			e_msg      := '전표 번호 찾기! [Line No: 1]';
			select max(data_no)
			  into C_SEQ
			  from dzais.autodocu 
	   	 where data_gubun = '51' 
            and write_date = adt_slip_date 
            and c_code     = v_company ; 
			if C_SEQ is null then
				C_SEQ := 0;
			END IF;
			C_SEQ := C_SEQ + 1;
			v_cust_code := null;
			IF v_s_idno is not null THEN
				e_msg      := '최종 전표 번호 찾기! [Line No: 1]';
				select count(*), MAX(cust_code), MAX(cust_name)  
              into C_CNT,    v_cust_code,    v_cust_name    
				  from base.trade 
		   	 where c_code = v_company 
               and s_idno = v_s_idno;
				if C_CNT is null then
					C_CNT := 0;
				END IF;
				IF C_CNT < 1 THEN
					e_msg      := '거래처코드가 없음! [Line No: 1] '  || v_s_idno ;
					select cust_name,   representative_name, kind_businesstype, business_condition, 
					       main_bank,   acc_number,   tel_number, fax_number, zip_number, addr 
                 into v_cust_name, v_rep_name,          v_kindtype,        v_kinditem,   
                      v_bank_code, v_deposit,    v_tel,      v_fax,      v_zip,      v_add  
					  from z_code_cust_code  
					 where cust_code = v_s_idno;  
					e_msg      := '거래처 최종 번호 찾기! [Line No: 1]';
					select to_number(MAX(cust_code))  
	              into v_cust_no    
					  from base.trade 
			   	 where c_code = v_company    
	               and cust_code < '090000' ;
	            if v_cust_no is null then
	            	v_cust_no := 100 ; 
	            end if;
	            v_cust_no := v_cust_no + 1;
	            v_cust_code := substr(to_char(v_cust_no, '000000'),2,6);
					e_msg      := '거래처 생성 실패! [Line No: -1]' || v_s_idno;

					insert into base.trade 
					          (c_code, cust_code, cust_name, cust_sort, cust_type, s_idno, dname, 
					           bank_code, deposit_no, tel_no, fax_no, s_address, uptae, jong, chan_amt, fg_use, dc_rmk,  
					          md_gubun, mm_rcp, dd_rcp, liquor) 
					   values (v_company, v_cust_code, v_cust_name, v_cust_name, '1', v_s_idno, v_rep_name, 
					           v_bank_code, v_deposit, v_tel,  v_fax,  v_add, v_kindtype, v_kinditem, 0,  0,    0,  
					           'Y',     0,      0,      '0' ) ;
				END IF; 
			END IF;	
-- 가전표_디테일을 입력한다 
		   e_msg      := '가전표 마스타 생성 실패! [Line No: 1]'|| C_SEQ || v_res_type;


			IF v_vatcode is null and v_cust_code is not null THEN
				Y_SP_F_SLIP_DETAIL1(v_nodecode, v_company,as_dept_code,v_costkind,v_dept_name, adt_from_date,adt_to_date,adt_slip_date, 
				           v_s_idno, v_cust_code,v_cust_name,v_res_type,as_process,C_SEQ, as_slip_name);
			END IF;
		   e_msg      := '가전표 마스타 생성 실패! [Line No: 2]' || C_SEQ;
			IF v_vatcode is null and v_cust_code is null THEN
				Y_SP_F_SLIP_DETAIL2(v_nodecode, v_company, as_dept_code,v_costkind,v_dept_name,adt_from_date,adt_to_date,adt_slip_date,v_res_type,
				                    as_process,C_SEQ, as_slip_name);
			END IF;
		   e_msg      := '가전표 마스타 생성 실패! [Line No: 3]';															   
			IF v_vatcode is not null and v_cust_code is not null THEN
				Y_SP_F_SLIP_DETAIL3(v_nodecode, v_company, as_dept_code,v_costkind,v_dept_name,v_rqst_date,v_seq,adt_slip_date, 
                               C_SEQ, v_cust_code,v_cust_name, as_slip_name);
			END IF;
		END LOOP;
		CLOSE DETAIL_CUR;
-- 외주 가전표 생성
		e_msg      := '가전표 마스타 생성 실패! [Line No: 4]';
		Y_SP_F_S_SLIP_DETAIL_S(v_nodecode, v_company, as_dept_code,v_costkind, v_dept_name, adt_from_date, adt_to_date, 
		                    adt_slip_date, as_process, as_slip_name);
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
END y_sp_f_s_slip_list;
/
