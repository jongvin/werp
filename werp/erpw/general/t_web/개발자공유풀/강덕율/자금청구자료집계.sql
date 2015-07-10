Create Or Replace Function F_F자금청구자료생성
(
	ar_현장코드			Varchar2,
	ar_자금청구회차     Number,
	ar_사용자id			Varchar2,
	ar_errm			Out	Varchar2
)
Return Boolean
Is
-- 프로그램의 목적 : 전표에서 미지급공사금등의 미불전표를 비목별(재노장외경,비원가)로
-- 집계하여 당월 청구액 산출, 집계월 범위내에서 기청구된 내역은 제외하고 집계
    lsStep              Varchar2(2000) := 'Start ';
    lnCnt               Number;
    RInsert             Ft1_자금청구자료%RowType;
    RInfo               Ft1_자금청구작업%RowType;
--적요코드 정의부 (비목구분을 위해)
    ls자재              at9_적요코드.적요코드%Type:= '1001';
    ls노무              at9_적요코드.적요코드%Type:= '1002';
    ls장비              at9_적요코드.적요코드%Type:= '1003';
    ls외주              at9_적요코드.적요코드%Type:= '1004';
    ls경비              at9_적요코드.적요코드%Type:= '1005';
    ls비원가            at9_적요코드.적요코드%Type:= '1006';
--당월발생 미불 집계
    Cursor CurA
    Is
    select
        RInfo.현장코드 현장코드,
        RInfo.자금청구회차,
        a.전표번호 청구전표번호,
        a.전표라인 청구전표라인,
        a.적요코드 ,
        a.거래처코드,
        a.거래처등록일,
        a.거래처명,
        0 전월말미불잔액,
        0 당월미불반제,
        a.대변금액 당월미불발생,
        0 당월말미불잔액,
        0 기청구공제,
        0 당월청구액,
        a.계정코드,
        a.적요1,
        a.적요2,
        a.대변금액 전표금액,
        'N' 현장확인,
        '0' 청구확인,           -- 추가된 항목
        ar_사용자id 등록자,
        Sysdate 등록일
    From
        at1_전표하 a,
        at1_전표상 b
    Where   a.전표번호 = b.전표번호
    And     a.귀속부서현장 = ar_현장코드
    And     b.확정일 Between RInfo.기간from And Last_Day(RInfo.기간to)
    and     a.반제전표번호 is null
    And     Nvl(a.대변금액,0) <> 0
    And     To_Char(b.확정일,'MMDD') <> '0101'
    And     Exists
    (
        Select  Null
        From    ft1_자금청구계정정의 n
        Where   n.구분자 = '2'          -- 미불
        And     n.계정코드 = a.계정코드
    )
    And not Exists
    (
        Select Null
        From ft1_자금청구자료 z
        Where z.현장코드 = a.귀속부서현장
        And   z.청구전표번호 = a.전표번호
        And   z.청구전표라인 = a.전표라인
        And   z.청구_확인 = '1'
    );
-- 전월말 미불잔액 가져오기
    Cursor CurB
    Is
    select
        RInfo.현장코드 현장코드,
        RInfo.자금청구회차,
        a.전표번호 청구전표번호,
        a.전표라인 청구전표라인,
        a.적요코드 ,
        a.거래처코드,
        a.거래처등록일,
        a.거래처명,
        Nvl(a.대변금액,0) - Sum(decode(sign(Trunc(RInfo.기간from,'MM') - d.확정일),1,c.반제금액,0)) 전월말미불잔액,
        0 당월미불반제,
        0 당월미불발생,
        0 당월말미불잔액,
        0 기청구공제,
        0 당월청구액,
        a.계정코드,
        a.적요1,
        a.적요2,
        a.대변금액 전표금액,
        'N' 현장확인,
        '0' 청구확인,           -- 추가된 항목
        ar_사용자id 등록자,
        Sysdate 등록일
    From
        at1_전표하 a,
        at1_전표상 b,
        at1_잔액관리 c,
        at1_전표상 d
    Where   a.전표번호 = b.전표번호
    And     b.확정일 < RInfo.기간from + Decode(To_Char(RInfo.기간from,'MMDD'),'0101',1,0)
    And     a.귀속부서현장 = RInfo.현장코드
    and     a.반제전표번호 is null
    And     Nvl(a.대변금액,0) <> 0
    And     b.확정일 >= Trunc(rInfo.기간from,'YYYY')
    And     Exists
    (
        Select  Null
        From    ft1_자금청구계정정의 n
        Where   n.구분자 = '2'
        And     n.계정코드 = a.계정코드
    )
    And     a.전표번호 = c.반제전표번호 (+)
    And     a.전표라인 = c.반제전표라인 (+)
    And     c.전표번호 = d.전표번호 (+)
    And not Exists
    (
        Select Null
        From ft1_자금청구자료 z
        Where z.현장코드 = a.귀속부서현장
        And   z.청구전표번호 = a.전표번호
        And   z.청구전표라인 = a.전표라인
        And   z.청구_확인 = '1'
    )
    Group by
        a.전표번호,
        a.전표라인,
        a.적요코드,
        a.거래처코드,
        a.거래처등록일,
        a.거래처명,
        a.대변금액,
        a.계정코드,
        a.적요1,
        a.적요2
    Having Nvl(a.대변금액,0) - Sum(decode(sign(Trunc(RInfo.기간from,'MM') - d.확정일),1,c.반제금액,0)) <> 0;
