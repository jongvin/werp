Create Type T_O_pay_summation As Object
(
     p_da_req_cnt      NUMBER ,        -- ���� ��û �Ǽ� 
     p_da_req_amt      NUMBER ,        -- ���� ��û �ݾ� 
     p_da_success_cnt  NUMBER ,        -- ���� ����ó�� �Ǽ� 
     p_da_success_amt  NUMBER ,        -- ���� ����ó�� �ݾ� 
     p_da_commission   NUMBER ,        -- ���� ������ 
     p_ta_req_cnt      NUMBER ,        -- Ÿ�� ��û �Ǽ� 
     p_ta_req_amt      NUMBER ,        -- Ÿ�� ��û �ݾ� 
     p_ta_success_cnt  NUMBER ,        -- Ÿ�� ����ó�� �Ǽ� 
     p_ta_success_amt  NUMBER ,        -- Ÿ�� ����ó�� �ݾ� 
     p_ta_commission   NUMBER ,        -- Ÿ�� ������ 
     p_resp_code       VARCHAR2(4000),       -- �����ڵ�
     p_resp_msg        VARCHAR2(4000)  -- �����ڵ��         
)
/
