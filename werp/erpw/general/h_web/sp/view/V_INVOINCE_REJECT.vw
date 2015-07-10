CREATE OR REPLACE FORCE VIEW V_INVOINCE_REJECT
(INVOICE_GROUP_ID, APPROVAL_NUM, APPROVAL_NAME, CHK_1)
AS 
SELECT C.INVOICE_GROUP_ID,
       C.APPROVAL_NUM,
       C.APPROVAL_NAME,
       DECODE(c.complete_flag,'1','������',DECODE(c.complete_flag,'3','�ݼ�',DECODE(c.complete_flag,'9',DECODE(c.relation_invoice_group_id,NULL,'����Ϸ�','�����ǥ')))) chk_1
FROM efin_invoice_header_itf  c  
WHERE DECODE(c.complete_flag,NULL,'Y',DECODE(c.complete_flag,'3','Y',DECODE(c.complete_flag,'9',DECODE(c.relation_invoice_group_id,NULL,'N','Y'),'N'))) = 'Y';



