/**************************************************************************/
/* 1. 프 로 그 램 id :t_PSlipFixSheetR(취득전표자동생성)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 한재원 작성(2006-02-06)
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

var vGET_TYPE = "";
var vWORK_SLIP_ID = "";
var vWORK_SLIP_IDSEQ = "";

function Initialize()
{
	document.body.topMargin = 0;
	document.body.leftMargin = 0;
      
	lrArgs = window.dialogArguments;
	vWorkSeq = lrArgs.work_seq;
	vDiv	= lrArgs.div;
	
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "전표발행대상");

	G_addDataSet(dsMAKE_SEQ, null, null, null, "전표순번");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	G_addDataSet(dsDAY_CLOSE, null, null, null, "마감정보");
	G_addDataSet(dsWORK_SLIP_IDSEQ, null, null, null, "자동전표ID순번");
	G_addDataSet(dsNEW_WORK_SLIP, null, null, null, "자동전표상대계정신규생성");	
	
	G_addDataSet(dsCOST_DEPT_KND_TAG, null, null, sSelectPageName+D_P1("ACT","COST_DEPT_KND_TAG"), "원가현장구분");
	
	G_Load(dsMAIN, null);
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName; 
	
	txtSLIP_MAKE_DT_F.value = sDt_Trans;//txtDT_F.value.replace(/-/gi,"");
	txtSLIP_MAKE_DT.value = sDt_Trans;
	txtSLIP_MAKE_SEQ.value = "";
	cboSLIP_KIND_TAG.value	= "B";
	cboSLIP_KIND_TAG.disabled = true;
	
	txtSLIP_MAKE_COMP_CODE.value = sCompCode;
	txtSLIP_MAKE_COMP_NAME.value = sCompName;

	txtSLIP_MAKE_DEPT_CODE.value = sDeptCode;
	txtSLIP_MAKE_DEPT_NAME.value = sDeptName;
	txtSLIP_INOUT_DEPT_CODE.value = sInout_DeptCode;
	txtSLIP_INOUT_DEPT_NAME.value = sInout_DeptName;
	// 작성자

	
	txtSLIP_CHARGE_PERS.value	= sCHARGE_PERS;
	txtSLIP_CHARGE_PERS_NAME.value	= sCHARGE_PERS_NAME;

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	

	txtWORK_DT_FROM.value	= vDATE.substr(0,4)+"-01-01";
    	txtWORK_DT_TO.value  	= vDATE.substr(0,4)+"-"+vDATE.substr(4,2)+"-"+vDATE.substr(6,2);
      
	if(vWORK_SLIP_ID=="") CurWorkSlip();
	G_Load(dsCOST_DEPT_KND_TAG, null);
	gridMAIN.focus();
}

function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//시스템명 가져오기
	{
		var			strCOMP_CODE 		= txtCOMP_CODE.value;
		var			strWORK_DT_FROM 	= txtWORK_DT_FROM.value;
		var			strWORK_DT_TO 		= txtWORK_DT_TO.value;
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									 + D_P2("COMP_CODE", txtCOMP_CODE.value)
									 + D_P2("WORK_DT_FROM",strWORK_DT_FROM)
									 + D_P2("WORK_DT_TO",strWORK_DT_TO)
									 + D_P2("WORK_SEQ", vWorkSeq)
									 + D_P2("DIV", vDiv);
									           
	}
	else if(dataset == dsMAKE_SEQ)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAKE_SEQ")
											+ D_P2("MAKE_COMP_CODE",txtSLIP_MAKE_COMP_CODE.value)
											+ D_P2("MAKE_DT_TRANS",txtSLIP_MAKE_DT.value);
	}
	else if(dataset == dsDAY_CLOSE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","DAY_CLOSE")
											+ D_P2("COMP_CODE",vMAKE_COMP_CODE)
											+ D_P2("DEPT_CODE",vMAKE_DEPT_CODE)
											+ D_P2("CLSE_DAY",vMAKE_DT_TRANS);
	}
	else if(dataset == dsWORK_SLIP_IDSEQ)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","WORK_SLIP_IDSEQ")
											+ D_P2("GET_TYPE",vGET_TYPE)
											+ D_P2("WORK_CODE",vWORK_CODE)
											+ D_P2("DEPT_CODE",sDeptCode);
	}
	else if(dataset == dsNEW_WORK_SLIP)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","NEW_WORK_SLIP")
											+ D_P2("WORK_SLIP_ID", vWORK_SLIP_ID)
											+ D_P2("WORK_SLIP_IDSEQ", vWORK_SLIP_IDSEQ)
											+ D_P2("WORK_CODE",vWORK_CODE)
											+ D_P2("DEPT_CODE",sDeptCode);
		//alert(dataset.DataID);
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

//조회시 체크
function checkCondition()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("사업장을  선택하십시요.", "확인");
		return;
	}
	if (C_isNull(txtWORK_DT_FROM.value))
	{
		C_msgOk("작업시작일자를 입력하십시요.", "확인");
		return;
	}
	if (C_isNull(txtWORK_DT_TO.value))
	{
		C_msgOk("작업종료일자를 입력하십시요.", "확인");
		return;
	}
	return true;
}
//신규 작업 전표ID 생성
function NewWorkSlip() {
	
	if(sDeptCode == "") {
		C_msgOk("로그인 정보가 없습니다. 작업을 진행할 수 없습니다.");
		return;
	}
	vGET_TYPE = "NEW";
	G_Load(dsWORK_SLIP_IDSEQ, null);
	vWORK_SLIP_ID = dsWORK_SLIP_IDSEQ.NameString(1,"WORK_SLIP_ID");
	vWORK_SLIP_IDSEQ = dsWORK_SLIP_IDSEQ.NameString(1,"WORK_SLIP_IDSEQ");
	
	G_Load(dsNEW_WORK_SLIP, null);
	//AccSearch();
}
//현재 작업 전표ID 
function CurWorkSlip() {
	
	if(sDeptCode == "") {
		C_msgOk("로그인 정보가 없습니다. 작업을 진행할 수 없습니다.");
		return;
	}
	
	vGET_TYPE = "CUR";	
	G_Load(dsWORK_SLIP_IDSEQ, null);
	vWORK_SLIP_ID = dsWORK_SLIP_IDSEQ.NameString(1,"WORK_SLIP_ID");
	vWORK_SLIP_IDSEQ = dsWORK_SLIP_IDSEQ.NameString(1,"WORK_SLIP_IDSEQ");
	
	if(vWORK_SLIP_ID == "0") {
		NewWorkSlip();
		return;
	}
	//AccSearch();
}
//상대계정검색
function AccSearch() {
	//ifrmOtherAccPage.AccSearch(vWORK_CODE, vWORK_SLIP_ID, vWORK_SLIP_IDSEQ);
	//ifrmOtherAccPage.AccReload();
}

//상대계정 업데이트 여부
function isAccUpdated() {
	if (ifrmOtherAccPage.dsSLIP_D.IsUpdated)
	{
		var	vRet	= C_msgYesNo("상대계정정보가 수정되었습니다.<br>저장하고 진행하시겠습니까?", "확인");
		if (vRet != "Y") return false;
		ifrmOtherAccPage.AccSaveNoMsg();
		
		// 저장에 실패하면...
		if (ifrmOtherAccPage.dsSLIP_D.IsUpdated) return false;
	}
	return true;
}

function SetIfrmOtherAccPageAmt()
{
	if(dsMAIN.NameString(1,"ACC_REMAIN_POSITION") == "C") {
		ifrmOtherAccPage.dsSLIP_D.NameString(1,"DB_AMT") = dsMAIN.NameSum("GET_AMT",0,0);
		ifrmOtherAccPage.dsSLIP_D.NameString(1,"DB_AMT_D") = C_toNumberFormatString(dsMAIN.NameSum("GET_AMT",0,0));
	} else {
		ifrmOtherAccPage.dsSLIP_D.NameString(1,"CR_AMT") = dsMAIN.NameSum("GET_AMT",0,0);
		ifrmOtherAccPage.dsSLIP_D.NameString(1,"CR_AMT_D") = C_toNumberFormatString(dsMAIN.NameSum("GET_AMT",0,0));
	}
}

// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	if(!CheckCompCode()) return;
	vDiv="A";
	D_defaultLoad(dsMAIN);
}


// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "WORK_DT_FROM")
	{
		txtWORK_DT_FROM.value = asDate;
		if ( !C_isNull(txtWORK_DT_FROM.value))
		{
			strWorkDtFrom = txtWORK_DT_FROM.value.replace(/-/gi,"");
			strWorkDtTo	 = txtWORK_DT_TO.value.replace(/-/gi,"");

			if (parseInt(strWorkDtFrom) > parseInt(strWorkDtTo))
			{
				C_msgOk("시작일은 종료일보다 작게 입력하세요");
				//txtWORK_DT_FROM.value = olddata1;
				return;
			}
		}	
	}
	else if (asCalendarID == "WORK_DT_TO")
	{
		txtWORK_DT_TO.value = asDate;
		if ( !C_isNull(txtWORK_DT_TO.value))
		{
			strWorkDtFrom = txtWORK_DT_FROM.value.replace(/-/gi,"");
			strWorkDtTo	 = txtWORK_DT_TO.value.replace(/-/gi,"");

			if (parseInt(strWorkDtFrom) > parseInt(strWorkDtTo))
			{
				C_msgOk("시작일은 종료일보다 작게 입력하세요");
				//txtWORK_DT_TO.value = olddata2;
				return;
			}
		}	
	}
	else if (asCalendarID == "SLIP_MAKE_DT")
	{
		txtSLIP_MAKE_DT.value = asDate.replace(/-/gi,"");
		if (txtSLIP_MAKE_DT_F.value == txtSLIP_MAKE_DT.value) return;
		txtSLIP_MAKE_SEQ.value = "";
	}
	else if (asCalendarID == "DT_F")
	{
		txtDT_F.value = asDate;
	}
	else if (asCalendarID == "DT_T")
	{
		txtDT_T.value = asDate;
	}
	else if (asCalendarID == "EXPR_DT_F")
	{
		txtEXPR_DT_F.value = asDate;
	}
	else if (asCalendarID == "EXPR_DT_T")
	{
		txtEXPR_DT_T.value = asDate;
	}

}

function OnLoadCompleted(dataset, rowcnt)
{
	if(dataset == dsMAIN)
	{
	}
	else if(dataset == dsNEW_WORK_SLIP)
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

var lockOnColumnChanged = false;

function	OnColumnChanged(dataset, row, colid)
{
	if (dataset == dsMAIN)
	{

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
		if(colid == 'GET_AMT') return;
		
		var pSLIP_ID        		= dataset.NameString(row,"SLIP_ID");
		var pSLIP_IDSEQ     	= dataset.NameString(row,"SLIP_IDSEQ");
		
		//전표헤더쪽 정보
		var pMAKE_COMP_CODE = dataset.NameString(row,"MAKE_COMP_CODE"); 
		var pMAKE_DT 	       = dataset.NameString(row,"MAKE_DT").replace(/-/gi,"");
		var pMAKE_SEQ     	 	= dataset.NameString(row,"MAKE_SEQ");
		var pSLIP_KIND_TAG  	= dataset.NameString(row,"SLIP_KIND_TAG");
		var pREADONLY_TF    	= "F";
		
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

function OnSuccess(dataset, p_Trans) {
	if (p_Trans == trans)
	{
		//txtSLIP_MAKE_SEQ.value = "";
		//btnquery_onclick();
	}
	else
	{
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

//발의사업장
function	txtCOMP_CODE_onChange()
{
	gridMAIN.focus();
	btnquery_onclick();
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

function btnEXPR_DT_F_onClick()
{
	C_Calendar("EXPR_DT_F", "D", txtEXPR_DT_F.value);
	S_nextFocus(btnEXPR_DT_F);
}

function btnEXPR_DT_T_onClick()
{
	C_Calendar("EXPR_DT_T", "D", txtEXPR_DT_T.value);
	S_nextFocus(btnEXPR_DT_T);
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
	//G_Load(dsCLASS_CODE, null);
}

// 귀속사업장
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
	lrArgs.set("SEARCH_CONDITION", txtDEPT_NAME.value);

	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE3", lrArgs,"T");

	if (lrRet == null) return;

	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
	//G_Load(dsCLASS_CODE, null);
}

function btnDEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtDEPT_NAME.value);

	lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"T");

	if (lrRet == null) return;

	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
	//G_Load(dsCLASS_CODE, null);
}


function Input_Clear()
{	
	if (C_isNull(txtSLIP_MAKE_COMP_CODE.value))
	{
		txtSLIP_MAKE_SEQ.value = "";
		txtSLIP_MAKE_COMP_NAME.value = "";
		txtSLIP_MAKE_DEPT_CODE.value = "";
	}

	if (C_isNull(txtSLIP_MAKE_DEPT_CODE.value))
	{
		txtSLIP_MAKE_DEPT_NAME.value = "";
	}
	
}

// 발의사업장
function btnSLIP_MAKE_COMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("WORK_CODE", vWORK_CODE);
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE2", lrArgs,"T");
	
	if (lrRet == null) return;
	txtSLIP_MAKE_COMP_CODE.value	= "";
	Input_Clear();
	txtSLIP_MAKE_COMP_CODE.value	= lrRet.get("COMP_CODE");
	txtSLIP_MAKE_COMP_NAME.value	= lrRet.get("COMPANY_NAME");
	txtSLIP_CHARGE_PERS.value		= lrRet.get("CHARGE_PERS");
	txtSLIP_CHARGE_PERS_NAME.value	= lrRet.get("CHARGE_PERS_NAME");
}

//발의부서
function btnSLIP_MAKE_DEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtSLIP_MAKE_COMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtSLIP_MAKE_COMP_CODE.value);

	lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"T");

	if (lrRet == null) return;
	
	txtSLIP_MAKE_DEPT_CODE.value	= "";
	Input_Clear();

	txtSLIP_MAKE_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtSLIP_MAKE_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
	Input_Clear();
}

//출납부서
function btnSLIP_INOUT_DEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");

	//lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"T");
	lrRet = C_LOV_NEW("T_DEPT_CODE3", btnSLIP_INOUT_DEPT_CODE, lrArgs,"T");

	if (lrRet == null) return;
	
	txtSLIP_INOUT_DEPT_CODE.value	= "";
	Input_Clear();

	txtSLIP_INOUT_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtSLIP_INOUT_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
}

//관리담당
function btnSLIP_CHARGE_PERS_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtSLIP_MAKE_COMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtSLIP_CHARGE_PERS.value);

	lrRet = C_LOV("Z_AUTHORITY_USER02", lrArgs,"T");

	if (lrRet == null) return;
	
	txtSLIP_CHARGE_PERS.value	= "";
	Input_Clear();

	txtSLIP_CHARGE_PERS.value	= lrRet.get("EMPNO");
	txtSLIP_CHARGE_PERS_NAME.value	= lrRet.get("NAME");
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

	lrRet = C_AutoLov(dsLOV,"T_ACC_CODE9", lrArgs,"T");

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
		lrRet = C_LOV("T_ACC_CODE9", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_ACC_CODE9", lrArgs,"T");
	}
	
	if (lrRet == null) return;
	txtACC_CODE.value	= "";
	Input_Clear();
	
	txtACC_CODE.value = lrRet.get("ACC_CODE");
	txtACC_NAME.value = lrRet.get("ACC_NAME");
}

//발의일자
function txtSLIP_MAKE_DT_onblur()
{
	if (txtSLIP_MAKE_DT_F.value == txtSLIP_MAKE_DT.value) return;

	if (!S_isValidDate(txtSLIP_MAKE_DT.value))
	{
		C_msgOk(ERR_MSG);
		txtSLIP_MAKE_DT.focus();
		return;
	}
	
	txtSLIP_MAKE_SEQ.value = "";
}

function btnSLIP_MAKE_DT_onClick()
{
	txtSLIP_MAKE_DT_F.value = txtSLIP_MAKE_DT.value;
	
	C_Calendar("SLIP_MAKE_DT", "D", txtSLIP_MAKE_DT.value);
}

//거래처코드검색
function txtCUST_CODE_onblur()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null; 

	lrArgs.set("SEARCH_CONDITION", txtCUST_CODE.value);
	
	lrRet = C_AutoLov(dsLOV,"T_CUST_CODE1", lrArgs,"T");

	if (lrRet == null) return;
	hiCUST_SEQ.value		= lrRet.get("CUST_SEQ");
	txtCUST_CODE.value	= lrRet.get("CUST_CODE");
	txtCUST_NAME.value	= lrRet.get("CUST_NAME");

}

function btnCUST_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_CUST_CODE1", lrArgs,"F");

	if (lrRet == null) return;

	hiCUST_SEQ.value		= lrRet.get("CUST_SEQ");
	txtCUST_CODE.value	= lrRet.get("CUST_CODE");
	txtCUST_NAME.value	= lrRet.get("CUST_NAME");

}


function LPad(strNum, nSize) {
	if(strNum.length>nSize) return strNum;
	
	var idx = 0;
	var nPad = nSize - (strNum.length);
	
	for(idx=0;idx<nPad;idx++) {
		strNum = "0"+strNum;
	}
	return strNum;
}

// 전표생성
function	btnSlipCreate_onClick()
{
	//if (C_isNull(txtACC_CODE.value || txtACC_CODE.value))
	//{
		//C_msgOk("계정과목별로 조회한후 실행해 주십시오.");
		//return;
	//}
	//if(!isAccUpdated()) return;

	
	if(!chkDayClose(true)) return;
	
	if (txtSLIP_MAKE_DT.value == "")
	{
		C_msgOk("작성일자를 입력하여 주십시오.");
		txtSLIP_MAKE_DT.focus();
		return;
	}

	if (cboSLIP_KIND_TAG.value == "")
	{
		C_msgOk("전표종류를 입력하여 주십시오.");
		return;
	}

	if (txtSLIP_MAKE_COMP_CODE.value == "")
	{
		C_msgOk("사업장 입력하여 주십시오.");
		return;
	}
	
	if (C_isNull(txtSLIP_MAKE_DEPT_CODE.value || txtSLIP_MAKE_DEPT_NAME.value))
	{
		C_msgOk("작성부서를 입력하여 주십시오.");
		return;
	}
	
	/*
	if (C_isNull(txtSLIP_CHARGE_PERS.value || txtSLIP_CHARGE_PERS_NAME.value))
	{
		C_msgOk("관리담당이 입력되지 않았습니다.<BR>*[기초정보>자동전표코드]에서 자동전표별 사업장 관리담당이 등록됐는지 확인해주시기 바랍니다.");
		return;
	}
	
	
	if (C_isNull(txtSLIP_INOUT_DEPT_CODE.value || txtSLIP_INOUT_DEPT_NAME.value))
	{
		C_msgOk("출납부서를 입력하여 주십시오.");
		return;
	}
	*/

	
	btnSLIP_MAKE_SLIPNO_onClick();
	
	trans.Parameters = "";
	trans.Parameters += "ACT=AUTO_BILL_FIX_DEPREC";
	//trans.Parameters += ",SLIP_MAKE_SLIP_NO="+txtSLIP_MAKE_DT.value.substring(2) + '-' + LPad(txtSLIP_MAKE_SEQ.value,4) + cboSLIP_KIND_TAG.value + '-' + txtSLIP_MAKE_COMP_CODE.value;	
	trans.Parameters += ",SLIP_MAKE_SLIP_NO="+txtSLIP_MAKE_DT.value.substring(2) + cboSLIP_KIND_TAG.value + '' + txtSLIP_MAKE_COMP_CODE.value + '' + LPad(txtSLIP_MAKE_SEQ.value,4);	//수정
	trans.Parameters += ",SLIP_MAKE_DT="+txtSLIP_MAKE_DT.value;
	trans.Parameters += ",SLIP_MAKE_SEQ="+LPad(txtSLIP_MAKE_SEQ.value,4);
	trans.Parameters += ",SLIP_KIND_TAG="+cboSLIP_KIND_TAG.value;
	trans.Parameters += ",SLIP_MAKE_COMP_CODE="+txtSLIP_MAKE_COMP_CODE.value;
	trans.Parameters += ",SLIP_MAKE_DEPT_CODE="+txtSLIP_MAKE_DEPT_CODE.value;
	trans.Parameters += ",SLIP_CHARGE_PERS="+txtSLIP_CHARGE_PERS.value;
	trans.Parameters += ",SLIP_INOUT_DEPT_CODE="+txtSLIP_INOUT_DEPT_CODE.value;
	trans.Parameters += ",WORK_SLIP_ID="+vWORK_SLIP_ID;
	trans.Parameters += ",WORK_SLIP_IDSEQ="+vWORK_SLIP_IDSEQ;
	trans.Parameters += ",WORK_CODE="+vWORK_CODE;
	trans.Parameters += ",WORK_SEQ="+dsMAIN.NameValue(dsMAIN.RowPosition, "WORK_SEQ");
	trans.Parameters += ",COST_DEPT_KND_TAG="+dsCOST_DEPT_KND_TAG.NameValue(dsCOST_DEPT_KND_TAG.RowPosition, "COST_DEPT_KND_TAG");

	
	//alert(trans.Parameters);
	
	if(!G_saveData(dsMAIN))  return;

	C_msgOk("전표가 발행되었습니다");
}

