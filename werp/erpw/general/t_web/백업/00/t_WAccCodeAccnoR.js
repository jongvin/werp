/**************************************************************************/
/* 1. 프 로 그 램 id : t_WVatCodeR(부가세코드등록)
/* 2. 유형(시나리오) : 부가세코드 조회 및 입력
/* 3. 기  능  정  의 : 부가세코드를 등록및 조회한다.
/* 4. 변  경  이  력 : 최언회 작성(2005-10-15)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "부가세계정등록");
	G_addDataSet(dsLOV, null, null, null, "LOV");

	txtCOMP_CODE_S.value = sCompCode;
	txtCOMPANY_NAME_S.value = sCompName;
	G_Load(dsMAIN,null);

	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	gridMAIN.focus();

}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//부가세코드 가져오기
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										 + D_P2("COMP_CODE",txtCOMP_CODE_S.value);
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

var lock_01 = false;
// 추가
function btnadd_onclick()
{
	lock_01 = true;
	//D_defaultAdd();
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE_S.value);
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV_NEW("T_ACC_CODE13", null, lrArgs, "T", "T");
	
	if (lrRet != null) {
		var idx = 0;
		for (idx = 0; idx < lrRet.length; idx++)
		{
			lrArgs = lrRet[idx];
			//D_defaultAdd();
			G_addRow(dsMAIN);

			dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE") = txtCOMP_CODE_S.value; 
			dsMAIN.NameString(dsMAIN.RowPosition,"ACC_CODE") = lrArgs.get("ACC_CODE");
			dsMAIN.NameString(dsMAIN.RowPosition,"ACC_NAME") = lrArgs.get("ACC_NAME");
		}
	}
	lock_01 = false;
}

// 삽입
function btninsert_onclick()
{
	//D_defaultInsert();
	btnadd_onclick();
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
	if(dataset == dsMAIN)
	{
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
	if(dataset == dsMAIN)
	{
		if(lock_01) return;
		lock_01 = true;
		if(colid=='ACC_CODE')
		{
			if(C_isNull(dsMAIN.NameString(row,"ACC_CODE")))
			{
				dsMAIN.NameString(row,"ACC_NAME") = "";
				lock_01 = false;
				return;
			}
			
			var lrArgs = new C_Dictionary();
			lrArgs.set("COMP_CODE", txtCOMP_CODE_S.value);
			lrArgs.set("SEARCH_CONDITION", dsMAIN.NameString(row,"ACC_CODE"));

			var		lrRet = C_AutoLov(dsLOV,"T_ACC_CODE13",lrArgs, "T");

			if (lrRet != null)
			{
				dsMAIN.NameString(row,"ACC_CODE")	= lrRet.get("ACC_CODE");
				dsMAIN.NameString(row,"ACC_NAME")	= lrRet.get("ACC_NAME");
			}
		}
		else if (colid == "ACCNO")
		{
			if(C_isNull(dsMAIN.NameString(row,"ACCNO")))
			{
				dsMAIN.NameString(row,"ACCT_NAME")	= "";
				dsMAIN.NameString(row,"BANK_CODE")	= "";
				dsMAIN.NameString(row,"BANK_NAME")	= "";
				lock_01 = false;
				return;
			}

			var lrArgs = new C_Dictionary();
			var lrRet = null;

			lrArgs.set("COMP_CODE", txtCOMP_CODE_S.value);		
			lrArgs.set("SEARCH_CONDITION", dsMAIN.NameString(row,"ACCNO"));
		
			if (C_isNull(dsMAIN.NameString(row,"ACCNO")))
			{
				lrRet = C_LOV("T_ACCNO_CODE1", lrArgs,"F");
			}
			else
			{
				lrRet = C_LOV("T_ACCNO_CODE1", lrArgs,"T");
			}
			
			if (lrRet != null) {
				dsMAIN.NameString(row,"ACCNO")	= lrRet.get("ACCNO");
				dsMAIN.NameString(row,"ACCT_NAME")	= lrRet.get("ACCT_NAME");
				dsMAIN.NameString(row,"BANK_CODE")	= lrRet.get("BANK_CODE");
				dsMAIN.NameString(row,"BANK_NAME")	= lrRet.get("BANK_NAME");
			}
		}
		lock_01 = false;
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
}

function OnPopup(dataset, grid, row, colid, data)
{
	if (dataset == dsMAIN)
	{
		lock_01 = true;
		if (colid == "ACC_CODE")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;

			lrArgs.set("COMP_CODE", txtCOMP_CODE_S.value);		
			lrArgs.set("SEARCH_CONDITION", dsMAIN.NameString(row,"ACC_CODE"));
		
			if (C_isNull(dsMAIN.NameString(row,"ACC_CODE")))
			{
				lrRet = C_LOV("T_ACC_CODE13", lrArgs,"F");
			}
			else
			{
				lrRet = C_LOV("T_ACC_CODE13", lrArgs,"T");
			}
			
			if (lrRet != null) {
				dsMAIN.NameString(row,"ACC_CODE")	= lrRet.get("ACC_CODE");
				dsMAIN.NameString(row,"ACC_NAME")	= lrRet.get("ACC_NAME");
			}
		}
		else if (colid == "ACCNO")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("COMP_CODE", txtCOMP_CODE_S.value);		
			lrArgs.set("SEARCH_CONDITION", dsMAIN.NameString(row,"ACCNO"));
		
			if (C_isNull(dsMAIN.NameString(row,"ACCNO")))
			{
				lrRet = C_LOV("T_ACCNO_CODE1", lrArgs,"F");
			}
			else
			{
				lrRet = C_LOV("T_ACCNO_CODE1", lrArgs,"T");
			}
			
			if (lrRet != null) {
				dsMAIN.NameString(row,"ACCNO")	= lrRet.get("ACCNO");
				dsMAIN.NameString(row,"ACCT_NAME")	= lrRet.get("ACCT_NAME");
				dsMAIN.NameString(row,"BANK_CODE")	= lrRet.get("BANK_CODE");
				dsMAIN.NameString(row,"BANK_NAME")	= lrRet.get("BANK_NAME");
			}
		}
		lock_01 = false;
	}
}

// 이벤트관련-------------------------------------------------------------------//
function txtCOMP_CODE_S_onblur()
{
	if (C_isNull(txtCOMP_CODE_S.value))
	{
		txtCOMPANY_NAME_S.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE_S.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE1", lrArgs, "T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE_S.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME_S.value	= lrRet.get("COMPANY_NAME");
	D_defaultLoad();
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE1", lrArgs, "T");
	
	if (lrRet == null) return;

	txtCOMP_CODE_S.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME_S.value	= lrRet.get("COMPANY_NAME");
	D_defaultLoad();
}