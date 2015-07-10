Create Or Replace Function F_F�ڱ�û���ڷ����
(
	ar_�����ڵ�			Varchar2,
	ar_�ڱ�û��ȸ��     Number,
	ar_�����id			Varchar2,
	ar_errm			Out	Varchar2
)
Return Boolean
Is
-- ���α׷��� ���� : ��ǥ���� �����ް���ݵ��� �̺���ǥ�� ���(�����ܰ�,�����)��
-- �����Ͽ� ��� û���� ����, ����� ���������� ��û���� ������ �����ϰ� ����
    lsStep              Varchar2(2000) := 'Start ';
    lnCnt               Number;
    RInsert             Ft1_�ڱ�û���ڷ�%RowType;
    RInfo               Ft1_�ڱ�û���۾�%RowType;
--�����ڵ� ���Ǻ� (��񱸺��� ����)
    ls����              at9_�����ڵ�.�����ڵ�%Type:= '1001';
    ls�빫              at9_�����ڵ�.�����ڵ�%Type:= '1002';
    ls���              at9_�����ڵ�.�����ڵ�%Type:= '1003';
    ls����              at9_�����ڵ�.�����ڵ�%Type:= '1004';
    ls���              at9_�����ڵ�.�����ڵ�%Type:= '1005';
    ls�����            at9_�����ڵ�.�����ڵ�%Type:= '1006';
--����߻� �̺� ����
    Cursor CurA
    Is
    select
        RInfo.�����ڵ� �����ڵ�,
        RInfo.�ڱ�û��ȸ��,
        a.��ǥ��ȣ û����ǥ��ȣ,
        a.��ǥ���� û����ǥ����,
        a.�����ڵ� ,
        a.�ŷ�ó�ڵ�,
        a.�ŷ�ó�����,
        a.�ŷ�ó��,
        0 �������̺��ܾ�,
        0 ����̺ҹ���,
        a.�뺯�ݾ� ����̺ҹ߻�,
        0 ������̺��ܾ�,
        0 ��û������,
        0 ���û����,
        a.�����ڵ�,
        a.����1,
        a.����2,
        a.�뺯�ݾ� ��ǥ�ݾ�,
        'N' ����Ȯ��,
        '0' û��Ȯ��,           -- �߰��� �׸�
        ar_�����id �����,
        Sysdate �����
    From
        at1_��ǥ�� a,
        at1_��ǥ�� b
    Where   a.��ǥ��ȣ = b.��ǥ��ȣ
    And     a.�ͼӺμ����� = ar_�����ڵ�
    And     b.Ȯ���� Between RInfo.�Ⱓfrom And Last_Day(RInfo.�Ⱓto)
    and     a.������ǥ��ȣ is null
    And     Nvl(a.�뺯�ݾ�,0) <> 0
    And     To_Char(b.Ȯ����,'MMDD') <> '0101'
    And     Exists
    (
        Select  Null
        From    ft1_�ڱ�û���������� n
        Where   n.������ = '2'          -- �̺�
        And     n.�����ڵ� = a.�����ڵ�
    )
    And not Exists
    (
        Select Null
        From ft1_�ڱ�û���ڷ� z
        Where z.�����ڵ� = a.�ͼӺμ�����
        And   z.û����ǥ��ȣ = a.��ǥ��ȣ
        And   z.û����ǥ���� = a.��ǥ����
        And   z.û��_Ȯ�� = '1'
    );
-- ������ �̺��ܾ� ��������
    Cursor CurB
    Is
    select
        RInfo.�����ڵ� �����ڵ�,
        RInfo.�ڱ�û��ȸ��,
        a.��ǥ��ȣ û����ǥ��ȣ,
        a.��ǥ���� û����ǥ����,
        a.�����ڵ� ,
        a.�ŷ�ó�ڵ�,
        a.�ŷ�ó�����,
        a.�ŷ�ó��,
        Nvl(a.�뺯�ݾ�,0) - Sum(decode(sign(Trunc(RInfo.�Ⱓfrom,'MM') - d.Ȯ����),1,c.�����ݾ�,0)) �������̺��ܾ�,
        0 ����̺ҹ���,
        0 ����̺ҹ߻�,
        0 ������̺��ܾ�,
        0 ��û������,
        0 ���û����,
        a.�����ڵ�,
        a.����1,
        a.����2,
        a.�뺯�ݾ� ��ǥ�ݾ�,
        'N' ����Ȯ��,
        '0' û��Ȯ��,           -- �߰��� �׸�
        ar_�����id �����,
        Sysdate �����
    From
        at1_��ǥ�� a,
        at1_��ǥ�� b,
        at1_�ܾװ��� c,
        at1_��ǥ�� d
    Where   a.��ǥ��ȣ = b.��ǥ��ȣ
    And     b.Ȯ���� < RInfo.�Ⱓfrom + Decode(To_Char(RInfo.�Ⱓfrom,'MMDD'),'0101',1,0)
    And     a.�ͼӺμ����� = RInfo.�����ڵ�
    and     a.������ǥ��ȣ is null
    And     Nvl(a.�뺯�ݾ�,0) <> 0
    And     b.Ȯ���� >= Trunc(rInfo.�Ⱓfrom,'YYYY')
    And     Exists
    (
        Select  Null
        From    ft1_�ڱ�û���������� n
        Where   n.������ = '2'
        And     n.�����ڵ� = a.�����ڵ�
    )
    And     a.��ǥ��ȣ = c.������ǥ��ȣ (+)
    And     a.��ǥ���� = c.������ǥ���� (+)
    And     c.��ǥ��ȣ = d.��ǥ��ȣ (+)
    And not Exists
    (
        Select Null
        From ft1_�ڱ�û���ڷ� z
        Where z.�����ڵ� = a.�ͼӺμ�����
        And   z.û����ǥ��ȣ = a.��ǥ��ȣ
        And   z.û����ǥ���� = a.��ǥ����
        And   z.û��_Ȯ�� = '1'
    )
    Group by
        a.��ǥ��ȣ,
        a.��ǥ����,
        a.�����ڵ�,
        a.�ŷ�ó�ڵ�,
        a.�ŷ�ó�����,
        a.�ŷ�ó��,
        a.�뺯�ݾ�,
        a.�����ڵ�,
        a.����1,
        a.����2
    Having Nvl(a.�뺯�ݾ�,0) - Sum(decode(sign(Trunc(RInfo.�Ⱓfrom,'MM') - d.Ȯ����),1,c.�����ݾ�,0)) <> 0;
