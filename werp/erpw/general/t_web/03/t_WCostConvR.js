/**************************************************************************/
/* 1. 프 로 그 램 id : t_WEmpPaySalR.jsp(사원별급여지급내역현황)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 사원별지급내역현황조회
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-03)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var			sEMPNO;
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "사원지급내역작업목록");
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "사원별지급내역");
	G_addDataSet(dsSUM, transSUM, null, sSelectPageName+D_P1("ACT","MAIN"), "급여집계");
	
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	G_addDataSet(dsWORK_SEQ, null, null, null, "작업순번");
	G_addDataSet(dsSEQ, null, null, null, "사원지급목록순번");
	G_addDataSet(dsACCINFO, null, null, null, "사원계좌정보");
	G_addDataSet(dsBANK_MAIN, null, null, null, "은행본점코드");
	G_addDataSet(dsPAYGBN, null, null, null, "급여구분");
	
	G_addDataSet(dsREMOVE, transREMOVE, null, sSelectPageName+D_P1("ACT","MAIN"), "전표삭제");
	
	
	
	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"COMP_CODE","COMP_CODE");
	G_addRelCol(dsSUB01,"WORK_SEQ","WORK_SEQ");
	

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	
	txtDATE_FROM.value = sDTF;
	txtDATE_TO.value = sDTT;

	G_setLovCol(gridSUB01,"NAME");
	G_setLovCol(gridSUB01,"EMP_NO");
	G_setLovCol(gridSUB01,"DEPT_CODE");
	G_setLovCol(gridSUB01,"DEPT_NAME");
	G_setLovCol(gridSUB01,"HNAME");

	G_setReadOnlyCol(gridMAIN,"MAKE_SLIPNO");

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	gridMAIN.TabToss = false;

	gridSUB01.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	gridSUB01.TabToss = false;
	
	G_Load(dsBANK_MAIN);
	G_Load(dsPAYGBN);

	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										 + D_P2("COMP_CODE",txtCOMP_CODE.value)
										 + D_P2("WORK_DT_F",txtDATE_FROM.value)
										 + D_P2("WORK_DT_T",txtDATE_TO.value);
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
										 + D_P2("COMP_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE"))
										 + D_P2("WORK_SEQ",dsMAIN.NameString(dsMAIN.RowPosition,"WORK_SEQ"));
	}
	else if(dataset == dsWORK_SEQ)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","WORK_SEQ");
	}
	else if(dataset == dsSEQ)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SEQ");
	}
	else if(dataset == dsBANK_MAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","BANK_MAIN");
	}
	else if(dataset == dsPAYGBN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","PAYGBN");
	}
	else if(dataset == dsSUM)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUM");
	}
	else if(dataset == dsACCINFO)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","ACCINFO")
										 + D_P2("EMPNO",sEMPNO);
	}
	else if(dataset == dsREMOVE)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","REMOVE");
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
function	setEmpsAccInfo(row,empno)
{
	sEMPNO = empno;
	G_Load(dsACCINFO);
	if(dsACCINFO.CountRow > 0 )
	{
		dsSUB01.NameString(row,"DEPT_CODE") = dsACCINFO.NameString(dsACCINFO.RowPosition,"DEPT_CODE");
		dsSUB01.NameString(row,"DEPT_NAME") = dsACCINFO.NameString(dsACCINFO.RowPosition,"DEPT_NAME");
		dsSUB01.NameString(row,"SAFE_MNG_TAG") = dsACCINFO.NameString(dsACCINFO.RowPosition,"SAFE_MNG_TAG");
	}
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
	if(dsSUB01.CountRow < 1)
	{
		C_msgOk("전표를 발행할 자료가 없습니다.");
		return;
	}
	var			lrObject = new Object();
	lrObject.dept_code = sDeptCode;
	lrObject.comp_code = sCompCode;
	lrObject.emp_no = sEmpNo;
	lrObject.work_dt = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_DT");
	lrObject.work_seq = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_SEQ");

	var		arrRtn2 = window.showModalDialog("./t_PMakeEmpPaySalSlipR.jsp", lrObject, "center:yes; dialogWidth:410px; dialogHeight:600px; status:no; help:no; scroll:no");
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
		C_msgOk("먼저 상단의 작업 목록을 선택 하십시오.");
		return;
	}
	G_Load(dsREMOVE);
	dsREMOVE.NameString(dsREMOVE.RowPosition,"COMP_CODE") = dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE");
	dsREMOVE.NameString(dsREMOVE.RowPosition,"WORK_DT") = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_DT");
	dsREMOVE.NameString(dsREMOVE.RowPosition,"WORK_SEQ") = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_SEQ");
	transREMOVE.Parameters = "ACT=REMOVE";
	if(!G_saveData(dsREMOVE))return;
	C_msgOk("지급전표가 정상적으로 삭제되었습니다.");
	var			liRow = dsMAIN.RowPosition;
	G_Load(dsMAIN);
	dsMAIN.RowPosition = liRow;
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
	else if (asCalendarID == dsMAIN.id+"."+"WORK_DT")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"WORK_DT") = asDate;
	}
	else if (asCalendarID == dsMAIN.id+"."+"WORK_YM")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"WORK_YM") = asDate;
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
		G_Load(dsWORK_SEQ);
		dataset.NameString(row,"WORK_SEQ") = dsWORK_SEQ.NameString(dsWORK_SEQ.RowPosition,"WORK_SEQ");
		dataset.NameString(row,"WORK_DT") = sDTT;
		dataset.NameString(row,"IGNORE_COMP_TAG") = "T";
		dataset.NameString(row,"COMP_CODE") =   txtCOMP_CODE.value;
	}
	else if(dataset == dsSUB01)
	{
		G_Load(dsSEQ);
		dataset.NameString(row,"SEQ") = dsSEQ.NameString(dsSEQ.RowPosition,"SEQ");
	}
}
function OnExit(dataset, grid, row, colid, olddata)
{
	if (dataset == dsMAIN)
	{
		var		COL_DATA;
		var		liDataRow = row;
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "WORK_DT")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
		else if(colid == "WORK_YM")
		{
			D_defaultYmProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
	else if(dataset == dsSUB01)
	{
		var		COL_DATA;
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "EMP_NO" || colid == "NAME")
		{
			var			lsTargetCode = "EMP_NO";
			var			lsTargetName = "NAME";
			if(COL_DATA == olddata) return;
			if(C_isNull(COL_DATA))
			{
				dataset.NameString(row,lsTargetCode) = "";
				dataset.NameString(row,lsTargetName) = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", COL_DATA);
		
			lrRet = C_AutoLov(dsLOV,"T_EMP_NO1", lrArgs,"T");
			if (lrRet != null)
			{
				dataset.NameString(row,lsTargetCode) = lrRet.get("EMPNO");
				dataset.NameString(row,lsTargetName) = lrRet.get("NAME");
				setEmpsAccInfo(row,dataset.NameString(row,lsTargetCode));
			}
			else
			{
				dataset.NameString(row,colid) = olddata;
			}
		}
		else if(colid == "DEPT_CODE" || colid == "DEPT_NAME" )
		{
			var		liDataRow = row;
			var			lsNewData = dataset.NameString(row,colid);
			var			lsTargetCode = "DEPT_CODE";
			var			lsTargetName = "DEPT_NAME";
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dataset.NameString(liDataRow,lsTargetCode) = "";
				dataset.NameString(liDataRow,lsTargetName) = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE1", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,lsTargetCode) = lrRet.get("DEPT_CODE");
					dataset.NameString(liDataRow,lsTargetName) = lrRet.get("DEPT_NAME");
				}
			}
			else
			{
				dataset.NameString(liDataRow,colid) = olddata;
			}
		}
		else if(colid == "HNAME")
		{
			var		liDataRow = row;
			var			lsNewData = dataset.NameString(row,colid);
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dataset.NameString(row,'HNAME') = "";
				dataset.NameString(row,'IN_OUT_TAG') = "";
				dataset.NameString(row,'SUDANGCD') = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_SUDANG", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(row,'HNAME') = lrRet.get("HNAME");
					dataset.NameString(row,'IN_OUT_TAG') = lrRet.get("IN_OUT_TAG");
					dataset.NameString(row,'SUDANGCD') = lrRet.get("SUDANGCD");
				}
			}
			else
			{
				dataset.NameString(liDataRow,colid) = olddata;
			}
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	var		liDataRow = row;
	if (dataset == dsMAIN)
	{
		if(colid == "WORK_DT")
		{
			C_Calendar(dataset.id+"."+colid, "D", dataset.NameString(dataset.RowPosition,colid));
		}
		else if(colid == "WORK_YM")
		{
			C_Calendar(dataset.id+"."+colid, "M", dataset.NameString(dataset.RowPosition,colid));
		}
	}
	else if(dataset == dsSUB01)
	{
		var		COL_DATA;
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "EMP_NO" || colid == "NAME")
		{
			var			lsTargetCode = "EMP_NO";
			var			lsTargetName = "NAME";

			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_EMP_NO1", lrArgs,"F");
			if (lrRet != null)
			{
				dataset.NameString(row,lsTargetCode) = lrRet.get("EMPNO");
				dataset.NameString(row,lsTargetName) = lrRet.get("NAME");
				setEmpsAccInfo(row,dataset.NameString(row,lsTargetCode));
			}
		}
		else if(colid == "DEPT_CODE" || colid == "DEPT_NAME" )
		{
			var		liDataRow = row;
			var			lsTargetCode = "DEPT_CODE";
			var			lsTargetName = "DEPT_NAME";
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_DEPT_CODE1", lrArgs,"F");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,lsTargetCode) = lrRet.get("DEPT_CODE");
					dataset.NameString(liDataRow,lsTargetName) = lrRet.get("DEPT_NAME");
				}
			}
		}
		else if(colid == "HNAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_SUDANG", lrArgs,"F");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(row,'HNAME') = lrRet.get("HNAME");
					dataset.NameString(row,'IN_OUT_TAG') = lrRet.get("IN_OUT_TAG");
					dataset.NameString(row,'SUDANGCD') = lrRet.get("SUDANGCD");
				}
			}
		}
	}

}
function	OnDuplicateColumn(dataset,grid,row,colid)
{
	if(row < 2) return;
	if(dataset == dsSUB01)
	{
		if(colid == "EMP_NO")
		{
			dataset.NameString(row,"NAME") = dataset.NameString(row-1,"NAME")
		}
		else if(colid == "NAME")
		{
			dataset.NameString(row,"EMP_NO") = dataset.NameString(row-1,"EMP_NO")
		}
		else if(colid == "DEPT_CODE")
		{
			dataset.NameString(row,"DEPT_NAME") = dataset.NameString(row-1,"DEPT_NAME")
		}
		else if(colid == "DEPT_NAME")
		{
			dataset.NameString(row,"DEPT_CODE") = dataset.NameString(row-1,"DEPT_CODE")
		}
		else if(colid == "HNAME")
		{
			dataset.NameString(row,"IN_OUT_TAG") = dataset.NameString(row-1,"IN_OUT_TAG")
			dataset.NameString(row,"SUDANGCD") = dataset.NameString(row-1,"SUDANGCD")
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

function	btnRemoveAll_onClick()
{
	G_deleteAllRow(dsSUB01);
}
function	btnMakeInSlip_onClick()	//
{
	makeInSlip();
}
function	btnRemoveSlip_onClick()	//
{
	removeSlip();
}

function btnFileLoad_onClick()
{
	if(dsMAIN.NameString(dsMAIN.RowPosition,"WORK_SEQ") == '')
	{
		C_msgOk("지급작업 목록을 먼저 등록하십시오.","확인");
		return;
	}
	if(!chkSave()) return;
	G_Load(dsSUM);
	dsSUM.NameString(dsSUM.RowPosition,"COMP_CODE") = dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE");
	dsSUM.NameString(dsSUM.RowPosition,"WORK_SEQ") = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_SEQ");
	transSUM.Parameters = "ACT=SUM";
	if(!G_saveData(dsSUM))return;
	C_msgOk("집계작업이 정상적으로 수행되었습니다.");
	G_Load(dsSUB01);
}
function	btnShowSlip_onClick()
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
