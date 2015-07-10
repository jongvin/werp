CREATE OR REPLACE PACKAGE BODY      erpw_invoice_approval_pkg AS
/******************************************************************************/
/*                                                                            */
/* Package Name  : efin_invoice_approval_pkg                                  */
/* Description   : 전산결재 관련 Package                                      */
/* Change Request Number : 1.0.0.0                                            */
/*                                                                            */
/* Parameters:                                                                */
/*----------------------------------------------------------------------------*/
/*Date       In Charge         Description                                    */
/*----------------------------------------------------------------------------*/
/*2005-05-25 BaNgDoLL          Initial Release                                */
/******************************************************************************/

/******************************************************************************/
/*                                                                            */
/* Procedure Name : create_reverse_invoice                                    */
/* Description   : 해당 결재전표의 - 전표를 생성한다.                         */
/* Change Request Number : 1.0.0.0                                            */
/*                                                                            */
/* Parameters:                                                                */
/*----------------------------------------------------------------------------*/
/*Date       In Charge         Description                                    */
/*----------------------------------------------------------------------------*/
/*2005-05-20 BaNgDoLL          Initial Release                                */
/******************************************************************************/
   PROCEDURE create_reverse_invoice ( errbuf               OUT VARCHAR2 ,
                                      retcode              OUT VARCHAR2 ,
                                      pv_invoice_group_id  IN  NUMBER   ,
                                      pv_batch_date        IN  DATE     ) IS

      v_header_creation         BOOLEAN := FALSE ;
      v_line_creation           BOOLEAN := FALSE ;
      v_invoice_group_id        efin_invoice_header_itf.invoice_group_id%TYPE ;
      v_batch_date              efin_invoice_header_itf.batch_date%TYPE ;
      v_created_dept_code       efin_invoice_header_itf.created_dept_code%TYPE ;
      v_approval_num            efin_invoice_header_itf.approval_num%TYPE ;

      DEPARTMENT_EXCEPTION      EXCEPTION ;
      HEADER_EXCEPTION          EXCEPTION ;
      LINES_EXCEPTION           EXCEPTION ;
   BEGIN

      BEGIN
         SELECT created_dept_code   ,
                batch_date
         INTO   v_created_dept_code ,
                v_batch_date
         FROM   efin_invoice_header_itf@crp
         WHERE  invoice_group_id = pv_invoice_group_id ;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            RAISE DEPARTMENT_EXCEPTION ;
      END ;

      SELECT efin_invoice_header_itf_s.NEXTVAL@crp
      INTO   v_invoice_group_id
      FROM   DUAL ;

      -- 전산 결재 전표 번호 생성
      erpw_invoice_approval_pkg.get_approval_num(SUBSTR(v_created_dept_code, 1, 2)                     ,
                                                 TO_CHAR(NVL(pv_batch_date, v_batch_date), 'YYYYMMDD') ,
                                                 v_approval_num                                        ) ;

      -- Header 정보 생성
      BEGIN
         INSERT INTO efin_invoice_header_itf@crp ( invoice_group_id                  ,  -- 전산결재시 전표 Grouping ID
                                               approval_num                      ,  -- 결재 번호
                                               approval_name                     ,  -- 결재 명
                                               source                            ,  -- 발생System (ADD-ON, FI)
                                               complete_flag                     ,  -- 결재 완료 Flag(1:결재중, 9:완료)
                                               interface_flag                    ,  -- FI Interface 완료 Flag(N:미완료, Y:완료)
                                               current_approval_id               ,  -- 현재 결재자 ID
                                               account_dept_code                 ,  -- 회계계리 부서코드
                                               secretary_dept_code               ,  -- 비서실 부서코드
                                               approval_id_last                  ,  -- 통제자 ID(이후 결재는 회계계리, 비서실순)
                                               approval_id_1                     ,  -- 결재자1 ID
                                               approval_jik_1                    ,  -- 결재자1 직급
                                               approval_name_1                   ,  -- 결재자1 성명
                                               approval_date_1                   ,  -- 전표 처리 일자
                                               approval_status_1                 ,  -- 전표 상태(승인, 반려, 진행)
                                               approval_id_2                     ,  -- 결재자2 ID
                                               approval_jik_2                    ,  -- 결재자2 직급
                                               approval_name_2                   ,  -- 결재자2 성명
                                               approval_date_2                   ,  -- 전표 처리 일자
                                               approval_status_2                 ,  -- 전표 상태(승인, 반려, 진행)
                                               approval_id_3                     ,  -- 결재자3 ID
                                               approval_jik_3                    ,  -- 결재자3 직급
                                               approval_name_3                   ,  -- 결재자3 성명
                                               approval_date_3                   ,  -- 전표 처리 일자
                                               approval_status_3                 ,  -- 전표 상태(승인, 반려, 진행)
                                               approval_id_4                     ,  -- 결재자4 ID
                                               approval_jik_4                    ,  -- 결재자4 직급
                                               approval_name_4                   ,  -- 결재자4 성명
                                               approval_date_4                   ,  -- 전표 처리 일자
                                               approval_status_4                 ,  -- 전표 상태(승인, 반려, 진행)
                                               approval_id_5                     ,  -- 결재자5 ID
                                               approval_jik_5                    ,  -- 결재자5 직급
                                               approval_name_5                   ,  -- 결재자5 성명
                                               approval_date_5                   ,  -- 전표 처리 일자
                                               approval_status_5                 ,  -- 전표 상태(승인, 반려, 진행)
                                               approval_id_6                     ,  -- 결재자6 ID
                                               approval_jik_6                    ,  -- 결재자6 직급
                                               approval_name_6                   ,  -- 결재자6 성명
                                               approval_date_6                   ,  -- 전표 처리 일자
                                               approval_status_6                 ,  -- 전표 상태(승인, 반려, 진행)
                                               approval_id_7                     ,  -- 결재자7 ID
                                               approval_jik_7                    ,  -- 결재자7 직급
                                               approval_name_7                   ,  -- 결재자7 성명
                                               approval_date_7                   ,  -- 전표 처리 일자
                                               approval_status_7                 ,  -- 전표 상태(승인, 반려, 진행)
                                               approval_id_8                     ,  -- 결재자8 ID
                                               approval_jik_8                    ,  -- 결재자8 직급
                                               approval_name_8                   ,  -- 결재자8 성명
                                               approval_date_8                   ,  -- 전표 처리 일자
                                               approval_status_8                 ,  -- 전표 상태(승인, 반려, 진행)
                                               approval_id_9                     ,  -- 결재자9 ID
                                               approval_jik_9                    ,  -- 결재자9 직급
                                               approval_name_9                   ,  -- 결재자9 성명
                                               approval_date_9                   ,  -- 전표 처리 일자
                                               approval_status_9                 ,  -- 전표 상태(승인, 반려, 진행)
                                               approval_id_10                    ,  -- 회계계리 결재자 ID
                                               approval_jik_10                   ,  -- 결재자10 직급
                                               approval_name_10                  ,  -- 결재자10 성명
                                               approval_date_10                  ,  -- 전표 처리 일자
                                               approval_status_10                ,  -- 전표 상태(승인, 반려, 진행)
                                               approval_id_11                    ,  -- 비서실 결재자 ID
                                               approval_jik_11                   ,  -- 결재자11 직급
                                               approval_name_11                  ,  -- 결재자11 성명
                                               approval_date_11                  ,  -- 전표 처리 일자
                                               approval_status_11                ,  -- 전표 상태(승인, 반려, 진행)
                                               creation_date                     ,  -- 생성일자
                                               created_by                        ,  -- 생성자 사번
                                               created_dept_code                 ,  -- 발의 부서
                                               created_dept_name                 ,  -- 발의 부서명
                                               batch_date                        ,  -- 결재전표 일자
                                               last_update_date                  ,  -- 최종 수정일자
                                               last_update_login                 ,  -- 최종 수정자 Log-In ID
                                               last_updated_by                   ,  -- 최종 수정자 사번
                                               relation_invoice_group_id         ,  -- 상대 전표 Invoice_group_id
                                               attribute1                        ,  --
                                               attribute2                        ,  --
                                               attribute3                        ,  --
                                               attribute4                        ,  --
                                               attribute5                        ,  --
                                               attribute6                        ,  --
                                               attribute7                        ,  --
                                               attribute8                        ,  --
                                               attribute9                        ,  --
                                               attribute10                       )  --
         SELECT v_invoice_group_id                     ,  -- 전산결재시 전표 Grouping ID
                v_approval_num                         ,  -- 결재 번호
                eihi.approval_name||' 취소'            ,  -- 결재 명
                eihi.source                            ,  -- 발생System (ADD-ON, FI)
                '1'                                    ,  -- 결재 완료 Flag(1:결재중, 9:완료) eihi.complete_flag
                NULL                                   ,  -- FI Interface 완료 Flag(N:미완료, Y:완료)
                eihi.approval_id_1                     ,  -- 현재 결재자 ID current_approval_id
                eihi.account_dept_code                 ,  -- 회계계리 부서코드
                eihi.secretary_dept_code               ,  -- 비서실 부서코드
                eihi.approval_id_last                  ,  -- 통제자 ID(이후 결재는 회계계리, 비서실순)
                eihi.approval_id_1                     ,  -- 결재자1 ID
                eihi.approval_jik_1                    ,  -- 결재자1 직급
                eihi.approval_name_1                   ,  -- 결재자1 성명
                NULL                                   ,  -- 전표 처리 일자
                NULL                                   ,  -- 전표 상태(승인, 반려, 진행)
                eihi.approval_id_2                     ,  -- 결재자2 ID
                eihi.approval_jik_2                    ,  -- 결재자2 직급
                eihi.approval_name_2                   ,  -- 결재자2 성명
                NULL                                   ,  -- 전표 처리 일자
                NULL                                   ,  -- 전표 상태(승인, 반려, 진행)
                eihi.approval_id_3                     ,  -- 결재자3 ID
                eihi.approval_jik_3                    ,  -- 결재자3 직급
                eihi.approval_name_3                   ,  -- 결재자3 성명
                NULL                                   ,  -- 전표 처리 일자
                NULL                                   ,  -- 전표 상태(승인, 반려, 진행)
                eihi.approval_id_4                     ,  -- 결재자4 ID
                eihi.approval_jik_4                    ,  -- 결재자4 직급
                eihi.approval_name_4                   ,  -- 결재자4 성명
                NULL                                   ,  -- 전표 처리 일자
                NULL                                   ,  -- 전표 상태(승인, 반려, 진행)
                eihi.approval_id_5                     ,  -- 결재자5 ID
                eihi.approval_jik_5                    ,  -- 결재자5 직급
                eihi.approval_name_5                   ,  -- 결재자5 성명
                NULL                                   ,  -- 전표 처리 일자
                NULL                                   ,  -- 전표 상태(승인, 반려, 진행)
                eihi.approval_id_6                     ,  -- 결재자6 ID
                eihi.approval_jik_6                    ,  -- 결재자6 직급
                eihi.approval_name_6                   ,  -- 결재자6 성명
                NULL                                   ,  -- 전표 처리 일자
                NULL                                   ,  -- 전표 상태(승인, 반려, 진행)
                eihi.approval_id_7                     ,  -- 결재자7 ID
                eihi.approval_jik_7                    ,  -- 결재자7 직급
                eihi.approval_name_7                   ,  -- 결재자7 성명
                NULL                                   ,  -- 전표 처리 일자
                NULL                                   ,  -- 전표 상태(승인, 반려, 진행)
                eihi.approval_id_8                     ,  -- 결재자8 ID
                eihi.approval_jik_8                    ,  -- 결재자8 직급
                eihi.approval_name_8                   ,  -- 결재자8 성명
                NULL                                   ,  -- 전표 처리 일자
                NULL                                   ,  -- 전표 상태(승인, 반려, 진행)
                eihi.approval_id_9                     ,  -- 결재자9 ID
                eihi.approval_jik_9                    ,  -- 결재자9 직급
                eihi.approval_name_9                   ,  -- 결재자9 성명
                NULL                                   ,  -- 전표 처리 일자
                NULL                                   ,  -- 전표 상태(승인, 반려, 진행)
                eihi.approval_id_10                    ,  -- 회계계리 결재자 ID
                eihi.approval_jik_10                   ,  -- 결재자10 직급
                eihi.approval_name_10                  ,  -- 결재자10 성명
                NULL                                   ,  -- 전표 처리 일자
                NULL                                   ,  -- 전표 상태(승인, 반려, 진행)
                eihi.approval_id_11                    ,  -- 비서실 결재자 ID
                eihi.approval_jik_11                   ,  -- 결재자11 직급
                eihi.approval_name_11                  ,  -- 결재자11 성명
                NULL                                   ,  -- 전표 처리 일자
                NULL                                   ,  -- 전표 상태(승인, 반려, 진행)
                SYSDATE                                ,  -- 생성일자
                -1                                     ,  -- 생성자 사번
                eihi.created_dept_code                 ,  -- 발의 부서
                eihi.created_dept_name                 ,  -- 발의 부서명
                eihi.batch_date                        ,  -- 결재전표 일자 ??????????
                SYSDATE                                ,  -- 최종 수정일자
                -1                                     ,  -- 최종 수정자 Log-In ID
                -1                                     ,  -- 최종 수정자 사번
                pv_invoice_group_id                    ,  -- 상대 전표 Invoice_group_id
                eihi.attribute1                        ,  --
                eihi.attribute2                        ,  --
                eihi.attribute3                        ,  --
                eihi.attribute4                        ,  --
                eihi.attribute5                        ,  --
                eihi.attribute6                        ,  --
                eihi.attribute7                        ,  --
                eihi.attribute8                        ,  --
                eihi.attribute9                        ,  --
                eihi.attribute10                          --
         FROM   efin_invoice_header_itf@crp eihi
         WHERE  eihi.invoice_group_id           = pv_invoice_group_id
         AND    eihi.source                     = 'A'                         -- Add-On 자료만
         AND    NVL(eihi.complete_flag,  '1')   = '9'                         -- 결재완료된 자료만
         AND    NVL(eihi.interface_flag, 'N')   = 'Y' ;

         v_header_creation := TRUE ;
      EXCEPTION
         WHEN OTHERS THEN
            v_header_creation := FALSE ;
            RAISE HEADER_EXCEPTION ;
      END ;

      IF v_header_creation THEN
         -- Line 정보 생성
         BEGIN
            INSERT INTO efin_invoice_lines_itf@crp ( seq                                           ,  -- (공통) Interface Sequence
                                                 batch_date                                    ,  -- (공통) Batch 실행일자 EFIN_BATCH_FLAG테이블에 입력된 날짜
                                                 invoice_group_id                              ,  -- (공통) 전산결재시 전표 Grouping ID
                                                 status                                        ,  -- (공통) Interface 상태(초기:NEW, 완료:INTERFACED)
                                                 module_name                                   ,  -- (공통) FI 모듈(GL, AP)
                                                 error_msg                                     ,  -- (공통) Error 시 MESSAGE
                                                 creation_date                                 ,  -- (공통) 생성일자
                                                 created_by                                    ,  -- (공통) 생성자 사번
                                                 last_update_date                              ,  -- (공통) 최종 수정일자
                                                 last_update_login                             ,  -- (공통) 최종 수정자 Log-In ID
                                                 last_updated_by                               ,  -- (공통) 최종 수정자 사번
                                                 attribute1                                    ,  -- (공통) 
                                                 attribute2                                    ,  -- (공통)
                                                 attribute3                                    ,  -- (공통)
                                                 attribute4                                    ,  -- (공통)
                                                 attribute5                                    ,  -- (공통)
                                                 attribute6                                    ,  -- (공통)
                                                 attribute7                                    ,  -- (공통)
                                                 attribute8                                    ,  -- (공통)
                                                 attribute9                                    ,  -- (공통)
                                                 attribute10                                   ,  -- (공통)
                                                 attribute11                                   ,  -- (공통)
                                                 attribute12                                   ,  -- (공통)
                                                 attribute13                                   ,  -- (공통)
                                                 attribute14                                   ,  -- (공통)
                                                 attribute15                                   ,  -- (공통)
                                                 attribute16                                   ,  -- (GL)
                                                 attribute17                                   ,  -- (GL)
                                                 attribute18                                   ,  -- (GL)
                                                 attribute19                                   ,  -- (GL)
                                                 attribute20                                   ,  -- (GL)
                                                 org_id                                        ,  -- (AP)
                                                 invoice_date                                  ,  -- (AP)
                                                 invoice_num                                   ,  -- (AP)
                                                 gl_date                                       ,  -- (AP)
                                                 invoice_type_lookup_code                      ,  -- (AP)
                                                 accts_pay_code_accounts                       ,  -- (AP)
                                                 accts_pay_code_combination_id                 ,  -- (AP)
                                                 source                                        ,  -- (AP)
                                                 terms_id                                      ,  -- (AP)
                                                 terms_name                                    ,  -- (AP)
                                                 vat_registration_num                          ,  -- (AP)
                                                 vendor_id                                     ,  -- (AP)
                                                 vendor_name                                   ,  -- (AP)
                                                 vendor_site_id                                ,  -- (AP)
                                                 workflow_flag                                 ,  -- (AP)
                                                 interface_check                               ,  -- (AP)
                                                 invoice_amount                                ,  -- (AP)
                                                 invoice_currency_code                         ,  -- (AP)
                                                 line_amount                                   ,  -- (AP)
                                                 line_description                              ,  -- (AP)
                                                 line_dist_code_accounts                       ,  -- (AP)
                                                 line_dist_code_combination_id                 ,  -- (AP)
                                                 description                                   ,  -- (AP)
                                                 line_tax_code                                 ,  -- (AP)
                                                 pay_group_lookup_code                         ,  -- (AP)
                                                 payment_method_lookup_code                    ,  -- (AP)
                                                 global_attribute_category                     ,  -- (AP)
                                                 global_attribute1                             ,  -- (AP)
                                                 global_attribute2                             ,  -- (AP)
                                                 global_attribute3                             ,  -- (AP)
                                                 global_attribute4                             ,  -- (AP)
                                                 global_attribute5                             ,  -- (AP)
                                                 global_attribute6                             ,  -- (AP)
                                                 global_attribute7                             ,  -- (AP)
                                                 global_attribute8                             ,  -- (AP)
                                                 global_attribute9                             ,  -- (AP)
                                                 global_attribute10                            ,  -- (AP)
                                                 global_attribute11                            ,  -- (AP)
                                                 global_attribute12                            ,  -- (AP)
                                                 global_attribute13                            ,  -- (AP)
                                                 global_attribute14                            ,  -- (AP)
                                                 global_attribute15                            ,  -- (AP)
                                                 global_attribute16                            ,  -- (AP)
                                                 global_attribute17                            ,  -- (AP)
                                                 global_attribute18                            ,  -- (AP)
                                                 global_attribute19                            ,  -- (AP)
                                                 global_attribute20                            ,  -- (AP)
                                                 line_attribute1                               ,  -- (AP)
                                                 line_attribute2                               ,  -- (AP)
                                                 line_attribute3                               ,  -- (AP)
                                                 line_attribute4                               ,  -- (AP)
                                                 line_attribute5                               ,  -- (AP)
                                                 line_attribute6                               ,  -- (AP)
                                                 line_attribute7                               ,  -- (AP)
                                                 line_attribute8                               ,  -- (AP)
                                                 line_attribute9                               ,  -- (AP)
                                                 line_attribute10                              ,  -- (AP)
                                                 line_attribute11                              ,  -- (AP)
                                                 line_attribute12                              ,  -- (AP)
                                                 line_attribute13                              ,  -- (AP)
                                                 line_attribute14                              ,  -- (AP)
                                                 line_attribute15                              ,  -- (AP)
                                                 line_global_attribute_category                ,  -- (AP)
                                                 line_global_attribute1                        ,  -- (AP)
                                                 line_global_attribute2                        ,  -- (AP)
                                                 line_global_attribute3                        ,  -- (AP)
                                                 line_global_attribute4                        ,  -- (AP)
                                                 line_global_attribute5                        ,  -- (AP)
                                                 line_global_attribute6                        ,  -- (AP)
                                                 line_global_attribute7                        ,  -- (AP)
                                                 line_global_attribute8                        ,  -- (AP)
                                                 line_global_attribute9                        ,  -- (AP)
                                                 line_global_attribute10                       ,  -- (AP)
                                                 line_global_attribute11                       ,  -- (AP)
                                                 line_global_attribute12                       ,  -- (AP)
                                                 line_global_attribute13                       ,  -- (AP)
                                                 line_global_attribute14                       ,  -- (AP)
                                                 line_global_attribute15                       ,  -- (AP)
                                                 line_global_attribute16                       ,  -- (AP)
                                                 line_global_attribute17                       ,  -- (AP)
                                                 line_global_attribute18                       ,  -- (AP)
                                                 line_global_attribute19                       ,  -- (AP)
                                                 line_global_attribute20                       ,  -- (AP)
                                                 set_of_books_id                               ,  -- (GL)
                                                 accounting_date                               ,  -- (GL)
                                                 chart_of_accounts_id                          ,  -- (GL)
                                                 code_combination_id                           ,  -- (GL)
                                                 concatenated_segments                         ,  -- (GL)
                                                 currency_code                                 ,  -- (GL)
                                                 currency_conversion_date                      ,  -- (GL)
                                                 currency_conversion_rate                      ,  -- (GL)
                                                 entered_cr                                    ,  -- (GL)
                                                 entered_dr                                    ,  -- (GL)
                                                 accounted_cr                                  ,  -- (GL)
                                                 accounted_dr                                  ,  -- (GL)
                                                 actual_flag                                   ,  -- (GL)
                                                 tax_group_id                                  ,  -- (GL)
                                                 tax_status_code                               ,  -- (GL)
                                                 transaction_date                              ,  -- (GL)
                                                 user_currency_conversion_type                 ,  -- (GL)
                                                 user_je_category_name                         ,  -- (GL)
                                                 user_je_source_name                           ,  -- (GL)
                                                 group_id                                      ,  -- (GL)
                                                 period_name                                   ,  -- (GL)
                                                 reference1                                    ,  -- (GL)
                                                 reference2                                    ,  -- (GL)
                                                 reference3                                    ,  -- (GL)
                                                 reference4                                    ,  -- (GL)
                                                 reference5                                    ,  -- (GL)
                                                 reference6                                    ,  -- (GL)
                                                 reference7                                    ,  -- (GL)
                                                 reference8                                    ,  -- (GL)
                                                 reference9                                    ,  -- (GL)
                                                 reference10                                   ,  -- (GL)
                                                 segment1                                      ,  -- (GL)
                                                 segment2                                      ,  -- (GL)
                                                 segment3                                      ,  -- (GL)
                                                 segment4                                      ,  -- (GL)
                                                 segment5                                      ,  -- (GL)
                                                 segment6                                      ,  -- (GL)
                                                 segment7                                      ,  -- (GL)
                                                 segment8                                      ,  -- (GL)
                                                 segment9                                      ,  -- (GL)
                                                 segment10                                     ,  -- (GL)
                                                 front_attribute1                              ,  -- (GL)
                                                 front_attribute2                              ,  -- (GL)
                                                 front_attribute3                              ,  -- (GL)
                                                 front_attribute4                              ,  -- (GL)
                                                 front_attribute5                              ,  -- (GL)
                                                 front_attribute6                              ,  -- (GL)
                                                 front_attribute7                              ,  -- (GL)
                                                 front_attribute8                              ,  -- (GL)
                                                 front_attribute9                              ,  -- (GL)
                                                 front_attribute10                             ,  -- (GL)
                                                 validation_flag                               )  -- (GL) 검증(C:Customer, V:Vendor)
            SELECT efin_invoice_lines_itf_s.NEXTVAL@crp                   ,  -- (공통) Interface Sequence
                   NVL(pv_batch_date, v_batch_date)                   ,  -- (공통) Batch 실행일자 EFIN_BATCH_FLAG테이블에 입력된 날짜
                   v_invoice_group_id                                 ,  -- (공통) 전산결재시 전표 Grouping ID
                   eili.status                                        ,  -- (공통) Interface 상태(초기:NEW, 완료:INTERFACED)
                   eili.module_name                                   ,  -- (공통) FI 모듈(GL, AP)
                   eili.error_msg                                     ,  -- (공통) Error 시 MESSAGE
                   SYSDATE                                            ,  -- (공통) 생성일자
                   -1                                                 ,  -- (공통) 생성자 사번
                   SYSDATE                                            ,  -- (공통) 최종 수정일자
                   -1                                                 ,  -- (공통) 최종 수정자 Log-In ID
                   -1                                                 ,  -- (공통) 최종 수정자 사번
                   eili.attribute1                                    ,  -- (공통) 
                   eili.attribute2                                    ,  -- (공통)
                   eili.attribute3                                    ,  -- (공통)
                   eili.attribute4                                    ,  -- (공통)
                   eili.attribute5                                    ,  -- (공통)
                   eili.attribute6                                    ,  -- (공통)
                   eili.attribute7                                    ,  -- (공통)
                   eili.attribute8                                    ,  -- (공통)
                   eili.attribute9                                    ,  -- (공통)
                   eili.attribute10                                   ,  -- (공통)
                   eili.attribute11                                   ,  -- (공통)
                   eili.attribute12                                   ,  -- (공통)
                   eili.attribute13                                   ,  -- (공통)
                   eili.attribute14                                   ,  -- (공통)
                   eili.attribute15                                   ,  -- (공통)
                   eili.attribute16                                   ,  -- (GL)
                   eili.attribute17                                   ,  -- (GL)
                   eili.attribute18                                   ,  -- (GL)
                   eili.attribute19                                   ,  -- (GL)
                   eili.attribute20                                   ,  -- (GL)
                   eili.org_id                                        ,  -- (AP)
                   eili.invoice_date                                  ,  -- (AP)
                   eili.invoice_num                                   ,  -- (AP)
                   eili.gl_date                                       ,  -- (AP)
                   eili.invoice_type_lookup_code                      ,  -- (AP)
                   eili.accts_pay_code_accounts                       ,  -- (AP)
                   eili.accts_pay_code_combination_id                 ,  -- (AP)
                   eili.source                                        ,  -- (AP)
                   eili.terms_id                                      ,  -- (AP)
                   eili.terms_name                                    ,  -- (AP)
                   eili.vat_registration_num                          ,  -- (AP)
                   eili.vendor_id                                     ,  -- (AP)
                   eili.vendor_name                                   ,  -- (AP)
                   eili.vendor_site_id                                ,  -- (AP)
                   eili.workflow_flag                                 ,  -- (AP)
                   eili.interface_check                               ,  -- (AP)
                   eili.invoice_amount                  * -1          ,  -- (AP)
                   eili.invoice_currency_code                         ,  -- (AP)
                   eili.line_amount                     * -1          ,  -- (AP)
                   eili.line_description                              ,  -- (AP)
                   eili.line_dist_code_accounts                       ,  -- (AP)
                   eili.line_dist_code_combination_id                 ,  -- (AP)
                   eili.description                                   ,  -- (AP)
                   eili.line_tax_code                                 ,  -- (AP)
                   eili.pay_group_lookup_code                         ,  -- (AP)
                   eili.payment_method_lookup_code                    ,  -- (AP)
                   eili.global_attribute_category                     ,  -- (AP)
                   eili.global_attribute1                             ,  -- (AP)
                   eili.global_attribute2                             ,  -- (AP)
                   eili.global_attribute3                             ,  -- (AP)
                   eili.global_attribute4                             ,  -- (AP)
                   eili.global_attribute5                             ,  -- (AP)
                   eili.global_attribute6                             ,  -- (AP)
                   eili.global_attribute7                             ,  -- (AP)
                   eili.global_attribute8                             ,  -- (AP)
                   eili.global_attribute9                             ,  -- (AP)
                   eili.global_attribute10                            ,  -- (AP)
                   eili.global_attribute11                            ,  -- (AP)
                   eili.global_attribute12                            ,  -- (AP)
                   eili.global_attribute13                            ,  -- (AP)
                   eili.global_attribute14                            ,  -- (AP)
                   eili.global_attribute15                            ,  -- (AP)
                   eili.global_attribute16                            ,  -- (AP)
                   eili.global_attribute17                            ,  -- (AP)
                   eili.global_attribute18                            ,  -- (AP)
                   eili.global_attribute19                            ,  -- (AP)
                   eili.global_attribute20                            ,  -- (AP)
                   eili.line_attribute1                               ,  -- (AP)
                   eili.line_attribute2                               ,  -- (AP)
                   eili.line_attribute3                               ,  -- (AP)
                   eili.line_attribute4                               ,  -- (AP)
                   eili.line_attribute5                               ,  -- (AP)
                   eili.line_attribute6                               ,  -- (AP)
                   eili.line_attribute7                               ,  -- (AP)
                   eili.line_attribute8                               ,  -- (AP)
                   eili.line_attribute9                               ,  -- (AP)
                   eili.line_attribute10                              ,  -- (AP)
                   eili.line_attribute11                              ,  -- (AP)
                   eili.line_attribute12                              ,  -- (AP)
                   eili.line_attribute13                              ,  -- (AP)
                   eili.line_attribute14                              ,  -- (AP)
                   eili.line_attribute15                              ,  -- (AP)
                   eili.line_global_attribute_category                ,  -- (AP)
                   eili.line_global_attribute1                        ,  -- (AP)
                   eili.line_global_attribute2                        ,  -- (AP)
                   eili.line_global_attribute3                        ,  -- (AP)
                   eili.line_global_attribute4                        ,  -- (AP)
                   eili.line_global_attribute5                        ,  -- (AP)
                   eili.line_global_attribute6                        ,  -- (AP)
                   eili.line_global_attribute7                        ,  -- (AP)
                   eili.line_global_attribute8                        ,  -- (AP)
                   eili.line_global_attribute9                        ,  -- (AP)
                   eili.line_global_attribute10                       ,  -- (AP)
                   eili.line_global_attribute11                       ,  -- (AP)
                   eili.line_global_attribute12                       ,  -- (AP)
                   eili.line_global_attribute13                       ,  -- (AP)
                   eili.line_global_attribute14                       ,  -- (AP)
                   eili.line_global_attribute15                       ,  -- (AP)
                   eili.line_global_attribute16                       ,  -- (AP)
                   eili.line_global_attribute17                       ,  -- (AP)
                   eili.line_global_attribute18                       ,  -- (AP)
                   eili.line_global_attribute19                       ,  -- (AP)
                   eili.line_global_attribute20                       ,  -- (AP)
                   eili.set_of_books_id                               ,  -- (GL)
                   eili.accounting_date                               ,  -- (GL)
                   eili.chart_of_accounts_id                          ,  -- (GL)
                   eili.code_combination_id                           ,  -- (GL)
                   eili.concatenated_segments                         ,  -- (GL)
                   eili.currency_code                                 ,  -- (GL)
                   eili.currency_conversion_date                      ,  -- (GL)
                   eili.currency_conversion_rate                      ,  -- (GL)
                   eili.entered_cr                      * -1          ,  -- (GL)
                   eili.entered_dr                      * -1          ,  -- (GL)
                   eili.accounted_cr                    * -1          ,  -- (GL)
                   eili.accounted_dr                    * -1          ,  -- (GL)
                   eili.actual_flag                                   ,  -- (GL)
                   eili.tax_group_id                                  ,  -- (GL)
                   eili.tax_status_code                               ,  -- (GL)
                   eili.transaction_date                              ,  -- (GL)
                   eili.user_currency_conversion_type                 ,  -- (GL)
                   eili.user_je_category_name                         ,  -- (GL)
                   eili.user_je_source_name                           ,  -- (GL)
                   eili.group_id                                      ,  -- (GL)
                   eili.period_name                                   ,  -- (GL)
                   eili.reference1                                    ,  -- (GL)
                   eili.reference2                                    ,  -- (GL)
                   eili.reference3                                    ,  -- (GL)
                   eili.reference4                                    ,  -- (GL)
                   eili.reference5                                    ,  -- (GL)
                   eili.reference6                                    ,  -- (GL)
                   eili.reference7                                    ,  -- (GL)
                   eili.reference8                                    ,  -- (GL)
                   eili.reference9                                    ,  -- (GL)
                   eili.reference10                                   ,  -- (GL)
                   eili.segment1                                      ,  -- (GL)
                   eili.segment2                                      ,  -- (GL)
                   eili.segment3                                      ,  -- (GL)
                   eili.segment4                                      ,  -- (GL)
                   eili.segment5                                      ,  -- (GL)
                   eili.segment6                                      ,  -- (GL)
                   eili.segment7                                      ,  -- (GL)
                   eili.segment8                                      ,  -- (GL)
                   eili.segment9                                      ,  -- (GL)
                   eili.segment10                                     ,  -- (GL)
                   eili.front_attribute1                              ,  -- (GL)
                   eili.front_attribute2                              ,  -- (GL)
                   eili.front_attribute3                              ,  -- (GL)
                   eili.front_attribute4                              ,  -- (GL)
                   eili.front_attribute5                              ,  -- (GL)
                   eili.front_attribute6                              ,  -- (GL)
                   eili.front_attribute7                              ,  -- (GL)
                   eili.front_attribute8                              ,  -- (GL)
                   eili.front_attribute9                              ,  -- (GL)
                   eili.front_attribute10                             ,  -- (GL)
                   eili.validation_flag                                  -- (GL) 검증(C:Customer, V:Vendor)
            FROM   efin_invoice_lines_itf@crp eili
            WHERE  eili.invoice_group_id           = pv_invoice_group_id ;
            --ORDER BY eili.seq ;

            v_line_creation := TRUE ;
         EXCEPTION
            WHEN OTHERS THEN
               v_line_creation := FALSE ;
               RAISE LINES_EXCEPTION ;
         END ;
      END IF ; -- header 정보가 있을 경우에만 INSERT

      -- 원전표에 - 전표 invoice_group_id 를 SET
      UPDATE efin_invoice_header_itf@crp
      SET    relation_invoice_group_id = v_invoice_group_id
      WHERE  invoice_group_id          = pv_invoice_group_id ;

      IF v_header_creation AND v_line_creation THEN
         COMMIT ;
      ELSE
         ROLLBACK ;
      END IF ;

   EXCEPTION
      WHEN DEPARTMENT_EXCEPTION THEN
          retcode := '1' ;
          errbuf  := '발의부서 Error' ;

      WHEN HEADER_EXCEPTION THEN
          retcode := '2' ;
          errbuf  := 'Header 정보 생성시 에러 : '|| SUBSTR(SQLERRM, 1, 200) ;
          ROLLBACK ;

      WHEN LINES_EXCEPTION THEN
          retcode := '2' ;
          errbuf  := 'Line 정보 생성시 에러 : '|| SUBSTR(SQLERRM, 1, 200) ;
          ROLLBACK ;

      WHEN OTHERS THEN
          retcode := '2' ;
          errbuf  := '에러발생: '|| SUBSTR(SQLERRM,1,200) ;
          ROLLBACK ;

   END create_reverse_invoice ;


