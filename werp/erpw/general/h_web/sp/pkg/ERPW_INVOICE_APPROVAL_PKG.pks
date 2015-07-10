CREATE OR REPLACE PACKAGE      erpw_invoice_approval_pkg AS
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
                                      pv_batch_date        IN  DATE     ) ;


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
                                pv_approval_num      OUT VARCHAR2 ) ;

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
                             pv_invoice_group_id      NUMBER   ) ;

END erpw_invoice_approval_pkg ;
/

