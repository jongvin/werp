CREATE OR	REPLACE	PACKAGE	FBS_MAIN_PKG IS

	/******************************************************************************/
	/****																		 ****/
	/****																		 ****/
	/****			LG CNS VAN과 [기업은행]과	Batch처리를	위한 설정사항			 ****/
	/****																		 ****/
	/****																		 ****/
	/******************************************************************************/

	SUCCESS_CODE		Constant Varchar2(2) :=	'OK';

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		 현금	대량이체용 RECORD									 */
	/*----------------------------------------------------------------------------*/
	TYPE FB_KIUP_CASH_HEAD_RECORD	IS RECORD	(
		record_gubun		VARCHAR2(2)	:= '11',				 /*	식별코드 : 11			 */
		bank_code				VARCHAR2(2)	:= '03',				 /*	은행코드 : 03			 */
		upmu_code				VARCHAR2(2)	:= '82',				 /*	업무코드 : 82			 */
		pay_date				VARCHAR2(6)	,						 /*	이체 처리일(YYMMDD)6자리 */
		dummy1					VARCHAR2(6)	,						 /*	공란(SPACE)				 */
		out_account_no	VARCHAR2(14) ,					 /*	출금계좌번호			 */
		dummy2					VARCHAR2(1)	,						 /*	공란(SPACE)				 */
		ente_code				VARCHAR2(7)	,						 /*	기관코드				 */
		dummy3					VARCHAR2(40));					 /*	공란(SPACE)				 */

	TYPE FB_KIUP_CASH_DATA_RECORD	IS RECORD	(
		record_gubun			VARCHAR2(2)	:= '22',				 /*	식별코드 : 22			 */
		bank_code				VARCHAR2(2)	,						 /*	입금은행코드			 */
		upmu_code				VARCHAR2(2)	:= '82',				 /*	업무코드 : 82			 */
		data_seq				VARCHAR2(6)	,						 /*	데이터 일련번호			 */
		in_account_no			VARCHAR2(14) ,					 /*	입금계좌번호			 */
		pay_amt					VARCHAR2(10) ,					 /*	이체요청금액			 */
		ente_use_field			VARCHAR2(10) ,					 /*	업체사용정보			 */
		result_yebu				VARCHAR2(1)	,						 /*	처리결과 1:정상	2:불능	 */
		result_code				VARCHAR2(4),						 /*	처리결과코드			 */
		money_gubun				VARCHAR2(1),						 /*	자금구분				 */
		dummy					VARCHAR2(3)	);					 /*	공란(SPACE)				 */

	TYPE FB_KIUP_CASH_TAIL_RECORD	IS RECORD	(
		record_gubun			VARCHAR2(2)	:= '33',				 /*	식별코드 : 33			 */
		bank_code				VARCHAR2(2)	,						 /*	입금은행코드			 */
		upmu_code				VARCHAR2(2)	:= '82',				 /*	업무코드 : 82			 */
		total_request_cnt		VARCHAR2(7)	,						 /*	총 의뢰건수				 */
		total_request_amt		VARCHAR2(13) ,					 /*	총 의뢰금액				 */
		success_cnt				VARCHAR2(7)	 :=	'0000000',		 /*	정상처리건수			 */
		success_amt				VARCHAR2(13) :=	'0000000000000'	,	 /*	정상처리금액			 */
		fail_cnt				VARCHAR2(7)	 :=	'0000000',		 /*	불능처리건수			 */
		fail_amt				VARCHAR2(13) :=	'0000000000000',	 /*	불능처리금액			 */
		dummy1					VARCHAR2(6),						 /*	공란(SPACE)				 */
		sign_no					VARCHAR2(4)	,						 /*	복기부호				 */
		dummy2					VARCHAR2(4));						 /*	공란(SPACE)				 */


	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	전자외상매출채권담보대출 용	 RECORD							*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_KIUP_BILL_HEAD_RECORD	IS RECORD	(
		h_gubun			 VARCHAR2(2) :=	'10',				 /*	레코드구분 : 10			*/
		h_filename		 VARCHAR2(6) ,						 /*	예비1						*/
		h_filecd		 VARCHAR2(4) ,						 /*	예비2						*/
		h_fill11		 VARCHAR2(4) ,						 /*	예비3						*/
		h_procdate		 VARCHAR2(8) ,						 /*	전송일자					*/
		h_upchecd		 VARCHAR2(12)	,						 /*	업체코드					*/
		h_bankcd		 VARCHAR2(2) :=	'03' ,				 /*	은행코드					*/
		h_culacc		 VARCHAR2(13)	,						 /*	결제 계좌번호				*/
		h_fill12		 VARCHAR2(13)	,						 /*	예비4						*/
		h_procgb		 VARCHAR2(1) :=	'1',				 /*	처리구분 1:이체요구(업체->은행)	 2:처리결과(은행->업체)	*/
		h_filler		 VARCHAR2(82)	,						 /*	예비5						*/
		h_filler_2		 VARCHAR2(2) );						 /*	예비6						*/

	TYPE FB_KIUP_BILL_DATA_RECORD	IS RECORD	(
		d_gubun			 VARCHAR2(2) :=	'20' ,				 /*	레코드구분 : 20			*/
		d_nor_can		 VARCHAR2(2) :=	'00' ,				 /*	거래구분 00:정상	99:취소	*/
		d_docno			 VARCHAR2(14)	,						 /*	채권번호					*/
		d_cash_trx_yn	 VARCHAR2(1) :=	'2'	,				 /*	결제구분 1:현금	,	2:채권	*/
		d_bil_amt		 VARCHAR2(13)	,						 /*	채권금액					*/
		d_slco_bzno		 VARCHAR2(10)	,						 /*	납품업체 사업자번호		*/
		d_fill11		 VARCHAR2(12)	,						 /*	예비1						*/
		d_gtext			 VARCHAR2(20)	,						 /*	지급사업장				*/
		d_chulgail		 VARCHAR2(8) ,						 /*	출금가능일(발행일자)		*/
		d_aummanki		 VARCHAR2(8) ,						 /*	채권만기일				*/
		d_result		 VARCHAR2(4) ,						 /*	처리결과					*/
		d_paymentdate	 VARCHAR2(8) ,						 /*	예비2						*/
		d_paymentid		 VARCHAR2(6) ,						 /*	예비3						*/
		d_indate		 VARCHAR2(8) ,						 /*	남품일자:세금계산서일자	*/
		d_pummok		 VARCHAR2(20)	,						 /*	품목						*/
		d_fill12		 VARCHAR2(9) ,						 /*	예비4						*/
		d_dbrtcd		 VARCHAR2(2) ,						 /*	처리RETURN CODE			*/
		d_cheriy		 VARCHAR2(1) ,						 /*	은행처리여부				*/
		d_filler		 VARCHAR2(2) );						 /*	예비5						*/

	TYPE FB_KIUP_BILL_TAIL_RECORD	IS RECORD	(
		t_gubun			 VARCHAR2(2) :=	'30',				 /*	레코드구분 : 30			*/
		t_totgun		 VARCHAR2(6) ,						 /*	총 전송건수				*/
		t_totamt		 VARCHAR2(13)	,						 /*	총 전송금액				*/
		t_norgun		 VARCHAR2(6) ,						 /*	정상처리건수				*/
		t_noramt		 VARCHAR2(13)	,						 /*	정상처리금액				*/
		t_errgun		 VARCHAR2(6) ,						 /*	에러 처리건수				*/
		t_erramt		 VARCHAR2(13)	,						 /*	에러 처리금액				*/
		t_fill11		 VARCHAR2(91)	);					 /*	공란						*/



	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	전자 외담대	거래선 정보용	RECORD							*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_KIUP_SUPPLIER_HEAD_RECORD	IS RECORD	(
		h_gubun			 VARCHAR2(2) :=	'10',				 /*	레코드구분 : 10			*/
		h_UPCHENO		 VARCHAR2(8) ,						 /*	업체번호					*/
		h_bankcd		 VARCHAR2(2) :=	'03' ,				 /*	은행코드 : 03				*/
		h_gubun01		 VARCHAR2(1) ,						 /*	예비						*/
		h_jendate		 VARCHAR2(8) ,						 /*	전송일자					*/
		h_jobsijak		 VARCHAR2(8) ,						 /*	예비						*/
		h_jobend		 VARCHAR2(8) ,						 /*	예비						*/
		h_saupja		 VARCHAR2(10)	,						 /*	CJ개발 사업자번호			*/
		h_filler		 VARCHAR2(101) ,					 /*	예비						*/
		h_fi0d25		 VARCHAR2(2) ,						 /*	예비						*/
		h_fil_48		 VARCHAR2(48)	,						 /*	예비						*/
		h_fil_end		 VARCHAR2(2) );						 /*	예비						*/

	TYPE FB_KIUP_SUPPLIER_DATA_RECORD	IS RECORD	(
		d_gubun			 VARCHAR2(2) :=	'20',				 /*	레코드구분 : 20			 */
		d_seqno			 VARCHAR2(11)	,						 /*	일련번호					 */
		d_saupno		 VARCHAR2(10)	,						 /*	사업자번호				 */
		d_juminno		 VARCHAR2(13)	,						 /*	주민번호					 */
		d_sangho		 VARCHAR2(30)	,						 /*	상호						 */
		d_gyeoje		 VARCHAR2(1) ,						 /*	구분						 */
		d_newilja		 VARCHAR2(8) ,						 /*	신규일자					 */
		d_cloilja		 VARCHAR2(8) ,						 /*	해지일자					 */
		d_adjilja		 VARCHAR2(12)	,						 /*	예비						 */
		d_iacctno		 VARCHAR2(15)	,						 /*	결제계좌번호 (협력업체)	 */
		d_brno			 VARCHAR2(3) ,						 /*	예비						 */
		d_filler		 VARCHAR2(25)	,						 /*	예비						 */
		d_fi0d25		 VARCHAR2(2) ,						 /*	예비						 */
		d_fil_48		 VARCHAR2(48)	,						 /*	예비						 */
		d_fil_end		 VARCHAR2(2) );						 /*	예비						 */

	TYPE FB_KIUP_SUPPLIER_TAIL_RECORD	IS RECORD	(
		t_gubun			 VARCHAR2(2) :=	'30' ,				 /*	레코드구분 : 30			 */
		t_totgun		 VARCHAR2(6) ,						 /*	총 전송건수				 */
		t_newgun		 VARCHAR2(6) ,						 /*	신규건수					 */
		t_adjgun		 VARCHAR2(6) ,						 /*	변경건수					 */
		t_clogun		 VARCHAR2(6) ,						 /*	해지건수					 */
		t_filler		 VARCHAR2(122) ,					 /*	업체코드					 */
		d_fi0d25		 VARCHAR2(2) ,						 /*	예비						 */
		d_fil_49		 VARCHAR2(48)	,						 /*	예비						 */
		d_fil_end		 VARCHAR2(2) );						 /*	예비						 */


	/******************************************************************************/
	/****																		 ****/
	/****																		 ****/
	/****			LG CNS VAN과 [국민은행]과	Batch처리를	위한 설정사항			 ****/
	/****																		 ****/
	/****																		 ****/
	/******************************************************************************/

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	현금 대량이체용	RECORD										*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_KUKMIN_CASH_HEAD_RECORD	IS RECORD	(
		record_gubun			VARCHAR2(1)	:= 'S',				 /*	식별코드 : S			 */
		transfer_gubun			VARCHAR2(2)	:= 'C2',				 /*	송수신구분 은행송신:C2 수신:2C */
		bank_code				VARCHAR2(2)	:= '04',				 /*	은행코드 : 04			 */
		ente_code				VARCHAR2(8)	,						 /*	기관코드				 */
		dummy1					VARCHAR2(6)	,						 /*	예비					 */
		pay_date				VARCHAR2(6)	,						 /*	이체 처리일(YYMMDD)6자리 */
		dummy2					VARCHAR2(6)	,						 /*	예비					 */
		out_account_pwd			VARCHAR2(8)	,						 /*	모계좌 비밀번호			 */
		out_account_no			VARCHAR2(14) ,					 /*	모계좌번호				 */
		dummy3					VARCHAR2(26));					 /*	예비					 */

	TYPE FB_KUKMIN_CASH_DATA_RECORD	IS RECORD	(
		record_gubun			VARCHAR2(1)	:= 'D',				 /*	식별코드 : D			 */
		data_seq				VARCHAR2(5)	,						 /*	데이터 일련번호			 */
		bank_code				VARCHAR2(2)	,						 /*	입금은행코드			 */
		in_account_no			VARCHAR2(14) ,					 /*	입금계좌번호			 */
		pay_amt					VARCHAR2(10) ,					 /*	이체요청금액			 */
		result_yn				VARCHAR2(1)	,						 /*	처리결과 Y 혹은	N		 */
		result_code				VARCHAR2(4),						 /*	처리결과코드			 */
		paid_amt				VARCHAR2(10) :=	'0000000000',		 /*	실제이체금액:은행셋팅	 */
		ente_use_field			VARCHAR2(10) ,					 /*	업체사용정보			 */
		remark					VARCHAR2(8)	,						 /*	통장인자				 */
		dummy1					VARCHAR2(12) ,					 /*	예비					 */
		remark_gubun			VARCHAR2(1)	,						 /*	통장인자구분:은행과	협의 */
		dummy2					VARCHAR2(2)	);					 /*	예비					 */

	TYPE FB_KUKMIN_CASH_TAIL_RECORD	IS RECORD	(
		record_gubun			VARCHAR2(1)	:= 'E',				 /*	식별코드 : E			 */
		total_request_cnt		VARCHAR2(7)	,						 /*	총 의뢰건수				 */
		total_request_amt		VARCHAR2(13) ,					 /*	총 의뢰금액				 */
		success_cnt				VARCHAR2(7)	 :=	'0000000',		 /*	정상처리건수			 */
		success_amt				VARCHAR2(13) :=	'0000000000000'	,	 /*	정상처리금액			 */
		fail_cnt				VARCHAR2(7)	 :=	'0000000',		 /*	불능처리건수			 */
		fail_amt				VARCHAR2(13) :=	'0000000000000',	 /*	불능처리금액			 */
		sign_no					VARCHAR2(4)	,						 /*	복기부호				 */
		dummy					VARCHAR2(8));						 /*	공란					 */

	/******************************************************************************/
	/****																		 ****/
	/****																		 ****/
	/****			LG CNS VAN과 [우리은행]과	Batch처리를	위한 설정사항			 ****/
	/****																		 ****/
	/****																		 ****/
	/******************************************************************************/

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	현금 대량이체용	RECORD										*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_WOORI_CASH_HEAD_RECORD IS	RECORD (
		record_gubun			VARCHAR2(1)	:= 'S',				 /*	식별코드 : S			 */
		transfer_gubun		VARCHAR2(2)	:= 'C2',				 /*	송수신구분 은행송신:C2 수신:2C */
		ente_code					VARCHAR2(10) ,					 /*	업체코드				 */
		bank_code					VARCHAR2(2)	:= '20',				 /*	은행코드 : 20			 */
		transfer_date			VARCHAR2(6)	,						 /*	전송일자 YYMMDD			 */
		pay_date					VARCHAR2(6)	,						 /*	이체 처리일(YYMMDD)6자리 */
		out_account_no		VARCHAR2(14) ,					 /*	모계좌번호				 */
		out_account_pwd		VARCHAR2(8)	,						 /*	모계좌 비밀번호			 */
		return_trx				VARCHAR2(1)	,						 /*	이체회수				 */
		info_gubun				VARCHAR2(1)	:= '1',				 /*	통보구분 1:전체	2:불능 3:통보불필요	*/
		dummy1						VARCHAR2(5)	,						 /*	재처리구분,거래점코드	 */
		van								VARCHAR2(6)	:= 'LGEDS',			 /*	VAN코드					 */
		dummy2						VARCHAR2(17));					 /*	공란					 */

	TYPE FB_WOORI_CASH_DATA_RECORD IS	RECORD (
		record_gubun			VARCHAR2(1)	:= 'D',				 /*	식별코드 : D			 */
		bank_code				VARCHAR2(2)	,						 /*	입금은행코드			 */
		in_account_no			VARCHAR2(15) ,					 /*	입금계좌번호			 */
		trx_gubun				VARCHAR2(2)	,						 /*	입금이체 31:급여,32:상여,40:기타 , 출금은	별도 협의	*/
		pay_amt					VARCHAR2(11) ,					 /*	이체요청금액			 */
		pay_date				VARCHAR2(2)	,						 /*	이체일자 - 사용안함		 */
		result_yn				VARCHAR2(1)	,						 /*	처리결과 Y(정상) N(불능) , Z(일부이체) */
		result_code				VARCHAR2(4)	,						 /*	처리결과코드			 */
		fail_amt				VARCHAR2(10) ,					 /*	미처리금액				 */
		ente_use_field			VARCHAR2(24) ,					 /*	업체사용영역			 */
		dummy					VARCHAR2(8));						 /*	공란					 */

	TYPE FB_WOORI_CASH_TAIL_RECORD IS	RECORD (
		record_gubun			VARCHAR2(1)	:= 'E',				 /*	식별코드 : E			 */
		total_transfer_cnt		VARCHAR2(7)	,						 /*	총 전송건수	DATA건수+2	 */
		total_request_cnt		VARCHAR2(7)	,						 /*	총 의뢰건수				 */
		total_request_amt		VARCHAR2(13) ,					 /*	총 의뢰금액				 */
		success_cnt				VARCHAR2(7)	 :=	'0000000',		 /*	정상처리건수			 */
		success_amt				VARCHAR2(13) :=	'0000000000000'	,	 /*	정상처리금액			 */
		fail_cnt				VARCHAR2(7)	 :=	'0000000',		 /*	불능처리건수			 */
		fail_amt				VARCHAR2(13) :=	'0000000000000',	 /*	불능처리금액			 */
		sign_no					VARCHAR2(6)	,						 /*	복기부호				 */
		dummy					VARCHAR2(6));						 /*	공란					 */



	/******************************************************************************/
	/****																		 ****/
	/****																		 ****/
	/****			LG CNS VAN과 [하나은행]과	Batch처리를	위한 설정사항			 ****/
	/****																		 ****/
	/****																		 ****/
	/******************************************************************************/

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	현금 대량이체용	RECORD										*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_HANA_CASH_HEAD_RECORD	IS RECORD	(
		record_gubun			VARCHAR2(1)	:= 'S',				 /*	식별코드 : S			 */
		upmu_gubun				VARCHAR2(2)	:= '10',				 /*	업무구분 : 10			 */
		bank_code				VARCHAR2(2)	:= '81',				 /*	은행코드 : 81			 */
		transfer_date			VARCHAR2(8)	,						 /*	데이터 전송일(YYYYMMDD)	 */
		pay_date				VARCHAR2(6)	,						 /*	이체 처리일(YYMMDD)6자리 */
		out_account_no			VARCHAR2(14) ,					 /*	모계좌번호				 */
		transfer_type			VARCHAR2(2),						 /*	이체종류				 */
		comp_no					VARCHAR2(6)	:= '000000',			 /*	회사번호/업체는'0'셋팅	 */
		result_gubun			VARCHAR2(1)	:= '1',				 /*	처리결과통보구분 1:모든것	2:에러분 3:정상분	*/
		transfer_seq			VARCHAR2(1)	:= '1',				 /*	전송차수				 */
		out_account_pwd			VARCHAR2(8)	,						 /*	모계좌 비밀번호			 */
		dummy					VARCHAR2(20) ,					 /*	공란					 */
		format					VARCHAR2(1)	:= '1',				 /*	포맷					 */
		van						VARCHAR2(2)	:= 'LG');				 /*	VAN사	:	LG				 */

	TYPE FB_HANA_CASH_DATA_RECORD	IS RECORD	(
		record_gubun			VARCHAR2(1)	:= 'D',				 /*	식별코드 : D			 */
		data_seq				VARCHAR2(7)	,						 /*	데이터 일련번호			 */
		bank_code				VARCHAR2(2)	,						 /*	입금은행코드			 */
		in_account_no			VARCHAR2(14) ,					 /*	입금계좌번호			 */
		pay_amt					VARCHAR2(11) ,					 /*	이체요청금액			 */
		paid_amt				VARCHAR2(11) :=	'00000000000',	 /*	실제이체금액:은행셋팅	*/
		biz_ss_no				VARCHAR2(13) ,					 /*	주민/사업자번호			 */
		result_yn				VARCHAR2(1)	,						 /*	처리결과 Y 혹은	N		 */
		result_code				VARCHAR2(4)	,						 /*	불능코드				 */
		remark					VARCHAR2(12) ,					 /*	통장기장내역:협의사항	 */
		dummy					VARCHAR2(4));						 /*	공란					 */

	TYPE FB_HANA_CASH_TAIL_RECORD	IS RECORD	(
		record_gubun			VARCHAR2(1)	:= 'E',				 /*	식별코드 : E			 */
		total_request_cnt		VARCHAR2(7)	,						 /*	총 의뢰건수				 */
		total_request_amt		VARCHAR2(13) ,					 /*	총 의뢰금액				 */
		success_cnt				VARCHAR2(7)	 :=	'0000000',		 /*	정상처리건수			 */
		success_amt				VARCHAR2(13) :=	'0000000000000'	,	 /*	정상처리금액			 */
		fail_cnt				VARCHAR2(7)	 :=	'0000000',		 /*	불능처리건수			 */
		fail_amt				VARCHAR2(13) :=	'0000000000000',	 /*	불능처리금액			 */
		sign_no					VARCHAR2(8)	,						 /*	복기부호				 */
		dummy					VARCHAR2(11));					 /*	공란					 */


	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	구매카드용 RECORD											*/
	/*----------------------------------------------------------------------------*/

	TYPE FB_HANA_BILL_HEAD_RECORD	IS RECORD	(
		record_gubun			VARCHAR2(1)	:= 'S',				 /*	구분 : S						*/
		upmu_gubun				VARCHAR2(4)	:= 'R351',			 /*	업무구분 : 구매카드	승인요청	*/
		bill_ente_code			VARCHAR2(4)	,						 /*	하나은행이 부여한	업체고유코드	*/
		service_gubun			VARCHAR2(1)	:= '1',				 /*	서비스구분 1:구매	 2:역구매		*/
		approval_req_date		VARCHAR2(8)	,						 /*	승인요청일자					*/
		transfer_seq			VARCHAR2(1)	:= '1',				 /*	전송차수						*/
		branch_no				VARCHAR2(3)	:= '001',				 /*	사업장 번호						*/
		transfer_time			VARCHAR2(6)	,						 /*	전송시간 HHMMSS					*/
		test_gubun				VARCHAR2(1)	:= 'R',				 /*	R	:	REAL						*/
		biz_no					VARCHAR2(13) ,					 /*	사업자번호 : "999"+사업자번호	*/
		dummy					VARCHAR2(158)	);					 /*	공란							*/

	TYPE FB_HANA_BILL_DATA_RECORD	IS RECORD	(
		record_gubun			VARCHAR2(1)	:= 'D',				 /*	구분 : D						*/
		trade_seq				VARCHAR2(5)	,						 /*	거래번호:일자별	Sequence No		*/
		transfer_date			VARCHAR2(8)	,						 /*	거래일자 : 전송일자				*/
		card_no					VARCHAR2(16) ,					 /*	카드번호						*/
		member_no				VARCHAR2(11) ,					 /*	가맹점 번호						*/
		approval_amt			VARCHAR2(11) ,					 /*	승인금액						*/
		installment_period		VARCHAR2(3)	,						 /*	할부기간						*/
		unredeemed_fee_gubun	VARCHAR2(1)	:= '1' ,				 /*	거치수수료 부담	1:카드 2:가맹점	*/
		unredeemed_period		VARCHAR2(3)	,						 /*	대금입금거치기간				*/
		installment_fee_gubun	VARCHAR2(1)	:= '1' ,				 /*	분할수수료 부담	1:카드 2:가맹점	*/
		due_pay_date			VARCHAR2(8)	,						 /*	결제일자 : 보통	만기일			*/
		remark					VARCHAR2(12) ,					 /*	비고,	업체별 별도	사용			*/
		approval_no				VARCHAR2(10) ,					 /*	승인번호						*/
		result_code				VARCHAR2(4)	,						 /*	에러코드						*/
		member_fee				VARCHAR2(9)	,						 /*	가맹점 부담	수수료				*/
		member_total_amt		VARCHAR2(11) ,					 /*	가맹점 입금	총액				*/
		bill_discount_date		VARCHAR2(8)	,						 /*	최초입금시작일자 : 할인가능일	*/
		bill_date				VARCHAR2(8)	,						 /*	세금계산서 일자					*/
		description				VARCHAR2(15) ,					 /*	적요							*/
		dummy					VARCHAR2(44));					 /*	공란							*/

	TYPE FB_HANA_BILL_TAIL_RECORD	IS RECORD	(
		record_gubun			VARCHAR2(1)	:= 'E',				 /*	구분 : E						*/
		record_cnt				VARCHAR2(5)	,						 /*	레코드 갯수	:HEAD	 TAIL	포함	 */
		approval_req_cnt		VARCHAR2(5)	,						 /*	승인요청자료 갯수				*/
		approval_req_amt		VARCHAR2(15) ,					 /*	승인요청금액					*/
		success_cnt				VARCHAR2(5)	,						 /*	정상승인건수					*/
		success_amt				VARCHAR2(15) ,					 /*	정상승인금액					*/
		member_total_fee		VARCHAR2(15) ,					 /*	가맹점 부담	총 수수료			*/
		member_total_amt		VARCHAR2(15) ,					 /*	가맹점 입금	총액				*/
		fail_cnt				VARCHAR2(5)	,						 /*	승인에러건수					*/
		fail_amt				VARCHAR2(15) ,					 /*	승인에러금액					*/
		sign_no					VARCHAR2(11) ,					 /*	복기부호						*/
		dummy					VARCHAR2(93));					 /*	공란							*/

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	구매카드 거래선	정보용 RECORD								*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_HANA_SUPPLIER_HEAD_RECORD	IS RECORD	(
		record_gubun			VARCHAR2(1)	:= 'S',				 /*	구분 : S						*/
		seq						VARCHAR2(5)	,						 /*	일련번호						*/
		bill_ente_code			VARCHAR2(4)	,						 /*	업체코드						*/
		upmu_gubun				VARCHAR2(4)	:= 'R390',			 /*	업무구분 : 구매카드/가맹점정보	*/
		service_gubun			VARCHAR2(1)	,						 /*	서비스구분 1:구매	2:역구매		*/
		trade_date				VARCHAR2(8)	,						 /*	거래일자						*/
		transfer_seq			VARCHAR2(1)	,						 /*	전송차수						*/
		branch_no				VARCHAR2(3)	,						 /*	사업장 번호						*/
		dummy					VARCHAR2(473));					 /*	공란							*/

	TYPE FB_HANA_SUPPLIER_DATA_RECORD	IS RECORD	(
		record_gubun			 VARCHAR2(1) :=	'D'	,				 /*	구분 : D						*/
		seq								 VARCHAR2(5) ,						 /*	일자별 Sequence	No				*/
		bill_ente_code		 VARCHAR2(4) ,						 /*	하나은행이 부여한	업체코드		*/
		ente_name					 VARCHAR2(32),						 /*	하나은행이 부여한	업체명		*/
		service_gubun			 VARCHAR2(1) ,						 /*	서비스구분 1:구매	,	2:역구매	*/
		memeber_gubun			 VARCHAR2(1) ,						 /*	회원구분	1:카드 , 2:가맹점		*/
		card_member_no		 VARCHAR2(16)	,					 /*	카드/가맹점	번호				*/
		memeber_kor_name	 VARCHAR2(32)	,					 /*	회원한글명						*/
		info_gubun				 VARCHAR2(1) ,						 /*	이동구분 0:정상	 9:해지			*/
		new_issue_date		 VARCHAR2(8) ,						 /*	신규일자						*/
		cancel_date				 VARCHAR2(8) ,						 /*	해지/취소일자					*/
		member_tel_no			 VARCHAR2(19)	,					 /*	회원 전화번호					*/
		home_zip_code			 VARCHAR2(6) ,						 /*	자택/가맹점	우편번호			*/
		home_addr1				 VARCHAR2(42)	,					 /*	자택/가맹점	주소1				*/
		home_sub_addr			 VARCHAR2(82)	,					 /*	자택/가맹점	부속 주소			*/
		home_tel_1				 VARCHAR2(19)	,					 /*	자택/가맹점	전화번호 1			*/
		home_tel_2				 VARCHAR2(14)	,					 /*	자택/가맹점	전화번호 2			*/
		home_mng_division	 VARCHAR2(22)	,					 /*	자택/가맹점	관리부서			*/
		comp_zip_code			 VARCHAR2(6) ,						 /*	회사/가맹점	우편번호			*/
		comp_addr1				 VARCHAR2(42)	,					 /*	회사/가맹점	주소1				*/
		comp_sub_addr			 VARCHAR2(82)	,					 /*	회사/가맹점	부속 주소			*/
		comp_tel_no				 VARCHAR2(19)	,					 /*	회사 전화번호					*/
		biz_ss_no					 VARCHAR2(13)	,					 /*	주민(사업자) 번호				*/
		mng_no						 VARCHAR2(12)	,					 /*	관리번호						*/
		bank_code					 VARCHAR2(2) ,						 /*	은행코드 : 81					*/
		dummy							 VARCHAR2(11));					 /*	공란							*/

	TYPE FB_HANA_SUPPLIER_TAIL_RECORD	IS RECORD	(
		record_gubun			 VARCHAR2(1) :=	'E'	,				 /*	구분 : E						*/
		seq								 VARCHAR2(5) ,						 /*	일련번호 : 99999				*/
		bill_ente_code		 VARCHAR2(4) ,						 /*	업체 고유	코드					*/
		record_cnt				 VARCHAR2(5) ,						 /*	레코드갯수,	DATA RECORD	총 갯수	*/
		memeber_person_cnt VARCHAR2(5) ,						 /*	카드회원정보 건수				*/
		memeber_biz_cnt		 VARCHAR2(5) ,						 /*	가맹점 회원정보	건수			*/
		dummy							 VARCHAR2(475));					 /*	공란							*/

	/******************************************************************************/
	/****																		 ****/
	/****																		 ****/
	/****		LG CNS VAN과 [ REALTIME	송수신 ] 전문에	대한 설정				 ****/
	/****																		 ****/
	/****																		 ****/
	/******************************************************************************/



	/*----------------------------------------------------------------------------*/
	/* 은행코드																		*/
	/*----------------------------------------------------------------------------*/
	KIUP_BANK_CD					 VARCHAR2(2) :=	'03';		-- 기업은행
	KUKMIN_BANK_CD					 VARCHAR2(2) :=	'04';		-- 국민은행
	WOORI_BANK_CD					 VARCHAR2(2) :=	'20';		-- 우리은행
	HANA_BANK_CD					 VARCHAR2(2) :=	'81';		-- 하나은행

	/*----------------------------------------------------------------------------*/
	/* 이체나, 전자어음	realtime처리시 최대	대기시간 지정	(단위:초)					*/
	/*----------------------------------------------------------------------------*/
	DEFAULT_TIMEOUT	NUMBER(10)	 :=	60;

	/*----------------------------------------------------------------------------*/
	/* 기타	상수 선언																*/
	/*----------------------------------------------------------------------------*/
	CRLF				VARCHAR2(2)	 :=	CHR(10)||CHR(13);

	-- OS상의	DIRECTORY	PATH를 알기위한	ORACLE의 DIRECTORY NAME
	FBS_REALTIME_SEND_DIR	 VARCHAR2(100) :=	'FBS_REALTIME_SEND_DIR';		-- 실시간	처리 전문파일	송신폴더
	FBS_REALTIME_TEMP_DIR	 VARCHAR2(100) :=	'FBS_REALTIME_TEMP_DIR';		-- 실시간	처리 전문파일	임시폴더



	/*----------------------------------------------------------------------------*/
	/*	 실시간	펌뱅킹 전문번호	DEFINE												*/
	/*----------------------------------------------------------------------------*/
	FB_DOCU_OPEN_T			VARCHAR2(7)	:= '0800100';	/*	개시전문			(업체=>은행)	*/
	FB_DOCU_OPEN_B			VARCHAR2(7)	:= '0810100';	/*	개시전문			(은행=>업체)	*/

	FB_DOCU_DEPO_TR_T		VARCHAR2(7)	:= '0200300';	/*	예금거래명세통지(업체=>은행)	*/
	FB_DOCU_DEPO_TR_B		VARCHAR2(7)	:= '0210300';	/*	예금거래명세통지(은행=>업체)	*/

	FB_DOCU_DEPO_MISS_T		VARCHAR2(7)	:= '0200600';	/*	예금거래결번		(업체=>은행)	*/
	FB_DOCU_DEPO_MISS_B		VARCHAR2(7)	:= '0210600';	/*	예금거래결번		(은행=>업체)	*/

	FB_DOCU_VIRT_TR_T		VARCHAR2(7)	:= '0210100';	/*	가상계좌거래명세(업체=>은행)	*/
	FB_DOCU_VIRT_TR_B		VARCHAR2(7)	:= '0200100';	/*	가상계좌거래명세(은행=>업체)	*/

	FB_DOCU_VIRT_MISS_T		VARCHAR2(7)	:= '0200200';	/*	가상계좌결번요청(업체=>은행)	*/
	FB_DOCU_VIRT_MISS_B		VARCHAR2(7)	:= '0210200';	/*	가상계좌결번요청(은행=>업체)	*/

	FB_DOCU_DATR_T			VARCHAR2(7)	:= '0100100';	/*	당행이체			(업체=>은행)	*/
	FB_DOCU_DATR_B			VARCHAR2(7)	:= '0110100';	/*	당행이체			(은행=>업체)	*/

	FB_DOCU_TATR_T			VARCHAR2(7)	:= '0100200';	/*	타행이체			(업체=>은행)	*/
	FB_DOCU_TATR_B			VARCHAR2(7)	:= '0110200';	/*	타행이체			(은행=>업체)	*/

	FB_DOCU_TR_RE_T			VARCHAR2(7)	:= '0600100';	/*	이체처리결과조회(업체=>은행)	*/
	FB_DOCU_TR_RE_B			VARCHAR2(7)	:= '0610100';	/*	이체처리결과조회(은행=>업체)	*/

	FB_DOCU_REMAIN_T		VARCHAR2(7)	:= '0600300';	/*	잔액조회			(업체=>은행)	*/
	FB_DOCU_REMAIN_B		VARCHAR2(7)	:= '0610300';	/*	잔액조회			(은행=>업체)	*/

	FB_DOCU_SUM_T			VARCHAR2(7)	:= '0700100';	/*	집계처리			(업체=>은행)	*/
	FB_DOCU_SUM_B			VARCHAR2(7)	:= '0710000';	/*	집계처리			(은행=>업체)	*/

	FB_DOCU_TATR_RE_T		VARCHAR2(7)	:= '0410100';	/*	타행이체결과통지(업체=>은행)	*/
	FB_DOCU_TATR_RE_B		VARCHAR2(7)	:= '0400100';	/*	타행이체결과통지(은행=>업체)	*/

	FB_DOCU_NAME_CHECK_T	VARCHAR2(7)	:= '0400400';	/*	수취인 성명조회	(업체=>은행)	*/
	FB_DOCU_NAME_CHECK_B	VARCHAR2(7)	:= '0410400';	/*	수취인 성명조회	(은행=>업체)	*/

	FB_DOCU_BILL_ISSUE_T	VARCHAR2(7)	:= '0100310';	/*	어음지불			(업체=>은행)	*/
	FB_DOCU_BILL_ISSUE_B	VARCHAR2(7)	:= '0110310';	/*	어음지불			(은행=>업체)	*/

	FB_DOCU_VENDOR_T		VARCHAR2(7)	:= '0110320';	/*	어음거래선정보	(업체=>은행)	*/
	FB_DOCU_VENDOR_B		VARCHAR2(7)	:= '0100320';	/*	어음거래선정보	(은행=>업체)	*/

	FB_DOCU_BILL_TRX_T		VARCHAR2(7)	:= '0210400';	/*	어음거래명세		 (업체=>은행)	*/
	FB_DOCU_BILL_TRX_B		VARCHAR2(7)	:= '0200400';	/*	어음거래명세		 (은행=>업체)	*/

	FB_DOCU_BILL_MISS_T		VARCHAR2(7)	:= '0200500';	/*	어음명세결번요청 (업체=>은행)	*/
	FB_DOCU_BILL_MISS_B		VARCHAR2(7)	:= '0210500';	/*	어음명세결번요청 (은행=>업체)	*/










	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	실시간 펌뱅킹	송신테이블 RECORD								*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_VAN_SEND_RECORD	IS RECORD	(
		tran_code				VARCHAR2(9),			 /*	식별코드					*/
		ente_code				VARCHAR2(8),			 /*	업체코드					*/
		bank_code				VARCHAR2(2),			 /*	은행코드					*/
		docu_code				VARCHAR2(4),			 /*	전문코드					*/
		upmu_code				VARCHAR2(3),			 /*	업무코드					*/
		send_cont				VARCHAR2(1),			 /*	송신횟수					*/
		docu_numc				VARCHAR2(6),			 /*	전문번호					*/
		send_date				VARCHAR2(8),			 /*	전송일자					*/
		send_time				VARCHAR2(6),			 /*	전송시간					*/
		resp_code				VARCHAR2(4),			 /*	응답코드					*/
		gaeb_area				VARCHAR2(200),		 /*	개별부 영역				*/
		resp_yebu				VARCHAR2(1));			 /*	응답여부					*/

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	실시간 펌뱅킹	수신테이블 RECORD								*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_VAN_RECV_RECORD	IS RECORD	(
		tran_code				VARCHAR2(9),			 /*	식별코드					*/
		ente_code				VARCHAR2(8),			 /*	업체코드					*/
		bank_code				VARCHAR2(2),			 /*	은행코드					*/
		docu_code				VARCHAR2(4),			 /*	전문코드					*/
		upmu_code				VARCHAR2(3),			 /*	업무코드					*/
		send_cont				VARCHAR2(1),			 /*	송신횟수					*/
		docu_numc				VARCHAR2(6),			 /*	전문번호					*/
		send_date				VARCHAR2(8),			 /*	전송일자					*/
		send_time				VARCHAR2(6),			 /*	전송시간					*/
		resp_code				VARCHAR2(4),			 /*	응답코드					*/
		gaeb_area				VARCHAR2(200),		 /*	개별부 영역				*/
		resp_yebu				VARCHAR2(1));			 /*	응답여부					*/

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	예금거래명세통지(0200300)	개별부 전문											*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_REAL_DEPO_TR_RECORD	IS RECORD	(
		account_no				 VARCHAR2(15),	 /*	입금계좌번호				*/
		trade_gb					 VARCHAR2(2),		 /*	거래구분						*/
		bank_cd						 VARCHAR2(2),		 /*	거래발행은행코드		*/
		trade_amt					 VARCHAR2(13),	 /*	거래금액						*/
		remain_amt				 VARCHAR2(13),	 /*	거래 후, 잔액				*/
		giro_cd						 VARCHAR2(6),		 /*	지로코드						*/
		depo_nm						 VARCHAR2(16),	 /*	입금인 성명					*/
		check_no					 VARCHAR2(10),	 /*	어음 및	수표번호		*/
		cms								 VARCHAR2(16),	 /*	CMS코드(거래처코드)	*/
		trade_dt					 VARCHAR2(8),		 /*	거래일자						*/
		trade_time				 VARCHAR2(6),		 /*	거래시간						*/
		cash_amt					 VARCHAR2(13),	 /*	현금								*/
		check_amt					 VARCHAR2(13),	 /*	가계수표						*/
		ta_check_amt			 VARCHAR2(13),	 /*	교환후,인출가능금액	*/
		trade_no					 VARCHAR2(6),		 /*	거래시 일련번호	추가*/
		cancel_trade_no		 VARCHAR2(6),		 /*	취소시 인련번호	추가*/
		cancel_trade_dt		 VARCHAR2(8),		 /*	취소시 거래일자	추가*/
		remain_sign				 VARCHAR2(1),		 /*	예비부(잔액부호)		*/
		loan_yn						 VARCHAR2(1),		 /*	예비비(집단대출여부)(예비) */
		dong_ho						 VARCHAR2(8),		 /*	예비(동호)					*/
		dummy							 VARCHAR2(24));	 /*	DUMMY	SPACE	24개		*/

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	예금거래명세결번요구통지(0200600)	개별부 전문				*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_REAL_DEPO_MISS_RECORD	IS RECORD	(
		account_no				 VARCHAR2(15),	 /*	입금계좌번호				 */
		trade_gb				 VARCHAR2(2),		 /*	거래구분					 */
		bank_cd					 VARCHAR2(2),		 /*	거래발행은행코드			 */
		trade_amt				 VARCHAR2(13),	 /*	거래금액					 */
		remain_amt				 VARCHAR2(13),	 /*	거래 후, 잔액				 */
		giro_cd					 VARCHAR2(6),		 /*	지로코드					 */
		depo_nm					 VARCHAR2(16),	 /*	입금인 성명					 */
		check_no				 VARCHAR2(10),	 /*	어음 및	수표번호			 */
		cms						 VARCHAR2(16),	 /*	CMS코드(거래처코드)			 */
		trade_dt				 VARCHAR2(8),		 /*	거래일자					 */
		trade_time				 VARCHAR2(6),		 /*	거래시간					 */
		cash_amt				 VARCHAR2(13),	 /*	현금						 */
		check_amt				 VARCHAR2(13),	 /*	가계수표					 */
		ta_check_amt			 VARCHAR2(13),	 /*	교환후,	인출가능금액		 */
		org_docu_numc			 VARCHAR2(6),		 /*	원거래전문번호 추가			 */
		trade_no				 VARCHAR2(6),		 /*	거래시 일련번호	추가		 */
		cancel_trade_no			 VARCHAR2(6),		 /*	취소시 인련번호	추가		 */
		cancel_trade_dt			 VARCHAR2(8),		 /*	취소시 거래일자	추가		 */
		remain_sign				 VARCHAR2(1),		 /*	예비부(잔액부호)			 */
		loan_yn					 VARCHAR2(1),		 /*	예비비(집단대출여부)		 */
		dong_ho					 VARCHAR2(8),		 /*	예비(동호)					 */
		dummy					 VARCHAR2(18));	 /*	DUMMY	SPACE	18개			 */

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	당행이체(0100100)	/	타행이체(0100200)	개별부 전문			*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_REAL_TR_RECORD IS	RECORD (
		out_account_no			 VARCHAR2(15),	 /*	지급계좌					 */
		account_pw				 VARCHAR2(8),		 /*	통장비번(4)+이체비번(4)		 */
		sign_no					 VARCHAR2(6),		 /*	복기부호					 */
		trade_amt				 VARCHAR2(13),	 /*	출금금액					 */
		remain_sign				 VARCHAR2(1),		 /*	출금 후, 잔액부호			 */
		remain_amt				 VARCHAR2(13),	 /*	원장 잔액					 */
		in_bank_cd				 VARCHAR2(2),		 /*	입금은행코드				 */
		in_account_no			 VARCHAR2(15),	 /*	입금계좌					 */
		commission				 VARCHAR2(13),	 /*	이체수수료					 */
		cms						 VARCHAR2(16),	 /*	CMS코드(거래처코드)			 */
		depo_nm					 VARCHAR2(22),	 /*	입금인 성명(사용안함)		 */
		remark					 VARCHAR2(14),	 /*	입금인 통장적요(사용)		 */
		dummy					 VARCHAR2(72));	 /*	DUMMY	SPACE	72개			 */

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	이체처리결과조회(0600100,0600200)	개별부 전문				*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_REAL_TR_RE_RECORD	IS RECORD	(
		docu_numc				 VARCHAR2(6),		 /*	전문번호					 */
		out_account_no			 VARCHAR2(15),	 /*	지급계좌번호				 */
		in_account_no			 VARCHAR2(15),	 /*	입금계좌번호				 */
		trade_amt				 VARCHAR2(13),	 /*	금액						 */
		commission				 VARCHAR2(13),	 /*	수수료						 */
		sub_seq_no				 VARCHAR2(4),		 /*	SUB	SEQ	NO					 */
		trade_date				 VARCHAR2(8),		 /*	이체일자					 */
		trade_time				 VARCHAR2(6),		 /*	이체시간					 */
		result_cd				 VARCHAR2(4),		 /*	처리결과					 */
		in_bank_cd				 VARCHAR2(2),		 /*	입금은행코드				 */
		dummy					 VARCHAR2(111));	 /*	DUMMY	SPOACE 111개			 */

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	잔액조회(0600300)	개별부 전문								*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_REAL_REMAIN_RECORD IS	RECORD (
		account_no				 VARCHAR2(15),	 /*	계좌번호					 */
		remain_sign				 VARCHAR2(1),		 /*	부호						 */
		remain_amt				 VARCHAR2(13),	 /*	현재잔액					 */
		out_enable_amt			 VARCHAR2(13),	 /*	지급가능금액				 */
		account_pw				 VARCHAR2(4),		 /*	비밀번호					 */
		dummy					 VARCHAR2(154));	 /*	DUMMY	SPACE	154개			 */

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	집계처리(0700100)	개별부 전문								*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_REAL_SUM_RECORD	IS RECORD	(
		da_account_no			 VARCHAR2(15),	 /*	당행 출금계좌번호			 */
		da_req_cnt				 VARCHAR2(5),		 /*	당행 의뢰	총 건수			 */
		da_req_amt				 VARCHAR2(13),	 /*	당행 의뢰	총 금액			 */
		da_normal_cnt			 VARCHAR2(5),		 /*	당행 정상	건수				 */
		da_normal_amt			 VARCHAR2(13),	 /*	당행 정상	금액				 */
		da_fail_cnt				 VARCHAR2(5),		 /*	당행 불능	건수				 */
		da_fail_amt				 VARCHAR2(13),	 /*	당행 불능	금액				 */
		da_commission			 VARCHAR2(9),		 /*	당행 수수료						 */
		ta_req_cnt				 VARCHAR2(5),		 /*	타행 의뢰	총 건수			 */
		ta_req_amt				 VARCHAR2(13),	 /*	타행 의뢰	총 금액			 */
		ta_normal_cnt			 VARCHAR2(5),		 /*	타행 정상	건수				 */
		ta_normal_amt			 VARCHAR2(13),	 /*	타행 정상	금액				 */
		ta_fail_cnt				 VARCHAR2(5),		 /*	타행 불능	건수				 */
		ta_fail_amt				 VARCHAR2(13),	 /*	타행 불능	금액				 */
		ta_commission			 VARCHAR2(9),		 /*	타행 수수료						 */
		dummy							 VARCHAR2(59));	 /*	DUMMY	SPACE	59개			 */


	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	가상계좌(0200100)	/	가상계좌결번(2000200)	개별부 전문		*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_REAL_VIRTUAL_RECORD	IS RECORD	(
		account_no				 VARCHAR2(15),	 /*	입금계좌번호				 */
		trade_gb				 VARCHAR2(2),		 /*	거래구분					 */
		bank_cd					 VARCHAR2(2),		 /*	거래발행은행코드			 */
		trade_amt				 VARCHAR2(13),	 /*	거래금액					 */
		remain_amt				 VARCHAR2(13),	 /*	거래 후, 잔액				 */
		giro_cd					 VARCHAR2(6),		 /*	지로코드					 */
		depo_nm					 VARCHAR2(16),	 /*	입금인 성명					 */
		check_no				 VARCHAR2(10),	 /*	어음 및	수표번호			 */
		cms						 VARCHAR2(16),	 /*	CMS코드(거래처코드)			 */
		trade_dt				 VARCHAR2(8),		 /*	거래일자					 */
		trade_time				 VARCHAR2(6),		 /*	거래시간					 */
		cash_amt				 VARCHAR2(13),	 /*	현금						 */
		check_amt				 VARCHAR2(13),	 /*	가계수표					 */
		ta_check_amt			 VARCHAR2(13),	 /*	타점권						 */
		trade_no				 VARCHAR2(6),		 /*	거래시 일련번호	추가		 */
		cancel_trade_no			 VARCHAR2(6),		 /*	취소시 인련번호	추가		 */
		cancel_trade_dt			 VARCHAR2(8),		 /*	취소시 거래일자	추가		 */
		remain_sign				 VARCHAR2(1),		 /*	잔액부호					 */
		jumin_no				 VARCHAR2(13),	 /*	주민번호					 */
		loan_yn					 VARCHAR2(1),		 /*	예비비(집단대출여부)		 */
		dummy					 VARCHAR2(19));	 /*	DUMMY	SPACE	19개			 */

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	수취인성명조회(0400400/0410400)	개별부 전문					*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_NAME_CHECK_RECORD	IS RECORD	(
		bank_code				 VARCHAR2(2),		 /*	은행코드					 */
		account_num			 VARCHAR2(15),	 /*	계좌번호					 */
		ssn							 VARCHAR2(14),	 /*	주민번호					 */
		account_name		 VARCHAR2(14),	 /*	예금주명					 */
		dummy						 VARCHAR2(155)); /*	DUMMY	SPACE	155개	 */

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	어음거래명세(0200400/0210400)	개별부 전문					*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_BILL_TRX_RECORD	IS RECORD	(
		trade_gb				 VARCHAR2(2),		 /*	거래구분					 */
		account_no				 VARCHAR2(15),	 /*	계좌번호					 */
		trade_dt				 VARCHAR2(8),		 /*	거래일자					 */
		trade_time				 VARCHAR2(6),		 /*	거래시간					 */
		bill_no					 VARCHAR2(10),	 /*	어음번호					 */
		trade_amt				 VARCHAR2(13),	 /*	금액						 */
		issue_name				 VARCHAR2(14),	 /*	발행인						 */
		pay_due_dt				 VARCHAR2(8),		 /*	만기일						 */
		pay_bank_cd				 VARCHAR2(16),	 /*	만기시 지급은행				 */
		cms						 VARCHAR2(16),	 /*	CMS코드						 */
		item_change_cd			 VARCHAR2(3),		 /*	항목변경코드				 */
		remain_amt				 VARCHAR2(13),	 /*	잔액						 */
		giro_cd					 VARCHAR2(6),		 /*	지로코드					 */
		org_docu_numc			 VARCHAR2(6),		 /*	원거래전문번호				 */
		trade_no				 VARCHAR2(6),		 /*	거래일련번호				 */
		cancel_trade_no			 VARCHAR2(6),		 /*	취소시 인련번호	추가		 */
		cancel_trade_dt			 VARCHAR2(8),		 /*	취소시 거래일자	추가		 */
		dummy					 VARCHAR2(44));	 /*	DUMMY	SPACE	44개			 */

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	어음거래명세결번요구(0200500/0210500)	개별부 전문			*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_BILL_MISS_RECORD IS	RECORD (
		trade_gb				 VARCHAR2(2),		 /*	거래구분					 */
		account_no				 VARCHAR2(15),	 /*	계좌번호					 */
		trade_dt				 VARCHAR2(8),		 /*	거래일자					 */
		trade_time				 VARCHAR2(6),		 /*	거래시간					 */
		bill_no					 VARCHAR2(10),	 /*	어음번호					 */
		trade_amt				 VARCHAR2(13),	 /*	금액						 */
		issue_name				 VARCHAR2(14),	 /*	발행인						 */
		future_pay_due_dt		 VARCHAR2(8),		 /*	만기일						 */
		future_pay_bank_cd		 VARCHAR2(16),	 /*	만기시 지급은행				 */
		cms						 VARCHAR2(16),	 /*	CMS코드						 */
		item_change_cd			 VARCHAR2(3),		 /*	항목변경코드				 */
		remain_amt				 VARCHAR2(13),	 /*	잔액						 */
		giro_cd					 VARCHAR2(6),		 /*	지로코드					 */
		org_docu_numc			 VARCHAR2(6),		 /*	원거래전문번호				 */
		trade_no				 VARCHAR2(6),		 /*	거래일련번호				 */
		cancel_trade_no			 VARCHAR2(6),		 /*	취소시 인련번호	추가		 */
		cancel_trade_dt			 VARCHAR2(8),		 /*	취소시 거래일자	추가		 */
		dummy					 VARCHAR2(44));	 /*	DUMMY	SPACE	44개			 */

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	어음지불자료(0100310/0110310)	개별부 전문					*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_BILL_ISSUE_RECORD	IS RECORD	(
		transfer_dt				 VARCHAR2(8),		 /*	전송일자					 */
		transfer_gb				 VARCHAR2(2),		 /*	전송구분					 */
		pay_confirm_gb			 VARCHAR2(1),		 /*	결제구분					 */
		biz_no					 VARCHAR2(10),	 /*	사업자번호					 */
		docu_no					 VARCHAR2(14),	 /*	문서번호					 */
		trade_gb				 VARCHAR2(2),		 /*	거래구분					 */
		future_pay_due_dt		 VARCHAR2(8),		 /*	만기일자					 */
		bank_cd					 VARCHAR2(2),		 /*	은행코드					 */
		account_no				 VARCHAR2(15),	 /*	계좌번호					 */
		pay_amt					 VARCHAR2(13),	 /*	처리금액					 */
		bank_client_no			 VARCHAR2(10),	 /*	은행고객번호				 */
		vendor_name				 VARCHAR2(20),	 /*	지급지명					 */
		result_gb				 VARCHAR2(2),		 /*	결과구분					 */
		company_etc				 VARCHAR2(20),	 /*	회사임의정보				 */
		dummy					 VARCHAR2(72));	 /*	DUMMY	SPACE	72개			 */

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	거래처정보(0100320/0110320)	개별부 전문						*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_VENDOR_RECORD	IS RECORD	(
		transfer_dt				 VARCHAR2(8),		 /*	전송일자					 */
		transfer_gb				 VARCHAR2(2),		 /*	전송구분					 */
		bank_client_no			 VARCHAR2(10),	 /*	은행고객번호				 */
		gb						 VARCHAR2(2),		 /*	구분						 */
		current_biz_no			 VARCHAR2(10),	 /*	현 사업자	번호				 */
		previous_biz_no			 VARCHAR2(10),	 /*	구 사업자	번호				 */
		president_name			 VARCHAR2(10),	 /*	대표자명					 */
		biz_name				 VARCHAR2(40),	 /*	법인명						 */
		address					 VARCHAR2(59),	 /*	주소						 */
		dummy					 VARCHAR2(50));	 /*	DUMMY	SPACE	50개			 */

	Type		T_Nums	Is	Table	Of Number
		Index By Binary_Integer;
	Type		T_Vars	Is	Table	Of Varchar2(4000)
		Index By Binary_Integer;

	/******************************************************************************/
	/*	기능 : 매일아침	정해진시간에 등록된	은행별로 개시전문을	송신합니다.			*/
	/******************************************************************************/
	FUNCTION send_start_document(	p_comp_code		IN VARCHAR2	,			-- 사업장	코드
									p_bank_code		IN VARCHAR2	,			-- 은행코드
									p_resp_code		OUT	VARCHAR2,			-- 응답코드
									p_resp_msg		OUT	VARCHAR2 )		-- 응답코드명
		RETURN VARCHAR2;												-- 함수	처리결과 메시지


	/******************************************************************************/
	/*	기능 : 매일아침	정해진시간에 FBS시스템에 대한	상태점검메일을 발송			*/
	/******************************************************************************/
	FUNCTION send_fbs_status_mail( p_recv_list	IN VARCHAR2	DEFAULT	NULL )	 --	추가적인 메일수신자
		RETURN VARCHAR2;													 --	함수 처리결과	메시지


	/******************************************************************************/
	/*	기능 : 이체처리집계요청	처리결과											*/
	/******************************************************************************/
	PROCEDURE	retieve_pay_summation( p_bank_code		 IN	VARCHAR2 ,		 --	은행코드
									 p_acct_number		 IN	VARCHAR2 ,		 --	계좌번호
									 p_da_req_cnt		 OUT NUMBER	,			 --	당행 요청	건수
									 p_da_req_amt		 OUT NUMBER	,			 --	당행 요청	금액
									 p_da_success_cnt	 OUT NUMBER	,			 --	당행 정상처리	건수
									 p_da_success_amt	 OUT NUMBER	,			 --	당행 정상처리	금액
									 p_da_commission	 OUT NUMBER	,			 --	당행 수수료
									 p_ta_req_cnt		 OUT NUMBER	,			 --	타행 요청	건수
									 p_ta_req_amt		 OUT NUMBER	,			 --	타행 요청	금액
									 p_ta_success_cnt	 OUT NUMBER	,			 --	타행 정상처리	건수
									 p_ta_success_amt	 OUT NUMBER	,			 --	타행 정상처리	금액
									 p_ta_commission	 OUT NUMBER	,			 --	타행 수수료
									 p_resp_code		 OUT VARCHAR2,		 --	응답코드
									 p_resp_msg			 OUT VARCHAR2	)	;		 --	응답코드명


	/******************************************************************************/
	/*	기능 : 1개 계좌에	대한 잔액조회												*/
	/******************************************************************************/
	FUNCTION retieve_acct_remains( p_bank_code		 IN	VARCHAR2 ,		 --	은행코드
									 p_acct_number	 IN	VARCHAR2 ,		 --	계좌번호
									 p_remain_amt		 OUT NUMBER	 ,		 --	계좌잔액
									 p_enable_amt		 OUT NUMBER	 ,		 --	출금가능액
									 p_resp_code		 OUT VARCHAR2,		 --	응답코드
									 p_resp_msg		 OUT VARCHAR2	)		 --	응답코드명
		RETURN VARCHAR2;												 --	함수 처리결과	메시지


	/******************************************************************************/
	/*	기능 : 현금이체	담당자 획인	및 취소처리	로직								*/
	/******************************************************************************/
	FUNCTION cash_pay_window_check(	p_pay_seq		IN NUMBER	,			 --	지급일련번호
									p_job_gubun		IN VARCHAR2	,			 --	처리구분 [ CHECK:확인	,	CANCEL:확인취소	]
									p_emp_no		IN VARCHAR2	)			 --	사번
		RETURN VARCHAR2;												 --	함수 처리결과	메시지


	/******************************************************************************/
	/*	기능 : 현금이체파일	생성													*/
	/******************************************************************************/
	FUNCTION create_cash_edi_file( p_comp_code			 IN	VARCHAR2 ,		-- 사업장코드
									 p_bank_code			 IN	VARCHAR2 ,		-- 은행코드
									 p_row_cnt			 IN	NUMBER ,			-- 처리할	행의 갯수	(체크용)
									 p_emp_no				 IN	VARCHAR2 ,		-- 사번
									 p_edi_history_seq	 OUT NUMBER	)			-- EDI생성_송수신HISTORY일련번호 (실패한 경우, NULL)
		RETURN VARCHAR2;													-- 함수	처리결과 메시지


	/******************************************************************************/
	/*	기능 : 전자어음파일	생성													*/
	/******************************************************************************/
	FUNCTION create_bill_edi_file(	p_comp_code			IN VARCHAR2	,		 --	사업장코드
									p_bank_code			IN VARCHAR2	,		 --	은행코드
									p_row_cnt			IN NUMBER	,			 --	처리할 행의	갯수 (체크용)
									p_emp_no			IN VARCHAR2	,		 --	사번
									p_edi_history_seq	OUT	NUMBER )		 --	EDI생성_송수신HISTORY일련번호	(실패한	경우,	NULL)
		RETURN VARCHAR2;													 --	함수 처리결과	메시지


	/******************************************************************************/
	/*	기능 : 분할건별	현금이체 지급												*/
	/******************************************************************************/
	FUNCTION send_cash_each_transfer(	p_pay_seq			IN NUMBER	,			 --	지급일련번호
										p_div_seq			IN NUMBER	,			 --	분할일련번호
										p_emp_no			IN VARCHAR2	,		 --	사번
										p_resp_code		OUT	VARCHAR2,		 --	응답코드
										p_resp_msg		OUT	VARCHAR2 )		 --	응답코드명
		RETURN VARCHAR2;													 --	함수 처리결과	메시지


	/******************************************************************************/
	/*	기능 : 지급건별	현금이체 지급												*/
	/******************************************************************************/
	FUNCTION send_cash_transfer( p_pay_seq			 IN	NUMBER ,			-- 지급일련번호
								 p_emp_no			 IN	VARCHAR2 )		-- 사번
		RETURN VARCHAR2;												-- 함수	처리결과 메시지


	/******************************************************************************/
	/*	기능 : 지급건별	전자어음 realtime	송신										*/
	/******************************************************************************/
	FUNCTION send_bill_transfer( p_pay_seq			 IN	NUMBER ,			-- 지급일련번호
								 p_emp_no			 IN	VARCHAR2 )		-- 사번
		RETURN VARCHAR2;												-- 함수	처리결과 메시지

	/******************************************************************************/
	/*	기능 : 예금주명	조회														*/
	/******************************************************************************/
	FUNCTION retieve_acct_holder_name( p_bank_code		 IN	VARCHAR2 ,		 --	은행코드
										 p_acct_number	 IN	VARCHAR2 ,		 --	계좌번호
										 p_holder_name	 OUT VARCHAR2	,		 --	예금주명
										 p_resp_code		 OUT VARCHAR2,		 --	응답코드
										 p_resp_msg		 OUT VARCHAR2	)		 --	응답코드명
		RETURN VARCHAR2;													 --	함수 처리결과	메시지


	/******************************************************************************/
	/*	기능 : 전자어음	거래선정보 수신	처리										*/
	/******************************************************************************/
	FUNCTION read_bill_vendor_info(	p_edi_history_seq	 IN	NUMBER )				-- EDI송수신이력 일련번호
		RETURN VARCHAR2;														-- 함수	처리결과 메시지


	/******************************************************************************/
	/*	기능 : 전자어음	처리결과 수신	처리										 */
	/******************************************************************************/
	FUNCTION read_bill_result	(	p_edi_history_seq	IN NUMBER	,					-- EDI송수신이력 일련번호
								p_emp_no			IN VARCHAR2	)				-- 사번
		RETURN VARCHAR2;														-- 함수	처리결과 메시지


	/******************************************************************************/
	/*	기능 : 현금이체파일	처리결과 수신	처리										*/
	/******************************************************************************/
	FUNCTION read_cash_result	(	p_edi_history_seq	IN NUMBER	,					-- EDI송수신이력 일련번호
								p_emp_no			IN VARCHAR2	)				-- 사번
		RETURN VARCHAR2;														-- 함수	처리결과 메시지

	/******************************************************************************/
	/*	기능 : 일정주기별로	수행되는 job에 대한	총괄 호출	함수						*/
	/******************************************************************************/
	PROCEDURE	do_job_task;


	/******************************************************************************/
	/*	기능 : 타행이체불능	통지메일 발송											*/
	/******************************************************************************/
	FUNCTION send_tran_fail_mail(	p_comp_code			IN VARCHAR2	,			 --	사업장코드
									p_bank_code			IN VARCHAR2	,			 --	은행코드
									p_docu_numc			IN VARCHAR2	)			 --	전문번호
		RETURN VARCHAR2;													 --	함수 처리결과	메시지


	/******************************************************************************/
	/*	기능 : 지급예정	메일데이타 생성												*/
	/******************************************************************************/
	FUNCTION create_paydue_mail_data(	p_comp_code			IN VARCHAR2	,			 --	사업장코드
										p_pay_ymd				IN VARCHAR2	,			 --	지급예정일자
										p_vendor_seq			IN NUMBER	)			 --	거래처일련번호
		RETURN VARCHAR2;														 --	함수 처리결과	메시지


	/******************************************************************************/
	/*	기능 : 지급예정	메일 발송													*/
	/******************************************************************************/
	FUNCTION send_paydue_mail( p_mail_seq			IN NUMBER	,					 --	메일일련번호
								 p_emp_no				IN VARCHAR2	)					 --	사번
		RETURN VARCHAR2;														 --	함수 처리결과	메시지


	/******************************************************************************/
	/*	기능 : 예금이체	전표생성/이체데이타	생성									*/
	/******************************************************************************/
	FUNCTION create_transfer_slip_data(	p_transfer_seq	 IN	NUMBER ,			-- 예금이체일련번호
										p_emp_no		 IN	VARCHAR2 )			-- 사번
		RETURN VARCHAR2;														-- 함수	처리결과 메시지


	/******************************************************************************/
	/*	기능 : 인사지급데이타	추출													*/
	/******************************************************************************/
	FUNCTION extract_hr_pay_data(	p_comp_code			IN VARCHAR2	,			 --	사업장코드
									p_pay_ym				IN VARCHAR2	,			 --	지급예정 년월
									p_gubun				IN VARCHAR2	,			 --	구분
									p_emp_no				IN VARCHAR2	,			 --	사번
									p_extract_cnt			OUT	NUMBER	,			 --	총 추출	건수
									p_extract_amt			OUT	NUMBER	)			 --	총 추출	금액
		RETURN VARCHAR2;													 --	함수 처리결과	메시지


	/******************************************************************************/
	/*	기능 : 회계시스템에서	업체등록시 전자어음거래처로	등록된 업체인지	확인		*/
	/******************************************************************************/
	FUNCTION check_bill_vendor(	p_comp_code			IN VARCHAR2	,		 --	사업장코드
								p_bank_code			IN VARCHAR2	,		 --	은행코드
								p_bizno				IN VARCHAR2	)		 --	사업자번호
		RETURN VARCHAR2;												 --	함수 처리결과	메시지



	/******************************************************************************/
	/*	기능 : RealTime처리시, VAN송신Table에	넣고,일정시간동안	수신대기처리		*/
	/******************************************************************************/
	FUNCTION send_realtime_document( p_rec_send			 IN	FB_VAN_SEND_RECORD ,	 --	송신RECORD
									 p_timeout			 IN	NUMBER ,				 --	최대대기시간
									 p_rec_recv			 OUT FB_VAN_RECV_RECORD	,	 --	수신RECORD
									 p_result_code		 OUT VARCHAR2	 ,			 --	처리결과코드
									 p_result_msg		 OUT VARCHAR2	 )			 --	처리결과메시지
		RETURN VARCHAR2;															 --	함수 처리결과	메시지

	/******************************************************************************/
	/*	기능 : Van 수신	트리거 처리													*/
	/******************************************************************************/
	Procedure	process_recv_trigger
	(
		Ar_TRAN_CODE					Varchar2,
		Ar_ENTE_CODE					Varchar2,
		Ar_BANK_CODE					Varchar2,
		Ar_DOCU_CODE					Varchar2,
		Ar_UPMU_CODE					Varchar2,
		Ar_SEND_CONT					Varchar2,
		Ar_DOCU_NUMC					Varchar2,
		Ar_SEND_DATE					Varchar2,
		Ar_SEND_TIME					Varchar2,
		Ar_RESP_CODE					Varchar2,
		Ar_GAEB_AREA					Varchar2,
		Ar_RESP_YEBU					Varchar2
	);
