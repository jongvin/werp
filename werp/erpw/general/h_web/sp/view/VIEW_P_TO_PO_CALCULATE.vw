CREATE OR REPLACE FORCE VIEW VIEW_P_TO_PO_CALCULATE
(COMP_CODE, DEPT_CODE, GRADE_CODE, WORK_YEAR, PO_01, 
 PO_02, PO_03, PO_04, PO_05, PO_06, 
 PO_07, PO_08, PO_09, PO_10, PO_11, 
 PO_12)
AS 
select a.comp_code,         a.dept_code,         a.grade_code,         trunc(a.work_date,'yyyy') work_year,         sum(decode(to_char(a.work_date,'mm'),'01',a.work_cnt,0)) po_01,          sum(decode(to_char(a.work_date,'mm'),'02',a.work_cnt,0)) po_02,          sum(decode(to_char(a.work_date,'mm'),'03',a.work_cnt,0)) po_03,          sum(decode(to_char(a.work_date,'mm'),'04',a.work_cnt,0)) po_04,          sum(decode(to_char(a.work_date,'mm'),'05',a.work_cnt,0)) po_05,          sum(decode(to_char(a.work_date,'mm'),'06',a.work_cnt,0)) po_06,          sum(decode(to_char(a.work_date,'mm'),'07',a.work_cnt,0)) po_07,          sum(decode(to_char(a.work_date,'mm'),'08',a.work_cnt,0)) po_08,          sum(decode(to_char(a.work_date,'mm'),'09',a.work_cnt,0)) po_09,          sum(decode(to_char(a.work_date,'mm'),'10',a.work_cnt,0)) po_10,          sum(decode(to_char(a.work_date,'mm'),'11',a.work_cnt,0)) po_11,          sum(decode(to_char(a.work_date,'mm'),'12',a.work_cnt,0)) po_12       from p_to_po_calculate a       group by a.comp_code,a.dept_code,a.grade_code,              trunc(a.work_date,'yyyy');



