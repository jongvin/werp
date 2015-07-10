/**************************************************************************/
/* 1. 프 로 그 램 id : t_WLoanSheetR.js(차입대장관리)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 차입대장관리
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-05)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var			lrArgs;
var			sBankCode;
var			sBankName;
var			sAccCode;
var			sDbCr;
var			sSlipId;
var			sSlipIdSeq;
var			sDbCrAmt;
function Initialize()
{
	lrArgs = window.dialogArguments;

	G_addDataSet(dsMAIN, trans,  gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "차입대장");
	G_addDataSet(dsSUB01, trans,  gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "상환내역");
	G_addDataSet(dsSUB02, trans,  gridSUB02, sSelectPageName+D_P1("ACT","SUB02"), "보증내역");
	G_addDataSet(dsLOAN_REFUND_SEQ, null,  null, sSelectPageName+D_P1("ACT","LOAN_REFUND_SEQ"), "상환내역순번");
	G_addDataSet(dsGUAR_SEQ, null,  null, sSelectPageName+D_P1("ACT","GUAR_SEQ"), "대출보증순번");

	G_addDataSet(dsDVD, transDvd,  null, sSelectPageName+D_P1("ACT","DVD"), "상환예정생성");
	
    G_addDataSet(dsLOV, null, null, "", "LOV");


	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"LOAN_NO","LOAN_NO");

	G_addRel(dsMAIN,dsSUB02);
	G_addRelCol(dsSUB02,"LOAN_NO","LOAN_NO");

	//gridMAIN.focus();
	sCompCode = lrArgs.CompCode;
	sCompName = lrArgs.CompName;
	sBankCode = lrArgs.BankCode;
	sBankName = lrArgs.BankName;
	sAccCode = lrArgs.AccCode;
	sDbCr = lrArgs.DbCr;
	sDbCrAmt = lrArgs.DbCrAmt;
	sSlipId = lrArgs.SlipId;
	sSlipIdSeq = lrArgs.SlipIdSeg;


	
	txtCOMP_CODE.value    = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtBANK_CODE.value = sBankCode;
	txtBANK_NAME.value = sBankName;

	G_setLovCol(gridMAIN,"CUST_CODE");
	G_setReadOnlyCol(gridMAIN,"CUST_NAME");
	G_setReadOnlyCol(gridMAIN,"BANK_NAME");

	G_setReadOnlyCol(gridSUB01,"LOAN_REMAIN_AMT");
	G_setReadOnlyCol(gridSUB01,"LOAN_SLIP_NO");
	G_setReadOnlyCol(gridSUB01,"REFUND_SLIP_NO");
	G_setReadOnlyCol(gridSUB01,"INTR_SLIP_NO");
	G_setReadOnlyCol(gridSUB01,"SCH_LOAN_REMAIN_AMT");

	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	gridSUB01.RejectEnterkeyOnPopupStyle = true;

	selectTab(1,2);
	
	gridMAIN.focus();
	D_defaultLoad();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										 + D_P2("COMP_CODE",txtCOMP_CODE.value)
										 + D_P2("ACC_CODE",sAccCode)
										 + D_P2("BANK_CODE",txtBANK_CODE.value);
	}
	else if(dataset == dsSUB01)
	{

		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
										 + D_P2("LOAN_NO",dsMAIN.NameString(dsMAIN.RowPosition,"LOAN_NO"));
	}
	else if(dataset == dsSUB02)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB02")
										 + D_P2("LOAN_NO",dsMAIN.NameString(dsMAIN.RowPosition,"LOAN_NO"));
	}
	else if(dataset == dsLOAN_REFUND_SEQ)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","LOAN_REFUND_SEQ");
	}
	else if(dataset == dsGUAR_SEQ)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","GUAR_SEQ");
	}
	else if(dataset == dsDVD)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","DVD");
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
function	updateConfirm()
{
	if (dsMAIN.IsUpdated || G_isChanged(dsMAIN.id))
	{
		var ret = C_msgYesNo("이 작업을 위해서는 먼저 저장을 하셔야 합니다.<br>변경된 내용을 저장하시겠습니까?" , "저장");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMAIN)) return false;
		}
		else if(ret == "N")
		{
			return false;
		}
	}
	return true;
}
function	chkTopCondition()
{
	if(C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("상단의 사업장을 선택하여 주십시오.");
		return false;
	}
	if(C_isNull(txtBANK_CODE.value))
	{
		C_msgOk("상단의 은행코드를 선택하여 주십시오.");
		return false;
	}
	return true;
}
function	chkNullDatasetColumn(aDataset,aColumnName)
{
	return C_isNull(aDataset.NameString(aDataset.RowPosition,aColumnName));
}
function	chkMainColumnNull(aColumnName)
{
	return chkNullDatasetColumn(dsMAIN,aColumnName);
}
function	HideAllTabPage()
{
	divTabPage1.style.display = "none";
	divTabPage2.style.display = "none";
}
function selectTab(index, totcount)
{
	// 탭페이지의 이미지 변환 공통함수
	if (!C_selectTab(index, totcount)) return;
	HideAllTabPage();
	switch (index)
	{
		case 1:
			divTabPage1.style.display = "";
			sTab = "1";
			break;
		case 2:
			divTabPage2.style.display = "";
			sTab = "2";
			break;

	}
}


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
	D_defaultSave();
}

// 취소
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "LOAN_FDT" || asCalendarID == "INTR_REFUND_FIRST_DT" || asCalendarID == "LOAN_EXPR_DT" || asCalendarID == "CHG_EXPR_DT" ||asCalendarID == "INTR_REFUND_FIRST_DT"
				||asCalendarID == "ORG_REFUND_FIRST_MONTH" )
	{
		dsMAIN.NameString(dsMAIN.RowPosition,asCalendarID) = asDate;
	}
	else if (asCalendarID == "REFUND_SCH_DT" || asCalendarID == "REFUND_INTR_DT" || asCalendarID == "INTR_START_DT" || asCalendarID == "INTR_END_DT")
	{
		dsSUB01.NameString(dsSUB01.RowPosition,asCalendarID) = asDate;
	}
	else if (asCalendarID == "GUAR_START_DT" || asCalendarID == "GUAR_END_DT" || asCalendarID == "GUAR_PAYMENT_DT" || asCalendarID == "GUAR_ESTAB_DT" || asCalendarID == "GUAR_CANCEL_DT")
	{
		dsSUB02.NameString(dsSUB02.RowPosition,asCalendarID) = asDate;
	}
}


function OnLoadCompleted(dataset, rowcnt)
{
}

function OnRowInsertBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		if(!chkTopCondition()) return false;
	}
	return true;
}

function OnRowInserted(dataset, row)
{
	if(dataset == dsMAIN)
	{
		dataset.NameValue(row,"BANK_CODE") =   txtBANK_CODE.value;
		dataset.NameValue(row,"BANK_NAME") 	= txtBANK_NAME.value;
		dataset.NameValue(row,"COMP_CODE")   = txtCOMP_CODE.value;
	}
	else if(dataset == dsSUB01)
	{
		G_Load(dsLOAN_REFUND_SEQ);
		dataset.NameString(row,"LOAN_REFUND_SEQ") = dsLOAN_REFUND_SEQ.NameString(dsLOAN_REFUND_SEQ.RowPosition,"LOAN_REFUND_SEQ");
	}
	else if(dataset == dsSUB02)
	{
		G_Load(dsGUAR_SEQ);
		dataset.NameString(row,"GUAR_SEQ") = dsGUAR_SEQ.NameString(dsGUAR_SEQ.RowPosition,"GUAR_SEQ");
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
	if( dataset == dsMAIN )
	{
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
	var		COL_DATA;
	if (dataset == dsMAIN)
	{
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "LOAN_FDT" || colid == "LOAN_EXPR_DT" ||colid == "INTR_REFUND_FIRST_DT"|| colid == "CHG_EXPR_DT" || colid == "INTR_REFUND_FIRST_DT"||colid == "ORG_REFUND_FIRST_MONTH")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
	else if(dataset == dsSUB01)
	{
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "REFUND_SCH_DT" || colid == "REFUND_INTR_DT" || colid == "INTR_START_DT" || colid == "INTR_END_DT")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
	else if(dataset == dsSUB02)
	{
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "GUAR_START_DT" || colid == "GUAR_END_DT" || colid == "GUAR_PAYMENT_DT" || colid == "GUAR_ESTAB_DT" || colid == "GUAR_CANCEL_DT")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if (dataset == dsMAIN)
	{
		if(colid == "LOAN_FDT" || colid == "LOAN_EXPR_DT" ||colid == "INTR_REFUND_FIRST_DT"|| colid == "CHG_EXPR_DT" || colid == "INTR_REFUND_FIRST_DT"||colid == "ORG_REFUND_FIRST_MONTH")
		{
			C_Calendar(colid, "D", dataset.NameString(row,colid));
		}
	}
	else if(dataset == dsSUB01)
	{
		if(colid == "REFUND_SCH_DT" || colid == "REFUND_INTR_DT" || colid == "INTR_START_DT" || colid == "INTR_END_DT")
		{
			C_Calendar(colid, "D", dataset.NameString(row,colid));
		}
	}
	else if(dataset == dsSUB02)
	{
		if(colid == "GUAR_START_DT" || colid == "GUAR_END_DT" || colid == "GUAR_PAYMENT_DT" || colid == "GUAR_ESTAB_DT" || colid == "GUAR_CANCEL_DT")
		{
			C_Calendar(colid, "D", dataset.NameString(row,colid));
		}
	}

}

function OnDblClick(dataset, grid, row, colid)
{
	if (dataset == dsMAIN)
	{
		btnselect_onclick();
	}
}


// 이벤트관련-------------------------------------------------------------------//
function	btnMakeSchedule_onClick()
{
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("먼저 상단의 차입대장을 선택하셔야 합니다.");
		return;
	}
	if(chkMainColumnNull("LOAN_FDT"))
	{
		C_msgOk("차입일을 입력하셔야 합니다.");
		return;
	}
	if(chkMainColumnNull("LOAN_EXPR_DT"))
	{
		C_msgOk("만기일을 입력하셔야 합니다.");
		return;
	}
	if(chkMainColumnNull("ORG_REFUND_MONTH"))
	{
		C_msgOk("상환주기를 입력하셔야 합니다.");
		return;
	}
	if(chkMainColumnNull("ORG_REFUND_FIRST_MONTH"))
	{
		C_msgOk("최초상환월을 입력하셔야 합니다.");
		return;
	}
	if(chkMainColumnNull("INTR_REFUND_DAY"))
	{
		C_msgOk("이자 지급일자를 입력하셔야 합니다.");
		return;
	}
	if(chkMainColumnNull("INTR_REFUND_FIRST_DT"))
	{
		C_msgOk("이자 최초지급일을 입력하셔야 합니다.");
		return;
	}
	if(chkMainColumnNull("INTR_REFUND_DIV_MONTH"))
	{
		C_msgOk("이자 납입주기를 입력하셔야 합니다.");
		return;
	}
	var		lf_LOAN_AMT = C_convSafeFloat(dsMAIN.NameString(dsMAIN.RowPosition,"LOAN_AMT"));	//차입원금
	var		lf_TITLE_INTR_RATE = C_convSafeFloat(dsMAIN.NameString(dsMAIN.RowPosition,"TITLE_INTR_RATE"));	//명목이율
	if(lf_LOAN_AMT == 0)
	{
		C_msgOk("차입원금을 입력하셔야 합니다.");
		return;
	}
	if(!updateConfirm()) return;
	G_Load(dsDVD);
	dsDVD.NameString(dsDVD.RowPosition,"LOAN_NO") = dsMAIN.NameString(dsMAIN.RowPosition,"LOAN_NO");
	
	transDvd.Parameters = "ACT=DVD";
	if(!G_saveData(dsDVD))return;
	C_msgOk("상환예정이 정상적으로 생성되었습니다.");
	G_Load(dsSUB01);
}
function	btnCANCEL_onclick()
{
	window.close();
}
function btnselect_onclick()
{
	var selIndex = dsMAIN.RowPosition;
	if(selIndex <= 0)
	{
		C_msgOk("선택한 항목이 없습니다.", "확인");
		return;
	}
	
	if (G_isChangedDataset(dsMAIN))
	{
		if(C_msgYesNo("수정후 저장되지 않았습니다.<br>저장하고 진행하시겠습니까?", "확인")!="Y")
		{
			return;
		}
		if(!G_saveAllData(dsMAIN)) return ;
	}
	
	var obj = new Object();
	obj.LOAN_NO = dsMAIN.NameString(dsMAIN.RowPosition,'LOAN_NO');
	obj.REAL_LOAN_NO = dsMAIN.NameString(dsMAIN.RowPosition,'REAL_LOAN_NO');
	obj.LOAN_NAME = dsMAIN.NameString(dsMAIN.RowPosition,'LOAN_NAME');
	obj.LOAN_KIND_CODE = dsMAIN.NameString(dsMAIN.RowPosition,'LOAN_KIND_CODE');
	obj.LOAN_EXPR_DT = dsMAIN.NameString(dsMAIN.RowPosition,'LOAN_EXPR_DT');
	obj.LOAN_FDT = dsMAIN.NameString(dsMAIN.RowPosition,'LOAN_FDT');

	window.returnValue = obj;
	window.close();
}

function btnselect_onclick_bak()
{
	var selIndex = dsSUB01.RowPosition;
	if(selIndex <= 0)
	{
		C_msgOk("선택한 항목이 없습니다.(하단에서 차입 또는 상환 내역을 선택하여 주십시오.)", "확인");
		return;
	}
	
	if (G_isChangedDataset(dsMAIN))
	{
		if(C_msgYesNo("수정후 저장되지 않았습니다.<br>저장하고 진행하시겠습니까?", "확인")!="Y")
		{
			return;
		}
		if(!G_saveAllData(dsMAIN)) return ;
	}
	if(C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_INTR_DT")))
	{
		C_msgOk("예정항목은 선택하실 수 없습니다. 반드시 차입/상환일이 입력된 행을 선택하여 주십시오.", "확인")
		return;
	}
	if(sDbCr == "D")		//차변이면 상환이어야 한다.
	{
		if(C_convSafeFloat(dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_AMT")) == 0)
		{
			C_msgOk("상환금액이 입력되지 않았습니다.", "확인");
			return;
		}
		if(C_convSafeFloat(sDbCrAmt) != C_convSafeFloat(dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_AMT")))
		{
			C_msgOk("전표상의 차변금액과 상환금액이 일치하지 않습니다.", "확인");
			return;
		}
		if(!C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_SLIP_ID"))||!C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SLIP_ID")))
		{
			if(dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SLIP_ID") == sSlipId &&
					dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SLIP_ID") == sSlipIdSeq)
			{
			}
			else
			{
				C_msgOk("선택하신 행은 이미 다른 전표와 관련을 맺고 있습니다.", "확인");
				return;
			}
		}
	}
	else if(sDbCr == "C")	//대변이면 차입이다.
	{
		if(C_convSafeFloat(dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_AMT")) == 0)
		{
			C_msgOk("차입금액이 입력되지 않았습니다.", "확인");
			return;
		}
		if(C_convSafeFloat(sDbCrAmt) != C_convSafeFloat(dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_AMT")))
		{
			C_msgOk("전표상의 대변금액과 차입금액이 일치하지 않습니다.", "확인");
			return;
		}
	}
	
	var obj = new Object();
	obj.LOAN_NO = dsMAIN.NameString(dsMAIN.RowPosition,'LOAN_NO');
	obj.LOAN_FDT = dsMAIN.NameString(dsMAIN.RowPosition,'LOAN_FDT');
	obj.LOAN_EXPR_DT = dsMAIN.NameString(dsMAIN.RowPosition,'LOAN_EXPR_DT');
	obj.REAL_INTR_RATE = dsMAIN.NameString(dsMAIN.RowPosition,'REAL_INTR_RATE');
	obj.TITLE_INTR_RATE = dsMAIN.NameString(dsMAIN.RowPosition,'TITLE_INTR_RATE');
	
	obj.TRANS_DT = dsSUB01.NameString(dsSUB01.RowPosition,"TRANS_DT");
	obj.LOAN_REFUND_SEQ = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_REFUND_SEQ");
	obj.REFUND_SCH_DT = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SCH_DT");
	obj.REFUND_SCH_ORG_AMT = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SCH_ORG_AMT");
	obj.REFUND_SCH_INTR_AMT = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SCH_INTR_AMT");
	obj.REFUND_INTR_DT = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_INTR_DT");
	window.returnValue = obj;
	window.close();
}
