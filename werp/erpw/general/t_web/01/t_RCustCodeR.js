/**************************************************************************/
/* 1. 프 로 그 램 id : t_WCustCodeR.js(거래처코드)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 최언회 작성(2005-11-15)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/

var opnrArgs = window.dialogArguments;

function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "거래처코드");
	G_addDataSet(dsCUST_SEQ, null, null, null, "거래처순번");
	G_addDataSet(dsCUST_CODE, null, null, null, "거래처코드");
	G_addDataSet(dsLOV, null, null, null, "LOV");

	if(opnrArgs.get("CUST_CODE")!="") {
		txtCUST_NAME_S.value = opnrArgs.get("CUST_CODE");
		gridMAIN.Focus();
		btnquery_onclick(); 
	} else {
		txtCUST_NAME_S.value = "쓰벌이거지우지마";
		gridMAIN.Focus();
		btnquery_onclick(); 
		txtCUST_NAME_S.value = "";
	}
	gridMAIN.Focus();

	if (sSlip_Trans_Cls != "T") {
		document.all.btnDELETE.style.display = "none";
	}
}

function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("TRADE_CLS",cboTRADE_CLS.value)
											+ D_P2("CUST_NAME",txtCUST_NAME_S.value.replace(/-/g, ""));
	}
	else if(dataset == dsCUST_SEQ)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","CUST_SEQ");
	}
	else if(dataset == dsCUST_CODE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","CUST_CODE")
											+ D_P2("CUST_NAME",txtCUST_CODE.value.replace(/-/gi,""));
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
	if(txtCUST_NAME_S.value.length<2) {
		C_msgOk("검색조건을 2글자이상 입력하세요.", "확인");
		return;
	}
	D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
	if ((G_FocusDataset == dsMAIN) && (cboTRADE_CLS.value == "%"))
	{
		C_msgOk("거래처구분이 전체일때는 추가할수 없습니다. <br><br> 먼저 거래추구분을 선택하세요.", "확인");
		return;
	}
	
	D_defaultAdd();
	if ((G_FocusDataset == dsCUST_ACCNO) && (dsCUST_ACCNO.NameString(dsCUST_ACCNO.Rowposition,"SEQ") == "0"))
	{
		dsCUST_ACCNO.NameString(dsCUST_ACCNO.Rowposition,"SEQ") = parseInt(dsCUST_ACCNO.NameMax("SEQ",0,0))+1;
	}
}

// 삽입
function btninsert_onclick()
{
	if ((G_FocusDataset == dsMAIN) && (cboTRADE_CLS.value == "%"))
	{
		C_msgOk("거래처구분이 전체일때는 삽입할수 없습니다. <br><br> 먼저 거래추구분을 선택하세요.", "확인");
		return;
	}
	
	D_defaultInsert();
	if ((G_FocusDataset == dsCUST_ACCNO) && (dsCUST_ACCNO.NameString(dsCUST_ACCNO.Rowposition,"SEQ") == "0"))
	{
		dsCUST_ACCNO.NameString(dsCUST_ACCNO.Rowposition,"SEQ") = parseInt(dsCUST_ACCNO.NameMax("SEQ",0,0))+1;
	}
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
	if (dataset == dsMAIN)
	{
		txtTRADE_CLS.value = cboTRADE_CLS.value;
		G_Load(dsCUST_SEQ, null);
		dsMAIN.NameValue(dsMAIN.RowPosition, "CUST_SEQ") = dsCUST_SEQ.NameValue(dsCUST_SEQ.RowPosition, "CUST_SEQ");
		dsMAIN.NameValue(dsMAIN.RowPosition, "GROUP_COMP_CLS") = "F";
		dsMAIN.NameValue(dsMAIN.RowPosition, "USE_CLS") = "T";
	}

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

function OnDblClick(dataset, grid, row, colid){
	if (dataset == dsMAIN)
	{
		btnselect_onclick();
	}
}

function document_onKeyDown(){
	if(event.keyCode==68) {
		C_msgError(G_FocusDataset.ExportData(1, G_FocusDataset.CountRow, true),"확인")
	}
	else if(event.keyCode==13) {
		if(gridMAIN.FocusState) {
			btnselect_onclick();
		} else if(event.srcElement.id == "txtCUST_NAME_S") {
			btnquery_onclick();
		}
	}
	else if(event.keyCode==27) {
		btnCANCEL_onclick();
	}
	else if (event.ctrlLeft == true && event.shiftLeft == true && event.keyCode == 83)
	{

	}
}

// 이벤트관련-------------------------------------------------------------------//
function txtCUST_CODE_onBlur()
{
	if (dsMAIN.CountRow == 0)
	{
		C_msgOk("먼저 추가를 실행하고 입력하셔야 합니다..", "확인");
		return;
	}

	if(C_isNull(txtCUST_CODE.value))
	{
		txtCUST_NAME.value = "";
		return;
	}
	
	if (txtCUST_CODE_F.value == txtCUST_CODE.value) return;
	
	G_Load(dsCUST_CODE, null)
	
	if (dsCUST_CODE.CountRow != 0)
	{
		if(C_msgYesNo("입력하신 거래처코드와 같은 거래처코드가 이미 존재합니다.<br><br>그래도 등록하시겠습니까?","확인") == "N")
		{
			return;
		}
	}
	
	var vCUST_CODE = txtCUST_CODE.value.replace(/-/g, "");
	
	if (txtTRADE_CLS.value == '1')
	{
		if (!C_isValidCustNo(txtCUST_CODE.value))
		{
			C_msgOk(ERR_MSG);
			txtCUST_CODE.focus();
			txtCUST_CODE.value = "";
			return;
		}
		txtCUST_CODE.value = vCUST_CODE.substr(0, 3) + "-" + vCUST_CODE.substr(3, 2) + "-" + vCUST_CODE.substr(5, 5);
	}
	else if (txtTRADE_CLS.value == '2')
	{
		if (!C_isValidRegNo(txtCUST_CODE.value))
		{
			C_msgOk(ERR_MSG);
			txtCUST_CODE.focus();
			txtCUST_CODE.value = "";
			return;
		}
		txtCUST_CODE.value = vCUST_CODE.substr(0, 6) + "-" + vCUST_CODE.substr(6, 7);
	}
	
	if (C_isNull(txtREPRESENT_CUST_CODE.value))
	{
		txtREPRESENT_CUST_SEQ.value		= txtCUST_SEQ.value;
		txtREPRESENT_CUST_CODE.value	= txtCUST_CODE.value;
		txtREPRESENT_CUST_NAME.value	= txtCUST_NAME.value;
	}
}

function txtCUST_NAME_onBlur()
{
	if (txtCUST_NAME_F.value == txtCUST_NAME.value) return;
	
	if (C_isNull(txtREPRESENT_CUST_NAME.value))
	{
		txtREPRESENT_CUST_SEQ.value		= txtCUST_SEQ.value;
		txtREPRESENT_CUST_CODE.value	= txtCUST_CODE.value;
		txtREPRESENT_CUST_NAME.value	= txtCUST_NAME.value;
	}
}

function txtZIPCODE_onBlur()
{
	if(C_isNull(txtZIPCODE.value))
	{
		txtADDR1.value = "";
		return;
	}
	
	if (txtZIPCODE_F.value == txtZIPCODE.value) return;
	
	var lrArgs = new C_Dictionary();
	lrArgs.set("SEARCH_CONDITION", txtZIPCODE.value);

	var		lrRet = C_AutoLov(dsLOV,"T_ZIP_CODE",lrArgs, "T");

	if (lrRet == null) return;

	txtZIPCODE.value	= lrRet.get("MASKED_ZIPCODE");
	txtADDR1.value		= lrRet.get("AREA_NAME");
	txtADDR2.focus();
}

function btnZIPCODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtZIPCODE.value);

	lrRet = C_LOV("T_ZIP_CODE", lrArgs,"F");
	
	if (lrRet == null) return;

	txtZIPCODE.value	= lrRet.get("MASKED_ZIPCODE");
	txtADDR1.value		= lrRet.get("AREA_NAME");
	txtADDR2.focus();
}

function btnREPRESENT_CUST_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtREPRESENT_CUST_CODE.value);

	lrRet = C_LOV("T_CUST_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtREPRESENT_CUST_SEQ.value		= lrRet.get("CUST_SEQ");
	txtREPRESENT_CUST_CODE.value	= lrRet.get("CUST_CODE");
	txtREPRESENT_CUST_NAME.value	= lrRet.get("CUST_NAME");
	cboTRADE_CLS.focus();
}

function	btnCANCEL_onclick()
{
	window.close();
}
function btnselect_onclick()
{
	if (dsMAIN.IsUpdated || G_isChanged(dsMAIN.id))
	{
		C_msgOk("현재 거래처 수정중입니다.<br>저장하고 선택하세요.", "확인");
		return;
	}
	
	var selIndex = dsMAIN.RowPosition;
	if(selIndex <= 0)
	{
		C_msgOk("선택한 항목이 없습니다. 거래처를 선택하여 주십시오.", "확인");
		return;
	}
	
	var obj = new Object();

	obj.CUST_SEQ = dsMAIN.NameString(dsMAIN.RowPosition, "CUST_SEQ");
	obj.CUST_CODE = dsMAIN.NameString(dsMAIN.RowPosition, "CUST_CODE");
	obj.CUST_NAME = dsMAIN.NameString(dsMAIN.RowPosition, "CUST_NAME");
	
	window.returnValue = obj;
	window.close();
}