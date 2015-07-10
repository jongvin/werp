/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFBBillTrxR.js(어음거래명세)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 배민정 작성(2006-02-23)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "예금거래명세");
	G_addDataSet(dsCOPY, transCopy, null, sSelectPageName+D_P1("ACT","COPY"), "저장store");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//시스템명 가져오기
	{
		dataset.DataID = sSelectPageName 	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("TRX_GUBUN",txtTRX_GUBUN.value)
											+ D_P2("BANK_CD",txtBANK_CD.value)
											+ D_P2("FUTUREBANK_CD",txtFUTUREBANK_CD.value)
											+ D_P2("DT_F",txtDT_F.value)
											+ D_P2("DT_T",txtDT_T.value)
											+ D_P2("ACCNO_CODE",txtACCNO_CODE.value);
	}
	else if (dataset == dsCOPY)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","COPY");
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
	gridMAIN.focus();	
	G_Load(dsMAIN);	
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

// 취소
function btncancel_onclick()
{	
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "DT_F")
	{
		txtDT_F.value = asDate;
	}
	if (asCalendarID == "DT_T")
	{
		txtDT_T.value = asDate;
	}		
	if (asCalendarID == "DT_F1")
	{
		txtDT_F1.value = asDate;
	}
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
function btnDT_F_onClick()
{
	C_Calendar("DT_F", "D", txtDT_F.value);
}
function btnDT_T_onClick()
{
	C_Calendar("DT_T", "D", txtDT_T.value);
}
function btnDT_F1_onClick()
{
	C_Calendar("DT_F1", "D", txtDT_F1.value);
}

//결번요청
function btnDOCU_NUM_onClick()
{
/*	if ( C_isNull(txtBANK_CD.value) )
	{
		C_msgOk("결번요청할 은행을 선택하세요.","확인")
		return;
	}	

	G_Load(dsCOPY);
	dsCOPY.ClearData();
	dsCOPY.AddRow()
	cnt = dsCOPY.CountRow;
	
	dsCOPY.NameString(cnt,"COMP_CODE") = txtCOMP_CODE.value;
	dsCOPY.NameString(cnt,"BANK_CODE") = txtBANK_CD.value;
	dsCOPY.NameString(cnt,"TRADE_YMD") = C_Replace(txtDT_F1.value,'-','');
	dsCOPY.NameString(cnt,"MISS_NUM") = C_LPad(txtDOCU_NUM.value,6,'0');

	transCopy.Parameters = "ACT=COPY";

	if(G_saveData(dsCOPY))
	{
		C_msgOk("결번요청 작업이 완료되었습니다.","알림");
		G_Load(dsMAIN);
	} */
}

function OnColumnChanged(dataset, row, colid)
{
}
//계좌번호
function txtACCNO_CODE_onblur()
{	
	if (C_isNull(txtACCNO_CODE.value))
	{
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtACCNO_CODE.value);
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("FBS_TRANSFER_CLS", '');
	
	lrRet = C_AutoLov(dsLOV,"T_ACCNO_CODE3", lrArgs,"T");

	if (lrRet == null) return;
	txtACCNO_CODE.value = lrRet.get("ACCNO");
	txtBANK_NAME.value = lrRet.get("BANK_NAME");
	txtBANK_CODE.value = lrRet.get("BANK_CODE");	
	txtBANK_CD.value = '%';
}
function btnACCNO_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtACCNO_CODE.value);
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("FBS_TRANSFER_CLS", '');

	lrRet = C_LOV("T_ACCNO_CODE3", lrArgs,"F");

	if (lrRet == null) return;

	txtACCNO_CODE.value = lrRet.get("ACCNO");
	txtBANK_NAME.value = lrRet.get("BANK_NAME");
	txtBANK_CODE.value = lrRet.get("BANK_CODE");	
	txtBANK_CD.value = '%';
}