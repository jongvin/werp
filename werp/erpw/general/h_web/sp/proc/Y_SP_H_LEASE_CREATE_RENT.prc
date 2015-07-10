CREATE OR REPLACE PROCEDURE y_sp_h_lease_create_rent(as_dept_code     IN   VARCHAR2,
                                                  as_sell_code     IN   VARCHAR2,
																  as_workym        IN   VARCHAR2,
																  as_month_code  IN   VARCHAR2,
																  as_day_code    IN   VARCHAR2,
																  as_day         IN   VARCHAR2) IS


-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
CURSOR MASTER_CUR (as_calc_rent_from date) IS
SELECT cont_date, 
		 cont_seq
  from h_lease_master m
 where m.dept_code = as_dept_code
   and m.sell_code = as_sell_code
	and ((to_char(m.exp_date,'yyyy.mm') >= as_workym ) or (exp_tag = 'N'))
	and exists(select dept_code  --�Ӵ�Ⱓ�� �������� �� �վ����
	             from h_lease_rent_detail
					where apply_date <= as_calc_rent_from
					  and m.dept_code = dept_code
					  and m.sell_code = sell_code
					  and m.cont_date = cont_date
					  and m.cont_seq  = cont_seq)
	and exists(select dept_code
	             from h_lease_detail --�Ӵ������ �Ӵ�ᰡ ��� ���־���� 
					where m.dept_code = dept_code
					  and m.sell_code = sell_code
					  and m.cont_date = cont_date
					  and m.cont_seq  = cont_seq)
	and not exists (select dept_code   --�ΰ����� �߻��� �Ӵ�ᰡ �������(�̹̺ΰ��ȼ�������)
	                  from h_lease_rent_agree
						  where to_char(s_date,'yyyy.mm') = as_workym
						    and m.dept_code = dept_code
							 and m.sell_code = sell_code
							 and m.cont_date = cont_date
							 and m.cont_seq  = cont_seq);

