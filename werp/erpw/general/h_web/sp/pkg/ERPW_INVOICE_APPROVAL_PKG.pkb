CREATE OR REPLACE PACKAGE BODY      erpw_invoice_approval_pkg AS
/******************************************************************************/
/*                                                                            */
/* Package Name  : efin_invoice_approval_pkg                                  */
/* Description   : ������� ���� Package                                      */
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
/* Description   : �ش� ������ǥ�� - ��ǥ�� �����Ѵ�.                         */
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

      -- ���� ���� ��ǥ ��ȣ ����
      erpw_invoice_approval_pkg.get_approval_num(SUBSTR(v_created_dept_code, 1, 2)                     ,
                                                 TO_CHAR(NVL(pv_batch_date, v_batch_date), 'YYYYMMDD') ,
                                                 v_approval_num                                        ) ;

      -- Header ���� ����
      BEGIN
         INSERT INTO efin_invoice_header_itf@crp ( invoice_group_id                  ,  -- �������� ��ǥ Grouping ID
                                               approval_num                      ,  -- ���� ��ȣ
                                               approval_name                     ,  -- ���� ��
                                               source                            ,  -- �߻�System (ADD-ON, FI)
                                               complete_flag                     ,  -- ���� �Ϸ� Flag(1:������, 9:�Ϸ�)
                                               interface_flag                    ,  -- FI Interface �Ϸ� Flag(N:�̿Ϸ�, Y:�Ϸ�)
                                               current_approval_id               ,  -- ���� ������ ID
                                               account_dept_code                 ,  -- ȸ��踮 �μ��ڵ�
                                               secretary_dept_code               ,  -- �񼭽� �μ��ڵ�
                                               approval_id_last                  ,  -- ������ ID(���� ����� ȸ��踮, �񼭽Ǽ�)
                                               approval_id_1                     ,  -- ������1 ID
                                               approval_jik_1                    ,  -- ������1 ����
                                               approval_name_1                   ,  -- ������1 ����
                                               approval_date_1                   ,  -- ��ǥ ó�� ����
                                               approval_status_1                 ,  -- ��ǥ ����(����, �ݷ�, ����)
                                               approval_id_2                     ,  -- ������2 ID
                                               approval_jik_2                    ,  -- ������2 ����
                                               approval_name_2                   ,  -- ������2 ����
                                               approval_date_2                   ,  -- ��ǥ ó�� ����
                                               approval_status_2                 ,  -- ��ǥ ����(����, �ݷ�, ����)
                                               approval_id_3                     ,  -- ������3 ID
                                               approval_jik_3                    ,  -- ������3 ����
                                               approval_name_3                   ,  -- ������3 ����
                                               approval_date_3                   ,  -- ��ǥ ó�� ����
                                               approval_status_3                 ,  -- ��ǥ ����(����, �ݷ�, ����)
                                               approval_id_4                     ,  -- ������4 ID
                                               approval_jik_4                    ,  -- ������4 ����
                                               approval_name_4                   ,  -- ������4 ����
                                               approval_date_4                   ,  -- ��ǥ ó�� ����
                                               approval_status_4                 ,  -- ��ǥ ����(����, �ݷ�, ����)
                                               approval_id_5                     ,  -- ������5 ID
                                               approval_jik_5                    ,  -- ������5 ����
                                               approval_name_5                   ,  -- ������5 ����
                                               approval_date_5                   ,  -- ��ǥ ó�� ����
                                               approval_status_5                 ,  -- ��ǥ ����(����, �ݷ�, ����)
                                               approval_id_6                     ,  -- ������6 ID
                                               approval_jik_6                    ,  -- ������6 ����
                                               approval_name_6                   ,  -- ������6 ����
                                               approval_date_6                   ,  -- ��ǥ ó�� ����
                                               approval_status_6                 ,  -- ��ǥ ����(����, �ݷ�, ����)
                                               approval_id_7                     ,  -- ������7 ID
                                               approval_jik_7                    ,  -- ������7 ����
                                               approval_name_7                   ,  -- ������7 ����
                                               approval_date_7                   ,  -- ��ǥ ó�� ����
                                               approval_status_7                 ,  -- ��ǥ ����(����, �ݷ�, ����)
                                               approval_id_8                     ,  -- ������8 ID
                                               approval_jik_8                    ,  -- ������8 ����
                                               approval_name_8                   ,  -- ������8 ����
                                               approval_date_8                   ,  -- ��ǥ ó�� ����
                                               approval_status_8                 ,  -- ��ǥ ����(����, �ݷ�, ����)
                                               approval_id_9                     ,  -- ������9 ID
                                               approval_jik_9                    ,  -- ������9 ����
                                               approval_name_9                   ,  -- ������9 ����
                                               approval_date_9                   ,  -- ��ǥ ó�� ����
                                               approval_status_9                 ,  -- ��ǥ ����(����, �ݷ�, ����)
                                               approval_id_10                    ,  -- ȸ��踮 ������ ID
                                               approval_jik_10                   ,  -- ������10 ����
                                               approval_name_10                  ,  -- ������10 ����
                                               approval_date_10                  ,  -- ��ǥ ó�� ����
                                               approval_status_10                ,  -- ��ǥ ����(����, �ݷ�, ����)
                                               approval_id_11                    ,  -- �񼭽� ������ ID
                                               approval_jik_11                   ,  -- ������11 ����
                                               approval_name_11                  ,  -- ������11 ����
                                               approval_date_11                  ,  -- ��ǥ ó�� ����
                                               approval_status_11                ,  -- ��ǥ ����(����, �ݷ�, ����)
                                               creation_date                     ,  -- ��������
                                               created_by                        ,  -- ������ ���
                                               created_dept_code                 ,  -- ���� �μ�
                                               created_dept_name                 ,  -- ���� �μ���
                                               batch_date                        ,  -- ������ǥ ����
                                               last_update_date                  ,  -- ���� ��������
                                               last_update_login                 ,  -- ���� ������ Log-In ID
                                               last_updated_by                   ,  -- ���� ������ ���
                                               relation_invoice_group_id         ,  -- ��� ��ǥ Invoice_group_id
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
         SELECT v_invoice_group_id                     ,  -- �������� ��ǥ Grouping ID
                v_approval_num                         ,  -- ���� ��ȣ
                eihi.approval_name||' ���'            ,  -- ���� ��
                eihi.source                            ,  -- �߻�System (ADD-ON, FI)
                '1'                                    ,  -- ���� �Ϸ� Flag(1:������, 9:�Ϸ�) eihi.complete_flag
                NULL                                   ,  -- FI Interface �Ϸ� Flag(N:�̿Ϸ�, Y:�Ϸ�)
                eihi.approval_id_1                     ,  -- ���� ������ ID current_approval_id
                eihi.account_dept_code                 ,  -- ȸ��踮 �μ��ڵ�
                eihi.secretary_dept_code               ,  -- �񼭽� �μ��ڵ�
                eihi.approval_id_last                  ,  -- ������ ID(���� ����� ȸ��踮, �񼭽Ǽ�)
                eihi.approval_id_1                     ,  -- ������1 ID
                eihi.approval_jik_1                    ,  -- ������1 ����
                eihi.approval_name_1                   ,  -- ������1 ����
                NULL                                   ,  -- ��ǥ ó�� ����
                NULL                                   ,  -- ��ǥ ����(����, �ݷ�, ����)
                eihi.approval_id_2                     ,  -- ������2 ID
                eihi.approval_jik_2                    ,  -- ������2 ����
                eihi.approval_name_2                   ,  -- ������2 ����
                NULL                                   ,  -- ��ǥ ó�� ����
                NULL                                   ,  -- ��ǥ ����(����, �ݷ�, ����)
                eihi.approval_id_3                     ,  -- ������3 ID
                eihi.approval_jik_3                    ,  -- ������3 ����
                eihi.approval_name_3                   ,  -- ������3 ����
                NULL                                   ,  -- ��ǥ ó�� ����
                NULL                                   ,  -- ��ǥ ����(����, �ݷ�, ����)
                eihi.approval_id_4                     ,  -- ������4 ID
                eihi.approval_jik_4                    ,  -- ������4 ����
                eihi.approval_name_4                   ,  -- ������4 ����
                NULL                                   ,  -- ��ǥ ó�� ����
                NULL                                   ,  -- ��ǥ ����(����, �ݷ�, ����)
                eihi.approval_id_5                     ,  -- ������5 ID
                eihi.approval_jik_5                    ,  -- ������5 ����
                eihi.approval_name_5                   ,  -- ������5 ����
                NULL                                   ,  -- ��ǥ ó�� ����
                NULL                                   ,  -- ��ǥ ����(����, �ݷ�, ����)
                eihi.approval_id_6                     ,  -- ������6 ID
                eihi.approval_jik_6                    ,  -- ������6 ����
                eihi.approval_name_6                   ,  -- ������6 ����
                NULL                                   ,  -- ��ǥ ó�� ����
                NULL                                   ,  -- ��ǥ ����(����, �ݷ�, ����)
                eihi.approval_id_7                     ,  -- ������7 ID
                eihi.approval_jik_7                    ,  -- ������7 ����
                eihi.approval_name_7                   ,  -- ������7 ����
                NULL                                   ,  -- ��ǥ ó�� ����
                NULL                                   ,  -- ��ǥ ����(����, �ݷ�, ����)
                eihi.approval_id_8                     ,  -- ������8 ID
                eihi.approval_jik_8                    ,  -- ������8 ����
                eihi.approval_name_8                   ,  -- ������8 ����
                NULL                                   ,  -- ��ǥ ó�� ����
                NULL                                   ,  -- ��ǥ ����(����, �ݷ�, ����)
                eihi.approval_id_9                     ,  -- ������9 ID
                eihi.approval_jik_9                    ,  -- ������9 ����
                eihi.approval_name_9                   ,  -- ������9 ����
                NULL                                   ,  -- ��ǥ ó�� ����
                NULL                                   ,  -- ��ǥ ����(����, �ݷ�, ����)
                eihi.approval_id_10                    ,  -- ȸ��踮 ������ ID
                eihi.approval_jik_10                   ,  -- ������10 ����
                eihi.approval_name_10                  ,  -- ������10 ����
                NULL                                   ,  -- ��ǥ ó�� ����
                NULL                                   ,  -- ��ǥ ����(����, �ݷ�, ����)
                eihi.approval_id_11                    ,  -- �񼭽� ������ ID
                eihi.approval_jik_11                   ,  -- ������11 ����
                eihi.approval_name_11                  ,  -- ������11 ����
                NULL                                   ,  -- ��ǥ ó�� ����
                NULL                                   ,  -- ��ǥ ����(����, �ݷ�, ����)
                SYSDATE                                ,  -- ��������
                -1                                     ,  -- ������ ���
                eihi.created_dept_code                 ,  -- ���� �μ�
                eihi.created_dept_name                 ,  -- ���� �μ���
                eihi.batch_date                        ,  -- ������ǥ ���� ??????????
                SYSDATE                                ,  -- ���� ��������
                -1                                     ,  -- ���� ������ Log-In ID
                -1                                     ,  -- ���� ������ ���
                pv_invoice_group_id                    ,  -- ��� ��ǥ Invoice_group_id
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
         AND    eihi.source                     = 'A'                         -- Add-On �ڷḸ
         AND    NVL(eihi.complete_flag,  '1')   = '9'                         -- ����Ϸ�� �ڷḸ
         AND    NVL(eihi.interface_flag, 'N')   = 'Y' ;

         v_header_creation := TRUE ;
      EXCEPTION
         WHEN OTHERS THEN
            v_header_creation := FALSE ;
            RAISE HEADER_EXCEPTION ;
      END ;

      IF v_header_creation THEN
         -- Line ���� ����
         BEGIN
            INSERT INTO efin_invoice_lines_itf@crp ( seq                                           ,  -- (����) Interface Sequence
                                                 batch_date                                    ,  -- (����) Batch �������� EFIN_BATCH_FLAG���̺� �Էµ� ��¥
                                                 invoice_group_id                              ,  -- (����) �������� ��ǥ Grouping ID
                                                 status                                        ,  -- (����) Interface ����(�ʱ�:NEW, �Ϸ�:INTERFACED)
                                                 module_name                                   ,  -- (����) FI ���(GL, AP)
                                                 error_msg                                     ,  -- (����) Error �� MESSAGE
                                                 creation_date                                 ,  -- (����) ��������
                                                 created_by                                    ,  -- (����) ������ ���
                                                 last_update_date                              ,  -- (����) ���� ��������
                                                 last_update_login                             ,  -- (����) ���� ������ Log-In ID
                                                 last_updated_by                               ,  -- (����) ���� ������ ���
                                                 attribute1                                    ,  -- (����) 
                                                 attribute2                                    ,  -- (����)
                                                 attribute3                                    ,  -- (����)
                                                 attribute4                                    ,  -- (����)
                                                 attribute5                                    ,  -- (����)
                                                 attribute6                                    ,  -- (����)
                                                 attribute7                                    ,  -- (����)
                                                 attribute8                                    ,  -- (����)
                                                 attribute9                                    ,  -- (����)
                                                 attribute10                                   ,  -- (����)
                                                 attribute11                                   ,  -- (����)
                                                 attribute12                                   ,  -- (����)
                                                 attribute13                                   ,  -- (����)
                                                 attribute14                                   ,  -- (����)
                                                 attribute15                                   ,  -- (����)
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
                                                 validation_flag                               )  -- (GL) ����(C:Customer, V:Vendor)
            SELECT efin_invoice_lines_itf_s.NEXTVAL@crp                   ,  -- (����) Interface Sequence
                   NVL(pv_batch_date, v_batch_date)                   ,  -- (����) Batch �������� EFIN_BATCH_FLAG���̺� �Էµ� ��¥
                   v_invoice_group_id                                 ,  -- (����) �������� ��ǥ Grouping ID
                   eili.status                                        ,  -- (����) Interface ����(�ʱ�:NEW, �Ϸ�:INTERFACED)
                   eili.module_name                                   ,  -- (����) FI ���(GL, AP)
                   eili.error_msg                                     ,  -- (����) Error �� MESSAGE
                   SYSDATE                                            ,  -- (����) ��������
                   -1                                                 ,  -- (����) ������ ���
                   SYSDATE                                            ,  -- (����) ���� ��������
                   -1                                                 ,  -- (����) ���� ������ Log-In ID
                   -1                                                 ,  -- (����) ���� ������ ���
                   eili.attribute1                                    ,  -- (����) 
                   eili.attribute2                                    ,  -- (����)
                   eili.attribute3                                    ,  -- (����)
                   eili.attribute4                                    ,  -- (����)
                   eili.attribute5                                    ,  -- (����)
                   eili.attribute6                                    ,  -- (����)
                   eili.attribute7                                    ,  -- (����)
                   eili.attribute8                                    ,  -- (����)
                   eili.attribute9                                    ,  -- (����)
                   eili.attribute10                                   ,  -- (����)
                   eili.attribute11                                   ,  -- (����)
                   eili.attribute12                                   ,  -- (����)
                   eili.attribute13                                   ,  -- (����)
                   eili.attribute14                                   ,  -- (����)
                   eili.attribute15                                   ,  -- (����)
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
                   eili.validation_flag                                  -- (GL) ����(C:Customer, V:Vendor)
            FROM   efin_invoice_lines_itf@crp eili
            WHERE  eili.invoice_group_id           = pv_invoice_group_id ;
            --ORDER BY eili.seq ;

            v_line_creation := TRUE ;
         EXCEPTION
            WHEN OTHERS THEN
               v_line_creation := FALSE ;
               RAISE LINES_EXCEPTION ;
         END ;
      END IF ; -- header ������ ���� ��쿡�� INSERT

      -- ����ǥ�� - ��ǥ invoice_group_id �� SET
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
          errbuf  := '���Ǻμ� Error' ;

      WHEN HEADER_EXCEPTION THEN
          retcode := '2' ;
          errbuf  := 'Header ���� ������ ���� : '|| SUBSTR(SQLERRM, 1, 200) ;
          ROLLBACK ;

      WHEN LINES_EXCEPTION THEN
          retcode := '2' ;
          errbuf  := 'Line ���� ������ ���� : '|| SUBSTR(SQLERRM, 1, 200) ;
          ROLLBACK ;

      WHEN OTHERS THEN
          retcode := '2' ;
          errbuf  := '�����߻�: '|| SUBSTR(SQLERRM,1,200) ;
          ROLLBACK ;

   END create_reverse_invoice ;


/******************************************************************************/
/*                                                                            */
/* Procedure Name : get_approval_num                                          */
/* Description   : �������� ������� ��ǥ��ȣ�� ���Ѵ�.                     */
/* Change Request Number : 1.0.0.0                                            */
/*                                                                            */
/* Parameters: pv_organization_code : ȸ���ڵ�(A0,B0..)(2)                    */
/*             pv_accounting_date   : ��ǥ����(8)                             */
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
/* Description   : FI AP��ǥ�� ������� ���������� �Ϸ�� Hold�� Release��    */
/* Change Request Number : 1.0.0.0                                            */
/*                                                                            */
/* Parameters: pv_invoice_group_id : ����Ϸ�� ��ǥ�� Invoice_group_id       */
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
         AND    NVL(eihi.source        , 'N') = 'F'                      -- FI �ڷḸ
         AND    NVL(eihi.complete_flag , '1') = '9'                      -- ����Ϸ�� �ڷ�
         AND    NVL(eili.module_name   , 'N') = 'AP' ;                   -- AP �ڷḸ

      v_errbuf                 VARCHAR2(200) ;
      v_retcode                VARCHAR2(200) ;

   BEGIN
      FOR r1 IN c1 LOOP
         BEGIN
            UPDATE ap.ap_holds_all
            SET    release_lookup_code = 'Electronic Approved' ,
                   release_reason      = '���� ���� �Ϸ�'      ,
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
      errbuf  := 'Hold Release �۾��� ���������� �Ϸ� �Ͽ����ϴ�.' ;
      COMMIT ;
   EXCEPTION
      WHEN OTHERS THEN
         retcode := '2' ;
         errbuf  := 'Hold Release �۾��� ������ �߻� �Ͽ����ϴ�.' ;
         ROLLBACK ;
   END hold_released ;

END erpw_invoice_approval_pkg ;
/