--��� �̺ҹ���
    Cursor CurC
    Is
    select
        RInfo.�����ڵ� �����ڵ�,
        RInfo.�ڱ�û��ȸ��,
        a.��ǥ��ȣ û����ǥ��ȣ,
        a.��ǥ���� û����ǥ����,
        a.�����ڵ� ,
        a.�ŷ�ó�ڵ�,
        a.�ŷ�ó�����,
        a.�ŷ�ó��,
        0 �������̺��ܾ�,
        Nvl(Sum(a1.�����ݾ�),0) - Nvl(Sum(a1.�뺯�ݾ�),0)  ����̺ҹ���,
        0 ����̺ҹ߻�,
        0 ������̺��ܾ�,
        0 ��û������,
        0 ���û����,
        a.�����ڵ�,
        a.����1,
        a.����2,
        a.�뺯�ݾ� ��ǥ�ݾ�,
        'N' ����Ȯ��,
        '0' û��Ȯ��,           -- �߰��� �׸�
        ar_�����id �����,
        Sysdate �����
    From
        at1_��ǥ�� a,
        at1_��ǥ�� a1,
        at1_��ǥ�� b,
        at1_��ǥ�� b1
    Where   a.��ǥ��ȣ = b.��ǥ��ȣ
    And     a.�ͼӺμ����� = RInfo.�����ڵ�
    And     Nvl(a.�뺯�ݾ�,0) <> 0
--    And     To_Char(b.Ȯ����,'MMDD') <> '0101'
    And     Exists
    (
        Select  Null
        From    ft1_�ڱ�û���������� n
        Where   n.������ = '2'
        And     n.�����ڵ� = a.�����ڵ�
    )
    And     a.��ǥ��ȣ = a1.������ǥ��ȣ
    And     a.��ǥ���� = a1.������ǥ����
    And     a1.��ǥ��ȣ = b1.��ǥ��ȣ
    And     To_Char(b1.Ȯ����,'MMDD') <> '0101'
    And     b1.Ȯ���� Between RInfo.�Ⱓfrom And Last_Day(RInfo.�Ⱓto)
    And not Exists
    (
        Select Null
        From ft1_�ڱ�û���ڷ� z
        Where z.�����ڵ� = a.�ͼӺμ�����
        And   z.û����ǥ��ȣ = a.��ǥ��ȣ
        And   z.û����ǥ���� = a.��ǥ����
        And   z.û��_Ȯ�� = '1'
    )
    Group by
        a.��ǥ��ȣ,
        a.��ǥ����,
        a.�����ڵ�,
        a.�ŷ�ó�ڵ�,
        a.�ŷ�ó�����,
        a.�ŷ�ó��,
        a.�뺯�ݾ�,
        a.�����ڵ�,
        a.����1,
        a.����2;