/******************************************************************************/
/*                                                                            */
/* Procedure Name : get_approval_num                                          */
/* Description   : 전산결재시 전산결재 전표번호를 구한다.                     */
/* Change Request Number : 1.0.0.0                                            */
/*                                                                            */
/* Parameters: pv_organization_code : 회사코드(A0,B0..)(2)                    */
/*             pv_accounting_date   : 전표일자(8)                             */
/*----------------------------------------------------------------------------*/
/*Date       In Charge         Description                                    */
/*----------------------------------------------------------------------------*/
/*2005-05-20 BaNgDoLL          Initial Release                                */
/******************************************************************************/
   PROCEDURE get_approval_num ( pv_corporation_code      VARCHAR2 ,
                                pv_accounting_date       VARCHAR2 ,
                                pv_approval_num     OUT  VARCHAR2 ) IS
      v_max_seq           NUMBER := 1 ;
      v_approval_num      efin_invoice_header_itf.approval_num%TYPE ;
   BEGIN
      BEGIN
         SELECT NVL(MAX(invoice_seq), 0) + 1
         INTO   v_max_seq
         FROM   efin_approval_num@crp
         WHERE  corporation_code = pv_corporation_code
         AND    accounting_date  = pv_accounting_date ;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            v_max_seq := 1 ;
      END ;

      IF v_max_seq > 1 THEN
         UPDATE efin_approval_num@crp
         SET    invoice_seq       = v_max_seq           ,
                last_update_date  = SYSDATE             ,
                last_update_login = -1 ,
                last_updated_by   = -1
         WHERE  corporation_code  = pv_corporation_code
         AND    accounting_date   = pv_accounting_date ;
      ELSE
         INSERT INTO efin_approval_num@crp ( corporation_code    ,
                                         accounting_date     ,
                                         invoice_seq         ,
                                         creation_date       ,
                                         created_by          ,
                                         last_update_date    ,
                                         last_update_login   ,
                                         last_updated_by     )
         VALUES                        ( pv_corporation_code ,
                                         pv_accounting_date  ,
                                         v_max_seq           ,
                                         SYSDATE             ,
                                         -1  ,
                                         SYSDATE             ,
                                         -1 ,
                                         -1  ) ;
      END IF ;

      COMMIT ;

      pv_approval_num := pv_corporation_code||'-'||pv_accounting_date||'-'||LTRIM(TO_CHAR(v_max_seq, '00000')) ;

   END get_approval_num ;

