CREATE OR REPLACE PROCEDURE y_sp_h_slip_list_ot01(as_dept_code    IN   VARCHAR2,
                                        		as_sell_code    IN   VARCHAR2,
                                        		adt_from_date   IN   DATE,
															adt_to_date     IN   DATE,
															as_dept         IN   VARCHAR2,
															as_slip_name    IN   VARCHAR2 ) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
		select a.sell_code,
		       a.dongho,
		       a.contract_code,
		       a.chg_date,
		       a.cust_code,
		       e.cust_name,
		       z.process_code,
		       nvl(b.sell_amt, 0)  sell_amt,
		       nvl(b.land_amt, 0)  land_amt,
		       nvl(b.build_amt, 0) build_amt,
		       nvl(b.vat_amt, 0)   vat_amt,
		       d.lease_deduct_amt,
		       d.loan_cap,
		       d.refund_amt,
		       nvl(c.r_amt, 0) r_amt,
		       (nvl(c.r_amt,0) - d.refund_amt - d.lease_deduct_amt - d.loan_cap) other_profit
		  from h_sale_master  a,
		       (select dongho, seq, sum(sell_amt) sell_amt, sum(land_amt) land_amt,
		                            sum(build_amt) build_amt, sum(vat_amt) vat_amt
                           from h_sale_agree
                          where dept_code = as_dept_code  and sell_code = as_sell_code
                            and agree_date <= adt_to_date
                          group by dongho, seq ) b,
		       (select dongho, seq, sum(r_amt) r_amt
                           from h_sale_income
                          where dept_code = as_dept_code and sell_code = as_sell_code and degree_code <> '99'
                          group by dongho, seq ) c,
		       h_sale_annul   d,
		       h_code_cust    e,
		       h_code_dept    z
		 where a.dept_code = z.dept_code
		   and a.dept_code = d.dept_code
		   and a.sell_code = d.sell_code
		   and a.dongho    = d.dongho
		   and a.seq       = d.seq
		   and a.dongho    = b.dongho(+)
		   and a.seq       = b.seq(+)
		   and a.dongho    = c.dongho(+)
		   and a.seq       = c.seq(+)
		   and a.cust_code = e.cust_code (+)
		   and a.dept_code = as_dept_code
		   and a.sell_code = as_sell_code
		   and a.chg_date  between  adt_from_date  and  adt_to_date
   ORDER BY  a.chg_date, a.dongho