--�ڱ�û���ڷῡ �����ϴ� local procedure
    Procedure PrsInsertLocal
    Is
    Begin
        If RInsert.�����ڵ� = ls���� Then
            If RInfo.�����û�� = 'Y' Then
                Null;
            Else
                Return;
            End If;
        ElsIf RInsert.�����ڵ� = ls�빫 Then
            If RInfo.�빫��û�� = 'Y' Then
                Null;
            Else
                Return;
            End If;
        ElsIf RInsert.�����ڵ� = ls��� Then
            If RInfo.����û�� = 'Y' Then
                Null;
            Else
                Return;
            End If;
        ElsIf RInsert.�����ڵ� = ls���� Then
            If RInfo.���ֺ�û�� = 'Y' Then
                Null;
            Else
                Return;
            End If;
        ElsIf RInsert.�����ڵ� = ls��� Then
            If RInfo.���û�� = 'Y' Then
                Null;
            Else
                Return;
            End If;
        ElsIf RInsert.�����ڵ� = ls����� Then
            If RInfo.�����û�� = 'Y' Then
                Null;
            Else
                Return;
            End If;
        Else
            Return;
        End If;
        Begin
            Insert Into Ft1_�ڱ�û���ڷ�
            (
                �����ڵ�,
                �ڱ�û��ȸ��,
                û����ǥ��ȣ,
                û����ǥ����,
                �����ڵ�,
                �ŷ�ó�ڵ�,
                �ŷ�ó�����,
                �ŷ�ó��,
                �������̺��ܾ�,
                ����̺ҹ���,
                ����̺ҹ߻�,
                ������̺��ܾ�,
                ��û������,
                ���û����,
                ��������,
                ����1,
                ����2,
                ��ǥ�ݾ�,
                ����_Ȯ��,
                û��_Ȯ��,
                �����,
                �����
            )
            Values
            (
                RInsert.�����ڵ�,
                RInsert.�ڱ�û��ȸ��,
                RInsert.û����ǥ��ȣ,
                RInsert.û����ǥ����,
                RInsert.�����ڵ�,
                RInsert.�ŷ�ó�ڵ�,
                RInsert.�ŷ�ó�����,
                RInsert.�ŷ�ó��,
                RInsert.�������̺��ܾ�,
                RInsert.����̺ҹ���,
                RInsert.����̺ҹ߻�,
                RInsert.������̺��ܾ�,
                RInsert.��û������,
                RInsert.���û����,
                RInsert.��������,
                RInsert.����1,
                RInsert.����2,
                RInsert.��ǥ�ݾ�,
                RInsert.����_Ȯ��,
                RInsert.û��_Ȯ��,
                RInsert.�����,
                RInsert.�����
            );
        Exception When Dup_Val_On_Index Then
            Update  Ft1_�ڱ�û���ڷ�
            Set     �������̺��ܾ� = Nvl(�������̺��ܾ�,0) + Nvl(RInsert.�������̺��ܾ�,0),
                    ����̺ҹ��� = Nvl(����̺ҹ���,0) + Nvl(RInsert.����̺ҹ���,0),
                    ����̺ҹ߻� = Nvl(����̺ҹ߻�,0) + Nvl(RInsert.����̺ҹ߻�,0)
            Where   �����ڵ� = RInsert.�����ڵ�
            And     �ڱ�û��ȸ�� = RInsert.�ڱ�û��ȸ��
            And     û����ǥ��ȣ = RInsert.û����ǥ��ȣ
            And     û����ǥ���� = RInsert.û����ǥ����;
        End;
    End;
Begin
--���η���
    lsStep := '�����ڷ���� ';
    Delete  FT1_�ڱ�û���Ǻ����αݾ�
    Where   �����ڵ� = ar_�����ڵ�
    And     �ڱ�û��ȸ�� = ar_�ڱ�û��ȸ��;
    Delete  FT1_�ڱ�û���Ǻ�Ȯ��
    Where   �����ڵ� = ar_�����ڵ�
    And     �ڱ�û��ȸ�� = ar_�ڱ�û��ȸ��;
    Delete  Ft1_�ڱ�û���ױ���
    Where   �����ڵ� = ar_�����ڵ�
    And     �ڱ�û��ȸ�� = ar_�ڱ�û��ȸ��;
    Delete  Ft1_�ڱ�û���ڷ�
    Where   �����ڵ� = ar_�����ڵ�
    And     �ڱ�û��ȸ�� = ar_�ڱ�û��ȸ��;
    lsStep := '����̺��ڷ� ';
--�ش� �ڱ�û�� �۾��� ������ �о��
    Begin
        Select  *
        Into    RInfo
        From    Ft1_�ڱ�û���۾�
        Where   �����ڵ� = ar_�����ڵ�
        And     �ڱ�û��ȸ�� = ar_�ڱ�û��ȸ��;
    Exception When No_Data_Found Then
        ar_errm := '�ش� ������ �ش� ������ �ڱ�û�� ����� ã�� �� �����ϴ�.';
        Return False;
    End;
    If RInfo.�ڱ�û���۾����� = 'Y' Then
        Null;
    Else
        ar_errm := '�ش� �ڱ�û�� ȸ������ �����ڱ��۾��� ���ԵǾ� ���� �ʽ��ϴ�.';
        Return False;
    End If;
    Begin
        Select  1
        Into    lnCnt
        From    Ft1_�ڱ�û���Ǻ�Ȯ��
        Where   �����ڵ� = ar_�����ڵ�
        And     �ڱ�û��ȸ�� = ar_�ڱ�û��ȸ��
        And     RowNum = 1;
    Exception When No_Data_Found Then
        lnCnt := 0;
    End;
--�����ܰ�� �̰��Ǿ����� �˻�
    If lnCnt > 0 Then
        ar_errm := '�ش� �ڱ�û�� ȸ���� ���� ���� �ܰ�� �̰��Ǿ� �۾��� �Ұ����մϴ�.';
        Return False;
    End If;
