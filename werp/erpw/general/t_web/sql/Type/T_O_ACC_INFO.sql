Create Type T_O_ACC_INFO As Object
(
	BANK_MAIN_CODE			Varchar2(4),
	ACCNO					Varchar2(20),
	ACCNO_OWNER				Varchar2(60)
);
/
Create Type T_OA_ACC_INFO As Table Of T_O_ACC_INFO;
/
