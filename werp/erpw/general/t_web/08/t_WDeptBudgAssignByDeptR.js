/**************************************************************************/
/* 1. 프 로 그 램 id : t_WDeptBudgAssignByDeptR(부서예산편성부서별)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 한재원 작성(2005-12-15)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var			sBudgCodeNo = "";
var			sBudgItemCode = "";
var			sBudgItemName = "";
var			sBudgItemFullPath = "";
var			bNowCalc = false;
var			sConfirm = "";
function Initialize()
{
	G_addDataSet(dsMASTER, trans, gridMASTER, null, "예산목록",null,null,true);
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "예산별 부서 목록",null,null,true);
	G_addDataSet(dsSUB01, trans, gridSUB01, null, "월별예산목록");
	G_addDataSet(dsBUDG_ITEM, null, null, null, "부서예산 목록 가져오기");
	
	
	G_addDataSet(dsCOPY,transCopy,null,null,"복사");
	G_addDataSet(dsDVD_MONTHS,transDvd,null,null,"일괄월별분할");
	G_addDataSet(dsCONFIRM,transConfirm,null,null,"예산확정취소");
	G_addDataSet(dsCONFIRM_ALL,transConfirmAll,null,null,"전부서예산확정취소");
	G_addDataSet(dsDEPT_ALL,transDeptAll,null,null,"일괄부서등록");
	G_addDataSet(dsBUDG_ITEM_ALL,transBudgItemAll,null,null,"부서별일괄항목등록");
	G_addDataSet(dsITEM_COST, transItemCost, null,null, "단가적용");
	G_addDataSet(dsDEPT_COPY,transDeptCopy,null,null,"발령정보설정");
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	G_addRel(dsMASTER,dsMAIN);
	G_addRelCol(dsMAIN,"COMP_CODE","COMP_CODE");
	G_addRelCol(dsMAIN,"CLSE_ACC_ID","CLSE_ACC_ID");
	G_addRelCol(dsMAIN,"DEPT_CODE","DEPT_CODE");
	G_addRelCol(dsMAIN,"CHG_SEQ","CHG_SEQ");
	//G_addRelCol(dsMAIN,"RESERVED_SEQ","RESERVED_SEQ");
	//G_addRelCol(dsMAIN,"BUDG_CODE_NO","BUDG_CODE_NO");

	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"COMP_CODE","COMP_CODE");
	G_addRelCol(dsSUB01,"CLSE_ACC_ID","CLSE_ACC_ID");
	G_addRelCol(dsSUB01,"DEPT_CODE","DEPT_CODE");
	G_addRelCol(dsSUB01,"BUDG_CODE_NO","BUDG_CODE_NO");
	G_addRelCol(dsSUB01,"CHG_SEQ","CHG_SEQ");
	G_addRelCol(dsSUB01,"RESERVED_SEQ","RESERVED_SEQ");
	
	G_setLovCol(gridSUB01,"BUDG_YM");

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value = sAccId;
	txtMAKE_DEPT_CODE.value = sDeptCode;
	txtMAKE_DEPT_NAME.value = sDeptName;

	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	gridSUB01.RejectEnterkeyOnPopupStyle = true;
	gridMASTER.focus();
	
	G_setReadOnlyCol(gridMASTER,"BUDG_ITEM_REQ_AMT_SUM"); 
	G_setReadOnlyCol(gridMASTER,"DEPT_NAME"); 
	G_setReadOnlyCol(gridMAIN,"BUDG_ITEM_CODE"); 
	G_setReadOnlyCol(gridMAIN,"BUDG_ITEM_REQ_AMT");
	//G_setReadOnlyCol(gridMAIN,"BUDG_CODE_NAME");
	//G_setReadOnlyCol(gridMAIN,"BUDG_ITEM_ASSIGN_AMT");
	G_setReadOnlyCol(gridMAIN,"FULL_PATH");	
	G_setReadOnlyCol(gridSUB01,"BUDG_YM");
	//G_setReadOnlyCol(gridSUB01,"BUDG_MONTH_ASSIGN_AMT");
	
	//G_Load(dsMASTER);
	
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMASTER)	//부서목록 가져오기
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MASTER")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value)
											+ D_P2("MAKE_DEPT",txtMAKE_DEPT_CODE.value)
											+ D_P2("CHG_SEQ","0");
	}
	else if (dataset == dsMAIN)	//시스템명 가져오기
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",dsMASTER.NameString(dsMASTER.RowPosition,"COMP_CODE"))
											+ D_P2("CLSE_ACC_ID",dsMASTER.NameString(dsMASTER.RowPosition,"CLSE_ACC_ID"))
											+ D_P2("DEPT_CODE",dsMASTER.NameString(dsMASTER.RowPosition,"DEPT_CODE"))
											+ D_P2("CHG_SEQ",dsMASTER.NameString(dsMASTER.RowPosition,"CHG_SEQ"));
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","SUB01")
											+ D_P2("COMP_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE"))
											+ D_P2("CLSE_ACC_ID",dsMAIN.NameString(dsMAIN.RowPosition,"CLSE_ACC_ID"))
											+ D_P2("DEPT_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"DEPT_CODE"))
											+ D_P2("CHG_SEQ",dsMAIN.NameString(dsMAIN.RowPosition,"CHG_SEQ"))
											+ D_P2("RESERVED_SEQ",dsMAIN.NameString(dsMAIN.RowPosition,"RESERVED_SEQ"))
											+ D_P2("BUDG_CODE_NO",dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_CODE_NO"));
	}
	else if(dataset == dsBUDG_ITEM)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","BUDG_ITEM")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value)
											+ D_P2("CHG_SEQ","0")
											+ D_P2("BUDG_CODE_NO",sBudgCodeNo);
	}
	else if(dataset == dsCOPY)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","COPY");
	}
	else if(dataset == dsITEM_COST)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","ITEM_COST");
	}
	else if(dataset == dsDVD_MONTHS)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","DVD_MONTHS");
	}
	else if(dataset == dsCONFIRM)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","CONFIRM");
	}
	else if(dataset == dsCONFIRM_ALL)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","CONFIRM_ALL");
	}
	else if(dataset == dsDEPT_ALL)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","DEPT_ALL");
	}
	else if(dataset == dsBUDG_ITEM_ALL)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","BUDG_ITEM_ALL");
	} 
	else if(dataset == dsDEPT_COPY)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","DEPT_COPY");
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
function	dvdMonth()
{
	/*
	if(!checkConditions()) return;
	if(!D_checkIsLoadedInternal(dsSUB01)) return ;
	if(!D_checkMasterRowExistsInternal(dsSUB01,"월별분할")) return ;
	if(dsSUB01.CountRow < 1) return;
	var		lsYearMonth = txtCLSE_ACC_ID.value + "-01";
	var		ldReqAmt = C_convSafeFloat(dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_ITEM_ASSIGN_AMT"));
	var		ldMonthReqAmt = Math.floor(ldReqAmt / dsSUB01.CountRow);
	var		ldReqTotal = 0;
	
	for(var i = 1 ; i <= dsSUB01.CountRow ; ++ i)
	{
		if(i == dsSUB01.CountRow)
		{
			ldMonthReqAmt = ldReqAmt - ldReqTotal;
		}
		dsSUB01.NameString(i,"BUDG_MONTH_ASSIGN_AMT") = ldMonthReqAmt;
		ldReqTotal += ldMonthReqAmt;
	}
	*/
	if(!checkConditions()) return;
	if(!D_checkIsLoadedInternal(dsSUB01)) return ;
	if(!D_checkMasterRowExistsInternal(dsSUB01,"월별분할")) return ;
	var		lsYearMonth = txtCLSE_ACC_ID.value + "-01";
	var		ldReqAmt = C_convSafeFloat(dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_ITEM_REQ_AMT"));
	//var		ldAssignAmt = C_convSafeFloat(dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_ITEM_ASSIGN_AMT"));
	var		ldMonthReqAmt = Math.floor(ldReqAmt / 12);
	//var		ldMonthAssignAmt = Math.floor(ldAssignAmt / 12);
	var		ldReqTotal = 0;
	var		ldAssignTotal = 0;
	
	for(var i = 0 ; i < 12 ; ++ i)
	{
		var		lsYm = addMonthsString(lsYearMonth,i);
		var		liRow = dsSUB01.NameValueRow("BUDG_YM", lsYm);
		if(liRow == 0) //없다면
		{
			G_addRow(dsSUB01);
			liRow = dsSUB01.RowPosition;
			dsSUB01.NameString(liRow,"BUDG_YM") = lsYm;
		}
		if(i == 11)
		{
			ldMonthReqAmt = ldReqAmt - ldReqTotal;
			//ldMonthAssignAmt = ldAssignAmt - ldAssignTotal;
		}
		dsSUB01.NameString(liRow,"BUDG_MONTH_REQ_AMT") = ldMonthReqAmt;
		//dsSUB01.NameString(liRow,"BUDG_MONTH_ASSIGN_AMT") = ldMonthAssignAmt;
		ldReqTotal += ldMonthReqAmt;
		//ldAssignTotal += ldMonthAssignAmt;
	}
}
function	reCalcSum1()
{
	//if(!chkNumber.checked) return;
	
	if(bNowCalc) return;
	
	dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_ITEM_REQ_AMT") = dsSUB01.NameSum("BUDG_MONTH_REQ_AMT",0,0);
		
}
function	reCalcSum2()
{
	//if(!chkNumber.checked) return;
	
	if(bNowCalc) return;
	
	//dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_ITEM_ASSIGN_AMT") = dsSUB01.NameSum("BUDG_MONTH_ASSIGN_AMT",0,0);
	
}
function	checkConditions()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("먼저 사업장코드를 선택하세요.", "확인");
		return false;
	}

	if(C_isNull(txtCLSE_ACC_ID.value))
	{
		C_msgOk("먼저 회기를 선택하세요.", "확인");
		return false;
	}
	
	return true;
}
function	monthToNumber(asMonth)
{
	if(asMonth.substr(0,1) == "0")
	{
		return parseInt(asMonth.substr(1,1));
	}
	else 
	{
		return parseInt(asMonth);
	}
}
function	numberToMonth(aiMonth)
{
	if(aiMonth > 0 && aiMonth < 10)
	{
		return "0"+aiMonth.toString();
	}
	else
	{
		return aiMonth.toString();
	}
}
function	addMonthsString(asYmValue,aNumber)
{
	var	lsYm = asYmValue.replace(/-/g, "");
	var	liYear = parseInt(lsYm.substr(0,4));
	var	liMonth = monthToNumber(lsYm.substr(4,2));
	var	liTotalMonths = liYear * 12 + liMonth + aNumber;
	liMonth = liTotalMonths % 12 == 0 ? 12 : liTotalMonths % 12 ;
	liYear = liMonth == 12 ? Math.floor(liTotalMonths / 12) - 1 : Math.floor(liTotalMonths / 12);
	return liYear.toString() + "-" + numberToMonth(liMonth);
}


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
function addDeptAll()
{
	G_Load(dsDEPT_ALL);
	dsDEPT_ALL.NameString(dsDEPT_ALL.RowPosition,"COMP_CODE")      =  txtCOMP_CODE.value;
	dsDEPT_ALL.NameString(dsDEPT_ALL.RowPosition,"CLSE_ACC_ID")    =  txtCLSE_ACC_ID.value;
	dsDEPT_ALL.NameString(dsDEPT_ALL.RowPosition,"CHG_SEQ") 	  = "0";
	
	transDeptAll.Parameters = "ACT=DEPT_ALL";
	if(!G_saveData(dsDEPT_ALL))return;
	C_msgOk("모든 예산신청부서가 등록되었습니다.");
	G_Load(dsMASTER);
}