-- ������ ���ǵ� Ŀ���� �����۾�
    Open CurA;
    Loop
        Fetch CurA
        Into    RInsert.�����ڵ�,
                RInsert.�ڱ�û��ȸ��,
                RInsert.û����ǥ��ȣ,
                RInsert.û����ǥ����,
                RInsert.�����ڵ�,
                RInsert.�ŷ�ó�ڵ�,
                RInsert.�ŷ�ó�����,
                RInsert.�ŷ�ó��,
                RInsert.�������̺��ܾ�,
                RInsert.����̺ҹ���,
                RInsert.����̺ҹ߻�,
                RInsert.������̺��ܾ�,
                RInsert.��û������,
                RInsert.���û����,
                RInsert.��������,
                RInsert.����1,
                RInsert.����2,
                RInsert.��ǥ�ݾ�,
                RInsert.����_Ȯ��,
                RInsert.û��_Ȯ��,
                RInsert.�����,
                RInsert.�����;
        Exit When CurA%NotFound;
        PrsInsertLocal;
    End Loop;
    Close CurA;
    lsStep := '������ �ܾ� ';
    Open CurB;
    Loop
        Fetch CurB
        Into    RInsert.�����ڵ�,
                RInsert.�ڱ�û��ȸ��,
                RInsert.û����ǥ��ȣ,
                RInsert.û����ǥ����,
                RInsert.�����ڵ�,
                RInsert.�ŷ�ó�ڵ�,
                RInsert.�ŷ�ó�����,
                RInsert.�ŷ�ó��,
                RInsert.�������̺��ܾ�,
                RInsert.����̺ҹ���,
                RInsert.����̺ҹ߻�,
                RInsert.������̺��ܾ�,
                RInsert.��û������,
                RInsert.���û����,
                RInsert.��������,
                RInsert.����1,
                RInsert.����2,
                RInsert.��ǥ�ݾ�,
                RInsert.����_Ȯ��,
                RInsert.û��_Ȯ��,
                RInsert.�����,
                RInsert.�����;
        Exit When CurB%NotFound;
        PrsInsertLocal;
    End Loop;
    Close CurB;
    lsStep := '����̺ҹ��� ';
    Open CurC;
    Loop
        Fetch CurC
        Into    RInsert.�����ڵ�,
                RInsert.�ڱ�û��ȸ��,
                RInsert.û����ǥ��ȣ,
                RInsert.û����ǥ����,
                RInsert.�����ڵ�,
                RInsert.�ŷ�ó�ڵ�,
                RInsert.�ŷ�ó�����,
                RInsert.�ŷ�ó��,
                RInsert.�������̺��ܾ�,
                RInsert.����̺ҹ���,
                RInsert.����̺ҹ߻�,
                RInsert.������̺��ܾ�,
                RInsert.��û������,
                RInsert.���û����,
                RInsert.��������,
                RInsert.����1,
                RInsert.����2,
                RInsert.��ǥ�ݾ�,
                RInsert.����_Ȯ��,
                RInsert.û��_Ȯ��,
                RInsert.�����,
                RInsert.�����;
        Exit When CurC%NotFound;
        PrsInsertLocal;
    End Loop;
    Close CurC;
-- ������ ���ǵ� Ŀ���� �����۾�    ��


-- ����� �̺��ܾ� �� ���û���� ����
-- ���û���� = ������̺��ܾ� - ��û�������� (�� ����ô� ��û���������� 0 �̹Ƿ� �� �ݾ��� ����.)
    Update  Ft1_�ڱ�û���ڷ�
    Set     ������̺��ܾ� = Nvl(�������̺��ܾ�,0) + Nvl(����̺ҹ߻�,0) - Nvl(����̺ҹ���,0),
            ���û���� = Nvl(�������̺��ܾ�,0) + Nvl(����̺ҹ߻�,0) - Nvl(����̺ҹ���,0)
    Where   �����ڵ� = ar_�����ڵ�
    And     �ڱ�û��ȸ�� = ar_�ڱ�û��ȸ��;
-- �⺻���δ� ���� û���� ����
    Insert Into Ft1_�ڱ�û���ױ���
    (
        �����ڵ�,
        �ڱ�û��ȸ��,
        û����ǥ��ȣ,
        û����ǥ����,
        ����,
        û������,
        û���ݾ�,
        �����,
        �����
    )
    Select
        �����ڵ�,
        �ڱ�û��ȸ��,
        û����ǥ��ȣ,
        û����ǥ����,
        1,
        '1',                    -- ���� 2�� ����
        ���û����,
        Sysdate,
        ar_�����ID
    From    Ft1_�ڱ�û���ڷ�
    Where   �����ڵ� = ar_�����ڵ�
    And     �ڱ�û��ȸ�� = ar_�ڱ�û��ȸ��;
    Commit;
    Return True;
Exception When Others Then
    ar_errm := lsStep || SqlErrm;
    Rollback;
    If CurA%IsOpen Then
        Close CurA;
    End If;
    If CurB%IsOpen Then
        Close CurB;
    End If;
    If CurC%IsOpen Then
        Close CurC;
    End If;
    Return False;
End;
/




Create Or Replace Function F_F�ڱ�û�������ڱ���ü
(
	ar_�����ڵ�			Varchar2,
	ar_�ڱ�û��ȸ��     Number,
	ar_��������         Number,
	ar_�����id			Varchar2,
	ar_errm			Out	Varchar2
)
Return Boolean
Is
    lnNumber            Number;
    Cursor CurA
    Is
    Select  *
    From    Fv1_�ڱ�û��������ü a
    Where   a.�����ڵ� = ar_�����ڵ�
    And     a.�ڱ�û��ȸ�� = ar_�ڱ�û��ȸ��
    And     a.�������� = ar_��������
    And     a.û���ݾ� > 0
    And     Not Exists
    (
        Select  Null
        From    at5_�ڱ�û������ b
        Where   a.�����ڵ� = b.û������
        And     a.�ڱ�û��ȸ�� = b.�ڱ�û��ȸ��
        And     a.û����ǥ��ȣ = b.û����ǥ��ȣ
        And     a.û����ǥ���� = b.û����ǥ����
    )
    Order By
        a.�����ڵ�,
        a.�ڱ�û��ȸ��,
        a.û����ǥ��ȣ,
        a.û����ǥ����,
        a.��������,
        a.����;
    r_�ڱ�û������          Ft1_�ڱ�û���۾�%RowType;
    ls_�ŷ�ó��             At1_��ǥ��.�ŷ�ó��%Type;