--당월 미불반제
    Cursor CurC
    Is
    select
        RInfo.현장코드 현장코드,
        RInfo.자금청구회차,
        a.전표번호 청구전표번호,
        a.전표라인 청구전표라인,
        a.적요코드 ,
        a.거래처코드,
        a.거래처등록일,
        a.거래처명,
        0 전월말미불잔액,
        Nvl(Sum(a1.차변금액),0) - Nvl(Sum(a1.대변금액),0)  당월미불반제,
        0 당월미불발생,
        0 당월말미불잔액,
        0 기청구공제,
        0 당월청구액,
        a.계정코드,
        a.적요1,
        a.적요2,
        a.대변금액 전표금액,
        'N' 현장확인,
        '0' 청구확인,           -- 추가된 항목
        ar_사용자id 등록자,
        Sysdate 등록일
    From
        at1_전표하 a,
        at1_전표하 a1,
        at1_전표상 b,
        at1_전표상 b1
    Where   a.전표번호 = b.전표번호
    And     a.귀속부서현장 = RInfo.현장코드
    And     Nvl(a.대변금액,0) <> 0
--    And     To_Char(b.확정일,'MMDD') <> '0101'
    And     Exists
    (
        Select  Null
        From    ft1_자금청구계정정의 n
        Where   n.구분자 = '2'
        And     n.계정코드 = a.계정코드
    )
    And     a.전표번호 = a1.반제전표번호
    And     a.전표라인 = a1.반제전표라인
    And     a1.전표번호 = b1.전표번호
    And     To_Char(b1.확정일,'MMDD') <> '0101'
    And     b1.확정일 Between RInfo.기간from And Last_Day(RInfo.기간to)
    And not Exists
    (
        Select Null
        From ft1_자금청구자료 z
        Where z.현장코드 = a.귀속부서현장
        And   z.청구전표번호 = a.전표번호
        And   z.청구전표라인 = a.전표라인
        And   z.청구_확인 = '1'
    )
    Group by
        a.전표번호,
        a.전표라인,
        a.적요코드,
        a.거래처코드,
        a.거래처등록일,
        a.거래처명,
        a.대변금액,
        a.계정코드,
        a.적요1,
        a.적요2;
