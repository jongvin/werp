/* ============================================================================= */
/* 함수명 : y_sp_m_output_sale                                                   */
/* 기  능 : 자재매각전표발행한다. 			                                     */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code   (string)                   */
/*        : 매각일자               ==> as_yymmdd      (date)                     */
/*        : 일련번호               ==> as_seq         (INTEGER)                  */
/*        : 전표결재번호           ==> ai_unq_num     (NUMBER)                   */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 이경일                                                               */
/* 작성일 : 2005.10.18                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_m_output_sale (
	as_dept_code IN   VARCHAR2,
	as_yymmdd    IN   DATE ,
	as_seq       IN   INTEGER,
	ai_unq_num   IN   NUMBER ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 전표발행 대상 커서
CURSOR DETAIL_CUR IS
    SELECT
		B.SALE_AMT,B.SALE_VAT,B.RQST_DATE,
		decode(lengthb(b.cust_code),13,
			substrb(b.cust_code,1,6) || '-' || substrb(b.cust_code,7,7),
			substrb(b.cust_code,1,3) || '-' || substrb(b.cust_code,4,2) || '-' || substrb(b.cust_code,6,5)),
		B.cust_code,
		B.CUST_NAME,
    	(
        SELECT SUM(AMT) AMT FROM M_OUTPUT_DETAIL
        WHERE
        	DEPT_CODE = as_dept_code
        AND YYMMDD = as_yymmdd
        AND SEQ = as_seq
    	) AMT,
		nvl(B.SLIP_SPEC_UNQ_NUM,0)
    FROM
    	M_OUTPUT A,
    	M_OUTPUT_SALE B,
		efin_invoice_header_itf D
    WHERE
    	A.DEPT_CODE = B.DEPT_CODE AND A.YYMMDD = B.YYMMDD AND A.SEQ = B.SEQ
	AND B.invoice_num = D.invoice_group_id (+)
    AND A.DEPT_CODE = as_dept_code
    AND A.YYMMDD = as_yymmdd
    AND A.SEQ = as_seq
	AND decode(D.complete_flag,null,'Y',decode(D.complete_flag,'3','Y',decode(D.complete_flag,'9',decode(D.relation_invoice_group_id,null,'N','Y'),'N'))) = 'Y';
-- 공통 변수
Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
e_msg               VARCHAR2(100);
UserErr             EXCEPTION;                  -- Select Data Not Found

CHK_CUNT            INTEGER;                    -- 자료를 가지고 왔는지 체크한다
DATA_CUNT           INTEGER;                    -- 전표발행 자료여부 체크

V_SALE_AMT          NUMBER(10,0);
V_SALE_VAT          NUMBER(10,0);
V_RQST_DATE         DATE;
V_CUST_CODE         VARCHAR2(20);
V_REAL_CUST_CODE    VARCHAR2(20);
V_SBCR_NAME         VARCHAR2(50);
V_AMT               NUMBER(13,0);
V_RST_AMT           NUMBER(13,0);
V_SPEC_UNQ          INTEGER;

C_COMP_CODE         VARCHAR2(10);
C_DEPT_NAME         VARCHAR2(50);
C_PROJ              VARCHAR2(10);
C_ORG_ID            VARCHAR2(10);
C_GROUP_ID          INTEGER;
C_BANK_FOLDER       VARCHAR2(10);
C_ACNTCODE          VARCHAR2(10);
C_VATNAME           VARCHAR2(50);
C_TAX_SEQ           INTEGER;	
C_TAX_TAG           VARCHAR2(1);
C_TAX_CNT           NUMBER(20,5);
C_FOLDER_ID         VARCHAR2(10);
C_VATCODE           VARCHAR2(8);

BEGIN
	BEGIN

	-- 현장별 사업장코드를 가지고 온다
    select comp_code ,long_name into C_COMP_CODE,C_DEPT_NAME
    from z_code_dept where dept_code = as_dept_code;
	-- 현장별프로젝트코드를 구한다.
    select a.proj_code
    into C_PROJ
    from ( select a.dept_code,c.proj_code
    		 from  z_code_dept a,
    		  ( select proj_unq_key,step     
    				from r_proj_view_business_form) b,
    			r_proj c
       where a.proj_unq_key = b.proj_unq_key
    	  and b.proj_unq_key = c.proj_unq_key
    	  and b.step = c.step ) a
    where a.dept_code =  as_dept_code;  
    SELECT attribute1
    INTO C_ORG_ID
    FROM efin_corporations_v
    WHERE corporation_code = C_COMP_CODE;
	-- 전표 마스터번호를 구한다.
	select efin_invoice_header_itf_s.nextval
    into C_GROUP_ID
    from dual;
	-- 은행계좌폴더를 가져온다.
 	select folder_id,nvl(count(*),0)
	  into C_BANK_FOLDER, CHK_CUNT
	  from f_dept_account
	 where dept_code = as_dept_code
	group by folder_id;
	IF CHK_CUNT <> 1 THEN
		e_msg      := '현장 전도금 계좌를 등록 하세요! [Line No: 159]';
        Wk_errflag := -20020;
        GOTO EXIT_ROUTINE;
	END IF;
	IF C_BANK_FOLDER IS NULL THEN
		C_BANK_FOLDER := C_COMP_CODE || '99999';
	END IF;
	-- 결재선 정보를 저장한다.
	y_sp_d_efin_invoice_copy(C_GROUP_ID,ai_unq_num,'A',last_day(as_yymmdd));
	DATA_CUNT := 0;

	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_SALE_AMT,V_SALE_VAT,V_RQST_DATE,V_CUST_CODE,V_REAL_CUST_CODE,V_SBCR_NAME,V_AMT,V_SPEC_UNQ;
		EXIT WHEN DETAIL_CUR%NOTFOUND;
		DATA_CUNT := DATA_CUNT + 1;
		--거래처 존재 여부 체크
		IF F_COMM_SLIP_CHECK_CUSTOMER(C_ORG_ID,V_CUST_CODE) = False THEN
			e_msg      := C_ORG_ID || ' ' || V_CUST_CODE || ' 거래처가 존재 하지 않습니다! [Line No: 159]';
        	Wk_errflag := -20020;
	        GOTO EXIT_ROUTINE;
		END IF;
	
		--거래처 존재 여부 체크
		IF V_AMT < 0 Or V_SALE_AMT <= 0 Or V_SALE_VAT <= 0 THEN
			e_msg      := '잔존 금액이 존재 하지 않습니다! [Line No: 159]';
        	Wk_errflag := -20020;
	        GOTO EXIT_ROUTINE;
		END IF;

		-- 115351 (가설재)
		-- 211719 (매출과세(기타))
		-- 462519 (잡이익(기타))
		-- 472511 (잡손실)
		-- 111114 (전도금(예금통장))
		C_FOLDER_ID := C_COMP_CODE || '99999';
		select account_code,tax_code_name_alt,tax_id,nvl(count(*),0)
    	into C_ACNTCODE,C_VATNAME,C_VATCODE, CHK_CUNT
    	from efin_tax_codes_v
    	where org_code = C_COMP_CODE
    		and account_code = '211719'
		GROUP BY account_code,tax_code_name_alt,tax_id;
		IF CHK_CUNT <> 1 THEN
			e_msg      := '현장 부가세 코드가 존재하지 않습니다! [Line No: 159]';
	        Wk_errflag := -20020;
    	    GOTO EXIT_ROUTINE;
		END IF;
		select gl_je_lines_s.nextval -- 부가세연결고리를 만든다
    	into C_TAX_SEQ
    	from dual;
    	C_TAX_TAG := 'T';
    	C_TAX_CNT := 1;
        V_RST_AMT := V_SALE_AMT + V_SALE_VAT; --대상금액
        -- 전도금계정입력(차)
        y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' 수입금',last_day(as_yymmdd),V_RQST_DATE,
        								  V_SBCR_NAME,V_CUST_CODE,V_RST_AMT,'','',as_dept_code,
        								  C_PROJ,'','111114','수입금','자재','','',
        								  C_BANK_FOLDER,'',C_ORG_ID,C_DEPT_NAME,C_DEPT_NAME || ' 가설재매각','C');
		IF V_AMT > 0 THEN
			-- 잔존가가 존재하는 경우
	        -- 가설재계정입력(대) (공급가)
    	    y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' 수입금',last_day(as_yymmdd),V_RQST_DATE,
        								  V_SBCR_NAME,V_CUST_CODE,'',V_SALE_AMT,C_VATNAME,as_dept_code,
        								  C_PROJ,C_TAX_CNT,'115351','수입금','자재',C_TAX_SEQ,C_TAX_TAG,
        								  C_FOLDER_ID,'',C_ORG_ID,C_DEPT_NAME,C_DEPT_NAME || ' 가설재매각','C');
		END IF;
		IF V_AMT = 0 THEN
			-- 잔존가가 존재하는 않는 경우
			-- 잡이익계정입력(대) (공급가)
			y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' 수입금',last_day(as_yymmdd),V_RQST_DATE,
        								  V_SBCR_NAME,V_CUST_CODE,'',V_SALE_AMT,C_VATNAME,as_dept_code,
        								  C_PROJ,C_TAX_CNT,'462519','수입금','자재',C_TAX_SEQ,C_TAX_TAG,
        								  C_FOLDER_ID,'',C_ORG_ID,C_DEPT_NAME,C_DEPT_NAME || ' 가설재매각','C');
		END IF;
        -- 부가세계정입력(대)  (부가세)
        y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' 수입금',last_day(as_yymmdd),V_RQST_DATE,
        							 	  V_SBCR_NAME,V_CUST_CODE,'',V_SALE_VAT,'',as_dept_code,
        								  C_PROJ,'','211719','수입금','자재',C_TAX_SEQ,C_TAX_TAG,
        								  C_FOLDER_ID,'',C_ORG_ID,C_DEPT_NAME,C_DEPT_NAME || ' 가설재매각','C');
		IF V_SALE_AMT > V_AMT THEN
			-- 잡이익 추가
			-- 잡이익계정입력(대)
			V_RST_AMT := V_SALE_AMT - V_AMT; --잡이익 대상금액
        	y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' 수입금',last_day(as_yymmdd),V_RQST_DATE,
        								  V_SBCR_NAME,V_CUST_CODE,'',V_RST_AMT,'',as_dept_code,
        								  C_PROJ,'','462519','수입금','자재','','',
        								  C_FOLDER_ID,'',C_ORG_ID,C_DEPT_NAME,C_DEPT_NAME || ' 가설재매각','C');
			-- 가설재계정입력(대)
			V_RST_AMT := V_RST_AMT * -1;
	        y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' 수입금',last_day(as_yymmdd),V_RQST_DATE,
        								  V_SBCR_NAME,V_CUST_CODE,'',V_RST_AMT,'',as_dept_code,
        								  C_PROJ,'','115351','수입금','자재','','',
        								  C_FOLDER_ID,'',C_ORG_ID,C_DEPT_NAME,C_DEPT_NAME || ' 가설재매각','C');
		END IF;

		IF V_SALE_AMT < V_AMT THEN
			-- 잡손실 추가
			-- 잡손실계정입력(차)
			V_RST_AMT := V_AMT - V_SALE_AMT; --잡손실 대상금액
        	y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' 수입금',last_day(as_yymmdd),V_RQST_DATE,
        								  V_SBCR_NAME,V_CUST_CODE,V_RST_AMT,'','',as_dept_code,
        								  C_PROJ,'','472511','수입금','자재','','',
        								  C_FOLDER_ID,'',C_ORG_ID,C_DEPT_NAME,C_DEPT_NAME || ' 가설재매각','C');
			-- 가설재계정입력(대)
	        y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' 수입금',last_day(as_yymmdd),V_RQST_DATE,
        								  V_SBCR_NAME,V_CUST_CODE,'',V_RST_AMT,'',as_dept_code,
        								  C_PROJ,'','115351','수입금','자재','','',
        								  C_FOLDER_ID,'',C_ORG_ID,C_DEPT_NAME,C_DEPT_NAME || ' 가설재매각','C');
		END IF;
	END LOOP;
	CLOSE DETAIL_CUR;

	IF DATA_CUNT = 0 THEN
		e_msg      := '전표 발행 대상이 존재하지 않습니다.! [Line No: 159]';
		Wk_errflag := -20020;
		GOTO EXIT_ROUTINE;
	END IF;

	-- 기존 수입금 입력 내용 삭제
	IF V_SPEC_UNQ <> 0 THEN
		DELETE FROM F_PROFIT_DETAIL WHERE DEPT_CODE = as_dept_code 
									AND INST_DATE = as_yymmdd AND SLIP_SPEC_UNQ_NUM = V_SPEC_UNQ;
	END IF;
	-- 수입금 쪽에 입력해 준다
	-- 반송시에도 수정할수 없게 하기 위해 INVOICE_NUM 1 로 입력함
	Select f_spec_unq_num.nextval into V_SPEC_UNQ from dual;
	INSERT INTO F_PROFIT_DETAIL
		(DEPT_CODE,INST_DATE,SLIP_SPEC_UNQ_NUM,RQST_DATE,CONT,ACNTCODE,AMT,VAT,CUST_CODE,CUST_NAME,VATCODE,INVOICE_NUM) VALUES
		(as_dept_code,as_yymmdd,V_SPEC_UNQ,V_RQST_DATE,'가설재매각금액','462513',V_SALE_AMT,V_SALE_VAT,V_REAL_CUST_CODE,V_SBCR_NAME,C_VATCODE,1);

	UPDATE M_OUTPUT_SALE SET INVOICE_NUM = C_GROUP_ID, SLIP_SPEC_UNQ_NUM = V_SPEC_UNQ
    WHERE DEPT_CODE = as_dept_code AND YYMMDD = as_yymmdd AND SEQ = as_seq;

	UPDATE M_OUTPUT SET trans_tag = ''
    WHERE DEPT_CODE = as_dept_code AND YYMMDD = as_yymmdd AND SEQ = as_seq;

	-- 배치화일을 Update 한다.
	y_sp_comm_slip_batch_flag(C_ORG_ID,'Journal');

	EXCEPTION
		WHEN others THEN
			IF SQL%NOTFOUND THEN
				e_msg      := '매각전표생성 실패! [Line No: 159]';
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
	WHEN UserErr THEN
		RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);
END y_sp_m_output_sale;