Begin
--���������� ��ó���� ����
    Delete  At5_�ڱ�û������ a
    Where   a.û������ = ar_�����ڵ�
    And     a.�ڱ�û��ȸ�� = ar_�ڱ�û��ȸ��
    And     a.û����ǥ��ȣ Is Not Null
    And     a.û����õ�� = '�ڱ�û��'
    And     Not Exists
    (
        Select  Null
        From    At5_�ڱ�û������ b
        Where   a.û������ = b.û������
        And     a.�ڱ�û��ȸ�� = b.�ڱ�û��ȸ��
        And     a.û����ǥ��ȣ = b.û����ǥ��ȣ
        And     a.û����ǥ���� = b.û����ǥ����
        And     b.������ǥ��ȣ is not null
    );
    Begin
        Select  *
        Into    r_�ڱ�û������
        From    Ft1_�ڱ�û���۾�
        Where   �����ڵ� = ar_�����ڵ�
        And     �ڱ�û��ȸ�� = ar_�ڱ�û��ȸ��;
    Exception When No_Data_Found Then
        ar_errm := SqlErrm;
        Rollback;
        Return False;
    End;
    Begin
        Select  Max(a.����)
        Into    lnNumber
        From    At5_�ڱ�û������ a
        Where   a.û������ = ar_�����ڵ�
        And     a.�ڱ�û��ȸ�� = ar_�ڱ�û��ȸ��;
    Exception When No_Data_Found Then
        lnNumber := Null;
    End;
    If lnNumber Is Null Then
        lnNumber := 0;
    End If;
    For R_A In CurA Loop
        lnNumber := lnNumber + 1;
        Begin
            Select  �ŷ�ó��
            Into    ls_�ŷ�ó��
            From    at1_��ǥ��
            Where   ��ǥ��ȣ = R_A.û����ǥ��ȣ
            And     ��ǥ���� = R_A.û����ǥ����;
        Exception When No_Data_Found Then
            ls_�ŷ�ó�� := Null;
        End;
        Insert Into at5_�ڱ�û������
        (
            û������,
            �ڱ�û��ȸ��,
            û�����,
            ����,
            �����ڵ�,
            û������,
            û���ݾ�,
            ó���ݾ�,
            �����ڵ�,
            ����1,
            ����2,
            �ŷ�ó�ڵ�,
            �ŷ�ó�����,
            �ŷ�ó��,
            û����õ��,
            û����ǥ��ȣ,
            û����ǥ����,
            �����,
            �����
        )
        Values
        (
            ar_�����ڵ�,
            ar_�ڱ�û��ȸ��,
            To_char(r_�ڱ�û������.�۾����,'YYYYMM'),
            lnNumber,
            R_A.��������,
            R_A.û������,
            R_A.û���ݾ�,
            NULL,
            R_A.�����ڵ�,
            R_A.����1,
            R_A.����2,
            R_A.�ŷ�ó�ڵ�,
            R_A.�ŷ�ó�����,
            ls_�ŷ�ó��,
            '�ڱ�û��',
            R_A.û����ǥ��ȣ,
            R_A.û����ǥ����,
            ar_�����id,
            SysDate
        );
    End Loop;
    Commit;
    Return True;
Exception When Others Then
    ar_errm := SqlErrm;
    Rollback;
    Return False;
End;
/



Create Or Replace Function F_F�ڱ�û���̺���ü
(
	ar_�����ڵ�			Varchar2,
	ar_�ڱ�û��ȸ��     Number,
	ar_�����id			Varchar2,
	ar_errm			Out	Varchar2
)
Return Boolean
Is
-- ���α׷��� ���� : ��ǥ���� �����ް���ݵ��� �̺���ǥ�� ���(�����ܰ�,�����)�� �����Ͽ� ��� û���� ����
    lsStep              Varchar2(2000) := 'Start ';
    lnCnt               Number;
    RInsert             Ft1_�ڱ�û���ڷ�%RowType;
    RInfo               Ft1_�ڱ�û���۾�%RowType;
--�����ڵ� ���Ǻ� (��񱸺��� ����)
    ls����              at9_�����ڵ�.�����ڵ�%Type:= '1001';
    ls�빫              at9_�����ڵ�.�����ڵ�%Type:= '1002';
    ls���              at9_�����ڵ�.�����ڵ�%Type:= '1003';
    ls����              at9_�����ڵ�.�����ڵ�%Type:= '1004';
    ls���              at9_�����ڵ�.�����ڵ�%Type:= '1005';
    ls�����            at9_�����ڵ�.�����ڵ�%Type:= '1006';
--����߻� �̺� ����
    Cursor CurA
    Is
    select
        RInfo.�����ڵ� �����ڵ�,
        RInfo.�ڱ�û��ȸ��,
        a.��ǥ��ȣ û����ǥ��ȣ,
        a.��ǥ���� û����ǥ����,
        a.�����ڵ� ,
        a.�ŷ�ó�ڵ�,
        a.�ŷ�ó�����,
        a.�ŷ�ó��,
        0 �������̺��ܾ�,
        0 ����̺ҹ���,
        a.�뺯�ݾ� ����̺ҹ߻�,
        0 ������̺��ܾ�,
        0 ��û������,
        0 ���û����,
        a.�����ڵ�,
        a.����1,
        a.����2,
        a.�뺯�ݾ� ��ǥ�ݾ�,
        'N' ����Ȯ��,
        ar_�����id �����,
        Sysdate �����
    From
        at1_��ǥ�� a,
        at1_��ǥ�� b
    Where   a.��ǥ��ȣ = b.��ǥ��ȣ
