Create Type T_O_pay_summation As Object
(
     p_da_req_cnt      NUMBER ,        -- 당행 요청 건수 
     p_da_req_amt      NUMBER ,        -- 당행 요청 금액 
     p_da_success_cnt  NUMBER ,        -- 당행 정상처리 건수 
     p_da_success_amt  NUMBER ,        -- 당행 정상처리 금액 
     p_da_commission   NUMBER ,        -- 당행 수수료 
     p_ta_req_cnt      NUMBER ,        -- 타행 요청 건수 
     p_ta_req_amt      NUMBER ,        -- 타행 요청 금액 
     p_ta_success_cnt  NUMBER ,        -- 타행 정상처리 건수 
     p_ta_success_amt  NUMBER ,        -- 타행 정상처리 금액 
     p_ta_commission   NUMBER ,        -- 타행 수수료 
     p_resp_code       VARCHAR2(4000),       -- 응답코드
     p_resp_msg        VARCHAR2(4000)  -- 응답코드명         
)
/
