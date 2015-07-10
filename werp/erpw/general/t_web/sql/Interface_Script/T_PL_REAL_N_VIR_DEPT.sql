Create Or Replace View T_PL_REAL_N_VIR_DEPT
(
	DEPT_CODE ,
	CRTUSERNO ,
	CRTDATE ,
	MODUSERNO ,
	MODDATE ,
	COMP_CODE,
	DEPT_NAME ,
	DEPT_SHORT_NAME,
	IS_REAL_DEPT,
	DEPT_PROJ_TAG
)
As
Select
	a.DEPT_CODE ,
	a.CRTUSERNO ,
	a.CRTDATE ,
	a.MODUSERNO ,
	a.MODDATE ,
	a.COMP_CODE,
	a.DEPT_NAME ,
	a.DEPT_SHORT_NAME,
	'T' IS_REAL_DEPT,
	a.DEPT_PROJ_TAG
From	T_DEPT_CODE a
Union
Select
	a.V_DEPT_CODE ,
	a.CRTUSERNO ,
	a.CRTDATE ,
	a.MODUSERNO ,
	a.MODDATE ,
	a.COMP_CODE ,
	a.DEPT_NAME ,
	a.DEPT_SHORT_NAME,
	'F' ,
	'P' DEPT_PROJ_TAG
From	T_PL_VIRTUAL_DEPT a
/