--    And     a.�ͼӺμ����� = b.�ۼ��μ�
    And     a.�ͼӺμ����� = ar_�����ڵ�
    And     b.Ȯ���� Between RInfo.�Ⱓfrom And Last_Day(RInfo.�Ⱓto)
    and     a.������ǥ��ȣ is null
    And     Nvl(a.�뺯�ݾ�,0) <> 0
    And     To_Char(b.Ȯ����,'MMDD') <> '0101'
    And     Exists
    (
        Select  Null
        From    ft1_�ڱ�û���������� n
        Where   n.������ = '2'          -- �̺�
        And     n.�����ڵ� = a.�����ڵ�
    );
-- ������ �̺��ܾ� ��������
    Cursor CurB
    Is
    select
        RInfo.�����ڵ� �����ڵ�,
        RInfo.�ڱ�û��ȸ��,
        a.��ǥ��ȣ û����ǥ��ȣ,
        a.��ǥ���� û����ǥ����,
        a.�����ڵ� ,
        a.�ŷ�ó�ڵ�,
        a.�ŷ�ó�����,
        a.�ŷ�ó��,
        Nvl(a.�뺯�ݾ�,0) - Sum(decode(sign(Trunc(RInfo.�Ⱓfrom,'MM') - d.Ȯ����),1,c.�����ݾ�,0)) �������̺��ܾ�,
        0 ����̺ҹ���,
        0 ����̺ҹ߻�,
        0 ������̺��ܾ�,
        0 ��û������,
        0 ���û����,
        a.�����ڵ�,
        a.����1,
        a.����2,
        a.�뺯�ݾ� ��ǥ�ݾ�,
        'N' ����Ȯ��,
        ar_�����id �����,
        Sysdate �����
    From
        at1_��ǥ�� a,
        at1_��ǥ�� b,
        at1_�ܾװ��� c,
        at1_��ǥ�� d
    Where   a.��ǥ��ȣ = b.��ǥ��ȣ
    And     b.Ȯ���� < RInfo.�Ⱓfrom + Decode(To_Char(RInfo.�Ⱓfrom,'MMDD'),'0101',1,0)
    And     a.�ͼӺμ����� = RInfo.�����ڵ�
    and     a.������ǥ��ȣ is null
    And     Nvl(a.�뺯�ݾ�,0) <> 0
    And     b.Ȯ���� >= Trunc(rInfo.�Ⱓfrom,'YYYY')
    And     Exists
    (
        Select  Null
        From    ft1_�ڱ�û���������� n
        Where   n.������ = '2'
        And     n.�����ڵ� = a.�����ڵ�
    )
    And     a.��ǥ��ȣ = c.������ǥ��ȣ (+)
    And     a.��ǥ���� = c.������ǥ���� (+)
    And     c.��ǥ��ȣ = d.��ǥ��ȣ (+)
    Group by
        a.��ǥ��ȣ,
        a.��ǥ����,
        a.�����ڵ�,
        a.�ŷ�ó�ڵ�,
        a.�ŷ�ó�����,
        a.�ŷ�ó��,
        a.�뺯�ݾ�,
        a.�����ڵ�,
        a.����1,
        a.����2
    Having Nvl(a.�뺯�ݾ�,0) - Sum(decode(sign(Trunc(RInfo.�Ⱓfrom,'MM') - d.Ȯ����),1,c.�����ݾ�,0)) <> 0;
--��� �̺ҹ���
    Cursor CurC
    Is
    select
        RInfo.�����ڵ� �����ڵ�,
        RInfo.�ڱ�û��ȸ��,
        a.��ǥ��ȣ û����ǥ��ȣ,
        a.��ǥ���� û����ǥ����,
        a.�����ڵ� ,
        a.�ŷ�ó�ڵ�,
        a.�ŷ�ó�����,
        a.�ŷ�ó��,
        0 �������̺��ܾ�,
        Nvl(Sum(a1.�����ݾ�),0) - Nvl(Sum(a1.�뺯�ݾ�),0)  ����̺ҹ���,
        0 ����̺ҹ߻�,
        0 ������̺��ܾ�,
        0 ��û������,
        0 ���û����,
        a.�����ڵ�,
        a.����1,
        a.����2,
        a.�뺯�ݾ� ��ǥ�ݾ�,
        'N' ����Ȯ��,
        ar_�����id �����,
        Sysdate �����
    From
        at1_��ǥ�� a,
        at1_��ǥ�� a1,
        at1_��ǥ�� b,
        at1_��ǥ�� b1
    Where   a.��ǥ��ȣ = b.��ǥ��ȣ
    And     a.�ͼӺμ����� = RInfo.�����ڵ�
    And     Nvl(a.�뺯�ݾ�,0) <> 0
--    And     To_Char(b.Ȯ����,'MMDD') <> '0101'
    And     Exists
    (
        Select  Null
        From    ft1_�ڱ�û���������� n
        Where   n.������ = '2'
        And     n.�����ڵ� = a.�����ڵ�
    )
    And     a.��ǥ��ȣ = a1.������ǥ��ȣ
    And     a.��ǥ���� = a1.������ǥ����
    And     a1.��ǥ��ȣ = b1.��ǥ��ȣ
    And     To_Char(b1.Ȯ����,'MMDD') <> '0101'
    And     b1.Ȯ���� Between RInfo.�Ⱓfrom And Last_Day(RInfo.�Ⱓto)
    Group by
        a.��ǥ��ȣ,
        a.��ǥ����,
        a.�����ڵ�,
        a.�ŷ�ó�ڵ�,
        a.�ŷ�ó�����,
        a.�ŷ�ó��,
        a.�뺯�ݾ�,
        a.�����ڵ�,
        a.����1,
        a.����2;
