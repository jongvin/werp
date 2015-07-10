CREATE OR REPLACE PROCEDURE Sp_T_Acc_Slip_Body_B_D
(
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER
)
IS
BEGIN
	Sp_T_Acc_Slip_Body_D(AR_SLIP_ID,AR_SLIP_IDSEQ);
END;
/
