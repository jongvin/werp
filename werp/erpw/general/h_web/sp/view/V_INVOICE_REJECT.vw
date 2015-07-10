CREATE OR REPLACE FORCE VIEW V_INVOICE_REJECT
(INVOICE_GROUP_ID, APPROVAL_NUM, APPROVAL_NAME, CHK_1, DEPT_CODE)
AS 
SELECT C.INVOICE_GROUP_ID,
       C.APPROVAL_NUM,
       C.APPROVAL_NAME,
       DECODE(c.complete_flag,'1','결재중',DECODE(c.complete_flag,'3','반송',DECODE(c.complete_flag,'9',DECODE(c.relation_invoice_group_id,NULL,'결재완료','취소전표')))) chk_1,
       c.created_dept_code
FROM efin_invoice_header_itf  c  
WHERE DECODE(c.complete_flag,'3','Y',DECODE(c.complete_flag,'9',DECODE(c.relation_invoice_group_id,NULL,'N','Y'),'N')) = 'Y';