-- ���� ����
   C_CNT               INTEGER;
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   c_temp_date      date;
	c_temp_date1      date;
   c_cont_date      H_lease_master.cont_date%TYPE; 
   c_cont_seq       H_lease_master.cont_seq%TYPE;
	c_cont_num       H_lease_master.cont_num%TYPE;
	c_apply_date     h_lease_rent_detail.apply_date%type;
	c_rent_amt       h_lease_rent_detail.rent_amt%type;
	c_rent_vat       h_lease_rent_detail.rent_vat%type;
	c_degree_code    h_lease_rent_agree.degree_code%type;
	c_agree_date     h_lease_rent_agree.agree_date%type;
	c_days           h_lease_rent_agree.days%type;
	c_days_inmonth   h_lease_rent_agree.days%type;
	c_vat_yn         h_lease_rent_agree.vat_yn%type;
	c_calc_rent_supply    h_lease_rent_agree.rent_supply%type;
	c_calc_rent_vat    h_lease_rent_agree.rent_vat%type;
	c_calc_rent_from date;
	c_calc_rent_to   date;
	sql_stmt            VARCHAR2(100);
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
	BEGIN
	  
	  --�������� ������ ���ϱ�
	  c_calc_rent_from := to_date(as_workym||'.01');
	  c_calc_rent_to   := last_day(to_date(as_workym||'.01'));
	  
	  --�������� ���ϱ� as_month_code:1-���  as_day_code: 1-������  as_day: 1~31 
	  --                              2-�Ϳ�               2-����
	  if as_month_code = '2' then 
	     c_agree_date := add_months(to_date(as_workym||'.01'), 1);  -- ��+1
	  else if as_month_code = '1' then
		  	    c_agree_date := to_date(as_workym||'.01');
		    end if;   
     end if;
	  
	  if as_day_code = '1' then
	     c_agree_date := to_date(to_char(c_agree_date,'yyyy.mm.')||trim(as_day));
	  else if as_day_code = '2' then
		  	    c_agree_date := last_day(c_agree_date);
		    end if;
	  end if;
		
	  	   
     OPEN	MASTER_CUR(c_calc_rent_from);
		
	  LOOP
		 FETCH MASTER_CUR INTO c_cont_date, c_cont_seq;
		 EXIT WHEN MASTER_CUR%NOTFOUND;
       	  
		 --�Ӵ������ �Ӵ�ᰡ ��� ���մ��� üũ  
		 select apply_date,rent_amt, rent_vat
		   into c_apply_date, c_rent_amt, c_rent_vat
		   from h_lease_rent_detail
		  where dept_code = as_dept_code and
		        sell_code = as_sell_code and 
				  cont_date = c_cont_date and
				  cont_seq  = c_cont_seq  and
		        apply_date <= c_calc_rent_from and
				  apply_date = (select max(apply_date)
				                  from h_lease_rent_detail
									  where dept_code = as_dept_code
										 and sell_code = as_sell_code
										 and cont_date = c_cont_date
										 and cont_seq  = c_cont_seq
										 and apply_date <= c_calc_rent_from );
		 
		 if not(c_rent_amt > 0) then
		 	 goto LOOP_NEXT;
		 end if;
		 
		 -- �����ϱ��ϱ� (�ΰ����� �Ӵ������ �� üũ )
		 begin
			 select lease_s_date  
			   into c_temp_date
			   from h_lease_detail
			  where --lease_s_date > c_calc_rent_from
			        dept_code = as_dept_code
				 and sell_code = as_sell_code
				 and cont_date = c_cont_date
				 and cont_seq  = c_cont_seq
				 and chg_seq = (select min(chg_seq)
				                  from h_lease_detail
									  where dept_code = as_dept_code
										 and sell_code = as_sell_code
										 and cont_date = c_cont_date
										 and cont_seq  = c_cont_seq);
			 if c_temp_date > c_calc_rent_from then --�Ӵ�������� �ΰ��������Ϻ��� ũ��   
				 c_calc_rent_from := c_temp_date;    --�Ӵ�����Ϻ��� �ϼ����
			 end if;
		 EXCEPTION
          WHEN NO_DATA_FOUND THEN
			   c_calc_rent_from := c_calc_rent_from; 
			   
		 END;
		
		-- �����ϱ��ϱ� (�ΰ����� �ؾ����� üũ )
		 BEGIN
		    select exp_date
			   into c_temp_date1
			   from h_lease_master
			  where exp_tag = 'Y'
			    and dept_code = as_dept_code
				 and sell_code = as_sell_code
				 and cont_date = c_cont_date
				 and cont_seq  = c_cont_seq;
			 if c_temp_date1 < c_calc_rent_to then --�ؾ����� �ΰ��������Ϻ��� ������   
				 c_calc_rent_to := c_temp_date1;    --�ؾ��ϱ��� �ϼ����
		    end if;
		 EXCEPTION
          WHEN NO_DATA_FOUND THEN
			   c_calc_rent_to := c_calc_rent_to; 
			 
		 END;
		
		 --�Ӵ�� ��� 
		 c_days := c_calc_rent_to - c_calc_rent_from + 1;
		
		 c_days_inmonth := to_number(to_char(last_day(to_date(as_workym||'.01')),'dd'));
		
		 if c_days_inmonth = 0 then
		    return;
		 end if;
		
		 c_calc_rent_supply := trunc(c_rent_amt * ( c_days/c_days_inmonth), 0);
		 if c_rent_vat > 0 then
		    c_calc_rent_vat    := trunc(c_rent_vat * ( c_days/c_days_inmonth), 0);
			 c_vat_yn := 'Y';
		 else
		    c_calc_rent_vat    := 0;
			 c_vat_yn := 'N';
		 end if;
		
		 --max�����������ϱ�
		 select decode(max(degree_code), null, 1, max(degree_code)+1) 
		   into c_degree_code
		   from h_lease_rent_agree
		  where dept_code = as_dept_code
			 and sell_code = as_sell_code
			 and cont_date = c_cont_date
			 and cont_seq  = c_cont_seq; 
		 
		 --�۾��� �Ӵ�����ΰ� insert
		 insert into h_lease_rent_agree
		   values( as_dept_code, as_sell_code, c_cont_date, c_cont_seq, c_degree_code, c_agree_date, 
			        c_calc_rent_from, c_calc_rent_to, c_days, c_calc_rent_supply+c_calc_rent_vat, c_vat_yn,
					  c_calc_rent_supply, c_calc_rent_vat, 'N', 0); 
		  
     	 <<LOOP_NEXT>>
		 c_apply_date :=null;
		 c_rent_amt:=null;
		 c_rent_vat:=null;
		 c_temp_date :=null;
		 c_temp_date1 :=null;
		 c_cont_date :=null;
		 c_cont_seq :=null;
		 c_degree_code :=null;
		 c_calc_rent_supply :=null;
		 c_calc_rent_vat :=null;
		 c_days :=null;
		 c_days_inmonth :=null;
		 
	  END LOOP;
		
	  CLOSE MASTER_CUR;
	END;
   -- *****************************************************************************
   -- PROCESS ENDDING ... !
   -- *****************************************************************************
   <<EXIT_ROUTINE>>
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
END y_sp_h_lease_create_rent;
/

