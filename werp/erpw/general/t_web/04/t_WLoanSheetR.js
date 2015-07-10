/**************************************************************************/
/* 1. 프 로 그 램 id : t_WLoanSheetR.js(차입대장관리)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 차입대장관리
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-05)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var				R_SLIP_ID = "";
var				vSTART_DT = "";
var				vEND_DT = "";
var				vRATIO = "";
var				vAMT = "";
var				vSLIP_ID = "";
var				vSLIP_IDSEQ = "";
function Initialize()
{
	
	G_addDataSet(dsMASTER, trans,  gridMASTER, sSelectPageName+D_P1("ACT","MAIN"), "차입약정");
	G_addDataSet(dsMAIN, trans,  gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "차입대장");
	G_addDataSet(dsSUB01, trans,  gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "상환내역");
	G_addDataSet(dsSUB02, trans,  gridSUB02, sSelectPageName+D_P1("ACT","SUB02"), "보증내역");
	G_addDataSet(dsLOAN_REFUND_SEQ, null,  null, sSelectPageName+D_P1("ACT","LOAN_REFUND_SEQ"), "상환내역순번");
	G_addDataSet(dsGUAR_SEQ, null,  null, sSelectPageName+D_P1("ACT","GUAR_SEQ"), "대출보증순번");
	G_addDataSet(dsSLIP_INFO,null,null,"","");
	G_addDataSet(dsCALC_ITR_AMT,null,null,"","");
	G_addDataSet(dsCALC_PE_ITR_AMT,null,null,"","");
	G_addDataSet(dsCALC_DATE1,null,null,"","");
	G_addDataSet(dsCALC_DATE2,null,null,"","");
	G_addDataSet(dsCALC_DATE3,null,null,"","");
	G_addDataSet(dsPE_SLIP_ID,null,null,"","");
	G_addDataSet(dsAE_SLIP_ID,null,null,"","");
	G_addDataSet(dsSLIP_REMAIN_AMT,null,null,"","");
	G_addDataSet(dsLOAN_NO,null,null,"","");
	G_addDataSet(dsLOAN_CONT_NO,null,null,"","");
	
	
	

	G_addDataSet(dsDVD, transDvd,  null, sSelectPageName+D_P1("ACT","DVD"), "상환예정생성");
	G_addDataSet(dsMAKE_ITR_SLIP, transMAKE_ITR_SLIP,  null, sSelectPageName+D_P1("ACT","MAKE_ITR_SLIP"), "이자전표");
	G_addDataSet(dsREMOVE_SLIP, transREMOVE_SLIP,  null, sSelectPageName+D_P1("ACT","MAKE_ITR_SLIP"), "전표삭제");
	
    G_addDataSet(dsLOV, null, null, "", "LOV");

	G_addRel(dsMASTER,dsMAIN);
	G_addRelCol(dsMAIN,"LOAN_CONT_NO","LOAN_CONT_NO");


	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"LOAN_NO","LOAN_NO");

	G_addRel(dsMAIN,dsSUB02);
	G_addRelCol(dsSUB02,"LOAN_NO","LOAN_NO");

	//gridMAIN.focus();
	txtCOMP_CODE.value    = sCompCode;
	txtCOMPANY_NAME.value = sCompName;

	G_setLovCol(gridMAIN,"CUST_CODE");
	G_setReadOnlyCol(gridMASTER,"BANK_NAME");
	G_setReadOnlyCol(gridMAIN,"CUST_NAME");
	G_setReadOnlyCol(gridMAIN,"BANK_NAME");
	G_setReadOnlyCol(gridMAIN,"SLIP_NO");
	

	G_setReadOnlyCol(gridSUB01,"LOAN_REMAIN_AMT");
	G_setReadOnlyCol(gridSUB01,"LOAN_SLIP_NO");
	G_setReadOnlyCol(gridSUB01,"REFUND_SLIP_NO");
	G_setReadOnlyCol(gridSUB01,"INTR_SLIP_NO");
	G_setReadOnlyCol(gridSUB01,"SCH_LOAN_REMAIN_AMT");

	G_setReadOnlyCol(gridSUB01,"PE_RESET_SLIP_NO");
	G_setReadOnlyCol(gridSUB01,"AE_RESET_SLIP_NO");

	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	gridSUB01.RejectEnterkeyOnPopupStyle = true;

	selectTab(1,2);
	
	gridMASTER.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMASTER)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MASTER")
										 + D_P2("COMP_CODE",txtCOMP_CODE.value)
										 + D_P2("BANK_CODE",txtBANK_CODE.value);
	}
	else if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										 + D_P2("LOAN_CONT_NO",dsMASTER.NameString(dsMASTER.RowPosition,"LOAN_CONT_NO"));
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
	else if (dataset == dsSLIP_INFO)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SLIP_INFO")
										 + D_P2("SLIP_ID",R_SLIP_ID);
	}
	else if(dataset == dsCALC_ITR_AMT)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","CALC_ITR_AMT")
										 + D_P2("START_DT",vSTART_DT)
										 + D_P2("END_DT",vEND_DT)
										 + D_P2("AMT",vAMT)
										 + D_P2("RATIO",vRATIO);
	}
	else if(dataset == dsCALC_PE_ITR_AMT)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","CALC_PE_ITR_AMT")
										 + D_P2("START_DT",dsSUB01.NameString(dsSUB01.RowPosition,"PE_START_DT"))
										 + D_P2("END_DT",dsSUB01.NameString(dsSUB01.RowPosition,"PE_END_DT"))
										 + D_P2("AMT",vAMT)
										 + D_P2("RATIO",vRATIO);
	}
	else if(dataset == dsCALC_DATE1)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","CALC_DATE1")
										 + D_P2("BASE_DT",dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_INTR_DT"));
	}
	else if(dataset == dsCALC_DATE2)
	{
		var			lsExprDt = getExprDt();
		dataset.DataID = sSelectPageName + D_P1("ACT","CALC_DATE2")
										 + D_P2("BASE_DT",dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_INTR_DT"))
										 + D_P2("EXPR_DT",lsExprDt);
	}
	else if(dataset == dsCALC_DATE3)
	{
		var			lsExprDt = getExprDt();
		var			lsPrevDt = getPrevDt();
		dataset.DataID = sSelectPageName + D_P1("ACT","CALC_DATE3")
										 + D_P2("PREV_DT",lsPrevDt)
										 + D_P2("BASE_DT",dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_INTR_DT"))
										 + D_P2("EXPR_DT",lsExprDt)
										 + D_P2("DAYS",dsMAIN.NameString(dsMAIN.RowPosition,"INTR_REFUND_DAY"));
	}
	else if(dataset == dsPE_SLIP_ID)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","PE_SLIP_ID")
										 + D_P2("LOAN_NO",dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_NO"));
	}
	else if(dataset == dsAE_SLIP_ID)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","AE_SLIP_ID")
										 + D_P2("LOAN_NO",dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_NO"));
	}
	else if(dataset == dsSLIP_REMAIN_AMT)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SLIP_REMAIN_AMT")
										 + D_P2("SLIP_ID",vSLIP_ID)
										 + D_P2("SLIP_IDSEQ",vSLIP_IDSEQ);
	}
	else if(dataset == dsLOAN_NO)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","LOAN_NO");
	}
	else if(dataset == dsREMOVE_SLIP)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","REMOVE_SLIP");
	}
	else if(dataset == dsLOAN_CONT_NO)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","LOAN_CONT_NO");
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
	if (dsMASTER.IsUpdated || G_isChanged(dsMASTER.id))
	{
		var ret = C_msgYesNo("이 작업을 위해서는 먼저 저장을 하셔야 합니다.<br>변경된 내용을 저장하시겠습니까?" , "저장");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMASTER)) return false;
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
function	getExprDt()
{
	var			lsExprDt;
	lsExprDt = dsMAIN.NameString(dsMAIN.RowPosition,"CHG_EXPR_DT");
	if(C_isNull(lsExprDt))
	{
		return dsMAIN.NameString(dsMAIN.RowPosition,"LOAN_EXPR_DT");
	}
	else
	{
		return lsExprDt;
	}
}
function	getPrevDt()
{
	var			lsPrevDt;
	for(var i = dsSUB01.RowPosition - 1; i >= 1 ; --i)
	{
		lsPrevDt = dsSUB01.NameString(i,"REFUND_INTR_DT");
		if(!C_isNull(lsPrevDt))
		{
			break;
		}
	}
	if(C_isNull(lsPrevDt))
	{
		return dsMAIN.NameString(dsMAIN.RowPosition,"LOAN_FDT");
	}
	else
	{
		return lsPrevDt;
	}
}
function	changeDatetoNumber(datestr)
{
	return C_convSafeFloat(datestr.replace(/-/g,""));
}
function	chkNullDatasetColumn(aDataset,aColumnName)
{
	return C_isNull(aDataset.NameString(aDataset.RowPosition,aColumnName));
}
function	chkMainColumnNull(aColumnName)
{
	return chkNullDatasetColumn(dsMAIN,aColumnName);
}
function	calcRemainAmt()
{
	var		lfSumLoan = 0;
	var		lfSumRefund = 0;
	var		i;
	var		iCount = dsSUB01.CountRow;
	for(i = 1 ; i <= iCount ; ++i)
	{
		lfSumLoan += C_convSafeFloat(dsSUB01.NameString(i,"LOAN_AMT"));
		lfSumRefund += C_convSafeFloat(dsSUB01.NameString(i,"REFUND_AMT"));
		dsSUB01.NameString(i,"LOAN_REMAIN_AMT") = lfSumLoan - lfSumRefund;
	}
}
function	getPrevRemainAmt()
{
	return C_convSafeFloat(dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_REMAIN_AMT")) + C_convSafeFloat(dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_AMT"));
}
function	calcSchRemainAmt()
{
	var		lfSumLoan = 0;
	var		lfSumRefund = 0;
	var		i;
	var		iCount = dsSUB01.CountRow;
	for(i = 1 ; i <= iCount ; ++i)
	{
		lfSumLoan += C_convSafeFloat(dsSUB01.NameString(i,"LOAN_AMT"));
		lfSumRefund += C_convSafeFloat(dsSUB01.NameString(i,"REFUND_SCH_ORG_AMT"));
		dsSUB01.NameString(i,"SCH_LOAN_REMAIN_AMT") = lfSumLoan - lfSumRefund;
	}
}
function	sumUpLoanAmt()
{
	dsMAIN.NameString(dsMAIN.RowPosition,"LOAN_AMT") = dsSUB01.NameSum("LOAN_AMT",0,0);
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
	else if (asCalendarID == "REFUND_SCH_DT" || asCalendarID == "REFUND_INTR_DT" || asCalendarID == "INTR_START_DT" || asCalendarID == "INTR_END_DT" ||
				asCalendarID == "PE_START_DT" || asCalendarID == "PE_END_DT" ||
				asCalendarID == "AE_START_DT" || asCalendarID == "AE_END_DT" )
	{
		dsSUB01.NameString(dsSUB01.RowPosition,asCalendarID) = asDate;
	}
	else if (asCalendarID == "GUAR_START_DT" || asCalendarID == "GUAR_END_DT" || asCalendarID == "GUAR_PAYMENT_DT" || asCalendarID == "GUAR_ESTAB_DT" || asCalendarID == "GUAR_CANCEL_DT")
	{
		dsSUB02.NameString(dsSUB02.RowPosition,asCalendarID) = asDate;
	}
	else if (asCalendarID == "LOAN_CONT_EXPR_DT")
	{
		dsMASTER.NameString(dsMASTER.RowPosition,asCalendarID) = asDate;
	}
}


function OnLoadCompleted(dataset, rowcnt)
{
}

function OnRowInsertBefore(dataset)
{
	if(dataset == dsMASTER)
	{
		if(!chkTopCondition()) return false;
	}
	return true;
}

function OnRowInserted(dataset, row)
{
	if(dataset == dsMASTER)
	{
		G_Load(dsLOAN_CONT_NO);
		dataset.NameString(row,"LOAN_CONT_NO") =   dsLOAN_CONT_NO.NameString(dsLOAN_CONT_NO.RowPosition,"LOAN_CONT_NO");
		dataset.NameValue(row,"BANK_CODE") =   txtBANK_CODE.value;
		dataset.NameValue(row,"BANK_NAME") 	= txtBANK_NAME.value;
		dataset.NameValue(row,"COMP_CODE")   = txtCOMP_CODE.value;
	}
	if(dataset == dsMAIN)
	{
		G_Load(dsLOAN_NO);
		dataset.NameString(row,"LOAN_NO") =   dsLOAN_NO.NameString(dsLOAN_NO.RowPosition,"LOAN_NO");
		dataset.NameValue(row,"BANK_CODE") =   dsMASTER.NameString(dsMASTER.RowPosition,"BANK_CODE");
		dataset.NameValue(row,"BANK_NAME") 	= dsMASTER.NameString(dsMASTER.RowPosition,"BANK_NAME");
		dataset.NameValue(row,"COMP_CODE")   = dsMASTER.NameString(dsMASTER.RowPosition,"COMP_CODE");
		dataset.NameValue(row,"LOAN_NAME")   = dsMASTER.NameString(dsMASTER.RowPosition,"LOAN_CONT_NAME");
		dataset.NameValue(row,"ITR_TAR_TAG")   = "A";
	}
	else if(dataset == dsSUB01)
	{
		G_Load(dsLOAN_REFUND_SEQ);
		dataset.NameString(row,"LOAN_REFUND_SEQ") = dsLOAN_REFUND_SEQ.NameString(dsLOAN_REFUND_SEQ.RowPosition,"LOAN_REFUND_SEQ");
		if(dataset.CountRow == 1)		//최초 생성
		{
			dataset.NameString(row,"REFUND_INTR_DT") = dsMAIN.NameString(dsMAIN.RowPosition,"LOAN_FDT");
			dataset.NameString(row,"LOAN_AMT") = dsMAIN.NameString(dsMAIN.RowPosition,"LOAN_AMT");
		}
		calcRemainAmt();
	}
	else if(dataset == dsSUB02)
	{
		G_Load(dsGUAR_SEQ);
		dataset.NameString(row,"GUAR_SEQ") = dsGUAR_SEQ.NameString(dsGUAR_SEQ.RowPosition,"GUAR_SEQ");
	}
}

function OnRowDeleteBefore(dataset)
{
	if(dataset == dsSUB01)
	{
		if(dsSUB01.RowPosition < 1) return true;
		if(!C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_SLIP_NO")) ||
			!C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SLIP_NO")) ||
			!C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"INTR_SLIP_NO")))
		{
			C_msgOk("전표가 발행된 것은 삭제가 불가능합니다.");
			return false;
		}
	}
	return true;
}

function OnRowDeleted(dataset, row)
{
	if(dataset == dsSUB01)
	{
		sumUpLoanAmt();
		calcRemainAmt();
	}
}
function	reCalcDate(dataset,row,colid)
{
	var		lsItrTag = dataset.NameString(row,"ITR_TAG");
	if(lsItrTag == "1")			//선취이자
	{
		//선취이자의 경우 이자 지급 대상 기간은 차입일에서 부터 만기일 까지 이다.
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_START_DT") = dsMAIN.NameString(dsMAIN.RowPosition,"LOAN_FDT");
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_END_DT") = dsMAIN.NameString(dsMAIN.RowPosition,"LOAN_EXPR_DT");
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_END_DT") = dsMAIN.NameString(dsMAIN.RowPosition,"LOAN_EXPR_DT");
		G_Load(dsCALC_DATE1);
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_START_DT") = dsCALC_DATE1.NameString(dsCALC_DATE1.RowPosition,"INTR_START_DT");
	}
	else if(lsItrTag == "2")			//후취이자
	{
		//후취이자인 경우는 별다른 일을 하지 않는다.
		//후취이자의 경우는 실제 이자 관련 작업은 후취이자 지급에서 처리된다.
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_START_DT") = "";
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_END_DT") = "";
	}
	else if(lsItrTag == "3")			//선급이자 반제
	{
		//선급이자 반제의 경우는 먼저 해당 차입번호로 되어 있는 선급비용 지급이자 전표를 찾아서 전표번호를 가져온다.
		G_Load(dsCALC_DATE2);
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_START_DT") = "";
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_END_DT") = "";
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_START_DT") = dsCALC_DATE2.NameString(dsCALC_DATE2.RowPosition,"INTR_START_DT");
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_END_DT") = dsCALC_DATE2.NameString(dsCALC_DATE2.RowPosition,"INTR_END_DT");
		G_Load(dsPE_SLIP_ID);
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_ID") = dsPE_SLIP_ID.NameString(dsPE_SLIP_ID.RowPosition,"SLIP_ID");
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_IDSEQ") = dsPE_SLIP_ID.NameString(dsPE_SLIP_ID.RowPosition,"SLIP_IDSEQ");
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_SLIP_NO") = dsPE_SLIP_ID.NameString(dsPE_SLIP_ID.RowPosition,"MAKE_SLIPNO");
		if(C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_ID")))
		{
			C_msgOk("반제할 선급비용 지급이자를 찾을 수 없습니다.");
		}
	}
	else if(lsItrTag == "4")			//후취이자 지급
	{
		//기존의 미지급 비용 이자 전표의 잔액이 남아 있는 것이 있으면 가져온다.
		//이자 계산일자는 전월의 이자 지급일 + 1일부터  이번달 이자 지급일까지로 한다.
		G_Load(dsCALC_DATE3);
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_START_DT") = dsCALC_DATE3.NameString(dsCALC_DATE3.RowPosition,"INTR_START_DT");
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_END_DT") = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_INTR_DT");
		dsSUB01.NameString(dsSUB01.RowPosition,"AE_START_DT") = dsCALC_DATE3.NameString(dsCALC_DATE3.RowPosition,"AE_INTR_START_DT");
		dsSUB01.NameString(dsSUB01.RowPosition,"AE_END_DT") = dsCALC_DATE3.NameString(dsCALC_DATE3.RowPosition,"AE_INTR_END_DT");
		G_Load(dsAE_SLIP_ID);
		dsSUB01.NameString(dsSUB01.RowPosition,"AE_RESET_ITR_ID") = dsAE_SLIP_ID.NameString(dsAE_SLIP_ID.RowPosition,"SLIP_ID");
		dsSUB01.NameString(dsSUB01.RowPosition,"AE_RESET_ITR_IDSEQ") = dsAE_SLIP_ID.NameString(dsAE_SLIP_ID.RowPosition,"SLIP_IDSEQ");
		dsSUB01.NameString(dsSUB01.RowPosition,"AE_RESET_SLIP_NO") = dsAE_SLIP_ID.NameString(dsAE_SLIP_ID.RowPosition,"MAKE_SLIPNO");
		dsSUB01.NameString(dsSUB01.RowPosition,"AE_RESET_ITR_AMT") = dsAE_SLIP_ID.NameString(dsAE_SLIP_ID.RowPosition,"REMAIN_AMT");
	}
	else if(lsItrTag == "5")			//선취 원금 상환
	{
		//이자 일자를 계산 하고
		//만약 미반제된 선급비용이 있다면 가져오고
		G_Load(dsPE_SLIP_ID);
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_ID") = dsPE_SLIP_ID.NameString(dsPE_SLIP_ID.RowPosition,"SLIP_ID");
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_IDSEQ") = dsPE_SLIP_ID.NameString(dsPE_SLIP_ID.RowPosition,"SLIP_IDSEQ");
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_SLIP_NO") = dsPE_SLIP_ID.NameString(dsPE_SLIP_ID.RowPosition,"MAKE_SLIPNO");
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_AMT") = dsPE_SLIP_ID.NameString(dsPE_SLIP_ID.RowPosition,"REMAIN_AMT");
		//만약 만기전 상환이면 이자일자를 역으로 계산해준다.
		var			lsExprDt = getExprDt();
		var			lsBaseDt = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_INTR_DT");
		if(changeDatetoNumber(lsExprDt) != changeDatetoNumber(lsBaseDt))
		{
			dsSUB01.NameString(dsSUB01.RowPosition,"INTR_START_DT") = lsExprDt;
			dsSUB01.NameString(dsSUB01.RowPosition,"INTR_END_DT") = lsBaseDt;
		}
		else
		{
			dsSUB01.NameString(dsSUB01.RowPosition,"INTR_START_DT") = "";
			dsSUB01.NameString(dsSUB01.RowPosition,"INTR_END_DT") = "";
		}
	}
	else if(lsItrTag == "6")			//후취 원금 상환
	{
		//이자 일자를 계산 하고
		G_Load(dsCALC_DATE3);
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_START_DT") = dsCALC_DATE3.NameString(dsCALC_DATE3.RowPosition,"INTR_START_DT");
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_END_DT") = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_INTR_DT");
		//만약 미지급비용이 있다면 가져오고
		G_Load(dsAE_SLIP_ID);
		dsSUB01.NameString(dsSUB01.RowPosition,"AE_RESET_ITR_ID") = dsAE_SLIP_ID.NameString(dsAE_SLIP_ID.RowPosition,"SLIP_ID");
		dsSUB01.NameString(dsSUB01.RowPosition,"AE_RESET_ITR_IDSEQ") = dsAE_SLIP_ID.NameString(dsAE_SLIP_ID.RowPosition,"SLIP_IDSEQ");
		dsSUB01.NameString(dsSUB01.RowPosition,"AE_RESET_SLIP_NO") = dsAE_SLIP_ID.NameString(dsAE_SLIP_ID.RowPosition,"MAKE_SLIPNO");
		dsSUB01.NameString(dsSUB01.RowPosition,"AE_RESET_ITR_AMT") = dsAE_SLIP_ID.NameString(dsAE_SLIP_ID.RowPosition,"REMAIN_AMT");
	}
	else if(lsItrTag == "7")			//선취이자 지급
	{
		//선취이자 지급의 경우는 먼저 해당 차입번호로 되어 있는 선급비용 지급이자 전표를 찾아서 전표번호를 가져온다.
		G_Load(dsCALC_DATE2);
		G_Load(dsCALC_DATE3);
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_START_DT") = dsCALC_DATE3.NameString(dsCALC_DATE3.RowPosition,"INTR_START_DT");
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_END_DT") = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_INTR_DT");
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_START_DT") = dsCALC_DATE2.NameString(dsCALC_DATE2.RowPosition,"INTR_START_DT");
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_END_DT") = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_INTR_DT");
		G_Load(dsPE_SLIP_ID);
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_ID") = dsPE_SLIP_ID.NameString(dsPE_SLIP_ID.RowPosition,"SLIP_ID");
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_IDSEQ") = dsPE_SLIP_ID.NameString(dsPE_SLIP_ID.RowPosition,"SLIP_IDSEQ");
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_SLIP_NO") = dsPE_SLIP_ID.NameString(dsPE_SLIP_ID.RowPosition,"MAKE_SLIPNO");
	}
	fCalcItrAmt();
}
function	OnColumnPosChanged(dataset, grid, row, colid)
{
	if(dataset == dsSUB01)
	{
		if(!C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_SLIP_NO")) ||
			!C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SLIP_NO")) ||
			!C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"INTR_SLIP_NO")))
		{
			grid.ColumnProp(colid, "Edit") = "None";
		}
		else
		{
			grid.ColumnProp(colid, "Edit") = "";
		}
	}
}

function OnColumnChanged(dataset, row, colid)
{
	if(dataset == dsSUB01)
	{
		if(colid == "LOAN_AMT" )
		{
			calcRemainAmt();
			calcSchRemainAmt();
			sumUpLoanAmt();
		}
		else if(colid == "REFUND_AMT")
		{
			calcRemainAmt();
		}
		else if(colid == "REFUND_SCH_ORG_AMT")
		{
			calcSchRemainAmt();
		}
		else if(colid == "ITR_TAG")
		{
			reCalcDate(dataset,row,colid);
		}
		else if(colid == "ITR_TAR_TAG")
		{
			fCalcItrAmt();
		}
		else if(colid == "REFUND_INTR_DT")
		{
			reCalcDate(dataset,row,colid);
		}
	}
}
function OnExit(dataset, grid, row, colid, olddata)
{
	var		COL_DATA;
	if (dataset == dsMASTER)
	{
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "LOAN_CONT_EXPR_DT")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
	else if (dataset == dsMAIN)
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
		if(colid == "REFUND_SCH_DT" || colid == "REFUND_INTR_DT" || colid == "INTR_START_DT" || colid == "INTR_END_DT"||
				colid == "PE_START_DT" || colid == "PE_END_DT" ||
				colid == "AE_START_DT" || colid == "AE_END_DT" )
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
	if (dataset == dsMASTER)
	{
		if(colid == "LOAN_CONT_EXPR_DT")
		{
			C_Calendar(colid, "D", dataset.NameString(row,colid));
		}
	}
	else if (dataset == dsMAIN)
	{
		if(colid == "LOAN_FDT" || colid == "LOAN_EXPR_DT" ||colid == "INTR_REFUND_FIRST_DT"|| colid == "CHG_EXPR_DT" || colid == "INTR_REFUND_FIRST_DT"||colid == "ORG_REFUND_FIRST_MONTH")
		{
			C_Calendar(colid, "D", dataset.NameString(row,colid));
		}
	}
	else if(dataset == dsSUB01)
	{
		if(colid == "REFUND_SCH_DT" || colid == "REFUND_INTR_DT" || colid == "INTR_START_DT" || colid == "INTR_END_DT"||
				colid == "PE_START_DT" || colid == "PE_END_DT" ||
				colid == "AE_START_DT" || colid == "AE_END_DT" )
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


// 이벤트관련-------------------------------------------------------------------//
function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE1", lrArgs,"T");

	if (lrRet == null) return;

	txtCOMP_CODE.value	  = lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value = lrRet.get("COMPANY_NAME");
	D_defaultLoad();
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE1", lrArgs,"T");

	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	D_defaultLoad();
}
//은행코드검색
function txtBANK_CODE_onblur()
{
	if (C_isNull(txtBANK_CODE.value))
	{
		txtBANK_NAME.value = "";
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtBANK_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_BANK_CODE1", lrArgs,"T");	//

	if (lrRet == null) return;

	txtBANK_CODE.value	= lrRet.get("BANK_CODE");
	txtBANK_NAME.value	= lrRet.get("BANK_NAME");

}

function btnBANK_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_BANK_CODE1", lrArgs,"T");	//

	if (lrRet == null) return;

	txtBANK_CODE.value	= lrRet.get("BANK_CODE");
	txtBANK_NAME.value	= lrRet.get("BANK_NAME");

}

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
	var			liRow = dsSUB01.RowPosition;
	G_Load(dsSUB01);
	if(liRow > 0) dsSUB01.RowPosition = liRow;
}
function	btnMakeLoanSlip_onClick()
{
	if(dsSUB01.RowPosition < 1)
	{
		C_msgOk("먼저 차입 목록을 선택 후 작업하십시오.");
		return;
	}
	var			lfAmt;
	lfAmt = C_convSafeFloat(dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_AMT"));
	if(lfAmt <= 0)
	{
		C_msgOk("차입금액이 등록된 행을 선택하여 주십시오.");
		return;
	}
	var pSLIP_ID        = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_SLIP_ID");
	if(!C_isNull(pSLIP_ID))
	{
		C_msgOk("이미 전표가 발행된 것이 있습니다.");
		return;
	}
	pSLIP_ID        = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SLIP_ID");
	if(!C_isNull(pSLIP_ID))
	{
		C_msgOk("이미 상환 전표가 발행된 것이 있습니다.");
		return;
	}
	if(!updateConfirm()) return;
	var			lrObject = new Object();
	lrObject.dept_code = sDeptCode;
	lrObject.comp_code = sCompCode;
	lrObject.emp_no = sEmpNo;
	lrObject.loan_no = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_NO");
	lrObject.loan_refund_seq = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_REFUND_SEQ");

	var		arrRtn2 = window.showModalDialog("./t_PMakeLoanSlipR.jsp", lrObject, "center:yes; dialogWidth:410px; dialogHeight:600px; status:no; help:no; scroll:no");
	if(C_isNull(arrRtn2)) return;
	var			liRow = dsSUB01.RowPosition;
	G_Load(dsSUB01);
	if(liRow > 0) dsSUB01.RowPosition = liRow;
}
function	btnMakeRefundSlip_onClick()
{
	if(dsSUB01.RowPosition < 1)
	{
		C_msgOk("먼저 차입 목록을 선택 후 작업하십시오.");
		return;
	}
	var			lfAmt;
	lfAmt = C_convSafeFloat(dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_AMT"));
	if(lfAmt <= 0)
	{
		C_msgOk("상환금액이 등록된 행을 선택하여 주십시오.");
		return;
	}
	var pSLIP_ID        = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_SLIP_ID");
	if(!C_isNull(pSLIP_ID))
	{
		C_msgOk("이미 전표가 발행된 것이 있습니다.");
		return;
	}
	pSLIP_ID        = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SLIP_ID");
	if(!C_isNull(pSLIP_ID))
	{
		C_msgOk("이미 상환 전표가 발행된 것이 있습니다.");
		return;
	}
	if(!updateConfirm()) return;
	var			lrObject = new Object();
	lrObject.dept_code = sDeptCode;
	lrObject.comp_code = sCompCode;
	lrObject.emp_no = sEmpNo;
	lrObject.loan_no = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_NO");
	lrObject.loan_refund_seq = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_REFUND_SEQ");

	var		arrRtn2 = window.showModalDialog("./t_PMakeLoanRefundSlipR.jsp", lrObject, "center:yes; dialogWidth:410px; dialogHeight:600px; status:no; help:no; scroll:no");
	if(C_isNull(arrRtn2)) return;
	var			liRow = dsSUB01.RowPosition;
	G_Load(dsSUB01);
	if(liRow > 0) dsSUB01.RowPosition = liRow;
}
function	btnMakeItrSlip_onClick()
{
	if(dsSUB01.RowPosition < 1)
	{
		C_msgOk("먼저 차입 목록을 선택 후 작업하십시오.");
		return;
	}
	var pSLIP_ID        = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_SLIP_ID");
	if(!C_isNull(pSLIP_ID))
	{
		C_msgOk("이미 전표가 발행된 것이 있습니다.");
		return;
	}
	pSLIP_ID        = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SLIP_ID");
	if(!C_isNull(pSLIP_ID))
	{
		C_msgOk("이미 상환 전표가 발행된 것이 있습니다.");
		return;
	}
	pSLIP_ID        = dsSUB01.NameString(dsSUB01.RowPosition,"INTR_SLIP_ID");
	if(!C_isNull(pSLIP_ID))
	{
		C_msgOk("이미 이자 전표가 발행된 것이 있습니다.");
		return;
	}
	if(!updateConfirm()) return;
	var		lsItrTag = dsSUB01.NameString(dsSUB01.RowPosition,"ITR_TAG");
	if(lsItrTag == "3")		//선급이자 반제이면
	{
		G_Load(dsMAKE_ITR_SLIP);
		dsMAKE_ITR_SLIP.NameString(dsMAKE_ITR_SLIP.RowPosition,"LOAN_NO") = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_NO");
		dsMAKE_ITR_SLIP.NameString(dsMAKE_ITR_SLIP.RowPosition,"LOAN_REFUND_SEQ") = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_REFUND_SEQ");
		dsMAKE_ITR_SLIP.NameString(dsMAKE_ITR_SLIP.RowPosition,"DEPT_CODE") = sDeptCode;
		dsMAKE_ITR_SLIP.NameString(dsMAKE_ITR_SLIP.RowPosition,"COMP_CODE") = sCompCode;
		
		transMAKE_ITR_SLIP.Parameters = "ACT=MAKE_ITR_SLIP";
		if(!G_saveData(dsMAKE_ITR_SLIP))return;
		C_msgOk("이자전표가 정상적으로 생성되었습니다.");
		var			liRow = dsSUB01.RowPosition;
		G_Load(dsSUB01);
		if(liRow > 0) dsSUB01.RowPosition = liRow;
	}
	else if(lsItrTag == "4" || lsItrTag == "7")		//후취이자 지급또는 선취이자 지급이면
	{
		var			lrObject = new Object();
		lrObject.dept_code = sDeptCode;
		lrObject.comp_code = sCompCode;
		lrObject.emp_no = sEmpNo;
		lrObject.loan_no = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_NO");
		lrObject.loan_refund_seq = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_REFUND_SEQ");
	
		var		arrRtn2 = window.showModalDialog("./t_PMakeAEItrSlipR.jsp", lrObject, "center:yes; dialogWidth:410px; dialogHeight:600px; status:no; help:no; scroll:no");
		if(C_isNull(arrRtn2)) return;
		var			liRow = dsSUB01.RowPosition;
		G_Load(dsSUB01);
		if(liRow > 0) dsSUB01.RowPosition = liRow;
	}
	else
	{
		C_msgOk("이자구분을 선급이자 반제 또는 후취이자 지급또는 선취이자지급을 선택후 작업하셔야 합니다.");
	}
	
}
function	btnRemoveSlip_onClick()
{
	if(dsSUB01.RowPosition < 1)
	{
		C_msgOk("먼저 차입 목록을 선택 후 작업하십시오.");
		return;
	}
	var pSLIP_ID        = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_SLIP_ID");
	var pSLIP_ID2        = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SLIP_ID");
	var pSLIP_ID3        = dsSUB01.NameString(dsSUB01.RowPosition,"INTR_SLIP_ID");
	if(C_isNull(pSLIP_ID) && C_isNull(pSLIP_ID2) && C_isNull(pSLIP_ID3))
	{
		C_msgOk("전표가 발행된 것이 없습니다.");
		return;
	}
	if(!updateConfirm()) return;
	G_Load(dsREMOVE_SLIP);
	dsREMOVE_SLIP.NameString(dsREMOVE_SLIP.RowPosition,"LOAN_NO") = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_NO");
	dsREMOVE_SLIP.NameString(dsREMOVE_SLIP.RowPosition,"LOAN_REFUND_SEQ") = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_REFUND_SEQ");
	
	transREMOVE_SLIP.Parameters = "ACT=REMOVE_SLIP";
	if(!G_saveData(dsREMOVE_SLIP))return;
	C_msgOk("전표가 정상적으로 삭제되었습니다.");
	var			liRow = dsSUB01.RowPosition;
	G_Load(dsSUB01);
	if(liRow > 0) dsSUB01.RowPosition = liRow;
}
function	btnExecSchedule_onClick()
{
	if(dsSUB01.RowPosition < 1)
	{
		C_msgOk("먼저 차입 및 상환내역을 선택하셔야 합니다.");
		return;
	}
	if(C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SCH_DT")))
	{
		C_msgOk("상환 또는 이자지급 예정일이 있는 자료를 선택하십시오.");
		return;
	}
	if(!C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_SLIP_NO")) ||
		!C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SLIP_NO")) ||
		!C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"INTR_SLIP_NO")))
	{
		C_msgOk("전표가 발행된 것은 작업이 불가능합니다.");
		return false;
	}
	dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_INTR_DT") = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SCH_DT");
	dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_AMT") = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SCH_ORG_AMT");
	dsSUB01.NameString(dsSUB01.RowPosition,"INTR_AMT") = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SCH_INTR_AMT");
}
function	btnShowLoanSlip_onClick()
{
	var pSLIP_ID        = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_SLIP_ID");
	var pSLIP_IDSEQ     = dsSUB01.NameString(dsSUB01.RowPosition,"LOAN_SLIP_IDSEQ");
	R_SLIP_ID = pSLIP_ID;
	G_Load(dsSLIP_INFO);
	var pMAKE_COMP_CODE = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"MAKE_COMP_CODE");
	var pMAKE_DT 	     = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"MAKE_DT_TRANS");
	var pMAKE_SEQ     	 = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"MAKE_SEQ");
	var pSLIP_KIND_TAG  = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"SLIP_KIND_TAG");
	var pREADONLY_TF    = "F";
	if(C_isNull(pSLIP_ID))
	{
		C_msgOk("전표가 발행된 것이 없습니다.");
		return;
	}
	
	PopupOpen_AccSlipRetrieve (
		pSLIP_ID,
		pSLIP_IDSEQ,
		pMAKE_DT,
		pMAKE_SEQ,
		pSLIP_KIND_TAG,
		pMAKE_COMP_CODE,
		pREADONLY_TF
	);
}
function	btnShowRefundSlip_onClick()
{
	var pSLIP_ID        = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SLIP_ID");
	var pSLIP_IDSEQ     = dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_SLIP_IDSEQ");
	R_SLIP_ID = pSLIP_ID;
	G_Load(dsSLIP_INFO);
	var pMAKE_COMP_CODE = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"MAKE_COMP_CODE");
	var pMAKE_DT 	     = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"MAKE_DT_TRANS");
	var pMAKE_SEQ     	 = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"MAKE_SEQ");
	var pSLIP_KIND_TAG  = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"SLIP_KIND_TAG");
	var pREADONLY_TF    = "F";
	if(C_isNull(pSLIP_ID))
	{
		C_msgOk("전표가 발행된 것이 없습니다.");
		return;
	}
	
	PopupOpen_AccSlipRetrieve (
		pSLIP_ID,
		pSLIP_IDSEQ,
		pMAKE_DT,
		pMAKE_SEQ,
		pSLIP_KIND_TAG,
		pMAKE_COMP_CODE,
		pREADONLY_TF
	);
}
function	btnShowItrSlip_onClick()
{
	var pSLIP_ID        = dsSUB01.NameString(dsSUB01.RowPosition,"INTR_SLIP_ID");
	var pSLIP_IDSEQ     = dsSUB01.NameString(dsSUB01.RowPosition,"INTR_SLIP_IDSEQ");
	R_SLIP_ID = pSLIP_ID;
	G_Load(dsSLIP_INFO);
	var pMAKE_COMP_CODE = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"MAKE_COMP_CODE");
	var pMAKE_DT 	     = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"MAKE_DT_TRANS");
	var pMAKE_SEQ     	 = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"MAKE_SEQ");
	var pSLIP_KIND_TAG  = dsSLIP_INFO.NameString(dsSLIP_INFO.RowPosition,"SLIP_KIND_TAG");
	var pREADONLY_TF    = "F";
	if(C_isNull(pSLIP_ID))
	{
		C_msgOk("전표가 발행된 것이 없습니다.");
		return;
	}
	
	PopupOpen_AccSlipRetrieve (
		pSLIP_ID,
		pSLIP_IDSEQ,
		pMAKE_DT,
		pMAKE_SEQ,
		pSLIP_KIND_TAG,
		pMAKE_COMP_CODE,
		pREADONLY_TF
	);
}
//실이자지급계산
function	fCalcItrBase()
{
	if(C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"INTR_START_DT")))
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_AMT") = 0;
		return true;
	}
	if(C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"INTR_END_DT")))
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"INTR_AMT") = 0;
		return true;
	}
	vSTART_DT = dsSUB01.NameString(dsSUB01.RowPosition,"INTR_START_DT");
	vEND_DT = dsSUB01.NameString(dsSUB01.RowPosition,"INTR_END_DT");
	vRATIO = dsMAIN.NameString(dsMAIN.RowPosition,"REAL_INTR_RATE");
	if(dsSUB01.NameString(dsSUB01.RowPosition,"ITR_TAR_TAG") == "R")
	{
		vAMT = C_convSafeFloat(dsSUB01.NameString(dsSUB01.RowPosition,"REFUND_AMT"));
	}
	else
	{
		vAMT = getPrevRemainAmt();
	}
	G_Load(dsCALC_ITR_AMT);
	dsSUB01.NameString(dsSUB01.RowPosition,"INTR_AMT") = dsCALC_ITR_AMT.NameString(dsCALC_ITR_AMT.RowPosition,"ITR_AMT");
	return true;
}
//선취이자차입
function	fCalcItr_1()
{
	if(!fCalcItrBase())
	{
		C_msgOk("이자 계산대상일을 입력하십시오.");
		return;
	}
	G_Load(dsCALC_PE_ITR_AMT);
	dsSUB01.NameString(dsSUB01.RowPosition,"PE_ITR_AMT") = dsCALC_PE_ITR_AMT.NameString(dsCALC_PE_ITR_AMT.RowPosition,"ITR_AMT");
}
//선급이자반제
function	fCalcItr_3()
{
	vSLIP_ID = dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_ID");
	vSLIP_IDSEQ =  dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_IDSEQ");
	vRATIO = dsMAIN.NameString(dsMAIN.RowPosition,"REAL_INTR_RATE");
	vAMT = getPrevRemainAmt();
	G_Load(dsCALC_PE_ITR_AMT);
	G_Load(dsSLIP_REMAIN_AMT);
	var		lnLimitAmt = C_convSafeFloat(dsSLIP_REMAIN_AMT.NameString(dsSLIP_REMAIN_AMT.RowPosition,"REMAIN_AMT"));
	var		lnItrAmt = C_convSafeFloat(dsCALC_PE_ITR_AMT.NameString(dsCALC_PE_ITR_AMT.RowPosition,"ITR_AMT"));
	if(lnItrAmt > lnLimitAmt)
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_AMT") = lnLimitAmt;
	}
	else
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_AMT") = lnItrAmt;
	}
}
//후취지급
function	fCalcItr_4()
{
	if(!fCalcItrBase())
	{
		C_msgOk("이자 계산대상일을 입력하십시오.");
		return;
	}
	vSTART_DT = dsSUB01.NameString(dsSUB01.RowPosition,"AE_START_DT");
	vEND_DT = dsSUB01.NameString(dsSUB01.RowPosition,"AE_END_DT");
	vRATIO = dsMAIN.NameString(dsMAIN.RowPosition,"REAL_INTR_RATE");
	vAMT = getPrevRemainAmt();
	G_Load(dsCALC_ITR_AMT);
	dsSUB01.NameString(dsSUB01.RowPosition,"AE_ITR_AMT") = dsCALC_ITR_AMT.NameString(dsCALC_ITR_AMT.RowPosition,"ITR_AMT");
}
//원금상환
function	fCalcItr_5()
{
	if(!fCalcItrBase()) return;
}
function	fCalcItr_6()
{
	if(!fCalcItrBase()) return;
	return;
}
function	fCalcItr_7()
{
	vSLIP_ID = dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_ID");
	vSLIP_IDSEQ =  dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_IDSEQ");
	if(!C_isNull(vSLIP_ID))
	{
		vRATIO = dsMAIN.NameString(dsMAIN.RowPosition,"REAL_INTR_RATE");
		vAMT = getPrevRemainAmt();
		G_Load(dsCALC_PE_ITR_AMT);
		G_Load(dsSLIP_REMAIN_AMT);
		var		lnLimitAmt = C_convSafeFloat(dsSLIP_REMAIN_AMT.NameString(dsSLIP_REMAIN_AMT.RowPosition,"REMAIN_AMT"));
		var		lnItrAmt = C_convSafeFloat(dsCALC_PE_ITR_AMT.NameString(dsCALC_PE_ITR_AMT.RowPosition,"ITR_AMT"));
		if(lnItrAmt > lnLimitAmt)
		{
			dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_AMT") = lnLimitAmt;
		}
		else
		{
			dsSUB01.NameString(dsSUB01.RowPosition,"PE_RESET_ITR_AMT") = lnItrAmt;
		}
	}
	G_Load(dsCALC_PE_ITR_AMT);
	dsSUB01.NameString(dsSUB01.RowPosition,"PE_ITR_AMT") = dsCALC_PE_ITR_AMT.NameString(dsCALC_PE_ITR_AMT.RowPosition,"ITR_AMT");
	if(!fCalcItrBase()) return;
	return;
}
function	fCalcItrAmt()
{
	var			vITR_TAG = dsSUB01.NameString(dsSUB01.RowPosition,"ITR_TAG");
	if(vITR_TAG == "1")		//선취이자차입
	{
		fCalcItr_1();
	}
	else if(vITR_TAG == "3")	//선급이자반제
	{
		fCalcItr_3();
	}
	else if(vITR_TAG == "4")	//후취지급
	{
		fCalcItr_4();
	}
	else if(vITR_TAG == "5")	//선취원금상환
	{
		fCalcItr_5();
	}
	else if(vITR_TAG == "6")	//후취원금상환
	{
		fCalcItr_6();
	}
	else if(vITR_TAG == "7")	//선취이자 지급
	{
		fCalcItr_7();
	}
}
function	btnCalcItrAmt_onClick()
{
	if(dsSUB01.RowPosition < 1)
	{
		C_msgOk("이자를 계산할 차입 상환내역을 선택하십시오.");
		return;
	}
	if(C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"ITR_TAG")))
	{
		C_msgOk("이자구분을 선택하십시오.");
		return;
	}
	fCalcItrAmt();
}