--�ڱ�û���ڷῡ �����ϴ� local procedure
    Procedure PrsInsertLocal
    Is
    Begin
        If RInsert.�����ڵ� = ls���� Then
            If RInfo.�����û�� = 'Y' Then
                Null;
            Else
                Return;
            End If;
        ElsIf RInsert.�����ڵ� = ls�빫 Then
            If RInfo.�빫��û�� = 'Y' Then
                Null;
            Else
                Return;
            End If;
        ElsIf RInsert.�����ڵ� = ls��� Then
            If RInfo.����û�� = 'Y' Then
                Null;
            Else
                Return;
            End If;
        ElsIf RInsert.�����ڵ� = ls���� Then
            If RInfo.���ֺ�û�� = 'Y' Then
                Null;
            Else
                Return;
            End If;
        ElsIf RInsert.�����ڵ� = ls��� Then
            If RInfo.���û�� = 'Y' Then
                Null;
            Else
                Return;
            End If;
        ElsIf RInsert.�����ڵ� = ls����� Then
            If RInfo.�����û�� = 'Y' Then
                Null;
            Else
                Return;
            End If;
        Else
            Return;
        End If;
        Begin
            Insert Into Ft1_�ڱ�û���ڷ�
            (
                �����ڵ�,
                �ڱ�û��ȸ��,
                û����ǥ��ȣ,
                û����ǥ����,
                �����ڵ�,
                �ŷ�ó�ڵ�,
                �ŷ�ó�����,
                �ŷ�ó��,
                �������̺��ܾ�,
                ����̺ҹ���,
                ����̺ҹ߻�,
                ������̺��ܾ�,
                ��û������,
                ���û����,
                ��������,
                ����1,
                ����2,
                ��ǥ�ݾ�,
                ����_Ȯ��,
                �����,
                �����
            )
            Values
            (
                RInsert.�����ڵ�,
                RInsert.�ڱ�û��ȸ��,
                RInsert.û����ǥ��ȣ,
                RInsert.û����ǥ����,
                RInsert.�����ڵ�,
                RInsert.�ŷ�ó�ڵ�,
                RInsert.�ŷ�ó�����,
                RInsert.�ŷ�ó��,
                RInsert.�������̺��ܾ�,
                RInsert.����̺ҹ���,
                RInsert.����̺ҹ߻�,
                RInsert.������̺��ܾ�,
                RInsert.��û������,
                RInsert.���û����,
                RInsert.��������,
                RInsert.����1,
                RInsert.����2,
                RInsert.��ǥ�ݾ�,
                RInsert.����_Ȯ��,
                RInsert.�����,
                RInsert.�����
            );
        Exception When Dup_Val_On_Index Then
            Update  Ft1_�ڱ�û���ڷ�
            Set     �������̺��ܾ� = Nvl(�������̺��ܾ�,0) + Nvl(RInsert.�������̺��ܾ�,0),
                    ����̺ҹ��� = Nvl(����̺ҹ���,0) + Nvl(RInsert.����̺ҹ���,0),
                    ����̺ҹ߻� = Nvl(����̺ҹ߻�,0) + Nvl(RInsert.����̺ҹ߻�,0)
            Where   �����ڵ� = RInsert.�����ڵ�
            And     �ڱ�û��ȸ�� = RInsert.�ڱ�û��ȸ��
            And     û����ǥ��ȣ = RInsert.û����ǥ��ȣ
            And     û����ǥ���� = RInsert.û����ǥ����;
        End;
    End;
Begin
--���η���
    lsStep := '�����ڷ���� ';
    Delete  FT1_�ڱ�û���Ǻ����αݾ�
    Where   �����ڵ� = ar_�����ڵ�
    And     �ڱ�û��ȸ�� = ar_�ڱ�û��ȸ��;
    Delete  FT1_�ڱ�û���Ǻ�Ȯ��
    Where   �����ڵ� = ar_�����ڵ�
    And     �ڱ�û��ȸ�� = ar_�ڱ�û��ȸ��;
    Delete  Ft1_�ڱ�û���ױ���
    Where   �����ڵ� = ar_�����ڵ�
    And     �ڱ�û��ȸ�� = ar_�ڱ�û��ȸ��;
    Delete  Ft1_�ڱ�û���ڷ�
    Where   �����ڵ� = ar_�����ڵ�
    And     �ڱ�û��ȸ�� = ar_�ڱ�û��ȸ��;
    lsStep := '����̺��ڷ� ';
--�ش� �ڱ�û�� �۾��� ������ �о��
    Begin
        Select  *
        Into    RInfo
        From    Ft1_�ڱ�û���۾�
        Where   �����ڵ� = ar_�����ڵ�
        And     �ڱ�û��ȸ�� = ar_�ڱ�û��ȸ��;
    Exception When No_Data_Found Then
        ar_errm := '�ش� ������ �ش� ������ �ڱ�û�� ����� ã�� �� �����ϴ�.';
        Return False;
    End;
    If RInfo.�ڱ�û���۾����� = 'Y' Then
        Null;
    Else
        ar_errm := '�ش� �ڱ�û�� ȸ������ �����ڱ��۾��� ���ԵǾ� ���� �ʽ��ϴ�.';
        Return False;
    End If;
    Begin
        Select  1
        Into    lnCnt
        From    Ft1_�ڱ�û���Ǻ�Ȯ��
        Where   �����ڵ� = ar_�����ڵ�
        And     �ڱ�û��ȸ�� = ar_�ڱ�û��ȸ��
        And     RowNum = 1;
    Exception When No_Data_Found Then
        lnCnt := 0;
    End;
