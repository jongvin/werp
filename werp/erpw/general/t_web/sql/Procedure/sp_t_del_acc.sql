create or replace procedure sp_t_del_acc
(
	ar_acc_code				varchar2
)
is
Begin
	delete T_GRP_ACC_CODE
	where acc_code = ar_acc_code;

	delete T_WORK_ACC_CODE
	where acc_code = ar_acc_code;

	delete T_ACC_CODE
	where acc_code = ar_acc_code;
End;
/

exec sp_t_del_acc('532021205');
