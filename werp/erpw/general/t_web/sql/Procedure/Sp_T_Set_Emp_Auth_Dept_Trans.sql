CREATE OR REPLACE PROCEDURE Sp_T_Set_Emp_Auth_Dept_Trans
(
	Ar_EMPNO			VARCHAR2,
	Ar_CRTUSERNO		VARCHAR2,
	Ar_COMP_CODE		VARCHAR2,
	Ar_DEPT_CODE		VARCHAR2
)
IS
	lnAuthChk NUMBER;
BEGIN

	SELECT
		COUNT(*)
	INTO lnAuthChk
	FROM
		T_EMPNO_AUTH a
	WHERE
		a.EMPNO = Ar_EMPNO;
		
	IF lnAuthChk = 1 THEN
		DELETE	T_EMPNO_AUTH_DEPT
		WHERE	EMPNO = Ar_EMPNO;
	
		DELETE	T_EMPNO_AUTH_COMP
		WHERE	EMPNO = Ar_EMPNO;
		
		IF Ar_COMP_CODE IS NOT NULL AND Ar_DEPT_CODE IS NOT NULL THEN	
			INSERT INTO T_EMPNO_AUTH_COMP
			(
				EMPNO,
				COMP_CODE,
				CRTUSERNO,
				CRTDATE
			)
			VALUES
			(
				Ar_EMPNO,
				Ar_COMP_CODE,
				Ar_CRTUSERNO,
				SYSDATE
			);
			INSERT INTO T_EMPNO_AUTH_DEPT
			(
				EMPNO,
				COMP_CODE,
				DEPT_CODE,
				CRTUSERNO,
				CRTDATE
			)
			VALUES
			(
				Ar_EMPNO,
				Ar_COMP_CODE,
				Ar_DEPT_CODE,
				Ar_CRTUSERNO,
				SYSDATE
			);
		END IF;
		
	END IF;
END;
/
