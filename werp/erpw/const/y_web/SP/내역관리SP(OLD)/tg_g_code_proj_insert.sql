/* ========================================================================= */
/* 시스템 : 공통관리                                                  */
/* 함수명 : tg_g_code_proj_insert(현장입력)                                */
/* 기  능 :                            */
/* ===========================[ 변   경   이   력 ]========================= */
/*      작 성 자    소     속             작 성 일      비         고        */
/*   ------------  -------------------  ------------  ---------------------- */
/*   1. 이주완                           2001.09.20       최초작성           */
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
