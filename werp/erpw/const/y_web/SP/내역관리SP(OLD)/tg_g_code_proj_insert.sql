/* ========================================================================= */
/* �ý��� : �������                                                  */
/* �Լ��� : tg_g_code_proj_insert(�����Է�)                                */
/* ��  �� :                            */
/* ===========================[ ��   ��   ��   �� ]========================= */
/*      �� �� ��    ��     ��             �� �� ��      ��         ��        */
/*   ------------  -------------------  ------------  ---------------------- */
/*   1. ���ֿ�                           2001.09.20       �����ۼ�           */
/* ========================================================================= */

CREATE OR REPLACE TRIGGER "CATS".TI_G_CODE_PROJ 
AFTER INSERT ON CATS.G_CODE_PROJ REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW 
BEGIN
 IF inserting THEN
   insert into g_code_proj_detail (proj_code, proj_name, degree, last_degree, process_code)
   values ( :new.proj_code, :new.proj_name, 1, 'Y', '02');
 END IF;
END TI_G_CODE_PROJ;

/
