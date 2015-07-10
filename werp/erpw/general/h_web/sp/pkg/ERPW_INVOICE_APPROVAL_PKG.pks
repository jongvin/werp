CREATE OR REPLACE PACKAGE      erpw_invoice_approval_pkg AS
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
                                      pv_batch_date        IN  DATE     ) ;


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
                                pv_approval_num      OUT VARCHAR2 ) ;

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
                             pv_invoice_group_id      NUMBER   ) ;

END erpw_invoice_approval_pkg ;
/

