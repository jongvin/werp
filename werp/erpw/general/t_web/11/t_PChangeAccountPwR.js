/**************************************************************************/
/* 1. 프 로 그 램 id : t_WCustCodeR.js(거래처코드)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 최언회 작성(2005-11-15)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/

var lrArgs = window.dialogArguments;
var	intX = 0;
var	intY = 0;
var	intWidth = 300;
var	intHeight = 200;
function Initialize()
{
	document.body.topMargin = 0;
	document.body.leftMargin = 0;
	
	if (intX == 0 && intY == 0 )
	{
		window.dialogTop = (window.screen.availHeight / 2) - ((intHeight + 25) / 2);
		window.dialogLeft = (window.screen.availWidth / 2) - ((intWidth + 6) / 2);
	}
	else
	{
		window.dialogTop = intY;
		window.dialogLeft = intX;
	}
	G_addDataSet(dsMAIN, trans, null, null, "계좌암호설정");
	
	window.dialogHeight = (intHeight + 25).toString() + "px";
	window.dialogWidth = (intWidth + 6).toString() + "px";
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
	dsMAIN.NameString(dsMAIN.RowPosition,"ACCNO") = lrArgs.accno;
	dsMAIN.NameString(dsMAIN.RowPosition,"NEW_PW") = txtNEW_PASSWORD.value;
	dsMAIN.NameString(dsMAIN.RowPosition,"EMP_NO") = lrArgs.emp_no;
	if(!G_saveData(dsMAIN))return;
	window.returnValue = "OK";
	window.close();
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
function document_onKeyDown()
{
	if (event.keyCode == 27)
	{
		imgCancle_onClick();
	}
}


function btnRetrieve_onClick()
{
	G_Load(dsMain, null);
}

function imgOk_onClick()
{
	
	ConfirmSelected();
}

function imgCancle_onClick()
{
	window.returnValue = null;
	window.close();
}
