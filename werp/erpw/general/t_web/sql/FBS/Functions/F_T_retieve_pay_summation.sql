Create Or Replace Function F_T_retieve_pay_summation
(
	p_bank_code			Varchar2,
	p_acct_number		Varchar2
)
Return T_O_pay_summations
Is
	p_da_req_cnt      	NUMBER ;
	p_da_req_amt      	NUMBER ;
	p_da_success_cnt  	NUMBER ;
	p_da_success_amt  	NUMBER ;
	p_da_commission   	NUMBER ;
	p_ta_req_cnt      	NUMBER ;
	p_ta_req_amt      	NUMBER ;
	p_ta_success_cnt  	NUMBER ;
	p_ta_success_amt  	NUMBER ;
	p_ta_commission   	NUMBER ;
	p_resp_code       	VARCHAR2(4000);
	p_resp_msg        	VARCHAR2(4000);
	ltRec				T_O_pay_summations := T_O_pay_summations();
	Pragma autonomous_transaction;
Begin
	ltRec.Extend();
	FBS_MAIN_PKG.retieve_pay_summation( p_bank_code,
                                     p_acct_number,
                                     p_da_req_cnt      ,        -- ���� ��û �Ǽ� 
                                     p_da_req_amt      ,        -- ���� ��û �ݾ� 
                                     p_da_success_cnt  ,        -- ���� ����ó�� �Ǽ� 
                                     p_da_success_amt  ,        -- ���� ����ó�� �ݾ� 
                                     p_da_commission   ,        -- ���� ������ 
                                     p_ta_req_cnt      ,        -- Ÿ�� ��û �Ǽ� 
                                     p_ta_req_amt      ,        -- Ÿ�� ��û �ݾ� 
                                     p_ta_success_cnt  ,        -- Ÿ�� ����ó�� �Ǽ� 
                                     p_ta_success_amt  ,        -- Ÿ�� ����ó�� �ݾ� 
                                     p_ta_commission   ,        -- Ÿ�� ������ 
                                     p_resp_code       ,       -- �����ڵ�
                                     p_resp_msg         );
	ltRec(ltRec.Count) := T_O_pay_summation(p_da_req_cnt      ,        -- ���� ��û �Ǽ� 
                                     p_da_req_amt      ,        -- ���� ��û �ݾ� 
                                     p_da_success_cnt  ,        -- ���� ����ó�� �Ǽ� 
                                     p_da_success_amt  ,        -- ���� ����ó�� �ݾ� 
                                     p_da_commission   ,        -- ���� ������ 
                                     p_ta_req_cnt      ,        -- Ÿ�� ��û �Ǽ� 
                                     p_ta_req_amt      ,        -- Ÿ�� ��û �ݾ� 
                                     p_ta_success_cnt  ,        -- Ÿ�� ����ó�� �Ǽ� 
                                     p_ta_success_amt  ,        -- Ÿ�� ����ó�� �ݾ� 
                                     p_ta_commission   ,        -- Ÿ�� ������ 
                                     p_resp_code       ,       -- �����ڵ�
                                     p_resp_msg         );
	Commit;
	Return ltRec;
Exception When Others Then
	Rollback;
	Raise;
End;
/
