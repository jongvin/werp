/**************************************************************************/
/* 1. 프 로 그 램 id : t_WChangePersonPwR.js(개인암호관리)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-19)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/

function Initialize()
{
	G_addDataSet(dsMAIN, trans, null, null, "계좌암호설정");
	
}


function ConfirmSelected()
{
	if(txtNEW_PASSWORD.value == txtNEW_PASSWORD_CONFIRM.value)
	{
	}
	else
	{
		C_msgOk("신규암호와 암호재입력이 서로 다릅니다.");
		return;
	}
	G_Load(dsMAIN);
	dsMAIN.NameString(dsMAIN.RowPosition,"OLD_PW") = txtOLD_PASSWORD.value;
	dsMAIN.NameString(dsMAIN.RowPosition,"NEW_PW") = txtNEW_PASSWORD.value;
	dsMAIN.NameString(dsMAIN.RowPosition,"EMP_NO") = sEmpNo;
	if(!G_saveData(dsMAIN))return;
	C_msgOk("암호가 정상적으로 변경되었습니다.");
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
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

function btnquery_onclick()
{
}

// 추가
function btnadd_onclick()
{
}

// 삽입
function btninsert_onclick()
{
}

// 삭제
function btndelete_onclick()
{
}

// 저장
function btnsave_onclick()
{
	ConfirmSelected();
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
}


function OnKeyPress(dataset, grid, kcode)
{
}

function OnDblClick(dataset, grid, row, colid)
{
}

// 이벤트관련-------------------------------------------------------------------//


function	imgOk_onClick()
{
	ConfirmSelected();
}
