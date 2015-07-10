Create Or Replace Procedure SP_T_CUST_CODE_I
(
	AR_CUST_SEQ                                NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_CUST_CODE                               VARCHAR2,
	AR_CUST_NAME                               VARCHAR2,
	AR_BOSS_NAME                               VARCHAR2,
	AR_TRADE_CLS                               VARCHAR2,
	AR_BIZCOND                                 VARCHAR2,
	AR_BIZKND                                  VARCHAR2,
	AR_ZIPCODE                                 VARCHAR2,
	AR_ADDR1                                   VARCHAR2,
	AR_ADDR2                                   VARCHAR2,
	AR_TELNO                                   VARCHAR2,
	AR_GROUP_COMP_CLS                          VARCHAR2,
	AR_USE_CLS                                 VARCHAR2,
	AR_REPRESENT_CUST_SEQ                      NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_CUST_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_CUST_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-11-28)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	--ȸ�� ���� ��û���׿� ���� ����.
	--������� ��� ȭ�鿡 �ʿ��� ��� ������ �ʼ��� �ش޶�!
	If Ar_TRADE_CLS = '1' Or LengthB(F_T_CUST_UMASK(AR_CUST_CODE)) = 10 Then
		If Ar_CUST_NAME Is Null Then
			Raise_Application_Error(-20009,'�ŷ�ó���� �ʼ������Դϴ�.');
		End If;
		If Ar_BIZCOND Is Null Then
			Raise_Application_Error(-20009,'���´� �ʼ������Դϴ�.');
		End If;
		If Ar_BIZKND Is Null Then
			Raise_Application_Error(-20009,'������ �ʼ������Դϴ�.');
		End If;
		If Ar_ZIPCODE Is Null Then
			Raise_Application_Error(-20009,'�����ȣ�� �ʼ������Դϴ�.');
		End If;
		If Ar_ADDR1 Is Null Then
			Raise_Application_Error(-20009,'�ּҴ� �ʼ������Դϴ�.');
		End If;
		If Ar_TELNO Is Null Then
			Raise_Application_Error(-20009,'��ȭ��ȣ�� �ʼ������Դϴ�.');
		End If;
	End If;
	Insert Into T_CUST_CODE
	(
		CUST_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CUST_CODE,
		CUST_NAME,
		BOSS_NAME,
		TRADE_CLS,
		BIZCOND,
		BIZKND,
		ZIPCODE,
		ADDR1,
		ADDR2,
		TELNO,
		GROUP_COMP_CLS,
		USE_CLS,
		REPRESENT_CUST_SEQ
	)
	Values
	(
		AR_CUST_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		F_T_CUST_UMASK(AR_CUST_CODE),
		AR_CUST_NAME,
		AR_BOSS_NAME,
		AR_TRADE_CLS,
		AR_BIZCOND,
		AR_BIZKND,
		REPLACE(AR_ZIPCODE, '-', NULL),
		AR_ADDR1,
		AR_ADDR2,
		AR_TELNO,
		AR_GROUP_COMP_CLS,
		AR_USE_CLS,
		AR_REPRESENT_CUST_SEQ
	);
End;
/
Create Or Replace Procedure SP_T_CUST_CODE_U
(
	AR_CUST_SEQ                                NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_CUST_CODE                               VARCHAR2,
	AR_CUST_NAME                               VARCHAR2,
	AR_BOSS_NAME                               VARCHAR2,
	AR_TRADE_CLS                               VARCHAR2,
	AR_BIZCOND                                 VARCHAR2,
	AR_BIZKND                                  VARCHAR2,
	AR_ZIPCODE                                 VARCHAR2,
	AR_ADDR1                                   VARCHAR2,
	AR_ADDR2                                   VARCHAR2,
	AR_TELNO                                   VARCHAR2,
	AR_GROUP_COMP_CLS                          VARCHAR2,
	AR_USE_CLS                                 VARCHAR2,
	AR_REPRESENT_CUST_SEQ                      NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_CUST_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_CUST_CODE ���̺� Update
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-11-28)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	--ȸ�� ���� ��û���׿� ���� ����.
	--������� ��� ȭ�鿡 �ʿ��� ��� ������ �ʼ��� �ش޶�!
	If Ar_TRADE_CLS = '1' Or LengthB(F_T_CUST_UMASK(AR_CUST_CODE)) = 10 Then
		If Ar_CUST_NAME Is Null Then
			Raise_Application_Error(-20009,'�ŷ�ó���� �ʼ������Դϴ�.');
		End If;
		If Ar_BIZCOND Is Null Then
			Raise_Application_Error(-20009,'���´� �ʼ������Դϴ�.');
		End If;
		If Ar_BIZKND Is Null Then
			Raise_Application_Error(-20009,'������ �ʼ������Դϴ�.');
		End If;
		If Ar_ZIPCODE Is Null Then
			Raise_Application_Error(-20009,'�����ȣ�� �ʼ������Դϴ�.');
		End If;
		If Ar_ADDR1 Is Null Then
			Raise_Application_Error(-20009,'�ּҴ� �ʼ������Դϴ�.');
		End If;
		If Ar_TELNO Is Null Then
			Raise_Application_Error(-20009,'��ȭ��ȣ�� �ʼ������Դϴ�.');
		End If;
	End If;
	Update T_CUST_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		CUST_CODE = F_T_CUST_UMASK(AR_CUST_CODE),
		CUST_NAME = AR_CUST_NAME,
		BOSS_NAME = AR_BOSS_NAME,
		TRADE_CLS = AR_TRADE_CLS,
		BIZCOND = AR_BIZCOND,
		BIZKND = AR_BIZKND,
		ZIPCODE = REPLACE(AR_ZIPCODE, '-', NULL),
		ADDR1 = AR_ADDR1,
		ADDR2 = AR_ADDR2,
		TELNO = AR_TELNO,
		GROUP_COMP_CLS = AR_GROUP_COMP_CLS,
		USE_CLS = AR_USE_CLS,
		REPRESENT_CUST_SEQ = AR_REPRESENT_CUST_SEQ
	Where	CUST_SEQ = AR_CUST_SEQ;
End;
/
Create Or Replace Procedure SP_T_CUST_CODE_D
(
	AR_CUST_SEQ                                NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_CUST_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_CUST_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-11-28)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_CUST_CODE
	Where	CUST_SEQ = AR_CUST_SEQ;
End;
/