/******************************************************************************/
/*                                                                            */
/* Procedure Name : hold_released                                             */
/* Description   : FI AP전표의 전산결재 최종결재자 완료시 Hold를 Release함    */
/* Change Request Number : 1.0.0.0                                            */
/*                                                                            */
/* Parameters: pv_invoice_group_id : 결재완료된 전표의 Invoice_group_id       */
/*----------------------------------------------------------------------------*/
/*Date       In Charge         Description                                    */
/*----------------------------------------------------------------------------*/
/*2005-05-27 BaNgDoLL          Initial Release                                */
/******************************************************************************/
   PROCEDURE hold_released ( errbuf               OUT VARCHAR2 ,
                             retcode              OUT VARCHAR2 ,
                             pv_invoice_group_id      NUMBER   ) IS
      CURSOR c1 IS
         SELECT DISTINCT TO_NUMBER(eili.attribute20)     invoice_id
         FROM   efin_invoice_lines_itf   eili ,
                efin_invoice_header_itf  eihi
         WHERE  eihi.invoice_group_id         = eili.invoice_group_id
         AND    eihi.invoice_group_id         = pv_invoice_group_id
         AND    NVL(eihi.source        , 'N') = 'F'                      -- FI 자료만
         AND    NVL(eihi.complete_flag , '1') = '9'                      -- 결재완료된 자료
         AND    NVL(eili.module_name   , 'N') = 'AP' ;                   -- AP 자료만

      v_errbuf                 VARCHAR2(200) ;
      v_retcode                VARCHAR2(200) ;

   BEGIN
      FOR r1 IN c1 LOOP
         BEGIN
            UPDATE ap.ap_holds_all
            SET    release_lookup_code = 'Electronic Approved' ,
                   release_reason      = '전산 결재 완료'      ,
                   last_updated_by     = -1     , -- FND_GLOBAL.user_id    ,
                   last_update_date    = SYSDATE               ,
                   last_update_login   = -1     -- FND_GLOBAL.login_id
            WHERE  invoice_id          = r1.invoice_id
            AND    hold_lookup_code    = 'In Approvaling' ;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
               NULL ;
         END ;
      END LOOP ;

      retcode := '0' ;
      errbuf  := 'Hold Release 작업을 정상적으로 완료 하였습니다.' ;
      COMMIT ;
   EXCEPTION
      WHEN OTHERS THEN
         retcode := '2' ;
         errbuf  := 'Hold Release 작업시 오류가 발생 하였습니다.' ;
         ROLLBACK ;
   END hold_released ;

END erpw_invoice_approval_pkg ;
/