--자금청구자료에 삽입하는 local procedure
    Procedure PrsInsertLocal
    Is
    Begin
        If RInsert.적요코드 = ls자재 Then
            If RInfo.자재비청구 = 'Y' Then
                Null;
            Else
                Return;
            End If;
        ElsIf RInsert.적요코드 = ls노무 Then
            If RInfo.노무비청구 = 'Y' Then
                Null;
            Else
                Return;
            End If;
        ElsIf RInsert.적요코드 = ls장비 Then
            If RInfo.장비비청구 = 'Y' Then
                Null;
            Else
                Return;
            End If;
        ElsIf RInsert.적요코드 = ls외주 Then
            If RInfo.외주비청구 = 'Y' Then
                Null;
            Else
                Return;
            End If;
        ElsIf RInsert.적요코드 = ls경비 Then
            If RInfo.경비청구 = 'Y' Then
                Null;
            Else
                Return;
            End If;
        ElsIf RInsert.적요코드 = ls비원가 Then
            If RInfo.비원가청구 = 'Y' Then
                Null;
            Else
                Return;
            End If;
        Else
            Return;
        End If;
        Begin
            Insert Into Ft1_자금청구자료
            (
                현장코드,
                자금청구회차,
                청구전표번호,
                청구전표라인,
                적요코드,
                거래처코드,
                거래처등록일,
                거래처명,
                전월말미불잔액,
                당월미불반제,
                당월미불발생,
                당월말미불잔액,
                기청구공제,
                당월청구액,
                계정과목,
                적요1,
                적요2,
                전표금액,
                현장_확인,
                청구_확인,
                등록자,
                등록일
            )
            Values
            (
                RInsert.현장코드,
                RInsert.자금청구회차,
                RInsert.청구전표번호,
                RInsert.청구전표라인,
                RInsert.적요코드,
                RInsert.거래처코드,
                RInsert.거래처등록일,
                RInsert.거래처명,
                RInsert.전월말미불잔액,
                RInsert.당월미불반제,
                RInsert.당월미불발생,
                RInsert.당월말미불잔액,
                RInsert.기청구공제,
                RInsert.당월청구액,
                RInsert.계정과목,
                RInsert.적요1,
                RInsert.적요2,
                RInsert.전표금액,
                RInsert.현장_확인,
                RInsert.청구_확인,
                RInsert.등록자,
                RInsert.등록일
            );
        Exception When Dup_Val_On_Index Then
            Update  Ft1_자금청구자료
            Set     전월말미불잔액 = Nvl(전월말미불잔액,0) + Nvl(RInsert.전월말미불잔액,0),
                    당월미불반제 = Nvl(당월미불반제,0) + Nvl(RInsert.당월미불반제,0),
                    당월미불발생 = Nvl(당월미불발생,0) + Nvl(RInsert.당월미불발생,0)
            Where   현장코드 = RInsert.현장코드
            And     자금청구회차 = RInsert.자금청구회차
            And     청구전표번호 = RInsert.청구전표번호
            And     청구전표라인 = RInsert.청구전표라인;
        End;
    End;
Begin
--메인루프
    lsStep := '이전자료삭제 ';
    Delete  FT1_자금청구건별승인금액
    Where   현장코드 = ar_현장코드
    And     자금청구회차 = ar_자금청구회차;
    Delete  FT1_자금청구건별확인
    Where   현장코드 = ar_현장코드
    And     자금청구회차 = ar_자금청구회차;
    Delete  Ft1_자금청구액구성
    Where   현장코드 = ar_현장코드
    And     자금청구회차 = ar_자금청구회차;
    Delete  Ft1_자금청구자료
    Where   현장코드 = ar_현장코드
    And     자금청구회차 = ar_자금청구회차;
    lsStep := '당월미불자료 ';
--해당 자금청구 작업의 정보를 읽어옴
    Begin
        Select  *
        Into    RInfo
        From    Ft1_자금청구작업
        Where   현장코드 = ar_현장코드
        And     자금청구회차 = ar_자금청구회차;
    Exception When No_Data_Found Then
        ar_errm := '해당 현장의 해당 차수의 자금청구 목록을 찾을 수 없습니다.';
        Return False;
    End;
    If RInfo.자금청구작업여부 = 'Y' Then
        Null;
    Else
        ar_errm := '해당 자금청구 회차에는 전도자금작업이 포함되어 있지 않습니다.';
        Return False;
    End If;
    Begin
        Select  1
        Into    lnCnt
        From    Ft1_자금청구건별확인
        Where   현장코드 = ar_현장코드
        And     자금청구회차 = ar_자금청구회차
        And     RowNum = 1;
    Exception When No_Data_Found Then
        lnCnt := 0;
    End;
--다음단계로 이관되었는지 검사
    If lnCnt > 0 Then
        ar_errm := '해당 자금청구 회차는 다음 승인 단계로 이관되어 작업이 불가능합니다.';
        Return False;
    End If;
