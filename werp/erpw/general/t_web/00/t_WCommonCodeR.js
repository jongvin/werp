/**************************************************************************/
/* 1. 프 로 그 램 id : t_WCommonCodeR(공통코드 등록)
/* 2. 유형(시나리오) : 공통코드의 조회 및 입력
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-04)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "코드그룹");
	G_addDataSet(dsGROUP_NO, null, null, sSelectPageName+D_P1("ACT","GROUP_NO"), "그룹번호");
	G_addDataSet(dsLIST, trans, gridSUB01, sSelectPageName+D_P1("ACT","LIST"), "그룹별코드");

	G_addRel(dsMAIN, dsLIST);
	G_addRelCol(dsLIST, "CODE_GROUP_NO", "CODE_GROUP_NO");

	G_Load(dsMAIN, null);
	
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("CODE_GROUP_ID",txtCODE_GROUP_ID.value)
											+ D_P2("CODE_GROUP_NAME",txtCODE_GROUP_NAME.value);
	}
	else if(dataset == dsGROUP_NO)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","GROUP_NO");
	}
	else if (dataset == dsLIST)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","LIST")
											+ D_P2("CODE_GROUP_NO",dsMAIN.NameString(dsMAIN.RowPosition, "CODE_GROUP_NO"));
	}
}

// 세션관련 함수----------------------------------------------------------------//
function SetSession()
{
}

function GetSession()
{
}

function ReportSession(asName, asValue)
{
}

// 함수관련---------------------------------------------------------------------//

// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
	D_defaultAdd();
}

// 삽입
function btninsert_onclick()
{
	D_defaultInsert();
}

// 삭제
function btndelete_onclick()
{
	D_defaultDelete();
}

// 저장
function btnsave_onclick()
{
	D_defaultSave(dsMAIN);
}

// 취소
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
}

function OnLoadCompleted(dataset, rowcnt)
{
}

function OnRowInserted(dataset, row)
{
	if (dataset == dsMAIN)
	{
		var strGROUP_NO;
		
		G_Load(dsGROUP_NO, null);
		
		strGROUP_NO = dsGROUP_NO.NameString(dsGROUP_NO.RowPosition,"GROUP_NO");
		
		dsMAIN.NameString(row,"CODE_GROUP_NO") = strGROUP_NO;
		dsMAIN.NameString(row,"OPEN_TAG") = "F";
	}
	else if(dataset == dsLIST)
	{
		dsLIST.NameString(row,"USE_TAG") = "T";
	}
}

function OnRowDeleted(dataset, row)
{
}

function OnColumnChanged(dataset, row, colid)
{
}

function OnExit(dataset, grid, row, colid, olddata)
{
}

function OnPopup(dataset, grid, row, colid, data)
{
}

// 이벤트관련-------------------------------------------------------------------//