function addBudgItemAll() //해당부서 일괄항목등록
{
	G_Load(dsBUDG_ITEM_ALL);
	
	for(var i = 1 ; i <= dsMASTER.CountRow ; ++i)
	{
		if (dsMASTER.RowMark(i) =="1")
		{
			dsBUDG_ITEM_ALL.AddRow();
			dsBUDG_ITEM_ALL.NameString(dsBUDG_ITEM_ALL.RowPosition,"COMP_CODE")      	=  txtCOMP_CODE.value;
			dsBUDG_ITEM_ALL.NameString(dsBUDG_ITEM_ALL.RowPosition,"CLSE_ACC_ID")    	=  txtCLSE_ACC_ID.value;
			dsBUDG_ITEM_ALL.NameString(dsBUDG_ITEM_ALL.RowPosition,"DEPT_CODE")   	=  dsMASTER.NameString(i ,"DEPT_CODE");
			dsBUDG_ITEM_ALL.NameString(dsBUDG_ITEM_ALL.RowPosition,"CHG_SEQ") 	       = "0";
			dsBUDG_ITEM_ALL.NameString(dsBUDG_ITEM_ALL.RowPosition,"MAKE_DEPT")         =  txtMAKE_DEPT_CODE.value;
			
		}
		
	}	


	transBudgItemAll.Parameters = "ACT=BUDG_ITEM_ALL";
	if(!G_saveData(dsBUDG_ITEM_ALL))return;
	C_msgOk("부서별 예산항목등록이 정상처리되었습니다.");
	G_Load(dsMAIN);
}
function addBudgItemAllForAllDept()
{
	G_Load(dsBUDG_ITEM_ALL);
	
	for(var i = 1 ; i <= dsMASTER.CountRow ; ++i)
	{
		
		dsBUDG_ITEM_ALL.AddRow();
		dsBUDG_ITEM_ALL.NameString(dsBUDG_ITEM_ALL.RowPosition,"COMP_CODE")      	=  txtCOMP_CODE.value;
		dsBUDG_ITEM_ALL.NameString(dsBUDG_ITEM_ALL.RowPosition,"CLSE_ACC_ID")    	=  txtCLSE_ACC_ID.value;
		dsBUDG_ITEM_ALL.NameString(dsBUDG_ITEM_ALL.RowPosition,"DEPT_CODE")   	=  dsMASTER.NameString(i ,"DEPT_CODE");
		dsBUDG_ITEM_ALL.NameString(dsBUDG_ITEM_ALL.RowPosition,"CHG_SEQ") 	       = "0";
		dsBUDG_ITEM_ALL.NameString(dsBUDG_ITEM_ALL.RowPosition,"MAKE_DEPT")         =  txtMAKE_DEPT_CODE.value;	
		
	}	


	transBudgItemAll.Parameters = "ACT=BUDG_ITEM_ALL";
	if(!G_saveData(dsBUDG_ITEM_ALL))return;
	C_msgOk("전부서  예산항목등록이 정상처리 되었습니다.");
	G_Load(dsMAIN);
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
	//if(!checkConditions()) return;

	if(G_FocusDataset == dsMASTER)
	{
		var lrArgs = new C_Dictionary();
		var lrRet = null;
	
		lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
		lrArgs.set("SEARCH_CONDITION", "");
	
		lrRet = C_LOV("T_BUDG_DEPT_CODE2", lrArgs,"F");
		
		if (lrRet == null) return;
		D_defaultAdd(dsMASTER);
		dsMASTER.NameValue(dsMASTER.RowPosition, "DEPT_CODE")	       = lrRet.get("DEPT_CODE");
		dsMASTER.NameValue(dsMASTER.RowPosition, "DEPT_NAME")	       = lrRet.get("DEPT_NAME");
		
	}
	else if(G_FocusDataset == dsMAIN)
	{
		var lrArgs = new C_Dictionary();
		var lrRet = null;
		lrArgs.set("1COMP_CODE", txtCOMP_CODE.value);
		lrArgs.set("2COMP_CODE", txtCOMP_CODE.value);
		lrArgs.set("3COMP_CODE", txtCOMP_CODE.value);
		lrArgs.set("DEPT_CODE", txtMAKE_DEPT_CODE.value);
		lrArgs.set("SEARCH_CONDITION", "");
	
		lrRet = C_LOV("T_BUDG_CODE2", lrArgs,"F");
		
		if (lrRet == null) return;
		D_defaultAdd(dsMAIN);
		dsMAIN.NameValue(dsMAIN.RowPosition, "BUDG_CODE_NO")	       = lrRet.get("BUDG_CODE_NO");
		dsMAIN.NameValue(dsMAIN.RowPosition, "BUDG_CODE_NAME")		= lrRet.get("BUDG_CODE_NAME");
		dsMAIN.NameValue(dsMAIN.RowPosition, "FULL_PATH")			= lrRet.get("FULL_BUDG_CODE_NAME");
		
		btnDvdMonths_onClick();
		
	}
	else if(G_FocusDataset == dsSUB01)
	{
		//D_defaultAdd();
	}
	
}