-- 각각의 정의된 커서의 루프작업
    Open CurA;
    Loop
        Fetch CurA
        Into    RInsert.현장코드,
                RInsert.자금청구회차,
                RInsert.청구전표번호,
                RInsert.청구전표라인,
                RInsert.적요코드,
                RInsert.거래처코드,
                RInsert.거래처등록일,
                RInsert.거래처명,
                RInsert.전월말미불잔액,
                RInsert.당월미불반제,
                RInsert.당월미불발생,
                RInsert.당월말미불잔액,
                RInsert.기청구공제,
                RInsert.당월청구액,
                RInsert.계정과목,
                RInsert.적요1,
                RInsert.적요2,
                RInsert.전표금액,
                RInsert.현장_확인,
                RInsert.청구_확인,
                RInsert.등록자,
                RInsert.등록일;
        Exit When CurA%NotFound;
        PrsInsertLocal;
    End Loop;
    Close CurA;
    lsStep := '전월말 잔액 ';
    Open CurB;
    Loop
        Fetch CurB
        Into    RInsert.현장코드,
                RInsert.자금청구회차,
                RInsert.청구전표번호,
                RInsert.청구전표라인,
                RInsert.적요코드,
                RInsert.거래처코드,
                RInsert.거래처등록일,
                RInsert.거래처명,
                RInsert.전월말미불잔액,
                RInsert.당월미불반제,
                RInsert.당월미불발생,
                RInsert.당월말미불잔액,
                RInsert.기청구공제,
                RInsert.당월청구액,
                RInsert.계정과목,
                RInsert.적요1,
                RInsert.적요2,
                RInsert.전표금액,
                RInsert.현장_확인,
                RInsert.청구_확인,
                RInsert.등록자,
                RInsert.등록일;
        Exit When CurB%NotFound;
        PrsInsertLocal;
    End Loop;
    Close CurB;
    lsStep := '당월미불반제 ';
    Open CurC;
    Loop
        Fetch CurC
        Into    RInsert.현장코드,
                RInsert.자금청구회차,
                RInsert.청구전표번호,
                RInsert.청구전표라인,
                RInsert.적요코드,
                RInsert.거래처코드,
                RInsert.거래처등록일,
                RInsert.거래처명,
                RInsert.전월말미불잔액,
                RInsert.당월미불반제,
                RInsert.당월미불발생,
                RInsert.당월말미불잔액,
                RInsert.기청구공제,
                RInsert.당월청구액,
                RInsert.계정과목,
                RInsert.적요1,
                RInsert.적요2,
                RInsert.전표금액,
                RInsert.현장_확인,
                RInsert.청구_확인,
                RInsert.등록자,
                RInsert.등록일;
        Exit When CurC%NotFound;
        PrsInsertLocal;
    End Loop;
    Close CurC;
-- 각각의 정의된 커서의 루프작업    끝


-- 당월말 미불잔액 및 당월청구액 설정
-- 당월청구액 = 당월말미불잔액 - 기청구공제액 (단 집계시는 기청구공제액이 0 이므로 두 금액은 같다.)
    Update  Ft1_자금청구자료
    Set     당월말미불잔액 = Nvl(전월말미불잔액,0) + Nvl(당월미불발생,0) - Nvl(당월미불반제,0),
            당월청구액 = Nvl(전월말미불잔액,0) + Nvl(당월미불발생,0) - Nvl(당월미불반제,0)
    Where   현장코드 = ar_현장코드
    And     자금청구회차 = ar_자금청구회차;
-- 기본으로는 현금 청구로 생성
    Insert Into Ft1_자금청구액구성
    (
        현장코드,
        자금청구회차,
        청구전표번호,
        청구전표라인,
        순번,
        청구구분,
        청구금액,
        등록일,
        등록자
    )
    Select
        현장코드,
        자금청구회차,
        청구전표번호,
        청구전표라인,
        1,
        '1',                    -- 현금 2는 어음
        당월청구액,
        Sysdate,
        ar_사용자ID
    From    Ft1_자금청구자료
    Where   현장코드 = ar_현장코드
    And     자금청구회차 = ar_자금청구회차;
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




Create Or Replace Function F_F자금청구내역자금이체
(
	ar_현장코드			Varchar2,
	ar_자금청구회차     Number,
	ar_경유순번         Number,
	ar_사용자id			Varchar2,
	ar_errm			Out	Varchar2
)
Return Boolean
Is
    lnNumber            Number;
    Cursor CurA
    Is
    Select  *
    From    Fv1_자금청구내역이체 a
    Where   a.현장코드 = ar_현장코드
    And     a.자금청구회차 = ar_자금청구회차
    And     a.경유순번 = ar_경유순번
    And     a.청구금액 > 0
    And     Not Exists
    (
        Select  Null
        From    at5_자금청구내역 b
        Where   a.현장코드 = b.청구현장
        And     a.자금청구회차 = b.자금청구회차
        And     a.청구전표번호 = b.청구전표번호
        And     a.청구전표라인 = b.청구전표라인
    )
    Order By
        a.현장코드,
        a.자금청구회차,
        a.청구전표번호,
        a.청구전표라인,
        a.경유순번,
        a.순번;
    r_자금청구정보          Ft1_자금청구작업%RowType;
    ls_거래처명             At1_전표하.거래처명%Type;
