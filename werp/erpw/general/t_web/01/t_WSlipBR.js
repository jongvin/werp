/**************************************************************************/
/* 1. 프 로 그 램 id : t_WBudgDeptMapR(예산신청)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-30)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "부서목록");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	
	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	
	//G_setReadOnlyCol(gridMAIN,"DEPT_CODE");
	//G_setReadOnlyCol(gridMAIN,"DEPT_NAME");
	
	G_setLovCol(gridMAIN,"TAX_COMP_CODE");
	G_setLovCol(gridMAIN,"TAX_COMP_NAME");
	
	//G_setReadOnlyCol(gridMAIN,"CLSE_ACC_ID");
	//G_setReadOnlyCol(gridMAIN,"ACC_ID");
	
	G_setLovCol(gridMAIN,"INPUT_DT_F");
	G_setLovCol(gridMAIN,"INPUT_DT_T");

	gridMAIN.focus();

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;

	txtMAKE_DEPT_CODE.value = sDeptCode;
	txtMAKE_DEPT_NAME.value = sDeptName;

	txtMAKE_PERS.value = sEmpno;
	txtMAKE_PERS_NAME.value = sName;

	//sDept_Chg_Cls = "F"

	if (sDept_Chg_Cls == "T")
	{
		document.all.txtCOMP_CODE.style.background		= "white";
		document.all.txtCOMP_CODE.value.readOnly		= false;
		document.all.btnCOMP_CODE.style.display			= "";

		document.all.txtMAKE_DEPT_CODE.style.background	= "white";
		document.all.txtMAKE_DEPT_CODE.readOnly			= false;
		document.all.btnMAKE_DEPT.style.display			= "";
	}
	else
	{
		document.all.txtCOMP_CODE.style.background		= "#EFEFEF";
		document.all.txtCOMP_CODE.readOnly				= true;
		document.all.btnCOMP_CODE.style.display			= "none";
		
		document.all.txtMAKE_DEPT_CODE.style.background	= "#EFEFEF";
		document.all.txtMAKE_DEPT_CODE.readOnly			= true;
		document.all.btnMAKE_DEPT.style.display			= "none";
	}
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//시스템명 가져오기
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("DATE_CLS",cboDATE_CLS.value)
											+ D_P2("DT_F",txtDT_F.value)
											+ D_P2("DT_T",txtDT_T.value)
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("CUST_CODE",txtCUST_CODE.value)
											+ D_P2("AMT_CLS",cboAMT_CLS.value)
											+ D_P2("DBCR_FAMT",txtDBCR_FAMT.value.replace(/,/gi,""))
											+ D_P2("DBCR_EAMT",txtDBCR_EAMT.value.replace(/,/gi,""))
											+ D_P2("ACC_CODE",txtACC_CODE.value)
											+ D_P2("KEEP_CLS",cboKEEP_CLS.value)
											+ D_P2("MAKE_DEPT_CODE",txtMAKE_DEPT_CODE.value)
											+ D_P2("VAT_CODE",txtVAT_CODE.value)
											+ D_P2("DEPT_CODE",txtDEPT_CODE.value)
											+ D_P2("SUMMARY1",txtSUMMARY1.value)
											+ D_P2("TAX_COMP_CODE",txtTAX_COMP_CODE.value)
											+ D_P2("CHARGE_PERS",txtCHARGE_PERS.value)
											+ D_P2("MAKE_PERS",txtMAKE_PERS.value)
											+ D_P2("MAKE_SLIPNO",txtMAKE_SLIPNO.value)
											+ D_P2("SLIP_KIND_TAG",cboSLIP_KIND_TAG.value);
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
	if(!CheckCompCode()) return;
	D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
	D_defaultAdd();
	dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	dsMAIN.NameString(dsMAIN.RowPosition,"COMP_NAME") = txtCOMPANY_NAME.value;

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
	if (asCalendarID == "INPUT_DT_F")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"INPUT_DT_F") = asDate;
	}
	else if (asCalendarID == "INPUT_DT_T")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"INPUT_DT_T") = asDate;
	}
	else if (asCalendarID == "DT_F")
	{
		txtDT_F.value = asDate;
	}
	else if (asCalendarID == "DT_T")
	{
		txtDT_T.value = asDate;
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
	if(dataset == dsMAIN)
	{
		if(colid == "INPUT_DT_F" || colid == "INPUT_DT_T")
		{
			var		COL_DATA;
			COL_DATA = dataset.NameString(row,colid);
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
		else if(colid == "TAX_COMP_CODE" || colid == "TAX_COMP_NAME")
		{
			var		liDataRow = row;
			var			lsNewData = dataset.NameString(row,colid);
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dsMAIN.NameString(liDataRow,"TAX_COMP_CODE") = "";
				dsMAIN.NameString(liDataRow,"TAX_COMP_NAME") = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("COMP_CODE", dsMAIN.NameString(liDataRow,"COMP_CODE"));
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_COMP_CODE", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsMAIN.NameString(liDataRow,"TAX_COMP_CODE") = lrRet.get("COMP_CODE");
					dsMAIN.NameString(liDataRow,"TAX_COMP_NAME") = lrRet.get("COMPANY_NAME");
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
	if(dataset == dsMAIN)
	{
		var		liDataRow = row;
		if(colid == "INPUT_DT_F")
		{
			C_Calendar("INPUT_DT_F", "D", dsMAIN.NameString(dsMAIN.RowPosition,"INPUT_DT_F"));
		}
		else if(colid == "INPUT_DT_T")
		{
			C_Calendar("INPUT_DT_T", "D", dsMAIN.NameString(dsMAIN.RowPosition,"INPUT_DT_T"));
		}
		else if(colid == "TAX_COMP_CODE" || colid == "TAX_COMP_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_COMP_CODE", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsMAIN.NameString(liDataRow,"TAX_COMP_CODE") = lrRet.get("COMP_CODE");
					dsMAIN.NameString(liDataRow,"TAX_COMP_NAME") = lrRet.get("COMPANY_NAME");
				}
			}
		}
	}
}

function OnDuplicateColumn(dataset,grid,row,colid) {
	if(dataset == dsMAIN)
	{
		if(colid == "TAX_COMP_CODE" || colid == "TAX_COMP_NAME")
		{
			if(row>=2) {
				dsMAIN.NameString(row,"TAX_COMP_CODE") = dsMAIN.NameString(row-1,"TAX_COMP_CODE");
				dsMAIN.NameString(row,"TAX_COMP_NAME") = dsMAIN.NameString(row-1,"TAX_COMP_NAME");
			}
		}
	}
}

function OnDblClick(dataset, grid, row, colid) {
	if(dataset == dsMAIN)
	{
		var pSLIP_ID        = dataset.NameString(row,"SLIP_ID");
		var pSLIP_IDSEQ     = dataset.NameString(row,"SLIP_IDSEQ");
		var pMAKE_COMP_CODE = dataset.NameString(row,"MAKE_COMP_CODE");
		var pMAKE_DT 	      = dataset.NameString(row,"MAKE_DT");
		var pMAKE_SEQ     	= dataset.NameString(row,"MAKE_SEQ");
		var pSLIP_KIND_TAG  = dataset.NameString(row,"SLIP_KIND_TAG");
		var pREADONLY_TF    = "F";
		
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
}

// 이벤트관련-------------------------------------------------------------------//
function	document_onKeyDown()
{
	if(event.altLeft && event.keyCode == 112)
	{
		//SetDefaultCheckDept();
	}
}
function	txtCOMP_CODE_onChange()
{
	gridMAIN.focus();
	btnquery_onclick();
}

function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		return;
	}
	
	if (txtCOMP_CODE.value == '%')
	{
		txtCOMPANY_NAME.value = "전체";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
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

function btnDT_F_onClick()
{
	C_Calendar("DT_F", "D", txtDT_F.value);
	S_nextFocus(btnDT_F);
}

function btnDT_T_onClick()
{
	C_Calendar("DT_T", "D", txtDT_T.value);
	S_nextFocus(btnDT_T);
}

//거래처코드
function txtCUST_CODE_onblur()
{
	if (C_isNull(txtCUST_CODE.value))
	{
		txtCUST_CODE.value = '';
		txtCUST_NAME.value = '';
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCUST_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_CUST_CODE1", lrArgs,"T");

	if (lrRet == null) return;
	
	txtCUST_CODE.value = lrRet.get("CUST_CODE");
	txtCUST_NAME.value = lrRet.get("CUST_NAME");
}

function btnCUST_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCUST_CODE.value);

	if (C_isNull(txtCUST_CODE.value))
	{
		lrRet = C_LOV("T_CUST_CODE1", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_CUST_CODE1", lrArgs,"T");
	}

	if (lrRet == null) return;

	txtCUST_CODE.value = lrRet.get("CUST_CODE");
	txtCUST_NAME.value = lrRet.get("CUST_NAME");
}

//계정과목
function txtACC_CODE_onblur()
{
	if (C_isNull(txtACC_CODE.value))
	{
		txtACC_CODE.value = '';
		txtACC_NAME.value = '';
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtACC_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_ACC_CODE1", lrArgs,"T");

	if (lrRet == null) return;

	txtACC_CODE.value = lrRet.get("ACC_CODE");
	txtACC_NAME.value = lrRet.get("ACC_NAME");
}

function btnACC_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", txtACC_CODE.value);

	if (C_isNull(txtACC_CODE.value))
	{
		lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_ACC_CODE1", lrArgs,"T");
	}
	
	if (lrRet == null) return;

	txtACC_CODE.value = lrRet.get("ACC_CODE");
	txtACC_NAME.value = lrRet.get("ACC_NAME");
}

//발의부서
function txtMAKE_DEPT_CODE_onblur()
{
	if (C_isNull(txtMAKE_DEPT_CODE.value))
	{
		txtMAKE_DEPT_CODE.value = '';
		txtMAKE_DEPT_NAME.value = '';
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtMAKE_DEPT_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE3", lrArgs,"T");

	if (lrRet == null) return;

	txtMAKE_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtMAKE_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
	txtMAKE_PERS.value = "";
	txtMAKE_PERS_NAME.value = "";
	//G_Load(dsCLASS_CODE, null);
}

function btnMAKE_DEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtMAKE_DEPT_CODE.value);

	lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"T");

	if (lrRet == null) return;

	txtMAKE_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtMAKE_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
	txtMAKE_PERS.value = "";
	txtMAKE_PERS_NAME.value = "";
	//G_Load(dsCLASS_CODE, null);
}

//증빙코드
function txtVAT_CODE_onblur()
{
	if (C_isNull(txtVAT_CODE.value))
	{
		txtVAT_CODE.value = '';
		txtVAT_NAME.value = '';
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtVAT_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_VAT_CODE1", lrArgs,"T");

	if (lrRet == null) return;
	
	txtVAT_CODE.value = lrRet.get("VAT_CODE");
	txtVAT_NAME.value = lrRet.get("VAT_NAME");


}

function btnVAT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtVAT_CODE.value);

	if (C_isNull(txtVAT_CODE.value))
	{
		lrRet = C_LOV("T_VAT_CODE1", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_VAT_CODE1", lrArgs,"T");
	}

	if (lrRet == null) return;

	txtVAT_CODE.value = lrRet.get("VAT_CODE");
	txtVAT_NAME.value = lrRet.get("VAT_NAME");
}

//귀속부서
function txtDEPT_CODE_onblur()
{
	if (C_isNull(txtDEPT_CODE.value))
	{
		txtDEPT_CODE.value = '';
		txtDEPT_NAME.value = '';
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE3", lrArgs,"T");

	if (lrRet == null) {
		txtDEPT_CODE.value = txtDEPT_CODE_F.value;
		return;
	}
	
	if (txtDEPT_CODE.value == lrRet.get("DEPT_CODE")) return;
	
	txtDEPT_CODE.value = lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value = lrRet.get("DEPT_NAME");
	//dsSLIP_D.NameValue(dsSLIP_D.RowPosition, "TAX_COMP_CODE")	= lrRet.get("TAX_COMP_CODE");
	//dsSLIP_D.NameValue(dsSLIP_D.RowPosition, "TAX_COMP_NAME")	= lrRet.get("TAX_COMP_NAME");
}

function btnDEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);

	if (C_isNull(txtDEPT_CODE.value))
	{
		lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"T");
	}

	if (lrRet == null) return;
	if (txtDEPT_CODE.value == lrRet.get("DEPT_CODE")) return;
	
	txtDEPT_CODE.value = lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value = lrRet.get("DEPT_NAME");
}

//세무사업장
function txtTAX_COMP_CODE_onblur() 
{
	
	if (C_isNull(txtTAX_COMP_CODE.value))
	{
		txtTAX_COMP_CODE.value = '';
		txtTAX_COMP_NAME.value = '';
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtTAX_COMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE", lrArgs,"T");

	if (lrRet == null) return;
	
	txtTAX_COMP_CODE.value	= lrRet.get("COMP_CODE");
	txtTAX_COMP_NAME.value	= lrRet.get("COMPANY_NAME");
}

function btnTAX_COMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtTAX_COMP_CODE.value);

	if (C_isNull(txtTAX_COMP_CODE.value))
	{
		lrRet = C_LOV("T_COMP_CODE", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_COMP_CODE", lrArgs,"T");
	}

	if (lrRet == null) return;

	txtTAX_COMP_CODE.value	= lrRet.get("COMP_CODE");
	txtTAX_COMP_NAME.value	= lrRet.get("COMPANY_NAME");
}

//관리담당
function txtCHARGE_PERS_onblur()
{
	if (C_isNull(txtCHARGE_PERS.value))
	{
		txtCHARGE_PERS.value = '';
		txtCHARGE_PERS_NAME.value = '';
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtCHARGE_PERS.value);

	lrRet = C_AutoLov(dsLOV,"Z_AUTHORITY_USER02", lrArgs,"T");

	if (lrRet == null) return;

	txtCHARGE_PERS.value	= lrRet.get("EMPNO");
	txtCHARGE_PERS_NAME.value	= lrRet.get("NAME");
}

function btnCHARGE_PERS_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtCHARGE_PERS.value);

	lrRet = C_LOV("Z_AUTHORITY_USER02", lrArgs,"T");

	if (lrRet == null) return;

	txtCHARGE_PERS.value	= lrRet.get("EMPNO");
	txtCHARGE_PERS_NAME.value	= lrRet.get("NAME");
}

//발의자
function txtMAKE_PERS_onblur()
{
	if (C_isNull(txtMAKE_PERS.value))
	{
		txtMAKE_PERS.value = '';
		txtMAKE_PERS_NAME.value = '';
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("DEPT_CODE", txtMAKE_DEPT_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtMAKE_PERS.value);

	lrRet = C_AutoLov(dsLOV,"Z_AUTHORITY_USER03", lrArgs,"T");

	if (lrRet == null) return;

	txtMAKE_PERS.value	= lrRet.get("EMPNO");
	txtMAKE_PERS_NAME.value	= lrRet.get("NAME");
}

function btnMAKE_PERS_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("DEPT_CODE", txtMAKE_DEPT_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtMAKE_PERS.value);

	lrRet = C_LOV("Z_AUTHORITY_USER03", lrArgs,"T");

	if (lrRet == null) return;

	txtMAKE_PERS.value	= lrRet.get("EMPNO");
	txtMAKE_PERS_NAME.value	= lrRet.get("NAME");
}