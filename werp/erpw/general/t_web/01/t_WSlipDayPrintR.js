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
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;

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
}

function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//시스템명 가져오기
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("DT_F",txtDT_F.value)
											+ D_P2("DT_T",txtDT_T.value)
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("MAKE_SLIPCLS",cboMAKE_SLIPCLS.value)
											+ D_P2("MAKE_DEPT_CODE",txtMAKE_DEPT_CODE.value);
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
//검색조건체크
function print_condition_check()
{
	var vCompCode = txtCOMP_CODE.value;
   	var vDT_F   = txtDT_F.value;
   	var vDT_T   = txtDT_T.value;

   	if ( C_isNull(vCompCode))
   	{
   		C_msgOk("사업장을 선택하세요");
   		return false;
   	}
   	
   	if ( C_isNull(vDT_F))
   	{
   		C_msgOk("작업일을 입력하세요");
   		return false;
   	}
   	
   	if ( C_isNull(vDT_T))
   	{
   		C_msgOk("작업일을 입력하세요");
   		return false;
   	}

	return true;
}

// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
//인쇄
function btnquery_prt_onclick()
{
	// 프로그래머 유효성검사 추가
				
	// 공통 Check
	//if (!checkCommon()) return;
	if(!print_condition_check()) return;
	
	var vCompCode  = txtCOMP_CODE.value;
	var vCompName  = txtCOMPANY_NAME.value;
	var vDeptCode  = (txtMAKE_DEPT_CODE.value=="")?"%":txtMAKE_DEPT_CODE.value;
	var vDeptName  = (txtMAKE_DEPT_NAME.value=="")?"전체":txtMAKE_DEPT_NAME.value;
	var	vMakeCls = cboMAKE_SLIPCLS.value;
	var	vMakeClsName = cboMAKE_SLIPCLS.options[cboMAKE_SLIPCLS.selectedIndex].text;

   	var vDT_F   = txtDT_F.value;
   	var vDT_T   = txtDT_T.value;
   
	// 보고서 디렉토리
   	var reportFile = sReportName;
   	
	frmList.EXPORT_TAG.value = "P";
	frmList.RUN_TAG.value = "";
	frmList.REQUEST_NAME.value = "";
	frmList.REPORT_NO.value = '--';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	var strTemp = "";
	// 프로그래머 파라메터 추가
	// 파라메터1__값1&&파라메터2__값2&&....
	// 예제
	//strTemp += "ProjCode__" + strProjCode + "&&";
	//strTemp += "ConsultSeq__" + strConsultSeq;

	strTemp += "pCOMP_CODE__" + vCompCode;
	strTemp += "&&pCOMP_NAME__" + vCompName;
	strTemp += "&&pDEPT_CODE__" + vDeptCode;
	strTemp += "&&pDEPT_NAME__" + vDeptName;
	strTemp += "&&pMAKE_SLIPCLS__" + vMakeCls;
	strTemp += "&&pMAKE_SLIPCLS_NAME__" + vMakeClsName;
	strTemp  += "&&pDT_T__" + vDT_T;
	strTemp += "&&pDT_F__" + vDT_F;

	
	//alert(frmList.REPORT_FILE_NAME.value);
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}
// 조회
function btnquery_onclick()
{
	if(!CheckCompCode()) return;
	D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
	//D_defaultAdd();
	//dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
	//dsMAIN.NameString(dsMAIN.RowPosition,"COMP_NAME") = txtCOMPANY_NAME.value;

}

// 삽입
function btninsert_onclick()
{
	//D_defaultInsert();
}

// 삭제
function btndelete_onclick()
{
	//D_defaultDelete();
}

// 저장
function btnsave_onclick()
{
	//D_defaultSave(dsMAIN);
}

// 취소
function btncancel_onclick()
{
	//if (G_FocusObject != null) G_FocusObject.focus();
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "DT_F")
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
	if(dataset == dsMAIN)
	{
	}
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

function	OnColumnChanged(dataset, row, colid)
{
	if(dataset == dsMAIN)
	{
		if(colid == "CHK_CLS")
		{
		}
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
	if(dataset == dsMAIN)
	{
		if(colid == "INPUT_DT_F" || colid == "INPUT_DT_T")
		{
		}
		else if(colid == "TAX_COMP_CODE" || colid == "TAX_COMP_NAME")
		{
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsMAIN)
	{
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
		if(dataset.NameString(row,"MAKE_COMP_CODE") == "")
		{
			C_msgOk("전체집계항목은 전표조회를 할 수 없습니다.", "확인");
			return;
		}
		var pSLIP_ID        = dataset.NameString(row,"SLIP_ID");
		var pSLIP_IDSEQ     = dataset.NameString(row,"SLIP_IDSEQ");
		var pMAKE_COMP_CODE = dataset.NameString(row,"MAKE_COMP_CODE");
		var pMAKE_DT 	     = dataset.NameString(row,"MAKE_DT");
		var pMAKE_SEQ     	 = dataset.NameString(row,"MAKE_SEQ");
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

function btnKEEP_DT_onClick()
{
	C_Calendar("KEEP_DT", "D", txtKEEP_DT.value);
	S_nextFocus(btnKEEP_DT);
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
	lrArgs.set("SEARCH_CONDITION", txtMAKE_DEPT_NAME.value);

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
	lrArgs.set("SEARCH_CONDITION", txtMAKE_DEPT_NAME.value);

	lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"T");

	if (lrRet == null) return;

	txtMAKE_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtMAKE_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
	txtMAKE_PERS.value = "";
	txtMAKE_PERS_NAME.value = "";
	//G_Load(dsCLASS_CODE, null);
}