Begin
--이전내용중 미처리분 삭제
    Delete  At5_자금청구내역 a
    Where   a.청구현장 = ar_현장코드
    And     a.자금청구회차 = ar_자금청구회차
    And     a.청구전표번호 Is Not Null
    And     a.청구원천명 = '자금청구'
    And     Not Exists
    (
        Select  Null
        From    At5_자금청구내역 b
        Where   a.청구현장 = b.청구현장
        And     a.자금청구회차 = b.자금청구회차
        And     a.청구전표번호 = b.청구전표번호
        And     a.청구전표라인 = b.청구전표라인
        And     b.지불전표번호 is not null
    );
    Begin
        Select  *
        Into    r_자금청구정보
        From    Ft1_자금청구작업
        Where   현장코드 = ar_현장코드
        And     자금청구회차 = ar_자금청구회차;
    Exception When No_Data_Found Then
        ar_errm := SqlErrm;
        Rollback;
        Return False;
    End;
    Begin
        Select  Max(a.순번)
        Into    lnNumber
        From    At5_자금청구내역 a
        Where   a.청구현장 = ar_현장코드
        And     a.자금청구회차 = ar_자금청구회차;
    Exception When No_Data_Found Then
        lnNumber := Null;
    End;
    If lnNumber Is Null Then
        lnNumber := 0;
    End If;
    For R_A In CurA Loop
        lnNumber := lnNumber + 1;
        Begin
            Select  거래처명
            Into    ls_거래처명
            From    at1_전표하
            Where   전표번호 = R_A.청구전표번호
            And     전표라인 = R_A.청구전표라인;
        Exception When No_Data_Found Then
            ls_거래처명 := Null;
        End;
        Insert Into at5_자금청구내역
        (
            청구현장,
            자금청구회차,
            청구년월,
            순번,
            계정코드,
            청구구분,
            청구금액,
            처리금액,
            적요코드,
            적요1,
            적요2,
            거래처코드,
            거래처등록일,
            거래처명,
            청구원천명,
            청구전표번호,
            청구전표라인,
            등록자,
            등록일
        )
        Values
        (
            ar_현장코드,
            ar_자금청구회차,
            To_char(r_자금청구정보.작업년월,'YYYYMM'),
            lnNumber,
            R_A.계정과목,
            R_A.청구구분,
            R_A.청구금액,
            NULL,
            R_A.적요코드,
            R_A.적요1,
            R_A.적요2,
            R_A.거래처코드,
            R_A.거래처등록일,
            ls_거래처명,
            '자금청구',
            R_A.청구전표번호,
            R_A.청구전표라인,
            ar_사용자id,
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



Create Or Replace Function F_F자금청구미불이체
(
	ar_현장코드			Varchar2,
	ar_자금청구회차     Number,
	ar_사용자id			Varchar2,
	ar_errm			Out	Varchar2
)
Return Boolean
Is
-- 프로그램의 목적 : 전표에서 미지급공사금등의 미불전표를 비목별(재노장외경,비원가)로 집계하여 당월 청구액 산출
    lsStep              Varchar2(2000) := 'Start ';
    lnCnt               Number;
    RInsert             Ft1_자금청구자료%RowType;
    RInfo               Ft1_자금청구작업%RowType;
--적요코드 정의부 (비목구분을 위해)
    ls자재              at9_적요코드.적요코드%Type:= '1001';
    ls노무              at9_적요코드.적요코드%Type:= '1002';
    ls장비              at9_적요코드.적요코드%Type:= '1003';
    ls외주              at9_적요코드.적요코드%Type:= '1004';
    ls경비              at9_적요코드.적요코드%Type:= '1005';
    ls비원가            at9_적요코드.적요코드%Type:= '1006';
--당월발생 미불 집계
    Cursor CurA
    Is
    select
        RInfo.현장코드 현장코드,
        RInfo.자금청구회차,
        a.전표번호 청구전표번호,
        a.전표라인 청구전표라인,
        a.적요코드 ,
        a.거래처코드,
        a.거래처등록일,
        a.거래처명,
        0 전월말미불잔액,
        0 당월미불반제,
        a.대변금액 당월미불발생,
        0 당월말미불잔액,
        0 기청구공제,
        0 당월청구액,
        a.계정코드,
        a.적요1,
        a.적요2,
        a.대변금액 전표금액,
        'N' 현장확인,
        ar_사용자id 등록자,
        Sysdate 등록일
    From
        at1_전표하 a,
        at1_전표상 b
    Where   a.전표번호 = b.전표번호
--    And     a.귀속부서현장 = b.작성부서
    And     a.귀속부서현장 = ar_현장코드
    And     b.확정일 Between RInfo.기간from And Last_Day(RInfo.기간to)
    and     a.반제전표번호 is null
    And     Nvl(a.대변금액,0) <> 0
    And     To_Char(b.확정일,'MMDD') <> '0101'
    And     Exists
    (
        Select  Null
        From    ft1_자금청구계정정의 n
        Where   n.구분자 = '2'          -- 미불
        And     n.계정코드 = a.계정코드
    );
-- 전월말 미불잔액 가져오기
    Cursor CurB
    Is
    select
        RInfo.현장코드 현장코드,
        RInfo.자금청구회차,
        a.전표번호 청구전표번호,
        a.전표라인 청구전표라인,
        a.적요코드 ,
        a.거래처코드,
        a.거래처등록일,
        a.거래처명,
        Nvl(a.대변금액,0) - Sum(decode(sign(Trunc(RInfo.기간from,'MM') - d.확정일),1,c.반제금액,0)) 전월말미불잔액,
        0 당월미불반제,
        0 당월미불발생,
        0 당월말미불잔액,
        0 기청구공제,
        0 당월청구액,
        a.계정코드,
        a.적요1,
        a.적요2,
        a.대변금액 전표금액,
        'N' 현장확인,
        ar_사용자id 등록자,
        Sysdate 등록일
    From
        at1_전표하 a,
        at1_전표상 b,
        at1_잔액관리 c,
        at1_전표상 d
    Where   a.전표번호 = b.전표번호
    And     b.확정일 < RInfo.기간from + Decode(To_Char(RInfo.기간from,'MMDD'),'0101',1,0)
    And     a.귀속부서현장 = RInfo.현장코드
    and     a.반제전표번호 is null
    And     Nvl(a.대변금액,0) <> 0
    And     b.확정일 >= Trunc(rInfo.기간from,'YYYY')
    And     Exists
    (
        Select  Null
        From    ft1_자금청구계정정의 n
        Where   n.구분자 = '2'
        And     n.계정코드 = a.계정코드
    )
    And     a.전표번호 = c.반제전표번호 (+)
    And     a.전표라인 = c.반제전표라인 (+)
    And     c.전표번호 = d.전표번호 (+)
    Group by
        a.전표번호,
        a.전표라인,
        a.적요코드,
        a.거래처코드,
        a.거래처등록일,
        a.거래처명,
        a.대변금액,
        a.계정코드,
        a.적요1,
        a.적요2
    Having Nvl(a.대변금액,0) - Sum(decode(sign(Trunc(RInfo.기간from,'MM') - d.확정일),1,c.반제금액,0)) <> 0;
--당월 미불반제
    Cursor CurC
    Is
    select
        RInfo.현장코드 현장코드,
        RInfo.자금청구회차,
        a.전표번호 청구전표번호,
        a.전표라인 청구전표라인,
        a.적요코드 ,
        a.거래처코드,
        a.거래처등록일,
        a.거래처명,
        0 전월말미불잔액,
        Nvl(Sum(a1.차변금액),0) - Nvl(Sum(a1.대변금액),0)  당월미불반제,
        0 당월미불발생,
        0 당월말미불잔액,
        0 기청구공제,
        0 당월청구액,
        a.계정코드,
        a.적요1,
        a.적요2,
        a.대변금액 전표금액,
        'N' 현장확인,
        ar_사용자id 등록자,
        Sysdate 등록일
    From
        at1_전표하 a,
        at1_전표하 a1,
        at1_전표상 b,
        at1_전표상 b1
    Where   a.전표번호 = b.전표번호
    And     a.귀속부서현장 = RInfo.현장코드
    And     Nvl(a.대변금액,0) <> 0
--    And     To_Char(b.확정일,'MMDD') <> '0101'
    And     Exists
    (
        Select  Null
        From    ft1_자금청구계정정의 n
        Where   n.구분자 = '2'
        And     n.계정코드 = a.계정코드
    )
    And     a.전표번호 = a1.반제전표번호
    And     a.전표라인 = a1.반제전표라인
    And     a1.전표번호 = b1.전표번호
    And     To_Char(b1.확정일,'MMDD') <> '0101'
    And     b1.확정일 Between RInfo.기간from And Last_Day(RInfo.기간to)
    Group by
        a.전표번호,
        a.전표라인,
        a.적요코드,
        a.거래처코드,
        a.거래처등록일,
        a.거래처명,
        a.대변금액,
        a.계정코드,
        a.적요1,
        a.적요2;
--자금청구자료에 삽입하는 local procedure
    Procedure PrsInsertLocal
    Is
    Begin
        If RInsert.적요코드 = ls자재 Then
            If RInfo.자재비청구 = 'Y' Then
                Null;
            Else
                Return;
            End If;
        ElsIf RInsert.적요코드 = ls노무 Then
            If RInfo.노무비청구 = 'Y' Then
                Null;
            Else
                Return;
            End If;
        ElsIf RInsert.적요코드 = ls장비 Then
            If RInfo.장비비청구 = 'Y' Then
                Null;
            Else
                Return;
            End If;
        ElsIf RInsert.적요코드 = ls외주 Then
            If RInfo.외주비청구 = 'Y' Then
                Null;
            Else
                Return;
            End If;
        ElsIf RInsert.적요코드 = ls경비 Then
            If RInfo.경비청구 = 'Y' Then
                Null;
            Else
                Return;
            End If;
        ElsIf RInsert.적요코드 = ls비원가 Then
            If RInfo.비원가청구 = 'Y' Then
                Null;
            Else
                Return;
            End If;
        Else
            Return;
        End If;
        Begin
            Insert Into Ft1_자금청구자료
            (
                현장코드,
                자금청구회차,
                청구전표번호,
                청구전표라인,
                적요코드,
                거래처코드,
                거래처등록일,
                거래처명,
                전월말미불잔액,
                당월미불반제,
                당월미불발생,
                당월말미불잔액,
                기청구공제,
                당월청구액,
                계정과목,
                적요1,
                적요2,
                전표금액,
                현장_확인,
                등록자,
                등록일
            )
            Values
            (
                RInsert.현장코드,
                RInsert.자금청구회차,
                RInsert.청구전표번호,
                RInsert.청구전표라인,
                RInsert.적요코드,
                RInsert.거래처코드,
                RInsert.거래처등록일,
                RInsert.거래처명,
                RInsert.전월말미불잔액,
                RInsert.당월미불반제,
                RInsert.당월미불발생,
                RInsert.당월말미불잔액,
                RInsert.기청구공제,
                RInsert.당월청구액,
                RInsert.계정과목,
                RInsert.적요1,
                RInsert.적요2,
                RInsert.전표금액,
                RInsert.현장_확인,
                RInsert.등록자,
                RInsert.등록일
            );
        Exception When Dup_Val_On_Index Then
            Update  Ft1_자금청구자료
            Set     전월말미불잔액 = Nvl(전월말미불잔액,0) + Nvl(RInsert.전월말미불잔액,0),
                    당월미불반제 = Nvl(당월미불반제,0) + Nvl(RInsert.당월미불반제,0),
                    당월미불발생 = Nvl(당월미불발생,0) + Nvl(RInsert.당월미불발생,0)
            Where   현장코드 = RInsert.현장코드
            And     자금청구회차 = RInsert.자금청구회차
            And     청구전표번호 = RInsert.청구전표번호
            And     청구전표라인 = RInsert.청구전표라인;
        End;
    End;
Begin
--메인루프
    lsStep := '이전자료삭제 ';
    Delete  FT1_자금청구건별승인금액
    Where   현장코드 = ar_현장코드
    And     자금청구회차 = ar_자금청구회차;
    Delete  FT1_자금청구건별확인
    Where   현장코드 = ar_현장코드
    And     자금청구회차 = ar_자금청구회차;
    Delete  Ft1_자금청구액구성
    Where   현장코드 = ar_현장코드
    And     자금청구회차 = ar_자금청구회차;
    Delete  Ft1_자금청구자료
    Where   현장코드 = ar_현장코드
    And     자금청구회차 = ar_자금청구회차;
    lsStep := '당월미불자료 ';
--해당 자금청구 작업의 정보를 읽어옴
    Begin
        Select  *
        Into    RInfo
        From    Ft1_자금청구작업
        Where   현장코드 = ar_현장코드
        And     자금청구회차 = ar_자금청구회차;
    Exception When No_Data_Found Then
        ar_errm := '해당 현장의 해당 차수의 자금청구 목록을 찾을 수 없습니다.';
        Return False;
    End;
    If RInfo.자금청구작업여부 = 'Y' Then
        Null;
    Else
        ar_errm := '해당 자금청구 회차에는 전도자금작업이 포함되어 있지 않습니다.';
        Return False;
    End If;
    Begin
        Select  1
        Into    lnCnt
        From    Ft1_자금청구건별확인
        Where   현장코드 = ar_현장코드
        And     자금청구회차 = ar_자금청구회차
        And     RowNum = 1;
    Exception When No_Data_Found Then
        lnCnt := 0;
    End;
--다음단계로 이관되었는지 검사
    If lnCnt > 0 Then
        ar_errm := '해당 자금청구 회차는 다음 승인 단계로 이관되어 작업이 불가능합니다.';
        Return False;
    End If;
-- 각각의 정의된 커서의 루프작업
    Open CurA;
    Loop
        Fetch CurA
        Into    RInsert.현장코드,
                RInsert.자금청구회차,
                RInsert.청구전표번호,
                RInsert.청구전표라인,
                RInsert.적요코드,
                RInsert.거래처코드,
                RInsert.거래처등록일,
                RInsert.거래처명,
                RInsert.전월말미불잔액,
                RInsert.당월미불반제,
                RInsert.당월미불발생,
                RInsert.당월말미불잔액,
                RInsert.기청구공제,
                RInsert.당월청구액,
                RInsert.계정과목,
                RInsert.적요1,
                RInsert.적요2,
                RInsert.전표금액,
                RInsert.현장_확인,
                RInsert.등록자,
                RInsert.등록일;
        Exit When CurA%NotFound;
        PrsInsertLocal;
    End Loop;
    Close CurA;
    lsStep := '전월말 잔액 ';
    Open CurB;
    Loop
        Fetch CurB
        Into    RInsert.현장코드,
                RInsert.자금청구회차,
                RInsert.청구전표번호,
                RInsert.청구전표라인,
                RInsert.적요코드,
                RInsert.거래처코드,
                RInsert.거래처등록일,
                RInsert.거래처명,
                RInsert.전월말미불잔액,
                RInsert.당월미불반제,
                RInsert.당월미불발생,
                RInsert.당월말미불잔액,
                RInsert.기청구공제,
                RInsert.당월청구액,
                RInsert.계정과목,
                RInsert.적요1,
                RInsert.적요2,
                RInsert.전표금액,
                RInsert.현장_확인,
                RInsert.등록자,
                RInsert.등록일;
        Exit When CurB%NotFound;
        PrsInsertLocal;
    End Loop;
    Close CurB;
    lsStep := '당월미불반제 ';
    Open CurC;
    Loop
        Fetch CurC
        Into    RInsert.현장코드,
                RInsert.자금청구회차,
                RInsert.청구전표번호,
                RInsert.청구전표라인,
                RInsert.적요코드,
                RInsert.거래처코드,
                RInsert.거래처등록일,
                RInsert.거래처명,
                RInsert.전월말미불잔액,
                RInsert.당월미불반제,
                RInsert.당월미불발생,
                RInsert.당월말미불잔액,
                RInsert.기청구공제,
                RInsert.당월청구액,
                RInsert.계정과목,
                RInsert.적요1,
                RInsert.적요2,
                RInsert.전표금액,
                RInsert.현장_확인,
                RInsert.등록자,
                RInsert.등록일;
        Exit When CurC%NotFound;
        PrsInsertLocal;
    End Loop;
    Close CurC;
-- 각각의 정의된 커서의 루프작업    끝


-- 당월말 미불잔액 및 당월청구액 설정
-- 당월청구액 = 당월말미불잔액 - 기청구공제액 (단 집계시는 기청구공제액이 0 이므로 두 금액은 같다.)
    Update  Ft1_자금청구자료
    Set     당월말미불잔액 = Nvl(전월말미불잔액,0) + Nvl(당월미불발생,0) - Nvl(당월미불반제,0),
            당월청구액 = Nvl(전월말미불잔액,0) + Nvl(당월미불발생,0) - Nvl(당월미불반제,0)
    Where   현장코드 = ar_현장코드
    And     자금청구회차 = ar_자금청구회차;
-- 기본으로는 현금 청구로 생성
    Insert Into Ft1_자금청구액구성
    (
        현장코드,
        자금청구회차,
        청구전표번호,
        청구전표라인,
        순번,
        청구구분,
        청구금액,
        등록일,
        등록자
    )
    Select
        현장코드,
        자금청구회차,
        청구전표번호,
        청구전표라인,
        1,
        '1',                    -- 현금 2는 어음
        당월청구액,
        Sysdate,
        ar_사용자ID
    From    Ft1_자금청구자료
    Where   현장코드 = ar_현장코드
    And     자금청구회차 = ar_자금청구회차;
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