// 삽입
function btninsert_onclick()
{
	btnadd_onclick();
}

// 삭제
function btndelete_onclick()
{
	if(G_FocusDataset == dsMASTER)
	{
		if( C_msgOkCancel("신청부서를 삭제하면 예산신청내역도 삭제됩니다. <br> 정말로 삭제하시겠습니까?","주의")=='C')
		{
			return;	
		}
	}
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
	if (asCalendarID == "BUDG_YM")
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"BUDG_YM") = asDate;
	}
}

function OnLoadCompleted(dataset, rowcnt)
{
	if(dataset == dsSUB01)
	{
		if(dsMAIN.NameValue(dsMAIN.RowPosition, "ITEM_NO") == 0) 
		{
			//gridSUB01.Editable ="true";	
		}
		else
		{
			//gridSUB01.Editable ="false";
		}	
	}
}
function OnRowInsertBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		if(C_isNull(txtCOMP_CODE.value)) return false;
		if(C_isNull(txtCLSE_ACC_ID.value)) return false;
	}
	else if(dataset == dsSUB01)
	{
		
		if (dataset.CountRow == 12)
		{
			C_msgOk("월이 초과했으므로 더 추가할 수 없습니다");	
			return false;
		}
	}
	return true;
}

function OnRowInserted(dataset, row)
{
	if(row < 1) return;

	if(dataset == dsMASTER)
	{
		dataset.NameString(row,"COMP_CODE") = txtCOMP_CODE.value;
		dataset.NameString(row,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
		
	}
	else if(dataset == dsMAIN)
	{
		dataset.NameString(row,"COMP_CODE") = txtCOMP_CODE.value;
		dataset.NameString(row,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
		dataset.NameString(row,"DEPT_CODE") = dsMASTER.NameValue(dsMASTER.RowPosition, "DEPT_CODE");;
		
		dataset.NameString(row, "CHG_SEQ") = "0";
		dsMAIN.NameString(row, "RESERVED_SEQ") = "1";
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
	if(dataset == dsSUB01)
	{
		if(colid == "BUDG_MONTH_REQ_AMT")
		{
			dsSUB01.NameValue(dsSUB01.RowPosition, "BUDG_MONTH_ASSIGN_AMT") =  dsSUB01.NameValue(dsSUB01.RowPosition, "BUDG_MONTH_REQ_AMT"); 
			reCalcSum1();
			reCalcSum2();
		}
		
	}
	
}

function OnExit(dataset, grid, row, colid, olddata)
{
	if(grid == gridSUB01)
	{
		var		COL_DATA;
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "BUDG_YM")
		{
			D_defaultYmProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
		
		grid.focus();
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(colid == "BUDG_YM")
	{
		C_Calendar("BUDG_YM", "M", dataset.NameString(dataset.RowPosition,colid));
	}
}
function OnPostBefore(dataset, trans)
{
	if(dataset == dsMAIN || dataset == dsSUB01)
	{
		if(dsSUB01.CountRow > 0)	//월별금액에 자료가 있는 경우만 검증--> 즉 월별에 아무 자료도 없는 경우는 무시한다.
		{
			var	ldMain = C_convSafeFloat(dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_ITEM_REQ_AMT"));
			var	ldSubSum = dsSUB01.NameSum("BUDG_MONTH_REQ_AMT",0,0);
			if(ldSubSum != ldMain)
			{
				C_msgOk("신청금액과 월별 분할 금액의 합계가 다릅니다.");
				return;
			}
		}
	}
	return true;
}

// 이벤트관련-------------------------------------------------------------------//

function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		dsMAIN.ClearData();
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	txtCLSE_ACC_ID.value = "";
	txtACC_ID.value = "";
	dsMAIN.ClearData();
}
function txtCLSE_ACC_ID_onblur()
{
	if(!CheckCompCode()) return;
	if (C_isNull(txtCLSE_ACC_ID.value))
	{
		txtACC_ID.value = "";
		dsMAIN.ClearData();
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	lrArgs.set("CLSE_ACC_ID", txtCLSE_ACC_ID.value);
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_BUDG_YEAR", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");
	//G_Load(dsMASTER);
	
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
	txtCLSE_ACC_ID.value = "";
	txtACC_ID.value = "";
	txtMAKE_DEPT_CODE.value = "";
	txtMAKE_DEPT_NAME.value = "";
	dsMAIN.ClearData();
}
function btnACC_ID_onClick()
{
	if(!CheckCompCode()) return;
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("CLSE_ACC_ID", "");
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_LOV("T_BUDG_YEAR", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");
	//G_Load(dsMASTER);
	
}

function	CheckCompCode()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("먼저 사업장코드를 선택하세요.", "확인");
		return false;
	}
	return true;
}
function	btnAssignMonths_onClick()
{
	if(!checkConditions()) return;
	if(!D_checkIsLoadedInternal(dsSUB01)) return ;
	if(!D_checkMasterRowExistsInternal(dsSUB01,"일괄배정")) return ;
	for(var i = 1 ; i <= dsSUB01.CountRow ; ++i)
	{
		dsSUB01.NameString(i,"BUDG_MONTH_ASSIGN_AMT") = dsSUB01.NameString(i,"BUDG_MONTH_REQ_AMT");
	}
	//dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_ITEM_ASSIGN_AMT") = dsSUB01.NameSum("BUDG_MONTH_ASSIGN_AMT",0,0);
}
function	btnCopyPrev_onClick()
{
	if(!checkConditions()) return;
	if(!updateConfirm()) return;
	G_Load(dsCOPY);
	dsCOPY.NameString(dsCOPY.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	dsCOPY.NameString(dsCOPY.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
	//dsCOPY.NameString(dsCOPY.RowPosition,"DEPT_CODE") = txtDEPT_CODE.value;
	transCopy.Parameters = "ACT=COPY";
	if(!G_saveData(dsCOPY))return;
	C_msgOk("복사가 정상적으로 수행되었습니다.");
	G_Load(dsMASTER);
}
function	btnAssignAll_onClick()
{
	if(!checkConditions()) return;
	if(!updateConfirm()) return;
	G_Load(dsDVD_MONTHS);
	dsDVD_MONTHS.NameString(dsDVD_MONTHS.RowPosition,"COMP_CODE") = dsMASTER.NameString(dsMASTER.RowPosition,"COMP_CODE");
	dsDVD_MONTHS.NameString(dsDVD_MONTHS.RowPosition,"CLSE_ACC_ID") = dsMASTER.NameString(dsMASTER.RowPosition,"CLSE_ACC_ID");
	dsDVD_MONTHS.NameString(dsDVD_MONTHS.RowPosition,"DEPT_CODE") = dsMASTER.NameString(dsMASTER.RowPosition,"DEPT_CODE");
	dsDVD_MONTHS.NameString(dsDVD_MONTHS.RowPosition,"CHG_SEQ") = dsMASTER.NameString(dsMASTER.RowPosition,"CHG_SEQ");

	transDvd.Parameters = "ACT=DVD";

	if(!G_saveData(dsDVD_MONTHS))return;
	C_msgOk("배정이 정상적으로 수행되었습니다.");
	G_Load(dsMAIN);
}

function	btnDvdMonths_onClick()
{
	bNowCalc = true;
	try
	{
		dvdMonth();
	}
	catch(e)
	{
	}
	bNowCalc = false;
	
}
function	btnConfirmDept_onClick()
{
	if(!checkConditions()) return;
	if(!updateConfirm()) return;
	if(dsMASTER.NameString(dsMASTER.RowPosition,"CONFIRM_TAG") == "T")
	{
		C_msgOk("이미 확정되어 있습니다.");
		return;
	}
	confirmDept("T");
}

function	btnAddDeptAll_onClick()
{
	if(!checkConditions()) return;
	addDeptAll();
}
function btnAddBudgItemAll()
{
	if(!checkConditions()) return;
	addBudgItemAll();
}
function btnAddBudgItemAllForAllDept()
{
	if(!checkConditions()) return;
	addBudgItemAllForAllDept();
}
function	btnDvdAllMonth_onClick()
{
	if(!checkConditions()) return;
	if (dsMAIN.IsUpdated || G_isChanged(dsMAIN.id))
	{
		var ret = C_msgYesNo("이 작업을 위해서는 먼저 저장을 하셔야 합니다.<br>변경된 내용을 저장하시겠습니까?" , "저장");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMAIN)) return ;
		}
		else if(ret == "N")
		{
			return ;
		}
	}
	G_Load(dsDVD_MONTHS);
	dsDVD_MONTHS.NameString(dsDVD_MONTHS.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	dsDVD_MONTHS.NameString(dsDVD_MONTHS.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
	dsDVD_MONTHS.NameString(dsDVD_MONTHS.RowPosition,"DEPT_CODE") = dsMASTER.NameString(dsMASTER.RowPosition,"DEPT_CODE");
	dsDVD_MONTHS.NameString(dsDVD_MONTHS.RowPosition,"CHG_SEQ") = "0";

	transDvd.Parameters = "ACT=DVD";

	if(!G_saveData(dsDVD_MONTHS))return;
	C_msgOk("분할이 정상적으로 수행되었습니다.");
	G_Load(dsMAIN);
}
//단가적용
function btnGetFromItemCost()
{
	G_Load(dsITEM_COST);
	
	dsITEM_COST.NameString(dsITEM_COST.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	dsITEM_COST.NameString(dsITEM_COST.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
	dsITEM_COST.NameString(dsITEM_COST.RowPosition,"DEPT_CODE")   = dsMASTER.NameString(dsMASTER.RowPosition,"DEPT_CODE");
	dsITEM_COST.NameString(dsITEM_COST.RowPosition,"CHG_SEQ") = "0";

	transItemCost.Parameters = "ACT=ITEM_COST";

	if(!G_saveData(dsITEM_COST))return;
	C_msgOk("단가적용이  정상적으로 수행되었습니다.");
	G_Load(dsMASTER);
}
//단가적용취소
function btnGetFromItemCostCan_onClick()
{
	G_Load(dsITEM_COST);
	
	dsITEM_COST.NameString(dsITEM_COST.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	dsITEM_COST.NameString(dsITEM_COST.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
	dsITEM_COST.NameString(dsITEM_COST.RowPosition,"DEPT_CODE")   = dsMASTER.NameString(dsMASTER.RowPosition,"DEPT_CODE");
	dsITEM_COST.NameString(dsITEM_COST.RowPosition,"CHG_SEQ") = "0";

	transItemCost.Parameters = "ACT=ITEM_COST_CAN";

	if(!G_saveData(dsITEM_COST))return;
	C_msgOk("단가적용 취소가  정상적으로 수행되었습니다.");
	G_Load(dsMASTER);
}
//모든부서 단가적용
function btnGetFromItemCostAll_onClick()
{
	G_Load(dsITEM_COST);
	
	dsITEM_COST.NameString(dsITEM_COST.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	dsITEM_COST.NameString(dsITEM_COST.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
	dsITEM_COST.NameString(dsITEM_COST.RowPosition,"CHG_SEQ") = "0";

	transItemCost.Parameters = "ACT=ITEM_COST_ALL";

	if(!G_saveData(dsITEM_COST))return;
	
	C_msgOk("전부서 단가적용이  정상적으로 수행되었습니다.");
	G_Load(dsMASTER);
}
//모든부서 단가적용 취소
function btnGetFromItemCostAllCan_onClick()
{
	G_Load(dsITEM_COST);
	
	dsITEM_COST.NameString(dsITEM_COST.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	dsITEM_COST.NameString(dsITEM_COST.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
	dsITEM_COST.NameString(dsITEM_COST.RowPosition,"CHG_SEQ") = "0";

	transItemCost.Parameters = "ACT=ITEM_COST_ALL_CAN";


	if(!G_saveData(dsITEM_COST))return;
	
	C_msgOk("전부서 단가적용 취소가 정상적으로 수행되었습니다.");
	G_Load(dsMASTER);
}
//모든 신청부서 삭제
function btnDelDeptAll_onClick()
{
	if( C_msgOkCancel("신청부서를 삭제하면 예산신청내역도 삭제됩니다. <br> 정말로 삭제하시겠습니까?","주의")=='C')
	{
		return;	
	}
	G_Load(dsDEPT_ALL);
	dsDEPT_ALL.NameString(dsDEPT_ALL.RowPosition,"COMP_CODE")      =  txtCOMP_CODE.value;
	dsDEPT_ALL.NameString(dsDEPT_ALL.RowPosition,"CLSE_ACC_ID")    =  txtCLSE_ACC_ID.value;
	dsDEPT_ALL.NameString(dsDEPT_ALL.RowPosition,"CHG_SEQ") 	  = "0";
	
	transDeptAll.Parameters = "ACT=DEPT_ALL_DEL";
	if(!G_saveData(dsDEPT_ALL))return;
	C_msgOk("모든 예산신청부서가 삭제 되었습니다.");
	G_Load(dsMASTER);
}

//발령정보 설정
function btnDeptCopy_onClick()
{
	G_Load(dsDEPT_COPY);
	
	dsDEPT_COPY.NameString(dsDEPT_COPY.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;

	transDeptCopy.Parameters = "ACT=DEPT_COPY";

	if(!G_saveData(dsDEPT_COPY))return;
	C_msgOk("발령정보 설정이  정상적으로 수행되었습니다.");
}
