/**************************************************************************/
/* 1. 프 로 그 램 id : t_WBudgDeptMapR(예산신청)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-30)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var vAccClse = false;
var vMonClse = false;
var vDayClse = false;
var vDeptClse = false;

var vMAKE_COMP_CODE = "";
var vMAKE_DEPT_CODE = "";
var vMAKE_DT_TRANS  = "";

function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "부서목록");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	G_addDataSet(dsDAY_CLOSE, null, null, null, "마감정보");
	
	/*
	if(sSlip_Trans_Cls == 'T'){
		txtCHARGE_PERS.value = sEmpno;
		txtCHARGE_PERS_NAME.value = sName;
	}
	*/

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
											+ D_P2("DT_F",txtDT_F.value)
											+ D_P2("DT_T",txtDT_T.value)
											+ D_P2("MAKE_COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("KEEP_CLS",cboKEEP_CLS.value)
											+ D_P2("MAKE_DEPT_CODE",txtMAKE_DEPT_CODE.value)
											+ D_P2("CHARGE_PERS",txtCHARGE_PERS.value)
											+ D_P2("MAKE_PERS",txtMAKE_PERS.value);
	}
	else if(dataset == dsDAY_CLOSE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","DAY_CLOSE")
											+ D_P2("COMP_CODE",vMAKE_COMP_CODE)
											+ D_P2("DEPT_CODE",vMAKE_DEPT_CODE)
											+ D_P2("CLSE_DAY",vMAKE_DT_TRANS);
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
	if(dsMAIN.CountRow == 0)
	{
   		C_msgOk("출력할 대상이 없습니다.");
   		return false;
   	}
	if (dsMAIN.IsUpdated || G_isChanged(dsMAIN.id))
	{
		// 선택된 항목이 있으면
	} else {
		C_msgOk("선택된 항목이 없습니다.");
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

	G_saveData(dsMAIN);

	btnquery_onclick();

	/*
	var vCompCode  = txtCOMP_CODE.value;
	var vCompName  = txtCOMPANY_NAME.value;
	var vDeptCode  = (txtDEPT_CODE.value=="")?"%":txtDEPT_CODE.value;
	var vDeptName  = (txtDEPT_NAME.value=="")?"전체":txtDEPT_NAME.value;
	var vCustCode  = (txtCUST_CODE.value=="")?"%":txtCUST_CODE.value;
	var vCustName  = (txtCUST_NAME.value=="")?"전체":txtCUST_NAME.value;
   	var vDT_F   = txtDT_F.value;
   	var vDT_T   = txtDT_T.value;
	*/
   
	// 보고서 디렉토리
   	var reportFile = sReportName;
   	
	frmList.EXPORT_TAG.value =cboExportTag.value;
	frmList.RUN_TAG.value = cboRunTag.value;
	frmList.REQUEST_NAME.value = txtRequestName.value;
	frmList.REPORT_NO.value = '--';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	var strTemp = "";
	// 프로그래머 파라메터 추가
	// 파라메터1__값1&&파라메터2__값2&&....
	// 예제
	//strTemp += "ProjCode__" + strProjCode + "&&";
	//strTemp += "ConsultSeq__" + strConsultSeq;

	/*
	strTemp += "pCOMP_CODE__" + vCompCode;
	strTemp += "&&pCOMP_NAME__" + vCompName;
	strTemp += "&&pDEPT_CODE__" + vDeptCode;
	strTemp += "&&pDEPT_NAME__" + vDeptName;
	strTemp += "&&pCUST_CODE__" + vCustCode;
	strTemp += "&&pCUST_NAME__" + vCustName;
	strTemp  += "&&pDT_T__" + vDT_T.replace(/-/gi,"");
	strTemp += "&&pDT_F__" + vDT_F.replace(/-/gi,"");
	*/

	
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}
// 조회
function btnquery_onclick()
{
	dsMAIN.ResetStatus();
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
		CountRow();
		CountSelectRow();
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

var chkLock = false; // btnAllSelect_onClick(), btnAllSelCancle_onClick() 에서 사용
function	OnColumnChanged(dataset, row, colid)
{
	if(dataset == dsMAIN)
	{
		if(colid == "CHK_CLS")
		{
			if(chkLock) return;
			CountSelectRow();
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
		var pSLIP_ID        = dataset.NameString(row,"SLIP_ID");
		var pSLIP_IDSEQ     = dataset.NameString(row,"SLIP_IDSEQ");
		var pMAKE_COMP_CODE = dataset.NameString(row,"MAKE_COMP_CODE");
		var pMAKE_DT 	     = dataset.NameString(row,"MAKE_DT");
		var pMAKE_SEQ     	 = dataset.NameString(row,"MAKE_SEQ");
		var pSLIP_KIND_TAG  = dataset.NameString(row,"SLIP_KIND_TAG");
		var pREADONLY_TF    = "F";
		alert(pMAKE_SEQ);
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

// 전체선택
function btnAllSelect_onClick()
{
	chkLock = true;
	for(i=1;i<=dsMAIN.CountRow;i++)
	{
		dsMAIN.NameString(i,"CHK_CLS") = "T";
	}
	chkLock = false;
	CountSelectRow();
}

// 전체선택취소
function btnAllSelCancle_onClick()
{
	chkLock = true;
	for(i=1;i<=dsMAIN.CountRow;i++)
	{
		dsMAIN.NameString(i,"CHK_CLS") = "F";
	}
	chkLock = false;
	CountSelectRow();
}

function CountSelectRow()
{
	var RowCnt2 = 0;
	for(i=1;i<=dsMAIN.CountRow;i++)
	{
		if(dsMAIN.NameString(i,"CHK_CLS") == "T")
		{
			RowCnt2++;
		}
	}
    txtTransCase.value = RowCnt2;
}

// 일괄출력
function btnSLIP_CONFIRM_onClick()
{
	trans.Parameters = "ACT=SLIP_PRINT";

	btnquery_prt_onclick();
}

function CountRow()
{
    var RowCnt = dsMAIN.CountRow;
    txtCaseAll.value = RowCnt;
}

//회기마감
function chkDayClose(bMsgView, row)
{
	var vMsg = "( 전표번호 : "+dsMAIN.NameString(row,"MAKE_SLIPNO") + " )";
	G_Load(dsDAY_CLOSE, null);
	if(dsDAY_CLOSE.CountRow==0) {
		if(bMsgView) C_msgOk("해당일자의 사업장별 마감정보가 등록되지 않았습니다.<BR>"+vMsg, "확인");
		vAccClse = false;
		vMonClse = false;
		vDayClse = false;
		vDeptClse = false;
		return false;
	}
	
	if(dsDAY_CLOSE.NameValue(dsDAY_CLOSE.RowPosition, "ACC_CLSE_CLS") == "T")
	{
		if(bMsgView) C_msgOk("해당일자는 회기마감되었습니다.<BR>"+vMsg, "확인");
		vAccClse = true;
		return false;
	} else {
		vAccClse = false;
	}
	
	if(dsDAY_CLOSE.NameValue(dsDAY_CLOSE.RowPosition, "MON_CLSE_CLS") == "T")
	{
		if(bMsgView) C_msgOk("해당일자는 월마감되었습니다.<BR>"+vMsg, "확인");
		vMonClse = true;
		return false;
	} else {
		vMonClse = false;
	}
	
	if(dsDAY_CLOSE.NameValue(dsDAY_CLOSE.RowPosition, "DAY_CLSE_CLS") == "T")
	{
		if(bMsgView) C_msgOk("해당일자는 일마감되었습니다.<BR>"+vMsg, "확인");
		vDayClse = true;
		return false;
	} else {
		vDayClse = false;
	}
	
	if(dsDAY_CLOSE.NameValue(dsDAY_CLOSE.RowPosition, "DEPT_CLSE_CLS") == "T")
	{		
		if(bMsgView) C_msgOk(txtMAKE_DEPT_NAME.value+"의 전표입력기간이 종료되었습니다.<BR>"+vMsg+"<BR>* 전표입력가능기간 : ("+dsDAY_CLOSE.NameValue(dsDAY_CLOSE.RowPosition, "INPUT_DT")+")", "확인");
		vDeptClse = true;
		return false;
	} else {
		vDeptClse = false;
	}
	
	return true;
}