END	FBS_MAIN_PKG;
/
CREATE OR	REPLACE	PACKAGE	BODY FBS_MAIN_PKG	IS
	Type		T_Nums	Is	Table	Of Number
		Index	By Binary_Integer;
	Type		T_Vars	Is	Table	Of Varchar2(4000)
		Index	By Binary_Integer;

	/******************************************************************************/
	/*	기능 : 전문코드	얻어내기													*/
	/******************************************************************************/
	Function	Get_Docu_Code
	(
		Ar_Docu				Varchar2
	)Return	Varchar2
	Is
	Begin
		Return SubStrb(Ar_Docu,1,4);
	End;

	/******************************************************************************/
	/*	기능 : 업무코드	얻어내기													*/
	/******************************************************************************/
	Function	Get_Upmu_Code
	(
		Ar_Docu				Varchar2
	)Return	Varchar2
	Is
	Begin
		Return SubStrb(Ar_Docu,5,3);
	End;
	/******************************************************************************/
	/*	기능 : RealTime자료	기본 설정												*/
	/******************************************************************************/
	PROCEDURE	init_van_send_record
	(
		p_bank_main_code			Varchar2,
		p_acct_number				VARCHAR2 ,		 --	계좌번호
		p_docu_upmu					Varchar2,
		p_rec_send			In Out	FB_VAN_SEND_RECORD
	)
	Is
	Begin
		Begin
			Select
				a.TRAN_CODE,
				a.ENTE_CODE
			Into
				p_rec_send.tran_code,
				p_rec_send.ente_code
			From	T_FB_ORG_BANK	a,
					T_ACCNO_CODE b
			Where	b.ACCOUNT_NO = p_acct_number
			And		b.COMP_CODE	=	a.COMP_CODE
			And		a.BANK_MAIN_CODE = p_bank_main_code;
		Exception	When No_Data_Found Then
			Raise_Application_Error(-20009,'은행거래정보가 설정되어	있지 않습니다.');
		End;
		p_rec_send.bank_code :=	p_bank_main_code;
		p_rec_send.send_date :=	To_Char(SysDate,'YYYYMMDD');
		p_rec_send.send_time :=	To_Char(SysDate,'HH24MISS');
		p_rec_send.send_cont :=	'1';
		-- 전문코드	및 업무코드	설정
		p_rec_send.docu_code :=	Get_Docu_Code(p_docu_upmu);
		p_rec_send.upmu_code :=	Get_Upmu_Code(p_docu_upmu);
		--전문 번호	채번
		p_rec_send.docu_numc :=	F_T_Gen_docu_numc(p_rec_send.bank_code,p_rec_send.docu_code,p_rec_send.upmu_code,p_rec_send.send_date);
	End;

	/******************************************************************************/
	/*	기능 : 전문	잘라주기													 */
	/******************************************************************************/
	Function	SplitDocu
	(
		Ar_Document				Varchar2,
		Ar_Nums					T_Nums,
		Ar_Trim					Boolean	Default	True
	)
	Return T_Vars
	Is
		liFirst					Number;
		liLast					Number;
		liStart					Number;
		ltVars					T_Vars;
	Begin
		If Ar_Nums.Count < 1 Then
			ltVars(ltVars.Count	+	1) :=	Ar_Document;
			Return ltVars;
		End	If;
		liFirst	:= Ar_Nums.First;
		liLast :=	Ar_Nums.Last;
		liStart	:= 1;
		For	liI	In liFirst..liLast Loop
			If Ar_Trim Then
				ltVars(ltVars.Count	+	1) :=	Trim(SubStrb(Ar_Document,liStart,Ar_Nums(liI)));
			Else
				ltVars(ltVars.Count	+	1) :=	SubStrb(Ar_Document,liStart,Ar_Nums(liI));
			End	If;
			liStart	:= liStart + Ar_Nums(liI);
		End	Loop;
		Return ltVars;
	End;

	/******************************************************************************/
	/*	기능 : 실시간	전문 에러코드로	에러 찾기										*/
	/******************************************************************************/
	Function	Get_RealTimeError
	(
		Ar_Bank_Code			Varchar2,
		Ar_ErrorCode			Varchar2
	)
	Return Varchar2
	Is
		lsErrm					T_FB_REAL_RESP_CODE.RESP_CODE_NAME%Type;
	Begin
		Select
			RESP_CODE_NAME
		Into
			lsErrm
		From	T_FB_REAL_RESP_CODE
		Where	BANK_CODE	=	Ar_Bank_Code
		And		RESP_CODE	=	Ar_ErrorCode;
		Return lsErrm;
	Exception	When No_Data_Found Then
		Return '알 수	없는 에러';
	End;

	/******************************************************************************/
	/*	기능 : SO-SI제거하고 KSC-5601로	변환										*/
	/******************************************************************************/
	Function	GetSingleBytes
	(
		Ar_Data						Varchar2
	)
	Return Varchar2
	Is
	Begin
		Return To_Single_Byte(RTrim(LTrim(Trim(Ar_Data),Chr(14)),Chr(15)));
	End;

	/*************************************************************************/
	/*																																			 */
	/*	1. 모듈ID		 : send_start_document																	 */
	/*	2. 모듈이름	 : 매일아침	은행으로 개시전문을	송신합니다.							 */
	/*	3. 시스템		 : 회계시스템																						 */
	/*	4. 서브시스템: FBS																									 */
	/*	5. 모듈유형	 :																											 */
	/*	6. 모듈언어	 : PL/SQL																								 */
	/*	7. 모듈환경	 : Windows2003 Server+ Oracle	9.2.0											 */
	/*	8. 모듈DBMS	 : Oracle																								 */
	/*	9. 모듈의	목적 및	주요기능																					 */
	/*																																			 */
	/*		-	매일 정해진시간(오전8:30)에	FBS약정계좌가	계설된 모든은행으로		 */
	/*			개시전문을 자동으로	발송합니다.																	 */
	/*			본 함수는	사업장/은행을	입력받아서,	개시전문1개를	전송하는			 */
	/*			기능을 수행하며, 사업장/은행LIST를 SELECT로	조회후,	본 함수를		 */
	/*			각각 호출하여	처리한다.	(매일아침	개시 시)											 */
	/*																																			 */
	/*		-	반환값																													 */
	/*			OK : 정상개시	시																								 */
	/*			오류메시지 : 기타	오류 발생시	(DEFAULT값:ERROR)									 */
	/*																																			 */
	/* 10. 최초작성자: LG	CNS	신인철																				 */
	/* 11. 최초작성일: 2005년12월21일																				 */
	/* 12. 최종수정자:																											 */
	/* 13. 최종수정일:																											 */
	/*************************************************************************/
	FUNCTION send_start_document(	p_comp_code		IN VARCHAR2	,			-- 사업장	코드
																p_bank_code		IN VARCHAR2	,			-- 은행코드
																p_resp_code		OUT	VARCHAR2,			-- 응답코드
																p_resp_msg		OUT	VARCHAR2 )		-- 응답코드명
		RETURN VARCHAR2	IS																-- 함수	처리결과 메시지

	BEGIN
		-- >>>>>>>>>>>>>	 처리로직		 <<<<<<<<<<<<<<<<<<


		RETURN(	NULL );

	END	send_start_document;


	/*************************************************************************/
	/*																		 */
	/*	1. 모듈ID	 : send_fbs_status_mail									 */
	/*	2. 모듈이름	 : 매일정해진시간에	FBS시스템에	대한 상태점검메일을	발송 */
	/*	3. 시스템	 : 회계시스템											 */
	/*	4. 서브시스템: FBS													 */
	/*	5. 모듈유형	 :														 */
	/*	6. 모듈언어	 : PL/SQL												 */
	/*	7. 모듈환경	 : Windows2003 Server+ Oracle	9.2.0						 */
	/*	8. 모듈DBMS	 : Oracle												 */
	/*	9. 모듈의	목적 및	주요기능											 */
	/*																		 */
	/*		-	매일 정해진시간(오전9:00)에	FBS시스템에	대한 상태를	점검하여	 */
	/*			기 등록된	수신자 및	추가적으로 PARAMETER로 입력된	인원에게	 */
	/*			FBS시스템상태를	담은 메일을	발송합니다.						 */
	/*			수신자는 T_FB_LOOKUP_VALUES의	LOOKUP_TYPE이	"FBS_RECEIVE_EMP"	 */
	/*			에 등록된	인원에게 발송한다.									 */
	/*																		 */
	/*		-	체크하는 내용은	아래와 같음									 */
	/*			 (1) 관련PROGRAM의 VALID여부 확인								 */
	/*			 (2) 관련PROCESS의 기동여부	확인								 */
	/*			 (3) JOB수행여부 확인											 */
	/*			 (4) 은행별	개시여부 확인										 */
	/*			 (5) 수신된	전자어음 약정거래선	정보							 */
	/*																		 */
	/*		-	반환값														 */
	/*			OK : 정상	메일발송 시										 */
	/*			오류메시지 : 기타	오류 발생시	(DEFAULT값:ERROR)				 */
	/*																		 */
	/* 10. 최초작성자: LG	CNS	신인철										 */
	/* 11. 최초작성일: 2005년12월21일										 */
	/* 12. 최종수정자:														 */
	/* 13. 최종수정일:														 */
	/*************************************************************************/
	FUNCTION send_fbs_status_mail( p_recv_list	IN VARCHAR2	DEFAULT	NULL )	 --	추가적인 메일수신자	(DEFAULT는 NULL)
		RETURN VARCHAR2	IS
	BEGIN


		-- >>>>>>>>>>>>>	 처리로직		 <<<<<<<<<<<<<<<<<<


		RETURN(	NULL );

	END	send_fbs_status_mail;


	/*************************************************************************/
	/*																		                                   */
	/*	1. 모듈ID	 : retieve_acct_remains									                   */
	/*	2. 모듈이름	 : 1개 계좌에	대한 잔액조회								               */
	/*	3. 시스템	 : 회계시스템											                         */
	/*	4. 서브시스템: FBS													                         */
	/*	5. 모듈유형	 :														                           */
	/*	6. 모듈언어	 : PL/SQL												                         */
	/*	7. 모듈환경	 : Windows2003 Server+ Oracle	9.2.0						           */
	/*	8. 모듈DBMS	 : Oracle												                         */
	/*	9. 모듈의	목적 및	주요기능											                     */
	/*																		                                   */
	/*		-	입력된 은행코드	및 계좌번호에	대한 잔액을	VAN사로	잔액조회전문   */
	/*			을 송수신하여, 구해옵니다.									                     */
	/*			정상적으로 처리된	경우,	RESP_CODE가	"0000"으로 반환된	경우만	   */
	/*			정상적으로 조회된	경우임.										                     */
	/*																		                                   */
	/*		-	잔액데이타에 대하여	"계좌잔액데이타(T_FB_ACCT_REMAIN_DATA)"의	   */
	/*			내용을 INSERT	혹은 UPDATE수행합니다							                 */
	/*																		                                   */
	/*		-	반환값														                               */
	/*			OK : 정상	처리 시											                           */
	/*			오류메시지 : 기타	오류 발생시	(DEFAULT값:ERROR)				           */
	/*																		                                   */
	/* 10. 최초작성자: LG	CNS	신인철										                     */
	/* 11. 최초작성일: 2005년12월21일										                     */
	/* 12. 최종수정자:														                           */
	/* 13. 최종수정일:														                           */
	/*************************************************************************/
	FUNCTION retieve_acct_remains( p_bank_code		 IN	VARCHAR2 ,		 --	은행코드
									 p_acct_number	 IN	VARCHAR2 ,		 --	계좌번호
									 p_remain_amt		 OUT NUMBER	 ,		 --	계좌잔액
									 p_enable_amt		 OUT NUMBER	 ,		 --	출금가능액
									 p_resp_code		 OUT VARCHAR2,		 --	응답코드
									 p_resp_msg		 OUT VARCHAR2	)		 --	응답코드명
		RETURN VARCHAR2	IS												 --	함수 처리결과	메시지
	BEGIN
		-- >>>>>>>>>>>>>	 처리로직		 <<<<<<<<<<<<<<<<<<
		sp_retrive_acct_remains( p_bank_code	    ,	   -- 은행코드
													   p_acct_number	  ,	   -- 계좌번호
													   p_remain_amt	    ,	   -- 잔액		
													   p_enable_amt     ,    -- 가용자금
													   p_resp_code	    ,    -- 응답코드
													   p_resp_msg		   );    -- 응답코드명

		RETURN(	NULL );

	END	retieve_acct_remains;


	/*************************************************************************/
	/*																																			 */
	/*	1. 모듈ID	 : cash_pay_window_check																	 */
	/*	2. 모듈이름	 : 현금이체	담당자 획인	및 취소처리	로직								 */
	/*	3. 시스템	 : 회계시스템																							 */
	/*	4. 서브시스템: FBS																									 */
	/*	5. 모듈유형	 :																											 */
	/*	6. 모듈언어	 : PL/SQL																								 */
	/*	7. 모듈환경	 : Windows2003 Server+ Oracle	9.2.0											 */
	/*	8. 모듈DBMS	 : Oracle																								 */
	/*	9. 모듈의	목적 및	주요기능																					 */
	/*																																			 */
	/*		-	현금이체시 담당자	확인/확인취소에	대하여 각각의	처리루틴				 */
	/*			확인인지,	확인취소처리인지는 GUBUN코드로 구분한다.							 */
	/*																																			 */
	/*			(1)	확인처리 시																									 */
	/*			:	T_FB_CASH_PAY_DATA에 담긴	해당 지급RECORD에	대하여 타행				 */
	/*				이체여부를 확인하여, T_FB_LOOKUP_VALUES테이블의	은행별				 */
	/*				이체한도금액을 확인하여, T_FB_CASH_PAY_DIVIDED_DATA에					 */
	/*				분할지급건에 대하여	RECORD를 생성시킨다.											 */
	/*				이체한도에 안걸리면	보통 1개의 분할지급RECORD생성됨						 */
	/*				생성시킨 후, PAY_STATUS를	담당자 확인상태로	UPDATE한다.				 */
	/*																																			 */
	/*			(2)	확인취소 처리	시																						 */
	/*			:	기 확인	된 건이었으므로, 분할지급테이블에	생성된 RECORD를			 */
	/*				DELETE하고,	PAY_STATUS를 담당자	미확인 상태로	변경시킨다.			 */
	/*																																			 */
	/*		-	담당자확인/확인취소처리는	팀장승인/지급완료/실패/전표취소	시를	 */
	/*			 제외한	상태에서만 처리가	가능함																 */
	/*																																			 */
	/*		-	지급데이타의 출처가	"예금이체"인 경우는	확인/확인취소에	따라서	 */
	/*			STATUS를 변경시켜준다. T_FB_CASH_TRANSFER_DATA의								 */
	/*			FUND_TRANSFER_STATUS를 확인시는	'1'로	변경하며,	취소시는 '0'으	 */
	/*			으로 UPDATE한다.																								 */
	/*																																			 */
	/*		-	반환값																													 */
	/*			OK : 정상	처리 시																								 */
	/*			오류메시지 : 기타	오류 발생시	(DEFAULT값:ERROR)									 */
	/*																																			 */
	/* 10. 최초작성자: LG	CNS	신인철																				 */
	/* 11. 최초작성일: 2005년12월21일																				 */
	/* 12. 최종수정자:																											 */
	/* 13. 최종수정일:																											 */
	/*************************************************************************/
	FUNCTION cash_pay_window_check(	p_pay_seq		IN NUMBER	,			 --	지급일련번호
																	p_job_gubun	IN VARCHAR2	,		 --	처리구분 [ CHECK:확인	,	CANCEL:확인취소	]
																	p_emp_no		IN VARCHAR2	)		 --	사번
		RETURN VARCHAR2	IS												 --	함수 처리결과	메시지
	BEGIN
		-- >>>>>>>>>>>>>	 처리로직		 <<<<<<<<<<<<<<<<<<
		SP_CASH_PAY_WINDOW_CHECK
		(
			p_pay_seq			,				 --	지급일련번호
			p_job_gubun		,				 --	처리구분 [ CHECK:확인	,	CANCEL:확인취소	]
			p_emp_no							 --	사번																			 
		);

		RETURN(	NULL );

	END	cash_pay_window_check;


	/*************************************************************************/
	/*																																			 */
	/*	1. 모듈ID	 : create_cash_edi_file																		 */
	/*	2. 모듈이름	 : 현금이체파일	생성																		 */
	/*	3. 시스템	 : 회계시스템																							 */
	/*	4. 서브시스템: FBS																									 */
	/*	5. 모듈유형	 :																											 */
	/*	6. 모듈언어	 : PL/SQL																								 */
	/*	7. 모듈환경	 : Windows2003 Server+ Oracle	9.2.0											 */
	/*	8. 모듈DBMS	 : Oracle																								 */
	/*	9. 모듈의	목적 및	주요기능																					 */
	/*																																			 */
	/*		-	생성은 화면단에서	UPDATE하여주는 EDI_CREATE_REQ_YN 컬럼이	'Y'		 */
	/*			인 것을	대상으로 EDI파일을 생성합니다.													 */
	/*																																			 */
	/*		-	현금이체파일을 생성하며, 은행별/사업장별로 생성된다.						 */
	/*			정상적으로 생성된	경우,	RETURN값은 OK가	반환되며,	생성된 송수		 */
	/*			신이력테이블(T_FB_EDI_HISTORY)의 키(SEQ)가 반환된다.						 */
	/*			오류가 난	경우는 NULL값이	반환된다.															 */
	/*																																			 */
	/*		-	이체파일은 정해진	규칙에 의거	생성을 하는	function을 호출하여		 */
	/*			파일경로/파일명을	구해서 생성시킨다.														 */
	/*																																			 */
	/*		-	파일명 명명규칙은	다음과 같이	함																 */
	/*			 CS_사업장코드(2)_은행코드(2)_날짜(8)_일련번호(3).dat						 */
	/*																																			 */
	/*		-	동시성 체크를	위해서 화면단위에서	호출시,	선택한 행의	갯수를		 */
	/*			본 함수의	parameter로	입력하여,	추후 처리완료시의	행의 갯수와		 */
	/*			비교를 하여	다른 경우는	오류로 반환한다.												 */
	/*																																			 */
	/*		-	반환값																													 */
	/*			OK : 정상	처리 시																								 */
	/*			오류메시지 : 기타	오류 발생시	(DEFAULT값:ERROR)									 */
	/*																																			 */
	/* 10. 최초작성자: LG	CNS	신인철																				 */
	/* 11. 최초작성일: 2005년12월21일																				 */
	/* 12. 최종수정자:																											 */
	/* 13. 최종수정일:																											 */
	/*************************************************************************/
	FUNCTION create_cash_edi_file( p_comp_code				 IN	VARCHAR2 ,		-- 사업장코드
																 p_bank_code				 IN	VARCHAR2 ,		-- 은행코드
																 p_row_cnt					 IN	NUMBER	 ,		-- 처리할	행의 갯수	(체크용)
																 p_emp_no						 IN	VARCHAR2 ,		-- 사번
																 p_edi_history_seq	 OUT NUMBER	)			-- EDI생성_송수신HISTORY일련번호 (실패한 경우, NULL)
		RETURN VARCHAR2	IS													-- 함수	처리결과 메시지
	BEGIN
		-- >>>>>>>>>>>>>	 처리로직		 <<<<<<<<<<<<<<<<<<
		-- sp_create_cash_edi_file(	company_cd		,			 --	회사코드
		--													pay_gubun			,			 --	지급구분
		--													pay_due_ymd		,			 --	지급예정일자
		--													bank_cd				,			 --	은행코드 
		--													account_no		,			 --	출금계좌ID
		--													emp_no				,			 --	사원번호(최종수정자)
		--													result_code		,			 --	처리결과코드 
		--													edi_date		 DEFAULT NULL	)
		RETURN(	NULL );

	END	create_cash_edi_file;


	/*************************************************************************/
	/*																																			 */
	/*	1. 모듈ID	 : create_bill_edi_file																		 */
	/*	2. 모듈이름	 : 전자어음파일	생성																		 */
	/*	3. 시스템	 : 회계시스템																							 */
	/*	4. 서브시스템: FBS																									 */
	/*	5. 모듈유형	 :																											 */
	/*	6. 모듈언어	 : PL/SQL																								 */
	/*	7. 모듈환경	 : Windows2003 Server+ Oracle	9.2.0											 */
	/*	8. 모듈DBMS	 : Oracle																								 */
	/*	9. 모듈의	목적 및	주요기능																					 */
	/*																																			 */
	/*		-	생성은 화면단에서	UPDATE하여주는 EDI_CREATE_REQ_YN 컬럼이	'Y'		 */
	/*			인 것을	대상으로 EDI파일을 생성합니다.													 */
	/*																																			 */
	/*		-	전자어음파일을 생성하며, 은행별/사업장별로 생성된다.						 */
	/*			정상적으로 생성된	경우,	RETURN값은 OK가	반환되며,	생성된 송수		 */
	/*			신이력테이블(T_FB_EDI_HISTORY)의 키(SEQ)가 반환된다.						 */
	/*			오류가 난	경우는 NULL값이	반환된다.															 */
	/*																																			 */
	/*		-	이체파일은 정해진	규칙에 의거	생성을 하는	function을 호출하여		 */
	/*			파일경로/파일명을	구해서 생성시킨다.														 */
	/*																																			 */
	/*		-	파일명 명명규칙은	다음과 같이	함																 */
	/*			 BS_사업장코드(2)_은행코드(2)_날짜(8)_일련번호(3).dat						 */
	/*																																			 */
	/*		-	동시성 체크를	위해서 화면단위에서	호출시,	선택한 행의	갯수를		 */
	/*			본 함수의	parameter로	입력하여,	추후 처리완료시의	행의 갯수와		 */
	/*			비교를 하여	다른 경우는	오류로 반환한다.												 */
	/*																																			 */
	/*		-	반환값																													 */
	/*			OK : 정상	처리 시																								 */
	/*			오류메시지 : 기타	오류 발생시	(DEFAULT값:ERROR)									 */
	/*																																			 */
	/* 10. 최초작성자: LG	CNS	신인철																				 */
	/* 11. 최초작성일: 2005년12월21일																				 */
	/* 12. 최종수정자:																											 */
	/* 13. 최종수정일:																											 */
	/*************************************************************************/
	FUNCTION create_bill_edi_file(	p_comp_code				IN VARCHAR2	,		 --	사업장코드
																	p_bank_code				IN VARCHAR2	,		 --	은행코드
																	p_row_cnt					IN NUMBER		,		 --	처리할 행의	갯수 (체크용)
																	p_emp_no					IN VARCHAR2	,		 --	사번
																	p_edi_history_seq	OUT	NUMBER )		 --	EDI생성_송수신HISTORY일련번호	(실패한	경우,	NULL)
		RETURN VARCHAR2	IS													 --	함수 처리결과	메시지
	BEGIN
		-- >>>>>>>>>>>>>	 처리로직		 <<<<<<<<<<<<<<<<<<
		-- sp_create_bill_edi_file(	company_cd		,			 --	회사코드
		--													pay_gubun			,			 --	지급구분
		--													pay_due_ymd		,			 --	발행예정일자																			
		--													bank_cd				,			 --	은행코드 
		--													account_no		,			 --	출금계좌ID
		--													emp_no				,			 --	사원번호(최종수정자)
		--													result_code		)	;		 --	처리결과코드?

		RETURN(	NULL );

	END	create_bill_edi_file;



	/*************************************************************************/
	/*																																			 */
	/*	1. 모듈ID	 : send_cash_each_transfer																 */
	/*	2. 모듈이름	 : 분할건별	현금이체 지급																 */
	/*	3. 시스템	 : 회계시스템																							 */
	/*	4. 서브시스템: FBS																									 */
	/*	5. 모듈유형	 :																											 */
	/*	6. 모듈언어	 : PL/SQL																								 */
	/*	7. 모듈환경	 : Windows2003 Server+ Oracle	9.2.0											 */
	/*	8. 모듈DBMS	 : Oracle																								 */
	/*	9. 모듈의	목적 및	주요기능																					 */
	/*																																			 */
	/*		-	담당자 확인	과정을 통해서	생성된 분할지급건	단위로 실제	은행과	 */
	/*			VAN을	통해서 전문(당타행이체)송수신을	수행한다.									 */
	/*			처리결과HISTORY는	HISTORY	TABLE(T_FB_CASH_PAY_HISTORY)에 저장		 */
	/*			되며,	처리결과는 RESP_CODE,	RESP_MSG로 반환된다.								 */
	/*																																			 */
	/*		-	본 함수는	단독으로 수행치	않으며,	SEND_CASH_TRANSFER에 의해서		 */
	/*			 호출되어	사용된다.																							 */
	/*																																			 */
	/*		-	반환값																													 */
	/*			OK : 정상	처리 시																								 */
	/*			오류메시지 : 기타	오류 발생시	(DEFAULT값:ERROR)									 */
	/*																																			 */
	/* 10. 최초작성자: LG	CNS	신인철																				 */
	/* 11. 최초작성일: 2005년12월21일																				 */
	/* 12. 최종수정자:																											 */
	/* 13. 최종수정일:																											 */
	/*************************************************************************/
	FUNCTION send_cash_each_transfer(	p_pay_seq			IN NUMBER	,			 --	지급일련번호
																		p_div_seq			IN NUMBER	,			 --	분할일련번호
																		p_emp_no			IN VARCHAR2	,		 --	사번
																		p_resp_code		OUT	VARCHAR2,		 --	응답코드
																		p_resp_msg		OUT	VARCHAR2 )	 --	응답코드명
		RETURN VARCHAR2	IS													 --	함수 처리결과	메시지
	BEGIN
		-- >>>>>>>>>>>>>	 처리로직		 <<<<<<<<<<<<<<<<<<
		--		sp_send_cash_each_transfer(	p_out_bank_code		 ,		 --	출금은행코드
		--																p_out_acct_number	 ,		 --	출금계좌번호
		--																p_in_bank_code		 ,		 --	입금은행코드
		--																p_in_acct_number	 ,		 --	입금계좌번호
		--																p_pay_amt					 ,		 --	이체금액									 
		--																p_commission			 ,		 --	수수료
		--																p_resp_code				 ,		 --	응답코드
		--																p_resp_msg				 ,		 --	응답코드명
		--																p_docu_numc				 ,		 --	전문번호
		--																p_send_date				 ,		 --	전송시간
		--																p_recv_date					);	 --	응답시간
		RETURN(	NULL );

	END	send_cash_each_transfer;


	/*************************************************************************/
	/*																																			 */
	/*	1. 모듈ID	 : send_cash_transfer																			 */
	/*	2. 모듈이름	 : 지급건별	현금이체 지급																 */
	/*	3. 시스템	 : 회계시스템																							 */
	/*	4. 서브시스템: FBS																									 */
	/*	5. 모듈유형	 :																											 */
	/*	6. 모듈언어	 : PL/SQL																								 */
	/*	7. 모듈환경	 : Windows2003 Server+ Oracle	9.2.0											 */
	/*	8. 모듈DBMS	 : Oracle																								 */
	/*	9. 모듈의	목적 및	주요기능																					 */
	/*																																			 */
	/*		-	지급건(T_FB_CASH_PAY_DATA) 단위로	처리되며,	실제 사용자가	화면	 */
	/*			을 통해서	호출되는 단위이며, 내부적으로	분할된 내역	각각에 대		 */
	/*			하여,	DIV_SEQ를	추가PARAMETER로	하여,	SEND_CASH_EACH_TRANSFER		 */
	/*			함수를 호출하여	처리한다.																				 */
	/*																																			 */
	/*		-	함수내부적으로 DIVIDE된	건수를 체크하고, 각각의	건에 대하여			 */
	/*			처리완료 후, 모두정상처리된	경우 혹은	일부실패,	전체실패에 대		 */
	/*			한 이력을	가지고 있다가	처리결과를 RETURN한다.									 */
	/*																																			 */
	/*		-	재전송시에도 본	함수를 사용하며, 지급실패/일부지급실패인 경우		 */
	/*			해당 지급실패건을	찾아서 SEND_CASH_EACH_TRANSFER를 재호출하여		 */
	/*			처리한다.																												 */
	/*																																			 */
	/*		-	함수내부적으로 SEND_CASH_EACH_TRANSFER를 호출하여	받은					 */
	/*			처리결과에 대하여	PAY_STATUS를 UPDATE한다.											 */
	/*			4: 지급완료																											 */
	/*			5: 지급실패																											 */
	/*			6: 일부지급실패	=> 여러분할건일때, 그중일부가	실패한 경우				 */
	/*			7: 전표취소																											 */
	/*																																			 */
	/*		-	반환값																													 */
	/*			정상처리 =>	정상 이체처리	완료 시																 */
	/*			일부지급실패:[오류메시지]																				 */
	/*					 =>	여러분할것인 경우, 일부	지급실패시 첫번째	오류					 */
	/*			지급실패:[오류메시지]																						 */
	/*					 =>	분할건이1건인	경우,	지급실패시 오류											 */
	/*			전표취소 =>	전표취소된 경우																			 */
	/*																																			 */
	/* 10. 최초작성자: LG	CNS	신인철																				 */
	/* 11. 최초작성일: 2005년12월21일																				 */
	/* 12. 최종수정자:																											 */
	/* 13. 최종수정일:																											 */
	/*************************************************************************/
	FUNCTION send_cash_transfer( p_pay_seq		 IN	NUMBER ,			-- 지급일련번호
															 p_emp_no			 IN	VARCHAR2 )		-- 사번
		RETURN VARCHAR2	IS												-- 함수	처리결과 메시지
	BEGIN
		-- >>>>>>>>>>>>>	 처리로직		 <<<<<<<<<<<<<<<<<<
		sp_send_cash_transfer( p_pay_seq		 ,		 --	지급일련번호
													 p_emp_no				);	 --	사번

		RETURN(	NULL );

	END	send_cash_transfer;



	/*************************************************************************/
	/*																																			 */
	/*	1. 모듈ID	 : send_bill_transfer																			 */
	/*	2. 모듈이름	 : 지급건별	전자어음 realtime	송신											 */
	/*	3. 시스템	 : 회계시스템																							 */
	/*	4. 서브시스템: FBS																									 */
	/*	5. 모듈유형	 :																											 */
	/*	6. 모듈언어	 : PL/SQL																								 */
	/*	7. 모듈환경	 : Windows2003 Server+ Oracle	9.2.0											 */
	/*	8. 모듈DBMS	 : Oracle																								 */
	/*	9. 모듈의	목적 및	주요기능																					 */
	/*																																			 */
	/*		-	Realtime으로 전자어음을	발행하는 기능을	수행합니다.							 */
	/*																																			 */
	/*		-	반환값																													 */
	/*			정상처리 =>	정상 발행처리	완료 시																 */
	/*			지급실패 =>	지급실패 오류																				 */
	/*			전표취소 =>	전표취소된 경우																			 */
	/*																																			 */
	/* 10. 최초작성자: LG	CNS	신인철																				 */
	/* 11. 최초작성일: 2005년12월21일																				 */
	/* 12. 최종수정자:																											 */
	/* 13. 최종수정일:																											 */
	/*************************************************************************/
	FUNCTION send_bill_transfer( p_pay_seq			 IN	NUMBER ,			-- 지급일련번호
															 p_emp_no				 IN	VARCHAR2 )		-- 사번
		RETURN VARCHAR2	IS												-- 함수	처리결과 메시지
	BEGIN
		-- >>>>>>>>>>>>>	 처리로직		 <<<<<<<<<<<<<<<<<<
	--sp_send_bill_transfer( p_pay_seq					 ,		 --	지급일련번호
	--											 p_out_bank_code		 ,		 --	출금은행코드
	--											 p_out_acct_number	 ,		 --	출금계좌번호
	--											 p_in_bank_code			 ,		 --	입금은행코드
	--											 p_in_acct_number		 ,		 --	입금계좌번호
	--											 p_regist_number		 ,		 --	사업자번호
	--											 p_check_no					 ,		 --	수표/어음번호
	--											 p_future_ymd				 ,		 --	만기일자
	--											 p_pay_amt					 ,		 --	이체금액
	--											 p_franchise_no			 ,		 --	가맹점번호
	--											 p_emp_no							)	;	 --	사번

		RETURN(	NULL );

	END	send_bill_transfer;




	/*************************************************************************/
	/*																		                                   */
	/*	1. 모듈ID	 : retieve_pay_summation								                   */
	/*	2. 모듈이름	 : 이체집계요청	처리									                   */
	/*	3. 시스템	 : 회계시스템											                         */
	/*	4. 서브시스템: FBS													                         */
	/*	5. 모듈유형	 :														                           */
	/*	6. 모듈언어	 : PL/SQL												                         */
	/*	7. 모듈환경	 : Windows2003 Server+ Oracle	9.2.0						           */
	/*	8. 모듈DBMS	 : Oracle												                         */
	/*	9. 모듈의	목적 및	주요기능											                     */
	/*																		                                   */
	/*		-	은행코드와 계좌번호를	입력받아,	이체처리집계요청을 하여	결과	   */
	/*			를 반환합니다.												                           */
	/*		-	실패건수,실패금액은	총건수/총금액에서	성공건수와 성공금액을	     */
	/*			차감하여 계산합니다.											                       */
	/*																		                                   */
	/* 10. 최초작성자: LG	CNS	신인철										                     */
	/* 11. 최초작성일: 2005년12월21일										                     */
	/* 12. 최종수정자:														                           */
	/* 13. 최종수정일:														                           */
	/*************************************************************************/
	PROCEDURE	retieve_pay_summation( p_bank_code		 IN	VARCHAR2 ,		 --	은행코드
									 p_acct_number		 IN	VARCHAR2 ,		 --	계좌번호
									 p_da_req_cnt		 OUT NUMBER	,			 --	당행 요청	건수
									 p_da_req_amt		 OUT NUMBER	,			 --	당행 요청	금액
									 p_da_success_cnt	 OUT NUMBER	,			 --	당행 정상처리	건수
									 p_da_success_amt	 OUT NUMBER	,			 --	당행 정상처리	금액
									 p_da_commission	 OUT NUMBER	,			 --	당행 수수료
									 p_ta_req_cnt		 OUT NUMBER	,			 --	타행 요청	건수
									 p_ta_req_amt		 OUT NUMBER	,			 --	타행 요청	금액
									 p_ta_success_cnt	 OUT NUMBER	,			 --	타행 정상처리	건수
									 p_ta_success_amt	 OUT NUMBER	,			 --	타행 정상처리	금액
									 p_ta_commission	 OUT NUMBER	,			 --	타행 수수료
									 p_resp_code		 OUT VARCHAR2,		 --	응답코드
									 p_resp_msg			 OUT VARCHAR2	)	IS	 --	응답코드명
		lrSend						FB_VAN_SEND_RECORD;
		lrRecv						FB_VAN_RECV_RECORD;
		lsRet						Varchar2(4000);
		p_result_code				Varchar2(4000);
		p_result_msg				Varchar2(4000);
		ltVars						T_Vars;
		ltNums						T_Nums;
	BEGIN
		-- >>>>>>>>>>>>>	 처리로직		 <<<<<<<<<<<<<<<<<<
		--.기본	초기화
		init_van_send_record(p_bank_code,p_acct_number,FB_DOCU_SUM_T,lrSend);
		-- 개별부	설정
		lrSend.gaeb_area :=		fbs_util_pkg.sprintf('%-15.15s', p_acct_number ) ||		--1.당행출금계좌번호
								fbs_util_pkg.sprintf('%-5.5s', ''	)	||					--2.당행의뢰총건수
								fbs_util_pkg.sprintf('%-13.13s', ''	)	||				--3.당행의뢰총금액
								fbs_util_pkg.sprintf('%-5.5s', ''	)	||					--4.당행정상건수
								fbs_util_pkg.sprintf('%-13.13s', ''	)	||				--5.당행정상금액
								fbs_util_pkg.sprintf('%-5.5s', ''	)	||					--6.당행불능건수
								fbs_util_pkg.sprintf('%-13.13s', ''	)	||				--7.당행불능금액
								fbs_util_pkg.sprintf('%-9.9s', ''	)	||					--8.당행수수료
								fbs_util_pkg.sprintf('%-5.5s', ''	)	||					--9.당행의뢰총건수
								fbs_util_pkg.sprintf('%-13.13s', ''	)	||				--10.타행의뢰총금액
								fbs_util_pkg.sprintf('%-5.5s', ''	)	||					--11.타행정상건수
								fbs_util_pkg.sprintf('%-13.13s', ''	)	||				--12.타행정상금액
								fbs_util_pkg.sprintf('%-5.5s', ''	)	||					--13.타행불능건수
								fbs_util_pkg.sprintf('%-13.13s', ''	)	||				--14.타행불능금액
								fbs_util_pkg.sprintf('%-9.9s', ''	)	||					--15.타행수수료
								fbs_util_pkg.sprintf('%-59.59s', ''	)	;					--16.예비

		lsRet	:= send_realtime_document(lrSend,DEFAULT_TIMEOUT,lrRecv,p_result_code,p_result_msg);

		If lsRet <>	SUCCESS_CODE Then
			p_resp_msg :=	lsRet;
			Return;
		End	If;
		ltNums(1)	:=	15;	--1.당행출금계좌번호
		ltNums(2)	:=	 5;	--2.당행의뢰총건수
		ltNums(3)	:=	13;	--3.당행의뢰총금액
		ltNums(4)	:=	 5;	--4.당행정상건수
		ltNums(5)	:=	13;	--5.당행정상금액
		ltNums(6)	:=	 5;	--6.당행불능건수
		ltNums(7)	:=	13;	--7.당행불능금액
		ltNums(8)	:=	 9;	--8.당행수수료
		ltNums(9)	:=	 5;	--9.당행의뢰총건수
		ltNums(10) :=	13;	--10.타행의뢰총금액
		ltNums(11) :=	 5;	--11.타행정상건수
		ltNums(12) :=	13;	--12.타행정상금액
		ltNums(13) :=	 5;	--13.타행불능건수
		ltNums(14) :=	13;	--14.타행불능금액
		ltNums(15) :=	 9;	--15.타행수수료
		ltNums(16) :=	59;	--16.예비

		ltVars :=	SplitDocu(lrRecv.gaeb_area,ltNums);

		p_da_req_cnt :=	To_Number(ltVars(2));
		p_da_req_amt :=	To_Number(ltVars(3));
		p_da_success_cnt :=	To_Number(ltVars(4));
		p_da_success_amt :=	To_Number(ltVars(5));
		p_da_commission	:= To_Number(ltVars(8));
		p_ta_req_cnt :=	To_Number(ltVars(9));
		p_ta_req_amt :=	To_Number(ltVars(10));
		p_ta_success_cnt :=	To_Number(ltVars(11));
		p_ta_success_amt :=	To_Number(ltVars(12));
		p_ta_commission	:= To_Number(ltVars(15));
		p_resp_code	:= p_result_code;
		p_resp_msg :=	p_result_msg;

	END	retieve_pay_summation;


	/*************************************************************************/
	/*																		                                   */
	/*	1. 모듈ID	 : retieve_acct_holder_name								                 */
	/*	2. 모듈이름	 : 예금주명	조회										                     */
	/*	3. 시스템	 : 회계시스템											                         */
	/*	4. 서브시스템: FBS													                         */
	/*	5. 모듈유형	 :														                           */
	/*	6. 모듈언어	 : PL/SQL												                         */
	/*	7. 모듈환경	 : Windows2003 Server+ Oracle	9.2.0						           */
	/*	8. 모듈DBMS	 : Oracle												                         */
	/*	9. 모듈의	목적 및	주요기능											                     */
	/*																		                                   */
	/*		-	입력된 은행코드	및 계좌번호에	대한 예금주명을	VAN과	전문을	     */
	/*			송수신하여,	구해옵니다.										                       */
	/*			정상적으로 처리된	경우,	RESP_CODE가	"0000"으로 반환된	경우만	   */
	/*			정상적으로 조회된	경우임.										                     */
	/*																		                                   */
	/*		-	반환값														                               */
	/*			OK : 정상	처리 시											                           */
	/*			오류메시지 : 기타	오류 발생시	(DEFAULT값:ERROR)				           */
	/*																		                                   */
	/* 10. 최초작성자: LG	CNS	신인철										                     */
	/* 11. 최초작성일: 2005년12월21일										                     */
	/* 12. 최종수정자:														                           */
	/* 13. 최종수정일:														                           */
	/*************************************************************************/
	FUNCTION retieve_acct_holder_name( p_bank_code		 IN	VARCHAR2 ,		 --	은행코드
										                 p_acct_number	 IN	VARCHAR2 ,		 --	계좌번호
										                 p_holder_name	 OUT VARCHAR2,		 --	예금주명
										                 p_resp_code		 OUT VARCHAR2,		 --	응답코드
										                 p_resp_msg		   OUT VARCHAR2	)		 --	응답코드명
		RETURN VARCHAR2	IS													 --	함수 처리결과	메시지
	BEGIN
		-- >>>>>>>>>>>>>	 처리로직		 <<<<<<<<<<<<<<<<<<
		--p_holder_name := f_retrive_acct_holder_name( p_bank_code	,	   -- 은행코드
		--													                   p_acct_number,	   -- 계좌번호
		--													                   p_biz_number	  )	 -- 주민(사업자)번호

		RETURN(	NULL );

	END	retieve_acct_holder_name;




	/*************************************************************************/
	/*																		                                   */
	/*	1. 모듈ID	   : read_bill_vendor_info								                 */
	/*	2. 모듈이름	 : 전자어음	거래선정보 수신	처리						             */
	/*	3. 시스템	   : 회계시스템											                       */
	/*	4. 서브시스템: FBS													                         */
	/*	5. 모듈유형	 :														                           */
	/*	6. 모듈언어	 : PL/SQL												                         */
	/*	7. 모듈환경	 : Windows2003 Server+ Oracle	9.2.0						           */
	/*	8. 모듈DBMS	 : Oracle												                         */
	/*	9. 모듈의	목적 및	주요기능											                     */
	/*																		                                   */
	/*		-	은행으로부터 수신된	전자어음 거래선정보파일명(경로포함)을	읽	   */
	/*			어서,	전자어음협력업체(T_FB_BILL_VENDORS)에 반영한다.		         */
	/*																		                                   */
	/*		-	파일명 은행과협의(기업은행,하나은행)	                           */
	/*			 V_사업장코드(2)_은행코드(2)_날짜(8)_일련번호(3).dat			       */
	/*																		                                   */
	/*		-	신규/변경/해지 모두	해당 TABLE에 INSERT를	수행하며,	별도의	     */
	/*			VIEW를 통해서	현재 업체의	상태를 확인할	수 있도록	한다.		       */
	/*																		                                   */
	/*		-	반환값														                               */
	/*			OK : 정상	처리 시											                           */
	/*			오류메시지 : 기타	오류 발생시	(DEFAULT값:ERROR)				           */
	/*																		                                   */
	/* 10. 최초작성자: LG	CNS	신인철										                     */
	/* 11. 최초작성일: 2005년12월21일										                     */
	/* 12. 최종수정자:														                           */
	/* 13. 최종수정일:														                           */
	/*************************************************************************/
	FUNCTION read_bill_vendor_info(	p_edi_history_seq	 IN	NUMBER )				-- EDI송수신이력 일련번호
		RETURN VARCHAR2	IS														-- 함수	처리결과 메시지
	BEGIN
		-- >>>>>>>>>>>>>	 처리로직		 <<<<<<<<<<<<<<<<<<
		-- sp_read_bill_vendor_info( comp_code        ,       -- 시압징코드
		--                           bank_code        ,       -- 은행코드
		--                           emp_no            )      -- 사원번호

		RETURN(	NULL );

	END	read_bill_vendor_info;



	/*************************************************************************/
	/*																		                                   */
	/*	1. 모듈ID	 : read_bill_result										                     */
	/*	2. 모듈이름	 : 전자어음	처리결과 수신	처리							             */
	/*	3. 시스템	 : 회계시스템											                         */
	/*	4. 서브시스템: FBS													                         */
	/*	5. 모듈유형	 :														                           */
	/*	6. 모듈언어	 : PL/SQL												                         */
	/*	7. 모듈환경	 : Windows2003 Server+ Oracle	9.2.0						           */
	/*	8. 모듈DBMS	 : Oracle												                         */
	/*	9. 모듈의	목적 및	주요기능											                     */
	/*																		                                   */
	/*		-	사용자 화면으로부터	해당 EDI송수신이력의 SEQ를 받아, 수신파일	   */
	/*			명을 조회하여, 파일을	오픈한 후, 채권번호에	해당하는 지급건을	   */
	/*			찾아서 처리결과를	UPDATE한다.									                   */
	/*																		                                   */
	/*		-	파일명 명명규칙은	다음과 같이	함 (송수신이력테이블에 있음)	     */
	/*			 BR_사업장코드(2)_은행코드(2)_날짜(8)_일련번호(3).dat				     */
	/*																		                                   */
	/*		-	처리결과에 따라서	각 지급건에	대하여 상태(PAY_STATUS)를	UPDATE   */
	/*			4: 발행완료													                             */
	/*			5: 발행실패													                             */
	/*                                                                       */ 
	/*		-	반환값														                               */
	/*			OK : 정상	처리 시											                           */
	/*			오류메시지 : 기타	오류 발생시	(DEFAULT값:ERROR)				           */
	/*																		                                   */
	/* 10. 최초작성자: LG	CNS	신인철										                     */
	/* 11. 최초작성일: 2005년12월21일										                     */
	/* 12. 최종수정자:														                           */
	/* 13. 최종수정일:														                           */
	/*************************************************************************/
	FUNCTION read_bill_result(	p_edi_history_seq	 IN	NUMBER ,			-- EDI송수신이력 일련번호
								              p_emp_no			     IN	VARCHAR2 )		-- 사번
		RETURN VARCHAR2	IS														-- 함수	처리결과 메시지
	BEGIN
		-- >>>>>>>>>>>>>	 처리로직		 <<<<<<<<<<<<<<<<<<
		--sp_read_bill_result( comp_code        ,        -- 사업장 코드
		--                     bank_code        ,        -- 은행코드
    --                     file_name        ,        -- 파일명
    --                     edi_history_seq   ) ;     -- edi이력일련번호

		RETURN(	NULL );

	END	read_bill_result;


	/*************************************************************************/
	/*																		                                   */
	/*	1. 모듈ID	 : read_cash_result										                     */
	/*	2. 모듈이름	 : 현금이체파일	처리결과 수신	처리						           */
	/*	3. 시스템	 : 회계시스템											                         */
	/*	4. 서브시스템: FBS													                         */
	/*	5. 모듈유형	 :														                           */
	/*	6. 모듈언어	 : PL/SQL												                         */
	/*	7. 모듈환경	 : Windows2003 Server+ Oracle	9.2.0						           */
	/*	8. 모듈DBMS	 : Oracle												                         */
	/*	9. 모듈의	목적 및	주요기능											                     */
	/*																		                                   */
	/*		-	사용자 화면으로부터	해당 EDI송수신이력의 SEQ를 받아, 수신파일	   */
	/*			명을 조회하여, 파일을	오픈한 후, 해당하는	지급건을			         */
	/*			찾아서 처리결과를	UPDATE한다.									                   */
	/*																		                                   */
	/*		-	파일명 명명규칙은	다음과 같이	함 (송수신이력테이블에 있음)	     */
	/*			 CR_사업장코드(2)_은행코드(2)_날짜(8)_일련번호(3).dat			       */
	/*																		                                   */
	/*		-	처리결과에 따라서	각 지급건에	대하여 상태(PAY_STATUS)를	UPDATE   */
	/*			4: 지급성공													                             */
	/*			5: 지급실패													                             */
	/*                                                                       */
	/*		-	반환값														                               */
	/*			OK : 정상	처리 시											                           */
	/*			오류메시지 : 기타	오류 발생시	(DEFAULT값:ERROR)				           */
	/*																		                                   */
	/* 10. 최초작성자: LG	CNS	신인철										                     */
	/* 11. 최초작성일: 2006년1월10일										                     */
	/* 12. 최종수정자:														                           */
	/* 13. 최종수정일:														                           */
	/*************************************************************************/
	FUNCTION read_cash_result(	p_edi_history_seq	 IN	NUMBER ,		-- EDI송수신이력 일련번호
								              p_emp_no			     IN	VARCHAR2 )	-- 사번
		RETURN VARCHAR2	IS														-- 함수	처리결과 메시지
	BEGIN
		-- >>>>>>>>>>>>>	 처리로직		 <<<<<<<<<<<<<<<<<<
		--sp_read_cash_result( comp_code        ,        -- 사업장 코드
		--                     bank_code        ,        -- 은행코드
    --                     file_name        ,        -- 파일명
    --                     edi_history_seq   ) ;     -- edi이력일련번호

		RETURN(	NULL );

	END	read_cash_result;

	/*************************************************************************/
	/*																		                                   */
	/*	1. 모듈ID	 : do_job_task											                       */
	/*	2. 모듈이름	 : 일정주기별로	수행되는 job에 대한	총괄 호출	함수		   */
	/*	3. 시스템	 : 회계시스템											                         */
	/*	4. 서브시스템: FBS													                         */
	/*	5. 모듈유형	 :														                           */
	/*	6. 모듈언어	 : PL/SQL												                         */
	/*	7. 모듈환경	 : Windows2003 Server+ Oracle	9.2.0						           */
	/*	8. 모듈DBMS	 : Oracle												                         */
	/*	9. 모듈의	목적 및	주요기능											                     */
	/*																		                                   */
	/*		-	일정한 주기별로	수행되는 JOB에 등록된	TASK에 대하여	적절한	     */
	/*			조회조건 및	필요PARAMETER를	선정하여 호출하는	총괄함수		       */
	/*																		                                   */
	/*		-	JOB에	의하여 처리되는	내역을 아래와	같음						             */
	/*																		                                   */
	/*			(1)	개시전문발송												                         */
	/*			 : 매일아침에	FBS약정계좌에	해당하는 은행을	SELECT한 후	,	       */
	/*				 send_start_document를 호출하여, 개시전문을	송신한다.		       */
	/*																		                                   */
	/*			(2)	FBS상태메일	발송											                       */
	/*			 : 등록된	사용자에게 FBS상태를 체크하는	로직을 수행한	결과를     */
	/*				 메일에	담아서 발송한다.									                     */
	/*																		                                   */
	/*			(3)	전자어음 거래선정보	수신 및	처리							               */
	/*			 : 매일아침에	은행으로부터 거래선	정보를 수신한	후,	처리	       */
	/*																		                                   */
	/*			(4)	예금거래명세 결번	처리									                     */
	/*			 : 예금거래명세중, 결번내역을	자동으로 체크하여	결번요청 및	     */
	/*				 응답에	대한 처리를	수행한다.	1시간	단위 수행				           */
	/*																		                                   */
	/*			(5)	전자어음 거래명세	결번 처리								                   */
	/*			 : 전자어음	거래명세 중, 결번내역을	자동으로 체크하여	결번	     */
	/*				 요청	및 응답에	대한 처리를	수행한다.	1시간	단위 수행		       */
	/*																		                                   */
	/*			(6)	전 계좌에	대한 일괄	일말잔액 조회							               */
	/*			 : 정해진	시간에 FBS계좌로 등록된	모든 계좌에	대하여 일괄적	     */
	/*				 으로	시스템이 자동으로	잔액조회 전문을	송수신 한다.		       */
	/*																		                                   */
	/*			(7)	분양전송데이타	오류확인									                   */
	/*			 : 입금/입금취소내역에 대하여	분양시스템으로 전송할때, 전송	     */
	/*				 이력을	확인하여,	미전송이력내역을 재전송시도하며, 다시	       */
	/*				 오류가	발생시는,	기 등록된	인원에게 메일을	발송한다.		       */
	/*																		                                   */
	/* 10. 최초작성자: LG	CNS	신인철										                     */
	/* 11. 최초작성일: 2005년12월21일										                     */
	/* 12. 최종수정자:														                           */
	/* 13. 최종수정일:														                           */
	/*************************************************************************/
	PROCEDURE	do_job_task	IS

	BEGIN
		-- >>>>>>>>>>>>>	 처리로직		 <<<<<<<<<<<<<<<<<<		
		sp_bank_opening();    -- 개시전문발송
		sp_bank_depomiss();   -- 예금거래명세 결번	처리
		sp_bank_checkmiss(); 	-- 전자어음 거래명세	결번 처리
		sp_bill_vendor();     -- 전자어음 거래선정보	수신 및	처리

	END	 do_job_task;



	/*************************************************************************/
	/*																		                                   */
	/*	1. 모듈ID	 : send_tran_fail_mail									                   */
	/*	2. 모듈이름	 : 타행이체불능	통지메일 발송							               */
	/*	3. 시스템	 : 회계시스템											 */
	/*	4. 서브시스템: FBS													 */
	/*	5. 모듈유형	 :														 */
	/*	6. 모듈언어	 : PL/SQL												 */
	/*	7. 모듈환경	 : Windows2003 Server+ Oracle	9.2.0						 */
	/*	8. 모듈DBMS	 : Oracle												 */
	/*	9. 모듈의	목적 및	주요기능											 */
	/*																		 */
	/*		-	본 함수는	TRIGGER에서	호출되며,	타행이체실행 후, 이체불능	통지 */
	/*			가 왔을때, T_FB_LOOKUP_VALUES의	LOOKUP_TYPE=TRAN_FAIL_MAIL_TO	 */
	/*			항목으로 등록된	사용자에게 메일을	발송합니다.					 */
	/*																		 */
	/*		-	은행으로부터 온	전문번호에 해당하는	지급건을 찾아서	지급내역에 */
	/*			대한 정보를	포함하여 메일을	발송한다.							 */
	/*																		 */
	/*		-	반환값														 */
	/*			OK : 정상	처리 시											 */
	/*			오류메시지 : 기타	오류 발생시	(DEFAULT값:ERROR)				 */
	/*																		 */
	/* 10. 최초작성자: LG	CNS	신인철										 */
	/* 11. 최초작성일: 2005년12월21일										 */
	/* 12. 최종수정자:														 */
	/* 13. 최종수정일:														 */
	/*************************************************************************/
	FUNCTION send_tran_fail_mail(	p_comp_code			IN VARCHAR2	,			 --	사업장코드
									p_bank_code			IN VARCHAR2	,			 --	은행코드
									p_docu_numc			IN VARCHAR2	)			 --	전문번호
		RETURN VARCHAR2	IS													 --	함수 처리결과	메시지
	BEGIN


		-- >>>>>>>>>>>>>	 처리로직		 <<<<<<<<<<<<<<<<<<


		RETURN(	NULL );

	END	send_tran_fail_mail;



	/*************************************************************************/
	/*																		 */
	/*	1. 모듈ID	 : create_paydue_mail_data								 */
	/*	2. 모듈이름	 : 지급예정	메일데이타 생성								 */
	/*	3. 시스템	 : 회계시스템											 */
	/*	4. 서브시스템: FBS													 */
	/*	5. 모듈유형	 :														 */
	/*	6. 모듈언어	 : PL/SQL												 */
	/*	7. 모듈환경	 : Windows2003 Server+ Oracle	9.2.0						 */
	/*	8. 모듈DBMS	 : Oracle												 */
	/*	9. 모듈의	목적 및	주요기능											 */
	/*																		 */
	/*		-	대금결제할 업체로	지급건에 대하여	지급예정메일을 발송할	자료를 */
	/*			생성합니다.	조건은 사업장/지급예정일자/사업자	를 조건으로	함	 */
	/*																		 */
	/*		-	사업장/지급예정일은	필수사항이며,	거래처는 선택사양임			 */
	/*																		 */
	/*		-	생성은 T_FB_PAYDUE_MAIL_MASTER와 T_FB_PAYDUE_MAIL_DETAIL에	 */
	/*			기존 RECORD를	삭제하고,	INSERT하며,	기 발송된	이력이 있는	경우 */
	/*			MASTER는 재생성하지	않으며,	DETAIL만 재	생성 후, 발송이력을	 */
	/*			미발송 상태로	UPDATE한다.										 */
	/*																		 */
	/*		-	반환값														 */
	/*			OK : 정상	처리 시											 */
	/*			오류메시지 : 기타	오류 발생시	(DEFAULT값:ERROR)				 */
	/*																		 */
	/* 10. 최초작성자: LG	CNS	신인철										 */
	/* 11. 최초작성일: 2005년12월21일										 */
	/* 12. 최종수정자:														 */
	/* 13. 최종수정일:														 */
	/*************************************************************************/
	FUNCTION create_paydue_mail_data(	p_comp_code			IN VARCHAR2	,			 --	사업장코드
										p_pay_ymd				IN VARCHAR2	,			 --	지급예정일자
										p_vendor_seq			IN NUMBER	)			 --	거래처일련번호
		RETURN VARCHAR2	IS														 --	함수 처리결과	메시지
	BEGIN


		-- >>>>>>>>>>>>>	 처리로직		 <<<<<<<<<<<<<<<<<<


		RETURN(	NULL );

	END	create_paydue_mail_data;



	/*************************************************************************/
	/*																		 */
	/*	1. 모듈ID	 : send_paydue_mail										 */
	/*	2. 모듈이름	 : 지급예정	메일 발송									 */
	/*	3. 시스템	 : 회계시스템											 */
	/*	4. 서브시스템: FBS													 */
	/*	5. 모듈유형	 :														 */
	/*	6. 모듈언어	 : PL/SQL												 */
	/*	7. 모듈환경	 : Windows2003 Server+ Oracle	9.2.0						 */
	/*	8. 모듈DBMS	 : Oracle												 */
	/*	9. 모듈의	목적 및	주요기능											 */
	/*																		 */
	/*		-	메일발송데이타의 SEQ(일련번호)를 입력받아, 메일포맷에	맞춰서	 */
	/*			데이타를 추출하여	메일을 발송합니다.							 */
	/*																		 */
	/*		-	메일 수신자는	거래처코드(T_CUST_CODE)테이블의	거래처별 출납	 */
	/*			담당자명 및	담당자 이메일	주소를 SELECT하여	설정한다.			 */
	/*																		 */
	/*		-	반환값														 */
	/*			OK : 정상	처리 시											 */
	/*			오류메시지 : 기타	오류 발생시	(DEFAULT값:ERROR)				 */
	/*																		 */
	/* 10. 최초작성자: LG	CNS	신인철										 */
	/* 11. 최초작성일: 2005년12월21일										 */
	/* 12. 최종수정자:														 */
	/* 13. 최종수정일:														 */
	/*************************************************************************/
	FUNCTION send_paydue_mail( p_mail_seq			IN NUMBER	,					 --	메일일련번호
								 p_emp_no				IN VARCHAR2	)					 --	사번
		RETURN VARCHAR2	IS														 --	함수 처리결과	메시지
	BEGIN


		-- >>>>>>>>>>>>>	 처리로직		 <<<<<<<<<<<<<<<<<<


		RETURN(	NULL );

	END	send_paydue_mail;


	/*************************************************************************/
	/*																		                                   */
	/*	1. 모듈ID	 : create_transfer_slip_data							                 */
	/*	2. 모듈이름	 : 예금이체	전표생성/이체데이타	생성					           */
	/*	3. 시스템	 : 회계시스템											                         */
	/*	4. 서브시스템: FBS													                         */
	/*	5. 모듈유형	 :														                           */
	/*	6. 모듈언어	 : PL/SQL												                         */
	/*	7. 모듈환경	 : Windows2003 Server+ Oracle	9.2.0						           */
	/*	8. 모듈DBMS	 : Oracle												                         */
	/*	9. 모듈의	목적 및	주요기능											                     */
	/*																		                                   */
	/*		-	등록한 예금이체	내역에 대하여	전표생성 및	이체를 실행할	수 있	   */
	/*			는 이체데이타(T_FB_CASH_PAY_DATA의 RECORD)로 생성합니다		       */
	/*																		                                   */
	/*		-	전표는 회계쪽으로	자동전표를 생성하며, 생성후의	전표번호를	     */
	/*			예금이체정보테이블(T_FB_CASH_TRANSFER_DATA)에	UPDATE한다.		     */
	/*																		                                   */
	/*		-	이체데이타가 정상적으로	생성되면,	지급일련번호(PAY_SEQ)를	받아   */
	/*			예금이체정보테이블(T_FB_CASH_TRANSFER_DATA)에	UPDATE한다.		     */
	/*																		                                   */
	/*		-	반환값														                               */
	/*			OK : 정상적으로	전표생성/이체데이타생성	완료 처리	시		         */
	/*			오류메시지 : 기타	오류 발생시								                     */
	/*				 =>	전표생성실패 , 이체데이타	생성 실패	등				             */
	/*																		                                   */
	/* 10. 최초작성자: LG	CNS	신인철										                     */
	/* 11. 최초작성일: 2005년12월21일										                     */
	/* 12. 최종수정자:														                           */
	/* 13. 최종수정일:														                           */
	/*************************************************************************/
	FUNCTION create_transfer_slip_data(	p_transfer_seq	 IN	NUMBER ,			-- 예금이체일련번호
										                  p_emp_no		     IN	VARCHAR2 )		-- 사번
		RETURN VARCHAR2	IS														-- 함수	처리결과 메시지
	BEGIN


		-- >>>>>>>>>>>>>	 처리로직		 <<<<<<<<<<<<<<<<<<


		RETURN(	NULL );

	END	create_transfer_slip_data;


	/*************************************************************************/
	/*																		 */
	/*	1. 모듈ID	 : extract_hr_pay_data									 */
	/*	2. 모듈이름	 : 인사지급데이타	추출									 */
	/*	3. 시스템	 : 회계시스템											 */
	/*	4. 서브시스템: FBS													 */
	/*	5. 모듈유형	 :														 */
	/*	6. 모듈언어	 : PL/SQL												 */
	/*	7. 모듈환경	 : Windows2003 Server+ Oracle	9.2.0						 */
	/*	8. 모듈DBMS	 : Oracle												 */
	/*	9. 모듈의	목적 및	주요기능											 */
	/*																		 */
	/*		-	추출화면의 조회조건(사업장,지급년월,지급구분)에	대하여 변수로	 */
	/*			입력받아,	HR쪽의 VIEW를	통해서 데이타를	FBS로	이관작업을 수행	 */
	/*																		 */
	/*		-	HR쪽에서는 "급여이력-급상여실적(지급이력MASTER)"(GLIS002TT)를	 */
	/*			SELECT하여,	필요데이타를 조회한	후,	"인터페이스_인사"테이블	 */
	/*			(T_FB_INTERFACE_HR)에	INSERT를 수행한다.						 */
	/*																		 */
	/*		-	동시에 현금지급데이타(T_FB_CASH_PAY_DATA)에도	지급내역에 대한	 */
	/*			INSERT작업을 수행하며, 생성된	PAY_SEQ를	T_FB_INTERFACE_PH의	 */
	/*			RECORD에 UPDATE하는	작업을 하여, 연결고리	역할을 한다.		 */
	/*																		 */
	/*		-	기존에 추출된	데이타가 있는	경우,	추출상태가 "정상전송(T)' 및	 */
	/*			'전표취소(C)'인	상태에서만 신규	재추출이 가능하다.			 */
	/*			'지급대기중(W)'	이나 '지급완료(P)'인 상태에서는	재추출이 불가	 */
	/*																		 */
	/*		-	반환값														 */
	/*			OK : 정상적으로	추출완료시 =>	'정상전송(T)'상태				 */
	/*			오류메시지 : 기타	오류 발생시	 오류	메시지					 */
	/*																		 */
	/* 10. 최초작성자: LG	CNS	신인철										 */
	/* 11. 최초작성일: 2005년12월21일										 */
	/* 12. 최종수정자:														 */
	/* 13. 최종수정일:														 */
	/*************************************************************************/
	FUNCTION extract_hr_pay_data(	p_comp_code			IN VARCHAR2	,			 --	사업장코드
									p_pay_ym				IN VARCHAR2	,			 --	지급예정 년월
									p_gubun				IN VARCHAR2	,			 --	구분
									p_emp_no				IN VARCHAR2	,			 --	사번
									p_extract_cnt			OUT	NUMBER	,			 --	총 추출	건수
									p_extract_amt			OUT	NUMBER	)			 --	총 추출	금액
		RETURN VARCHAR2	IS													 --	함수 처리결과	메시지
	BEGIN


		-- >>>>>>>>>>>>>	 처리로직		 <<<<<<<<<<<<<<<<<<


		RETURN(	NULL );

	END	extract_hr_pay_data;



	/*************************************************************************/
	/*																		                                   */
	/*	1. 모듈ID	 : check_bill_vendor									                     */
	/*	2. 모듈이름	 : 업체등록시	전자어음거래처로 등록된	업체인지 확인		   */
	/*	3. 시스템	 : 회계시스템											                         */
	/*	4. 서브시스템: FBS													                         */
	/*	5. 모듈유형	 :														                           */
	/*	6. 모듈언어	 : PL/SQL												                         */
	/*	7. 모듈환경	 : Windows2003 Server+ Oracle	9.2.0						           */
	/*	8. 모듈DBMS	 : Oracle												                         */
	/*	9. 모듈의	목적 및	주요기능											                     */
	/*																		                                   */
	/*		-	재무회계시스템에서 업체등록시, 해당	업체가 특정사업장,은행에	   */
	/*			전자어음 거래처로	등록되어 있는지	확인하는 함수				           */
	/*																		                                   */
	/*		-	내부적으로 "전자어음협력업체(T_FB_BILL_VENDORS)"테이블을 조회	   */
	/*			하여,	가장최근의 상태	결과값을 반환합니다						             */
	/*																		                                   */
	/*		-	반환값														                               */
	/*			OK : 정상적으로	약정된 업체인	경우							                 */
	/*			오류메시지 : 기타	오류 발생시	 오류	메시지					             */
	/*																		                                   */
	/* 10. 최초작성자: LG	CNS	신인철										                     */
	/* 11. 최초작성일: 2006년	1월	5일										                     */
	/* 10. 최종수정자: LG	CNS	신인철										                     */
	/* 11. 최종수정일: 2006년	1월	5일										                     */
	/*************************************************************************/
	FUNCTION check_bill_vendor(	p_comp_code			IN VARCHAR2	,		 --	사업장코드
								p_bank_code			IN VARCHAR2	,		 --	은행코드
								p_bizno				IN VARCHAR2	)		 --	사업자번호
		RETURN VARCHAR2	IS												 --	함수 처리결과	메시지

		v_return_msg			VARCHAR2(300)	:= SUCCESS_CODE;
		rec_fb_bill_vendors		T_FB_BILL_VENDORS%ROWTYPE;

		ERR_PARAM_ERROR			EXCEPTION;		 --입력받은	PARAMTER가 오류인	경우.

	BEGIN

		-- 입력받은	PARAMETER에	대한 VALID를 체크합니다.
		IF p_comp_code IS	NULL or	LENGTH(p_comp_code)	=	0	THEN
			v_return_msg :=	'사업장코드가	NULL이거나,	잘못된 값입니다.';

		ELSIF	p_bank_code	IS NULL	or LENGTH(p_bank_code) = 0 THEN
			v_return_msg :=	'은행코드가	NULL이거나,	잘못된 값입니다.';

		ELSIF	p_bizno	IS NULL	or LENGTH(p_bizno) = 0 THEN
			v_return_msg :=	'사업자번호가	NULL이거나,	잘못된 값입니다.';
		END	IF;

		-- 해당	사업장/은행/사업자번호에 해당하는	업체상태를 조회합니다.
		BEGIN
			SELECT *
				INTO rec_fb_bill_vendors
				FROM T_FB_BILL_VENDORS
			 WHERE BANK_CODE = p_bank_code
				 AND COMP_CODE = p_comp_code
				 AND VAT_REGISTRATION_NUM	=	REPLACE(p_bizno,'-','')
				 AND SEQ = (	SELECT MAX(SEQ)
								FROM T_FB_BILL_VENDORS
							 WHERE BANK_CODE = p_bank_code
								 AND COMP_CODE = p_comp_code
								 AND VAT_REGISTRATION_NUM	=	REPLACE(p_bizno,'-','')	);

			IF rec_fb_bill_vendors.contract_gubun	=	'C'	THEN
				v_return_msg :=	'해당	업체는 약정해지된	업체입니다.(해지일:' ||	rec_fb_bill_vendors.change_ymd ||	')';
			END	IF;

		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				v_return_msg :=	'미약정이거나, 약정정보가	없습니다.';

			WHEN OTHERS	THEN
				v_return_msg :=	fbs_util_pkg.format_msg( sqlerrm );
		END;

		RETURN(	v_return_msg );

	EXCEPTION
		WHEN ERR_PARAM_ERROR THEN
			RETURN(	v_return_msg );

		WHEN OTHERS	THEN
			RETURN(	fbs_util_pkg.format_msg( sqlerrm ) );

	END	check_bill_vendor;



	/*************************************************************************/
	/*																		 */
	/*	1. 모듈ID	 : send_realtime_document								 */
	/*	2. 모듈이름	 : RealTimeVAN송신Table에	넣고,일정시간동안	수신대기처리 */
	/*	3. 시스템	 : 회계시스템											 */
	/*	4. 서브시스템: FBS													 */
	/*	5. 모듈유형	 :														 */
	/*	6. 모듈언어	 : PL/SQL												 */
	/*	7. 모듈환경	 : Windows2003 Server+ Oracle	9.2.0						 */
	/*	8. 모듈DBMS	 : Oracle												 */
	/*	9. 모듈의	목적 및	주요기능											 */
	/*																		 */
	/*		-	parameter로	넘겨받은 전송RECORD를	VAN송신TABLE에 INSERT를	한후 */
	/*			REALTIME_TEMP_DIR에	전문파일을 생성한	후,	REALTIME_SEND_DIR에	 */
	/*			FILE MOVE를	시킨 후에, 일정시간동안	대기하여,	수신TABLE에		 */
	/*			결과RECORD가 오는	경우,	수신RECORD에 내용을	담아서 반환한다.	 */
	/*																		 */
	/*		-	생성시키는 파일은	전문 개별	각각에 대하여	1개	파일이 생성되며	 */
	/*			각 파일은	1개	줄에 300Byte의 전문전체내역을	담은 파일	생성	 */
	/*																		 */
	/*		-	파일명 명명규칙은	아래와 같습니다. 확장자는	.rec 라고	붙인다	 */
	/*		 사업장코드(2)_은행코드(2)_전문구분코드(6)_날짜(8)_전문번호(6).rec */
	/*																		 */
	/*		-	파일MOVE는 FBS_UTIL_PKG의	exec_os_command	함수를 사용하여		 */
	/*			처리한다.														 */
	/*																		 */
	/*		-	timeout값이	오는 경우,(초단위) 이것을	적용하며,	NULL값이 입력	 */
	/*			되는 경우, DEFAULT_TIMEOUT 값이	적용된다.						 */
	/*																		 */
	/*		-	반환값														 */
	/*			OK : 정상적으로	추출완료시 =>	'정상전송(T)'상태				 */
	/*			오류메시지 : 기타	오류 발생시	 오류	메시지					 */
	/*																		 */
	/* 10. 최초작성자: LG	CNS	신인철										 */
	/* 11. 최초작성일: 2005년12월21일										 */
	/* 10. 최종수정자: LG	CNS	신인철										 */
	/* 11. 최종수정일: 2006년	1월	3일										 */
	/*************************************************************************/
	FUNCTION send_realtime_document( p_rec_send			 IN	FB_VAN_SEND_RECORD ,	 --	송신RECORD
									 p_timeout			 IN	NUMBER ,				 --	최대대기시간
									 p_rec_recv			 OUT FB_VAN_RECV_RECORD	,	 --	수신RECORD
									 p_result_code	 OUT VARCHAR2	 ,			 --	처리결과코드
									 p_result_msg		 OUT VARCHAR2	 )			 --	처리결과메시지
		RETURN VARCHAR2	IS															 --	함수 처리결과	메시지

		v_return_msg			 VARCHAR2(200) :=	SUCCESS_CODE;		 --	반환메시지
		v_file_name				 VARCHAR2(100);				 --	전문파일이름
		v_temp_file_path		 VARCHAR2(200);				 --	임시파일위치경로
		v_send_file_path		 VARCHAR2(200);				 --	송신파일위치경로
		v_document_buffer		 VARCHAR2(400);				 --	전문파일내용(BUFFER)
		v_dummy_return			 VARCHAR2(100);

		d_start_dt				 DATE;						 --	수신대기 시작시간
		n_start_time			 NUMBER(20)	:= 0;				 --	프로그램이 시작한	시간(초단위로	환산된 값)
		n_curr_time				 NUMBER(20)	:= 0;				 --	응답대기를 위하여	현재 시간(초단위로 환산된	값)

		v_output_file					UTL_FILE.FILE_TYPE;

		ERR_INVALID_OPERATION			EXCEPTION;			 --	잘못된 수행인경우...
		ERR_MAKE_TEMP_FILE_ERR			EXCEPTION;			 --	전문파일생성 시	오류가 발생한	경우...

	BEGIN

		 --	0) 입력된	parameter값에	대한 validation을	수행합니다.
		 ---------------------------------------------------------

		 IF	p_timeout	IS NULL	or p_timeout < 1 THEN
			 v_return_msg	:= 'TIMEOUT으로	입력된 값은	숫자로 0 이상의	값이어야 합니다.';
			 RAISE ERR_INVALID_OPERATION;

		 ELSIF p_rec_send.ente_code	IS NULL	or LENGTH(p_rec_send.ente_code)	=	0	THEN
			 v_return_msg	:= '업체코드(ENTE_CODE)가	셋팅되지 않았습니다.';
			 RAISE ERR_INVALID_OPERATION;

		 ELSIF p_rec_send.bank_code	IS NULL	or LENGTH(p_rec_send.bank_code)	!= 2 THEN
			 v_return_msg	:= '은행코드(BANK_CODE)가	셋팅되지 않았거나, NULL값이	입력되었습니다.';
			 RAISE ERR_INVALID_OPERATION;

		 ELSIF p_rec_send.docu_code	IS NULL	or LENGTH(p_rec_send.docu_code)	!= 4 THEN
			 v_return_msg	:= '전문구분코드(DOCU_CODE)가	셋팅되지 않았거나, 잘못된	값이 입력되었습니다.';
			 RAISE ERR_INVALID_OPERATION;

		 ELSIF p_rec_send.upmu_code	IS NULL	or LENGTH(p_rec_send.upmu_code)	!= 3 THEN
			 v_return_msg	:= '업부구분코드(UPMU_CODE)가	셋팅되지 않았거나, 잘못된	값이 입력되었습니다.';
			 RAISE ERR_INVALID_OPERATION;

		 ELSIF p_rec_send.docu_numc	IS NULL	or LENGTH(p_rec_send.docu_numc)	!= 6 THEN
			 v_return_msg	:= '전문번호(DOCU_NUMC)가	셋팅되지 않았거나, 잘못된	값이 입력되었습니다.';
			 RAISE ERR_INVALID_OPERATION;

		 ELSIF p_rec_send.send_date	IS NULL	or LENGTH(p_rec_send.send_date)	!= 8 THEN
			 v_return_msg	:= '송신일자(SEND_DATE)가	셋팅되지 않았거나, 잘못된	값이 입력되었습니다.';
			 RAISE ERR_INVALID_OPERATION;

		 ELSIF p_rec_send.gaeb_area	IS NULL	or LENGTH(p_rec_send.gaeb_area)	=	0	THEN
			 v_return_msg	:= '개별부(GAEB_AREA)가	셋팅되지 않았거나, 잘못된	값이 입력되었습니다.';
			 RAISE ERR_INVALID_OPERATION;

		 END IF;


		-- 1)	넘겨받은 SEND_RECORD를 송신테이블(T_FB_VAN_SEND)에 INSERT합니다.
		----------------------------------------------------------------------

		BEGIN

			INSERT INTO	T_FB_VAN_SEND	VALUES p_rec_send;

		EXCEPTION
			WHEN OTHERS	THEN
				v_return_msg :=	'송신테이블(T_FB_VAN_SEND)에 INSERT하는중	오류발생';
				RAISE	ERR_INVALID_OPERATION;
		END;


		-- 2)	전문파일을 명명규칙에	의하여,	임시디렉토리에 생성합니다.
		-- 명명규칙	:	 사업장코드_은행코드(2)_전문구분코드(6)_날짜(8)_전문번호(6).rec
		------------------------------------------------------------------------------

		/* 물리적인	OS상의 directory를 가져옵니다.(from	DBA_DIRECTORIES	)	*/
		BEGIN
			SELECT DIRECTORY_PATH	|| '\'
				INTO v_temp_file_path
				FROM DBA_DIRECTORIES
			 WHERE DIRECTORY_NAME	=	FBS_REALTIME_TEMP_DIR;

			SELECT DIRECTORY_PATH	|| '\'
				INTO v_send_file_path
				FROM DBA_DIRECTORIES
			 WHERE DIRECTORY_NAME	=	FBS_REALTIME_SEND_DIR;

		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				v_return_msg :=	'이체전문파일을	생성하기위한 OS	path정보가 잘못되었습니다';
				RAISE	ERR_INVALID_OPERATION;
		END;

		/* 300byte의 전문내역을	buffer에 작성합니다. */
		v_document_buffer	:= fbs_util_pkg.sprintf('%-9.9s',	p_rec_send.tran_code ) ||
							 fbs_util_pkg.sprintf('%-8.8s',	p_rec_send.ente_code ) ||
							 fbs_util_pkg.sprintf('%-2.2s',	p_rec_send.bank_code ) ||
							 fbs_util_pkg.sprintf('%-4.4s',	p_rec_send.docu_code ) ||
							 fbs_util_pkg.sprintf('%-3.3s',	p_rec_send.upmu_code ) ||
							 fbs_util_pkg.sprintf('%-1.1s',	p_rec_send.send_cont ) ||
							 fbs_util_pkg.sprintf('%-6.6s',	p_rec_send.docu_numc ) ||
							 fbs_util_pkg.sprintf('%-8.8s',	p_rec_send.send_date ) ||
							 fbs_util_pkg.sprintf('%-6.6s',	p_rec_send.send_time ) ||
							 fbs_util_pkg.sprintf('%-4.4s',	NVL(p_rec_send.resp_code,'') ) ||
							 fbs_util_pkg.sprintf('%-49.49s',	'' ) ||
							 fbs_util_pkg.sprintf('%-200.200s',	p_rec_send.gaeb_area );

		/* 파일명을	만듭니다.	*/
		v_file_name	:= v_file_name ||	p_rec_send.ente_code ||	'_'	||
										p_rec_send.bank_code ||	'_'	||
										p_rec_send.docu_code ||	p_rec_send.upmu_code ||	'_'	||
										p_rec_send.send_date ||	'_'	||
										p_rec_send.docu_numc ||	'.rec';

		/* 파일을	OPEN 합니다	.*/
		BEGIN

			v_output_file	:= UTL_FILE.FOPEN('FBS_REALTIME_TEMP_DIR', v_file_name,	'w');

		EXCEPTION
			WHEN UTL_FILE.INVALID_OPERATION	THEN
				v_return_msg :=	'전문전문파일생성을	위해 파일을	OPEN하는중 오류발생';
				RAISE	ERR_INVALID_OPERATION;
		END;

		/* 파일내용을	WRITE	합니다.	*/
		BEGIN
			 UTL_FILE.PUT_LINE(	v_output_file	,	v_document_buffer	);
		EXCEPTION
			WHEN OTHERS	THEN
				v_return_msg :=	'전문파일내용	생성중 오류가	발생하여,	파일생성이 되지	않았습니다.';
				RAISE	ERR_MAKE_TEMP_FILE_ERR;
		END;

		/* 파일을	닫습니다.	*/
		BEGIN
			UTL_FILE.FCLOSE( v_output_file );
		EXCEPTION
			WHEN OTHERS	THEN
				v_return_msg :=	'전문파일내용	생성중 오류가	발생하여,	파일생성이 되지	않았습니다.';
				RAISE	ERR_MAKE_TEMP_FILE_ERR;
		END;


		-- 3)	OS명령어를 사용하여, SEND_DIRECTORY에	MOVE 합니다.
		v_dummy_return :=	fbs_util_pkg.exec_os_command(	'move	/Y '|| v_temp_file_path	|| v_file_name ||	'	'	|| v_send_file_path	|| v_file_name );


		-- 4)	일정시간동안 대기하고	있다가,	수신table에	record가 들어오면, RECORD형	변수에 담은뒤	종료한다.

		/* 프로그램이	시작한 시간을	기록합니다.	*/
		SELECT TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))*3600 +
				 TO_NUMBER(TO_CHAR(SYSDATE,'MI'))*60 +
				 TO_NUMBER(TO_CHAR(SYSDATE,'SS'))
			INTO n_start_time
			FROM DUAL;

		LOOP
			BEGIN

				 /*	일정시간동안 수신결과가	왔는지 확인합니다. */
				 SELECT	*
				 INTO	p_rec_recv
				 FROM	T_FB_VAN_RECV
				WHERE	ENTE_CODE	=	p_rec_send.ente_code
					AND	BANK_CODE	=	p_rec_send.bank_code
					AND	DOCU_CODE	=	SUBSTR(	p_rec_send.docu_code , 1 , 2 ) ||	'10'
					AND	UPMU_CODE	=	p_rec_send.upmu_code
					AND	SEND_DATE	=	p_rec_send.send_date
					AND	SEND_CONT	=	p_rec_send.send_cont
					AND	DOCU_NUMC	=	p_rec_send.docu_numc;

				 /*	수신된 결과가	있는 경우, 송신RECORD를	'Y'라고	UPDATE한후,	*/
				 /*	응답코드에 해당하는	응답코드명을 구해서	반환한다.			*/
				 UPDATE	T_FB_VAN_SEND
					SET	RESP_CODE	=	TRIM(	p_rec_recv.resp_code ) ,
						RESP_YEBU	=	'Y'
				WHERE	ENTE_CODE	=	p_rec_send.ente_code
					AND	BANK_CODE	=	p_rec_send.bank_code
					AND	DOCU_CODE	=	p_rec_send.docu_code
					AND	UPMU_CODE	=	p_rec_send.upmu_code
					AND	SEND_DATE	=	p_rec_send.send_date
					AND	SEND_CONT	=	p_rec_send.send_cont
					AND	DOCU_NUMC	=	p_rec_send.docu_numc;

				 BEGIN
					 SELECT	RESP_CODE	,	RESP_CODE_NAME
					 INTO	p_result_code	,	p_result_msg
					 FROM	T_FB_REAL_RESP_CODE
					WHERE	BANK_CODE	=	TRIM(p_rec_recv.bank_code)
						AND	RESP_CODE	=	TRIM(p_rec_recv.resp_code)
						AND	USE_YN = 'Y';

				 EXCEPTION
					 WHEN	NO_DATA_FOUND	THEN
						 v_return_msg	:= '은행오류코드['||p_rec_recv.resp_code ||']가	미등록되어 있습니다.';

					 WHEN	OTHERS THEN
						 v_return_msg	:= '은행오류코드조회시 기타오류발생';
				 END;


				 EXIT;	-- 정상적으로	결과가 수신되고, UPDATE가	완료되면 LOOP를	빠져나간다.

			EXCEPTION
				WHEN NO_DATA_FOUND THEN

					-- timeout시간이 초과하는	경우,	응답없음으로 빠져나간다.
					SELECT TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))*3600 +
							 TO_NUMBER(TO_CHAR(SYSDATE,'MI'))*60 +
							 TO_NUMBER(TO_CHAR(SYSDATE,'SS'))
						INTO n_curr_time
						FROM DUAL;
					IF ( n_curr_time - n_start_time	)	>	p_timeout	THEN
						v_return_msg :=	'[응답없음]	timeout시간('||	p_timeout	||'초)동안 응답수신	대기하였으나,	은행으로부터 응답없음';
						EXIT;
					END	IF;

				WHEN OTHERS	THEN
					-- 기타	오류가 발생하는	경우..
					v_return_msg :=	'[기타오류]	응답수신처리중 기타오류	발생';
					EXIT;
			END;
		END	LOOP;

		-- 최종적으로	정상처리된 경우, 'OK'문자열이	반환되며,	기타 오류의	경우,	오류메시지 반환
		RETURN(	v_return_msg );

	EXCEPTION
		WHEN ERR_INVALID_OPERATION THEN
			RETURN(	v_return_msg );

		WHEN ERR_MAKE_TEMP_FILE_ERR	THEN

			-- 파일이	이미 생성된	다음 나오는	EXCEPTION이므로, 이	파일을 삭제하는	로직
			BEGIN
				UTL_FILE.FCLOSE( v_output_file );
				v_dummy_return :=	fbs_util_pkg.exec_os_command(	'del ' ||	v_temp_file_path ||	v_file_name	);
			EXCEPTION
				WHEN OTHERS	THEN
					fbs_util_pkg.write_log('FBS',v_return_msg	|| fbs_util_pkg.format_msg(	sqlerrm	)	);
			END;

			RETURN(	v_return_msg );


		WHEN OTHERS	THEN
			RETURN(	FBS_UTIL_PKG.format_msg( sqlerrm ) );


	END	send_realtime_document;
	/******************************************************************************/
	/*	기능 : 사업장코드	및 은행	코드 구하기										*/
	/******************************************************************************/
	Procedure	GetCompAndBankCode
	(
		Ar_ACCOUNT_NO				Varchar2,
		Ar_COMP_CODE		Out		Varchar2,
		Ar_BANK_CODE		Out		Varchar2
	)
	Is
	Begin
		Select
			a.COMP_CODE,
			b.BANK_MAIN_CODE
		Into
			Ar_COMP_CODE,
			Ar_BANK_CODE
		From	T_ACCNO_CODE a,
				T_BANK_CODE	b
		Where	a.BANK_CODE	=	b.BANK_CODE
		And		a.ACCOUNT_NO = Ar_ACCOUNT_NO;
	Exception	When No_Data_Found Then
		Begin
			FBS_UTIL_PKG.write_log('계좌정보조회','트리거	호출 시	계좌정보를 찾을	수 없습니다. 계좌:'||Ar_ACCOUNT_NO);
			Raise;
		Exception	When Others	Then
			Raise;
		End;
	End;

	/******************************************************************************/
	/*	기능 : Van 수신	트리거 처리	잔액조회										*/
	/******************************************************************************/
	Procedure	process_trg_FB_DOCU_REMAIN_B
	(
		Ar_Recv						FB_VAN_RECV_RECORD
	)
	Is
		lrRec						T_FB_ACCT_REMAIN_DATA%RowType;
		ltNums						T_Nums;
		ltVars						T_Vars;
	 Begin
		ltNums(1)	:=	15;	--1.계좌번호
		ltNums(2)	:=	 1;	--2.부호
		ltNums(3)	:=	13;	--3.현재잔액
		ltNums(4)	:=	13;	--4.지급가능액
		ltNums(5)	:= 158;	--5.예비
		ltVars :=	SplitDocu(Ar_Recv.gaeb_area,ltNums);
		lrRec.ACCOUNT_NO :=	Trim(ltVars(1));
		lrRec.STD_YMD	:= To_Char(SysDate,'YYYYMMDD');
		lrRec.REMAIN_AMT :=	To_Number(ltVars(3));
		lrRec.ENABLE_AMT :=	To_Number(ltVars(4));
		lrRec.CREATION_DATE	:= SysDate;
		lrRec.LAST_MODIFY_DATE :=	SysDate;
		GetCompAndBankCode(lrRec.ACCOUNT_NO,lrRec.COMP_CODE,lrRec.BANK_CODE);
		Begin
			Insert Into	T_FB_ACCT_REMAIN_DATA
			(
				BANK_CODE,
				ACCOUNT_NO,
				STD_YMD,
				REMAIN_AMT,
				ENABLE_AMT,
				COMP_CODE,
				CREATION_DATE,
				LAST_MODIFY_DATE
			)
			Values
			(
				lrRec.BANK_CODE,
				lrRec.ACCOUNT_NO,
				lrRec.STD_YMD,
				lrRec.REMAIN_AMT,
				lrRec.ENABLE_AMT,
				lrRec.COMP_CODE,
				lrRec.CREATION_DATE,
				Null
			);
		Exception	When Dup_Val_On_Index	Then
			Update	T_FB_ACCT_REMAIN_DATA
			Set		REMAIN_AMT = lrRec.REMAIN_AMT,
					ENABLE_AMT = lrRec.ENABLE_AMT,
					LAST_MODIFY_DATE = lrRec.LAST_MODIFY_DATE
			Where	BANK_CODE	=	lrRec.BANK_CODE
			And		ACCOUNT_NO = lrRec.ACCOUNT_NO
			And		STD_YMD	=	lrRec.STD_YMD;
		End;
	Exception	When Others	Then
		Begin
			FBS_UTIL_PKG.write_log('잔액조회','계좌:'||lrRec.ACCOUNT_NO||' '||SqlErrm);
		Exception	When Others	Then
			Null;
		End;
	End;



	/******************************************************************************/
	/*	기능 : Van 수신	트리거 처리	예금거래명세										*/
	/******************************************************************************/
	Procedure	process_trg_FB_DOCU_DEPO_TR_B
	(
		Ar_Recv					FB_VAN_RECV_RECORD
	)
	Is
		lrRec						T_FB_CASH_TRX_DATA%RowType;
		ltNums						T_Nums;
		ltVars						T_Vars;
		lsBankCode					Varchar2(10);
		lnTaAmt						Number;
		lsSign						Varchar2(1);
	Begin
		ltNums(1)	:=	15;	--1.계좌번호
		ltNums(2)	:=	 2;	--2.거래구분
		ltNums(3)	:=	 2;	--3.은행코드
		ltNums(4)	:=	13;	--4.거래금액
		ltNums(5)	:=	13;	--5.거래후 잔액
		ltNums(6)	:=	 6;	--6.지로코드
		ltNums(7)	:=	16;	--7.성명
		ltNums(8)	:=	10;	--8.수표번호
		ltNums(9)	:=	16;	--9.거래처코드(CMS)
		ltNums(10):=	 8;	--10.거래일자
		ltNums(11):=	 6;	--11.거래시간
		ltNums(12):=	13;	--12.현금성
		ltNums(13):=	13;	--13.가계수표
		ltNums(14):=	13;	--14.타점권
		ltNums(15):=	 6;	--15.거래일련번호
		ltNums(16):=	 6;	--16.취소시일련번호
		ltNums(17):=	 8;	--17.취소시거래일자
		ltNums(18):=	 1;	--18.거래후	잔액부호
		ltNums(19):=	33;	--19.예비
		ltVars :=	SplitDocu(Ar_Recv.gaeb_area,ltNums);

		lrRec.BANK_CODE		:=		ltVars(3);		--3.은행코드
		lrRec.ACCOUNT_NO	:=		Trim(ltVars(1));--1.계좌번호
		lrRec.TRADE_YMD		:=		ltVars(10);		--10.거래일자
		lrRec.DOCU_NUMC		:=		ltVars(15);		--15.거래일련번호
		lrRec.TRX_GUBUN		:=		Trim(ltVars(2));--2.거래구분
		lrRec.TRADE_TIME	:=		ltVars(11);		--11.거래시간
		If lrRec.TRX_GUBUN In	(	'20','21','40','51') Then	--입금종류(입금,추심입금,결산이자,입금취소)
			lrRec.RECV_AMT		:=		To_Number(ltVars(4));		--4.거래금액
		ElsIf	lrRec.TRX_GUBUN	In ( '30','31','52') Then	--지급종류(지급,부도지급,지급취소)
			lrRec.PAY_AMT		:=		To_Number(ltVars(4));		--4.거래금액
		End	If;
		lsSign				:=		ltVars(18);		--18.거래후	잔액부호
		If lsSign	=	'-'	Then
			lrRec.REMAIN_AMT	:=		-	To_Number(ltVars(5));		--5.거래후 잔액
		Else
			lrRec.REMAIN_AMT	:=		To_Number(ltVars(5));		--5.거래후 잔액
		End	If;
		lnTaAmt				:=		Nvl(To_Number(ltVars(14)),0);						--14.타점권
		lrRec.ENABLE_AMT	:=		Nvl(lrRec.REMAIN_AMT,0)	-	lnTaAmt;
		lrRec.IN_OUT_NAME	:=		GetSingleBytes(ltVars(7));							--7.성명
		lrRec.DESCRIPTION	:=		Null;
		lrRec.CMS_CODE		:=		Trim(ltVars(9));													--9.거래처코드(CMS)
		lrRec.CANCEL_DOCU_NUM	:=	ltVars(16);		--16.취소시일련번호
		lrRec.CANCEL_TRADE_YMD	:=	ltVars(17);		--17.취소시거래일자
		GetCompAndBankCode(lrRec.ACCOUNT_NO,lrRec.COMP_CODE,lsBankCode);

		Begin
			Insert Into	T_FB_CASH_TRX_DATA
			(
				BANK_CODE,
				ACCOUNT_NO,
				TRADE_YMD,
				DOCU_NUMC,
				TRX_GUBUN,
				TRADE_TIME,
				RECV_AMT,
				PAY_AMT,
				REMAIN_AMT,
				ENABLE_AMT,
				IN_OUT_NAME,
				CMS_CODE,
				COMP_CODE,
				CANCEL_DOCU_NUM,
				CANCEL_TRADE_YMD
			)
			Values
			(
				lrRec.BANK_CODE,
				lrRec.ACCOUNT_NO,
				lrRec.TRADE_YMD,
				lrRec.DOCU_NUMC,
				lrRec.TRX_GUBUN,
				lrRec.TRADE_TIME,
				lrRec.RECV_AMT,
				lrRec.PAY_AMT,
				lrRec.REMAIN_AMT,
				lrRec.ENABLE_AMT,
				lrRec.IN_OUT_NAME,
				lrRec.CMS_CODE,
				lrRec.COMP_CODE,
				lrRec.CANCEL_DOCU_NUM,
				lrRec.CANCEL_TRADE_YMD
			);
		Exception	When Dup_Val_On_Index	Then
			Update	T_FB_CASH_TRX_DATA
			Set		TRX_GUBUN	=	lrRec.TRX_GUBUN,
					TRADE_TIME = lrRec.TRADE_TIME,
					RECV_AMT = lrRec.RECV_AMT,
					PAY_AMT	=	lrRec.PAY_AMT,
					REMAIN_AMT = lrRec.REMAIN_AMT,
					ENABLE_AMT = lrRec.ENABLE_AMT,
					IN_OUT_NAME	=	lrRec.IN_OUT_NAME,
					CMS_CODE = lrRec.CMS_CODE,
					COMP_CODE	=	lrRec.COMP_CODE,
					CANCEL_DOCU_NUM	=	lrRec.CANCEL_DOCU_NUM,
					CANCEL_TRADE_YMD = lrRec.CANCEL_TRADE_YMD
			Where	BANK_CODE	=	lrRec.BANK_CODE
			And		ACCOUNT_NO = lrRec.ACCOUNT_NO
			And		TRADE_YMD	=	lrRec.TRADE_YMD
			And		DOCU_NUMC	=	lrRec.DOCU_NUMC;
		End;
	Exception	When Others	Then
		Begin
			FBS_UTIL_PKG.write_log('예금거래명세삽입','계좌:'||lrRec.ACCOUNT_NO||' '||SqlErrm);
		Exception	When Others	Then
			Null;
		End;
	End;
	/******************************************************************************/
	/*	기능 : Van 수신	트리거 처리	어음거래명세									*/
	/******************************************************************************/
	Procedure	process_trg_FB_DOCU_BILL_TRX_B
	(
		Ar_Recv					FB_VAN_RECV_RECORD
	)
	Is
		lrRec						T_FB_BILL_TRX_DATA%RowType;
		ltNums						T_Nums;
		ltVars						T_Vars;
		lnTaAmt						Number;
		lsSign						Varchar2(1);
	Begin
		ltNums(1)	:=	 2;	--1.거래구분
		ltNums(2)	:=	15;	--2.계좌번호
		ltNums(3)	:=	 8;	--3.거래일자
		ltNums(4)	:=	 6;	--4.거래시간
		ltNums(5)	:=	10;	--5.어음번호
		ltNums(6)	:=	13;	--6.금액
		ltNums(7)	:=	14;	--7.발행인
		ltNums(8)	:=	 8;	--8.만기일
		ltNums(9)	:=	16;	--9.만기시지급은행
		ltNums(10) :=	16;	--10.CMS
		ltNums(11) :=	 3;	--11.항목변경코드
		ltNums(12) :=	13;	--12.잔액
		ltNums(13) :=	 6;	--13.지로코드
		ltNums(14) :=	 6;	--14.원거래전문번호
		ltNums(15) :=	 6;	--15.일련번호
		ltNums(16) :=	 6;	--16.취소시일련번호
		ltNums(17):=	 8;	--17.취소시거래일자
		ltNums(18):=	44;	--18.예비

		ltVars :=	SplitDocu(Ar_Recv.gaeb_area,ltNums);

		lrRec.ACCOUNT_NO	:=		Trim(ltVars(2));		--2.계좌번호
		lrRec.TRADE_YMD		:=		ltVars(3);				--3.거래일자
		lrRec.DOCU_NUMC		:=		ltVars(15);				--15.거래일련번호
		lrRec.TRX_GUBUN		:=		Trim(ltVars(1));			--1.거래구분
		lrRec.TRADE_TIME	:=		ltVars(4);				--4.거래시간
		lrRec.BILL_NO		:=		Trim(ltVars(5));		--5.어음번호
		lrRec.ISSUE_NAME	:=		GetSingleBytes(ltVars(7));		--7.발행인
		lrRec.FUTURE_PAY_DUE_YMD	:=		ltVars(8);		--8.만기일
		--만기시지급은행 처리	유보 lrRec.FUTURE_PAY_BANK_CODE
		lrRec.AMOUNT		:=		To_Number(ltVars(6));	--6.금액
		lrRec.REMAIN_AMT	:=		To_Number(ltVars(12));	--12.잔액
		lrRec.CMS_CODE		:=		Trim(ltVars(10));		--10.CMS
		lrRec.GIRO_CODE		:=		Trim(ltVars(13));		--13.지로코드
		lrRec.CANCEL_DOCU_NUM	:=	ltVars(16);		--16.취소시일련번호
		lrRec.CANCEL_TRADE_YMD	:=	ltVars(17);		--17.취소시거래일자

		GetCompAndBankCode(lrRec.ACCOUNT_NO,lrRec.COMP_CODE,lrRec.BANK_CODE);

		Begin
			Insert Into	T_FB_BILL_TRX_DATA
			(
				BANK_CODE,
				ACCOUNT_NO,
				TRADE_YMD,
				DOCU_NUMC,
				TRX_GUBUN,
				TRADE_TIME,
				BILL_NO,
				ISSUE_NAME,
				FUTURE_PAY_DUE_YMD,
				FUTURE_PAY_BANK_CODE,
				AMOUNT,
				REMAIN_AMT,
				CMS_CODE,
				GIRO_CODE,
				COMP_CODE,
				CANCEL_DOCU_NUM,
				CANCEL_TRADE_YMD
			)
			Values
			(
				lrRec.BANK_CODE,
				lrRec.ACCOUNT_NO,
				lrRec.TRADE_YMD,
				lrRec.DOCU_NUMC,
				lrRec.TRX_GUBUN,
				lrRec.TRADE_TIME,
				lrRec.BILL_NO,
				lrRec.ISSUE_NAME,
				lrRec.FUTURE_PAY_DUE_YMD,
				lrRec.FUTURE_PAY_BANK_CODE,
				lrRec.AMOUNT,
				lrRec.REMAIN_AMT,
				lrRec.CMS_CODE,
				lrRec.GIRO_CODE,
				lrRec.COMP_CODE,
				lrRec.CANCEL_DOCU_NUM,
				lrRec.CANCEL_TRADE_YMD
			);
		Exception	When Dup_Val_On_Index	Then
			Update	T_FB_BILL_TRX_DATA
			Set		TRX_GUBUN	=	lrRec.TRX_GUBUN,
					TRADE_TIME = lrRec.TRADE_TIME,
					BILL_NO	=	lrRec.BILL_NO,
					ISSUE_NAME = lrRec.ISSUE_NAME,
					FUTURE_PAY_DUE_YMD = lrRec.FUTURE_PAY_DUE_YMD,
					FUTURE_PAY_BANK_CODE = lrRec.FUTURE_PAY_BANK_CODE,
					AMOUNT = lrRec.AMOUNT,
					REMAIN_AMT = lrRec.REMAIN_AMT,
					CMS_CODE = lrRec.CMS_CODE,
					GIRO_CODE	=	lrRec.GIRO_CODE,
					COMP_CODE	=	lrRec.COMP_CODE,
					CANCEL_DOCU_NUM	=	lrRec.CANCEL_DOCU_NUM,
					CANCEL_TRADE_YMD = lrRec.CANCEL_TRADE_YMD
			Where	BANK_CODE	=	lrRec.BANK_CODE
			And		ACCOUNT_NO = lrRec.ACCOUNT_NO
			And		TRADE_YMD	=	lrRec.TRADE_YMD
			And		DOCU_NUMC	=	lrRec.DOCU_NUMC;
		End;
	Exception	When Others	Then
		Begin
			FBS_UTIL_PKG.write_log('어음거래명세삽입','계좌:'||lrRec.ACCOUNT_NO||' '||SqlErrm);
		Exception	When Others	Then
			Null;
		End;
	End;
	/******************************************************************************/
	/*	기능 : Van 수신	트리거 처리	타행이체불능									*/
	/******************************************************************************/
	Procedure	process_trg_FB_DOCU_TATR_RE_B
	(
		Ar_Recv					FB_VAN_RECV_RECORD
	)
	Is
		lsOrgDocuNo							Varchar2(6);
		lsOutAccNo							Varchar2(15);
		lsInAccNo							Varchar2(15);
		lsInBankCode						Varchar2(2);
		lnAmt								Number;
		lnNAmt								Number;
		lsErrCode							Varchar2(3);
		ltNums								T_Nums;
		ltVars								T_Vars;
		lnPAY_SEQ							Number;
		lnDIV_SEQ							Number;
		lnTRX_SEQ							Number;
		lrRec								T_FB_CASH_PAY_HISTORY%RowType;
		lsMsg								T_FB_CASH_PAY_DIVIDED_DATA.RESULT_TEXT%Type;
		lsBankCode							Varchar2(10);
		lsCompCode							Varchar2(20);
		lsRet								Varchar2(2000);
	Begin
		ltNums(1)	:=	 6;	--1.원거래전문번호
		ltNums(2)	:=	15;	--2.출금계좌번호
		ltNums(3)	:=	15;	--3.입금계좌번호
		ltNums(4)	:=	 2;	--4.입금은행코드
		ltNums(5)	:=	13;	--5.의뢰금액
		ltNums(6)	:=	13;	--6.미처리금액
		ltNums(7)	:=	 3;	--7.에러코드
		ltNums(8)	:= 133;	--8.예비

		ltVars :=	SplitDocu(Ar_Recv.gaeb_area,ltNums);

		lsOrgDocuNo		:=		ltVars(1);							--1.원거래전문번호
		lsOutAccNo		:=		Trim(ltVars(2));					--2.출금계좌번호
		lsInAccNo		:=		Trim(ltVars(3));					--3.입금계좌번호
		lsInBankCode	:=		ltVars(4);							--4.입금은행코드
		lnAmt			:=		To_Number(ltVars(5));				--5.의뢰금액
		lnNAmt			:=		To_Number(ltVars(6));				--6.미처리금액
		lsErrCode		:=		Trim(ltVars(7));					--7.에러코드

		GetCompAndBankCode(lsOutAccNo,lsCompCode,lsBankCode);

		--1	먼저 오늘	날짜로 해당	원 거래를	찾아본다.
		Begin
			Select
				Max(c.PAY_SEQ) PAY_SEQ,
				Max(c.DIV_SEQ) DIV_SEQ,
				Max(c.TRX_SEQ) TRX_SEQ
			Into
				lnPAY_SEQ,
				lnDIV_SEQ,
				lnTRX_SEQ
			From	T_FB_CASH_PAY_DATA a,
					T_FB_CASH_PAY_DIVIDED_DATA b,
					T_FB_CASH_PAY_HISTORY	c
			Where	a.PAY_SEQ	=	b.PAY_SEQ
			And		b.PAY_SEQ	=	c.PAY_SEQ
			And		b.DIV_SEQ	=	c.DIV_SEQ
			And		a.IN_ACCOUNT_NO	=	lsInAccNo
			And		a.IN_BANK_CODE = lsInBankCode
			And		a.OUT_ACCOUNT_NO = lsOutAccNo
			And		c.DOCU_NUMC	=	lsOrgDocuNo
			And		b.PAY_YMD	=	To_Char(Sysdate,'YYYYMMDD');
		Exception	When No_Data_Found Then		--실제로는 Max질의는 No_Data_Found를 타지	않는다..
			lnPAY_SEQ	:= Null;
			lnDIV_SEQ	:= Null;
			lnTRX_SEQ	:= Null;
		End;
		If lnPAY_SEQ Is	Null Then
			Begin
				Select
					Max(c.PAY_SEQ) PAY_SEQ,
					Max(c.DIV_SEQ) DIV_SEQ,
					Max(c.TRX_SEQ) TRX_SEQ
				Into
					lnPAY_SEQ,
					lnDIV_SEQ,
					lnTRX_SEQ
				From	T_FB_CASH_PAY_DATA a,
						T_FB_CASH_PAY_DIVIDED_DATA b,
						T_FB_CASH_PAY_HISTORY	c
				Where	a.PAY_SEQ	=	b.PAY_SEQ
				And		b.PAY_SEQ	=	c.PAY_SEQ
				And		b.DIV_SEQ	=	c.DIV_SEQ
				And		a.IN_ACCOUNT_NO	=	lsInAccNo
				And		a.IN_BANK_CODE = lsInBankCode
				And		a.OUT_ACCOUNT_NO = lsOutAccNo
				And		c.DOCU_NUMC	=	lsOrgDocuNo;
			Exception	When No_Data_Found Then		--실제로는 Max질의는 No_Data_Found를 타지	않는다..
				lnPAY_SEQ	:= Null;
				lnDIV_SEQ	:= Null;
				lnTRX_SEQ	:= Null;
			End;
			If lnPAY_SEQ Is	Null Then
				Begin
					FBS_UTIL_PKG.write_log('이체불능통지','출금계좌:'||lsOutAccNo||' 입금계좌:'	|| lsInAccNo||'	전문번호 :'||lsOrgDocuNo||'의	원 거래를	찾을 수	없습니다.');
				Exception	When Others	Then
					Null;
				End;
				Return;
			End	If;
		End	If;
		lsMsg	:= SubStrb(Get_RealTimeError(Ar_Recv.bank_code,lsErrCode),1,300);
		Select
			*
		Into
			lrRec
		From	T_FB_CASH_PAY_HISTORY
		Where	PAY_SEQ	=	lnPAY_SEQ
		And		DIV_SEQ	=	lnDIV_SEQ
		And		TRX_SEQ	=	lnTRX_SEQ;
		Insert Into	T_FB_CASH_PAY_HISTORY
		(
			PAY_SEQ,
			DIV_SEQ,
			TRX_SEQ,
			EDI_CREATE_YN,
			TRANSFER_YN,
			PAY_SUCCESS_YN,
			DOCU_NUMC,
			SEND_DATE,
			RECV_DATE,
			RESULT_CODE,
			RESULT_TEXT,
			EDI_HISTORY_SEQ,
			EDI_RECORD_SEQ
		)
		Values
		(
			lrRec.PAY_SEQ,
			lrRec.DIV_SEQ,
			SQ_T_TRX_SEQ.NextVal ,
			lrRec.EDI_CREATE_YN,
			lrRec.TRANSFER_YN,
			'N',
			lrRec.DOCU_NUMC,
			lrRec.SEND_DATE,
			lrRec.RECV_DATE,
			lsErrCode,
			lsMsg,
			lrRec.EDI_HISTORY_SEQ,
			lrRec.EDI_RECORD_SEQ
		);

		Update	T_FB_CASH_PAY_DIVIDED_DATA
		Set		PAY_SUCCESS_YN = 'N',
				RESULT_TEXT	=	lsMsg
		Where	PAY_SEQ	=	lnPAY_SEQ
		And		DIV_SEQ	=	lnDIV_SEQ;

		Update	T_FB_CASH_PAY_DATA a
		Set		(a.PAY_STATUS,a.PAY_SUCCESS_AMT,a.PAY_FAIL_AMT)	=
				(
					Select
						Case
							When Count(*)	=	1	And	Count(Decode(b.PAY_SUCCESS_YN,'Y',1))	<> 1 Then	--총건수가 1이고 성공건수가	1이	아니면 실패
								5
							When Count(*)	>	1	And	Count(Decode(b.PAY_SUCCESS_YN,'Y',1))	<	Count(*) Then		--총건수가 1보다 크도	성공건수가 그보다	작으면 일부실패
								6
							Else
								4
						End,
						Sum(Decode(b.PAY_SUCCESS_YN,'Y',b.PAY_AMT)),
						Sum(Decode(b.PAY_SUCCESS_YN,'Y',Null,b.PAY_AMT))
					From	T_FB_CASH_PAY_DIVIDED_DATA b
					Where	a.PAY_SEQ	=	b.PAY_SEQ
				)
		Where	a.PAY_SEQ	=	lnPAY_SEQ;

		GetCompAndBankCode(lsOutAccNo,lsCompCode,lsBankCode);

		lsRet	:= send_tran_fail_mail(	lsCompCode,lsBankCode,lrRec.DOCU_NUMC);
	Exception	When Others	Then
		Begin
			FBS_UTIL_PKG.write_log('이체불능통지','출금계좌:'||lsOutAccNo||' 입금계좌:'	|| lsInAccNo||'	전문번호 :'||lsOrgDocuNo||'	'||SqlErrm);
		Exception	When Others	Then
			Null;
		End;
	End;
	/******************************************************************************/
	/*	기능 : Van 수신	트리거 처리	타임아웃된 이체처리시							*/
	/******************************************************************************/
	Procedure	process_trg_FB_DOCU_DATR_T
	(
		Ar_Recv					FB_VAN_RECV_RECORD
	)
	Is
		lrData								FB_REAL_TR_RECORD;
		ltNums								T_Nums;
		ltVars								T_Vars;
		lsOrgDocuNo							Varchar2(6);
		lsOutAccNo							Varchar2(15);
		lsInAccNo							Varchar2(15);
		lsInBankCode						Varchar2(2);
		lnPAY_SEQ							Number;
		lnDIV_SEQ							Number;
		lnTRX_SEQ							Number;
		lrRec								T_FB_CASH_PAY_HISTORY%RowType;
	Begin
		ltNums(1)	:=	15;	--1.출금계좌번호
		ltNums(2)	:=	 8;	--2.통장비밀번호
		ltNums(3)	:=	 6;	--3.복기부호
		ltNums(4)	:=	13;	--4.출금금액
		ltNums(5)	:=	 1;	--5.출금후잔액부호
		ltNums(6)	:=	13;	--6.출금후잔액
		ltNums(7)	:=	 2;	--7.입금은행코드
		ltNums(8)	:=	15;	--8.입금계좌
		ltNums(9)	:=	13;	--9.이체수수료
		ltNums(10):=	 6;	--10.CMS
		ltNums(11):=	22;	--11.임금인성명
		ltNums(12):=	14;	--12.입금인통장적요
		ltNums(13):=	72;	--13.예비

		ltVars :=	SplitDocu(Ar_Recv.gaeb_area,ltNums);

		lrData.out_account_no		:=		Trim(ltVars(1));				/*	지급계좌					 */
		lrData.account_pw			:=		Trim(ltVars(2));				/*	통장비번(4)+이체비번(4)		 */
		lrData.sign_no				:=		Trim(ltVars(3));				/*	복기부호					 */
		lrData.trade_amt			:=		To_Number(ltVars(4));			/*	출금금액					 */
		lrData.remain_sign			:=		ltVars(5);						/*	출금 후, 잔액부호			 */
		lrData.remain_amt			:=		To_Number(ltVars(6));			/*	원장 잔액					 */
		lrData.in_bank_cd			:=		ltVars(7);						/*	입금은행코드				 */
		lrData.in_account_no		:=		Trim(ltVars(8));				/*	입금계좌					 */
		lrData.commission			:=		To_Number(ltVars(9));			/*	이체수수료					 */
		lrData.cms					:=		Trim(ltVars(10));				/*	CMS코드(거래처코드)			 */

		lsOrgDocuNo		:=		Ar_Recv.docu_numc;
		lsOutAccNo		:=		lrData.out_account_no;
		lsInAccNo		:=		lrData.in_account_no;
		lsInBankCode	:=		lrData.in_bank_cd;

		--1	먼저 오늘	날짜로 해당	원 거래를	찾아본다.
		Begin
			Select
				Max(c.PAY_SEQ) PAY_SEQ,
				Max(c.DIV_SEQ) DIV_SEQ,
				Max(c.TRX_SEQ) TRX_SEQ
			Into
				lnPAY_SEQ,
				lnDIV_SEQ,
				lnTRX_SEQ
			From	T_FB_CASH_PAY_DATA a,
					T_FB_CASH_PAY_DIVIDED_DATA b,
					T_FB_CASH_PAY_HISTORY	c
			Where	a.PAY_SEQ	=	b.PAY_SEQ
			And		b.PAY_SEQ	=	c.PAY_SEQ
			And		b.DIV_SEQ	=	c.DIV_SEQ
			And		a.IN_ACCOUNT_NO	=	lsInAccNo
			And		a.IN_BANK_CODE = lsInBankCode
			And		a.OUT_ACCOUNT_NO = lsOutAccNo
			And		c.DOCU_NUMC	=	lsOrgDocuNo
			And		b.PAY_YMD	=	To_Char(Sysdate,'YYYYMMDD');
		Exception	When No_Data_Found Then		--실제로는 Max질의는 No_Data_Found를 타지	않는다..
			lnPAY_SEQ	:= Null;
			lnDIV_SEQ	:= Null;
			lnTRX_SEQ	:= Null;
		End;
		If lnPAY_SEQ Is	Null Then
			Begin
				Select
					Max(c.PAY_SEQ) PAY_SEQ,
					Max(c.DIV_SEQ) DIV_SEQ,
					Max(c.TRX_SEQ) TRX_SEQ
				Into
					lnPAY_SEQ,
					lnDIV_SEQ,
					lnTRX_SEQ
				From	T_FB_CASH_PAY_DATA a,
						T_FB_CASH_PAY_DIVIDED_DATA b,
						T_FB_CASH_PAY_HISTORY	c
				Where	a.PAY_SEQ	=	b.PAY_SEQ
				And		b.PAY_SEQ	=	c.PAY_SEQ
				And		b.DIV_SEQ	=	c.DIV_SEQ
				And		a.IN_ACCOUNT_NO	=	lsInAccNo
				And		a.IN_BANK_CODE = lsInBankCode
				And		a.OUT_ACCOUNT_NO = lsOutAccNo
				And		c.DOCU_NUMC	=	lsOrgDocuNo;
			Exception	When No_Data_Found Then		--실제로는 Max질의는 No_Data_Found를 타지	않는다..
				lnPAY_SEQ	:= Null;
				lnDIV_SEQ	:= Null;
				lnTRX_SEQ	:= Null;
			End;
			If lnPAY_SEQ Is	Null Then
				Begin
					FBS_UTIL_PKG.write_log('타임아웃이체처리','출금계좌:'||lsOutAccNo||' 입금계좌:'	|| lsInAccNo||'	전문번호 :'||lsOrgDocuNo||'의	원 거래를	찾을 수	없습니다.');
				Exception	When Others	Then
					Null;
				End;
				Return;
			End	If;
		End	If;

		Select
			*
		Into
			lrRec
		From	T_FB_CASH_PAY_HISTORY
		Where	PAY_SEQ	=	lnPAY_SEQ
		And		DIV_SEQ	=	lnDIV_SEQ
		And		TRX_SEQ	=	lnTRX_SEQ;
		Insert Into	T_FB_CASH_PAY_HISTORY
		(
			PAY_SEQ,
			DIV_SEQ,
			TRX_SEQ,
			EDI_CREATE_YN,
			TRANSFER_YN,
			PAY_SUCCESS_YN,
			DOCU_NUMC,
			SEND_DATE,
			RECV_DATE,
			EDI_HISTORY_SEQ,
			EDI_RECORD_SEQ
		)
		Values
		(
			lrRec.PAY_SEQ,
			lrRec.DIV_SEQ,
			SQ_T_TRX_SEQ.NextVal ,
			lrRec.EDI_CREATE_YN,
			lrRec.TRANSFER_YN,
			'Y',
			lrRec.DOCU_NUMC,
			lrRec.SEND_DATE,
			lrRec.RECV_DATE,
			lrRec.EDI_HISTORY_SEQ,
			lrRec.EDI_RECORD_SEQ
		);

		Update	T_FB_CASH_PAY_DIVIDED_DATA
		Set		PAY_SUCCESS_YN = 'Y'
		Where	PAY_SEQ	=	lnPAY_SEQ
		And		DIV_SEQ	=	lnDIV_SEQ;

		Update	T_FB_CASH_PAY_DATA a
		Set		(a.PAY_STATUS,a.PAY_SUCCESS_AMT,a.PAY_FAIL_AMT)	=
				(
					Select
						Case
							When Count(*)	=	1	And	Count(Decode(b.PAY_SUCCESS_YN,'Y',1))	<> 1 Then	--총건수가 1이고 성공건수가	1이	아니면 실패
								5
							When Count(*)	>	1	And	Count(Decode(b.PAY_SUCCESS_YN,'Y',1))	<	Count(*) Then		--총건수가 1보다 크도	성공건수가 그보다	작으면 일부실패
								6
							Else
								4
						End,
						Sum(Decode(b.PAY_SUCCESS_YN,'Y',b.PAY_AMT)),
						Sum(Decode(b.PAY_SUCCESS_YN,'Y',Null,b.PAY_AMT))
					From	T_FB_CASH_PAY_DIVIDED_DATA b
					Where	a.PAY_SEQ	=	b.PAY_SEQ
				)
		Where	a.PAY_SEQ	=	lnPAY_SEQ;
	Exception	When Others	Then
		Begin
			FBS_UTIL_PKG.write_log('타임아웃이체처리','출금계좌:'||lsOutAccNo||' 입금계좌:'	|| lsInAccNo||'	전문번호 :'||lsOrgDocuNo||'	'||SqlErrm);
		Exception	When Others	Then
			Null;
		End;
	End;
	/******************************************************************************/
	/*	기능 : Van 수신	트리거 처리	분양인터페이스테이블에 삽입						*/
	/******************************************************************************/
	Procedure	process_trg_ins_hsms
	(
		Ar_Data								T_FB_INTERFACE_PH%RowType
	)
	Is
	Begin
		Insert Into	T_FB_INTERFACE_PH
		(
			SEQ,
			COMP_CODE,
			ACCOUNT_NO,
			ACCT_TYPE_GUBUN,
			BANK_CODE,
			TRX_GUBUN,
			RECV_YMD,
			RECV_AMT,
			REMAIN_AMT,
			ACCT_HOLDER_NAME,
			CMS_CODE,
			DOCU_NUMC,
			SSN,
			DONGHO,
			LOAD_YN,
			ORG_BANK_CODE,
			INNER_DOCU_NUMC,
			TRANSFER_YMD,
			TRANSFER_YN,
			ATTRIBUTE1,
			ATTRIBUTE2,
			ATTRIBUTE3
		)
		Values
		(
			SQ_T_HSMS_SEQ.NextVal,
			Ar_Data.COMP_CODE,
			Ar_Data.ACCOUNT_NO,
			Ar_Data.ACCT_TYPE_GUBUN,
			Ar_Data.BANK_CODE,
			Ar_Data.TRX_GUBUN,
			Ar_Data.RECV_YMD,
			Ar_Data.RECV_AMT,
			Ar_Data.REMAIN_AMT,
			Ar_Data.ACCT_HOLDER_NAME,
			Ar_Data.CMS_CODE,
			Ar_Data.DOCU_NUMC,
			Ar_Data.SSN,
			Ar_Data.DONGHO,
			Ar_Data.LOAD_YN,
			Ar_Data.ORG_BANK_CODE,
			Ar_Data.INNER_DOCU_NUMC,
			Ar_Data.TRANSFER_YMD,
			Ar_Data.TRANSFER_YN,
			Ar_Data.ATTRIBUTE1,
			Ar_Data.ATTRIBUTE2,
			Ar_Data.ATTRIBUTE3
		);
	End;

	/******************************************************************************/
	/*	기능 : Van 수신	트리거 처리	분양->예금거래명세통지							*/
	/******************************************************************************/
	Procedure	process_trg_HSMS_D1
	(
		Ar_Recv					FB_VAN_RECV_RECORD
	)
	Is
		ltNums								T_Nums;
		ltVars								T_Vars;
		lrRec								FB_REAL_DEPO_TR_RECORD;
		lrData								T_FB_INTERFACE_PH%RowType;
		lsBankCode							Varchar2(10);
	Begin
		ltNums(1)	:=	15;	--1.계좌번호
		ltNums(2)	:=	 2;	--2.거래구분
		ltNums(3)	:=	 2;	--3.은행코드
		ltNums(4)	:=	13;	--4.거래금액
		ltNums(5)	:=	13;	--5.거래후 잔액
		ltNums(6)	:=	 6;	--6.지로코드
		ltNums(7)	:=	16;	--7.성명
		ltNums(8)	:=	10;	--8.수표번호
		ltNums(9)	:=	16;	--9.거래처코드(CMS)
		ltNums(10):=	 8;	--10.거래일자
		ltNums(11):=	 6;	--11.거래시간
		ltNums(12):=	13;	--12.현금성
		ltNums(13):=	13;	--13.가계수표
		ltNums(14):=	13;	--14.타점권
		ltNums(15):=	 6;	--15.거래일련번호
		ltNums(16):=	 6;	--16.취소시일련번호
		ltNums(17):=	 8;	--17.취소시거래일자
		ltNums(18):=	 1;	--18.거래후	잔액부호
		ltNums(19):=	 1;	--19.예비	집단대출여부
		ltNums(20):=	 8;	--20.예비	동호
		ltNums(21):=	24;	--21.예비

		ltVars :=	SplitDocu(Ar_Recv.gaeb_area,ltNums);

		lrRec.account_no		:=				Trim(ltVars(1));					/*	입금계좌번호				 */
		lrRec.trade_gb			:=				Trim(ltVars(2));					/*	거래구분					 */
		lrRec.bank_cd			:=				Trim(ltVars(3));					/*	거래발행은행코드			 */
		lrRec.trade_amt			:=				To_Number(Trim(ltVars(4)));			/*	거래금액					 */
		lrRec.remain_amt		:=				To_Number(Trim(ltVars(5)));			/*	거래 후, 잔액				 */
		lrRec.giro_cd			:=				Trim(ltVars(6));					/*	지로코드					 */
		lrRec.depo_nm			:=				GetSingleBytes(ltVars(7));			/*	입금인 성명					 */
		lrRec.check_no			:=				Trim(ltVars(8));					/*	어음 및	수표번호			 */
		lrRec.cms				:=				Trim(ltVars(9));					/*	CMS코드(거래처코드)			 */
		lrRec.trade_dt			:=				Trim(ltVars(10));					/*	거래일자					 */
		lrRec.trade_time		:=				Trim(ltVars(11));					/*	거래시간					 */
		lrRec.cash_amt			:=				To_Number(Trim(ltVars(12)));		/*	현금						 */
		lrRec.check_amt			:=				To_Number(Trim(ltVars(13)));		/*	가계수표					 */
		lrRec.ta_check_amt		:=				To_Number(Trim(ltVars(14)));		/*	교환후,	인출가능금액		 */
		lrRec.trade_no			:=				Trim(ltVars(15));					/*	거래시 일련번호	추가		 */
		lrRec.cancel_trade_no	:=				Trim(ltVars(16));					/*	취소시 인련번호	추가		 */
		lrRec.cancel_trade_dt	:=				Trim(ltVars(17));					/*	취소시 거래일자	추가		 */
		lrRec.remain_sign		:=				Trim(ltVars(18));					/*	예비부(잔액부호)			 */
		lrRec.loan_yn			:=				Trim(ltVars(19));					/*	예비비(집단대출여부)(예비) */
		lrRec.dong_ho			:=				Trim(ltVars(20));					/*	예비(동호)					 */

		If lrRec.trade_gb	Not	In ('20','51') Then
			Return;
		End	If;

		If lrRec.remain_sign = '-' Then
			lrRec.remain_amt :=	-	lrRec.remain_amt;
		End	If;


		lrData.ACCOUNT_NO		:=				lrRec.account_no;
		lrData.ACCT_TYPE_GUBUN	:=				'1';				-- 일반계좌	구분코드:1
		lrData.BANK_CODE		:=				Ar_Recv.bank_code;
		lrData.TRX_GUBUN		:=				lrRec.trade_gb;
		lrData.RECV_YMD			:=				lrRec.trade_dt;
		lrData.RECV_AMT			:=				lrRec.trade_amt;
		lrData.REMAIN_AMT		:=				lrRec.remain_amt;
		lrData.ACCT_HOLDER_NAME	:=				lrRec.depo_nm;
		lrData.CMS_CODE			:=				lrRec.cms;
		lrData.DOCU_NUMC		:=				Ar_Recv.docu_numc;
		lrData.SSN				:=				Null;
		lrData.DONGHO			:=				RTRIM(TRIM(lrRec.dong_ho),'0');
		If lrRec.loan_yn = '1' Then
			lrData.LOAD_YN			:=				'Y';
		Else
			lrData.LOAD_YN			:=				'N';
		End	If;
		lrData.ORG_BANK_CODE	:=				lrRec.bank_cd;
		lrData.INNER_DOCU_NUMC	:=				lrRec.trade_no;
		lrData.TRANSFER_YMD		:=				Null;
		lrData.TRANSFER_YN		:=				Null;

		GetCompAndBankCode(lrRec.account_no,lrData.COMP_CODE,lsBankCode);

		----------------------------------------------------------
		-- 입금(20)	,	입금취소(51)에 따른	구분 처리
		----------------------------------------------------------
		If lrRec.trade_gb	=	'51' THEN		 --	입금취소인 경우는	(-)	금액 처리
			lrData.RECV_AMT	:= - lrData.RECV_AMT;

		-- 기존에	INTERFACE된	내역인 A_FB_INTERFACE_PH에서 취소할	전문내역을 찾아서
		-- 관련정보를	가져와서 셋팅합니다.
			BEGIN
				SELECT
					A.ACCT_HOLDER_NAME,	-- 원거래	예금주명
					A.LOAD_YN,			-- 원거래, 대출유무
					A.DONGHO				-- 원거래, 동호
				INTO
					lrData.ACCT_HOLDER_NAME,
					lrData.LOAD_YN,
					lrData.DONGHO
				FROM	T_FB_INTERFACE_PH	A
				WHERE	A.INNER_DOCU_NUMC	=	lrRec.cancel_trade_no
				AND		A.ACCOUNT_NO = lrRec.account_no
				AND		A.RECV_YMD = Ar_Recv.send_date
				AND		A.BANK_CODE		=	Ar_recv.bank_code;
			EXCEPTION	When Others	Then
				NULL;	 --	해당 이전입금내역을	못찾는 경우는,수신된 내역	그대로 저장한다.
			END;

		END	IF;


		process_trg_ins_hsms(lrData);
	Exception	When Others	Then
		Begin
			FBS_UTIL_PKG.write_log('분양수입금처리','입금계좌:'||lrRec.account_no||' 입금일자:'	|| lrRec.trade_dt||' 동호	:'||RTRIM(TRIM(lrRec.dong_ho),'0')||
									'	전문번호 :'||lrRec.trade_no||' '||SqlErrm);
		Exception	When Others	Then
			Null;
		End;
	End;

	/******************************************************************************/
	/*	기능 : Van 수신	트리거 처리	분양->예금거래결번통지							*/
	/******************************************************************************/
	Procedure	process_trg_HSMS_D2
	(
		Ar_Recv					FB_VAN_RECV_RECORD
	)
	Is
		ltNums								T_Nums;
		ltVars								T_Vars;
		lrRec								FB_REAL_DEPO_MISS_RECORD;
		lrData								T_FB_INTERFACE_PH%RowType;
		lsBankCode							Varchar2(10);
	Begin
		ltNums(1)	:=	15;	--1.계좌번호
		ltNums(2)	:=	 2;	--2.거래구분
		ltNums(3)	:=	 2;	--3.은행코드
		ltNums(4)	:=	13;	--4.거래금액
		ltNums(5)	:=	13;	--5.거래후 잔액
		ltNums(6)	:=	 6;	--6.지로코드
		ltNums(7)	:=	16;	--7.성명
		ltNums(8)	:=	10;	--8.수표번호
		ltNums(9)	:=	16;	--9.거래처코드(CMS)
		ltNums(10):=	 8;	--10.거래일자
		ltNums(11):=	 6;	--11.거래시간
		ltNums(12):=	13;	--12.현금성
		ltNums(13):=	13;	--13.가계수표
		ltNums(14):=	13;	--14.타점권
		ltNums(15):=	 6;	--15.원거래번문번호
		ltNums(16):=	 6;	--16.거래일련번호
		ltNums(17):=	 6;	--17.취소시일련번호
		ltNums(18):=	 8;	--18.취소시거래일자
		ltNums(19):=	 1;	--19.거래후	잔액부호
		ltNums(20):=	 1;	--20.예비	집단대출여부
		ltNums(21):=	 8;	--21.예비	동호
		ltNums(22):=	18;	--22.예비

		ltVars :=	SplitDocu(Ar_Recv.gaeb_area,ltNums);

		lrRec.account_no		:=				Trim(ltVars(1));					/*	입금계좌번호				 */
		lrRec.trade_gb			:=				Trim(ltVars(2));					/*	거래구분					 */
		lrRec.bank_cd			:=				Trim(ltVars(3));					/*	거래발행은행코드			 */
		lrRec.trade_amt			:=				To_Number(Trim(ltVars(4)));			/*	거래금액					 */
		lrRec.remain_amt		:=				To_Number(Trim(ltVars(5)));			/*	거래 후, 잔액				 */
		lrRec.giro_cd			:=				Trim(ltVars(6));					/*	지로코드					 */
		lrRec.depo_nm			:=				GetSingleBytes(ltVars(7));			/*	입금인 성명					 */
		lrRec.check_no			:=				Trim(ltVars(8));					/*	어음 및	수표번호			 */
		lrRec.cms				:=				Trim(ltVars(9));					/*	CMS코드(거래처코드)			 */
		lrRec.trade_dt			:=				Trim(ltVars(10));					/*	거래일자					 */
		lrRec.trade_time		:=				Trim(ltVars(11));					/*	거래시간					 */
		lrRec.cash_amt			:=				To_Number(Trim(ltVars(12)));		/*	현금						 */
		lrRec.check_amt			:=				To_Number(Trim(ltVars(13)));		/*	가계수표					 */
		lrRec.ta_check_amt		:=				To_Number(Trim(ltVars(14)));		/*	교환후,	인출가능금액		 */
		lrRec.org_docu_numc		:=				Trim(ltVars(15));					/*	원거래전문번호 추가			 */
		lrRec.trade_no			:=				Trim(ltVars(16));					/*	거래시 일련번호	추가		 */
		lrRec.cancel_trade_no	:=				Trim(ltVars(17));					/*	취소시 인련번호	추가		 */
		lrRec.cancel_trade_dt	:=				Trim(ltVars(18));					/*	취소시 거래일자	추가		 */
		lrRec.remain_sign		:=				Trim(ltVars(19));					/*	예비부(잔액부호)			 */
		lrRec.loan_yn			:=				Trim(ltVars(20));					/*	예비비(집단대출여부)(예비) */
		lrRec.dong_ho			:=				Trim(ltVars(21));					/*	예비(동호)					 */

		If lrRec.trade_gb	Not	In ('20','51') Then
			Return;
		End	If;

		If lrRec.remain_sign = '-' Then
			lrRec.remain_amt :=	-	lrRec.remain_amt;
		End	If;


		lrData.ACCOUNT_NO		:=				lrRec.account_no;
		lrData.ACCT_TYPE_GUBUN	:=				'1';				-- 일반계좌	구분코드:1
		lrData.BANK_CODE		:=				Ar_Recv.bank_code;
		lrData.TRX_GUBUN		:=				lrRec.trade_gb;
		lrData.RECV_YMD			:=				lrRec.trade_dt;
		lrData.RECV_AMT			:=				lrRec.trade_amt;
		lrData.REMAIN_AMT		:=				lrRec.remain_amt;
		lrData.ACCT_HOLDER_NAME	:=				lrRec.depo_nm;
		lrData.CMS_CODE			:=				lrRec.cms;
		lrData.DOCU_NUMC		:=				Ar_Recv.docu_numc;
		lrData.SSN				:=				Null;
		lrData.DONGHO			:=				RTRIM(TRIM(lrRec.dong_ho),'0');
		If lrRec.loan_yn = '1' Then
			lrData.LOAD_YN			:=				'Y';
		Else
			lrData.LOAD_YN			:=				'N';
		End	If;
		lrData.ORG_BANK_CODE	:=				lrRec.bank_cd;
		lrData.INNER_DOCU_NUMC	:=				lrRec.org_docu_numc;
		lrData.TRANSFER_YMD		:=				Null;
		lrData.TRANSFER_YN		:=				Null;

		GetCompAndBankCode(lrRec.account_no,lrData.COMP_CODE,lsBankCode);

		----------------------------------------------------------
		-- 입금(20)	,	입금취소(51)에 따른	구분 처리
		----------------------------------------------------------
		If lrRec.trade_gb	=	'51' THEN		 --	입금취소인 경우는	(-)	금액 처리
			lrData.RECV_AMT	:= - lrData.RECV_AMT;

		-- 기존에	INTERFACE된	내역인 A_FB_INTERFACE_PH에서 취소할	전문내역을 찾아서
		-- 관련정보를	가져와서 셋팅합니다.
			BEGIN
				SELECT
					A.ACCT_HOLDER_NAME,	-- 원거래	예금주명
					A.LOAD_YN,			-- 원거래, 대출유무
					A.DONGHO				-- 원거래, 동호
				INTO
					lrData.ACCT_HOLDER_NAME,
					lrData.LOAD_YN,
					lrData.DONGHO
				FROM	T_FB_INTERFACE_PH	A
				WHERE	A.INNER_DOCU_NUMC	=	lrRec.cancel_trade_no
				AND		A.ACCOUNT_NO = lrRec.account_no
				AND		A.RECV_YMD = Ar_Recv.send_date
				AND		A.BANK_CODE		=	Ar_recv.bank_code;
			EXCEPTION	When Others	Then
				NULL;	 --	해당 이전입금내역을	못찾는 경우는,수신된 내역	그대로 저장한다.
			END;

		END	IF;


		process_trg_ins_hsms(lrData);
	Exception	When Others	Then
		Begin
			FBS_UTIL_PKG.write_log('분양수입금처리','입금계좌:'||lrRec.account_no||' 입금일자:'	|| lrRec.trade_dt||' 동호	:'||RTRIM(TRIM(lrRec.dong_ho),'0')||
									'	전문번호 :'||lrRec.trade_no||' '||SqlErrm);
		Exception	When Others	Then
			Null;
		End;
	End;
	/******************************************************************************/
	/*	기능 : Van 수신	트리거 처리	분양->가상계좌거래명세							*/
	/******************************************************************************/
	Procedure	process_trg_HSMS_D3
	(
		Ar_Recv					FB_VAN_RECV_RECORD
	)
	Is
		ltNums								T_Nums;
		ltVars								T_Vars;
		lrRec								FB_REAL_VIRTUAL_RECORD;
		lrData								T_FB_INTERFACE_PH%RowType;
		lsBankCode							Varchar2(10);
	Begin
		ltNums(1)	:=	15;	--1.계좌번호
		ltNums(2)	:=	 2;	--2.거래구분
		ltNums(3)	:=	 2;	--3.은행코드
		ltNums(4)	:=	13;	--4.거래금액
		ltNums(5)	:=	13;	--5.거래후 잔액
		ltNums(6)	:=	 6;	--6.지로코드
		ltNums(7)	:=	16;	--7.성명
		ltNums(8)	:=	10;	--8.수표번호
		ltNums(9)	:=	16;	--9.거래처코드(CMS)
		ltNums(10):=	 8;	--10.거래일자
		ltNums(11):=	 6;	--11.거래시간
		ltNums(12):=	13;	--12.현금성
		ltNums(13):=	13;	--13.가계수표
		ltNums(14):=	13;	--14.타점권
		ltNums(15):=	 6;	--15.거래일련번호
		ltNums(16):=	 6;	--16.취소시일련번호
		ltNums(17):=	 8;	--17.취소시거래일자
		ltNums(18):=	 1;	--18.거래후	잔액부호
		ltNums(19):=	13;	--19.주민번호
		ltNums(20):=	 1;	--20.예비	대출여부
		ltNums(20):=	19;	--21.예비

		ltVars :=	SplitDocu(Ar_Recv.gaeb_area,ltNums);

		lrRec.account_no		:=				Trim(ltVars(1));					/*	입금계좌번호				 */
		lrRec.trade_gb			:=				Trim(ltVars(2));					/*	거래구분					 */
		lrRec.bank_cd			:=				Trim(ltVars(3));					/*	거래발행은행코드			 */
		lrRec.trade_amt			:=				To_Number(Trim(ltVars(4)));			/*	거래금액					 */
		lrRec.remain_amt		:=				To_Number(Trim(ltVars(5)));			/*	거래 후, 잔액				 */
		lrRec.giro_cd			:=				Trim(ltVars(6));					/*	지로코드					 */
		lrRec.depo_nm			:=				GetSingleBytes(ltVars(7));			/*	입금인 성명					 */
		lrRec.check_no			:=				Trim(ltVars(8));					/*	어음 및	수표번호			 */
		lrRec.cms				:=				Trim(ltVars(9));					/*	CMS코드(거래처코드)			 */
		lrRec.trade_dt			:=				Trim(ltVars(10));					/*	거래일자					 */
		lrRec.trade_time		:=				Trim(ltVars(11));					/*	거래시간					 */
		lrRec.cash_amt			:=				To_Number(Trim(ltVars(12)));		/*	현금						 */
		lrRec.check_amt			:=				To_Number(Trim(ltVars(13)));		/*	가계수표					 */
		lrRec.ta_check_amt		:=				To_Number(Trim(ltVars(14)));		/*	교환후,	인출가능금액		 */
		lrRec.trade_no			:=				Trim(ltVars(15));					/*	거래시 일련번호	추가		 */
		lrRec.cancel_trade_no	:=				Trim(ltVars(16));					/*	취소시 인련번호	추가		 */
		lrRec.cancel_trade_dt	:=				Trim(ltVars(17));					/*	취소시 거래일자	추가		 */
		lrRec.remain_sign		:=				Trim(ltVars(18));					/*	예비부(잔액부호)			 */
		lrRec.jumin_no			:=				Trim(ltVars(19));					/*	주민번호						 */
		lrRec.loan_yn			:=				Trim(ltVars(20));					/*	예비비(집단대출여부)(예비) */

		If lrRec.trade_gb	Not	In ('20','51') Then
			Return;
		End	If;

		If lrRec.remain_sign = '-' Then
			lrRec.remain_amt :=	-	lrRec.remain_amt;
		End	If;


		lrData.ACCOUNT_NO		:=				lrRec.account_no;
		lrData.ACCT_TYPE_GUBUN	:=				'2';				-- 가상계좌	구분코드:2
		lrData.BANK_CODE		:=				Ar_Recv.bank_code;
		lrData.TRX_GUBUN		:=				lrRec.trade_gb;
		lrData.RECV_YMD			:=				lrRec.trade_dt;
		lrData.RECV_AMT			:=				lrRec.trade_amt;
		lrData.REMAIN_AMT		:=				lrRec.remain_amt;
		lrData.ACCT_HOLDER_NAME	:=				lrRec.depo_nm;
		lrData.CMS_CODE			:=				lrRec.cms;
		lrData.DOCU_NUMC		:=				Ar_Recv.docu_numc;
		lrData.SSN				:=				lrRec.jumin_no;
		If lrRec.loan_yn = '1' Then
			lrData.LOAD_YN			:=				'Y';
		Else
			lrData.LOAD_YN			:=				'N';
		End	If;
		lrData.ORG_BANK_CODE	:=				lrRec.bank_cd;
		lrData.INNER_DOCU_NUMC	:=				lrRec.trade_no;
		lrData.TRANSFER_YMD		:=				Null;
		lrData.TRANSFER_YN		:=				Null;

		GetCompAndBankCode(lrRec.account_no,lrData.COMP_CODE,lsBankCode);

		----------------------------------------------------------
		-- 입금(20)	,	입금취소(51)에 따른	구분 처리
		----------------------------------------------------------
		If lrRec.trade_gb	=	'51' THEN		 --	입금취소인 경우는	(-)	금액 처리
			lrData.RECV_AMT	:= - lrData.RECV_AMT;
		END	IF;


		process_trg_ins_hsms(lrData);
	Exception	When Others	Then
		Begin
			FBS_UTIL_PKG.write_log('분양수입금처리','입금계좌:'||lrRec.account_no||' 입금일자:'	|| lrRec.trade_dt||' 주민번호	:'||RTRIM(TRIM(lrRec.jumin_no),'0')||
									'	전문번호 :'||lrRec.trade_no||' '||SqlErrm);
		Exception	When Others	Then
			Null;
		End;
	End;
	/******************************************************************************/
	/*	기능 : Van 수신	트리거 처리	분양->가상계좌결번요청							*/
	/******************************************************************************/
	Procedure	process_trg_HSMS_D4
	(
		Ar_Recv					FB_VAN_RECV_RECORD
	)
	Is
		ltNums								T_Nums;
		ltVars								T_Vars;
		lrRec								FB_REAL_VIRTUAL_RECORD;
		lrData								T_FB_INTERFACE_PH%RowType;
		lsBankCode							Varchar2(10);
	Begin
		ltNums(1)	:=	15;	--1.계좌번호
		ltNums(2)	:=	 2;	--2.거래구분
		ltNums(3)	:=	 2;	--3.은행코드
		ltNums(4)	:=	13;	--4.거래금액
		ltNums(5)	:=	13;	--5.거래후 잔액
		ltNums(6)	:=	 6;	--6.지로코드
		ltNums(7)	:=	16;	--7.성명
		ltNums(8)	:=	10;	--8.수표번호
		ltNums(9)	:=	16;	--9.거래처코드(CMS)
		ltNums(10):=	 8;	--10.거래일자
		ltNums(11):=	 6;	--11.거래시간
		ltNums(12):=	13;	--12.현금성
		ltNums(13):=	13;	--13.가계수표
		ltNums(14):=	13;	--14.타점권
		ltNums(15):=	 6;	--15.거래일련번호
		ltNums(16):=	 6;	--16.취소시일련번호
		ltNums(17):=	 8;	--17.취소시거래일자
		ltNums(18):=	 1;	--18.거래후	잔액부호
		ltNums(19):=	13;	--19.주민번호
		ltNums(20):=	 1;	--20.예비	대출여부
		ltNums(20):=	19;	--21.예비

		ltVars :=	SplitDocu(Ar_Recv.gaeb_area,ltNums);

		lrRec.account_no		:=				Trim(ltVars(1));					/*	입금계좌번호				 */
		lrRec.trade_gb			:=				Trim(ltVars(2));					/*	거래구분					 */
		lrRec.bank_cd			:=				Trim(ltVars(3));					/*	거래발행은행코드			 */
		lrRec.trade_amt			:=				To_Number(Trim(ltVars(4)));			/*	거래금액					 */
		lrRec.remain_amt		:=				To_Number(Trim(ltVars(5)));			/*	거래 후, 잔액				 */
		lrRec.giro_cd			:=				Trim(ltVars(6));					/*	지로코드					 */
		lrRec.depo_nm			:=				GetSingleBytes(ltVars(7));			/*	입금인 성명					 */
		lrRec.check_no			:=				Trim(ltVars(8));					/*	어음 및	수표번호			 */
		lrRec.cms				:=				Trim(ltVars(9));					/*	CMS코드(거래처코드)			 */
		lrRec.trade_dt			:=				Trim(ltVars(10));					/*	거래일자					 */
		lrRec.trade_time		:=				Trim(ltVars(11));					/*	거래시간					 */
		lrRec.cash_amt			:=				To_Number(Trim(ltVars(12)));		/*	현금						 */
		lrRec.check_amt			:=				To_Number(Trim(ltVars(13)));		/*	가계수표					 */
		lrRec.ta_check_amt		:=				To_Number(Trim(ltVars(14)));		/*	교환후,	인출가능금액		 */
		lrRec.trade_no			:=				Trim(ltVars(15));					/*	거래시 일련번호	추가		 */
		lrRec.cancel_trade_no	:=				Trim(ltVars(16));					/*	취소시 인련번호	추가		 */
		lrRec.cancel_trade_dt	:=				Trim(ltVars(17));					/*	취소시 거래일자	추가		 */
		lrRec.remain_sign		:=				Trim(ltVars(18));					/*	예비부(잔액부호)			 */
		lrRec.jumin_no			:=				Trim(ltVars(19));					/*	주민번호						 */
		lrRec.loan_yn			:=				Trim(ltVars(20));					/*	예비비(집단대출여부)(예비) */

		If lrRec.trade_gb	Not	In ('20','51') Then
			Return;
		End	If;

		If lrRec.remain_sign = '-' Then
			lrRec.remain_amt :=	-	lrRec.remain_amt;
		End	If;


		lrData.ACCOUNT_NO		:=				lrRec.account_no;
		lrData.ACCT_TYPE_GUBUN	:=				'2';				-- 가상계좌	구분코드:1
		lrData.BANK_CODE		:=				Ar_Recv.bank_code;
		lrData.TRX_GUBUN		:=				lrRec.trade_gb;
		lrData.RECV_YMD			:=				lrRec.trade_dt;
		lrData.RECV_AMT			:=				lrRec.trade_amt;
		lrData.REMAIN_AMT		:=				lrRec.remain_amt;
		lrData.ACCT_HOLDER_NAME	:=				lrRec.depo_nm;
		lrData.CMS_CODE			:=				lrRec.cms;
		lrData.DOCU_NUMC		:=				Ar_Recv.docu_numc;
		lrData.SSN				:=				lrRec.jumin_no;
		If lrRec.loan_yn = '1' Then
			lrData.LOAD_YN			:=				'Y';
		Else
			lrData.LOAD_YN			:=				'N';
		End	If;
		lrData.ORG_BANK_CODE	:=				lrRec.bank_cd;
		lrData.INNER_DOCU_NUMC	:=				lrRec.trade_no;
		lrData.TRANSFER_YMD		:=				Null;
		lrData.TRANSFER_YN		:=				Null;

		GetCompAndBankCode(lrRec.account_no,lrData.COMP_CODE,lsBankCode);

		----------------------------------------------------------
		-- 입금(20)	,	입금취소(51)에 따른	구분 처리
		----------------------------------------------------------
		If lrRec.trade_gb	=	'51' THEN		 --	입금취소인 경우는	(-)	금액 처리
			lrData.RECV_AMT	:= - lrData.RECV_AMT;
		END	IF;


		process_trg_ins_hsms(lrData);
	Exception	When Others	Then
		Begin
			FBS_UTIL_PKG.write_log('분양수입금처리','입금계좌:'||lrRec.account_no||' 입금일자:'	|| lrRec.trade_dt||' 주민번호	:'||RTRIM(TRIM(lrRec.jumin_no),'0')||
									'	전문번호 :'||lrRec.trade_no||' '||SqlErrm);
		Exception	When Others	Then
			Null;
		End;
	End;
	/******************************************************************************/
	/*	기능 : Van 수신	트리거 처리	분양-->메인										*/
	/******************************************************************************/
	Procedure	process_trg_HSMS
	(
		Ar_Recv					FB_VAN_RECV_RECORD
	)
	Is
		lsAccNo								T_ACCNO_CODE.ACCOUNT_NO%Type;
		lnCnt								Number;
		lsDocu								Varchar2(7)	:= Ar_Recv.docu_code	|| Ar_Recv.upmu_code;
	Begin
		lsAccNo	:= Trim(SubStrb(Ar_Recv.gaeb_area,1,15));
		Select
			Count(*)
		Into
			lnCnt
		From	T_ACCNO_CODE
		Where	HSMS_USE_CLS = 'T'
		And		FBS_ACCOUNT_CLS	=	'T'
		And		ACCOUNT_NO = lsAccNo;
		If lnCnt < 1 Then
			Return;
		End	If;
		If lsDocu	=	FB_DOCU_DEPO_TR_B	Then			--예금거래명세통지
			process_trg_HSMS_D1(Ar_Recv);
		ElsIf	lsDocu = FB_DOCU_DEPO_MISS_B Then		--예금거래결번통지
			process_trg_HSMS_D2(Ar_Recv);
		ElsIf	lsDocu = FB_DOCU_VIRT_TR_B Then		--가상계좌거래명세
			process_trg_HSMS_D3(Ar_Recv);
		ElsIf	lsDocu = FB_DOCU_VIRT_MISS_B Then		--가상계좌결번요청
			process_trg_HSMS_D4(Ar_Recv);
		End	If;
	End;


	/******************************************************************************/
	/*	기능 : Van 수신	트리거 처리	main											*/
	/******************************************************************************/
	/*************************************************************************/
	/*																		 */
	/*	1. 모듈ID	 : T_FB_VAN_RECV_TRG									 */
	/*	2. 모듈이름	 : VAN사 전문이	수신되었을때 처리로직					 */
	/*	3. 시스템	 : 회계시스템											 */
	/*	4. 서브시스템: FBS													 */
	/*	5. 모듈유형	 : TRIGGER												 */
	/*	6. 모듈언어	 : PL/SQL												 */
	/*	7. 모듈환경	 : Windows2003 Server+ Oracle	9.2.0						 */
	/*	8. 모듈DBMS	 : Oracle												 */
	/*	9. 모듈의	목적 및	주요기능											 */
	/*																		 */
	/*		-	전문이 수신된	경우,	하기의 5가지 기능을	수행한다.				 */
	/*																		 */
	/*		(1)	계좌잔액데이터 TABLE INSERT/UPDATE							 */
	/*			 : 각	계좌별 일자별	잔액을 가지고	있는 T_FB_ACCT_REAMIN_DATA	 */
	/*			 테이블에	계좌잔액을 UPDATE한다. 만약	잔액조회한 내역이	없	 */
	/*			 는	경우는 신규로	INSERT를 수행한다.						 */
	/*																		 */
	/*		(2)	예금거래명세 TABLE INSERT									 */
	/*			 : 예금거래명세	전문 및	결번응답 전문이	온 경우, 해당	테이블	 */
	/*			 (T_FB_CASH_TRX_DATA)에	각 항목별로	구분해서 INSERT수행한다	 */
	/*			 또	예금거래명세가 오는	경우,	해당 잔고가	표기되므로,	이를	 */
	/*			 계좌별	잔액Table에	insert혹은 update를	합니다.				 */
	/*																		 */
	/*		(3)	어음거래명세 TABLE INSERT									 */
	/*			 : 어음거래명세	전문 및	결번응답 전문이	온 경우, 해당	테이블	 */
	/*			 (T_FB_BILL_TRX_DATA)에	각 항목별로	구분해서 INSERT수행		 */
	/*																		 */
	/*		(4)	타행이체불능 통지	처리										 */
	/*			 : 타행이체불능통지	전문이 수신되면, 해당	지급건을 찾아서	상태 */
	/*			 를	'지급실패' 혹은	'일부지급실패'로 바꾸고, 등록된			 */
	/*			 사원에게	타행이체불능통지 메일을	발송합니다.				 */
	/*																		 */
	/*		(5)	응답없음 처리	후,	이체처리결과 수신시	처리					 */
	/*			 : 실시간이체처리시	일정시간을 LOOPING 을	WAITING을	수행하나,	 */
	/*			 WAITING TIMEOUT이후에 수신된	이체처리결과 전문이	수신된	 */
	/*			 경우, 해당	지급건을 찾아서	처리결과를 UPDATE합니다.		 */
	/*																		 */
	/*		(6)	분양전송 데이타	INSERT										 */
	/*																		 */
	/*			 : 예금거래명세/예금거래명세결번요청응답/가상계좌거래명세/	 */
	/*			 가상계좌	거래명세결번요청응답 등	4개의	전문이 수신되었을때	 */
	/*			 해당	계좌가 "계좌(T_ACCNO_CODE)'테이블의	HSMS_USE_CLS컬럼이 */
	/*			 TRUE인	계좌라면,	이 경우, 컬럼별로	필요데이타를 뽑아서,	 */
	/*			 "분양인터페이스(T_FB_INTERFACE_PH)"테이블에 INSERT수행		 */
	/*																		 */
	/* 10. 최초작성자: LG	CNS	신인철										 */
	/* 11. 최초작성일: 2005년12월21일										 */
	/* 12. 최종수정자:														 */
	/* 13. 최종수정일:														 */
	/*************************************************************************/
	Procedure	process_recv_trigger
	(
		Ar_TRAN_CODE					Varchar2,
		Ar_ENTE_CODE					Varchar2,
		Ar_BANK_CODE					Varchar2,
		Ar_DOCU_CODE					Varchar2,
		Ar_UPMU_CODE					Varchar2,
		Ar_SEND_CONT					Varchar2,
		Ar_DOCU_NUMC					Varchar2,
		Ar_SEND_DATE					Varchar2,
		Ar_SEND_TIME					Varchar2,
		Ar_RESP_CODE					Varchar2,
		Ar_GAEB_AREA					Varchar2,
		Ar_RESP_YEBU					Varchar2
	)
	Is
		lsDocu							Varchar2(7)	:= Ar_DOCU_CODE	|| Ar_UPMU_CODE;
		lrRecv							FB_VAN_RECV_RECORD;
	Begin
		lrRecv.TRAN_CODE	 :=	Ar_TRAN_CODE;
		lrRecv.ENTE_CODE	 :=	Ar_ENTE_CODE;
		lrRecv.BANK_CODE	 :=	Ar_BANK_CODE;
		lrRecv.DOCU_CODE	 :=	Ar_DOCU_CODE;
		lrRecv.UPMU_CODE	 :=	Ar_UPMU_CODE;
		lrRecv.SEND_CONT	 :=	Ar_SEND_CONT;
		lrRecv.DOCU_NUMC	 :=	Ar_DOCU_NUMC;
		lrRecv.SEND_DATE	 :=	Ar_SEND_DATE;
		lrRecv.SEND_TIME	 :=	Ar_SEND_TIME;
		lrRecv.RESP_CODE	 :=	Ar_RESP_CODE;
		lrRecv.GAEB_AREA	 :=	Ar_GAEB_AREA;
		lrRecv.RESP_YEBU	 :=	Ar_RESP_YEBU;
		--조건에 따른	처리기로 분기하기...
		If lsDocu	=	FB_DOCU_REMAIN_B Then			--만약 잔액	조회 이면
			process_trg_FB_DOCU_REMAIN_B(lrRecv);
		ElsIf	lsDocu = FB_DOCU_DEPO_TR_B Then		--만약 예금거래명세	이면
			process_trg_FB_DOCU_DEPO_TR_B(lrRecv);
		ElsIf	lsDocu = FB_DOCU_BILL_TRX_B	Then		--만약 어음거래명세	이면
			process_trg_FB_DOCU_BILL_TRX_B(lrRecv);
		ElsIf	lsDocu = FB_DOCU_TATR_RE_B Then		--타행이체 불능이면
			process_trg_FB_DOCU_TATR_RE_B(lrRecv);
		ElsIf	lsDocu In	(FB_DOCU_DATR_T,FB_DOCU_DATR_B,FB_DOCU_TATR_T,FB_DOCU_TATR_B)	Then	--이체 처리시
			process_trg_FB_DOCU_DATR_T(lrRecv);
		End	If;
		If lsDocu	In (FB_DOCU_DEPO_TR_B,FB_DOCU_DEPO_MISS_B,FB_DOCU_VIRT_TR_B,FB_DOCU_VIRT_MISS_B) Then	--분양수입금 관련이라면
			process_trg_HSMS(lrRecv);
		End	If;
	End;

END	FBS_MAIN_PKG;
/
