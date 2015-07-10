/*************************************************************************/
/*                                                                       */
/*  1. 모듈ID    : T_FB_VAN_RECV_TRG                                     */
/*  2. 모듈이름  : VAN사 전문이 수신되었을때 처리로직                    */
/*  3. 시스템    : 회계시스템                                            */
/*  4. 서브시스템: FBS                                                   */
/*  5. 모듈유형  : TRIGGER                                               */
/*  6. 모듈언어  : PL/SQL                                                */
/*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
/*  8. 모듈DBMS  : Oracle                                                */
/*  9. 모듈의 목적 및 주요기능                                           */
/*                                                                       */
/*    - 전문이 수신된 경우, 하기의 5가지 기능을 수행한다.                */
/*                                                                       */
/*      (1) 계좌잔액데이터 TABLE INSERT/UPDATE                           */
/*         : 각 계좌별 일자별 잔액을 가지고 있는 T_FB_ACCT_REAMIN_DATA   */
/*           테이블에 계좌잔액을 UPDATE한다. 만약 잔액조회한 내역이 없   */
/*           는 경우는 신규로 INSERT를 수행한다.                         */
/*                                                                       */
/*      (2) 예금거래명세 TABLE INSERT                                    */
/*         : 예금거래명세 전문 및 결번응답 전문이 온 경우, 해당 테이블   */
/*           (T_FB_CASH_TRX_DATA)에 각 항목별로 구분해서 INSERT수행한다  */
/*           또 예금거래명세가 오는 경우, 해당 잔고가 표기되므로, 이를   */
/*           계좌별 잔액Table에 insert혹은 update를 합니다.              */
/*                                                                       */
/*      (3) 어음거래명세 TABLE INSERT                                    */
/*         : 어음거래명세 전문 및 결번응답 전문이 온 경우, 해당 테이블   */
/*           (T_FB_BILL_TRX_DATA)에 각 항목별로 구분해서 INSERT수행      */
/*                                                                       */
/*      (4) 타행이체불능 통지 처리                                       */
/*         : 타행이체불능통지 전문이 수신되면, 해당 지급건을 찾아서 상태 */
/*           를 '지급실패' 혹은 '일부지급실패'로 바꾸고, 등록된          */
/*           사원에게 타행이체불능통지 메일을 발송합니다.                */
/*                                                                       */
/*      (5) 응답없음 처리 후, 이체처리결과 수신시 처리                   */
/*         : 실시간이체처리시 일정시간을 LOOPING 을 WAITING을 수행하나,  */
/*           WAITING TIMEOUT이후에 수신된 이체처리결과 전문이 수신된     */
/*           경우, 해당 지급건을 찾아서 처리결과를 UPDATE합니다.         */
/*                                                                       */
/*      (6) 분양전송 데이타 INSERT                                       */
/*                                                                       */
/*         : 예금거래명세/예금거래명세결번요청응답/가상계좌거래명세/     */
/*           가상계좌 거래명세결번요청응답 등 4개의 전문이 수신되었을때  */
/*           해당 계좌가 "계좌(T_ACCNO_CODE)'테이블의 HSMS_USE_CLS컬럼이 */
/*           TRUE인 계좌라면, 이 경우, 컬럼별로 필요데이타를 뽑아서,     */
/*           "분양인터페이스(T_FB_INTERFACE_PH)"테이블에 INSERT수행      */
/*                                                                       */
/* 10. 최초작성자: LG CNS 신인철                                         */
/* 11. 최초작성일: 2005년12월21일                                        */
/* 12. 최종수정자:                                                       */
/* 13. 최종수정일:                                                       */
/*************************************************************************/
CREATE OR REPLACE TRIGGER T_FB_VAN_RECV_TRG
AFTER INSERT ON T_FB_VAN_RECV
FOR EACH ROW   
DECLARE
BEGIN
     
    
    -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<                  
	FBS_MAIN_PKG.process_recv_trigger(
		:New.TRAN_CODE,
		:New.ENTE_CODE,
		:New.BANK_CODE,
		:New.DOCU_CODE,
		:New.UPMU_CODE,
		:New.SEND_CONT,
		:New.DOCU_NUMC,
		:New.SEND_DATE,
		:New.SEND_TIME,
		:New.RESP_CODE,
		:New.GAEB_AREA,
		:New.RESP_YEBU
    );
END T_FB_VAN_RECV_TRG;
/