//회기마감
function chkDayClose(bMsgView)
{
	//var vMsg = "( 전표번호 : "+dsMAIN.NameString(row,"MAKE_SLIPNO") + " )";
	var vMsg = "";
	vMAKE_COMP_CODE = txtSLIP_MAKE_COMP_CODE.value;
	vMAKE_DEPT_CODE = txtSLIP_MAKE_DEPT_CODE.value;
	vMAKE_DT_TRANS  = txtSLIP_MAKE_DT.value;
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

function btnSLIP_MAKE_SLIPNO_onClick() {
	if (C_isNull(txtSLIP_MAKE_DT.value) )
	{
		C_msgOk("전표번호의 일자를 입력해주세요");	
		return;
	}
	G_Load(dsMAKE_SEQ, null);
	txtSLIP_MAKE_SEQ.value = LPad(dsMAKE_SEQ.NameString(dsMAKE_SEQ.RowPosition, "MAKE_SEQ"),4);
}

function btnQuery_onClick()
{
	if(!checkCondition()) return;
	vDiv="A";
	D_defaultLoad(dsMAIN);
}

function btnWORK_DT_FROM_onClick()
{
	C_Calendar("WORK_DT_FROM", "D", txtWORK_DT_FROM.value);
	 
}

function btnWORK_DT_TO_onClick()
{

	C_Calendar("WORK_DT_TO", "D", txtWORK_DT_TO.value);
}

//전표삭제
function btnSlipDelete_onClick()
{
	if(C_isNull(dsMAIN.NameValue(dsMAIN.RowPosition, "SLIP_ID")))
	{
		C_msgOk("전표가 발행되지 않아서 삭제할 수 없습니다");
		return;	
	}
	
	trans.Parameters = "";
	trans.Parameters += "ACT=AUTO_SLIP_ID_DEL";
	trans.Parameters += ",SLIP_ID="+dsMAIN.NameValue(dsMAIN.RowPosition, "SLIP_ID");	
	//alert(trans.Parameters);
	//return;
	if(!G_saveData(dsMAIN)){
		return;
		
	}
	C_msgOk("전표가 삭제되었습니다");	
}