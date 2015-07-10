CREATE OR REPLACE PROCEDURE y_sp_h_lease_to_sale_cmpt(as_dept_code              IN   VARCHAR2,
																	  as_sell_code              IN   VARCHAR2,
																	  as_dongho                 IN   VARCHAR2,
																	  as_seq                    IN   INTEGER,
																	  as_recont_date            in   date,
																	  as_raise_amt              in   number,
																	  as_raise_cont_date        in   date,
																	  as_input_id               in   varchar2
																	  ) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
-- ���� ����
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
	err_num             integer;
-- User Define Error
   UserErr         EXCEPTION;
   C_CNT           NUMBER(10,0);
	rem_degree_code varchar2(2);
	rem_amt         NUMBER(18,0);
	C_LEASE_SUPPLY  NUMBER(18,0);
	C_LEASE_VAT     NUMBER(18,0);
	C_VAT_YN  VARCHAR2(1);
	C_DEGREE_CODE   VARCHAR2(2);
	C_AGREE_DATE    DATE;
	C_DAYS          NUMBER(10,0);
	C_SYSDATE       DATE;

BEGIN
   BEGIN
		select nvl(count(*), 0)
		  into C_CNT
		  from h_sale_agree
		 where dept_code = as_dept_code
		   and sell_code = as_sell_code
			and dongho    = as_dongho
			and seq       = as_seq
			and degree_code = '80';

      IF C_CNT > 0 THEN
			e_msg := as_dongho|| '���뿡 ������ �о���ȯ������ �����մϴ�. ó���Ұ�';
			Wk_errflag := -20010;
			GOTO EXIT_ROUTINE;
		END IF;


		INSERT INTO h_sale_agree ( DEPT_CODE, SELL_CODE, DONGHO,SEQ, DEGREE_CODE, AGREE_DATE,
                                   LAND_AMT, BUILD_AMT, VAT_AMT,SELL_AMT, F_PAY_YN, TOT_AMT,
                                   WORK_DATE, WORK_NO)
				 		VALUES (as_dept_code, as_sell_code, as_dongho, as_seq,
						 '80', as_raise_cont_date, 0,0,0, as_raise_amt, 'N', 0, '', 0);
		EXCEPTION
	      WHEN others THEN
	        IF SQL%NOTFOUND THEN
	           e_msg      := '(����)�о���ȯ���� ���� ����! [Line No: 2]';
	           Wk_errflag := -20020;
	           GOTO EXIT_ROUTINE;
	        END IF;
	END;

	BEGIN
      select degree_code --�о���ȯ���� ������ �ִ��� üũ
		  into C_DEGREE_CODE
		  from h_leas_lease_agree
		 where to_char(agree_date, 'yyyy.mm') = to_char(as_recont_date,'yyyy.mm')
		   and dept_code = as_dept_code
		   and sell_code = as_sell_code
			and dongho    = as_dongho
			and seq       = as_seq;

		IF C_DEGREE_CODE is not null THEN
		   select nvl(count(*), 0)
			  into C_CNT
			  from h_leas_lease_income
			 where dept_code = as_dept_code
			   and sell_code = as_sell_code
				and dongho    = as_dongho
				and seq       = as_seq
				and degree_code = C_DEGREE_CODE;
			IF C_CNT = 0 THEN                 --�ش������� ���Ա��� ������
				select case when agree.e_date = as_recont_date
			               then agree.lease_supply
					         else master.lease_supply * (as_recont_date - agree.s_date + 1) / to_number(decode(to_char(agree.s_date, 'mm'),to_char(as_recont_date, 'mm'),
							                                                                                                 to_number(to_char(last_day(agree.e_date),'dd')), 30) )
					    end ,
						 agree.agree_date,
						 (as_recont_date - agree.s_date + 1) ,
						 agree.vat_yn,
						 agree.degree_code
				  into C_LEASE_SUPPLY, C_AGREE_DATE, C_DAYS, C_VAT_YN, C_DEGREE_CODE
				  from h_leas_lease_agree agree,
				       h_sale_master master
			    where agree.dept_code = as_dept_code
			      and agree.sell_code = as_sell_code
				   and agree.dongho    = as_dongho
				   and agree.seq       = as_seq
				   and agree.degree_code = C_DEGREE_CODE
					and master.dept_code = agree.dept_code
					and master.sell_code = agree.sell_code
					and master.dongho    = agree.dongho
					and master.seq       = agree.seq;

				IF C_VAT_YN = 'Y' THEN
					C_LEASE_VAT := TRUNC(C_LEASE_SUPPLY*0.1,0);
				ELSE
					C_LEASE_VAT := 0 ;
				END IF;

				IF C_AGREE_DATE > as_recont_date THEN
					C_AGREE_DATE := as_recont_date;
				END IF;
            err_num := 100;
				update h_leas_lease_agree target --�о���ȯ�ϱ����� �Ӵ����� �ϼ���� UPDATE
				  set target.agree_date = C_AGREE_DATE,
				      target.e_date = as_recont_date,
				      target.days = C_DAYS,
						target.lease_amt = C_LEASE_SUPPLY + C_LEASE_VAT,
						target.lease_supply = C_LEASE_SUPPLY ,
						target.lease_vat = C_LEASE_VAT
				 where target.dept_code = as_dept_code
			      and target.sell_code = as_sell_code
				   and target.dongho    = as_dongho
				   and target.seq       = as_seq
				   and target.degree_code = C_DEGREE_CODE ;
			END IF;

		END IF;

		-- �о���ȯ�� ���������� �����߿��� ���Ա��� ���� ���������ؼ� ���� �Ѵ�
      err_num := 100;
	   delete h_leas_lease_agree target
		 where target.dept_code = as_dept_code
	      and target.sell_code = as_sell_code
		   and target.dongho    = as_dongho
		   and target.seq       = as_seq
		   and target.degree_code > C_DEGREE_CODE
			and not exists ( select *
			                   from h_leas_lease_income
									where dept_code = as_dept_code
								     and sell_code = as_sell_code
									  and dongho    = as_dongho
									  and seq       = as_seq
									  and degree_code = target.degree_code );
	   EXCEPTION
		   WHEN NO_DATA_FOUND THEN
		        GOTO sale_tag_update;
			WHEN others THEN
	        IF SQL%NOTFOUND THEN
	           e_msg      := '�Ӵ�� ���� -> �о���ȯ���� ���� �Ӵ���� �������� [Line No:'||err_num||']';
	           Wk_errflag := -20020;
	           GOTO EXIT_ROUTINE;
	        END IF;
	END;

	<<sale_tag_update>>
	BEGIN --�о���忡 ��౸��(�о�), �ξ���ȯ�±�(Y) UPDATE
	   update h_sale_master
		   set contract_code = '01',
			    lease_to_sale_tag = 'Y'
		 where dept_code = as_dept_code
	      and sell_code = as_sell_code
		   and dongho    = as_dongho
		   and seq       = as_seq;
	   EXCEPTION
	      WHEN others THEN
	        IF SQL%NOTFOUND THEN
	           e_msg      := '�о���� ������Ʈ ����[Line No: 5]';
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
       rollback;
       RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);
END y_sp_h_lease_to_sale_cmpt;
/

