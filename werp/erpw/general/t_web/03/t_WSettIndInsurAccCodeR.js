/**************************************************************************/
/* 1. 프 로 그 램 id : t_WSettIndInsurAccCodeR.jsp(산재보험료기본설정계정등록)
/* 2. 유형(시나리오) : Left-Right(Master-Detail)
/* 3. 기  능  정  의 : 산재보험료기본설정계정등록
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-23)
/* 5. 관련  프로그램 : 없음
/* 6. 특  기  사  항 : 없음
/**************************************************************************/
function Initialize()
{
	//objectPatch();
	G_addDataSet(dsACC_CODE, null, gridACC_CODE, sSelectPageName+D_P1("ACT","ACC_CODE"), "계정과목");
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "적요코드");


	
	gridACC_CODE.focus();

	

}
function OnLoadBefore(dataset)
{
	if (dataset == dsACC_CODE)	//계정과목 가져오기
	{
		
		dataset.DataID = sSelectPageName	+ D_P1("ACT","ACC_CODE")
										+ D_P2("ACC_GRP",'8')			//원가
										+ D_P2("ACC_NAME",'');
	}
	else if(dataset == dsMAIN)
	{

		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN");
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
function	CopyOneRow(arSrcDataset,arSrcRow,arDstDataset,arDstRow)
{
	for(var j = 1 ; j <= arSrcDataset.CountColumn ; ++ j)
	{
		arDstDataset.NameString(arDstRow,arSrcDataset.ColumnID(j)) = arSrcDataset.ColumnString(arSrcRow,j);
	}
	return true;
}
function	MoveSelectedRows(arSrcDataset,arDstDataset)
{
	var		lrArrayRows = new Array();
	for(var i = 1 ; i <= arSrcDataset.CountRow ; ++ i)
	{
		if(arSrcDataset.RowMark(i) == 1)
		{
			lrArrayRows.push(i);
		}
	}
	for(var i = 0 ; i < lrArrayRows.length  ; ++i)
	{
		G_addRow(arDstDataset);
		if(!CopyOneRow(arSrcDataset,lrArrayRows[i],arDstDataset,arDstDataset.RowPosition)) return;
	}
	for(var i = lrArrayRows.length - 1 ; i >= 0 ; --i)
	{
		G_deleteRow(arSrcDataset,lrArrayRows[i],false);
	}
}

// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	gridACC_CODE.focus();
	D_defaultLoad();
	gridMAIN.focus();
	D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
	//D_defaultAdd();
}

// 삽입
function btninsert_onclick()
{
	//D_defaultInsert();
}

// 삭제
function btndelete_onclick()
{
	//D_defaultDelete();
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
function	btnSet_onClick()
{
	MoveSelectedRows(dsACC_CODE,dsMAIN);
	dsACC_CODE.ResetStatus();
}
function	btnReSet_onClick()
{
	MoveSelectedRows(dsMAIN,dsACC_CODE);
	dsACC_CODE.ResetStatus();
}