--�����ܰ�� �̰��Ǿ����� �˻�
    If lnCnt > 0 Then
        ar_errm := '�ش� �ڱ�û�� ȸ���� ���� ���� �ܰ�� �̰��Ǿ� �۾��� �Ұ����մϴ�.';
        Return False;
    End If;
-- ������ ���ǵ� Ŀ���� �����۾�
    Open CurA;
    Loop
        Fetch CurA
        Into    RInsert.�����ڵ�,
                RInsert.�ڱ�û��ȸ��,
                RInsert.û����ǥ��ȣ,
                RInsert.û����ǥ����,
                RInsert.�����ڵ�,
                RInsert.�ŷ�ó�ڵ�,
                RInsert.�ŷ�ó�����,
                RInsert.�ŷ�ó��,
                RInsert.�������̺��ܾ�,
                RInsert.����̺ҹ���,
                RInsert.����̺ҹ߻�,
                RInsert.������̺��ܾ�,
                RInsert.��û������,
                RInsert.���û����,
                RInsert.��������,
                RInsert.����1,
                RInsert.����2,
                RInsert.��ǥ�ݾ�,
                RInsert.����_Ȯ��,
                RInsert.�����,
                RInsert.�����;
        Exit When CurA%NotFound;
        PrsInsertLocal;
    End Loop;
    Close CurA;
    lsStep := '������ �ܾ� ';
    Open CurB;
    Loop
        Fetch CurB
        Into    RInsert.�����ڵ�,
                RInsert.�ڱ�û��ȸ��,
                RInsert.û����ǥ��ȣ,
                RInsert.û����ǥ����,
                RInsert.�����ڵ�,
                RInsert.�ŷ�ó�ڵ�,
                RInsert.�ŷ�ó�����,
                RInsert.�ŷ�ó��,
                RInsert.�������̺��ܾ�,
                RInsert.����̺ҹ���,
                RInsert.����̺ҹ߻�,
                RInsert.������̺��ܾ�,
                RInsert.��û������,
                RInsert.���û����,
                RInsert.��������,
                RInsert.����1,
                RInsert.����2,
                RInsert.��ǥ�ݾ�,
                RInsert.����_Ȯ��,
                RInsert.�����,
                RInsert.�����;
        Exit When CurB%NotFound;
        PrsInsertLocal;
    End Loop;
    Close CurB;
    lsStep := '����̺ҹ��� ';
    Open CurC;
    Loop
        Fetch CurC
        Into    RInsert.�����ڵ�,
                RInsert.�ڱ�û��ȸ��,
                RInsert.û����ǥ��ȣ,
                RInsert.û����ǥ����,
                RInsert.�����ڵ�,
                RInsert.�ŷ�ó�ڵ�,
                RInsert.�ŷ�ó�����,
                RInsert.�ŷ�ó��,
                RInsert.�������̺��ܾ�,
                RInsert.����̺ҹ���,
                RInsert.����̺ҹ߻�,
                RInsert.������̺��ܾ�,
                RInsert.��û������,
                RInsert.���û����,
                RInsert.��������,
                RInsert.����1,
                RInsert.����2,
                RInsert.��ǥ�ݾ�,
                RInsert.����_Ȯ��,
                RInsert.�����,
                RInsert.�����;
        Exit When CurC%NotFound;
        PrsInsertLocal;
    End Loop;
    Close CurC;
-- ������ ���ǵ� Ŀ���� �����۾�    ��


-- ����� �̺��ܾ� �� ���û���� ����
-- ���û���� = ������̺��ܾ� - ��û�������� (�� ����ô� ��û���������� 0 �̹Ƿ� �� �ݾ��� ����.)
    Update  Ft1_�ڱ�û���ڷ�
    Set     ������̺��ܾ� = Nvl(�������̺��ܾ�,0) + Nvl(����̺ҹ߻�,0) - Nvl(����̺ҹ���,0),
            ���û���� = Nvl(�������̺��ܾ�,0) + Nvl(����̺ҹ߻�,0) - Nvl(����̺ҹ���,0)
    Where   �����ڵ� = ar_�����ڵ�
    And     �ڱ�û��ȸ�� = ar_�ڱ�û��ȸ��;
-- �⺻���δ� ���� û���� ����
    Insert Into Ft1_�ڱ�û���ױ���
    (
        �����ڵ�,
        �ڱ�û��ȸ��,
        û����ǥ��ȣ,
        û����ǥ����,
        ����,
        û������,
        û���ݾ�,
        �����,
        �����
    )
    Select
        �����ڵ�,
        �ڱ�û��ȸ��,
        û����ǥ��ȣ,
        û����ǥ����,
        1,
        '1',                    -- ���� 2�� ����
        ���û����,
        Sysdate,
        ar_�����ID
    From    Ft1_�ڱ�û���ڷ�
    Where   �����ڵ� = ar_�����ڵ�
    And     �ڱ�û��ȸ�� = ar_�ڱ�û��ȸ��;
    Commit;
    Return True;
Exception When Others Then
    ar_errm := lsStep || SqlErrm;
    Rollback;
    If CurA%IsOpen Then
        Close CurA;
    End If;
    If CurB%IsOpen Then
        Close CurB;
    End If;
    If CurC%IsOpen Then
        Close CurC;
    End If;
    Return False;
End;
/
