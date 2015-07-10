/**************************************************************************/
/* 1. 프 로 그 램 id : t_WAccSummaryR.js(적요코드)
/* 2. 유형(시나리오) : Left-Right(Master-Detail)
/* 3. 기  능  정  의 : 계정코드 별 적요코드의 등록
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-15)
/* 5. 관련  프로그램 : 없음
/* 6. 특  기  사  항 : 없음
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsACC_CODE, null, gridACC_CODE, sSelectPageName+D_P1("ACT","ACC_CODE"), "계정과목");
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "적요코드");


	G_addRel(dsACC_CODE, dsMAIN);
	G_addRelCol(dsMAIN, "ACC_CODE", "ACC_CODE");
	
	gridACC_CODE.focus();

}
function OnLoadBefore(dataset)
{
	if (dataset == dsACC_CODE)	//계정과목 가져오기
	{
		var		strACC_CODE = txtACC_CODE.value;

		dataset.DataID = sSelectPageName	+ D_P1("ACT","ACC_CODE")
											+ D_P2("ACC_CODE",strACC_CODE);
	}
	else if(dataset == dsMAIN)
	{
		var 	strACC_CODE = dsACC_CODE.NameString(dsACC_CODE.RowPosition,"ACC_CODE");

		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("ACC_CODE",strACC_CODE);
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

function OnRowInsertBefore(dataset)
{
	return true;
}

function OnRowInserted(dataset, row)
{
}

function OnRowDeleteBefore(dataset)
{
	return true;
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
function txtACC_CODE_onblur()
{
	G_Load(dsACC_CODE,null);
}

