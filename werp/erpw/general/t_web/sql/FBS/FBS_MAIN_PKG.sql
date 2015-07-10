CREATE OR	REPLACE	PACKAGE	FBS_MAIN_PKG IS

	/******************************************************************************/
	/****																		 ****/
	/****																		 ****/
	/****			LG CNS VAN�� [�������]��	Batchó����	���� ��������			 ****/
	/****																		 ****/
	/****																		 ****/
	/******************************************************************************/

	SUCCESS_CODE		Constant Varchar2(2) :=	'OK';

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		 ����	�뷮��ü�� RECORD									 */
	/*----------------------------------------------------------------------------*/
	TYPE FB_KIUP_CASH_HEAD_RECORD	IS RECORD	(
		record_gubun		VARCHAR2(2)	:= '11',				 /*	�ĺ��ڵ� : 11			 */
		bank_code				VARCHAR2(2)	:= '03',				 /*	�����ڵ� : 03			 */
		upmu_code				VARCHAR2(2)	:= '82',				 /*	�����ڵ� : 82			 */
		pay_date				VARCHAR2(6)	,						 /*	��ü ó����(YYMMDD)6�ڸ� */
		dummy1					VARCHAR2(6)	,						 /*	����(SPACE)				 */
		out_account_no	VARCHAR2(14) ,					 /*	��ݰ��¹�ȣ			 */
		dummy2					VARCHAR2(1)	,						 /*	����(SPACE)				 */
		ente_code				VARCHAR2(7)	,						 /*	����ڵ�				 */
		dummy3					VARCHAR2(40));					 /*	����(SPACE)				 */

	TYPE FB_KIUP_CASH_DATA_RECORD	IS RECORD	(
		record_gubun			VARCHAR2(2)	:= '22',				 /*	�ĺ��ڵ� : 22			 */
		bank_code				VARCHAR2(2)	,						 /*	�Ա������ڵ�			 */
		upmu_code				VARCHAR2(2)	:= '82',				 /*	�����ڵ� : 82			 */
		data_seq				VARCHAR2(6)	,						 /*	������ �Ϸù�ȣ			 */
		in_account_no			VARCHAR2(14) ,					 /*	�Աݰ��¹�ȣ			 */
		pay_amt					VARCHAR2(10) ,					 /*	��ü��û�ݾ�			 */
		ente_use_field			VARCHAR2(10) ,					 /*	��ü�������			 */
		result_yebu				VARCHAR2(1)	,						 /*	ó����� 1:����	2:�Ҵ�	 */
		result_code				VARCHAR2(4),						 /*	ó������ڵ�			 */
		money_gubun				VARCHAR2(1),						 /*	�ڱݱ���				 */
		dummy					VARCHAR2(3)	);					 /*	����(SPACE)				 */

	TYPE FB_KIUP_CASH_TAIL_RECORD	IS RECORD	(
		record_gubun			VARCHAR2(2)	:= '33',				 /*	�ĺ��ڵ� : 33			 */
		bank_code				VARCHAR2(2)	,						 /*	�Ա������ڵ�			 */
		upmu_code				VARCHAR2(2)	:= '82',				 /*	�����ڵ� : 82			 */
		total_request_cnt		VARCHAR2(7)	,						 /*	�� �ǷڰǼ�				 */
		total_request_amt		VARCHAR2(13) ,					 /*	�� �Ƿڱݾ�				 */
		success_cnt				VARCHAR2(7)	 :=	'0000000',		 /*	����ó���Ǽ�			 */
		success_amt				VARCHAR2(13) :=	'0000000000000'	,	 /*	����ó���ݾ�			 */
		fail_cnt				VARCHAR2(7)	 :=	'0000000',		 /*	�Ҵ�ó���Ǽ�			 */
		fail_amt				VARCHAR2(13) :=	'0000000000000',	 /*	�Ҵ�ó���ݾ�			 */
		dummy1					VARCHAR2(6),						 /*	����(SPACE)				 */
		sign_no					VARCHAR2(4)	,						 /*	�����ȣ				 */
		dummy2					VARCHAR2(4));						 /*	����(SPACE)				 */


	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	���ڿܻ����ä�Ǵ㺸���� ��	 RECORD							*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_KIUP_BILL_HEAD_RECORD	IS RECORD	(
		h_gubun			 VARCHAR2(2) :=	'10',				 /*	���ڵ屸�� : 10			*/
		h_filename		 VARCHAR2(6) ,						 /*	����1						*/
		h_filecd		 VARCHAR2(4) ,						 /*	����2						*/
		h_fill11		 VARCHAR2(4) ,						 /*	����3						*/
		h_procdate		 VARCHAR2(8) ,						 /*	��������					*/
		h_upchecd		 VARCHAR2(12)	,						 /*	��ü�ڵ�					*/
		h_bankcd		 VARCHAR2(2) :=	'03' ,				 /*	�����ڵ�					*/
		h_culacc		 VARCHAR2(13)	,						 /*	���� ���¹�ȣ				*/
		h_fill12		 VARCHAR2(13)	,						 /*	����4						*/
		h_procgb		 VARCHAR2(1) :=	'1',				 /*	ó������ 1:��ü�䱸(��ü->����)	 2:ó�����(����->��ü)	*/
		h_filler		 VARCHAR2(82)	,						 /*	����5						*/
		h_filler_2		 VARCHAR2(2) );						 /*	����6						*/

	TYPE FB_KIUP_BILL_DATA_RECORD	IS RECORD	(
		d_gubun			 VARCHAR2(2) :=	'20' ,				 /*	���ڵ屸�� : 20			*/
		d_nor_can		 VARCHAR2(2) :=	'00' ,				 /*	�ŷ����� 00:����	99:���	*/
		d_docno			 VARCHAR2(14)	,						 /*	ä�ǹ�ȣ					*/
		d_cash_trx_yn	 VARCHAR2(1) :=	'2'	,				 /*	�������� 1:����	,	2:ä��	*/
		d_bil_amt		 VARCHAR2(13)	,						 /*	ä�Ǳݾ�					*/
		d_slco_bzno		 VARCHAR2(10)	,						 /*	��ǰ��ü ����ڹ�ȣ		*/
		d_fill11		 VARCHAR2(12)	,						 /*	����1						*/
		d_gtext			 VARCHAR2(20)	,						 /*	���޻����				*/
		d_chulgail		 VARCHAR2(8) ,						 /*	��ݰ�����(��������)		*/
		d_aummanki		 VARCHAR2(8) ,						 /*	ä�Ǹ�����				*/
		d_result		 VARCHAR2(4) ,						 /*	ó�����					*/
		d_paymentdate	 VARCHAR2(8) ,						 /*	����2						*/
		d_paymentid		 VARCHAR2(6) ,						 /*	����3						*/
		d_indate		 VARCHAR2(8) ,						 /*	��ǰ����:���ݰ�꼭����	*/
		d_pummok		 VARCHAR2(20)	,						 /*	ǰ��						*/
		d_fill12		 VARCHAR2(9) ,						 /*	����4						*/
		d_dbrtcd		 VARCHAR2(2) ,						 /*	ó��RETURN CODE			*/
		d_cheriy		 VARCHAR2(1) ,						 /*	����ó������				*/
		d_filler		 VARCHAR2(2) );						 /*	����5						*/

	TYPE FB_KIUP_BILL_TAIL_RECORD	IS RECORD	(
		t_gubun			 VARCHAR2(2) :=	'30',				 /*	���ڵ屸�� : 30			*/
		t_totgun		 VARCHAR2(6) ,						 /*	�� ���۰Ǽ�				*/
		t_totamt		 VARCHAR2(13)	,						 /*	�� ���۱ݾ�				*/
		t_norgun		 VARCHAR2(6) ,						 /*	����ó���Ǽ�				*/
		t_noramt		 VARCHAR2(13)	,						 /*	����ó���ݾ�				*/
		t_errgun		 VARCHAR2(6) ,						 /*	���� ó���Ǽ�				*/
		t_erramt		 VARCHAR2(13)	,						 /*	���� ó���ݾ�				*/
		t_fill11		 VARCHAR2(91)	);					 /*	����						*/



	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	���� �ܴ��	�ŷ��� ������	RECORD							*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_KIUP_SUPPLIER_HEAD_RECORD	IS RECORD	(
		h_gubun			 VARCHAR2(2) :=	'10',				 /*	���ڵ屸�� : 10			*/
		h_UPCHENO		 VARCHAR2(8) ,						 /*	��ü��ȣ					*/
		h_bankcd		 VARCHAR2(2) :=	'03' ,				 /*	�����ڵ� : 03				*/
		h_gubun01		 VARCHAR2(1) ,						 /*	����						*/
		h_jendate		 VARCHAR2(8) ,						 /*	��������					*/
		h_jobsijak		 VARCHAR2(8) ,						 /*	����						*/
		h_jobend		 VARCHAR2(8) ,						 /*	����						*/
		h_saupja		 VARCHAR2(10)	,						 /*	CJ���� ����ڹ�ȣ			*/
		h_filler		 VARCHAR2(101) ,					 /*	����						*/
		h_fi0d25		 VARCHAR2(2) ,						 /*	����						*/
		h_fil_48		 VARCHAR2(48)	,						 /*	����						*/
		h_fil_end		 VARCHAR2(2) );						 /*	����						*/

	TYPE FB_KIUP_SUPPLIER_DATA_RECORD	IS RECORD	(
		d_gubun			 VARCHAR2(2) :=	'20',				 /*	���ڵ屸�� : 20			 */
		d_seqno			 VARCHAR2(11)	,						 /*	�Ϸù�ȣ					 */
		d_saupno		 VARCHAR2(10)	,						 /*	����ڹ�ȣ				 */
		d_juminno		 VARCHAR2(13)	,						 /*	�ֹι�ȣ					 */
		d_sangho		 VARCHAR2(30)	,						 /*	��ȣ						 */
		d_gyeoje		 VARCHAR2(1) ,						 /*	����						 */
		d_newilja		 VARCHAR2(8) ,						 /*	�ű�����					 */
		d_cloilja		 VARCHAR2(8) ,						 /*	��������					 */
		d_adjilja		 VARCHAR2(12)	,						 /*	����						 */
		d_iacctno		 VARCHAR2(15)	,						 /*	�������¹�ȣ (���¾�ü)	 */
		d_brno			 VARCHAR2(3) ,						 /*	����						 */
		d_filler		 VARCHAR2(25)	,						 /*	����						 */
		d_fi0d25		 VARCHAR2(2) ,						 /*	����						 */
		d_fil_48		 VARCHAR2(48)	,						 /*	����						 */
		d_fil_end		 VARCHAR2(2) );						 /*	����						 */

	TYPE FB_KIUP_SUPPLIER_TAIL_RECORD	IS RECORD	(
		t_gubun			 VARCHAR2(2) :=	'30' ,				 /*	���ڵ屸�� : 30			 */
		t_totgun		 VARCHAR2(6) ,						 /*	�� ���۰Ǽ�				 */
		t_newgun		 VARCHAR2(6) ,						 /*	�ű԰Ǽ�					 */
		t_adjgun		 VARCHAR2(6) ,						 /*	����Ǽ�					 */
		t_clogun		 VARCHAR2(6) ,						 /*	�����Ǽ�					 */
		t_filler		 VARCHAR2(122) ,					 /*	��ü�ڵ�					 */
		d_fi0d25		 VARCHAR2(2) ,						 /*	����						 */
		d_fil_49		 VARCHAR2(48)	,						 /*	����						 */
		d_fil_end		 VARCHAR2(2) );						 /*	����						 */


	/******************************************************************************/
	/****																		 ****/
	/****																		 ****/
	/****			LG CNS VAN�� [��������]��	Batchó����	���� ��������			 ****/
	/****																		 ****/
	/****																		 ****/
	/******************************************************************************/

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	���� �뷮��ü��	RECORD										*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_KUKMIN_CASH_HEAD_RECORD	IS RECORD	(
		record_gubun			VARCHAR2(1)	:= 'S',				 /*	�ĺ��ڵ� : S			 */
		transfer_gubun			VARCHAR2(2)	:= 'C2',				 /*	�ۼ��ű��� ����۽�:C2 ����:2C */
		bank_code				VARCHAR2(2)	:= '04',				 /*	�����ڵ� : 04			 */
		ente_code				VARCHAR2(8)	,						 /*	����ڵ�				 */
		dummy1					VARCHAR2(6)	,						 /*	����					 */
		pay_date				VARCHAR2(6)	,						 /*	��ü ó����(YYMMDD)6�ڸ� */
		dummy2					VARCHAR2(6)	,						 /*	����					 */
		out_account_pwd			VARCHAR2(8)	,						 /*	����� ��й�ȣ			 */
		out_account_no			VARCHAR2(14) ,					 /*	����¹�ȣ				 */
		dummy3					VARCHAR2(26));					 /*	����					 */

	TYPE FB_KUKMIN_CASH_DATA_RECORD	IS RECORD	(
		record_gubun			VARCHAR2(1)	:= 'D',				 /*	�ĺ��ڵ� : D			 */
		data_seq				VARCHAR2(5)	,						 /*	������ �Ϸù�ȣ			 */
		bank_code				VARCHAR2(2)	,						 /*	�Ա������ڵ�			 */
		in_account_no			VARCHAR2(14) ,					 /*	�Աݰ��¹�ȣ			 */
		pay_amt					VARCHAR2(10) ,					 /*	��ü��û�ݾ�			 */
		result_yn				VARCHAR2(1)	,						 /*	ó����� Y Ȥ��	N		 */
		result_code				VARCHAR2(4),						 /*	ó������ڵ�			 */
		paid_amt				VARCHAR2(10) :=	'0000000000',		 /*	������ü�ݾ�:�������	 */
		ente_use_field			VARCHAR2(10) ,					 /*	��ü�������			 */
		remark					VARCHAR2(8)	,						 /*	��������				 */
		dummy1					VARCHAR2(12) ,					 /*	����					 */
		remark_gubun			VARCHAR2(1)	,						 /*	�������ڱ���:�����	���� */
		dummy2					VARCHAR2(2)	);					 /*	����					 */

	TYPE FB_KUKMIN_CASH_TAIL_RECORD	IS RECORD	(
		record_gubun			VARCHAR2(1)	:= 'E',				 /*	�ĺ��ڵ� : E			 */
		total_request_cnt		VARCHAR2(7)	,						 /*	�� �ǷڰǼ�				 */
		total_request_amt		VARCHAR2(13) ,					 /*	�� �Ƿڱݾ�				 */
		success_cnt				VARCHAR2(7)	 :=	'0000000',		 /*	����ó���Ǽ�			 */
		success_amt				VARCHAR2(13) :=	'0000000000000'	,	 /*	����ó���ݾ�			 */
		fail_cnt				VARCHAR2(7)	 :=	'0000000',		 /*	�Ҵ�ó���Ǽ�			 */
		fail_amt				VARCHAR2(13) :=	'0000000000000',	 /*	�Ҵ�ó���ݾ�			 */
		sign_no					VARCHAR2(4)	,						 /*	�����ȣ				 */
		dummy					VARCHAR2(8));						 /*	����					 */

	/******************************************************************************/
	/****																		 ****/
	/****																		 ****/
	/****			LG CNS VAN�� [�츮����]��	Batchó����	���� ��������			 ****/
	/****																		 ****/
	/****																		 ****/
	/******************************************************************************/

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	���� �뷮��ü��	RECORD										*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_WOORI_CASH_HEAD_RECORD IS	RECORD (
		record_gubun			VARCHAR2(1)	:= 'S',				 /*	�ĺ��ڵ� : S			 */
		transfer_gubun		VARCHAR2(2)	:= 'C2',				 /*	�ۼ��ű��� ����۽�:C2 ����:2C */
		ente_code					VARCHAR2(10) ,					 /*	��ü�ڵ�				 */
		bank_code					VARCHAR2(2)	:= '20',				 /*	�����ڵ� : 20			 */
		transfer_date			VARCHAR2(6)	,						 /*	�������� YYMMDD			 */
		pay_date					VARCHAR2(6)	,						 /*	��ü ó����(YYMMDD)6�ڸ� */
		out_account_no		VARCHAR2(14) ,					 /*	����¹�ȣ				 */
		out_account_pwd		VARCHAR2(8)	,						 /*	����� ��й�ȣ			 */
		return_trx				VARCHAR2(1)	,						 /*	��üȸ��				 */
		info_gubun				VARCHAR2(1)	:= '1',				 /*	�뺸���� 1:��ü	2:�Ҵ� 3:�뺸���ʿ�	*/
		dummy1						VARCHAR2(5)	,						 /*	��ó������,�ŷ����ڵ�	 */
		van								VARCHAR2(6)	:= 'LGEDS',			 /*	VAN�ڵ�					 */
		dummy2						VARCHAR2(17));					 /*	����					 */

	TYPE FB_WOORI_CASH_DATA_RECORD IS	RECORD (
		record_gubun			VARCHAR2(1)	:= 'D',				 /*	�ĺ��ڵ� : D			 */
		bank_code				VARCHAR2(2)	,						 /*	�Ա������ڵ�			 */
		in_account_no			VARCHAR2(15) ,					 /*	�Աݰ��¹�ȣ			 */
		trx_gubun				VARCHAR2(2)	,						 /*	�Ա���ü 31:�޿�,32:��,40:��Ÿ , �����	���� ����	*/
		pay_amt					VARCHAR2(11) ,					 /*	��ü��û�ݾ�			 */
		pay_date				VARCHAR2(2)	,						 /*	��ü���� - ������		 */
		result_yn				VARCHAR2(1)	,						 /*	ó����� Y(����) N(�Ҵ�) , Z(�Ϻ���ü) */
		result_code				VARCHAR2(4)	,						 /*	ó������ڵ�			 */
		fail_amt				VARCHAR2(10) ,					 /*	��ó���ݾ�				 */
		ente_use_field			VARCHAR2(24) ,					 /*	��ü��뿵��			 */
		dummy					VARCHAR2(8));						 /*	����					 */

	TYPE FB_WOORI_CASH_TAIL_RECORD IS	RECORD (
		record_gubun			VARCHAR2(1)	:= 'E',				 /*	�ĺ��ڵ� : E			 */
		total_transfer_cnt		VARCHAR2(7)	,						 /*	�� ���۰Ǽ�	DATA�Ǽ�+2	 */
		total_request_cnt		VARCHAR2(7)	,						 /*	�� �ǷڰǼ�				 */
		total_request_amt		VARCHAR2(13) ,					 /*	�� �Ƿڱݾ�				 */
		success_cnt				VARCHAR2(7)	 :=	'0000000',		 /*	����ó���Ǽ�			 */
		success_amt				VARCHAR2(13) :=	'0000000000000'	,	 /*	����ó���ݾ�			 */
		fail_cnt				VARCHAR2(7)	 :=	'0000000',		 /*	�Ҵ�ó���Ǽ�			 */
		fail_amt				VARCHAR2(13) :=	'0000000000000',	 /*	�Ҵ�ó���ݾ�			 */
		sign_no					VARCHAR2(6)	,						 /*	�����ȣ				 */
		dummy					VARCHAR2(6));						 /*	����					 */



	/******************************************************************************/
	/****																		 ****/
	/****																		 ****/
	/****			LG CNS VAN�� [�ϳ�����]��	Batchó����	���� ��������			 ****/
	/****																		 ****/
	/****																		 ****/
	/******************************************************************************/

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	���� �뷮��ü��	RECORD										*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_HANA_CASH_HEAD_RECORD	IS RECORD	(
		record_gubun			VARCHAR2(1)	:= 'S',				 /*	�ĺ��ڵ� : S			 */
		upmu_gubun				VARCHAR2(2)	:= '10',				 /*	�������� : 10			 */
		bank_code				VARCHAR2(2)	:= '81',				 /*	�����ڵ� : 81			 */
		transfer_date			VARCHAR2(8)	,						 /*	������ ������(YYYYMMDD)	 */
		pay_date				VARCHAR2(6)	,						 /*	��ü ó����(YYMMDD)6�ڸ� */
		out_account_no			VARCHAR2(14) ,					 /*	����¹�ȣ				 */
		transfer_type			VARCHAR2(2),						 /*	��ü����				 */
		comp_no					VARCHAR2(6)	:= '000000',			 /*	ȸ���ȣ/��ü��'0'����	 */
		result_gubun			VARCHAR2(1)	:= '1',				 /*	ó������뺸���� 1:����	2:������ 3:�����	*/
		transfer_seq			VARCHAR2(1)	:= '1',				 /*	��������				 */
		out_account_pwd			VARCHAR2(8)	,						 /*	����� ��й�ȣ			 */
		dummy					VARCHAR2(20) ,					 /*	����					 */
		format					VARCHAR2(1)	:= '1',				 /*	����					 */
		van						VARCHAR2(2)	:= 'LG');				 /*	VAN��	:	LG				 */

	TYPE FB_HANA_CASH_DATA_RECORD	IS RECORD	(
		record_gubun			VARCHAR2(1)	:= 'D',				 /*	�ĺ��ڵ� : D			 */
		data_seq				VARCHAR2(7)	,						 /*	������ �Ϸù�ȣ			 */
		bank_code				VARCHAR2(2)	,						 /*	�Ա������ڵ�			 */
		in_account_no			VARCHAR2(14) ,					 /*	�Աݰ��¹�ȣ			 */
		pay_amt					VARCHAR2(11) ,					 /*	��ü��û�ݾ�			 */
		paid_amt				VARCHAR2(11) :=	'00000000000',	 /*	������ü�ݾ�:�������	*/
		biz_ss_no				VARCHAR2(13) ,					 /*	�ֹ�/����ڹ�ȣ			 */
		result_yn				VARCHAR2(1)	,						 /*	ó����� Y Ȥ��	N		 */
		result_code				VARCHAR2(4)	,						 /*	�Ҵ��ڵ�				 */
		remark					VARCHAR2(12) ,					 /*	������峻��:���ǻ���	 */
		dummy					VARCHAR2(4));						 /*	����					 */

	TYPE FB_HANA_CASH_TAIL_RECORD	IS RECORD	(
		record_gubun			VARCHAR2(1)	:= 'E',				 /*	�ĺ��ڵ� : E			 */
		total_request_cnt		VARCHAR2(7)	,						 /*	�� �ǷڰǼ�				 */
		total_request_amt		VARCHAR2(13) ,					 /*	�� �Ƿڱݾ�				 */
		success_cnt				VARCHAR2(7)	 :=	'0000000',		 /*	����ó���Ǽ�			 */
		success_amt				VARCHAR2(13) :=	'0000000000000'	,	 /*	����ó���ݾ�			 */
		fail_cnt				VARCHAR2(7)	 :=	'0000000',		 /*	�Ҵ�ó���Ǽ�			 */
		fail_amt				VARCHAR2(13) :=	'0000000000000',	 /*	�Ҵ�ó���ݾ�			 */
		sign_no					VARCHAR2(8)	,						 /*	�����ȣ				 */
		dummy					VARCHAR2(11));					 /*	����					 */


	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	����ī��� RECORD											*/
	/*----------------------------------------------------------------------------*/

	TYPE FB_HANA_BILL_HEAD_RECORD	IS RECORD	(
		record_gubun			VARCHAR2(1)	:= 'S',				 /*	���� : S						*/
		upmu_gubun				VARCHAR2(4)	:= 'R351',			 /*	�������� : ����ī��	���ο�û	*/
		bill_ente_code			VARCHAR2(4)	,						 /*	�ϳ������� �ο���	��ü�����ڵ�	*/
		service_gubun			VARCHAR2(1)	:= '1',				 /*	���񽺱��� 1:����	 2:������		*/
		approval_req_date		VARCHAR2(8)	,						 /*	���ο�û����					*/
		transfer_seq			VARCHAR2(1)	:= '1',				 /*	��������						*/
		branch_no				VARCHAR2(3)	:= '001',				 /*	����� ��ȣ						*/
		transfer_time			VARCHAR2(6)	,						 /*	���۽ð� HHMMSS					*/
		test_gubun				VARCHAR2(1)	:= 'R',				 /*	R	:	REAL						*/
		biz_no					VARCHAR2(13) ,					 /*	����ڹ�ȣ : "999"+����ڹ�ȣ	*/
		dummy					VARCHAR2(158)	);					 /*	����							*/

	TYPE FB_HANA_BILL_DATA_RECORD	IS RECORD	(
		record_gubun			VARCHAR2(1)	:= 'D',				 /*	���� : D						*/
		trade_seq				VARCHAR2(5)	,						 /*	�ŷ���ȣ:���ں�	Sequence No		*/
		transfer_date			VARCHAR2(8)	,						 /*	�ŷ����� : ��������				*/
		card_no					VARCHAR2(16) ,					 /*	ī���ȣ						*/
		member_no				VARCHAR2(11) ,					 /*	������ ��ȣ						*/
		approval_amt			VARCHAR2(11) ,					 /*	���αݾ�						*/
		installment_period		VARCHAR2(3)	,						 /*	�ҺαⰣ						*/
		unredeemed_fee_gubun	VARCHAR2(1)	:= '1' ,				 /*	��ġ������ �δ�	1:ī�� 2:������	*/
		unredeemed_period		VARCHAR2(3)	,						 /*	����Աݰ�ġ�Ⱓ				*/
		installment_fee_gubun	VARCHAR2(1)	:= '1' ,				 /*	���Ҽ����� �δ�	1:ī�� 2:������	*/
		due_pay_date			VARCHAR2(8)	,						 /*	�������� : ����	������			*/
		remark					VARCHAR2(12) ,					 /*	���,	��ü�� ����	���			*/
		approval_no				VARCHAR2(10) ,					 /*	���ι�ȣ						*/
		result_code				VARCHAR2(4)	,						 /*	�����ڵ�						*/
		member_fee				VARCHAR2(9)	,						 /*	������ �δ�	������				*/
		member_total_amt		VARCHAR2(11) ,					 /*	������ �Ա�	�Ѿ�				*/
		bill_discount_date		VARCHAR2(8)	,						 /*	�����Աݽ������� : ���ΰ�����	*/
		bill_date				VARCHAR2(8)	,						 /*	���ݰ�꼭 ����					*/
		description				VARCHAR2(15) ,					 /*	����							*/
		dummy					VARCHAR2(44));					 /*	����							*/

	TYPE FB_HANA_BILL_TAIL_RECORD	IS RECORD	(
		record_gubun			VARCHAR2(1)	:= 'E',				 /*	���� : E						*/
		record_cnt				VARCHAR2(5)	,						 /*	���ڵ� ����	:HEAD	 TAIL	����	 */
		approval_req_cnt		VARCHAR2(5)	,						 /*	���ο�û�ڷ� ����				*/
		approval_req_amt		VARCHAR2(15) ,					 /*	���ο�û�ݾ�					*/
		success_cnt				VARCHAR2(5)	,						 /*	������ΰǼ�					*/
		success_amt				VARCHAR2(15) ,					 /*	������αݾ�					*/
		member_total_fee		VARCHAR2(15) ,					 /*	������ �δ�	�� ������			*/
		member_total_amt		VARCHAR2(15) ,					 /*	������ �Ա�	�Ѿ�				*/
		fail_cnt				VARCHAR2(5)	,						 /*	���ο����Ǽ�					*/
		fail_amt				VARCHAR2(15) ,					 /*	���ο����ݾ�					*/
		sign_no					VARCHAR2(11) ,					 /*	�����ȣ						*/
		dummy					VARCHAR2(93));					 /*	����							*/

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	����ī�� �ŷ���	������ RECORD								*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_HANA_SUPPLIER_HEAD_RECORD	IS RECORD	(
		record_gubun			VARCHAR2(1)	:= 'S',				 /*	���� : S						*/
		seq						VARCHAR2(5)	,						 /*	�Ϸù�ȣ						*/
		bill_ente_code			VARCHAR2(4)	,						 /*	��ü�ڵ�						*/
		upmu_gubun				VARCHAR2(4)	:= 'R390',			 /*	�������� : ����ī��/����������	*/
		service_gubun			VARCHAR2(1)	,						 /*	���񽺱��� 1:����	2:������		*/
		trade_date				VARCHAR2(8)	,						 /*	�ŷ�����						*/
		transfer_seq			VARCHAR2(1)	,						 /*	��������						*/
		branch_no				VARCHAR2(3)	,						 /*	����� ��ȣ						*/
		dummy					VARCHAR2(473));					 /*	����							*/

	TYPE FB_HANA_SUPPLIER_DATA_RECORD	IS RECORD	(
		record_gubun			 VARCHAR2(1) :=	'D'	,				 /*	���� : D						*/
		seq								 VARCHAR2(5) ,						 /*	���ں� Sequence	No				*/
		bill_ente_code		 VARCHAR2(4) ,						 /*	�ϳ������� �ο���	��ü�ڵ�		*/
		ente_name					 VARCHAR2(32),						 /*	�ϳ������� �ο���	��ü��		*/
		service_gubun			 VARCHAR2(1) ,						 /*	���񽺱��� 1:����	,	2:������	*/
		memeber_gubun			 VARCHAR2(1) ,						 /*	ȸ������	1:ī�� , 2:������		*/
		card_member_no		 VARCHAR2(16)	,					 /*	ī��/������	��ȣ				*/
		memeber_kor_name	 VARCHAR2(32)	,					 /*	ȸ���ѱ۸�						*/
		info_gubun				 VARCHAR2(1) ,						 /*	�̵����� 0:����	 9:����			*/
		new_issue_date		 VARCHAR2(8) ,						 /*	�ű�����						*/
		cancel_date				 VARCHAR2(8) ,						 /*	����/�������					*/
		member_tel_no			 VARCHAR2(19)	,					 /*	ȸ�� ��ȭ��ȣ					*/
		home_zip_code			 VARCHAR2(6) ,						 /*	����/������	�����ȣ			*/
		home_addr1				 VARCHAR2(42)	,					 /*	����/������	�ּ�1				*/
		home_sub_addr			 VARCHAR2(82)	,					 /*	����/������	�μ� �ּ�			*/
		home_tel_1				 VARCHAR2(19)	,					 /*	����/������	��ȭ��ȣ 1			*/
		home_tel_2				 VARCHAR2(14)	,					 /*	����/������	��ȭ��ȣ 2			*/
		home_mng_division	 VARCHAR2(22)	,					 /*	����/������	�����μ�			*/
		comp_zip_code			 VARCHAR2(6) ,						 /*	ȸ��/������	�����ȣ			*/
		comp_addr1				 VARCHAR2(42)	,					 /*	ȸ��/������	�ּ�1				*/
		comp_sub_addr			 VARCHAR2(82)	,					 /*	ȸ��/������	�μ� �ּ�			*/
		comp_tel_no				 VARCHAR2(19)	,					 /*	ȸ�� ��ȭ��ȣ					*/
		biz_ss_no					 VARCHAR2(13)	,					 /*	�ֹ�(�����) ��ȣ				*/
		mng_no						 VARCHAR2(12)	,					 /*	������ȣ						*/
		bank_code					 VARCHAR2(2) ,						 /*	�����ڵ� : 81					*/
		dummy							 VARCHAR2(11));					 /*	����							*/

	TYPE FB_HANA_SUPPLIER_TAIL_RECORD	IS RECORD	(
		record_gubun			 VARCHAR2(1) :=	'E'	,				 /*	���� : E						*/
		seq								 VARCHAR2(5) ,						 /*	�Ϸù�ȣ : 99999				*/
		bill_ente_code		 VARCHAR2(4) ,						 /*	��ü ����	�ڵ�					*/
		record_cnt				 VARCHAR2(5) ,						 /*	���ڵ尹��,	DATA RECORD	�� ����	*/
		memeber_person_cnt VARCHAR2(5) ,						 /*	ī��ȸ������ �Ǽ�				*/
		memeber_biz_cnt		 VARCHAR2(5) ,						 /*	������ ȸ������	�Ǽ�			*/
		dummy							 VARCHAR2(475));					 /*	����							*/

	/******************************************************************************/
	/****																		 ****/
	/****																		 ****/
	/****		LG CNS VAN�� [ REALTIME	�ۼ��� ] ������	���� ����				 ****/
	/****																		 ****/
	/****																		 ****/
	/******************************************************************************/



	/*----------------------------------------------------------------------------*/
	/* �����ڵ�																		*/
	/*----------------------------------------------------------------------------*/
	KIUP_BANK_CD					 VARCHAR2(2) :=	'03';		-- �������
	KUKMIN_BANK_CD					 VARCHAR2(2) :=	'04';		-- ��������
	WOORI_BANK_CD					 VARCHAR2(2) :=	'20';		-- �츮����
	HANA_BANK_CD					 VARCHAR2(2) :=	'81';		-- �ϳ�����

	/*----------------------------------------------------------------------------*/
	/* ��ü��, ���ھ���	realtimeó���� �ִ�	���ð� ����	(����:��)					*/
	/*----------------------------------------------------------------------------*/
	DEFAULT_TIMEOUT	NUMBER(10)	 :=	60;

	/*----------------------------------------------------------------------------*/
	/* ��Ÿ	��� ����																*/
	/*----------------------------------------------------------------------------*/
	CRLF				VARCHAR2(2)	 :=	CHR(10)||CHR(13);

	-- OS����	DIRECTORY	PATH�� �˱�����	ORACLE�� DIRECTORY NAME
	FBS_REALTIME_SEND_DIR	 VARCHAR2(100) :=	'FBS_REALTIME_SEND_DIR';		-- �ǽð�	ó�� ��������	�۽�����
	FBS_REALTIME_TEMP_DIR	 VARCHAR2(100) :=	'FBS_REALTIME_TEMP_DIR';		-- �ǽð�	ó�� ��������	�ӽ�����



	/*----------------------------------------------------------------------------*/
	/*	 �ǽð�	�߹�ŷ ������ȣ	DEFINE												*/
	/*----------------------------------------------------------------------------*/
	FB_DOCU_OPEN_T			VARCHAR2(7)	:= '0800100';	/*	��������			(��ü=>����)	*/
	FB_DOCU_OPEN_B			VARCHAR2(7)	:= '0810100';	/*	��������			(����=>��ü)	*/

	FB_DOCU_DEPO_TR_T		VARCHAR2(7)	:= '0200300';	/*	���ݰŷ�������(��ü=>����)	*/
	FB_DOCU_DEPO_TR_B		VARCHAR2(7)	:= '0210300';	/*	���ݰŷ�������(����=>��ü)	*/

	FB_DOCU_DEPO_MISS_T		VARCHAR2(7)	:= '0200600';	/*	���ݰŷ����		(��ü=>����)	*/
	FB_DOCU_DEPO_MISS_B		VARCHAR2(7)	:= '0210600';	/*	���ݰŷ����		(����=>��ü)	*/

	FB_DOCU_VIRT_TR_T		VARCHAR2(7)	:= '0210100';	/*	������°ŷ���(��ü=>����)	*/
	FB_DOCU_VIRT_TR_B		VARCHAR2(7)	:= '0200100';	/*	������°ŷ���(����=>��ü)	*/

	FB_DOCU_VIRT_MISS_T		VARCHAR2(7)	:= '0200200';	/*	������°����û(��ü=>����)	*/
	FB_DOCU_VIRT_MISS_B		VARCHAR2(7)	:= '0210200';	/*	������°����û(����=>��ü)	*/

	FB_DOCU_DATR_T			VARCHAR2(7)	:= '0100100';	/*	������ü			(��ü=>����)	*/
	FB_DOCU_DATR_B			VARCHAR2(7)	:= '0110100';	/*	������ü			(����=>��ü)	*/

	FB_DOCU_TATR_T			VARCHAR2(7)	:= '0100200';	/*	Ÿ����ü			(��ü=>����)	*/
	FB_DOCU_TATR_B			VARCHAR2(7)	:= '0110200';	/*	Ÿ����ü			(����=>��ü)	*/

	FB_DOCU_TR_RE_T			VARCHAR2(7)	:= '0600100';	/*	��üó�������ȸ(��ü=>����)	*/
	FB_DOCU_TR_RE_B			VARCHAR2(7)	:= '0610100';	/*	��üó�������ȸ(����=>��ü)	*/

	FB_DOCU_REMAIN_T		VARCHAR2(7)	:= '0600300';	/*	�ܾ���ȸ			(��ü=>����)	*/
	FB_DOCU_REMAIN_B		VARCHAR2(7)	:= '0610300';	/*	�ܾ���ȸ			(����=>��ü)	*/

	FB_DOCU_SUM_T			VARCHAR2(7)	:= '0700100';	/*	����ó��			(��ü=>����)	*/
	FB_DOCU_SUM_B			VARCHAR2(7)	:= '0710000';	/*	����ó��			(����=>��ü)	*/

	FB_DOCU_TATR_RE_T		VARCHAR2(7)	:= '0410100';	/*	Ÿ����ü�������(��ü=>����)	*/
	FB_DOCU_TATR_RE_B		VARCHAR2(7)	:= '0400100';	/*	Ÿ����ü�������(����=>��ü)	*/

	FB_DOCU_NAME_CHECK_T	VARCHAR2(7)	:= '0400400';	/*	������ ������ȸ	(��ü=>����)	*/
	FB_DOCU_NAME_CHECK_B	VARCHAR2(7)	:= '0410400';	/*	������ ������ȸ	(����=>��ü)	*/

	FB_DOCU_BILL_ISSUE_T	VARCHAR2(7)	:= '0100310';	/*	��������			(��ü=>����)	*/
	FB_DOCU_BILL_ISSUE_B	VARCHAR2(7)	:= '0110310';	/*	��������			(����=>��ü)	*/

	FB_DOCU_VENDOR_T		VARCHAR2(7)	:= '0110320';	/*	�����ŷ�������	(��ü=>����)	*/
	FB_DOCU_VENDOR_B		VARCHAR2(7)	:= '0100320';	/*	�����ŷ�������	(����=>��ü)	*/

	FB_DOCU_BILL_TRX_T		VARCHAR2(7)	:= '0210400';	/*	�����ŷ���		 (��ü=>����)	*/
	FB_DOCU_BILL_TRX_B		VARCHAR2(7)	:= '0200400';	/*	�����ŷ���		 (����=>��ü)	*/

	FB_DOCU_BILL_MISS_T		VARCHAR2(7)	:= '0200500';	/*	�����������û (��ü=>����)	*/
	FB_DOCU_BILL_MISS_B		VARCHAR2(7)	:= '0210500';	/*	�����������û (����=>��ü)	*/










	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	�ǽð� �߹�ŷ	�۽����̺� RECORD								*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_VAN_SEND_RECORD	IS RECORD	(
		tran_code				VARCHAR2(9),			 /*	�ĺ��ڵ�					*/
		ente_code				VARCHAR2(8),			 /*	��ü�ڵ�					*/
		bank_code				VARCHAR2(2),			 /*	�����ڵ�					*/
		docu_code				VARCHAR2(4),			 /*	�����ڵ�					*/
		upmu_code				VARCHAR2(3),			 /*	�����ڵ�					*/
		send_cont				VARCHAR2(1),			 /*	�۽�Ƚ��					*/
		docu_numc				VARCHAR2(6),			 /*	������ȣ					*/
		send_date				VARCHAR2(8),			 /*	��������					*/
		send_time				VARCHAR2(6),			 /*	���۽ð�					*/
		resp_code				VARCHAR2(4),			 /*	�����ڵ�					*/
		gaeb_area				VARCHAR2(200),		 /*	������ ����				*/
		resp_yebu				VARCHAR2(1));			 /*	���俩��					*/

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	�ǽð� �߹�ŷ	�������̺� RECORD								*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_VAN_RECV_RECORD	IS RECORD	(
		tran_code				VARCHAR2(9),			 /*	�ĺ��ڵ�					*/
		ente_code				VARCHAR2(8),			 /*	��ü�ڵ�					*/
		bank_code				VARCHAR2(2),			 /*	�����ڵ�					*/
		docu_code				VARCHAR2(4),			 /*	�����ڵ�					*/
		upmu_code				VARCHAR2(3),			 /*	�����ڵ�					*/
		send_cont				VARCHAR2(1),			 /*	�۽�Ƚ��					*/
		docu_numc				VARCHAR2(6),			 /*	������ȣ					*/
		send_date				VARCHAR2(8),			 /*	��������					*/
		send_time				VARCHAR2(6),			 /*	���۽ð�					*/
		resp_code				VARCHAR2(4),			 /*	�����ڵ�					*/
		gaeb_area				VARCHAR2(200),		 /*	������ ����				*/
		resp_yebu				VARCHAR2(1));			 /*	���俩��					*/

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	���ݰŷ�������(0200300)	������ ����											*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_REAL_DEPO_TR_RECORD	IS RECORD	(
		account_no				 VARCHAR2(15),	 /*	�Աݰ��¹�ȣ				*/
		trade_gb					 VARCHAR2(2),		 /*	�ŷ�����						*/
		bank_cd						 VARCHAR2(2),		 /*	�ŷ����������ڵ�		*/
		trade_amt					 VARCHAR2(13),	 /*	�ŷ��ݾ�						*/
		remain_amt				 VARCHAR2(13),	 /*	�ŷ� ��, �ܾ�				*/
		giro_cd						 VARCHAR2(6),		 /*	�����ڵ�						*/
		depo_nm						 VARCHAR2(16),	 /*	�Ա��� ����					*/
		check_no					 VARCHAR2(10),	 /*	���� ��	��ǥ��ȣ		*/
		cms								 VARCHAR2(16),	 /*	CMS�ڵ�(�ŷ�ó�ڵ�)	*/
		trade_dt					 VARCHAR2(8),		 /*	�ŷ�����						*/
		trade_time				 VARCHAR2(6),		 /*	�ŷ��ð�						*/
		cash_amt					 VARCHAR2(13),	 /*	����								*/
		check_amt					 VARCHAR2(13),	 /*	�����ǥ						*/
		ta_check_amt			 VARCHAR2(13),	 /*	��ȯ��,���Ⱑ�ɱݾ�	*/
		trade_no					 VARCHAR2(6),		 /*	�ŷ��� �Ϸù�ȣ	�߰�*/
		cancel_trade_no		 VARCHAR2(6),		 /*	��ҽ� �ηù�ȣ	�߰�*/
		cancel_trade_dt		 VARCHAR2(8),		 /*	��ҽ� �ŷ�����	�߰�*/
		remain_sign				 VARCHAR2(1),		 /*	�����(�ܾ׺�ȣ)		*/
		loan_yn						 VARCHAR2(1),		 /*	�����(���ܴ��⿩��)(����) */
		dong_ho						 VARCHAR2(8),		 /*	����(��ȣ)					*/
		dummy							 VARCHAR2(24));	 /*	DUMMY	SPACE	24��		*/

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	���ݰŷ�������䱸����(0200600)	������ ����				*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_REAL_DEPO_MISS_RECORD	IS RECORD	(
		account_no				 VARCHAR2(15),	 /*	�Աݰ��¹�ȣ				 */
		trade_gb				 VARCHAR2(2),		 /*	�ŷ�����					 */
		bank_cd					 VARCHAR2(2),		 /*	�ŷ����������ڵ�			 */
		trade_amt				 VARCHAR2(13),	 /*	�ŷ��ݾ�					 */
		remain_amt				 VARCHAR2(13),	 /*	�ŷ� ��, �ܾ�				 */
		giro_cd					 VARCHAR2(6),		 /*	�����ڵ�					 */
		depo_nm					 VARCHAR2(16),	 /*	�Ա��� ����					 */
		check_no				 VARCHAR2(10),	 /*	���� ��	��ǥ��ȣ			 */
		cms						 VARCHAR2(16),	 /*	CMS�ڵ�(�ŷ�ó�ڵ�)			 */
		trade_dt				 VARCHAR2(8),		 /*	�ŷ�����					 */
		trade_time				 VARCHAR2(6),		 /*	�ŷ��ð�					 */
		cash_amt				 VARCHAR2(13),	 /*	����						 */
		check_amt				 VARCHAR2(13),	 /*	�����ǥ					 */
		ta_check_amt			 VARCHAR2(13),	 /*	��ȯ��,	���Ⱑ�ɱݾ�		 */
		org_docu_numc			 VARCHAR2(6),		 /*	���ŷ�������ȣ �߰�			 */
		trade_no				 VARCHAR2(6),		 /*	�ŷ��� �Ϸù�ȣ	�߰�		 */
		cancel_trade_no			 VARCHAR2(6),		 /*	��ҽ� �ηù�ȣ	�߰�		 */
		cancel_trade_dt			 VARCHAR2(8),		 /*	��ҽ� �ŷ�����	�߰�		 */
		remain_sign				 VARCHAR2(1),		 /*	�����(�ܾ׺�ȣ)			 */
		loan_yn					 VARCHAR2(1),		 /*	�����(���ܴ��⿩��)		 */
		dong_ho					 VARCHAR2(8),		 /*	����(��ȣ)					 */
		dummy					 VARCHAR2(18));	 /*	DUMMY	SPACE	18��			 */

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	������ü(0100100)	/	Ÿ����ü(0100200)	������ ����			*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_REAL_TR_RECORD IS	RECORD (
		out_account_no			 VARCHAR2(15),	 /*	���ް���					 */
		account_pw				 VARCHAR2(8),		 /*	������(4)+��ü���(4)		 */
		sign_no					 VARCHAR2(6),		 /*	�����ȣ					 */
		trade_amt				 VARCHAR2(13),	 /*	��ݱݾ�					 */
		remain_sign				 VARCHAR2(1),		 /*	��� ��, �ܾ׺�ȣ			 */
		remain_amt				 VARCHAR2(13),	 /*	���� �ܾ�					 */
		in_bank_cd				 VARCHAR2(2),		 /*	�Ա������ڵ�				 */
		in_account_no			 VARCHAR2(15),	 /*	�Աݰ���					 */
		commission				 VARCHAR2(13),	 /*	��ü������					 */
		cms						 VARCHAR2(16),	 /*	CMS�ڵ�(�ŷ�ó�ڵ�)			 */
		depo_nm					 VARCHAR2(22),	 /*	�Ա��� ����(������)		 */
		remark					 VARCHAR2(14),	 /*	�Ա��� ��������(���)		 */
		dummy					 VARCHAR2(72));	 /*	DUMMY	SPACE	72��			 */

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	��üó�������ȸ(0600100,0600200)	������ ����				*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_REAL_TR_RE_RECORD	IS RECORD	(
		docu_numc				 VARCHAR2(6),		 /*	������ȣ					 */
		out_account_no			 VARCHAR2(15),	 /*	���ް��¹�ȣ				 */
		in_account_no			 VARCHAR2(15),	 /*	�Աݰ��¹�ȣ				 */
		trade_amt				 VARCHAR2(13),	 /*	�ݾ�						 */
		commission				 VARCHAR2(13),	 /*	������						 */
		sub_seq_no				 VARCHAR2(4),		 /*	SUB	SEQ	NO					 */
		trade_date				 VARCHAR2(8),		 /*	��ü����					 */
		trade_time				 VARCHAR2(6),		 /*	��ü�ð�					 */
		result_cd				 VARCHAR2(4),		 /*	ó�����					 */
		in_bank_cd				 VARCHAR2(2),		 /*	�Ա������ڵ�				 */
		dummy					 VARCHAR2(111));	 /*	DUMMY	SPOACE 111��			 */

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	�ܾ���ȸ(0600300)	������ ����								*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_REAL_REMAIN_RECORD IS	RECORD (
		account_no				 VARCHAR2(15),	 /*	���¹�ȣ					 */
		remain_sign				 VARCHAR2(1),		 /*	��ȣ						 */
		remain_amt				 VARCHAR2(13),	 /*	�����ܾ�					 */
		out_enable_amt			 VARCHAR2(13),	 /*	���ް��ɱݾ�				 */
		account_pw				 VARCHAR2(4),		 /*	��й�ȣ					 */
		dummy					 VARCHAR2(154));	 /*	DUMMY	SPACE	154��			 */

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	����ó��(0700100)	������ ����								*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_REAL_SUM_RECORD	IS RECORD	(
		da_account_no			 VARCHAR2(15),	 /*	���� ��ݰ��¹�ȣ			 */
		da_req_cnt				 VARCHAR2(5),		 /*	���� �Ƿ�	�� �Ǽ�			 */
		da_req_amt				 VARCHAR2(13),	 /*	���� �Ƿ�	�� �ݾ�			 */
		da_normal_cnt			 VARCHAR2(5),		 /*	���� ����	�Ǽ�				 */
		da_normal_amt			 VARCHAR2(13),	 /*	���� ����	�ݾ�				 */
		da_fail_cnt				 VARCHAR2(5),		 /*	���� �Ҵ�	�Ǽ�				 */
		da_fail_amt				 VARCHAR2(13),	 /*	���� �Ҵ�	�ݾ�				 */
		da_commission			 VARCHAR2(9),		 /*	���� ������						 */
		ta_req_cnt				 VARCHAR2(5),		 /*	Ÿ�� �Ƿ�	�� �Ǽ�			 */
		ta_req_amt				 VARCHAR2(13),	 /*	Ÿ�� �Ƿ�	�� �ݾ�			 */
		ta_normal_cnt			 VARCHAR2(5),		 /*	Ÿ�� ����	�Ǽ�				 */
		ta_normal_amt			 VARCHAR2(13),	 /*	Ÿ�� ����	�ݾ�				 */
		ta_fail_cnt				 VARCHAR2(5),		 /*	Ÿ�� �Ҵ�	�Ǽ�				 */
		ta_fail_amt				 VARCHAR2(13),	 /*	Ÿ�� �Ҵ�	�ݾ�				 */
		ta_commission			 VARCHAR2(9),		 /*	Ÿ�� ������						 */
		dummy							 VARCHAR2(59));	 /*	DUMMY	SPACE	59��			 */


	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	�������(0200100)	/	������°��(2000200)	������ ����		*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_REAL_VIRTUAL_RECORD	IS RECORD	(
		account_no				 VARCHAR2(15),	 /*	�Աݰ��¹�ȣ				 */
		trade_gb				 VARCHAR2(2),		 /*	�ŷ�����					 */
		bank_cd					 VARCHAR2(2),		 /*	�ŷ����������ڵ�			 */
		trade_amt				 VARCHAR2(13),	 /*	�ŷ��ݾ�					 */
		remain_amt				 VARCHAR2(13),	 /*	�ŷ� ��, �ܾ�				 */
		giro_cd					 VARCHAR2(6),		 /*	�����ڵ�					 */
		depo_nm					 VARCHAR2(16),	 /*	�Ա��� ����					 */
		check_no				 VARCHAR2(10),	 /*	���� ��	��ǥ��ȣ			 */
		cms						 VARCHAR2(16),	 /*	CMS�ڵ�(�ŷ�ó�ڵ�)			 */
		trade_dt				 VARCHAR2(8),		 /*	�ŷ�����					 */
		trade_time				 VARCHAR2(6),		 /*	�ŷ��ð�					 */
		cash_amt				 VARCHAR2(13),	 /*	����						 */
		check_amt				 VARCHAR2(13),	 /*	�����ǥ					 */
		ta_check_amt			 VARCHAR2(13),	 /*	Ÿ����						 */
		trade_no				 VARCHAR2(6),		 /*	�ŷ��� �Ϸù�ȣ	�߰�		 */
		cancel_trade_no			 VARCHAR2(6),		 /*	��ҽ� �ηù�ȣ	�߰�		 */
		cancel_trade_dt			 VARCHAR2(8),		 /*	��ҽ� �ŷ�����	�߰�		 */
		remain_sign				 VARCHAR2(1),		 /*	�ܾ׺�ȣ					 */
		jumin_no				 VARCHAR2(13),	 /*	�ֹι�ȣ					 */
		loan_yn					 VARCHAR2(1),		 /*	�����(���ܴ��⿩��)		 */
		dummy					 VARCHAR2(19));	 /*	DUMMY	SPACE	19��			 */

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	�����μ�����ȸ(0400400/0410400)	������ ����					*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_NAME_CHECK_RECORD	IS RECORD	(
		bank_code				 VARCHAR2(2),		 /*	�����ڵ�					 */
		account_num			 VARCHAR2(15),	 /*	���¹�ȣ					 */
		ssn							 VARCHAR2(14),	 /*	�ֹι�ȣ					 */
		account_name		 VARCHAR2(14),	 /*	�����ָ�					 */
		dummy						 VARCHAR2(155)); /*	DUMMY	SPACE	155��	 */

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	�����ŷ���(0200400/0210400)	������ ����					*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_BILL_TRX_RECORD	IS RECORD	(
		trade_gb				 VARCHAR2(2),		 /*	�ŷ�����					 */
		account_no				 VARCHAR2(15),	 /*	���¹�ȣ					 */
		trade_dt				 VARCHAR2(8),		 /*	�ŷ�����					 */
		trade_time				 VARCHAR2(6),		 /*	�ŷ��ð�					 */
		bill_no					 VARCHAR2(10),	 /*	������ȣ					 */
		trade_amt				 VARCHAR2(13),	 /*	�ݾ�						 */
		issue_name				 VARCHAR2(14),	 /*	������						 */
		pay_due_dt				 VARCHAR2(8),		 /*	������						 */
		pay_bank_cd				 VARCHAR2(16),	 /*	����� ��������				 */
		cms						 VARCHAR2(16),	 /*	CMS�ڵ�						 */
		item_change_cd			 VARCHAR2(3),		 /*	�׸񺯰��ڵ�				 */
		remain_amt				 VARCHAR2(13),	 /*	�ܾ�						 */
		giro_cd					 VARCHAR2(6),		 /*	�����ڵ�					 */
		org_docu_numc			 VARCHAR2(6),		 /*	���ŷ�������ȣ				 */
		trade_no				 VARCHAR2(6),		 /*	�ŷ��Ϸù�ȣ				 */
		cancel_trade_no			 VARCHAR2(6),		 /*	��ҽ� �ηù�ȣ	�߰�		 */
		cancel_trade_dt			 VARCHAR2(8),		 /*	��ҽ� �ŷ�����	�߰�		 */
		dummy					 VARCHAR2(44));	 /*	DUMMY	SPACE	44��			 */

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	�����ŷ�������䱸(0200500/0210500)	������ ����			*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_BILL_MISS_RECORD IS	RECORD (
		trade_gb				 VARCHAR2(2),		 /*	�ŷ�����					 */
		account_no				 VARCHAR2(15),	 /*	���¹�ȣ					 */
		trade_dt				 VARCHAR2(8),		 /*	�ŷ�����					 */
		trade_time				 VARCHAR2(6),		 /*	�ŷ��ð�					 */
		bill_no					 VARCHAR2(10),	 /*	������ȣ					 */
		trade_amt				 VARCHAR2(13),	 /*	�ݾ�						 */
		issue_name				 VARCHAR2(14),	 /*	������						 */
		future_pay_due_dt		 VARCHAR2(8),		 /*	������						 */
		future_pay_bank_cd		 VARCHAR2(16),	 /*	����� ��������				 */
		cms						 VARCHAR2(16),	 /*	CMS�ڵ�						 */
		item_change_cd			 VARCHAR2(3),		 /*	�׸񺯰��ڵ�				 */
		remain_amt				 VARCHAR2(13),	 /*	�ܾ�						 */
		giro_cd					 VARCHAR2(6),		 /*	�����ڵ�					 */
		org_docu_numc			 VARCHAR2(6),		 /*	���ŷ�������ȣ				 */
		trade_no				 VARCHAR2(6),		 /*	�ŷ��Ϸù�ȣ				 */
		cancel_trade_no			 VARCHAR2(6),		 /*	��ҽ� �ηù�ȣ	�߰�		 */
		cancel_trade_dt			 VARCHAR2(8),		 /*	��ҽ� �ŷ�����	�߰�		 */
		dummy					 VARCHAR2(44));	 /*	DUMMY	SPACE	44��			 */

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	���������ڷ�(0100310/0110310)	������ ����					*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_BILL_ISSUE_RECORD	IS RECORD	(
		transfer_dt				 VARCHAR2(8),		 /*	��������					 */
		transfer_gb				 VARCHAR2(2),		 /*	���۱���					 */
		pay_confirm_gb			 VARCHAR2(1),		 /*	��������					 */
		biz_no					 VARCHAR2(10),	 /*	����ڹ�ȣ					 */
		docu_no					 VARCHAR2(14),	 /*	������ȣ					 */
		trade_gb				 VARCHAR2(2),		 /*	�ŷ�����					 */
		future_pay_due_dt		 VARCHAR2(8),		 /*	��������					 */
		bank_cd					 VARCHAR2(2),		 /*	�����ڵ�					 */
		account_no				 VARCHAR2(15),	 /*	���¹�ȣ					 */
		pay_amt					 VARCHAR2(13),	 /*	ó���ݾ�					 */
		bank_client_no			 VARCHAR2(10),	 /*	�������ȣ				 */
		vendor_name				 VARCHAR2(20),	 /*	��������					 */
		result_gb				 VARCHAR2(2),		 /*	�������					 */
		company_etc				 VARCHAR2(20),	 /*	ȸ����������				 */
		dummy					 VARCHAR2(72));	 /*	DUMMY	SPACE	72��			 */

	/*----------------------------------------------------------------------------*/
	/*	 REC	 NAME		:	�ŷ�ó����(0100320/0110320)	������ ����						*/
	/*----------------------------------------------------------------------------*/
	TYPE FB_VENDOR_RECORD	IS RECORD	(
		transfer_dt				 VARCHAR2(8),		 /*	��������					 */
		transfer_gb				 VARCHAR2(2),		 /*	���۱���					 */
		bank_client_no			 VARCHAR2(10),	 /*	�������ȣ				 */
		gb						 VARCHAR2(2),		 /*	����						 */
		current_biz_no			 VARCHAR2(10),	 /*	�� �����	��ȣ				 */
		previous_biz_no			 VARCHAR2(10),	 /*	�� �����	��ȣ				 */
		president_name			 VARCHAR2(10),	 /*	��ǥ�ڸ�					 */
		biz_name				 VARCHAR2(40),	 /*	���θ�						 */
		address					 VARCHAR2(59),	 /*	�ּ�						 */
		dummy					 VARCHAR2(50));	 /*	DUMMY	SPACE	50��			 */

	Type		T_Nums	Is	Table	Of Number
		Index By Binary_Integer;
	Type		T_Vars	Is	Table	Of Varchar2(4000)
		Index By Binary_Integer;

	/******************************************************************************/
	/*	��� : ���Ͼ�ħ	�������ð��� ��ϵ�	���ະ�� ����������	�۽��մϴ�.			*/
	/******************************************************************************/
	FUNCTION send_start_document(	p_comp_code		IN VARCHAR2	,			-- �����	�ڵ�
									p_bank_code		IN VARCHAR2	,			-- �����ڵ�
									p_resp_code		OUT	VARCHAR2,			-- �����ڵ�
									p_resp_msg		OUT	VARCHAR2 )		-- �����ڵ��
		RETURN VARCHAR2;												-- �Լ�	ó����� �޽���


	/******************************************************************************/
	/*	��� : ���Ͼ�ħ	�������ð��� FBS�ý��ۿ� ����	�������˸����� �߼�			*/
	/******************************************************************************/
	FUNCTION send_fbs_status_mail( p_recv_list	IN VARCHAR2	DEFAULT	NULL )	 --	�߰����� ���ϼ�����
		RETURN VARCHAR2;													 --	�Լ� ó�����	�޽���


	/******************************************************************************/
	/*	��� : ��üó�������û	ó�����											*/
	/******************************************************************************/
	PROCEDURE	retieve_pay_summation( p_bank_code		 IN	VARCHAR2 ,		 --	�����ڵ�
									 p_acct_number		 IN	VARCHAR2 ,		 --	���¹�ȣ
									 p_da_req_cnt		 OUT NUMBER	,			 --	���� ��û	�Ǽ�
									 p_da_req_amt		 OUT NUMBER	,			 --	���� ��û	�ݾ�
									 p_da_success_cnt	 OUT NUMBER	,			 --	���� ����ó��	�Ǽ�
									 p_da_success_amt	 OUT NUMBER	,			 --	���� ����ó��	�ݾ�
									 p_da_commission	 OUT NUMBER	,			 --	���� ������
									 p_ta_req_cnt		 OUT NUMBER	,			 --	Ÿ�� ��û	�Ǽ�
									 p_ta_req_amt		 OUT NUMBER	,			 --	Ÿ�� ��û	�ݾ�
									 p_ta_success_cnt	 OUT NUMBER	,			 --	Ÿ�� ����ó��	�Ǽ�
									 p_ta_success_amt	 OUT NUMBER	,			 --	Ÿ�� ����ó��	�ݾ�
									 p_ta_commission	 OUT NUMBER	,			 --	Ÿ�� ������
									 p_resp_code		 OUT VARCHAR2,		 --	�����ڵ�
									 p_resp_msg			 OUT VARCHAR2	)	;		 --	�����ڵ��


	/******************************************************************************/
	/*	��� : 1�� ���¿�	���� �ܾ���ȸ												*/
	/******************************************************************************/
	FUNCTION retieve_acct_remains( p_bank_code		 IN	VARCHAR2 ,		 --	�����ڵ�
									 p_acct_number	 IN	VARCHAR2 ,		 --	���¹�ȣ
									 p_remain_amt		 OUT NUMBER	 ,		 --	�����ܾ�
									 p_enable_amt		 OUT NUMBER	 ,		 --	��ݰ��ɾ�
									 p_resp_code		 OUT VARCHAR2,		 --	�����ڵ�
									 p_resp_msg		 OUT VARCHAR2	)		 --	�����ڵ��
		RETURN VARCHAR2;												 --	�Լ� ó�����	�޽���


	/******************************************************************************/
	/*	��� : ������ü	����� ȹ��	�� ���ó��	����								*/
	/******************************************************************************/
	FUNCTION cash_pay_window_check(	p_pay_seq		IN NUMBER	,			 --	�����Ϸù�ȣ
									p_job_gubun		IN VARCHAR2	,			 --	ó������ [ CHECK:Ȯ��	,	CANCEL:Ȯ�����	]
									p_emp_no		IN VARCHAR2	)			 --	���
		RETURN VARCHAR2;												 --	�Լ� ó�����	�޽���


	/******************************************************************************/
	/*	��� : ������ü����	����													*/
	/******************************************************************************/
	FUNCTION create_cash_edi_file( p_comp_code			 IN	VARCHAR2 ,		-- ������ڵ�
									 p_bank_code			 IN	VARCHAR2 ,		-- �����ڵ�
									 p_row_cnt			 IN	NUMBER ,			-- ó����	���� ����	(üũ��)
									 p_emp_no				 IN	VARCHAR2 ,		-- ���
									 p_edi_history_seq	 OUT NUMBER	)			-- EDI����_�ۼ���HISTORY�Ϸù�ȣ (������ ���, NULL)
		RETURN VARCHAR2;													-- �Լ�	ó����� �޽���


	/******************************************************************************/
	/*	��� : ���ھ�������	����													*/
	/******************************************************************************/
	FUNCTION create_bill_edi_file(	p_comp_code			IN VARCHAR2	,		 --	������ڵ�
									p_bank_code			IN VARCHAR2	,		 --	�����ڵ�
									p_row_cnt			IN NUMBER	,			 --	ó���� ����	���� (üũ��)
									p_emp_no			IN VARCHAR2	,		 --	���
									p_edi_history_seq	OUT	NUMBER )		 --	EDI����_�ۼ���HISTORY�Ϸù�ȣ	(������	���,	NULL)
		RETURN VARCHAR2;													 --	�Լ� ó�����	�޽���


	/******************************************************************************/
	/*	��� : ���ҰǺ�	������ü ����												*/
	/******************************************************************************/
	FUNCTION send_cash_each_transfer(	p_pay_seq			IN NUMBER	,			 --	�����Ϸù�ȣ
										p_div_seq			IN NUMBER	,			 --	�����Ϸù�ȣ
										p_emp_no			IN VARCHAR2	,		 --	���
										p_resp_code		OUT	VARCHAR2,		 --	�����ڵ�
										p_resp_msg		OUT	VARCHAR2 )		 --	�����ڵ��
		RETURN VARCHAR2;													 --	�Լ� ó�����	�޽���


	/******************************************************************************/
	/*	��� : ���ްǺ�	������ü ����												*/
	/******************************************************************************/
	FUNCTION send_cash_transfer( p_pay_seq			 IN	NUMBER ,			-- �����Ϸù�ȣ
								 p_emp_no			 IN	VARCHAR2 )		-- ���
		RETURN VARCHAR2;												-- �Լ�	ó����� �޽���


	/******************************************************************************/
	/*	��� : ���ްǺ�	���ھ��� realtime	�۽�										*/
	/******************************************************************************/
	FUNCTION send_bill_transfer( p_pay_seq			 IN	NUMBER ,			-- �����Ϸù�ȣ
								 p_emp_no			 IN	VARCHAR2 )		-- ���
		RETURN VARCHAR2;												-- �Լ�	ó����� �޽���

	/******************************************************************************/
	/*	��� : �����ָ�	��ȸ														*/
	/******************************************************************************/
	FUNCTION retieve_acct_holder_name( p_bank_code		 IN	VARCHAR2 ,		 --	�����ڵ�
										 p_acct_number	 IN	VARCHAR2 ,		 --	���¹�ȣ
										 p_holder_name	 OUT VARCHAR2	,		 --	�����ָ�
										 p_resp_code		 OUT VARCHAR2,		 --	�����ڵ�
										 p_resp_msg		 OUT VARCHAR2	)		 --	�����ڵ��
		RETURN VARCHAR2;													 --	�Լ� ó�����	�޽���


	/******************************************************************************/
	/*	��� : ���ھ���	�ŷ������� ����	ó��										*/
	/******************************************************************************/
	FUNCTION read_bill_vendor_info(	p_edi_history_seq	 IN	NUMBER )				-- EDI�ۼ����̷� �Ϸù�ȣ
		RETURN VARCHAR2;														-- �Լ�	ó����� �޽���


	/******************************************************************************/
	/*	��� : ���ھ���	ó����� ����	ó��										 */
	/******************************************************************************/
	FUNCTION read_bill_result	(	p_edi_history_seq	IN NUMBER	,					-- EDI�ۼ����̷� �Ϸù�ȣ
								p_emp_no			IN VARCHAR2	)				-- ���
		RETURN VARCHAR2;														-- �Լ�	ó����� �޽���


	/******************************************************************************/
	/*	��� : ������ü����	ó����� ����	ó��										*/
	/******************************************************************************/
	FUNCTION read_cash_result	(	p_edi_history_seq	IN NUMBER	,					-- EDI�ۼ����̷� �Ϸù�ȣ
								p_emp_no			IN VARCHAR2	)				-- ���
		RETURN VARCHAR2;														-- �Լ�	ó����� �޽���

	/******************************************************************************/
	/*	��� : �����ֱ⺰��	����Ǵ� job�� ����	�Ѱ� ȣ��	�Լ�						*/
	/******************************************************************************/
	PROCEDURE	do_job_task;


	/******************************************************************************/
	/*	��� : Ÿ����ü�Ҵ�	�������� �߼�											*/
	/******************************************************************************/
	FUNCTION send_tran_fail_mail(	p_comp_code			IN VARCHAR2	,			 --	������ڵ�
									p_bank_code			IN VARCHAR2	,			 --	�����ڵ�
									p_docu_numc			IN VARCHAR2	)			 --	������ȣ
		RETURN VARCHAR2;													 --	�Լ� ó�����	�޽���


	/******************************************************************************/
	/*	��� : ���޿���	���ϵ���Ÿ ����												*/
	/******************************************************************************/
	FUNCTION create_paydue_mail_data(	p_comp_code			IN VARCHAR2	,			 --	������ڵ�
										p_pay_ymd				IN VARCHAR2	,			 --	���޿�������
										p_vendor_seq			IN NUMBER	)			 --	�ŷ�ó�Ϸù�ȣ
		RETURN VARCHAR2;														 --	�Լ� ó�����	�޽���


	/******************************************************************************/
	/*	��� : ���޿���	���� �߼�													*/
	/******************************************************************************/
	FUNCTION send_paydue_mail( p_mail_seq			IN NUMBER	,					 --	�����Ϸù�ȣ
								 p_emp_no				IN VARCHAR2	)					 --	���
		RETURN VARCHAR2;														 --	�Լ� ó�����	�޽���


	/******************************************************************************/
	/*	��� : ������ü	��ǥ����/��ü����Ÿ	����									*/
	/******************************************************************************/
	FUNCTION create_transfer_slip_data(	p_transfer_seq	 IN	NUMBER ,			-- ������ü�Ϸù�ȣ
										p_emp_no		 IN	VARCHAR2 )			-- ���
		RETURN VARCHAR2;														-- �Լ�	ó����� �޽���


	/******************************************************************************/
	/*	��� : �λ����޵���Ÿ	����													*/
	/******************************************************************************/
	FUNCTION extract_hr_pay_data(	p_comp_code			IN VARCHAR2	,			 --	������ڵ�
									p_pay_ym				IN VARCHAR2	,			 --	���޿��� ���
									p_gubun				IN VARCHAR2	,			 --	����
									p_emp_no				IN VARCHAR2	,			 --	���
									p_extract_cnt			OUT	NUMBER	,			 --	�� ����	�Ǽ�
									p_extract_amt			OUT	NUMBER	)			 --	�� ����	�ݾ�
		RETURN VARCHAR2;													 --	�Լ� ó�����	�޽���


	/******************************************************************************/
	/*	��� : ȸ��ý��ۿ���	��ü��Ͻ� ���ھ����ŷ�ó��	��ϵ� ��ü����	Ȯ��		*/
	/******************************************************************************/
	FUNCTION check_bill_vendor(	p_comp_code			IN VARCHAR2	,		 --	������ڵ�
								p_bank_code			IN VARCHAR2	,		 --	�����ڵ�
								p_bizno				IN VARCHAR2	)		 --	����ڹ�ȣ
		RETURN VARCHAR2;												 --	�Լ� ó�����	�޽���



	/******************************************************************************/
	/*	��� : RealTimeó����, VAN�۽�Table��	�ְ�,�����ð�����	���Ŵ��ó��		*/
	/******************************************************************************/
	FUNCTION send_realtime_document( p_rec_send			 IN	FB_VAN_SEND_RECORD ,	 --	�۽�RECORD
									 p_timeout			 IN	NUMBER ,				 --	�ִ���ð�
									 p_rec_recv			 OUT FB_VAN_RECV_RECORD	,	 --	����RECORD
									 p_result_code		 OUT VARCHAR2	 ,			 --	ó������ڵ�
									 p_result_msg		 OUT VARCHAR2	 )			 --	ó������޽���
		RETURN VARCHAR2;															 --	�Լ� ó�����	�޽���

	/******************************************************************************/
	/*	��� : Van ����	Ʈ���� ó��													*/
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
	/*	��� : �����ڵ�	����													*/
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
	/*	��� : �����ڵ�	����													*/
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
	/*	��� : RealTime�ڷ�	�⺻ ����												*/
	/******************************************************************************/
	PROCEDURE	init_van_send_record
	(
		p_bank_main_code			Varchar2,
		p_acct_number				VARCHAR2 ,		 --	���¹�ȣ
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
			Raise_Application_Error(-20009,'����ŷ������� �����Ǿ�	���� �ʽ��ϴ�.');
		End;
		p_rec_send.bank_code :=	p_bank_main_code;
		p_rec_send.send_date :=	To_Char(SysDate,'YYYYMMDD');
		p_rec_send.send_time :=	To_Char(SysDate,'HH24MISS');
		p_rec_send.send_cont :=	'1';
		-- �����ڵ�	�� �����ڵ�	����
		p_rec_send.docu_code :=	Get_Docu_Code(p_docu_upmu);
		p_rec_send.upmu_code :=	Get_Upmu_Code(p_docu_upmu);
		--���� ��ȣ	ä��
		p_rec_send.docu_numc :=	F_T_Gen_docu_numc(p_rec_send.bank_code,p_rec_send.docu_code,p_rec_send.upmu_code,p_rec_send.send_date);
	End;

	/******************************************************************************/
	/*	��� : ����	�߶��ֱ�													 */
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
	/*	��� : �ǽð�	���� �����ڵ��	���� ã��										*/
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
		Return '�� ��	���� ����';
	End;

	/******************************************************************************/
	/*	��� : SO-SI�����ϰ� KSC-5601��	��ȯ										*/
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
	/*	1. ���ID		 : send_start_document																	 */
	/*	2. ����̸�	 : ���Ͼ�ħ	�������� ����������	�۽��մϴ�.							 */
	/*	3. �ý���		 : ȸ��ý���																						 */
	/*	4. ����ý���: FBS																									 */
	/*	5. �������	 :																											 */
	/*	6. �����	 : PL/SQL																								 */
	/*	7. ���ȯ��	 : Windows2003 Server+ Oracle	9.2.0											 */
	/*	8. ���DBMS	 : Oracle																								 */
	/*	9. �����	���� ��	�ֿ���																					 */
	/*																																			 */
	/*		-	���� �������ð�(����8:30)��	FBS�������°�	�輳�� �����������		 */
	/*			���������� �ڵ�����	�߼��մϴ�.																	 */
	/*			�� �Լ���	�����/������	�Է¹޾Ƽ�,	��������1����	�����ϴ�			 */
	/*			����� �����ϸ�, �����/����LIST�� SELECT��	��ȸ��,	�� �Լ���		 */
	/*			���� ȣ���Ͽ�	ó���Ѵ�.	(���Ͼ�ħ	���� ��)											 */
	/*																																			 */
	/*		-	��ȯ��																													 */
	/*			OK : ���󰳽�	��																								 */
	/*			�����޽��� : ��Ÿ	���� �߻���	(DEFAULT��:ERROR)									 */
	/*																																			 */
	/* 10. �����ۼ���: LG	CNS	����ö																				 */
	/* 11. �����ۼ���: 2005��12��21��																				 */
	/* 12. ����������:																											 */
	/* 13. ����������:																											 */
	/*************************************************************************/
	FUNCTION send_start_document(	p_comp_code		IN VARCHAR2	,			-- �����	�ڵ�
																p_bank_code		IN VARCHAR2	,			-- �����ڵ�
																p_resp_code		OUT	VARCHAR2,			-- �����ڵ�
																p_resp_msg		OUT	VARCHAR2 )		-- �����ڵ��
		RETURN VARCHAR2	IS																-- �Լ�	ó����� �޽���

	BEGIN
		-- >>>>>>>>>>>>>	 ó������		 <<<<<<<<<<<<<<<<<<


		RETURN(	NULL );

	END	send_start_document;


	/*************************************************************************/
	/*																		 */
	/*	1. ���ID	 : send_fbs_status_mail									 */
	/*	2. ����̸�	 : �����������ð���	FBS�ý��ۿ�	���� �������˸�����	�߼� */
	/*	3. �ý���	 : ȸ��ý���											 */
	/*	4. ����ý���: FBS													 */
	/*	5. �������	 :														 */
	/*	6. �����	 : PL/SQL												 */
	/*	7. ���ȯ��	 : Windows2003 Server+ Oracle	9.2.0						 */
	/*	8. ���DBMS	 : Oracle												 */
	/*	9. �����	���� ��	�ֿ���											 */
	/*																		 */
	/*		-	���� �������ð�(����9:00)��	FBS�ý��ۿ�	���� ���¸�	�����Ͽ�	 */
	/*			�� ��ϵ�	������ ��	�߰������� PARAMETER�� �Էµ�	�ο�����	 */
	/*			FBS�ý��ۻ��¸�	���� ������	�߼��մϴ�.						 */
	/*			�����ڴ� T_FB_LOOKUP_VALUES��	LOOKUP_TYPE��	"FBS_RECEIVE_EMP"	 */
	/*			�� ��ϵ�	�ο����� �߼��Ѵ�.									 */
	/*																		 */
	/*		-	üũ�ϴ� ������	�Ʒ��� ����									 */
	/*			 (1) ����PROGRAM�� VALID���� Ȯ��								 */
	/*			 (2) ����PROCESS�� �⵿����	Ȯ��								 */
	/*			 (3) JOB���࿩�� Ȯ��											 */
	/*			 (4) ���ະ	���ÿ��� Ȯ��										 */
	/*			 (5) ���ŵ�	���ھ��� �����ŷ���	����							 */
	/*																		 */
	/*		-	��ȯ��														 */
	/*			OK : ����	���Ϲ߼� ��										 */
	/*			�����޽��� : ��Ÿ	���� �߻���	(DEFAULT��:ERROR)				 */
	/*																		 */
	/* 10. �����ۼ���: LG	CNS	����ö										 */
	/* 11. �����ۼ���: 2005��12��21��										 */
	/* 12. ����������:														 */
	/* 13. ����������:														 */
	/*************************************************************************/
	FUNCTION send_fbs_status_mail( p_recv_list	IN VARCHAR2	DEFAULT	NULL )	 --	�߰����� ���ϼ�����	(DEFAULT�� NULL)
		RETURN VARCHAR2	IS
	BEGIN


		-- >>>>>>>>>>>>>	 ó������		 <<<<<<<<<<<<<<<<<<


		RETURN(	NULL );

	END	send_fbs_status_mail;


	/*************************************************************************/
	/*																		                                   */
	/*	1. ���ID	 : retieve_acct_remains									                   */
	/*	2. ����̸�	 : 1�� ���¿�	���� �ܾ���ȸ								               */
	/*	3. �ý���	 : ȸ��ý���											                         */
	/*	4. ����ý���: FBS													                         */
	/*	5. �������	 :														                           */
	/*	6. �����	 : PL/SQL												                         */
	/*	7. ���ȯ��	 : Windows2003 Server+ Oracle	9.2.0						           */
	/*	8. ���DBMS	 : Oracle												                         */
	/*	9. �����	���� ��	�ֿ���											                     */
	/*																		                                   */
	/*		-	�Էµ� �����ڵ�	�� ���¹�ȣ��	���� �ܾ���	VAN���	�ܾ���ȸ����   */
	/*			�� �ۼ����Ͽ�, ���ؿɴϴ�.									                     */
	/*			���������� ó����	���,	RESP_CODE��	"0000"���� ��ȯ��	��츸	   */
	/*			���������� ��ȸ��	�����.										                     */
	/*																		                                   */
	/*		-	�ܾ׵���Ÿ�� ���Ͽ�	"�����ܾ׵���Ÿ(T_FB_ACCT_REMAIN_DATA)"��	   */
	/*			������ INSERT	Ȥ�� UPDATE�����մϴ�							                 */
	/*																		                                   */
	/*		-	��ȯ��														                               */
	/*			OK : ����	ó�� ��											                           */
	/*			�����޽��� : ��Ÿ	���� �߻���	(DEFAULT��:ERROR)				           */
	/*																		                                   */
	/* 10. �����ۼ���: LG	CNS	����ö										                     */
	/* 11. �����ۼ���: 2005��12��21��										                     */
	/* 12. ����������:														                           */
	/* 13. ����������:														                           */
	/*************************************************************************/
	FUNCTION retieve_acct_remains( p_bank_code		 IN	VARCHAR2 ,		 --	�����ڵ�
									 p_acct_number	 IN	VARCHAR2 ,		 --	���¹�ȣ
									 p_remain_amt		 OUT NUMBER	 ,		 --	�����ܾ�
									 p_enable_amt		 OUT NUMBER	 ,		 --	��ݰ��ɾ�
									 p_resp_code		 OUT VARCHAR2,		 --	�����ڵ�
									 p_resp_msg		 OUT VARCHAR2	)		 --	�����ڵ��
		RETURN VARCHAR2	IS												 --	�Լ� ó�����	�޽���
	BEGIN
		-- >>>>>>>>>>>>>	 ó������		 <<<<<<<<<<<<<<<<<<
		sp_retrive_acct_remains( p_bank_code	    ,	   -- �����ڵ�
													   p_acct_number	  ,	   -- ���¹�ȣ
													   p_remain_amt	    ,	   -- �ܾ�		
													   p_enable_amt     ,    -- �����ڱ�
													   p_resp_code	    ,    -- �����ڵ�
													   p_resp_msg		   );    -- �����ڵ��

		RETURN(	NULL );

	END	retieve_acct_remains;


	/*************************************************************************/
	/*																																			 */
	/*	1. ���ID	 : cash_pay_window_check																	 */
	/*	2. ����̸�	 : ������ü	����� ȹ��	�� ���ó��	����								 */
	/*	3. �ý���	 : ȸ��ý���																							 */
	/*	4. ����ý���: FBS																									 */
	/*	5. �������	 :																											 */
	/*	6. �����	 : PL/SQL																								 */
	/*	7. ���ȯ��	 : Windows2003 Server+ Oracle	9.2.0											 */
	/*	8. ���DBMS	 : Oracle																								 */
	/*	9. �����	���� ��	�ֿ���																					 */
	/*																																			 */
	/*		-	������ü�� �����	Ȯ��/Ȯ����ҿ�	���Ͽ� ������	ó����ƾ				 */
	/*			Ȯ������,	Ȯ�����ó�������� GUBUN�ڵ�� �����Ѵ�.							 */
	/*																																			 */
	/*			(1)	Ȯ��ó�� ��																									 */
	/*			:	T_FB_CASH_PAY_DATA�� ���	�ش� ����RECORD��	���Ͽ� Ÿ��				 */
	/*				��ü���θ� Ȯ���Ͽ�, T_FB_LOOKUP_VALUES���̺���	���ະ				 */
	/*				��ü�ѵ��ݾ��� Ȯ���Ͽ�, T_FB_CASH_PAY_DIVIDED_DATA��					 */
	/*				�������ްǿ� ���Ͽ�	RECORD�� ������Ų��.											 */
	/*				��ü�ѵ��� �Ȱɸ���	���� 1���� ��������RECORD������						 */
	/*				������Ų ��, PAY_STATUS��	����� Ȯ�λ��·�	UPDATE�Ѵ�.				 */
	/*																																			 */
	/*			(2)	Ȯ����� ó��	��																						 */
	/*			:	�� Ȯ��	�� ���̾����Ƿ�, �����������̺�	������ RECORD��			 */
	/*				DELETE�ϰ�,	PAY_STATUS�� �����	��Ȯ�� ���·�	�����Ų��.			 */
	/*																																			 */
	/*		-	�����Ȯ��/Ȯ�����ó����	�������/���޿Ϸ�/����/��ǥ���	�ø�	 */
	/*			 ������	���¿����� ó����	������																 */
	/*																																			 */
	/*		-	���޵���Ÿ�� ��ó��	"������ü"�� ����	Ȯ��/Ȯ����ҿ�	����	 */
	/*			STATUS�� ��������ش�. T_FB_CASH_TRANSFER_DATA��								 */
	/*			FUND_TRANSFER_STATUS�� Ȯ�νô�	'1'��	�����ϸ�,	��ҽô� '0'��	 */
	/*			���� UPDATE�Ѵ�.																								 */
	/*																																			 */
	/*		-	��ȯ��																													 */
	/*			OK : ����	ó�� ��																								 */
	/*			�����޽��� : ��Ÿ	���� �߻���	(DEFAULT��:ERROR)									 */
	/*																																			 */
	/* 10. �����ۼ���: LG	CNS	����ö																				 */
	/* 11. �����ۼ���: 2005��12��21��																				 */
	/* 12. ����������:																											 */
	/* 13. ����������:																											 */
	/*************************************************************************/
	FUNCTION cash_pay_window_check(	p_pay_seq		IN NUMBER	,			 --	�����Ϸù�ȣ
																	p_job_gubun	IN VARCHAR2	,		 --	ó������ [ CHECK:Ȯ��	,	CANCEL:Ȯ�����	]
																	p_emp_no		IN VARCHAR2	)		 --	���
		RETURN VARCHAR2	IS												 --	�Լ� ó�����	�޽���
	BEGIN
		-- >>>>>>>>>>>>>	 ó������		 <<<<<<<<<<<<<<<<<<
		SP_CASH_PAY_WINDOW_CHECK
		(
			p_pay_seq			,				 --	�����Ϸù�ȣ
			p_job_gubun		,				 --	ó������ [ CHECK:Ȯ��	,	CANCEL:Ȯ�����	]
			p_emp_no							 --	���																			 
		);

		RETURN(	NULL );

	END	cash_pay_window_check;


	/*************************************************************************/
	/*																																			 */
	/*	1. ���ID	 : create_cash_edi_file																		 */
	/*	2. ����̸�	 : ������ü����	����																		 */
	/*	3. �ý���	 : ȸ��ý���																							 */
	/*	4. ����ý���: FBS																									 */
	/*	5. �������	 :																											 */
	/*	6. �����	 : PL/SQL																								 */
	/*	7. ���ȯ��	 : Windows2003 Server+ Oracle	9.2.0											 */
	/*	8. ���DBMS	 : Oracle																								 */
	/*	9. �����	���� ��	�ֿ���																					 */
	/*																																			 */
	/*		-	������ ȭ��ܿ���	UPDATE�Ͽ��ִ� EDI_CREATE_REQ_YN �÷���	'Y'		 */
	/*			�� ����	������� EDI������ �����մϴ�.													 */
	/*																																			 */
	/*		-	������ü������ �����ϸ�, ���ະ/����庰�� �����ȴ�.						 */
	/*			���������� ������	���,	RETURN���� OK��	��ȯ�Ǹ�,	������ �ۼ�		 */
	/*			���̷����̺�(T_FB_EDI_HISTORY)�� Ű(SEQ)�� ��ȯ�ȴ�.						 */
	/*			������ ��	���� NULL����	��ȯ�ȴ�.															 */
	/*																																			 */
	/*		-	��ü������ ������	��Ģ�� �ǰ�	������ �ϴ�	function�� ȣ���Ͽ�		 */
	/*			���ϰ��/���ϸ���	���ؼ� ������Ų��.														 */
	/*																																			 */
	/*		-	���ϸ� ����Ģ��	������ ����	��																 */
	/*			 CS_������ڵ�(2)_�����ڵ�(2)_��¥(8)_�Ϸù�ȣ(3).dat						 */
	/*																																			 */
	/*		-	���ü� üũ��	���ؼ� ȭ���������	ȣ���,	������ ����	������		 */
	/*			�� �Լ���	parameter��	�Է��Ͽ�,	���� ó���Ϸ����	���� ������		 */
	/*			�񱳸� �Ͽ�	�ٸ� ����	������ ��ȯ�Ѵ�.												 */
	/*																																			 */
	/*		-	��ȯ��																													 */
	/*			OK : ����	ó�� ��																								 */
	/*			�����޽��� : ��Ÿ	���� �߻���	(DEFAULT��:ERROR)									 */
	/*																																			 */
	/* 10. �����ۼ���: LG	CNS	����ö																				 */
	/* 11. �����ۼ���: 2005��12��21��																				 */
	/* 12. ����������:																											 */
	/* 13. ����������:																											 */
	/*************************************************************************/
	FUNCTION create_cash_edi_file( p_comp_code				 IN	VARCHAR2 ,		-- ������ڵ�
																 p_bank_code				 IN	VARCHAR2 ,		-- �����ڵ�
																 p_row_cnt					 IN	NUMBER	 ,		-- ó����	���� ����	(üũ��)
																 p_emp_no						 IN	VARCHAR2 ,		-- ���
																 p_edi_history_seq	 OUT NUMBER	)			-- EDI����_�ۼ���HISTORY�Ϸù�ȣ (������ ���, NULL)
		RETURN VARCHAR2	IS													-- �Լ�	ó����� �޽���
	BEGIN
		-- >>>>>>>>>>>>>	 ó������		 <<<<<<<<<<<<<<<<<<
		-- sp_create_cash_edi_file(	company_cd		,			 --	ȸ���ڵ�
		--													pay_gubun			,			 --	���ޱ���
		--													pay_due_ymd		,			 --	���޿�������
		--													bank_cd				,			 --	�����ڵ� 
		--													account_no		,			 --	��ݰ���ID
		--													emp_no				,			 --	�����ȣ(����������)
		--													result_code		,			 --	ó������ڵ� 
		--													edi_date		 DEFAULT NULL	)
		RETURN(	NULL );

	END	create_cash_edi_file;


	/*************************************************************************/
	/*																																			 */
	/*	1. ���ID	 : create_bill_edi_file																		 */
	/*	2. ����̸�	 : ���ھ�������	����																		 */
	/*	3. �ý���	 : ȸ��ý���																							 */
	/*	4. ����ý���: FBS																									 */
	/*	5. �������	 :																											 */
	/*	6. �����	 : PL/SQL																								 */
	/*	7. ���ȯ��	 : Windows2003 Server+ Oracle	9.2.0											 */
	/*	8. ���DBMS	 : Oracle																								 */
	/*	9. �����	���� ��	�ֿ���																					 */
	/*																																			 */
	/*		-	������ ȭ��ܿ���	UPDATE�Ͽ��ִ� EDI_CREATE_REQ_YN �÷���	'Y'		 */
	/*			�� ����	������� EDI������ �����մϴ�.													 */
	/*																																			 */
	/*		-	���ھ��������� �����ϸ�, ���ະ/����庰�� �����ȴ�.						 */
	/*			���������� ������	���,	RETURN���� OK��	��ȯ�Ǹ�,	������ �ۼ�		 */
	/*			���̷����̺�(T_FB_EDI_HISTORY)�� Ű(SEQ)�� ��ȯ�ȴ�.						 */
	/*			������ ��	���� NULL����	��ȯ�ȴ�.															 */
	/*																																			 */
	/*		-	��ü������ ������	��Ģ�� �ǰ�	������ �ϴ�	function�� ȣ���Ͽ�		 */
	/*			���ϰ��/���ϸ���	���ؼ� ������Ų��.														 */
	/*																																			 */
	/*		-	���ϸ� ����Ģ��	������ ����	��																 */
	/*			 BS_������ڵ�(2)_�����ڵ�(2)_��¥(8)_�Ϸù�ȣ(3).dat						 */
	/*																																			 */
	/*		-	���ü� üũ��	���ؼ� ȭ���������	ȣ���,	������ ����	������		 */
	/*			�� �Լ���	parameter��	�Է��Ͽ�,	���� ó���Ϸ����	���� ������		 */
	/*			�񱳸� �Ͽ�	�ٸ� ����	������ ��ȯ�Ѵ�.												 */
	/*																																			 */
	/*		-	��ȯ��																													 */
	/*			OK : ����	ó�� ��																								 */
	/*			�����޽��� : ��Ÿ	���� �߻���	(DEFAULT��:ERROR)									 */
	/*																																			 */
	/* 10. �����ۼ���: LG	CNS	����ö																				 */
	/* 11. �����ۼ���: 2005��12��21��																				 */
	/* 12. ����������:																											 */
	/* 13. ����������:																											 */
	/*************************************************************************/
	FUNCTION create_bill_edi_file(	p_comp_code				IN VARCHAR2	,		 --	������ڵ�
																	p_bank_code				IN VARCHAR2	,		 --	�����ڵ�
																	p_row_cnt					IN NUMBER		,		 --	ó���� ����	���� (üũ��)
																	p_emp_no					IN VARCHAR2	,		 --	���
																	p_edi_history_seq	OUT	NUMBER )		 --	EDI����_�ۼ���HISTORY�Ϸù�ȣ	(������	���,	NULL)
		RETURN VARCHAR2	IS													 --	�Լ� ó�����	�޽���
	BEGIN
		-- >>>>>>>>>>>>>	 ó������		 <<<<<<<<<<<<<<<<<<
		-- sp_create_bill_edi_file(	company_cd		,			 --	ȸ���ڵ�
		--													pay_gubun			,			 --	���ޱ���
		--													pay_due_ymd		,			 --	���࿹������																			
		--													bank_cd				,			 --	�����ڵ� 
		--													account_no		,			 --	��ݰ���ID
		--													emp_no				,			 --	�����ȣ(����������)
		--													result_code		)	;		 --	ó������ڵ�?

		RETURN(	NULL );

	END	create_bill_edi_file;



	/*************************************************************************/
	/*																																			 */
	/*	1. ���ID	 : send_cash_each_transfer																 */
	/*	2. ����̸�	 : ���ҰǺ�	������ü ����																 */
	/*	3. �ý���	 : ȸ��ý���																							 */
	/*	4. ����ý���: FBS																									 */
	/*	5. �������	 :																											 */
	/*	6. �����	 : PL/SQL																								 */
	/*	7. ���ȯ��	 : Windows2003 Server+ Oracle	9.2.0											 */
	/*	8. ���DBMS	 : Oracle																								 */
	/*	9. �����	���� ��	�ֿ���																					 */
	/*																																			 */
	/*		-	����� Ȯ��	������ ���ؼ�	������ �������ް�	������ ����	�����	 */
	/*			VAN��	���ؼ� ����(��Ÿ����ü)�ۼ�����	�����Ѵ�.									 */
	/*			ó�����HISTORY��	HISTORY	TABLE(T_FB_CASH_PAY_HISTORY)�� ����		 */
	/*			�Ǹ�,	ó������� RESP_CODE,	RESP_MSG�� ��ȯ�ȴ�.								 */
	/*																																			 */
	/*		-	�� �Լ���	�ܵ����� ����ġ	������,	SEND_CASH_TRANSFER�� ���ؼ�		 */
	/*			 ȣ��Ǿ�	���ȴ�.																							 */
	/*																																			 */
	/*		-	��ȯ��																													 */
	/*			OK : ����	ó�� ��																								 */
	/*			�����޽��� : ��Ÿ	���� �߻���	(DEFAULT��:ERROR)									 */
	/*																																			 */
	/* 10. �����ۼ���: LG	CNS	����ö																				 */
	/* 11. �����ۼ���: 2005��12��21��																				 */
	/* 12. ����������:																											 */
	/* 13. ����������:																											 */
	/*************************************************************************/
	FUNCTION send_cash_each_transfer(	p_pay_seq			IN NUMBER	,			 --	�����Ϸù�ȣ
																		p_div_seq			IN NUMBER	,			 --	�����Ϸù�ȣ
																		p_emp_no			IN VARCHAR2	,		 --	���
																		p_resp_code		OUT	VARCHAR2,		 --	�����ڵ�
																		p_resp_msg		OUT	VARCHAR2 )	 --	�����ڵ��
		RETURN VARCHAR2	IS													 --	�Լ� ó�����	�޽���
	BEGIN
		-- >>>>>>>>>>>>>	 ó������		 <<<<<<<<<<<<<<<<<<
		--		sp_send_cash_each_transfer(	p_out_bank_code		 ,		 --	��������ڵ�
		--																p_out_acct_number	 ,		 --	��ݰ��¹�ȣ
		--																p_in_bank_code		 ,		 --	�Ա������ڵ�
		--																p_in_acct_number	 ,		 --	�Աݰ��¹�ȣ
		--																p_pay_amt					 ,		 --	��ü�ݾ�									 
		--																p_commission			 ,		 --	������
		--																p_resp_code				 ,		 --	�����ڵ�
		--																p_resp_msg				 ,		 --	�����ڵ��
		--																p_docu_numc				 ,		 --	������ȣ
		--																p_send_date				 ,		 --	���۽ð�
		--																p_recv_date					);	 --	����ð�
		RETURN(	NULL );

	END	send_cash_each_transfer;


	/*************************************************************************/
	/*																																			 */
	/*	1. ���ID	 : send_cash_transfer																			 */
	/*	2. ����̸�	 : ���ްǺ�	������ü ����																 */
	/*	3. �ý���	 : ȸ��ý���																							 */
	/*	4. ����ý���: FBS																									 */
	/*	5. �������	 :																											 */
	/*	6. �����	 : PL/SQL																								 */
	/*	7. ���ȯ��	 : Windows2003 Server+ Oracle	9.2.0											 */
	/*	8. ���DBMS	 : Oracle																								 */
	/*	9. �����	���� ��	�ֿ���																					 */
	/*																																			 */
	/*		-	���ް�(T_FB_CASH_PAY_DATA) ������	ó���Ǹ�,	���� ����ڰ�	ȭ��	 */
	/*			�� ���ؼ�	ȣ��Ǵ� �����̸�, ����������	���ҵ� ����	������ ��		 */
	/*			�Ͽ�,	DIV_SEQ��	�߰�PARAMETER��	�Ͽ�,	SEND_CASH_EACH_TRANSFER		 */
	/*			�Լ��� ȣ���Ͽ�	ó���Ѵ�.																				 */
	/*																																			 */
	/*		-	�Լ����������� DIVIDE��	�Ǽ��� üũ�ϰ�, ������	�ǿ� ���Ͽ�			 */
	/*			ó���Ϸ� ��, �������ó����	��� Ȥ��	�Ϻν���,	��ü���п� ��		 */
	/*			�� �̷���	������ �ִٰ�	ó������� RETURN�Ѵ�.									 */
	/*																																			 */
	/*		-	�����۽ÿ��� ��	�Լ��� ����ϸ�, ���޽���/�Ϻ����޽����� ���		 */
	/*			�ش� ���޽��а���	ã�Ƽ� SEND_CASH_EACH_TRANSFER�� ��ȣ���Ͽ�		 */
	/*			ó���Ѵ�.																												 */
	/*																																			 */
	/*		-	�Լ����������� SEND_CASH_EACH_TRANSFER�� ȣ���Ͽ�	����					 */
	/*			ó������� ���Ͽ�	PAY_STATUS�� UPDATE�Ѵ�.											 */
	/*			4: ���޿Ϸ�																											 */
	/*			5: ���޽���																											 */
	/*			6: �Ϻ����޽���	=> �������Ұ��϶�, �����Ϻΰ�	������ ���				 */
	/*			7: ��ǥ���																											 */
	/*																																			 */
	/*		-	��ȯ��																													 */
	/*			����ó�� =>	���� ��üó��	�Ϸ� ��																 */
	/*			�Ϻ����޽���:[�����޽���]																				 */
	/*					 =>	�������Ұ��� ���, �Ϻ�	���޽��н� ù��°	����					 */
	/*			���޽���:[�����޽���]																						 */
	/*					 =>	���Ұ���1����	���,	���޽��н� ����											 */
	/*			��ǥ��� =>	��ǥ��ҵ� ���																			 */
	/*																																			 */
	/* 10. �����ۼ���: LG	CNS	����ö																				 */
	/* 11. �����ۼ���: 2005��12��21��																				 */
	/* 12. ����������:																											 */
	/* 13. ����������:																											 */
	/*************************************************************************/
	FUNCTION send_cash_transfer( p_pay_seq		 IN	NUMBER ,			-- �����Ϸù�ȣ
															 p_emp_no			 IN	VARCHAR2 )		-- ���
		RETURN VARCHAR2	IS												-- �Լ�	ó����� �޽���
	BEGIN
		-- >>>>>>>>>>>>>	 ó������		 <<<<<<<<<<<<<<<<<<
		sp_send_cash_transfer( p_pay_seq		 ,		 --	�����Ϸù�ȣ
													 p_emp_no				);	 --	���

		RETURN(	NULL );

	END	send_cash_transfer;



	/*************************************************************************/
	/*																																			 */
	/*	1. ���ID	 : send_bill_transfer																			 */
	/*	2. ����̸�	 : ���ްǺ�	���ھ��� realtime	�۽�											 */
	/*	3. �ý���	 : ȸ��ý���																							 */
	/*	4. ����ý���: FBS																									 */
	/*	5. �������	 :																											 */
	/*	6. �����	 : PL/SQL																								 */
	/*	7. ���ȯ��	 : Windows2003 Server+ Oracle	9.2.0											 */
	/*	8. ���DBMS	 : Oracle																								 */
	/*	9. �����	���� ��	�ֿ���																					 */
	/*																																			 */
	/*		-	Realtime���� ���ھ�����	�����ϴ� �����	�����մϴ�.							 */
	/*																																			 */
	/*		-	��ȯ��																													 */
	/*			����ó�� =>	���� ����ó��	�Ϸ� ��																 */
	/*			���޽��� =>	���޽��� ����																				 */
	/*			��ǥ��� =>	��ǥ��ҵ� ���																			 */
	/*																																			 */
	/* 10. �����ۼ���: LG	CNS	����ö																				 */
	/* 11. �����ۼ���: 2005��12��21��																				 */
	/* 12. ����������:																											 */
	/* 13. ����������:																											 */
	/*************************************************************************/
	FUNCTION send_bill_transfer( p_pay_seq			 IN	NUMBER ,			-- �����Ϸù�ȣ
															 p_emp_no				 IN	VARCHAR2 )		-- ���
		RETURN VARCHAR2	IS												-- �Լ�	ó����� �޽���
	BEGIN
		-- >>>>>>>>>>>>>	 ó������		 <<<<<<<<<<<<<<<<<<
	--sp_send_bill_transfer( p_pay_seq					 ,		 --	�����Ϸù�ȣ
	--											 p_out_bank_code		 ,		 --	��������ڵ�
	--											 p_out_acct_number	 ,		 --	��ݰ��¹�ȣ
	--											 p_in_bank_code			 ,		 --	�Ա������ڵ�
	--											 p_in_acct_number		 ,		 --	�Աݰ��¹�ȣ
	--											 p_regist_number		 ,		 --	����ڹ�ȣ
	--											 p_check_no					 ,		 --	��ǥ/������ȣ
	--											 p_future_ymd				 ,		 --	��������
	--											 p_pay_amt					 ,		 --	��ü�ݾ�
	--											 p_franchise_no			 ,		 --	��������ȣ
	--											 p_emp_no							)	;	 --	���

		RETURN(	NULL );

	END	send_bill_transfer;




	/*************************************************************************/
	/*																		                                   */
	/*	1. ���ID	 : retieve_pay_summation								                   */
	/*	2. ����̸�	 : ��ü�����û	ó��									                   */
	/*	3. �ý���	 : ȸ��ý���											                         */
	/*	4. ����ý���: FBS													                         */
	/*	5. �������	 :														                           */
	/*	6. �����	 : PL/SQL												                         */
	/*	7. ���ȯ��	 : Windows2003 Server+ Oracle	9.2.0						           */
	/*	8. ���DBMS	 : Oracle												                         */
	/*	9. �����	���� ��	�ֿ���											                     */
	/*																		                                   */
	/*		-	�����ڵ�� ���¹�ȣ��	�Է¹޾�,	��üó�������û�� �Ͽ�	���	   */
	/*			�� ��ȯ�մϴ�.												                           */
	/*		-	���аǼ�,���бݾ���	�ѰǼ�/�ѱݾ׿���	�����Ǽ��� �����ݾ���	     */
	/*			�����Ͽ� ����մϴ�.											                       */
	/*																		                                   */
	/* 10. �����ۼ���: LG	CNS	����ö										                     */
	/* 11. �����ۼ���: 2005��12��21��										                     */
	/* 12. ����������:														                           */
	/* 13. ����������:														                           */
	/*************************************************************************/
	PROCEDURE	retieve_pay_summation( p_bank_code		 IN	VARCHAR2 ,		 --	�����ڵ�
									 p_acct_number		 IN	VARCHAR2 ,		 --	���¹�ȣ
									 p_da_req_cnt		 OUT NUMBER	,			 --	���� ��û	�Ǽ�
									 p_da_req_amt		 OUT NUMBER	,			 --	���� ��û	�ݾ�
									 p_da_success_cnt	 OUT NUMBER	,			 --	���� ����ó��	�Ǽ�
									 p_da_success_amt	 OUT NUMBER	,			 --	���� ����ó��	�ݾ�
									 p_da_commission	 OUT NUMBER	,			 --	���� ������
									 p_ta_req_cnt		 OUT NUMBER	,			 --	Ÿ�� ��û	�Ǽ�
									 p_ta_req_amt		 OUT NUMBER	,			 --	Ÿ�� ��û	�ݾ�
									 p_ta_success_cnt	 OUT NUMBER	,			 --	Ÿ�� ����ó��	�Ǽ�
									 p_ta_success_amt	 OUT NUMBER	,			 --	Ÿ�� ����ó��	�ݾ�
									 p_ta_commission	 OUT NUMBER	,			 --	Ÿ�� ������
									 p_resp_code		 OUT VARCHAR2,		 --	�����ڵ�
									 p_resp_msg			 OUT VARCHAR2	)	IS	 --	�����ڵ��
		lrSend						FB_VAN_SEND_RECORD;
		lrRecv						FB_VAN_RECV_RECORD;
		lsRet						Varchar2(4000);
		p_result_code				Varchar2(4000);
		p_result_msg				Varchar2(4000);
		ltVars						T_Vars;
		ltNums						T_Nums;
	BEGIN
		-- >>>>>>>>>>>>>	 ó������		 <<<<<<<<<<<<<<<<<<
		--.�⺻	�ʱ�ȭ
		init_van_send_record(p_bank_code,p_acct_number,FB_DOCU_SUM_T,lrSend);
		-- ������	����
		lrSend.gaeb_area :=		fbs_util_pkg.sprintf('%-15.15s', p_acct_number ) ||		--1.������ݰ��¹�ȣ
								fbs_util_pkg.sprintf('%-5.5s', ''	)	||					--2.�����Ƿ��ѰǼ�
								fbs_util_pkg.sprintf('%-13.13s', ''	)	||				--3.�����Ƿ��ѱݾ�
								fbs_util_pkg.sprintf('%-5.5s', ''	)	||					--4.��������Ǽ�
								fbs_util_pkg.sprintf('%-13.13s', ''	)	||				--5.��������ݾ�
								fbs_util_pkg.sprintf('%-5.5s', ''	)	||					--6.����ҴɰǼ�
								fbs_util_pkg.sprintf('%-13.13s', ''	)	||				--7.����Ҵɱݾ�
								fbs_util_pkg.sprintf('%-9.9s', ''	)	||					--8.���������
								fbs_util_pkg.sprintf('%-5.5s', ''	)	||					--9.�����Ƿ��ѰǼ�
								fbs_util_pkg.sprintf('%-13.13s', ''	)	||				--10.Ÿ���Ƿ��ѱݾ�
								fbs_util_pkg.sprintf('%-5.5s', ''	)	||					--11.Ÿ������Ǽ�
								fbs_util_pkg.sprintf('%-13.13s', ''	)	||				--12.Ÿ������ݾ�
								fbs_util_pkg.sprintf('%-5.5s', ''	)	||					--13.Ÿ��ҴɰǼ�
								fbs_util_pkg.sprintf('%-13.13s', ''	)	||				--14.Ÿ��Ҵɱݾ�
								fbs_util_pkg.sprintf('%-9.9s', ''	)	||					--15.Ÿ�������
								fbs_util_pkg.sprintf('%-59.59s', ''	)	;					--16.����

		lsRet	:= send_realtime_document(lrSend,DEFAULT_TIMEOUT,lrRecv,p_result_code,p_result_msg);

		If lsRet <>	SUCCESS_CODE Then
			p_resp_msg :=	lsRet;
			Return;
		End	If;
		ltNums(1)	:=	15;	--1.������ݰ��¹�ȣ
		ltNums(2)	:=	 5;	--2.�����Ƿ��ѰǼ�
		ltNums(3)	:=	13;	--3.�����Ƿ��ѱݾ�
		ltNums(4)	:=	 5;	--4.��������Ǽ�
		ltNums(5)	:=	13;	--5.��������ݾ�
		ltNums(6)	:=	 5;	--6.����ҴɰǼ�
		ltNums(7)	:=	13;	--7.����Ҵɱݾ�
		ltNums(8)	:=	 9;	--8.���������
		ltNums(9)	:=	 5;	--9.�����Ƿ��ѰǼ�
		ltNums(10) :=	13;	--10.Ÿ���Ƿ��ѱݾ�
		ltNums(11) :=	 5;	--11.Ÿ������Ǽ�
		ltNums(12) :=	13;	--12.Ÿ������ݾ�
		ltNums(13) :=	 5;	--13.Ÿ��ҴɰǼ�
		ltNums(14) :=	13;	--14.Ÿ��Ҵɱݾ�
		ltNums(15) :=	 9;	--15.Ÿ�������
		ltNums(16) :=	59;	--16.����

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
	/*	1. ���ID	 : retieve_acct_holder_name								                 */
	/*	2. ����̸�	 : �����ָ�	��ȸ										                     */
	/*	3. �ý���	 : ȸ��ý���											                         */
	/*	4. ����ý���: FBS													                         */
	/*	5. �������	 :														                           */
	/*	6. �����	 : PL/SQL												                         */
	/*	7. ���ȯ��	 : Windows2003 Server+ Oracle	9.2.0						           */
	/*	8. ���DBMS	 : Oracle												                         */
	/*	9. �����	���� ��	�ֿ���											                     */
	/*																		                                   */
	/*		-	�Էµ� �����ڵ�	�� ���¹�ȣ��	���� �����ָ���	VAN��	������	     */
	/*			�ۼ����Ͽ�,	���ؿɴϴ�.										                       */
	/*			���������� ó����	���,	RESP_CODE��	"0000"���� ��ȯ��	��츸	   */
	/*			���������� ��ȸ��	�����.										                     */
	/*																		                                   */
	/*		-	��ȯ��														                               */
	/*			OK : ����	ó�� ��											                           */
	/*			�����޽��� : ��Ÿ	���� �߻���	(DEFAULT��:ERROR)				           */
	/*																		                                   */
	/* 10. �����ۼ���: LG	CNS	����ö										                     */
	/* 11. �����ۼ���: 2005��12��21��										                     */
	/* 12. ����������:														                           */
	/* 13. ����������:														                           */
	/*************************************************************************/
	FUNCTION retieve_acct_holder_name( p_bank_code		 IN	VARCHAR2 ,		 --	�����ڵ�
										                 p_acct_number	 IN	VARCHAR2 ,		 --	���¹�ȣ
										                 p_holder_name	 OUT VARCHAR2,		 --	�����ָ�
										                 p_resp_code		 OUT VARCHAR2,		 --	�����ڵ�
										                 p_resp_msg		   OUT VARCHAR2	)		 --	�����ڵ��
		RETURN VARCHAR2	IS													 --	�Լ� ó�����	�޽���
	BEGIN
		-- >>>>>>>>>>>>>	 ó������		 <<<<<<<<<<<<<<<<<<
		--p_holder_name := f_retrive_acct_holder_name( p_bank_code	,	   -- �����ڵ�
		--													                   p_acct_number,	   -- ���¹�ȣ
		--													                   p_biz_number	  )	 -- �ֹ�(�����)��ȣ

		RETURN(	NULL );

	END	retieve_acct_holder_name;




	/*************************************************************************/
	/*																		                                   */
	/*	1. ���ID	   : read_bill_vendor_info								                 */
	/*	2. ����̸�	 : ���ھ���	�ŷ������� ����	ó��						             */
	/*	3. �ý���	   : ȸ��ý���											                       */
	/*	4. ����ý���: FBS													                         */
	/*	5. �������	 :														                           */
	/*	6. �����	 : PL/SQL												                         */
	/*	7. ���ȯ��	 : Windows2003 Server+ Oracle	9.2.0						           */
	/*	8. ���DBMS	 : Oracle												                         */
	/*	9. �����	���� ��	�ֿ���											                     */
	/*																		                                   */
	/*		-	�������κ��� ���ŵ�	���ھ��� �ŷ����������ϸ�(�������)��	��	   */
	/*			�,	���ھ������¾�ü(T_FB_BILL_VENDORS)�� �ݿ��Ѵ�.		         */
	/*																		                                   */
	/*		-	���ϸ� ���������(�������,�ϳ�����)	                           */
	/*			 V_������ڵ�(2)_�����ڵ�(2)_��¥(8)_�Ϸù�ȣ(3).dat			       */
	/*																		                                   */
	/*		-	�ű�/����/���� ���	�ش� TABLE�� INSERT��	�����ϸ�,	������	     */
	/*			VIEW�� ���ؼ�	���� ��ü��	���¸� Ȯ����	�� �ֵ���	�Ѵ�.		       */
	/*																		                                   */
	/*		-	��ȯ��														                               */
	/*			OK : ����	ó�� ��											                           */
	/*			�����޽��� : ��Ÿ	���� �߻���	(DEFAULT��:ERROR)				           */
	/*																		                                   */
	/* 10. �����ۼ���: LG	CNS	����ö										                     */
	/* 11. �����ۼ���: 2005��12��21��										                     */
	/* 12. ����������:														                           */
	/* 13. ����������:														                           */
	/*************************************************************************/
	FUNCTION read_bill_vendor_info(	p_edi_history_seq	 IN	NUMBER )				-- EDI�ۼ����̷� �Ϸù�ȣ
		RETURN VARCHAR2	IS														-- �Լ�	ó����� �޽���
	BEGIN
		-- >>>>>>>>>>>>>	 ó������		 <<<<<<<<<<<<<<<<<<
		-- sp_read_bill_vendor_info( comp_code        ,       -- �þ�¡�ڵ�
		--                           bank_code        ,       -- �����ڵ�
		--                           emp_no            )      -- �����ȣ

		RETURN(	NULL );

	END	read_bill_vendor_info;



	/*************************************************************************/
	/*																		                                   */
	/*	1. ���ID	 : read_bill_result										                     */
	/*	2. ����̸�	 : ���ھ���	ó����� ����	ó��							             */
	/*	3. �ý���	 : ȸ��ý���											                         */
	/*	4. ����ý���: FBS													                         */
	/*	5. �������	 :														                           */
	/*	6. �����	 : PL/SQL												                         */
	/*	7. ���ȯ��	 : Windows2003 Server+ Oracle	9.2.0						           */
	/*	8. ���DBMS	 : Oracle												                         */
	/*	9. �����	���� ��	�ֿ���											                     */
	/*																		                                   */
	/*		-	����� ȭ�����κ���	�ش� EDI�ۼ����̷��� SEQ�� �޾�, ��������	   */
	/*			���� ��ȸ�Ͽ�, ������	������ ��, ä�ǹ�ȣ��	�ش��ϴ� ���ް���	   */
	/*			ã�Ƽ� ó�������	UPDATE�Ѵ�.									                   */
	/*																		                                   */
	/*		-	���ϸ� ����Ģ��	������ ����	�� (�ۼ����̷����̺� ����)	     */
	/*			 BR_������ڵ�(2)_�����ڵ�(2)_��¥(8)_�Ϸù�ȣ(3).dat				     */
	/*																		                                   */
	/*		-	ó������� ����	�� ���ްǿ�	���Ͽ� ����(PAY_STATUS)��	UPDATE   */
	/*			4: ����Ϸ�													                             */
	/*			5: �������													                             */
	/*                                                                       */ 
	/*		-	��ȯ��														                               */
	/*			OK : ����	ó�� ��											                           */
	/*			�����޽��� : ��Ÿ	���� �߻���	(DEFAULT��:ERROR)				           */
	/*																		                                   */
	/* 10. �����ۼ���: LG	CNS	����ö										                     */
	/* 11. �����ۼ���: 2005��12��21��										                     */
	/* 12. ����������:														                           */
	/* 13. ����������:														                           */
	/*************************************************************************/
	FUNCTION read_bill_result(	p_edi_history_seq	 IN	NUMBER ,			-- EDI�ۼ����̷� �Ϸù�ȣ
								              p_emp_no			     IN	VARCHAR2 )		-- ���
		RETURN VARCHAR2	IS														-- �Լ�	ó����� �޽���
	BEGIN
		-- >>>>>>>>>>>>>	 ó������		 <<<<<<<<<<<<<<<<<<
		--sp_read_bill_result( comp_code        ,        -- ����� �ڵ�
		--                     bank_code        ,        -- �����ڵ�
    --                     file_name        ,        -- ���ϸ�
    --                     edi_history_seq   ) ;     -- edi�̷��Ϸù�ȣ

		RETURN(	NULL );

	END	read_bill_result;


	/*************************************************************************/
	/*																		                                   */
	/*	1. ���ID	 : read_cash_result										                     */
	/*	2. ����̸�	 : ������ü����	ó����� ����	ó��						           */
	/*	3. �ý���	 : ȸ��ý���											                         */
	/*	4. ����ý���: FBS													                         */
	/*	5. �������	 :														                           */
	/*	6. �����	 : PL/SQL												                         */
	/*	7. ���ȯ��	 : Windows2003 Server+ Oracle	9.2.0						           */
	/*	8. ���DBMS	 : Oracle												                         */
	/*	9. �����	���� ��	�ֿ���											                     */
	/*																		                                   */
	/*		-	����� ȭ�����κ���	�ش� EDI�ۼ����̷��� SEQ�� �޾�, ��������	   */
	/*			���� ��ȸ�Ͽ�, ������	������ ��, �ش��ϴ�	���ް���			         */
	/*			ã�Ƽ� ó�������	UPDATE�Ѵ�.									                   */
	/*																		                                   */
	/*		-	���ϸ� ����Ģ��	������ ����	�� (�ۼ����̷����̺� ����)	     */
	/*			 CR_������ڵ�(2)_�����ڵ�(2)_��¥(8)_�Ϸù�ȣ(3).dat			       */
	/*																		                                   */
	/*		-	ó������� ����	�� ���ްǿ�	���Ͽ� ����(PAY_STATUS)��	UPDATE   */
	/*			4: ���޼���													                             */
	/*			5: ���޽���													                             */
	/*                                                                       */
	/*		-	��ȯ��														                               */
	/*			OK : ����	ó�� ��											                           */
	/*			�����޽��� : ��Ÿ	���� �߻���	(DEFAULT��:ERROR)				           */
	/*																		                                   */
	/* 10. �����ۼ���: LG	CNS	����ö										                     */
	/* 11. �����ۼ���: 2006��1��10��										                     */
	/* 12. ����������:														                           */
	/* 13. ����������:														                           */
	/*************************************************************************/
	FUNCTION read_cash_result(	p_edi_history_seq	 IN	NUMBER ,		-- EDI�ۼ����̷� �Ϸù�ȣ
								              p_emp_no			     IN	VARCHAR2 )	-- ���
		RETURN VARCHAR2	IS														-- �Լ�	ó����� �޽���
	BEGIN
		-- >>>>>>>>>>>>>	 ó������		 <<<<<<<<<<<<<<<<<<
		--sp_read_cash_result( comp_code        ,        -- ����� �ڵ�
		--                     bank_code        ,        -- �����ڵ�
    --                     file_name        ,        -- ���ϸ�
    --                     edi_history_seq   ) ;     -- edi�̷��Ϸù�ȣ

		RETURN(	NULL );

	END	read_cash_result;

	/*************************************************************************/
	/*																		                                   */
	/*	1. ���ID	 : do_job_task											                       */
	/*	2. ����̸�	 : �����ֱ⺰��	����Ǵ� job�� ����	�Ѱ� ȣ��	�Լ�		   */
	/*	3. �ý���	 : ȸ��ý���											                         */
	/*	4. ����ý���: FBS													                         */
	/*	5. �������	 :														                           */
	/*	6. �����	 : PL/SQL												                         */
	/*	7. ���ȯ��	 : Windows2003 Server+ Oracle	9.2.0						           */
	/*	8. ���DBMS	 : Oracle												                         */
	/*	9. �����	���� ��	�ֿ���											                     */
	/*																		                                   */
	/*		-	������ �ֱ⺰��	����Ǵ� JOB�� ��ϵ�	TASK�� ���Ͽ�	������	     */
	/*			��ȸ���� ��	�ʿ�PARAMETER��	�����Ͽ� ȣ���ϴ�	�Ѱ��Լ�		       */
	/*																		                                   */
	/*		-	JOB��	���Ͽ� ó���Ǵ�	������ �Ʒ���	����						             */
	/*																		                                   */
	/*			(1)	���������߼�												                         */
	/*			 : ���Ͼ�ħ��	FBS�������¿�	�ش��ϴ� ������	SELECT�� ��	,	       */
	/*				 send_start_document�� ȣ���Ͽ�, ����������	�۽��Ѵ�.		       */
	/*																		                                   */
	/*			(2)	FBS���¸���	�߼�											                       */
	/*			 : ��ϵ�	����ڿ��� FBS���¸� üũ�ϴ�	������ ������	�����     */
	/*				 ���Ͽ�	��Ƽ� �߼��Ѵ�.									                     */
	/*																		                                   */
	/*			(3)	���ھ��� �ŷ�������	���� ��	ó��							               */
	/*			 : ���Ͼ�ħ��	�������κ��� �ŷ���	������ ������	��,	ó��	       */
	/*																		                                   */
	/*			(4)	���ݰŷ��� ���	ó��									                     */
	/*			 : ���ݰŷ�����, ���������	�ڵ����� üũ�Ͽ�	�����û ��	     */
	/*				 ���信	���� ó����	�����Ѵ�.	1�ð�	���� ����				           */
	/*																		                                   */
	/*			(5)	���ھ��� �ŷ���	��� ó��								                   */
	/*			 : ���ھ���	�ŷ��� ��, ���������	�ڵ����� üũ�Ͽ�	���	     */
	/*				 ��û	�� ���信	���� ó����	�����Ѵ�.	1�ð�	���� ����		       */
	/*																		                                   */
	/*			(6)	�� ���¿�	���� �ϰ�	�ϸ��ܾ� ��ȸ							               */
	/*			 : ������	�ð��� FBS���·� ��ϵ�	��� ���¿�	���Ͽ� �ϰ���	     */
	/*				 ����	�ý����� �ڵ�����	�ܾ���ȸ ������	�ۼ��� �Ѵ�.		       */
	/*																		                                   */
	/*			(7)	�о����۵���Ÿ	����Ȯ��									                   */
	/*			 : �Ա�/�Ա���ҳ����� ���Ͽ�	�о�ý������� �����Ҷ�, ����	     */
	/*				 �̷���	Ȯ���Ͽ�,	�������̷³����� �����۽õ��ϸ�, �ٽ�	       */
	/*				 ������	�߻��ô�,	�� ��ϵ�	�ο����� ������	�߼��Ѵ�.		       */
	/*																		                                   */
	/* 10. �����ۼ���: LG	CNS	����ö										                     */
	/* 11. �����ۼ���: 2005��12��21��										                     */
	/* 12. ����������:														                           */
	/* 13. ����������:														                           */
	/*************************************************************************/
	PROCEDURE	do_job_task	IS

	BEGIN
		-- >>>>>>>>>>>>>	 ó������		 <<<<<<<<<<<<<<<<<<		
		sp_bank_opening();    -- ���������߼�
		sp_bank_depomiss();   -- ���ݰŷ��� ���	ó��
		sp_bank_checkmiss(); 	-- ���ھ��� �ŷ���	��� ó��
		sp_bill_vendor();     -- ���ھ��� �ŷ�������	���� ��	ó��

	END	 do_job_task;



	/*************************************************************************/
	/*																		                                   */
	/*	1. ���ID	 : send_tran_fail_mail									                   */
	/*	2. ����̸�	 : Ÿ����ü�Ҵ�	�������� �߼�							               */
	/*	3. �ý���	 : ȸ��ý���											 */
	/*	4. ����ý���: FBS													 */
	/*	5. �������	 :														 */
	/*	6. �����	 : PL/SQL												 */
	/*	7. ���ȯ��	 : Windows2003 Server+ Oracle	9.2.0						 */
	/*	8. ���DBMS	 : Oracle												 */
	/*	9. �����	���� ��	�ֿ���											 */
	/*																		 */
	/*		-	�� �Լ���	TRIGGER����	ȣ��Ǹ�,	Ÿ����ü���� ��, ��ü�Ҵ�	���� */
	/*			�� ������, T_FB_LOOKUP_VALUES��	LOOKUP_TYPE=TRAN_FAIL_MAIL_TO	 */
	/*			�׸����� ��ϵ�	����ڿ��� ������	�߼��մϴ�.					 */
	/*																		 */
	/*		-	�������κ��� ��	������ȣ�� �ش��ϴ�	���ް��� ã�Ƽ�	���޳����� */
	/*			���� ������	�����Ͽ� ������	�߼��Ѵ�.							 */
	/*																		 */
	/*		-	��ȯ��														 */
	/*			OK : ����	ó�� ��											 */
	/*			�����޽��� : ��Ÿ	���� �߻���	(DEFAULT��:ERROR)				 */
	/*																		 */
	/* 10. �����ۼ���: LG	CNS	����ö										 */
	/* 11. �����ۼ���: 2005��12��21��										 */
	/* 12. ����������:														 */
	/* 13. ����������:														 */
	/*************************************************************************/
	FUNCTION send_tran_fail_mail(	p_comp_code			IN VARCHAR2	,			 --	������ڵ�
									p_bank_code			IN VARCHAR2	,			 --	�����ڵ�
									p_docu_numc			IN VARCHAR2	)			 --	������ȣ
		RETURN VARCHAR2	IS													 --	�Լ� ó�����	�޽���
	BEGIN


		-- >>>>>>>>>>>>>	 ó������		 <<<<<<<<<<<<<<<<<<


		RETURN(	NULL );

	END	send_tran_fail_mail;



	/*************************************************************************/
	/*																		 */
	/*	1. ���ID	 : create_paydue_mail_data								 */
	/*	2. ����̸�	 : ���޿���	���ϵ���Ÿ ����								 */
	/*	3. �ý���	 : ȸ��ý���											 */
	/*	4. ����ý���: FBS													 */
	/*	5. �������	 :														 */
	/*	6. �����	 : PL/SQL												 */
	/*	7. ���ȯ��	 : Windows2003 Server+ Oracle	9.2.0						 */
	/*	8. ���DBMS	 : Oracle												 */
	/*	9. �����	���� ��	�ֿ���											 */
	/*																		 */
	/*		-	��ݰ����� ��ü��	���ްǿ� ���Ͽ�	���޿��������� �߼���	�ڷḦ */
	/*			�����մϴ�.	������ �����/���޿�������/�����	�� ��������	��	 */
	/*																		 */
	/*		-	�����/���޿�������	�ʼ������̸�,	�ŷ�ó�� ���û����			 */
	/*																		 */
	/*		-	������ T_FB_PAYDUE_MAIL_MASTER�� T_FB_PAYDUE_MAIL_DETAIL��	 */
	/*			���� RECORD��	�����ϰ�,	INSERT�ϸ�,	�� �߼۵�	�̷��� �ִ�	��� */
	/*			MASTER�� ���������	������,	DETAIL�� ��	���� ��, �߼��̷���	 */
	/*			�̹߼� ���·�	UPDATE�Ѵ�.										 */
	/*																		 */
	/*		-	��ȯ��														 */
	/*			OK : ����	ó�� ��											 */
	/*			�����޽��� : ��Ÿ	���� �߻���	(DEFAULT��:ERROR)				 */
	/*																		 */
	/* 10. �����ۼ���: LG	CNS	����ö										 */
	/* 11. �����ۼ���: 2005��12��21��										 */
	/* 12. ����������:														 */
	/* 13. ����������:														 */
	/*************************************************************************/
	FUNCTION create_paydue_mail_data(	p_comp_code			IN VARCHAR2	,			 --	������ڵ�
										p_pay_ymd				IN VARCHAR2	,			 --	���޿�������
										p_vendor_seq			IN NUMBER	)			 --	�ŷ�ó�Ϸù�ȣ
		RETURN VARCHAR2	IS														 --	�Լ� ó�����	�޽���
	BEGIN


		-- >>>>>>>>>>>>>	 ó������		 <<<<<<<<<<<<<<<<<<


		RETURN(	NULL );

	END	create_paydue_mail_data;



	/*************************************************************************/
	/*																		 */
	/*	1. ���ID	 : send_paydue_mail										 */
	/*	2. ����̸�	 : ���޿���	���� �߼�									 */
	/*	3. �ý���	 : ȸ��ý���											 */
	/*	4. ����ý���: FBS													 */
	/*	5. �������	 :														 */
	/*	6. �����	 : PL/SQL												 */
	/*	7. ���ȯ��	 : Windows2003 Server+ Oracle	9.2.0						 */
	/*	8. ���DBMS	 : Oracle												 */
	/*	9. �����	���� ��	�ֿ���											 */
	/*																		 */
	/*		-	���Ϲ߼۵���Ÿ�� SEQ(�Ϸù�ȣ)�� �Է¹޾�, �������˿�	���缭	 */
	/*			����Ÿ�� �����Ͽ�	������ �߼��մϴ�.							 */
	/*																		 */
	/*		-	���� �����ڴ�	�ŷ�ó�ڵ�(T_CUST_CODE)���̺���	�ŷ�ó�� �ⳳ	 */
	/*			����ڸ� ��	����� �̸���	�ּҸ� SELECT�Ͽ�	�����Ѵ�.			 */
	/*																		 */
	/*		-	��ȯ��														 */
	/*			OK : ����	ó�� ��											 */
	/*			�����޽��� : ��Ÿ	���� �߻���	(DEFAULT��:ERROR)				 */
	/*																		 */
	/* 10. �����ۼ���: LG	CNS	����ö										 */
	/* 11. �����ۼ���: 2005��12��21��										 */
	/* 12. ����������:														 */
	/* 13. ����������:														 */
	/*************************************************************************/
	FUNCTION send_paydue_mail( p_mail_seq			IN NUMBER	,					 --	�����Ϸù�ȣ
								 p_emp_no				IN VARCHAR2	)					 --	���
		RETURN VARCHAR2	IS														 --	�Լ� ó�����	�޽���
	BEGIN


		-- >>>>>>>>>>>>>	 ó������		 <<<<<<<<<<<<<<<<<<


		RETURN(	NULL );

	END	send_paydue_mail;


	/*************************************************************************/
	/*																		                                   */
	/*	1. ���ID	 : create_transfer_slip_data							                 */
	/*	2. ����̸�	 : ������ü	��ǥ����/��ü����Ÿ	����					           */
	/*	3. �ý���	 : ȸ��ý���											                         */
	/*	4. ����ý���: FBS													                         */
	/*	5. �������	 :														                           */
	/*	6. �����	 : PL/SQL												                         */
	/*	7. ���ȯ��	 : Windows2003 Server+ Oracle	9.2.0						           */
	/*	8. ���DBMS	 : Oracle												                         */
	/*	9. �����	���� ��	�ֿ���											                     */
	/*																		                                   */
	/*		-	����� ������ü	������ ���Ͽ�	��ǥ���� ��	��ü�� ������	�� ��	   */
	/*			�� ��ü����Ÿ(T_FB_CASH_PAY_DATA�� RECORD)�� �����մϴ�		       */
	/*																		                                   */
	/*		-	��ǥ�� ȸ��������	�ڵ���ǥ�� �����ϸ�, ��������	��ǥ��ȣ��	     */
	/*			������ü�������̺�(T_FB_CASH_TRANSFER_DATA)��	UPDATE�Ѵ�.		     */
	/*																		                                   */
	/*		-	��ü����Ÿ�� ����������	�����Ǹ�,	�����Ϸù�ȣ(PAY_SEQ)��	�޾�   */
	/*			������ü�������̺�(T_FB_CASH_TRANSFER_DATA)��	UPDATE�Ѵ�.		     */
	/*																		                                   */
	/*		-	��ȯ��														                               */
	/*			OK : ����������	��ǥ����/��ü����Ÿ����	�Ϸ� ó��	��		         */
	/*			�����޽��� : ��Ÿ	���� �߻���								                     */
	/*				 =>	��ǥ�������� , ��ü����Ÿ	���� ����	��				             */
	/*																		                                   */
	/* 10. �����ۼ���: LG	CNS	����ö										                     */
	/* 11. �����ۼ���: 2005��12��21��										                     */
	/* 12. ����������:														                           */
	/* 13. ����������:														                           */
	/*************************************************************************/
	FUNCTION create_transfer_slip_data(	p_transfer_seq	 IN	NUMBER ,			-- ������ü�Ϸù�ȣ
										                  p_emp_no		     IN	VARCHAR2 )		-- ���
		RETURN VARCHAR2	IS														-- �Լ�	ó����� �޽���
	BEGIN


		-- >>>>>>>>>>>>>	 ó������		 <<<<<<<<<<<<<<<<<<


		RETURN(	NULL );

	END	create_transfer_slip_data;


	/*************************************************************************/
	/*																		 */
	/*	1. ���ID	 : extract_hr_pay_data									 */
	/*	2. ����̸�	 : �λ����޵���Ÿ	����									 */
	/*	3. �ý���	 : ȸ��ý���											 */
	/*	4. ����ý���: FBS													 */
	/*	5. �������	 :														 */
	/*	6. �����	 : PL/SQL												 */
	/*	7. ���ȯ��	 : Windows2003 Server+ Oracle	9.2.0						 */
	/*	8. ���DBMS	 : Oracle												 */
	/*	9. �����	���� ��	�ֿ���											 */
	/*																		 */
	/*		-	����ȭ���� ��ȸ����(�����,���޳��,���ޱ���)��	���Ͽ� ������	 */
	/*			�Է¹޾�,	HR���� VIEW��	���ؼ� ����Ÿ��	FBS��	�̰��۾��� ����	 */
	/*																		 */
	/*		-	HR�ʿ����� "�޿��̷�-�޻󿩽���(�����̷�MASTER)"(GLIS002TT)��	 */
	/*			SELECT�Ͽ�,	�ʿ䵥��Ÿ�� ��ȸ��	��,	"�������̽�_�λ�"���̺�	 */
	/*			(T_FB_INTERFACE_HR)��	INSERT�� �����Ѵ�.						 */
	/*																		 */
	/*		-	���ÿ� �������޵���Ÿ(T_FB_CASH_PAY_DATA)����	���޳����� ����	 */
	/*			INSERT�۾��� �����ϸ�, ������	PAY_SEQ��	T_FB_INTERFACE_PH��	 */
	/*			RECORD�� UPDATE�ϴ�	�۾��� �Ͽ�, �����	������ �Ѵ�.		 */
	/*																		 */
	/*		-	������ �����	����Ÿ�� �ִ�	���,	������°� "��������(T)' ��	 */
	/*			'��ǥ���(C)'��	���¿����� �ű�	�������� �����ϴ�.			 */
	/*			'���޴����(W)'	�̳� '���޿Ϸ�(P)'�� ���¿�����	�������� �Ұ�	 */
	/*																		 */
	/*		-	��ȯ��														 */
	/*			OK : ����������	����Ϸ�� =>	'��������(T)'����				 */
	/*			�����޽��� : ��Ÿ	���� �߻���	 ����	�޽���					 */
	/*																		 */
	/* 10. �����ۼ���: LG	CNS	����ö										 */
	/* 11. �����ۼ���: 2005��12��21��										 */
	/* 12. ����������:														 */
	/* 13. ����������:														 */
	/*************************************************************************/
	FUNCTION extract_hr_pay_data(	p_comp_code			IN VARCHAR2	,			 --	������ڵ�
									p_pay_ym				IN VARCHAR2	,			 --	���޿��� ���
									p_gubun				IN VARCHAR2	,			 --	����
									p_emp_no				IN VARCHAR2	,			 --	���
									p_extract_cnt			OUT	NUMBER	,			 --	�� ����	�Ǽ�
									p_extract_amt			OUT	NUMBER	)			 --	�� ����	�ݾ�
		RETURN VARCHAR2	IS													 --	�Լ� ó�����	�޽���
	BEGIN


		-- >>>>>>>>>>>>>	 ó������		 <<<<<<<<<<<<<<<<<<


		RETURN(	NULL );

	END	extract_hr_pay_data;



	/*************************************************************************/
	/*																		                                   */
	/*	1. ���ID	 : check_bill_vendor									                     */
	/*	2. ����̸�	 : ��ü��Ͻ�	���ھ����ŷ�ó�� ��ϵ�	��ü���� Ȯ��		   */
	/*	3. �ý���	 : ȸ��ý���											                         */
	/*	4. ����ý���: FBS													                         */
	/*	5. �������	 :														                           */
	/*	6. �����	 : PL/SQL												                         */
	/*	7. ���ȯ��	 : Windows2003 Server+ Oracle	9.2.0						           */
	/*	8. ���DBMS	 : Oracle												                         */
	/*	9. �����	���� ��	�ֿ���											                     */
	/*																		                                   */
	/*		-	�繫ȸ��ý��ۿ��� ��ü��Ͻ�, �ش�	��ü�� Ư�������,���࿡	   */
	/*			���ھ��� �ŷ�ó��	��ϵǾ� �ִ���	Ȯ���ϴ� �Լ�				           */
	/*																		                                   */
	/*		-	���������� "���ھ������¾�ü(T_FB_BILL_VENDORS)"���̺��� ��ȸ	   */
	/*			�Ͽ�,	�����ֱ��� ����	������� ��ȯ�մϴ�						             */
	/*																		                                   */
	/*		-	��ȯ��														                               */
	/*			OK : ����������	������ ��ü��	���							                 */
	/*			�����޽��� : ��Ÿ	���� �߻���	 ����	�޽���					             */
	/*																		                                   */
	/* 10. �����ۼ���: LG	CNS	����ö										                     */
	/* 11. �����ۼ���: 2006��	1��	5��										                     */
	/* 10. ����������: LG	CNS	����ö										                     */
	/* 11. ����������: 2006��	1��	5��										                     */
	/*************************************************************************/
	FUNCTION check_bill_vendor(	p_comp_code			IN VARCHAR2	,		 --	������ڵ�
								p_bank_code			IN VARCHAR2	,		 --	�����ڵ�
								p_bizno				IN VARCHAR2	)		 --	����ڹ�ȣ
		RETURN VARCHAR2	IS												 --	�Լ� ó�����	�޽���

		v_return_msg			VARCHAR2(300)	:= SUCCESS_CODE;
		rec_fb_bill_vendors		T_FB_BILL_VENDORS%ROWTYPE;

		ERR_PARAM_ERROR			EXCEPTION;		 --�Է¹���	PARAMTER�� ������	���.

	BEGIN

		-- �Է¹���	PARAMETER��	���� VALID�� üũ�մϴ�.
		IF p_comp_code IS	NULL or	LENGTH(p_comp_code)	=	0	THEN
			v_return_msg :=	'������ڵ尡	NULL�̰ų�,	�߸��� ���Դϴ�.';

		ELSIF	p_bank_code	IS NULL	or LENGTH(p_bank_code) = 0 THEN
			v_return_msg :=	'�����ڵ尡	NULL�̰ų�,	�߸��� ���Դϴ�.';

		ELSIF	p_bizno	IS NULL	or LENGTH(p_bizno) = 0 THEN
			v_return_msg :=	'����ڹ�ȣ��	NULL�̰ų�,	�߸��� ���Դϴ�.';
		END	IF;

		-- �ش�	�����/����/����ڹ�ȣ�� �ش��ϴ�	��ü���¸� ��ȸ�մϴ�.
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
				v_return_msg :=	'�ش�	��ü�� ����������	��ü�Դϴ�.(������:' ||	rec_fb_bill_vendors.change_ymd ||	')';
			END	IF;

		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				v_return_msg :=	'�̾����̰ų�, ����������	�����ϴ�.';

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
	/*	1. ���ID	 : send_realtime_document								 */
	/*	2. ����̸�	 : RealTimeVAN�۽�Table��	�ְ�,�����ð�����	���Ŵ��ó�� */
	/*	3. �ý���	 : ȸ��ý���											 */
	/*	4. ����ý���: FBS													 */
	/*	5. �������	 :														 */
	/*	6. �����	 : PL/SQL												 */
	/*	7. ���ȯ��	 : Windows2003 Server+ Oracle	9.2.0						 */
	/*	8. ���DBMS	 : Oracle												 */
	/*	9. �����	���� ��	�ֿ���											 */
	/*																		 */
	/*		-	parameter��	�Ѱܹ��� ����RECORD��	VAN�۽�TABLE�� INSERT��	���� */
	/*			REALTIME_TEMP_DIR��	���������� ������	��,	REALTIME_SEND_DIR��	 */
	/*			FILE MOVE��	��Ų �Ŀ�, �����ð�����	����Ͽ�,	����TABLE��		 */
	/*			���RECORD�� ����	���,	����RECORD�� ������	��Ƽ� ��ȯ�Ѵ�.	 */
	/*																		 */
	/*		-	������Ű�� ������	���� ����	������ ���Ͽ�	1��	������ �����Ǹ�	 */
	/*			�� ������	1��	�ٿ� 300Byte�� ������ü������	���� ����	����	 */
	/*																		 */
	/*		-	���ϸ� ����Ģ��	�Ʒ��� �����ϴ�. Ȯ���ڴ�	.rec ���	���δ�	 */
	/*		 ������ڵ�(2)_�����ڵ�(2)_���������ڵ�(6)_��¥(8)_������ȣ(6).rec */
	/*																		 */
	/*		-	����MOVE�� FBS_UTIL_PKG��	exec_os_command	�Լ��� ����Ͽ�		 */
	/*			ó���Ѵ�.														 */
	/*																		 */
	/*		-	timeout����	���� ���,(�ʴ���) �̰���	�����ϸ�,	NULL���� �Է�	 */
	/*			�Ǵ� ���, DEFAULT_TIMEOUT ����	����ȴ�.						 */
	/*																		 */
	/*		-	��ȯ��														 */
	/*			OK : ����������	����Ϸ�� =>	'��������(T)'����				 */
	/*			�����޽��� : ��Ÿ	���� �߻���	 ����	�޽���					 */
	/*																		 */
	/* 10. �����ۼ���: LG	CNS	����ö										 */
	/* 11. �����ۼ���: 2005��12��21��										 */
	/* 10. ����������: LG	CNS	����ö										 */
	/* 11. ����������: 2006��	1��	3��										 */
	/*************************************************************************/
	FUNCTION send_realtime_document( p_rec_send			 IN	FB_VAN_SEND_RECORD ,	 --	�۽�RECORD
									 p_timeout			 IN	NUMBER ,				 --	�ִ���ð�
									 p_rec_recv			 OUT FB_VAN_RECV_RECORD	,	 --	����RECORD
									 p_result_code	 OUT VARCHAR2	 ,			 --	ó������ڵ�
									 p_result_msg		 OUT VARCHAR2	 )			 --	ó������޽���
		RETURN VARCHAR2	IS															 --	�Լ� ó�����	�޽���

		v_return_msg			 VARCHAR2(200) :=	SUCCESS_CODE;		 --	��ȯ�޽���
		v_file_name				 VARCHAR2(100);				 --	���������̸�
		v_temp_file_path		 VARCHAR2(200);				 --	�ӽ�������ġ���
		v_send_file_path		 VARCHAR2(200);				 --	�۽�������ġ���
		v_document_buffer		 VARCHAR2(400);				 --	�������ϳ���(BUFFER)
		v_dummy_return			 VARCHAR2(100);

		d_start_dt				 DATE;						 --	���Ŵ�� ���۽ð�
		n_start_time			 NUMBER(20)	:= 0;				 --	���α׷��� ������	�ð�(�ʴ�����	ȯ��� ��)
		n_curr_time				 NUMBER(20)	:= 0;				 --	�����⸦ ���Ͽ�	���� �ð�(�ʴ����� ȯ���	��)

		v_output_file					UTL_FILE.FILE_TYPE;

		ERR_INVALID_OPERATION			EXCEPTION;			 --	�߸��� �����ΰ��...
		ERR_MAKE_TEMP_FILE_ERR			EXCEPTION;			 --	�������ϻ��� ��	������ �߻���	���...

	BEGIN

		 --	0) �Էµ�	parameter����	���� validation��	�����մϴ�.
		 ---------------------------------------------------------

		 IF	p_timeout	IS NULL	or p_timeout < 1 THEN
			 v_return_msg	:= 'TIMEOUT����	�Էµ� ����	���ڷ� 0 �̻���	���̾�� �մϴ�.';
			 RAISE ERR_INVALID_OPERATION;

		 ELSIF p_rec_send.ente_code	IS NULL	or LENGTH(p_rec_send.ente_code)	=	0	THEN
			 v_return_msg	:= '��ü�ڵ�(ENTE_CODE)��	���õ��� �ʾҽ��ϴ�.';
			 RAISE ERR_INVALID_OPERATION;

		 ELSIF p_rec_send.bank_code	IS NULL	or LENGTH(p_rec_send.bank_code)	!= 2 THEN
			 v_return_msg	:= '�����ڵ�(BANK_CODE)��	���õ��� �ʾҰų�, NULL����	�ԷµǾ����ϴ�.';
			 RAISE ERR_INVALID_OPERATION;

		 ELSIF p_rec_send.docu_code	IS NULL	or LENGTH(p_rec_send.docu_code)	!= 4 THEN
			 v_return_msg	:= '���������ڵ�(DOCU_CODE)��	���õ��� �ʾҰų�, �߸���	���� �ԷµǾ����ϴ�.';
			 RAISE ERR_INVALID_OPERATION;

		 ELSIF p_rec_send.upmu_code	IS NULL	or LENGTH(p_rec_send.upmu_code)	!= 3 THEN
			 v_return_msg	:= '���α����ڵ�(UPMU_CODE)��	���õ��� �ʾҰų�, �߸���	���� �ԷµǾ����ϴ�.';
			 RAISE ERR_INVALID_OPERATION;

		 ELSIF p_rec_send.docu_numc	IS NULL	or LENGTH(p_rec_send.docu_numc)	!= 6 THEN
			 v_return_msg	:= '������ȣ(DOCU_NUMC)��	���õ��� �ʾҰų�, �߸���	���� �ԷµǾ����ϴ�.';
			 RAISE ERR_INVALID_OPERATION;

		 ELSIF p_rec_send.send_date	IS NULL	or LENGTH(p_rec_send.send_date)	!= 8 THEN
			 v_return_msg	:= '�۽�����(SEND_DATE)��	���õ��� �ʾҰų�, �߸���	���� �ԷµǾ����ϴ�.';
			 RAISE ERR_INVALID_OPERATION;

		 ELSIF p_rec_send.gaeb_area	IS NULL	or LENGTH(p_rec_send.gaeb_area)	=	0	THEN
			 v_return_msg	:= '������(GAEB_AREA)��	���õ��� �ʾҰų�, �߸���	���� �ԷµǾ����ϴ�.';
			 RAISE ERR_INVALID_OPERATION;

		 END IF;


		-- 1)	�Ѱܹ��� SEND_RECORD�� �۽����̺�(T_FB_VAN_SEND)�� INSERT�մϴ�.
		----------------------------------------------------------------------

		BEGIN

			INSERT INTO	T_FB_VAN_SEND	VALUES p_rec_send;

		EXCEPTION
			WHEN OTHERS	THEN
				v_return_msg :=	'�۽����̺�(T_FB_VAN_SEND)�� INSERT�ϴ���	�����߻�';
				RAISE	ERR_INVALID_OPERATION;
		END;


		-- 2)	���������� ����Ģ��	���Ͽ�,	�ӽõ��丮�� �����մϴ�.
		-- ����Ģ	:	 ������ڵ�_�����ڵ�(2)_���������ڵ�(6)_��¥(8)_������ȣ(6).rec
		------------------------------------------------------------------------------

		/* ��������	OS���� directory�� �����ɴϴ�.(from	DBA_DIRECTORIES	)	*/
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
				v_return_msg :=	'��ü����������	�����ϱ����� OS	path������ �߸��Ǿ����ϴ�';
				RAISE	ERR_INVALID_OPERATION;
		END;

		/* 300byte�� ����������	buffer�� �ۼ��մϴ�. */
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

		/* ���ϸ���	����ϴ�.	*/
		v_file_name	:= v_file_name ||	p_rec_send.ente_code ||	'_'	||
										p_rec_send.bank_code ||	'_'	||
										p_rec_send.docu_code ||	p_rec_send.upmu_code ||	'_'	||
										p_rec_send.send_date ||	'_'	||
										p_rec_send.docu_numc ||	'.rec';

		/* ������	OPEN �մϴ�	.*/
		BEGIN

			v_output_file	:= UTL_FILE.FOPEN('FBS_REALTIME_TEMP_DIR', v_file_name,	'w');

		EXCEPTION
			WHEN UTL_FILE.INVALID_OPERATION	THEN
				v_return_msg :=	'�����������ϻ�����	���� ������	OPEN�ϴ��� �����߻�';
				RAISE	ERR_INVALID_OPERATION;
		END;

		/* ���ϳ�����	WRITE	�մϴ�.	*/
		BEGIN
			 UTL_FILE.PUT_LINE(	v_output_file	,	v_document_buffer	);
		EXCEPTION
			WHEN OTHERS	THEN
				v_return_msg :=	'�������ϳ���	������ ������	�߻��Ͽ�,	���ϻ����� ����	�ʾҽ��ϴ�.';
				RAISE	ERR_MAKE_TEMP_FILE_ERR;
		END;

		/* ������	�ݽ��ϴ�.	*/
		BEGIN
			UTL_FILE.FCLOSE( v_output_file );
		EXCEPTION
			WHEN OTHERS	THEN
				v_return_msg :=	'�������ϳ���	������ ������	�߻��Ͽ�,	���ϻ����� ����	�ʾҽ��ϴ�.';
				RAISE	ERR_MAKE_TEMP_FILE_ERR;
		END;


		-- 3)	OS��ɾ ����Ͽ�, SEND_DIRECTORY��	MOVE �մϴ�.
		v_dummy_return :=	fbs_util_pkg.exec_os_command(	'move	/Y '|| v_temp_file_path	|| v_file_name ||	'	'	|| v_send_file_path	|| v_file_name );


		-- 4)	�����ð����� ����ϰ�	�ִٰ�,	����table��	record�� ������, RECORD��	������ ������	�����Ѵ�.

		/* ���α׷���	������ �ð���	����մϴ�.	*/
		SELECT TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))*3600 +
				 TO_NUMBER(TO_CHAR(SYSDATE,'MI'))*60 +
				 TO_NUMBER(TO_CHAR(SYSDATE,'SS'))
			INTO n_start_time
			FROM DUAL;

		LOOP
			BEGIN

				 /*	�����ð����� ���Ű����	�Դ��� Ȯ���մϴ�. */
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

				 /*	���ŵ� �����	�ִ� ���, �۽�RECORD��	'Y'���	UPDATE����,	*/
				 /*	�����ڵ忡 �ش��ϴ�	�����ڵ���� ���ؼ�	��ȯ�Ѵ�.			*/
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
						 v_return_msg	:= '��������ڵ�['||p_rec_recv.resp_code ||']��	�̵�ϵǾ� �ֽ��ϴ�.';

					 WHEN	OTHERS THEN
						 v_return_msg	:= '��������ڵ���ȸ�� ��Ÿ�����߻�';
				 END;


				 EXIT;	-- ����������	����� ���ŵǰ�, UPDATE��	�Ϸ�Ǹ� LOOP��	����������.

			EXCEPTION
				WHEN NO_DATA_FOUND THEN

					-- timeout�ð��� �ʰ��ϴ�	���,	����������� ����������.
					SELECT TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))*3600 +
							 TO_NUMBER(TO_CHAR(SYSDATE,'MI'))*60 +
							 TO_NUMBER(TO_CHAR(SYSDATE,'SS'))
						INTO n_curr_time
						FROM DUAL;
					IF ( n_curr_time - n_start_time	)	>	p_timeout	THEN
						v_return_msg :=	'[�������]	timeout�ð�('||	p_timeout	||'��)���� �������	����Ͽ�����,	�������κ��� �������';
						EXIT;
					END	IF;

				WHEN OTHERS	THEN
					-- ��Ÿ	������ �߻��ϴ�	���..
					v_return_msg :=	'[��Ÿ����]	�������ó���� ��Ÿ����	�߻�';
					EXIT;
			END;
		END	LOOP;

		-- ����������	����ó���� ���, 'OK'���ڿ���	��ȯ�Ǹ�,	��Ÿ ������	���,	�����޽��� ��ȯ
		RETURN(	v_return_msg );

	EXCEPTION
		WHEN ERR_INVALID_OPERATION THEN
			RETURN(	v_return_msg );

		WHEN ERR_MAKE_TEMP_FILE_ERR	THEN

			-- ������	�̹� ������	���� ������	EXCEPTION�̹Ƿ�, ��	������ �����ϴ�	����
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
	/*	��� : ������ڵ�	�� ����	�ڵ� ���ϱ�										*/
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
			FBS_UTIL_PKG.write_log('����������ȸ','Ʈ����	ȣ�� ��	���������� ã��	�� �����ϴ�. ����:'||Ar_ACCOUNT_NO);
			Raise;
		Exception	When Others	Then
			Raise;
		End;
	End;

	/******************************************************************************/
	/*	��� : Van ����	Ʈ���� ó��	�ܾ���ȸ										*/
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
		ltNums(1)	:=	15;	--1.���¹�ȣ
		ltNums(2)	:=	 1;	--2.��ȣ
		ltNums(3)	:=	13;	--3.�����ܾ�
		ltNums(4)	:=	13;	--4.���ް��ɾ�
		ltNums(5)	:= 158;	--5.����
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
			FBS_UTIL_PKG.write_log('�ܾ���ȸ','����:'||lrRec.ACCOUNT_NO||' '||SqlErrm);
		Exception	When Others	Then
			Null;
		End;
	End;



	/******************************************************************************/
	/*	��� : Van ����	Ʈ���� ó��	���ݰŷ���										*/
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
		ltNums(1)	:=	15;	--1.���¹�ȣ
		ltNums(2)	:=	 2;	--2.�ŷ�����
		ltNums(3)	:=	 2;	--3.�����ڵ�
		ltNums(4)	:=	13;	--4.�ŷ��ݾ�
		ltNums(5)	:=	13;	--5.�ŷ��� �ܾ�
		ltNums(6)	:=	 6;	--6.�����ڵ�
		ltNums(7)	:=	16;	--7.����
		ltNums(8)	:=	10;	--8.��ǥ��ȣ
		ltNums(9)	:=	16;	--9.�ŷ�ó�ڵ�(CMS)
		ltNums(10):=	 8;	--10.�ŷ�����
		ltNums(11):=	 6;	--11.�ŷ��ð�
		ltNums(12):=	13;	--12.���ݼ�
		ltNums(13):=	13;	--13.�����ǥ
		ltNums(14):=	13;	--14.Ÿ����
		ltNums(15):=	 6;	--15.�ŷ��Ϸù�ȣ
		ltNums(16):=	 6;	--16.��ҽ��Ϸù�ȣ
		ltNums(17):=	 8;	--17.��ҽðŷ�����
		ltNums(18):=	 1;	--18.�ŷ���	�ܾ׺�ȣ
		ltNums(19):=	33;	--19.����
		ltVars :=	SplitDocu(Ar_Recv.gaeb_area,ltNums);

		lrRec.BANK_CODE		:=		ltVars(3);		--3.�����ڵ�
		lrRec.ACCOUNT_NO	:=		Trim(ltVars(1));--1.���¹�ȣ
		lrRec.TRADE_YMD		:=		ltVars(10);		--10.�ŷ�����
		lrRec.DOCU_NUMC		:=		ltVars(15);		--15.�ŷ��Ϸù�ȣ
		lrRec.TRX_GUBUN		:=		Trim(ltVars(2));--2.�ŷ�����
		lrRec.TRADE_TIME	:=		ltVars(11);		--11.�ŷ��ð�
		If lrRec.TRX_GUBUN In	(	'20','21','40','51') Then	--�Ա�����(�Ա�,�߽��Ա�,�������,�Ա����)
			lrRec.RECV_AMT		:=		To_Number(ltVars(4));		--4.�ŷ��ݾ�
		ElsIf	lrRec.TRX_GUBUN	In ( '30','31','52') Then	--��������(����,�ε�����,�������)
			lrRec.PAY_AMT		:=		To_Number(ltVars(4));		--4.�ŷ��ݾ�
		End	If;
		lsSign				:=		ltVars(18);		--18.�ŷ���	�ܾ׺�ȣ
		If lsSign	=	'-'	Then
			lrRec.REMAIN_AMT	:=		-	To_Number(ltVars(5));		--5.�ŷ��� �ܾ�
		Else
			lrRec.REMAIN_AMT	:=		To_Number(ltVars(5));		--5.�ŷ��� �ܾ�
		End	If;
		lnTaAmt				:=		Nvl(To_Number(ltVars(14)),0);						--14.Ÿ����
		lrRec.ENABLE_AMT	:=		Nvl(lrRec.REMAIN_AMT,0)	-	lnTaAmt;
		lrRec.IN_OUT_NAME	:=		GetSingleBytes(ltVars(7));							--7.����
		lrRec.DESCRIPTION	:=		Null;
		lrRec.CMS_CODE		:=		Trim(ltVars(9));													--9.�ŷ�ó�ڵ�(CMS)
		lrRec.CANCEL_DOCU_NUM	:=	ltVars(16);		--16.��ҽ��Ϸù�ȣ
		lrRec.CANCEL_TRADE_YMD	:=	ltVars(17);		--17.��ҽðŷ�����
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
			FBS_UTIL_PKG.write_log('���ݰŷ�������','����:'||lrRec.ACCOUNT_NO||' '||SqlErrm);
		Exception	When Others	Then
			Null;
		End;
	End;
	/******************************************************************************/
	/*	��� : Van ����	Ʈ���� ó��	�����ŷ���									*/
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
		ltNums(1)	:=	 2;	--1.�ŷ�����
		ltNums(2)	:=	15;	--2.���¹�ȣ
		ltNums(3)	:=	 8;	--3.�ŷ�����
		ltNums(4)	:=	 6;	--4.�ŷ��ð�
		ltNums(5)	:=	10;	--5.������ȣ
		ltNums(6)	:=	13;	--6.�ݾ�
		ltNums(7)	:=	14;	--7.������
		ltNums(8)	:=	 8;	--8.������
		ltNums(9)	:=	16;	--9.�������������
		ltNums(10) :=	16;	--10.CMS
		ltNums(11) :=	 3;	--11.�׸񺯰��ڵ�
		ltNums(12) :=	13;	--12.�ܾ�
		ltNums(13) :=	 6;	--13.�����ڵ�
		ltNums(14) :=	 6;	--14.���ŷ�������ȣ
		ltNums(15) :=	 6;	--15.�Ϸù�ȣ
		ltNums(16) :=	 6;	--16.��ҽ��Ϸù�ȣ
		ltNums(17):=	 8;	--17.��ҽðŷ�����
		ltNums(18):=	44;	--18.����

		ltVars :=	SplitDocu(Ar_Recv.gaeb_area,ltNums);

		lrRec.ACCOUNT_NO	:=		Trim(ltVars(2));		--2.���¹�ȣ
		lrRec.TRADE_YMD		:=		ltVars(3);				--3.�ŷ�����
		lrRec.DOCU_NUMC		:=		ltVars(15);				--15.�ŷ��Ϸù�ȣ
		lrRec.TRX_GUBUN		:=		Trim(ltVars(1));			--1.�ŷ�����
		lrRec.TRADE_TIME	:=		ltVars(4);				--4.�ŷ��ð�
		lrRec.BILL_NO		:=		Trim(ltVars(5));		--5.������ȣ
		lrRec.ISSUE_NAME	:=		GetSingleBytes(ltVars(7));		--7.������
		lrRec.FUTURE_PAY_DUE_YMD	:=		ltVars(8);		--8.������
		--������������� ó��	���� lrRec.FUTURE_PAY_BANK_CODE
		lrRec.AMOUNT		:=		To_Number(ltVars(6));	--6.�ݾ�
		lrRec.REMAIN_AMT	:=		To_Number(ltVars(12));	--12.�ܾ�
		lrRec.CMS_CODE		:=		Trim(ltVars(10));		--10.CMS
		lrRec.GIRO_CODE		:=		Trim(ltVars(13));		--13.�����ڵ�
		lrRec.CANCEL_DOCU_NUM	:=	ltVars(16);		--16.��ҽ��Ϸù�ȣ
		lrRec.CANCEL_TRADE_YMD	:=	ltVars(17);		--17.��ҽðŷ�����

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
			FBS_UTIL_PKG.write_log('�����ŷ�������','����:'||lrRec.ACCOUNT_NO||' '||SqlErrm);
		Exception	When Others	Then
			Null;
		End;
	End;
	/******************************************************************************/
	/*	��� : Van ����	Ʈ���� ó��	Ÿ����ü�Ҵ�									*/
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
		ltNums(1)	:=	 6;	--1.���ŷ�������ȣ
		ltNums(2)	:=	15;	--2.��ݰ��¹�ȣ
		ltNums(3)	:=	15;	--3.�Աݰ��¹�ȣ
		ltNums(4)	:=	 2;	--4.�Ա������ڵ�
		ltNums(5)	:=	13;	--5.�Ƿڱݾ�
		ltNums(6)	:=	13;	--6.��ó���ݾ�
		ltNums(7)	:=	 3;	--7.�����ڵ�
		ltNums(8)	:= 133;	--8.����

		ltVars :=	SplitDocu(Ar_Recv.gaeb_area,ltNums);

		lsOrgDocuNo		:=		ltVars(1);							--1.���ŷ�������ȣ
		lsOutAccNo		:=		Trim(ltVars(2));					--2.��ݰ��¹�ȣ
		lsInAccNo		:=		Trim(ltVars(3));					--3.�Աݰ��¹�ȣ
		lsInBankCode	:=		ltVars(4);							--4.�Ա������ڵ�
		lnAmt			:=		To_Number(ltVars(5));				--5.�Ƿڱݾ�
		lnNAmt			:=		To_Number(ltVars(6));				--6.��ó���ݾ�
		lsErrCode		:=		Trim(ltVars(7));					--7.�����ڵ�

		GetCompAndBankCode(lsOutAccNo,lsCompCode,lsBankCode);

		--1	���� ����	��¥�� �ش�	�� �ŷ���	ã�ƺ���.
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
		Exception	When No_Data_Found Then		--�����δ� Max���Ǵ� No_Data_Found�� Ÿ��	�ʴ´�..
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
			Exception	When No_Data_Found Then		--�����δ� Max���Ǵ� No_Data_Found�� Ÿ��	�ʴ´�..
				lnPAY_SEQ	:= Null;
				lnDIV_SEQ	:= Null;
				lnTRX_SEQ	:= Null;
			End;
			If lnPAY_SEQ Is	Null Then
				Begin
					FBS_UTIL_PKG.write_log('��ü�Ҵ�����','��ݰ���:'||lsOutAccNo||' �Աݰ���:'	|| lsInAccNo||'	������ȣ :'||lsOrgDocuNo||'��	�� �ŷ���	ã�� ��	�����ϴ�.');
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
							When Count(*)	=	1	And	Count(Decode(b.PAY_SUCCESS_YN,'Y',1))	<> 1 Then	--�ѰǼ��� 1�̰� �����Ǽ���	1��	�ƴϸ� ����
								5
							When Count(*)	>	1	And	Count(Decode(b.PAY_SUCCESS_YN,'Y',1))	<	Count(*) Then		--�ѰǼ��� 1���� ũ��	�����Ǽ��� �׺���	������ �Ϻν���
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
			FBS_UTIL_PKG.write_log('��ü�Ҵ�����','��ݰ���:'||lsOutAccNo||' �Աݰ���:'	|| lsInAccNo||'	������ȣ :'||lsOrgDocuNo||'	'||SqlErrm);
		Exception	When Others	Then
			Null;
		End;
	End;
	/******************************************************************************/
	/*	��� : Van ����	Ʈ���� ó��	Ÿ�Ӿƿ��� ��üó����							*/
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
		ltNums(1)	:=	15;	--1.��ݰ��¹�ȣ
		ltNums(2)	:=	 8;	--2.�����й�ȣ
		ltNums(3)	:=	 6;	--3.�����ȣ
		ltNums(4)	:=	13;	--4.��ݱݾ�
		ltNums(5)	:=	 1;	--5.������ܾ׺�ȣ
		ltNums(6)	:=	13;	--6.������ܾ�
		ltNums(7)	:=	 2;	--7.�Ա������ڵ�
		ltNums(8)	:=	15;	--8.�Աݰ���
		ltNums(9)	:=	13;	--9.��ü������
		ltNums(10):=	 6;	--10.CMS
		ltNums(11):=	22;	--11.�ӱ��μ���
		ltNums(12):=	14;	--12.�Ա�����������
		ltNums(13):=	72;	--13.����

		ltVars :=	SplitDocu(Ar_Recv.gaeb_area,ltNums);

		lrData.out_account_no		:=		Trim(ltVars(1));				/*	���ް���					 */
		lrData.account_pw			:=		Trim(ltVars(2));				/*	������(4)+��ü���(4)		 */
		lrData.sign_no				:=		Trim(ltVars(3));				/*	�����ȣ					 */
		lrData.trade_amt			:=		To_Number(ltVars(4));			/*	��ݱݾ�					 */
		lrData.remain_sign			:=		ltVars(5);						/*	��� ��, �ܾ׺�ȣ			 */
		lrData.remain_amt			:=		To_Number(ltVars(6));			/*	���� �ܾ�					 */
		lrData.in_bank_cd			:=		ltVars(7);						/*	�Ա������ڵ�				 */
		lrData.in_account_no		:=		Trim(ltVars(8));				/*	�Աݰ���					 */
		lrData.commission			:=		To_Number(ltVars(9));			/*	��ü������					 */
		lrData.cms					:=		Trim(ltVars(10));				/*	CMS�ڵ�(�ŷ�ó�ڵ�)			 */

		lsOrgDocuNo		:=		Ar_Recv.docu_numc;
		lsOutAccNo		:=		lrData.out_account_no;
		lsInAccNo		:=		lrData.in_account_no;
		lsInBankCode	:=		lrData.in_bank_cd;

		--1	���� ����	��¥�� �ش�	�� �ŷ���	ã�ƺ���.
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
		Exception	When No_Data_Found Then		--�����δ� Max���Ǵ� No_Data_Found�� Ÿ��	�ʴ´�..
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
			Exception	When No_Data_Found Then		--�����δ� Max���Ǵ� No_Data_Found�� Ÿ��	�ʴ´�..
				lnPAY_SEQ	:= Null;
				lnDIV_SEQ	:= Null;
				lnTRX_SEQ	:= Null;
			End;
			If lnPAY_SEQ Is	Null Then
				Begin
					FBS_UTIL_PKG.write_log('Ÿ�Ӿƿ���üó��','��ݰ���:'||lsOutAccNo||' �Աݰ���:'	|| lsInAccNo||'	������ȣ :'||lsOrgDocuNo||'��	�� �ŷ���	ã�� ��	�����ϴ�.');
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
							When Count(*)	=	1	And	Count(Decode(b.PAY_SUCCESS_YN,'Y',1))	<> 1 Then	--�ѰǼ��� 1�̰� �����Ǽ���	1��	�ƴϸ� ����
								5
							When Count(*)	>	1	And	Count(Decode(b.PAY_SUCCESS_YN,'Y',1))	<	Count(*) Then		--�ѰǼ��� 1���� ũ��	�����Ǽ��� �׺���	������ �Ϻν���
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
			FBS_UTIL_PKG.write_log('Ÿ�Ӿƿ���üó��','��ݰ���:'||lsOutAccNo||' �Աݰ���:'	|| lsInAccNo||'	������ȣ :'||lsOrgDocuNo||'	'||SqlErrm);
		Exception	When Others	Then
			Null;
		End;
	End;
	/******************************************************************************/
	/*	��� : Van ����	Ʈ���� ó��	�о��������̽����̺� ����						*/
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
	/*	��� : Van ����	Ʈ���� ó��	�о�->���ݰŷ�������							*/
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
		ltNums(1)	:=	15;	--1.���¹�ȣ
		ltNums(2)	:=	 2;	--2.�ŷ�����
		ltNums(3)	:=	 2;	--3.�����ڵ�
		ltNums(4)	:=	13;	--4.�ŷ��ݾ�
		ltNums(5)	:=	13;	--5.�ŷ��� �ܾ�
		ltNums(6)	:=	 6;	--6.�����ڵ�
		ltNums(7)	:=	16;	--7.����
		ltNums(8)	:=	10;	--8.��ǥ��ȣ
		ltNums(9)	:=	16;	--9.�ŷ�ó�ڵ�(CMS)
		ltNums(10):=	 8;	--10.�ŷ�����
		ltNums(11):=	 6;	--11.�ŷ��ð�
		ltNums(12):=	13;	--12.���ݼ�
		ltNums(13):=	13;	--13.�����ǥ
		ltNums(14):=	13;	--14.Ÿ����
		ltNums(15):=	 6;	--15.�ŷ��Ϸù�ȣ
		ltNums(16):=	 6;	--16.��ҽ��Ϸù�ȣ
		ltNums(17):=	 8;	--17.��ҽðŷ�����
		ltNums(18):=	 1;	--18.�ŷ���	�ܾ׺�ȣ
		ltNums(19):=	 1;	--19.����	���ܴ��⿩��
		ltNums(20):=	 8;	--20.����	��ȣ
		ltNums(21):=	24;	--21.����

		ltVars :=	SplitDocu(Ar_Recv.gaeb_area,ltNums);

		lrRec.account_no		:=				Trim(ltVars(1));					/*	�Աݰ��¹�ȣ				 */
		lrRec.trade_gb			:=				Trim(ltVars(2));					/*	�ŷ�����					 */
		lrRec.bank_cd			:=				Trim(ltVars(3));					/*	�ŷ����������ڵ�			 */
		lrRec.trade_amt			:=				To_Number(Trim(ltVars(4)));			/*	�ŷ��ݾ�					 */
		lrRec.remain_amt		:=				To_Number(Trim(ltVars(5)));			/*	�ŷ� ��, �ܾ�				 */
		lrRec.giro_cd			:=				Trim(ltVars(6));					/*	�����ڵ�					 */
		lrRec.depo_nm			:=				GetSingleBytes(ltVars(7));			/*	�Ա��� ����					 */
		lrRec.check_no			:=				Trim(ltVars(8));					/*	���� ��	��ǥ��ȣ			 */
		lrRec.cms				:=				Trim(ltVars(9));					/*	CMS�ڵ�(�ŷ�ó�ڵ�)			 */
		lrRec.trade_dt			:=				Trim(ltVars(10));					/*	�ŷ�����					 */
		lrRec.trade_time		:=				Trim(ltVars(11));					/*	�ŷ��ð�					 */
		lrRec.cash_amt			:=				To_Number(Trim(ltVars(12)));		/*	����						 */
		lrRec.check_amt			:=				To_Number(Trim(ltVars(13)));		/*	�����ǥ					 */
		lrRec.ta_check_amt		:=				To_Number(Trim(ltVars(14)));		/*	��ȯ��,	���Ⱑ�ɱݾ�		 */
		lrRec.trade_no			:=				Trim(ltVars(15));					/*	�ŷ��� �Ϸù�ȣ	�߰�		 */
		lrRec.cancel_trade_no	:=				Trim(ltVars(16));					/*	��ҽ� �ηù�ȣ	�߰�		 */
		lrRec.cancel_trade_dt	:=				Trim(ltVars(17));					/*	��ҽ� �ŷ�����	�߰�		 */
		lrRec.remain_sign		:=				Trim(ltVars(18));					/*	�����(�ܾ׺�ȣ)			 */
		lrRec.loan_yn			:=				Trim(ltVars(19));					/*	�����(���ܴ��⿩��)(����) */
		lrRec.dong_ho			:=				Trim(ltVars(20));					/*	����(��ȣ)					 */

		If lrRec.trade_gb	Not	In ('20','51') Then
			Return;
		End	If;

		If lrRec.remain_sign = '-' Then
			lrRec.remain_amt :=	-	lrRec.remain_amt;
		End	If;


		lrData.ACCOUNT_NO		:=				lrRec.account_no;
		lrData.ACCT_TYPE_GUBUN	:=				'1';				-- �Ϲݰ���	�����ڵ�:1
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
		-- �Ա�(20)	,	�Ա����(51)�� ����	���� ó��
		----------------------------------------------------------
		If lrRec.trade_gb	=	'51' THEN		 --	�Ա������ ����	(-)	�ݾ� ó��
			lrData.RECV_AMT	:= - lrData.RECV_AMT;

		-- ������	INTERFACE��	������ A_FB_INTERFACE_PH���� �����	���������� ã�Ƽ�
		-- ����������	�����ͼ� �����մϴ�.
			BEGIN
				SELECT
					A.ACCT_HOLDER_NAME,	-- ���ŷ�	�����ָ�
					A.LOAD_YN,			-- ���ŷ�, ��������
					A.DONGHO				-- ���ŷ�, ��ȣ
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
				NULL;	 --	�ش� �����Աݳ�����	��ã�� ����,���ŵ� ����	�״�� �����Ѵ�.
			END;

		END	IF;


		process_trg_ins_hsms(lrData);
	Exception	When Others	Then
		Begin
			FBS_UTIL_PKG.write_log('�о���Ա�ó��','�Աݰ���:'||lrRec.account_no||' �Ա�����:'	|| lrRec.trade_dt||' ��ȣ	:'||RTRIM(TRIM(lrRec.dong_ho),'0')||
									'	������ȣ :'||lrRec.trade_no||' '||SqlErrm);
		Exception	When Others	Then
			Null;
		End;
	End;

	/******************************************************************************/
	/*	��� : Van ����	Ʈ���� ó��	�о�->���ݰŷ��������							*/
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
		ltNums(1)	:=	15;	--1.���¹�ȣ
		ltNums(2)	:=	 2;	--2.�ŷ�����
		ltNums(3)	:=	 2;	--3.�����ڵ�
		ltNums(4)	:=	13;	--4.�ŷ��ݾ�
		ltNums(5)	:=	13;	--5.�ŷ��� �ܾ�
		ltNums(6)	:=	 6;	--6.�����ڵ�
		ltNums(7)	:=	16;	--7.����
		ltNums(8)	:=	10;	--8.��ǥ��ȣ
		ltNums(9)	:=	16;	--9.�ŷ�ó�ڵ�(CMS)
		ltNums(10):=	 8;	--10.�ŷ�����
		ltNums(11):=	 6;	--11.�ŷ��ð�
		ltNums(12):=	13;	--12.���ݼ�
		ltNums(13):=	13;	--13.�����ǥ
		ltNums(14):=	13;	--14.Ÿ����
		ltNums(15):=	 6;	--15.���ŷ�������ȣ
		ltNums(16):=	 6;	--16.�ŷ��Ϸù�ȣ
		ltNums(17):=	 6;	--17.��ҽ��Ϸù�ȣ
		ltNums(18):=	 8;	--18.��ҽðŷ�����
		ltNums(19):=	 1;	--19.�ŷ���	�ܾ׺�ȣ
		ltNums(20):=	 1;	--20.����	���ܴ��⿩��
		ltNums(21):=	 8;	--21.����	��ȣ
		ltNums(22):=	18;	--22.����

		ltVars :=	SplitDocu(Ar_Recv.gaeb_area,ltNums);

		lrRec.account_no		:=				Trim(ltVars(1));					/*	�Աݰ��¹�ȣ				 */
		lrRec.trade_gb			:=				Trim(ltVars(2));					/*	�ŷ�����					 */
		lrRec.bank_cd			:=				Trim(ltVars(3));					/*	�ŷ����������ڵ�			 */
		lrRec.trade_amt			:=				To_Number(Trim(ltVars(4)));			/*	�ŷ��ݾ�					 */
		lrRec.remain_amt		:=				To_Number(Trim(ltVars(5)));			/*	�ŷ� ��, �ܾ�				 */
		lrRec.giro_cd			:=				Trim(ltVars(6));					/*	�����ڵ�					 */
		lrRec.depo_nm			:=				GetSingleBytes(ltVars(7));			/*	�Ա��� ����					 */
		lrRec.check_no			:=				Trim(ltVars(8));					/*	���� ��	��ǥ��ȣ			 */
		lrRec.cms				:=				Trim(ltVars(9));					/*	CMS�ڵ�(�ŷ�ó�ڵ�)			 */
		lrRec.trade_dt			:=				Trim(ltVars(10));					/*	�ŷ�����					 */
		lrRec.trade_time		:=				Trim(ltVars(11));					/*	�ŷ��ð�					 */
		lrRec.cash_amt			:=				To_Number(Trim(ltVars(12)));		/*	����						 */
		lrRec.check_amt			:=				To_Number(Trim(ltVars(13)));		/*	�����ǥ					 */
		lrRec.ta_check_amt		:=				To_Number(Trim(ltVars(14)));		/*	��ȯ��,	���Ⱑ�ɱݾ�		 */
		lrRec.org_docu_numc		:=				Trim(ltVars(15));					/*	���ŷ�������ȣ �߰�			 */
		lrRec.trade_no			:=				Trim(ltVars(16));					/*	�ŷ��� �Ϸù�ȣ	�߰�		 */
		lrRec.cancel_trade_no	:=				Trim(ltVars(17));					/*	��ҽ� �ηù�ȣ	�߰�		 */
		lrRec.cancel_trade_dt	:=				Trim(ltVars(18));					/*	��ҽ� �ŷ�����	�߰�		 */
		lrRec.remain_sign		:=				Trim(ltVars(19));					/*	�����(�ܾ׺�ȣ)			 */
		lrRec.loan_yn			:=				Trim(ltVars(20));					/*	�����(���ܴ��⿩��)(����) */
		lrRec.dong_ho			:=				Trim(ltVars(21));					/*	����(��ȣ)					 */

		If lrRec.trade_gb	Not	In ('20','51') Then
			Return;
		End	If;

		If lrRec.remain_sign = '-' Then
			lrRec.remain_amt :=	-	lrRec.remain_amt;
		End	If;


		lrData.ACCOUNT_NO		:=				lrRec.account_no;
		lrData.ACCT_TYPE_GUBUN	:=				'1';				-- �Ϲݰ���	�����ڵ�:1
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
		-- �Ա�(20)	,	�Ա����(51)�� ����	���� ó��
		----------------------------------------------------------
		If lrRec.trade_gb	=	'51' THEN		 --	�Ա������ ����	(-)	�ݾ� ó��
			lrData.RECV_AMT	:= - lrData.RECV_AMT;

		-- ������	INTERFACE��	������ A_FB_INTERFACE_PH���� �����	���������� ã�Ƽ�
		-- ����������	�����ͼ� �����մϴ�.
			BEGIN
				SELECT
					A.ACCT_HOLDER_NAME,	-- ���ŷ�	�����ָ�
					A.LOAD_YN,			-- ���ŷ�, ��������
					A.DONGHO				-- ���ŷ�, ��ȣ
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
				NULL;	 --	�ش� �����Աݳ�����	��ã�� ����,���ŵ� ����	�״�� �����Ѵ�.
			END;

		END	IF;


		process_trg_ins_hsms(lrData);
	Exception	When Others	Then
		Begin
			FBS_UTIL_PKG.write_log('�о���Ա�ó��','�Աݰ���:'||lrRec.account_no||' �Ա�����:'	|| lrRec.trade_dt||' ��ȣ	:'||RTRIM(TRIM(lrRec.dong_ho),'0')||
									'	������ȣ :'||lrRec.trade_no||' '||SqlErrm);
		Exception	When Others	Then
			Null;
		End;
	End;
	/******************************************************************************/
	/*	��� : Van ����	Ʈ���� ó��	�о�->������°ŷ���							*/
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
		ltNums(1)	:=	15;	--1.���¹�ȣ
		ltNums(2)	:=	 2;	--2.�ŷ�����
		ltNums(3)	:=	 2;	--3.�����ڵ�
		ltNums(4)	:=	13;	--4.�ŷ��ݾ�
		ltNums(5)	:=	13;	--5.�ŷ��� �ܾ�
		ltNums(6)	:=	 6;	--6.�����ڵ�
		ltNums(7)	:=	16;	--7.����
		ltNums(8)	:=	10;	--8.��ǥ��ȣ
		ltNums(9)	:=	16;	--9.�ŷ�ó�ڵ�(CMS)
		ltNums(10):=	 8;	--10.�ŷ�����
		ltNums(11):=	 6;	--11.�ŷ��ð�
		ltNums(12):=	13;	--12.���ݼ�
		ltNums(13):=	13;	--13.�����ǥ
		ltNums(14):=	13;	--14.Ÿ����
		ltNums(15):=	 6;	--15.�ŷ��Ϸù�ȣ
		ltNums(16):=	 6;	--16.��ҽ��Ϸù�ȣ
		ltNums(17):=	 8;	--17.��ҽðŷ�����
		ltNums(18):=	 1;	--18.�ŷ���	�ܾ׺�ȣ
		ltNums(19):=	13;	--19.�ֹι�ȣ
		ltNums(20):=	 1;	--20.����	���⿩��
		ltNums(20):=	19;	--21.����

		ltVars :=	SplitDocu(Ar_Recv.gaeb_area,ltNums);

		lrRec.account_no		:=				Trim(ltVars(1));					/*	�Աݰ��¹�ȣ				 */
		lrRec.trade_gb			:=				Trim(ltVars(2));					/*	�ŷ�����					 */
		lrRec.bank_cd			:=				Trim(ltVars(3));					/*	�ŷ����������ڵ�			 */
		lrRec.trade_amt			:=				To_Number(Trim(ltVars(4)));			/*	�ŷ��ݾ�					 */
		lrRec.remain_amt		:=				To_Number(Trim(ltVars(5)));			/*	�ŷ� ��, �ܾ�				 */
		lrRec.giro_cd			:=				Trim(ltVars(6));					/*	�����ڵ�					 */
		lrRec.depo_nm			:=				GetSingleBytes(ltVars(7));			/*	�Ա��� ����					 */
		lrRec.check_no			:=				Trim(ltVars(8));					/*	���� ��	��ǥ��ȣ			 */
		lrRec.cms				:=				Trim(ltVars(9));					/*	CMS�ڵ�(�ŷ�ó�ڵ�)			 */
		lrRec.trade_dt			:=				Trim(ltVars(10));					/*	�ŷ�����					 */
		lrRec.trade_time		:=				Trim(ltVars(11));					/*	�ŷ��ð�					 */
		lrRec.cash_amt			:=				To_Number(Trim(ltVars(12)));		/*	����						 */
		lrRec.check_amt			:=				To_Number(Trim(ltVars(13)));		/*	�����ǥ					 */
		lrRec.ta_check_amt		:=				To_Number(Trim(ltVars(14)));		/*	��ȯ��,	���Ⱑ�ɱݾ�		 */
		lrRec.trade_no			:=				Trim(ltVars(15));					/*	�ŷ��� �Ϸù�ȣ	�߰�		 */
		lrRec.cancel_trade_no	:=				Trim(ltVars(16));					/*	��ҽ� �ηù�ȣ	�߰�		 */
		lrRec.cancel_trade_dt	:=				Trim(ltVars(17));					/*	��ҽ� �ŷ�����	�߰�		 */
		lrRec.remain_sign		:=				Trim(ltVars(18));					/*	�����(�ܾ׺�ȣ)			 */
		lrRec.jumin_no			:=				Trim(ltVars(19));					/*	�ֹι�ȣ						 */
		lrRec.loan_yn			:=				Trim(ltVars(20));					/*	�����(���ܴ��⿩��)(����) */

		If lrRec.trade_gb	Not	In ('20','51') Then
			Return;
		End	If;

		If lrRec.remain_sign = '-' Then
			lrRec.remain_amt :=	-	lrRec.remain_amt;
		End	If;


		lrData.ACCOUNT_NO		:=				lrRec.account_no;
		lrData.ACCT_TYPE_GUBUN	:=				'2';				-- �������	�����ڵ�:2
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
		-- �Ա�(20)	,	�Ա����(51)�� ����	���� ó��
		----------------------------------------------------------
		If lrRec.trade_gb	=	'51' THEN		 --	�Ա������ ����	(-)	�ݾ� ó��
			lrData.RECV_AMT	:= - lrData.RECV_AMT;
		END	IF;


		process_trg_ins_hsms(lrData);
	Exception	When Others	Then
		Begin
			FBS_UTIL_PKG.write_log('�о���Ա�ó��','�Աݰ���:'||lrRec.account_no||' �Ա�����:'	|| lrRec.trade_dt||' �ֹι�ȣ	:'||RTRIM(TRIM(lrRec.jumin_no),'0')||
									'	������ȣ :'||lrRec.trade_no||' '||SqlErrm);
		Exception	When Others	Then
			Null;
		End;
	End;
	/******************************************************************************/
	/*	��� : Van ����	Ʈ���� ó��	�о�->������°����û							*/
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
		ltNums(1)	:=	15;	--1.���¹�ȣ
		ltNums(2)	:=	 2;	--2.�ŷ�����
		ltNums(3)	:=	 2;	--3.�����ڵ�
		ltNums(4)	:=	13;	--4.�ŷ��ݾ�
		ltNums(5)	:=	13;	--5.�ŷ��� �ܾ�
		ltNums(6)	:=	 6;	--6.�����ڵ�
		ltNums(7)	:=	16;	--7.����
		ltNums(8)	:=	10;	--8.��ǥ��ȣ
		ltNums(9)	:=	16;	--9.�ŷ�ó�ڵ�(CMS)
		ltNums(10):=	 8;	--10.�ŷ�����
		ltNums(11):=	 6;	--11.�ŷ��ð�
		ltNums(12):=	13;	--12.���ݼ�
		ltNums(13):=	13;	--13.�����ǥ
		ltNums(14):=	13;	--14.Ÿ����
		ltNums(15):=	 6;	--15.�ŷ��Ϸù�ȣ
		ltNums(16):=	 6;	--16.��ҽ��Ϸù�ȣ
		ltNums(17):=	 8;	--17.��ҽðŷ�����
		ltNums(18):=	 1;	--18.�ŷ���	�ܾ׺�ȣ
		ltNums(19):=	13;	--19.�ֹι�ȣ
		ltNums(20):=	 1;	--20.����	���⿩��
		ltNums(20):=	19;	--21.����

		ltVars :=	SplitDocu(Ar_Recv.gaeb_area,ltNums);

		lrRec.account_no		:=				Trim(ltVars(1));					/*	�Աݰ��¹�ȣ				 */
		lrRec.trade_gb			:=				Trim(ltVars(2));					/*	�ŷ�����					 */
		lrRec.bank_cd			:=				Trim(ltVars(3));					/*	�ŷ����������ڵ�			 */
		lrRec.trade_amt			:=				To_Number(Trim(ltVars(4)));			/*	�ŷ��ݾ�					 */
		lrRec.remain_amt		:=				To_Number(Trim(ltVars(5)));			/*	�ŷ� ��, �ܾ�				 */
		lrRec.giro_cd			:=				Trim(ltVars(6));					/*	�����ڵ�					 */
		lrRec.depo_nm			:=				GetSingleBytes(ltVars(7));			/*	�Ա��� ����					 */
		lrRec.check_no			:=				Trim(ltVars(8));					/*	���� ��	��ǥ��ȣ			 */
		lrRec.cms				:=				Trim(ltVars(9));					/*	CMS�ڵ�(�ŷ�ó�ڵ�)			 */
		lrRec.trade_dt			:=				Trim(ltVars(10));					/*	�ŷ�����					 */
		lrRec.trade_time		:=				Trim(ltVars(11));					/*	�ŷ��ð�					 */
		lrRec.cash_amt			:=				To_Number(Trim(ltVars(12)));		/*	����						 */
		lrRec.check_amt			:=				To_Number(Trim(ltVars(13)));		/*	�����ǥ					 */
		lrRec.ta_check_amt		:=				To_Number(Trim(ltVars(14)));		/*	��ȯ��,	���Ⱑ�ɱݾ�		 */
		lrRec.trade_no			:=				Trim(ltVars(15));					/*	�ŷ��� �Ϸù�ȣ	�߰�		 */
		lrRec.cancel_trade_no	:=				Trim(ltVars(16));					/*	��ҽ� �ηù�ȣ	�߰�		 */
		lrRec.cancel_trade_dt	:=				Trim(ltVars(17));					/*	��ҽ� �ŷ�����	�߰�		 */
		lrRec.remain_sign		:=				Trim(ltVars(18));					/*	�����(�ܾ׺�ȣ)			 */
		lrRec.jumin_no			:=				Trim(ltVars(19));					/*	�ֹι�ȣ						 */
		lrRec.loan_yn			:=				Trim(ltVars(20));					/*	�����(���ܴ��⿩��)(����) */

		If lrRec.trade_gb	Not	In ('20','51') Then
			Return;
		End	If;

		If lrRec.remain_sign = '-' Then
			lrRec.remain_amt :=	-	lrRec.remain_amt;
		End	If;


		lrData.ACCOUNT_NO		:=				lrRec.account_no;
		lrData.ACCT_TYPE_GUBUN	:=				'2';				-- �������	�����ڵ�:1
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
		-- �Ա�(20)	,	�Ա����(51)�� ����	���� ó��
		----------------------------------------------------------
		If lrRec.trade_gb	=	'51' THEN		 --	�Ա������ ����	(-)	�ݾ� ó��
			lrData.RECV_AMT	:= - lrData.RECV_AMT;
		END	IF;


		process_trg_ins_hsms(lrData);
	Exception	When Others	Then
		Begin
			FBS_UTIL_PKG.write_log('�о���Ա�ó��','�Աݰ���:'||lrRec.account_no||' �Ա�����:'	|| lrRec.trade_dt||' �ֹι�ȣ	:'||RTRIM(TRIM(lrRec.jumin_no),'0')||
									'	������ȣ :'||lrRec.trade_no||' '||SqlErrm);
		Exception	When Others	Then
			Null;
		End;
	End;
	/******************************************************************************/
	/*	��� : Van ����	Ʈ���� ó��	�о�-->����										*/
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
		If lsDocu	=	FB_DOCU_DEPO_TR_B	Then			--���ݰŷ�������
			process_trg_HSMS_D1(Ar_Recv);
		ElsIf	lsDocu = FB_DOCU_DEPO_MISS_B Then		--���ݰŷ��������
			process_trg_HSMS_D2(Ar_Recv);
		ElsIf	lsDocu = FB_DOCU_VIRT_TR_B Then		--������°ŷ���
			process_trg_HSMS_D3(Ar_Recv);
		ElsIf	lsDocu = FB_DOCU_VIRT_MISS_B Then		--������°����û
			process_trg_HSMS_D4(Ar_Recv);
		End	If;
	End;


	/******************************************************************************/
	/*	��� : Van ����	Ʈ���� ó��	main											*/
	/******************************************************************************/
	/*************************************************************************/
	/*																		 */
	/*	1. ���ID	 : T_FB_VAN_RECV_TRG									 */
	/*	2. ����̸�	 : VAN�� ������	���ŵǾ����� ó������					 */
	/*	3. �ý���	 : ȸ��ý���											 */
	/*	4. ����ý���: FBS													 */
	/*	5. �������	 : TRIGGER												 */
	/*	6. �����	 : PL/SQL												 */
	/*	7. ���ȯ��	 : Windows2003 Server+ Oracle	9.2.0						 */
	/*	8. ���DBMS	 : Oracle												 */
	/*	9. �����	���� ��	�ֿ���											 */
	/*																		 */
	/*		-	������ ���ŵ�	���,	�ϱ��� 5���� �����	�����Ѵ�.				 */
	/*																		 */
	/*		(1)	�����ܾ׵����� TABLE INSERT/UPDATE							 */
	/*			 : ��	���º� ���ں�	�ܾ��� ������	�ִ� T_FB_ACCT_REAMIN_DATA	 */
	/*			 ���̺�	�����ܾ��� UPDATE�Ѵ�. ����	�ܾ���ȸ�� ������	��	 */
	/*			 ��	���� �űԷ�	INSERT�� �����Ѵ�.						 */
	/*																		 */
	/*		(2)	���ݰŷ��� TABLE INSERT									 */
	/*			 : ���ݰŷ���	���� ��	������� ������	�� ���, �ش�	���̺�	 */
	/*			 (T_FB_CASH_TRX_DATA)��	�� �׸񺰷�	�����ؼ� INSERT�����Ѵ�	 */
	/*			 ��	���ݰŷ����� ����	���,	�ش� �ܰ�	ǥ��ǹǷ�,	�̸�	 */
	/*			 ���º�	�ܾ�Table��	insertȤ�� update��	�մϴ�.				 */
	/*																		 */
	/*		(3)	�����ŷ��� TABLE INSERT									 */
	/*			 : �����ŷ���	���� ��	������� ������	�� ���, �ش�	���̺�	 */
	/*			 (T_FB_BILL_TRX_DATA)��	�� �׸񺰷�	�����ؼ� INSERT����		 */
	/*																		 */
	/*		(4)	Ÿ����ü�Ҵ� ����	ó��										 */
	/*			 : Ÿ����ü�Ҵ�����	������ ���ŵǸ�, �ش�	���ް��� ã�Ƽ�	���� */
	/*			 ��	'���޽���' Ȥ��	'�Ϻ����޽���'�� �ٲٰ�, ��ϵ�			 */
	/*			 �������	Ÿ����ü�Ҵ����� ������	�߼��մϴ�.				 */
	/*																		 */
	/*		(5)	������� ó��	��,	��üó����� ���Ž�	ó��					 */
	/*			 : �ǽð���üó����	�����ð��� LOOPING ��	WAITING��	�����ϳ�,	 */
	/*			 WAITING TIMEOUT���Ŀ� ���ŵ�	��üó����� ������	���ŵ�	 */
	/*			 ���, �ش�	���ް��� ã�Ƽ�	ó������� UPDATE�մϴ�.		 */
	/*																		 */
	/*		(6)	�о����� ����Ÿ	INSERT										 */
	/*																		 */
	/*			 : ���ݰŷ���/���ݰŷ��������û����/������°ŷ���/	 */
	/*			 �������	�ŷ��������û���� ��	4����	������ ���ŵǾ�����	 */
	/*			 �ش�	���°� "����(T_ACCNO_CODE)'���̺���	HSMS_USE_CLS�÷��� */
	/*			 TRUE��	���¶��,	�� ���, �÷�����	�ʿ䵥��Ÿ�� �̾Ƽ�,	 */
	/*			 "�о��������̽�(T_FB_INTERFACE_PH)"���̺� INSERT����		 */
	/*																		 */
	/* 10. �����ۼ���: LG	CNS	����ö										 */
	/* 11. �����ۼ���: 2005��12��21��										 */
	/* 12. ����������:														 */
	/* 13. ����������:														 */
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
		--���ǿ� ����	ó����� �б��ϱ�...
		If lsDocu	=	FB_DOCU_REMAIN_B Then			--���� �ܾ�	��ȸ �̸�
			process_trg_FB_DOCU_REMAIN_B(lrRecv);
		ElsIf	lsDocu = FB_DOCU_DEPO_TR_B Then		--���� ���ݰŷ���	�̸�
			process_trg_FB_DOCU_DEPO_TR_B(lrRecv);
		ElsIf	lsDocu = FB_DOCU_BILL_TRX_B	Then		--���� �����ŷ���	�̸�
			process_trg_FB_DOCU_BILL_TRX_B(lrRecv);
		ElsIf	lsDocu = FB_DOCU_TATR_RE_B Then		--Ÿ����ü �Ҵ��̸�
			process_trg_FB_DOCU_TATR_RE_B(lrRecv);
		ElsIf	lsDocu In	(FB_DOCU_DATR_T,FB_DOCU_DATR_B,FB_DOCU_TATR_T,FB_DOCU_TATR_B)	Then	--��ü ó����
			process_trg_FB_DOCU_DATR_T(lrRecv);
		End	If;
		If lsDocu	In (FB_DOCU_DEPO_TR_B,FB_DOCU_DEPO_MISS_B,FB_DOCU_VIRT_TR_B,FB_DOCU_VIRT_MISS_B) Then	--�о���Ա� �����̶��
			process_trg_HSMS(lrRecv);
		End	If;
	End;

END	FBS_MAIN_PKG;
/
