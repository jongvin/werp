/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFinSecurtyR.js(유가증권현황)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 유가증권현황조회 
/* 4. 변  경  이  력 : 한재원 작성(2005-12-07)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "유가증권현황");
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "유가증권미수이자내역");
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	G_addDataSet(dsSECU_NO, null, null, null, "유가증권순번");
	G_addDataSet(dsITR_CALC_NO, null, null, null, "유가증권미수이자순번");
	G_addDataSet(dsITR_AMT, null, null, null, "유가증권미수이자계산");
	G_addDataSet(dsREMOVE_SLIP, transREMOVE_SLIP,  null, sSelectPageName+D_P1("ACT","MAKE_ITR_SLIP"), "전표삭제");
	
	
	
	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"SECU_NO","SECU_NO");
	

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	
	txtDATE_FROM.value = sDTF;
	txtDATE_TO.value = sDTT;

	G_setLovCol(gridMAIN,"CONSIGN_BANK");
	G_setLovCol(gridMAIN,"BANK_NAME");
	G_setReadOnlyCol(gridMAIN,"MAKE_SLIPNO");
	G_setReadOnlyCol(gridMAIN,"PRE_ITR_SLIPNO");
	G_setReadOnlyCol(gridMAIN,"RE_MAKE_SLIPNO");
	G_setReadOnlyCol(gridSUB01,"MAKE_SLIPNO");

	G_setReadOnlyCol(gridMAIN,"SALE_LOSS");
	G_setReadOnlyCol(gridMAIN,"SALE_NP_ITR_AMT");

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	gridMAIN.TabToss = false;

	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										 + D_P2("COMP_CODE",txtCOMP_CODE.value)
										 + D_P2("SEC_KIND_CODE",cboSECU_KIND_CODE.value)
										 + D_P2("DATE_FROM",txtDATE_FROM.value)
										 + D_P2("DATE_TO",txtDATE_TO.value)
										 + D_P2("DATE_CLS",cboDATE_CLS.value);
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
										 + D_P2("SECU_NO",dsMAIN.NameString(dsMAIN.RowPosition,"SECU_NO"));
	}
	else if(dataset == dsSECU_NO)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SECU_NO");
	}
	else if(dataset == dsITR_CALC_NO)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","ITR_CALC_NO");
	}
	else if(dataset == dsITR_AMT)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","ITR_AMT")
										 + D_P2("DT_F",dsSUB01.NameString(dsSUB01.RowPosition,"CALC_DT_FROM"))
										 + D_P2("DT_T",dsSUB01.NameString(dsSUB01.RowPosition,"CALC_DT_TO"))
										 + D_P2("NUM",dsMAIN.NameString(dsMAIN.RowPosition,"PERSTOCK_AMT"))
										 + D_P2("ITR",dsMAIN.NameString(dsMAIN.RowPosition,"INTR_RATE"));
	}
	else if(dataset == dsREMOVE_SLIP)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","REMOVE_SLIP");
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
function	ApplyItrAmt()
{
	if(!chkTopCondition()) return;
	if(dsSUB01.RowPosition < 1) return;
	G_Load(dsITR_AMT);
	if(dsSUB01.NameString(dsSUB01.RowPosition,"KIND_TAG") == "1")
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"NP_ITR_AMT") = dsITR_AMT.NameString(dsITR_AMT.RowPosition,"ITR_AMT");
	}
	else
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"ITR_AMT") = dsITR_AMT.NameString(dsITR_AMT.RowPosition,"ITR_AMT");
	}
}
function	chkTopCondition()
{
	if(C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("먼저 사업장을 선택하십시오.");
		return false;
	}
	return true;
}
function	chkSave()
{
	if (G_isChangedDataset(dsMAIN))
	{
		var ret = C_msgYesNo("변경사항을 저장한 후 작업이 가능합니다.<br>변경된 내용을 저장하시겠습니까?" , "저장");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMAIN)) return false;
			return true;
		}
		else
		{
			return false;
		}
	}
	return true;
}
function	searchBank(dataset,row,colid,COL_DATA,olddata)
{
	if(C_isNull(COL_DATA))
	{
		dataset.NameString(row,"CONSIGN_BANK") = "";
		dataset.NameString(row,"BANK_NAME") = "";
		return ;
	}
	else
	{
		var		lrArgs = new C_Dictionary();
		lrArgs.set("SEARCH_CONDITION", COL_DATA);
		var		lrRet = C_AutoLov(dsLOV,"T_BANK_CODE1",lrArgs,"T");
		if (lrRet != null)
		{
			dataset.NameString(row,"CONSIGN_BANK")	= lrRet.get("BANK_CODE");
			dataset.NameString(row,"BANK_NAME")	= lrRet.get("BANK_NAME");
		}
		else
		{
			dataset.NameString(row,colid)	= olddata;
		}
	}
}
function	makeDateString(year,month,day)
{
	return C_LPad(year.toString(),4,"0") + "-" + C_LPad(month.toString(),2,"0") + "-" + C_LPad(day.toString(),2,"0");
}
function	addDay(asDate,aiDays)
{
	var		ldDate = C_toDate(asDate);
	var		ldNewDate = new Date(ldDate.getYear(),ldDate.getMonth(),ldDate.getDate() + aiDays);
	return makeDateString(ldNewDate.getYear(),ldNewDate.getMonth() + 1,ldNewDate.getDate());
}
function	addMonths(asDate,aiMonths)
{
	var		ldDate = C_toDate(asDate);
	var		ldNewDate = new Date(ldDate.getYear(),ldDate.getMonth() + aiMonths ,ldDate.getDate());
	return makeDateString(ldNewDate.getYear(),ldNewDate.getMonth() + 1,ldNewDate.getDate());
}
function	addMonthDay(asDate,aiMonths)
{
	var		lsDate = asDate.replace(/-/g, "");
	var		lsDay = lsDate.substring(6,8);
	if(lsDay == "01") return asDate;
	var		liYear = parseInt(lsDate.substring(0,4));
	var		liMonth = parseInt(lsDate.substring(4,6));
	liMonth ++;
	if(liMonth == 13)
	{
		liYear ++;
		liMonth = 1;
	}
	return makeDateString(liYear,liMonth,1);
}
function	searchBankPopup(dataset)
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_BANK_CODE1", lrArgs);

	if(lrRet == null) return;

	dataset.NameString(dataset.RowPosition,"CONSIGN_BANK") = lrRet.get("BANK_CODE");
	dataset.NameString(dataset.RowPosition,"BANK_NAME") = lrRet.get("BANK_NAME");
}
function	getPreExprDate(row,dt)
{
	var			liUpperBound = parseInt(dt.replace(/-/g, ""));
	var			liLowerBound = 0;
	var			i;
	var			liCountRow = dsSUB01.CountRow;
	var			lsPreDt = addMonthDay(dsMAIN.NameString(dsMAIN.RowPosition,"PUBL_DT"));
	for(i = 1 ; i <= liCountRow ; ++ i)
	{
		if(i == row) continue;
		var		lsChdDt = dsSUB01.NameString(i,"CALC_DT_TO");
		if(C_isNull(lsChdDt)) continue;
		var		liChgDt = parseInt(lsChdDt.replace(/-/g, ""));
		if(liChgDt > liUpperBound) continue;
		if(liChgDt > liLowerBound)
		{
			liLowerBound = liChgDt;
			lsPreDt = dsSUB01.NameString(i,"CALC_DT_TO");
		}
	}
	return addDay(lsPreDt,1);
}
function	setPreExprDate(row)
{
	var			lsDtFrom;
	if(dsSUB01.CountRow == 1)
	{
		lsDtFrom = addMonthDay(dsMAIN.NameString(dsMAIN.RowPosition,"PUBL_DT"));
	}
	else if(C_isNull(dsSUB01.NameString(dsSUB01.RowPosition,"CALC_DT_TO")))
	{
		lsDtFrom = getPreExprDate(row,"99999999");
	}
	else
	{
		lsDtFrom = getPreExprDate(row,dsSUB01.NameString(dsSUB01.RowPosition,"CALC_DT_TO"));
	}
	dsSUB01.NameString(dsSUB01.RowPosition,"CALC_DT_FROM") = lsDtFrom;
	dsSUB01.NameString(dsSUB01.RowPosition,"CALC_DT_TO") = addDay(addMonthDay(addDay(lsDtFrom,1),1),-1);
}
function	makeInSlip()
{
	if(!chkTopCondition()) return;
	if(!chkSave()) return;
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("먼저 전표를 발행할 행을 선택하십시오.");
		return;
	}
	if(!C_isNull(dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_ID")))
	{
		C_msgOk("이미 전표가 발행되어 있습니다.");
		return;
	}
	if(C_isNull(dsMAIN.NameString(dsMAIN.RowPosition,"GET_DT")))
	{
		C_msgOk("취득일을 등록하십시오..");
		return;
	}
	var			lrObject = new Object();
	lrObject.dept_code = sDeptCode;
	lrObject.comp_code = sCompCode;
	lrObject.emp_no = sEmpNo;
	lrObject.SECU_NO = dsMAIN.NameString(dsMAIN.RowPosition,"SECU_NO");

	var		arrRtn2 = window.showModalDialog("./t_PMakeSecuInSlipR.jsp", lrObject, "center:yes; dialogWidth:410px; dialogHeight:600px; status:no; help:no; scroll:no");
	if(C_isNull(arrRtn2)) return;
	var			liRow = dsMAIN.RowPosition;
	G_Load(dsMAIN);
	if(liRow > 0) dsMAIN.RowPosition = liRow;
}
function	makeInItrSlip()
{
	if(!chkTopCondition()) return;
	if(!chkSave()) return;
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("먼저 전표를 발행할 행을 선택하십시오.");
		return;
	}
	if(!C_isNull(dsMAIN.NameString(dsMAIN.RowPosition,"PRE_ITR_SLIP_ID")))
	{
		C_msgOk("이미 전표가 발행되어 있습니다.");
		return;
	}
	var			lrObject = new Object();
	lrObject.dept_code = sDeptCode;
	lrObject.comp_code = sCompCode;
	lrObject.emp_no = sEmpNo;
	lrObject.SECU_NO = dsMAIN.NameString(dsMAIN.RowPosition,"SECU_NO");

	var		arrRtn2 = window.showModalDialog("./t_PMakeSecuInItrSlipR.jsp", lrObject, "center:yes; dialogWidth:410px; dialogHeight:600px; status:no; help:no; scroll:no");
	if(C_isNull(arrRtn2)) return;
	var			liRow = dsMAIN.RowPosition;
	G_Load(dsMAIN);
	if(liRow > 0) dsMAIN.RowPosition = liRow;
}

function	makeReturnSlip()
{
	if(!chkTopCondition()) return;
	if(!chkSave()) return;
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("먼저 전표를 발행할 행을 선택하십시오.");
		return;
	}
	if(C_isNull(dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_ID")))
	{
		C_msgOk("매입 전표가 발행된 적이 없습니다.");
		return;
	}
	if(!C_isNull(dsMAIN.NameString(dsMAIN.RowPosition,"RESET_SLIP_ID")))
	{
		C_msgOk("이미 전표가 발행되어 있습니다.");
		return;
	}
	if(C_isNull(dsMAIN.NameString(dsMAIN.RowPosition,"RETURN_DT")))
	{
		C_msgOk("상환일을 등록하십시오..");
		return;
	}
	var			lrObject = new Object();
	lrObject.dept_code = sDeptCode;
	lrObject.comp_code = sCompCode;
	lrObject.emp_no = sEmpNo;
	lrObject.SECU_NO = dsMAIN.NameString(dsMAIN.RowPosition,"SECU_NO");

	var		arrRtn2 = window.showModalDialog("./t_PMakeSecuResetSlipR.jsp", lrObject, "center:yes; dialogWidth:410px; dialogHeight:600px; status:no; help:no; scroll:no");
	if(C_isNull(arrRtn2)) return;
	var			liRow = dsMAIN.RowPosition;
	G_Load(dsMAIN);
	if(liRow > 0) dsMAIN.RowPosition = liRow;
}
function	makeSaleSlip()
{
	if(!chkTopCondition()) return;
	if(!chkSave()) return;
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("먼저 전표를 발행할 행을 선택하십시오.");
		return;
	}
	if(C_isNull(dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_ID")))
	{
		C_msgOk("매입 전표가 발행된 적이 없습니다.");
		return;
	}
	if(!C_isNull(dsMAIN.NameString(dsMAIN.RowPosition,"RESET_SLIP_ID")))
	{
		C_msgOk("이미 전표가 발행되어 있습니다.");
		return;
	}
	if(C_isNull(dsMAIN.NameString(dsMAIN.RowPosition,"SALE_DT")))
	{
		C_msgOk("매각일을 등록하십시오..");
		return;
	}
	var			lrObject = new Object();
	lrObject.dept_code = sDeptCode;
	lrObject.comp_code = sCompCode;
	lrObject.emp_no = sEmpNo;
	lrObject.SECU_NO = dsMAIN.NameString(dsMAIN.RowPosition,"SECU_NO");

	var		arrRtn2 = window.showModalDialog("./t_PMakeSecuSaleSlipR.jsp", lrObject, "center:yes; dialogWidth:410px; dialogHeight:600px; status:no; help:no; scroll:no");
	if(C_isNull(arrRtn2)) return;
	var			liRow = dsMAIN.RowPosition;
	G_Load(dsMAIN);
	if(liRow > 0) dsMAIN.RowPosition = liRow;
}
function	removeSlip()
{
	if(!chkTopCondition()) return;
	if(!chkSave()) return;
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("먼저 유가증권 목록을 선택 후 작업하십시오.");
		return;
	}
	var pSLIP_ID        = dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_ID");
	if(C_isNull(pSLIP_ID))
	{
		C_msgOk("전표가 발행된 것이 없습니다.");
		return;
	}
	G_Load(dsREMOVE_SLIP);
	dsREMOVE_SLIP.NameString(dsREMOVE_SLIP.RowPosition,"SECU_NO") = dsMAIN.NameString(dsMAIN.RowPosition,"SECU_NO");
	
	transREMOVE_SLIP.Parameters = "ACT=REMOVE_SLIP";
	if(!G_saveData(dsREMOVE_SLIP))return;
	C_msgOk("전표가 정상적으로 삭제되었습니다.");
	var			liRow = dsMAIN.RowPosition;
	G_Load(dsMAIN);
	if(liRow > 0) dsMAIN.RowPosition = liRow;
}
function	removeReturnSlip()
{
	if(!chkTopCondition()) return;
	if(!chkSave()) return;
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("먼저 유가증권 목록을 선택 후 작업하십시오.");
		return;
	}
	var pSLIP_ID        = dsMAIN.NameString(dsMAIN.RowPosition,"RESET_SLIP_ID");
	if(C_isNull(pSLIP_ID))
	{
		C_msgOk("전표가 발행된 것이 없습니다.");
		return;
	}
	G_Load(dsREMOVE_SLIP);
	dsREMOVE_SLIP.NameString(dsREMOVE_SLIP.RowPosition,"SECU_NO") = dsMAIN.NameString(dsMAIN.RowPosition,"SECU_NO");
	
	transREMOVE_SLIP.Parameters = "ACT=REMOVE_RESET_SLIP";
	if(!G_saveData(dsREMOVE_SLIP))return;
	C_msgOk("전표가 정상적으로 삭제되었습니다.");
	var			liRow = dsMAIN.RowPosition;
	G_Load(dsMAIN);
	if(liRow > 0) dsMAIN.RowPosition = liRow;
}
function	makeNoItrSlip()
{
}
function	makeItrSlip()
{
}
function	removeItrSlip()
{
	if(!chkTopCondition()) return;
	if(!chkSave()) return;
	if(dsMAIN.RowPosition < 1)
	{
		C_msgOk("먼저 유가증권 목록을 선택 후 작업하십시오.");
		return;
	}
	var pSLIP_ID        = dsMAIN.NameString(dsMAIN.RowPosition,"PRE_ITR_SLIP_ID");
	if(C_isNull(pSLIP_ID))
	{
		C_msgOk("전표가 발행된 것이 없습니다.");
		return;
	}
	G_Load(dsREMOVE_SLIP);
	dsREMOVE_SLIP.NameString(dsREMOVE_SLIP.RowPosition,"SECU_NO") = dsMAIN.NameString(dsMAIN.RowPosition,"SECU_NO");
	
	transREMOVE_SLIP.Parameters = "ACT=REMOVE_ITR_SLIP";
	if(!G_saveData(dsREMOVE_SLIP))return;
	C_msgOk("전표가 정상적으로 삭제되었습니다.");
	var			liRow = dsMAIN.RowPosition;
	G_Load(dsMAIN);
	if(liRow > 0) dsMAIN.RowPosition = liRow;
}

// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	if (txtCOMP_CODE.value == "")
	{
		C_msgOk("사업장을 입력 하십시오.", "확인");
		return;
	}
	if (txtDATE_FROM.value == "" || txtDATE_TO.value == "")
	{
		C_msgOk("조회기간을 입력 하십시오.", "확인");
		return;
	}
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
	if (asCalendarID == "DATE_FROM")
	{
		txtDATE_FROM.value = asDate;
	}
	else if (asCalendarID == "DATE_TO")
	{
		txtDATE_TO.value = asDate;
	}
	else if (asCalendarID == dsMAIN.id+"."+"GET_DT")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"GET_DT") = asDate;
	}
	else if (asCalendarID == dsMAIN.id+"."+"PUBL_DT")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"PUBL_DT") = asDate;
	}
	else if (asCalendarID == dsMAIN.id+"."+"EXPR_DT")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"EXPR_DT") = asDate;
	}
	else if (asCalendarID == dsMAIN.id+"."+"SALE_DT")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"SALE_DT") = asDate;
	}
	else if (asCalendarID == dsMAIN.id+"."+"RETURN_DT")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"RETURN_DT") = asDate;
	}
	else if (asCalendarID == dsSUB01.id+"."+"CALC_DT_TO")
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"CALC_DT_TO") = asDate;
		setPreExprDate(dsSUB01.RowPosition);
	}
	else if (asCalendarID == dsSUB01.id+"."+"CALC_DT_FROM")
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"CALC_DT_FROM") = asDate;
		setPreExprDate(dsSUB01.RowPosition);
	}
}

function OnRowInsertBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		if(!chkTopCondition()) return false;
		return true;
	}
	else if(dataset == dsSUB01)
	{
		return true;
	}
	return false;
}
function OnRowInserted(dataset, row)
{
	if(dataset == dsMAIN)
	{
		G_Load(dsSECU_NO);
		dataset.NameString(row,"SECU_NO") = dsSECU_NO.NameString(dsSECU_NO.RowPosition,"SECU_NO");
		if(cboSECU_KIND_CODE.value == "%")
		{
			dataset.NameString(row,"SEC_KIND_CODE") =   sDfltCode;
		}
		else
		{
			dataset.NameString(row,"SEC_KIND_CODE") =   cboSECU_KIND_CODE.value;
		}
		dataset.NameString(row,"COMP_CODE") =   txtCOMP_CODE.value;
		dataset.NameString(row,"ITR_TAG") = "D";		//단리
	}
	else if(dataset == dsSUB01)
	{
		G_Load(dsITR_CALC_NO);
		dataset.NameString(row,"ITR_CALC_NO") = dsITR_CALC_NO.NameString(dsITR_CALC_NO.RowPosition,"ITR_CALC_NO");
		dataset.NameString(row,"KIND_TAG") = "1";	//미수이자
		setPreExprDate(row);
	}
}
function OnExit(dataset, grid, row, colid, olddata)
{
	if (dataset == dsMAIN)
	{
		var		COL_DATA;
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "CONSIGN_BANK" || colid == "BANK_NAME")
		{
			searchBank(dataset,row,colid,COL_DATA,olddata);
		}
		else if(colid == "GET_DT"||colid == "PUBL_DT"||colid == "EXPR_DT"||colid == "SALE_DT"||colid == "RETURN_DT")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
	else if(dataset == dsSUB01)
	{
		var		COL_DATA;
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "CALC_DT_TO" || colid == "CALC_DT_FROM")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
			setPreExprDate(row);
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(grid == gridMAIN && (colid == "CONSIGN_BANK"||colid == "BANK_NAME" ))
	{
		searchBankPopup(dsMAIN);
	}
	if (dataset == dsMAIN)
	{
		if(colid == "GET_DT"||colid == "PUBL_DT"||colid == "EXPR_DT"||colid == "SALE_DT"||colid == "RETURN_DT")
		{
			C_Calendar(dataset.id+"."+colid, "D", dataset.NameString(dataset.RowPosition,colid));
		}
	}
	else if(dataset == dsSUB01)
	{
		if(colid == "CALC_DT_TO"||colid == "CALC_DT_FROM")
		{
			C_Calendar(dataset.id+"."+colid, "D", dataset.NameString(dataset.RowPosition,colid));
		}
	}

}
function	OnDuplicateColumn(dataset,grid,row,colid)
{
	if(row <= 1) return;
	if (dataset == dsMAIN)
	{
		if(colid == "CONSIGN_BANK"||colid == "BANK_NAME")
		{
			dataset.NameString(row,"CONSIGN_BANK") = dataset.NameString(row - 1,"CONSIGN_BANK");
			dataset.NameString(row,"BANK_NAME") = dataset.NameString(row - 1,"BANK_NAME");
		}
	}
}

// 이벤트관련-------------------------------------------------------------------//
function txtCOMP_CODE_onfocus()
{
	oldData1 = txtCOMP_CODE.value;	
}
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
	
	if (lrRet == null)
	{
		txtCOMP_CODE.value = oldData1;
		return;
	}
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
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
}


function btnDATE_FROM_onClick()
{
	C_Calendar("DATE_FROM", "D", txtDATE_FROM.value);
}

function btnDATE_TO_onClick()
{
	C_Calendar("DATE_TO", "D", txtDATE_TO.value);
}
function	cboSECU_KIND_CODE_onChange()
{
	gridMAIN.focus();
	D_defaultLoad();
}

function	cboDATE_CLS_onChange()
{
	gridMAIN.focus();
	D_defaultLoad();
}
function	btnApplyItrAmt_onClick()
{
	ApplyItrAmt();
}
function	btnMakeInSlip_onClick()	//매입전표발행
{
	makeInSlip();
}
function	btnMakeReturnSlip_onClick()	//상환전표발행
{
	makeReturnSlip();
}
function	btnMakeSaleSlip_onClick()	//매각전표발행
{
	makeSaleSlip();
}
function	btnRemoveSlip_onClick()	//매입전표삭제
{
	removeSlip();
}
function	btnRemoveReturnSlip_onClick()
{
	removeReturnSlip();
}
function	btnMakeNpItrSlip_onClick()	//미수이자전표발행
{
	makeNoItrSlip();
}
function	btnMakeItrSlip_onClick()	//이자수익전표발행
{
	makeItrSlip();
}
function	btnRemoveItrSlip_onClick()	//이자전표삭제
{
	removeItrSlip();
}
function	btnShowInSlip_onClick()	//매입전표보기
{
	var pSLIP_ID        = dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_ID");
	var pSLIP_IDSEQ     = dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_IDSEQ");
	var pMAKE_COMP_CODE = dsMAIN.NameString(dsMAIN.RowPosition,"MAKE_COMP_CODE");
	var pMAKE_DT 	     = dsMAIN.NameString(dsMAIN.RowPosition,"MAKE_DT_TRANS");
	var pMAKE_SEQ     	 = dsMAIN.NameString(dsMAIN.RowPosition,"MAKE_SEQ");
	var pSLIP_KIND_TAG  = dsMAIN.NameString(dsMAIN.RowPosition,"SLIP_KIND_TAG");
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
function	btnShowInItrSlip_onClick()
{
	var pSLIP_ID        = dsMAIN.NameString(dsMAIN.RowPosition,"PRE_ITR_SLIP_ID");
	var pSLIP_IDSEQ     = dsMAIN.NameString(dsMAIN.RowPosition,"PRE_ITR_SLIP_IDSEQ");
	var pMAKE_COMP_CODE = dsMAIN.NameString(dsMAIN.RowPosition,"PRE_ITR_MAKE_COMP_CODE");
	var pMAKE_DT 	     = dsMAIN.NameString(dsMAIN.RowPosition,"PRE_ITR_MAKE_DT_TRANS");
	var pMAKE_SEQ     	 = dsMAIN.NameString(dsMAIN.RowPosition,"PRE_ITR_MAKE_SEQ");
	var pSLIP_KIND_TAG  = dsMAIN.NameString(dsMAIN.RowPosition,"PRE_ITR_SLIP_KIND_TAG");
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
function	btnShowRetSlip_onClick()
{
	var pSLIP_ID        = dsMAIN.NameString(dsMAIN.RowPosition,"RESET_SLIP_ID");
	var pSLIP_IDSEQ     = dsMAIN.NameString(dsMAIN.RowPosition,"RESET_SLIP_IDSEQ");
	var pMAKE_COMP_CODE = dsMAIN.NameString(dsMAIN.RowPosition,"RE_MAKE_COMP_CODE");
	var pMAKE_DT 	     = dsMAIN.NameString(dsMAIN.RowPosition,"RE_MAKE_DT_TRANS");
	var pMAKE_SEQ     	 = dsMAIN.NameString(dsMAIN.RowPosition,"RE_MAKE_SEQ");
	var pSLIP_KIND_TAG  = dsMAIN.NameString(dsMAIN.RowPosition,"RE_SLIP_KIND_TAG");
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

function	btnMakeInItrSlip_onClick()
{
	makeInItrSlip();
}