;
-- ���� ����
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   v_dept_name        z_code_dept.long_name%TYPE;
   v_desc             VARCHAR2(100);
   v_sell_code        VARCHAR2(2);
   v_degree           VARCHAR2(2);
   v_dongho           VARCHAR2(10);
   v_dongho_tmp       VARCHAR2(10);
   v_contract_code    VARCHAR2(2);
   v_cust_code        VARCHAR2(15);
   v_cust_name        VARCHAR2(90);
   v_process_code     VARCHAR2(90);
   v_vatcode          VARCHAR2(2);
   v_pay_yn           VARCHAR2(2);
   v_occ_date         DATE;
   v_deptdetail_code  VARCHAR2(3);
   v_acnt_tmp1        VARCHAR2(10);
   v_acnt_tmp2        VARCHAR2(10);
   v_acntcode_01_1    VARCHAR2(10);
   v_acntcode_01_2    VARCHAR2(10);
   v_acntcode_02_1    VARCHAR2(10);
   v_acntcode_02_2    VARCHAR2(10);
   v_acntcode_02_3    VARCHAR2(10);
   v_acntcode_02_31   VARCHAR2(10);
   v_acntcode_02_4    VARCHAR2(10);
   v_acntcode_02_5    VARCHAR2(10);
   v_acntcode_02_6    VARCHAR2(10);
   v_acntcode_02_7    VARCHAR2(10);
   v_seq              NUMBER(10,0);
   v_amt              NUMBER(15,0);
   v_vat              NUMBER(15,0)   DEFAULT 0;
   v_vat_tmp          NUMBER(15,0)   DEFAULT 0;
   v_tot              NUMBER(15,0);
   v_sell             NUMBER(15,0);
   v_land             NUMBER(15,0);
   v_build            NUMBER(15,0);
   v_lease            NUMBER(15,0);
   v_loan             NUMBER(15,0);
   v_refund           NUMBER(15,0);
   v_r_amt            NUMBER(15,0);
   v_other            NUMBER(15,0);
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
		  and  CODE     = '05' ;       --   �о�̼���(����Ʈ) ����
		if v_acntcode_01_1 is null then
			e_msg := '�о�̼���(����Ʈ) ���� ���� ot01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_01_2
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '06' ;       --   �о�̼���(��) ����
		if v_acntcode_01_2 is null then
			e_msg := '�о�̼���(��) ���� ���� ot01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_02_1
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '11' ;        -- �о缱����(����Ʈ)  ����
		if v_acntcode_02_1 is null then
			e_msg := '�о缱����(����Ʈ) ���� ���� ot01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_02_2
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '12' ;        -- �о缱����(��) ����
		if v_acntcode_02_2 is null then
			e_msg := '�о缱����(��) ���� ���� ot01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_02_3
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '15' ;        -- �Ӵ뺸���� ����(�������� ����)
		if v_acntcode_02_3 is null then
			e_msg := '�Ӵ뺸���� ���� ���� ot01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
 		select substr(code_name, 1, 8)
		  into v_acntcode_02_31
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '15' ;        -- ǥ���Ӵ뺸���� ����(�ذ�����)   -----  �Ӵ뺸�������� ����
		if v_acntcode_02_31 is null then
			e_msg := 'ǥ���Ӵ뺸���� ���� ���� ot01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_02_4
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '23' ;        -- �����޹̿�(�ؾ��) ����
		if v_acntcode_02_4 is null then
			e_msg := '�����޹̿�(�ؾ��) ���� ���� ot01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_02_5
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '88' ;        -- ������(�����) ����
		if v_acntcode_02_5 is null then
			e_msg := '������(�����) ���� ���� ot01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_02_6
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '80' ;        -- �ܱ�뿩��(��Ÿ) ����
		if v_acntcode_02_6 is null then
			e_msg := '�ܱ�뿩��(��Ÿ) ���� ���� ot01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
		select substr(code_name, 1, 8)
		  into v_acntcode_02_7
		  from h_code_common
		 where code_div = '25'
		  and  CODE     = '03' ;        -- �Ӵ�̼��� ����
		if v_acntcode_02_7 is null then
			e_msg := '�Ӵ�̼��� ���� ���� ot01';
			Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      end if;
      v_w_cnt := 999;    -- ��ǥ write  �Ǽ��� 99 ���� ������ ���ο� ��ǥ�� �����.
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO v_sell_code, v_dongho, v_contract_code, v_occ_date,
	                      v_cust_code, v_cust_name, v_process_code,
	                      v_sell, v_land, v_build, v_vat_tmp, v_lease, v_loan, v_refund, v_r_amt, v_other;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
			IF v_cust_code is not null THEN
				select COUNT(*)
				  into C_CNT
				  from sm_code_cust
				 where cust_code = v_cust_code;
				IF C_CNT < 1 THEN
					e_msg      := '�ŷ�ó ���� ����! ot01 [Line No: -3]' || v_cust_code;
						INSERT INTO ERPC.SM_CODE_CUST
						  SELECT CUST_CODE,'Y','Y',decode(CUST_DIV, '01', '002', '02', '001', '099'),CUST_NAME,CUST_NAME,'','','',
									'','','',HOME_PHONE,'',CONTRACT_ZIP_CODE, CONTRACT_ADDR1,
									'','','',sysdate,'',null
							 FROM H_CODE_CUST
							WHERE CUST_CODE = v_cust_code ;
				END IF;
			END IF;
			-- ��ǥ insert �Ǽ��� 99 �� ������ ���ο� ��ǥ�� �����.
			IF v_w_cnt > 99 THEN
					v_w_cnt  := 0;
					C_DT_SEQ := 0;
					select COUNT(*)
					  into C_CNT
					  from am_work_workno
		 		    where work_date = v_occ_date;
					IF C_CNT < 1 THEN
					   e_msg      := '��ǥ��ȣ ���� ����! ot01 [Line No: -1]';
						INSERT INTO ERPC.AM_WORK_WORKNO
						VALUES ( v_occ_date,1 )  ;
						C_SEQ := 1;
					ELSE
						select work_no_last
						  into C_SEQ
						  from am_work_workno
				   	 where work_date = v_occ_date;
						C_SEQ := C_SEQ + 1;
					   e_msg      := '��ǥ��ȣ ���� ����! ot01 [Line No: -2]';
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
				   e_msg      := '����ǥ ����Ÿ ���� ����! ot01 [Line No: 3]';
					INSERT INTO ERPC.AM_WORK_MASTER
					VALUES ( v_occ_date,C_SEQ,C_START_SEQ,'01',as_dept,C_KIND_CODE,'003',as_slip_name,sysdate,'01',v_cust_code,
								v_occ_date,C_EVIDENCE_KIND,null,'N',null,null,'N',null,null,'N',null,null,null,null,null,null,'N',null,null )  ;
			END IF;
