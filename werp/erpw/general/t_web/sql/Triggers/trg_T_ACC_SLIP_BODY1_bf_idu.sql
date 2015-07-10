CREATE OR REPLACE TRIGGER "ERPW".trg_T_ACC_SLIP_BODY1_bf_idu
AFTER INSERT OR UPDATE OR DELETE ON T_ACC_SLIP_BODY1
FOR EACH ROW
BEGIN
	IF INSERTING OR UPDATING THEN
		IF :NEW.RESET_SLIP_IDSEQ IS NOT NULL AND :NEW.TRANSFER_TAG = 'F' AND :NEW.IGNORE_SET_RESET_TAG = 'F'
		THEN
			MERGE INTO T_ACC_SLIP_REMAIN D
			USING
			(
				SELECT
					:NEW.SLIP_ID SLIP_ID,
					:NEW.SLIP_IDSEQ SLIP_IDSEQ,
					:NEW.COMP_CODE COMP_CODE,
					:NEW.DEPT_CODE DEPT_CODE,
					:NEW.ACC_CODE ACC_CODE,
					:NEW.CUST_SEQ CUST_SEQ,
					:NEW.MAKE_DT MAKE_DT,
					:NEW.KEEP_DT KEEP_DT,
					:NEW.TRANSFER_TAG TRANSFER_TAG,
					:NEW.SLIP_KIND_TAG SLIP_KIND_TAG,
					NULL COMPL_DT,
					:NEW.DB_AMT DB_AMT,
					:NEW.CR_AMT CR_AMT,
					:NEW.RESET_SLIP_ID RESET_SLIP_ID,
					:NEW.RESET_SLIP_IDSEQ RESET_SLIP_IDSEQ
				FROM
					DUAL
			) S
			ON
			(
				D.SLIP_ID = S.SLIP_ID
				AND D.SLIP_IDSEQ = S.SLIP_IDSEQ
			)
			WHEN MATCHED THEN
				UPDATE SET
					d.COMP_CODE = s.COMP_CODE,
					d.DEPT_CODE = s.DEPT_CODE,
					d.ACC_CODE = s.ACC_CODE,
					d.CUST_SEQ = s.CUST_SEQ,
					d.MAKE_DT = s.MAKE_DT,
					d.KEEP_DT = s.KEEP_DT,
					d.TRANSFER_TAG = s.TRANSFER_TAG,
					d.SLIP_KIND_TAG = s.SLIP_KIND_TAG,
					d.COMPL_DT = s.COMPL_DT,
					d.DB_AMT = s.DB_AMT,
					d.CR_AMT = s.CR_AMT,
					d.RESET_SLIP_ID = s.RESET_SLIP_ID,
					d.RESET_SLIP_IDSEQ = s.RESET_SLIP_IDSEQ
			WHEN NOT MATCHED THEN
				INSERT (
					d.SLIP_IDSEQ,
					d.SLIP_ID,
					d.COMP_CODE,
					d.DEPT_CODE,
					d.ACC_CODE,
					d.CUST_SEQ,
					d.MAKE_DT,
					d.KEEP_DT,
					d.TRANSFER_TAG,
					d.SLIP_KIND_TAG,
					d.COMPL_DT,
					d.DB_AMT,
					d.CR_AMT,
					d.RESET_SLIP_ID,
					d.RESET_SLIP_IDSEQ
				) VALUES (
					s.SLIP_IDSEQ,
					s.SLIP_ID,
					s.COMP_CODE,
					s.DEPT_CODE,
					s.ACC_CODE,
					s.CUST_SEQ,
					s.MAKE_DT,
					s.KEEP_DT,
					s.TRANSFER_TAG,
					s.SLIP_KIND_TAG,
					s.COMPL_DT,
					s.DB_AMT,
					s.CR_AMT,
					s.RESET_SLIP_ID,
					s.RESET_SLIP_IDSEQ
				);
		ELSE
			DELETE FROM T_ACC_SLIP_REMAIN
			WHERE
				SLIP_ID	= :NEW.SLIP_ID
				AND SLIP_IDSEQ = :NEW.SLIP_IDSEQ;
		END IF;
	ELSIF DELETING THEN
		DELETE FROM T_ACC_SLIP_REMAIN
		WHERE
			SLIP_ID	= :OLD.SLIP_ID
			AND SLIP_IDSEQ = :OLD.SLIP_IDSEQ;
	END IF;

	IF ( :OLD.RESET_SLIP_IDSEQ IS NOT NULL ) OR ( :NEW.RESET_SLIP_IDSEQ IS NOT NULL ) THEN
		MERGE INTO T_ACC_SLIP_REMAIN D
		USING
		(
			SELECT
				A.SLIP_ID,
				A.SLIP_IDSEQ,
				A.COMP_CODE,
				A.DEPT_CODE,
				A.ACC_CODE,
				A.CUST_SEQ,
				A.MAKE_DT,
				A.KEEP_DT,
				A.DB_AMT,
				A.CR_AMT,
				A.RESET_SLIP_ID,
				A.RESET_SLIP_IDSEQ,
				A.TRANSFER_TAG,
				A.SLIP_KIND_TAG,
				DECODE(B.COMPL_DT, NULL, F_T_StringToDate('99991231'), B.COMPL_DT) COMPL_DT
			FROM
				T_ACC_SLIP_REMAIN A,
				(
					SELECT
							A.SLIP_ID,
							A.SLIP_IDSEQ,
							F_T_Stringtodate(A.MAKE_DT) COMPL_DT
					FROM
					(
						SELECT
							A.RESET_SLIP_ID SLIP_ID,
							A.RESET_SLIP_IDSEQ SLIP_IDSEQ,
							-- ����
							DECODE(B.ACC_REMAIN_POSITION, 'D', 1, -1)*NVL(A.DB_AMT1,0)
							+
							DECODE(B.ACC_REMAIN_POSITION, 'C', 1, -1)*NVL(A.CR_AMT1,0) SET_AMT,
							-- ����Ȯ��
							DECODE(B.ACC_REMAIN_POSITION, 'D', -1, 1)*NVL(A.DB_AMT2,0)
							+
							DECODE(B.ACC_REMAIN_POSITION, 'C', -1, 1)*NVL(A.CR_AMT2,0) RESET_AMT,
							A.MAKE_DT
						FROM
						(
							SELECT
								A.RESET_SLIP_ID,
								A.RESET_SLIP_IDSEQ,
								MAX( DECODE(A.SLIP_IDSEQ, A.RESET_SLIP_IDSEQ , A.ACC_CODE, NULL ) ) ACC_CODE,
								NVL(SUM( DECODE(A.SLIP_IDSEQ, A.RESET_SLIP_IDSEQ , A.DB_AMT, 0 ) ), 0) DB_AMT1,
								NVL(SUM( DECODE(A.SLIP_IDSEQ, A.RESET_SLIP_IDSEQ , A.CR_AMT, 0 ) ), 0) CR_AMT1,
								NVL(SUM( DECODE(A.SLIP_IDSEQ, A.RESET_SLIP_IDSEQ , 0, A.DB_AMT ) ), 0) DB_AMT2,
								NVL(SUM( DECODE(A.SLIP_IDSEQ, A.RESET_SLIP_IDSEQ , 0, A.CR_AMT ) ), 0) CR_AMT2,
								MAX( DECODE(A.SLIP_IDSEQ, A.RESET_SLIP_IDSEQ , NULL, F_T_Datetostring(A.MAKE_DT) ) ) MAKE_DT
							FROM
								T_ACC_SLIP_REMAIN A
							WHERE
								(
									(
										A.RESET_SLIP_ID = :OLD.RESET_SLIP_ID
										AND
										A.RESET_SLIP_IDSEQ = :OLD.RESET_SLIP_IDSEQ
									)
									OR
									(
										A.RESET_SLIP_ID = :NEW.RESET_SLIP_ID
										AND
										A.RESET_SLIP_IDSEQ = :NEW.RESET_SLIP_IDSEQ
									)
								)
								AND A.KEEP_DT IS NOT NULL
							GROUP BY
								A.RESET_SLIP_ID,
								A.RESET_SLIP_IDSEQ
						) A,
						T_ACC_CODE B
						WHERE
							A.ACC_CODE = B.ACC_CODE
					) A
					WHERE
						A.SET_AMT = A.RESET_AMT
				) B
			WHERE
				A.SLIP_ID = B.SLIP_ID(+)
				AND A.SLIP_IDSEQ = B.SLIP_IDSEQ(+)
				AND
				(
					(
						A.SLIP_ID = :OLD.RESET_SLIP_ID
						AND
						A.SLIP_IDSEQ = :OLD.RESET_SLIP_IDSEQ
					)
					OR
					(
						A.SLIP_ID = :NEW.RESET_SLIP_ID
						AND
						A.SLIP_IDSEQ = :NEW.RESET_SLIP_IDSEQ
					)
				)
		) S
		ON
		(
			D.SLIP_ID = S.SLIP_ID
			AND D.SLIP_IDSEQ = S.SLIP_IDSEQ
		)
		WHEN MATCHED THEN
			UPDATE SET
				d.COMP_CODE = s.COMP_CODE,
				d.DEPT_CODE = s.DEPT_CODE,
				d.ACC_CODE = s.ACC_CODE,
				d.CUST_SEQ = s.CUST_SEQ,
				d.MAKE_DT = s.MAKE_DT,
				d.KEEP_DT = s.KEEP_DT,
				d.TRANSFER_TAG = s.TRANSFER_TAG,
				d.SLIP_KIND_TAG = s.SLIP_KIND_TAG,
				d.COMPL_DT = s.COMPL_DT,
				d.DB_AMT = s.DB_AMT,
				d.CR_AMT = s.CR_AMT,
				d.RESET_SLIP_ID = s.RESET_SLIP_ID,
				d.RESET_SLIP_IDSEQ = s.RESET_SLIP_IDSEQ
		WHEN NOT MATCHED THEN
			INSERT (
				d.SLIP_IDSEQ,
				d.SLIP_ID,
				d.COMP_CODE,
				d.DEPT_CODE,
				d.ACC_CODE,
				d.CUST_SEQ,
				d.MAKE_DT,
				d.KEEP_DT,
				d.TRANSFER_TAG,
				d.SLIP_KIND_TAG,
				d.COMPL_DT,
				d.DB_AMT,
				d.CR_AMT,
				d.RESET_SLIP_ID,
				d.RESET_SLIP_IDSEQ
			) VALUES (
				s.SLIP_IDSEQ,
				s.SLIP_ID,
				s.COMP_CODE,
				s.DEPT_CODE,
				s.ACC_CODE,
				s.CUST_SEQ,
				s.MAKE_DT,
				s.KEEP_DT,
				s.TRANSFER_TAG,
				s.SLIP_KIND_TAG,
				s.COMPL_DT,
				s.DB_AMT,
				s.CR_AMT,
				s.RESET_SLIP_ID,
				s.RESET_SLIP_IDSEQ
			);
	END IF;

	EXCEPTION
		WHEN OTHERS THEN
		-- Consider logging the error and then re-raise
		NULL;
END;