-- ����ǥ_�������� �Է��Ѵ�
			v_dongho_tmp := substr(v_dongho, 1, 4) || '-' || substr(v_dongho, 5, 4);
			v_desc := '�ؾ�-' || v_dongho_tmp || ' ' || v_cust_name ;
			-- ���� ����(�Ӵ�� ���� ����)
			if v_contract_code <> '02' then
				if v_sell_code = '03' then
					v_acnt_tmp1 := v_acntcode_01_2;  -- �о�̼���(��)
				else
					v_acnt_tmp1 := v_acntcode_01_1;  -- �о�̼���(����Ʈ)
				end if;
	         v_amt := v_sell * (-1) ;    -- minus ó��
	         v_vat := 0 ;
				v_tot := v_amt ;
			   e_msg      := '����ǥ ������ ���� ����! ot01 [Line No: 5]'|| C_SEQ || ' 1';
				C_DT_SEQ := C_DT_SEQ + 1;
				v_w_cnt  := v_w_cnt + 1;
				-- ����
				INSERT INTO erpc.AM_WORK_DETAIL
				VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
						 v_acnt_tmp1,v_acnt_tmp1,v_tot,0,v_amt,0,0,0,v_desc,v_desc,
						 '01',v_cust_code,null,v_occ_date,null,null,null,null,null,null,null,null,null,null,null,null,null,
						 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,v_dongho_tmp,null,null,null,null,
						 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ;
			end if;
			-- �뺯 ����
			-- �о缱����, �ΰ��������� ó��
			if v_contract_code <> '02' then
				if v_sell_code = '03' then
					v_acnt_tmp2 := v_acntcode_02_2;  -- �о缱����(��)
				else
					v_acnt_tmp2 := v_acntcode_02_1;  -- �о缱����(����Ʈ)
				end if;
				-- �ΰ��� �ִ� ���
				if v_vat_tmp <> 0 then
					-- ������
		         v_amt := v_land * (-1) ;
					v_vat := 0;
					v_tot := v_amt ;
				   e_msg      := '����ǥ ������ ���� ����! ot01 [Line No: 6]'|| C_SEQ || ' 1';
					C_DT_SEQ := C_DT_SEQ + 1;
					v_w_cnt  := v_w_cnt + 1;
					v_vatcode := 'K1';
					-- �뺯
					INSERT INTO erpc.AM_WORK_DETAIL
					VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
							 v_acnt_tmp2,v_acnt_tmp2,0,0,0,v_tot,0,v_amt,v_desc,v_desc,
							 '01',v_cust_code,v_vatcode,v_occ_date,null,null,null,null,null,null,null,null,null,null,null,null,null,
							 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,v_dongho_tmp,null,null,null,null,
							 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ;
				-- �ǹ���
		         v_amt := v_build   * (-1) ;
		         v_vat := v_vat_tmp * (-1) ;
					v_tot := v_amt + v_vat ;
				   e_msg      := '����ǥ ������ ���� ����! ot01 [Line No: 6]'|| C_SEQ || ' 1';
					C_DT_SEQ := C_DT_SEQ + 1;
					v_w_cnt  := v_w_cnt + 1;
					v_vatcode := '11';
					-- �뺯
					INSERT INTO erpc.AM_WORK_DETAIL
					VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
							 v_acnt_tmp2,v_acnt_tmp2,0,0,0,v_tot,v_vat,v_amt,v_desc,v_desc,
							 '01',v_cust_code,v_vatcode,v_occ_date,null,null,null,null,null,null,null,null,null,null,null,null,null,
							 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,v_dongho_tmp,null,null,null,null,
							 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ;
				-- �ΰ��� ���� ���
				else
		         v_amt := v_sell * (-1) ;
		         v_vat := 0 ;
					v_tot := v_amt + v_vat ;
				   e_msg      := '����ǥ ������ ���� ����! ot01 [Line No: 7]'|| C_SEQ || ' 1';
					C_DT_SEQ := C_DT_SEQ + 1;
					v_w_cnt  := v_w_cnt + 1;
					v_vatcode := null ;
					-- �뺯
					INSERT INTO erpc.AM_WORK_DETAIL
					VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
							 v_acnt_tmp2,v_acnt_tmp2,0,0,0,v_tot,0,v_amt,v_desc,v_desc,
							 '01',v_cust_code,v_vatcode,v_occ_date,null,null,null,null,null,null,null,null,null,null,null,null,null,
							 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,v_dongho_tmp,null,null,null,null,
							 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ;
				end if;
			end if;
			if v_contract_code = '02' then
				if v_process_code = '01' then
					v_acnt_tmp2 := v_acntcode_02_3;      -- �Ӵ뼱����
				else
					v_acnt_tmp2 := v_acntcode_02_31;     -- ǥ���Ӵ뺸����
				end if;
			else
				if v_sell_code = '03' then
					v_acnt_tmp2 := v_acntcode_01_2;  -- �о�̼���(��)
				else
					v_acnt_tmp2 := v_acntcode_01_1;  -- �о�̼���(����Ʈ)
				end if;
			end if;
         v_amt := v_r_amt * (-1) ;
			v_vat := 0;
			v_tot := v_amt;
		   e_msg      := '����ǥ ������ ���� ����! ot01 [Line No: 8]'|| C_SEQ || ' 1';
			C_DT_SEQ := C_DT_SEQ + 1;
			v_w_cnt  := v_w_cnt + 1;
			INSERT INTO erpc.AM_WORK_DETAIL
			VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
					 v_acnt_tmp2,v_acnt_tmp2,0,0,0,v_tot,0,v_amt,v_desc,v_desc,
					 '01',v_cust_code,null,v_occ_date,null,null,null,null,null,null,null,null,null,null,null,null,null,
					 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,v_dongho_tmp,null,null,null,null,
					 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ;
			-- �����޺��(�ؾ��) ó��
			if v_refund <> 0 then
				v_acnt_tmp2 := v_acntcode_02_4;     -- �����޺��(�ؾ��)
	         v_amt := v_refund ;
				v_vat := 0;
				v_tot := v_amt;
			   e_msg      := '����ǥ ������ ���� ����! ot01 [Line No: 9]'|| C_SEQ || ' 1';
				C_DT_SEQ := C_DT_SEQ + 1;
				v_w_cnt  := v_w_cnt + 1;
				INSERT INTO erpc.AM_WORK_DETAIL
				VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
						 v_acnt_tmp2,v_acnt_tmp2,0,0,0,v_tot,0,v_amt,v_desc,v_desc,
						 '01',v_cust_code,null,v_occ_date,null,null,null,null,null,null,null,null,null,null,null,null,null,
						 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,v_dongho_tmp,null,null,null,null,
						 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ;
			end if;
			-- ������(�����) ó��
			if v_other <> 0 then
				v_acnt_tmp2 := v_acntcode_02_5;     -- ������(�����)
	         v_amt := v_other ;
				v_vat := 0;
				v_tot := v_amt;
			   e_msg      := '����ǥ ������ ���� ����! ot01 [Line No: 11]'|| C_SEQ || ' 1';
				C_DT_SEQ := C_DT_SEQ + 1;
				v_w_cnt  := v_w_cnt + 1;
				INSERT INTO erpc.AM_WORK_DETAIL
				VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
						 v_acnt_tmp2,v_acnt_tmp2,0,0,0,v_tot,0,v_amt,v_desc,v_desc,
						 '01',v_cust_code,null,v_occ_date,null,null,null,null,null,null,null,null,null,null,null,null,null,
						 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,v_dongho_tmp,null,null,null,null,
						 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ;
			end if;
			-- �ܱ�뿩��  : �뿩�� ���� ó��
			if v_loan <> 0 then
				v_acnt_tmp2 := v_acntcode_02_6;     -- �ܱ�뿩��
	         v_amt := v_loan ;
				v_vat := 0;
				v_tot := v_amt;
			   e_msg      := '����ǥ ������ ���� ����! ot01 [Line No: 12]'|| C_SEQ || ' 1';
				C_DT_SEQ := C_DT_SEQ + 1;
				v_w_cnt  := v_w_cnt + 1;
				INSERT INTO erpc.AM_WORK_DETAIL
				VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
						 v_acnt_tmp2,v_acnt_tmp2,0,0,0,v_tot,0,v_amt,v_desc,v_desc,
						 '01',v_cust_code,null,v_occ_date,null,null,null,null,null,null,null,null,null,null,null,null,null,
						 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,null,null,null,null,null,
						 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ;
			end if;
			-- �Ӵ�̼���  : �Ӵ�� ���� ó��
			if v_lease <> 0 then
				v_acnt_tmp2 := v_acntcode_02_7;     -- �Ӵ�̼���
	         v_amt := v_lease ;
				v_vat := 0;
				v_tot := v_amt;
			   e_msg      := '����ǥ ������ ���� ����! ot01 [Line No: 12]'|| C_SEQ || ' 1';
				C_DT_SEQ := C_DT_SEQ + 1;
				v_w_cnt  := v_w_cnt + 1;
				INSERT INTO erpc.AM_WORK_DETAIL
				VALUES ( v_occ_date,C_SEQ,C_DT_SEQ,C_DT_SEQ,as_dept,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,
						 v_acnt_tmp2,v_acnt_tmp2,0,0,0,v_tot,0,v_amt,v_desc,v_desc,
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
END y_sp_h_slip_list_ot01;
/

