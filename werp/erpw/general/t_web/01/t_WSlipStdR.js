/**************************************************************************/
/* 1. 프 로 그 램 id : t_WSlipR.js(전표등록)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 프로그램 설명
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-18)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var vMAKE_COMP_CODE = null;
var vMAKE_DT_TRANS = null;
var vMAKE_SEQ = null;
var vSLIP_KIND_TAG = null;
var vError_Flag = null;
var vOBJ = null;

var vAccClse = false;
var vMonClse = false;
var vDayClse = false;
var vDeptClse = false;

var vUpdate = true;

var isPopup = false;
var amtLOCK = false;
var	vatdtLOCK = false;
var	deptcodeLOCK = false;
var	deptnameLOCK = false;
/*
parent.main_title.div_u.style.visibility = "hidden";
parent.main_title.div_s.style.visibility = "visible";
*/

var vsSLIP_ID        = "";
var vsSLIP_IDSEQ     = "";
var vsMAKE_COMP_CODE = "";
var vsMAKE_DT 	     = "";
var vsMAKE_SEQ     	 = "";
var vsSLIP_KIND_TAG  = "";
var vsREADONLY_TF    = "";
/*
var vsSLIP_ID        = "20060103";
var vsSLIP_IDSEQ     = "1";
var vsMAKE_COMP_CODE = "A0";
var vsMAKE_DT 	     = "20060103";
var vsMAKE_SEQ     	 = "4";
var vsSLIP_KIND_TAG  = "A";
var vsREADONLY_TF    = "F";
*/
var opnrArgs = window.dialogArguments;

function	LNumRange(aStart,aEnd)
{
	this.StartRow = aStart;
	this.EndRow = aEnd;
	this.IsEmpty = f_LNumRangeIsEmpty;
}
function	f_LNumRangeIsEmpty()
{
	return this.StartRow == 0 || this.EndRow == 0;
}
function _Debug(_msg) {
	//if(true) alert(_msg);	
}

if(opnrArgs!=null) {
	if(opnrArgs.SLIP_ID!=null) {
		vsSLIP_ID        = opnrArgs.SLIP_ID;
		vsSLIP_IDSEQ     = opnrArgs.SLIP_IDSEQ;
		vsMAKE_DT 	     = opnrArgs.MAKE_DT.replace(/-/g, "");
		vsMAKE_SEQ     	 = opnrArgs.MAKE_SEQ;
		vsSLIP_KIND_TAG  = opnrArgs.SLIP_KIND_TAG;
		vsMAKE_COMP_CODE = opnrArgs.MAKE_COMP_CODE;
		vsREADONLY_TF    = opnrArgs.READONLY_TF;
	}
	isPopup = true;
}

function Initialize()
{
	G_addDataSet(dsMAIN, transMAIN, null, null, "부서목록");
	G_addDataSet(dsSLIP_H, trans, gridSLIP_H, null, "전표HEAD");
	G_addDataSet(dsSLIP_D, trans, gridSLIP_D, null, "전표내역", null, false);
	G_addDataSet(dsRESET_CNT, null, null, null, "반제내역");
	G_addDataSet(dsSLIP_ID, null, null, null, "전표ID");
	G_addDataSet(dsSLIP_IDSEQ, null, null, null, "전표ID순번");
	G_addDataSet(dsMAKE_SEQ, null, null, null, "전표순번");
	G_addDataSet(dsLOV, null, null, null, "LOV");
	G_addDataSet(dsDAY_CLOSE, null, null, null, "마감정보");
	G_addDataSet(dsCLASS_CODE, null, null, null, "부문코드");
	G_addDataSet(dsDEPT_ACC_CHK, null, null, null, "부서별 계정코드존재 체크");
	G_addDataSet(dsCOST_DEPT_KND_ACC, null, null, null, "원가현장구분별 비용계정");
	G_addDataSet(dsCUST_CODE, null, null, null, "거래처코드");

	G_addDataSet(dsBRAIN_SLIP_SEQ1, null, null, null, "표준전표적요코드대분류등록");
	G_addDataSet(dsBRAIN_SLIP_SEQ2, null, null, null, "표준전표적요소코드중분류등록");
	G_addDataSet(dsBRAIN_GRP_SEQ, null, null, null, "BRAIN_GRP_SEQ");
	G_addDataSet(dsBRAIN_SLIP_BODY, null, null, null, "표준전표적요소코드등록");

	G_addRel(dsSLIP_H, dsSLIP_D);
	G_addRelCol(dsSLIP_D, "SLIP_ID", "SLIP_ID");

	G_addRel(dsBRAIN_SLIP_SEQ1, dsBRAIN_SLIP_SEQ2);
	G_addRelCol(dsBRAIN_SLIP_SEQ2, "BRAIN_SLIP_SEQ1", "BRAIN_SLIP_SEQ1");
	G_Load(dsBRAIN_SLIP_SEQ1, null);
	
	vMAKE_COMP_CODE = "";
	vMAKE_DT_TRANS = "";
	vMAKE_SEQ = "";

	Slip_Head_Setting();
	
	if (vsSLIP_ID != "")
	{
		txtMAKE_DT.value		= vsMAKE_DT;
		txtMAKE_DT_TRANS.value	= vsMAKE_DT;
		txtMAKE_SEQ.value		= vsMAKE_SEQ;
		cboSLIP_KIND_TAG.value	= vsSLIP_KIND_TAG;
		txtMAKE_COMP_CODE.value	= vsMAKE_COMP_CODE;

		btnquery_onclick();
		var	pRowIdx	= dsSLIP_D.NameValueRow("SLIP_IDSEQ",vsSLIP_IDSEQ);
		dsSLIP_D.RowPosition = pRowIdx;
		gridSLIP_D.focus();
	} else {
		G_Load(dsSLIP_H, null);
		D_Div_ReadOnly(divSLIP_D, true);
		Input_Clear();
		btnadd_onclick();
	}

	if (sDept_Chg_Cls == "T")
	{
		document.all.txtMAKE_COMP_CODE.readOnly				= false;
		document.all.txtMAKE_COMP_CODE.style.background		= "white";

		document.all.txtCOMPANY_NAME.readOnly		= false;
		//document.all.btnMAKE_COMP_CODE.disabled	= false;
		document.all.btnMAKE_COMP_CODE.style.display= "";
		document.all.txtMAKE_DEPT_NAME.readOnly		= false;
		//document.all.btnMAKE_DEPT_CODE.disabled	= false;
		document.all.btnMAKE_DEPT_CODE.style.display= "";
	}
	else
	{
		document.all.txtMAKE_COMP_CODE.readOnly				= true;
		document.all.txtMAKE_COMP_CODE.style.background		= "#EFEFEF";

		document.all.txtCOMPANY_NAME.readOnly		= true;
		//document.all.btnMAKE_COMP_CODE.disabled		= true;
		document.all.btnMAKE_COMP_CODE.style.display= "none";
		document.all.txtMAKE_DEPT_NAME.readOnly		= true;
		//document.all.btnMAKE_DEPT_CODE.disabled		= true;
		document.all.btnMAKE_DEPT_CODE.style.display= "none";
	}
}

function OnLoadBefore(dataset)
{
	if(dataset == dsSLIP_H)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","SLIP_H")
											+ D_P2("MAKE_COMP_CODE",vMAKE_COMP_CODE)
											+ D_P2("MAKE_DT_TRANS",vMAKE_DT_TRANS)
											+ D_P2("MAKE_SEQ",vMAKE_SEQ)
											+ D_P2("MAKE_SLIPNO",txtMAKE_SLIPNO.value);
	}
	else if(dataset == dsSLIP_D)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","SLIP_D")
											+ D_P2("SLIP_ID",dsSLIP_H.NameString(dsSLIP_H.RowPosition, "SLIP_ID"));
	}
	else if(dataset == dsRESET_CNT)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","RESET_CNT")
											+ D_P2("SLIP_ID",dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_ID"))
											+ D_P2("SLIP_IDSEQ",dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_IDSEQ"));
	}
	else if(dataset == dsSLIP_ID)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","SLIP_ID");
	}
	else if(dataset == dsSLIP_IDSEQ)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","SLIP_IDSEQ");
	}
	else if(dataset == dsMAKE_SEQ)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAKE_SEQ")
											+ D_P2("SLIP_ID",dsSLIP_H.NameString(dsSLIP_H.RowPosition, "SLIP_ID"));
	}
	else if(dataset == dsCLASS_CODE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","CLASS_CODE")
											+ D_P2("DEPT_CODE",txtMAKE_DEPT_CODE.value);
	}
	else if(dataset == dsDAY_CLOSE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","DAY_CLOSE")
											+ D_P2("COMP_CODE",txtMAKE_COMP_CODE.value)
											+ D_P2("DEPT_CODE",txtMAKE_DEPT_CODE.value)
											+ D_P2("CLSE_DAY",txtMAKE_DT_TRANS.value);
	}
	
	else if(dataset == dsDEPT_ACC_CHK)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","DEPT_ACC_CHK")
											+ D_P2("DEPT_CODE",dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DEPT_CODE"))
											+ D_P2("ACC_CODE",txtACC_CODE.value);
	}
	else if(dataset == dsCOST_DEPT_KND_ACC)
	{
		/*
		dataset.DataID = sSelectPageName	+ D_P1("ACT","COST_DEPT_KND_ACC")
											+ D_P2("DEPT_CODE",dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DEPT_CODE"))
											+ D_P2("ACC_CODE",txtACC_CODE.value);
		*/
	}
	else if(dataset == dsCUST_CODE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","CUST_CODE")
											+ D_P2("CUST_CODE",txtCUST_CODE.value.replace(/-/g, ""));
	}
	else if(dataset == dsBRAIN_SLIP_SEQ1)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","BRAIN_SLIP_SEQ1");
	}
	else if(dataset == dsBRAIN_SLIP_SEQ2)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","BRAIN_SLIP_SEQ2")
										 + D_P2("BRAIN_SLIP_SEQ1",dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BRAIN_SLIP_SEQ1"));
	}
	else if(dataset == dsBRAIN_GRP_SEQ)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","BRAIN_GRP_SEQ");
	}
	else if(dataset == dsBRAIN_SLIP_BODY)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","BRAIN_SLIP_BODY")
										 + D_P2("DEPT_CODE",dsSLIP_D.NameString(dsSLIP_D.RowPosition,"DEPT_CODE"))
										 + D_P2("BRAIN_SLIP_SEQ1",dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BRAIN_SLIP_SEQ1"))
										 + D_P2("BRAIN_SLIP_SEQ2",dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BRAIN_SLIP_SEQ2"))
										 + D_P2("VAT_CODE",dsSLIP_D.NameString(dsSLIP_D.RowPosition,"VAT_CODE"));
	}
}

// 유틸리티 함수----------------------------------------------------------------//
function SafeToInt(asValue)
{
	if(C_isNull(asValue)) return 0;
	try
	{
		var	liRet = parseInt(asValue);
		if(isNaN(liRet)) return 0;
		return liRet;
	}
	catch( e )
	{
		return 0;
	}
}

function	SafeToFloat(asValue)
{
	if(C_isNull(asValue)) return 0;
	try
	{
		var	liRet = parseFloat(asValue);
		if(isNaN(liRet)) return 0;
		return liRet;
	}
	catch( e )
	{
		return 0;
	}
}

function	IsValidAccCDBV(row)
{
	var returnVal1 = ( (dsSLIP_D.NameString(row,"ACC_REMAIN_POSITION")	== "C")	&& (SafeToInt(dsSLIP_D.NameString(row,"DB_AMT")) !=	0) );
	var returnVal2 = ( (dsSLIP_D.NameString(row,"ACC_REMAIN_POSITION")	== "D")	&& (SafeToInt(dsSLIP_D.NameString(row,"DB_AMT")) <	0) );
	return returnVal1||returnVal2;
}
function	IsValidAccCDBVCurrent()
{
	return IsValidAccCDBV(dsSLIP_D.RowPosition);
}

function	IsValidAccDCRV(row)
{
	var returnVal1 = ( (dsSLIP_D.NameString(row,"ACC_REMAIN_POSITION")	== "D")	&& (SafeToInt(dsSLIP_D.NameString(row,"CR_AMT")) !=	0) );
	var returnVal2 = ( (dsSLIP_D.NameString(row,"ACC_REMAIN_POSITION")	== "C")	&& (SafeToInt(dsSLIP_D.NameString(row,"CR_AMT")) <	0) );
	return returnVal1||returnVal2;
}
function	IsValidAccDCRVCurrent()
{
	return IsValidAccDCRV(dsSLIP_D.RowPosition);
}

function	IsValidAccDDBV(row)
{
	return (dsSLIP_D.NameString(row,"ACC_REMAIN_POSITION")	== "D")	&& (SafeToInt(dsSLIP_D.NameString(row,"DB_AMT")) >	0);
}
function	IsValidAccDDBVCurrent()
{
	return IsValidAccDDBV(dsSLIP_D.RowPosition);
}

function	IsValidAccCCRV(row)
{
	return (dsSLIP_D.NameString(row,"ACC_REMAIN_POSITION")	== "C")	&& (SafeToInt(dsSLIP_D.NameString(row,"CR_AMT")) >	0);
}
function	IsValidAccCCRVCurrent()
{
	return IsValidAccCCRV(dsSLIP_D.RowPosition);
}

function	IsValidAccCDB0(row)
{
	return (dsSLIP_D.NameString(row,"ACC_REMAIN_POSITION")	== "C")	&& (SafeToInt(dsSLIP_D.NameString(row,"DB_AMT")) == 0);
}
function	IsValidAccCDB0Current()
{
	return IsValidAccCDB0(dsSLIP_D.RowPosition);
}
function	IsValidAccDCR0(row)
{
	return (dsSLIP_D.NameString(row,"ACC_REMAIN_POSITION")	== "D")	&& (SafeToInt(dsSLIP_D.NameString(row,"CR_AMT")) == 0);
}
function	IsValidAccDCR0Current()
{
	return IsValidAccDCR0(dsSLIP_D.RowPosition);
}


function	IsValidAccDDB0(row)
{
	return (dsSLIP_D.NameString(row,"ACC_REMAIN_POSITION")	== "D")	&& (SafeToInt(dsSLIP_D.NameString(row,"DB_AMT")) == 0);
}
function	IsValidAccDDB0Current()
{
	return IsValidAccDDB0(dsSLIP_D.RowPosition);
}
function	IsValidAccCCR0(row)
{
	return (dsSLIP_D.NameString(row,"ACC_REMAIN_POSITION")	== "C")	&& (SafeToInt(dsSLIP_D.NameString(row,"CR_AMT")) == 0);
}
function	IsValidAccCCR0Current()
{
	return IsValidAccCCR0(dsSLIP_D.RowPosition);
}



function	IsValidAccOSide(row)	//반대변이면
{
	return (IsValidAccDCRV(row)||IsValidAccCDBV(row));
}

function	IsValidAccOSideCurrent()
{
	return IsValidAccOSide(dsSLIP_D.RowPosition);
}

function	IsValidAccThisSide(row)		//자기변이면
{
	return (IsValidAccDDBV(row) || IsValidAccCCRV(row));
}

function	IsValidAccThisSideCurrent()
{
	return IsValidAccThisSide(dsSLIP_D.RowPosition);
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
	if (C_keyCode == "82")
	{
		C_keyCode = "";
		return;
	}
	
	if (dsSLIP_D.IsUpdated || G_isChanged(dsSLIP_D.id))
	{
		var	vRet	= C_msgYesNo("전표 작성중입니다. 작성을 취소하고 진행하시겠습니까?", "확인");
		if (vRet != "Y") return;
	}

	vMAKE_COMP_CODE			= txtMAKE_COMP_CODE.value;
	vMAKE_DT_TRANS			= txtMAKE_DT_TRANS.value;
	vMAKE_SEQ				= txtMAKE_SEQ.value;
	vSLIP_KIND_TAG			= cboSLIP_KIND_TAG.value;

	if( vMAKE_SEQ == "" && txtMAKE_SLIPNO.value == "" ) {
		C_msgOk("전표일자/순번이나 전표번호를 입력하고 다시 실행해 주십시오.", "확인");
		return;
	}
	
	G_Load(dsSLIP_H, null);
	if( dsSLIP_H.CountRow == 0 ) C_msgOk("전표가 존재하지 않습니다.", "확인");
}

// 추가
function btnadd_onclick()
{
	if (C_keyCode == "65")
	{
		btnDETAIL_ADD_onClick();
		C_keyCode = "";
		return;
	}

	if (C_cmdCode == "3020")
	{
		btnDETAIL_ADD_onClick();
		C_cmdCode = "";
		return;
	}
	
	if (C_isNull(txtMAKE_DT_TRANS.value))
	{
		C_msgOk("발의일자를 먼저 입력하세요.", "확인");
		txtMAKE_DT_TRANS.focus();
		return;
	}
	
	if (cboSLIP_KIND_TAG.value=='%')
	{
		C_msgOk("전표분류코드를 먼저 선택하세요.", "확인");
		cboSLIP_KIND_TAG.focus();
		return;
	}
	
	if (C_isNull(txtMAKE_COMP_CODE.value))
	{
		C_msgOk("사업장코드를 먼저 입력하세요.", "확인");
		txtMAKE_COMP_CODE.focus();
		return;
	}
	
	if (C_isNull(txtINOUT_DEPT_CODE.value))
	{
		C_msgOk("출납부서를 먼저 입력하세요.", "확인");
		return;
	}
	
	if (C_isNull(txtMAKE_DEPT_CODE.value))
	{
		C_msgOk("작성부서를 먼저 입력하세요.", "확인");
		return;
	}
	
	if( !chkDayClose(true) ) return;
	
	if (dsSLIP_D.IsUpdated || G_isChanged(dsSLIP_D.id))
	{
		var	vRet	= C_msgYesNo("전표 작성중입니다. 작성을 취소하고 진행하시겠습니까?", "확인");
		if (vRet != "Y") return;
	}
	dsSLIP_D.ResetStatus();
	
	btncancel_onclick();

	G_addRow(dsSLIP_H);
	Slip_Head_ReadOnly(true);
}

// 삽입
function btninsert_onclick()
{
	if (C_keyCode == "73")
	{
		btnDETAIL_INSERT_onClick();
		C_keyCode = "";
		return;
	}

	if (C_cmdCode == "3030")
	{
		btnDETAIL_INSERT_onClick();
		C_cmdCode = "";
		return;
	}
	
	btnadd_onclick();
}

// 삭제
function btndelete_onclick()
{
	if(txtKEEP_CLS.value == "확정") {
		C_msgOk("확정된 전표입니다.<br>삭제하시려면 먼저 확정을 취소하셔야 합니다.", "확인");
		return;
	}
	
	if (C_keyCode == "68")
	{
		btnDETAIL_DELETE_onClick();
		C_keyCode = "";
		return;
	}

	if (C_cmdCode == "3040")
	{
		btnDETAIL_DELETE_onClick();
		C_cmdCode = "";
		return;
	}
	
	if (dsSLIP_H.CountRow != 1) return;

	if(C_msgYesNo("정말 삭제하시겠습니까?","확인") == "N")
	{
		return;
	}

	dsSLIP_D.ClearData();
	G_deleteRow(dsSLIP_H);
	if(!G_saveData(dsSLIP_H)) {
		dsSLIP_H.ResetStatus();
		dsSLIP_D.ResetStatus();
		btnquery_onclick();
		return;
	}
	vUpdate = true;
	Slip_Head_ReadOnly(false);

	txtMAKE_SEQ.value = "";
	txtMAKE_SLIPNO.value = "";
}

// 저장
function btnsave_onclick() {
	btnsave_proc_onclick();
}

function btnsave_proc_onclick()
{
	if( ( vAccClse == true ) || ( vMonClse == true ) || ( vDayClse == true ) ) {
		C_msgOk("해당일자는 회기가감되었습니다.", "확인");
		return false;
	} else if( ( vDeptClse == true ) ) {
		C_msgOk("부서별 전표입력기간이 아닙니다.", "확인");
		return false;
	} else if (vsREADONLY_TF == "T") {
		C_msgOk("조회전용 모드입니다.", "확인");
		return false;
	} else if (dsSLIP_H.NameString(dsSLIP_H.RowPosition, "KEEP_CLS") == "T") {
		C_msgOk("확정된 전표입니다.<br>수정하시려면 먼저 확정을 취소하셔야 합니다.", "확인");
		return false;
	} else if (
		(dsSLIP_H.NameString(dsSLIP_H.RowPosition, "WORK_CODE")!="") 
		&& 
		(dsSLIP_H.NameString(dsSLIP_H.RowPosition, "SLIP_UPDATE_CLS") != "T")
		) 
	{
		C_msgOk(txtWORK_NAME.value+"전표는 수정할 수 업습니다.", "확인");
		return false;
	}
	
	if (dsSLIP_H.CountRow != 1) return false;
	
	if (dsSLIP_D.CountRow == 0)
	{
		C_msgOk("저장할 전표내역이 없습니다.", "확인");
		return false;
	}
	
	Input_Error_Check();
	
	if (vError_Flag == 'T')
	{
		vOBJ.focus();
		vError_Flag = "F";
		return false;
	}

	if( dsSLIP_H.RowStatus(1) == 0 || dsSLIP_H.RowStatus(1) == 3 ) { // 0 : 조회, 1 : 추가, 3 : 수정
		if(
			txtMAKE_DT_TRANS.value!=dsSLIP_H.NameString(1,"MAKE_DT_TRANS") ||
			txtMAKE_COMP_CODE.value!=dsSLIP_H.NameString(1,"MAKE_COMP_CODE") ||
			cboSLIP_KIND_TAG.value!=dsSLIP_H.NameString(1,"SLIP_KIND_TAG")
		) {
			if(C_msgYesNo("전표번호 구성항목이 변경되었습니다.<BR>계속진행하면 전표번호가 재생성됩니다.<BR>계속 진행하시겠습니까?","확인") == "N")
			{
				return;
			}
		}
	}

	dsSLIP_H.NameString(1,"MAKE_DT")		= txtMAKE_DT.value;
	dsSLIP_H.NameString(1,"MAKE_DT_TRANS")	= txtMAKE_DT_TRANS.value;
	dsSLIP_H.NameString(1,"SLIP_KIND_TAG")	= cboSLIP_KIND_TAG.value;
	dsSLIP_H.NameString(1,"MAKE_COMP_CODE")	= txtMAKE_COMP_CODE.value;
	dsSLIP_H.NameString(1,"MAKE_DEPT_CODE")	= txtMAKE_DEPT_CODE.value;
	dsSLIP_H.NameString(1,"MAKE_SEQ")		= txtMAKE_SEQ.value;
	dsSLIP_H.NameString(1,"MAKE_SLIPCLS")	= cboMAKE_SLIPCLS.value;

	dsSLIP_H.NameString(1,"CHARGE_PERS") = txtCHARGE_PERS.value;
	dsSLIP_H.NameString(1,"CHARGE_PERS_NAME") = txtCHARGE_PERS_NAME.value;

	dsSLIP_H.NameString(1, "INOUT_DEPT_CODE")	= txtINOUT_DEPT_CODE.value;
	dsSLIP_H.NameString(1, "INOUT_DEPT_NAME")	= txtINOUT_DEPT_NAME.value;
	
	if(!G_saveData(dsSLIP_H)) {
		return;
	}
	// 입력상태가 아니면 리턴...
	if(dsSLIP_H.NameString(1,"SLIP_ID") == "") return;

	// 전표조회면 리턴...
	if(dsSLIP_H.NameString(1,"MAKE_SEQ") != "0"){
		C_msgOk("전표내역이 저장되었습니다.", "확인");
		return;
	}

	// 신규저장일경우만, 실 전표순번을 가져와 다시 조회한다.
	G_Load(dsMAKE_SEQ, null);
	txtMAKE_SEQ.value = dsMAKE_SEQ.NameString(dsMAKE_SEQ.RowPosition, "MAKE_SEQ");
	btnquery_onclick();
	return true;
}

// 취소
function btncancel_onclick()
{
	if (dsSLIP_D.IsUpdated || G_isChanged(dsSLIP_D.id))
	{
		var	vRet = C_msgYesNo("정말 전표 작성을 취소하시겠습니까?", "확인");
		if (vRet != "Y") return;
	}
	
	vMAKE_COMP_CODE = "";
	vMAKE_DT_TRANS = "";
	vMAKE_SEQ = "";
	vSLIP_KIND_TAG = "";
	txtMAKE_SEQ.value = "";
	txtMAKE_SLIPNO.value = "";
	txtWORK_NAME.value = "";
	
	G_Load(dsSLIP_H, null);
	Input_Clear();

	vUpdate = true;
	Slip_Head_ReadOnly(false);
	document.all.divCUST_CODE.style.display = "none";
	document.all.divCUST_NAME.style.display = "none";
	document.all.divBANK_CODE.style.display = "none";
	document.all.divACCNO_CODE.style.display = "none";
	document.all.divCARD_SEQ.style.display = "none";
	document.all.divCHK_NO.style.display = "none";
	document.all.divBILL_NO.style.display = "none";
	document.all.divBILL_NO_R.style.display = "none";
	document.all.divREC_BILL_NO.style.display = "none";
	document.all.divREC_BILL_NO_R.style.display = "none";
	document.all.divSECU_NO.style.display = "none";
	document.all.divSECU_NO_R.style.display = "none";
	document.all.divLOAN_NO_S.style.display = "none";
	document.all.divLOAN_NO_R.style.display = "none";
	document.all.divLOAN_NO_I.style.display = "none";
	document.all.divDEPOSIT_PAYMENT.style.display = "none";
	document.all.divFIX.style.display = "none";
	document.all.divPAY_CON.style.display = "none";
	document.all.divPAY_CON_BILL_DT.style.display = "none";
	document.all.divEMP_NO.style.display = "none";
	document.all.divANTICIPATION_DATE.style.display = "none";
	document.all.divCASH.style.display = "none";
	document.all.divCARD.style.display = "none";
	document.all.divMNG_ITEM_CHAR1.style.display = "none";
	document.all.divMNG_ITEM_CHAR2.style.display = "none";
	document.all.divMNG_ITEM_CHAR3.style.display = "none";
	document.all.divMNG_ITEM_CHAR4.style.display = "none";
	document.all.divMNG_ITEM_NUM1.style.display = "none";
	document.all.divMNG_ITEM_NUM2.style.display = "none";
	document.all.divMNG_ITEM_NUM3.style.display = "none";
	document.all.divMNG_ITEM_NUM4.style.display = "none";
	document.all.divMNG_ITEM_DT1.style.display = "none";
	document.all.divMNG_ITEM_DT2.style.display = "none";
	document.all.divMNG_ITEM_DT3.style.display = "none";
	document.all.divMNG_ITEM_DT4.style.display = "none";
	document.all.divRESET_SLIPNO.style.display = "none";
	D_Div_ReadOnly(divSLIP_D, true);
	txtMAKE_SEQ.focus();

	cboSLIP_KIND_TAG.value = "G";
	//cboSLIP_KIND_TAG.disabled = true;
}
function	getGrpRange(curRow)
{
	var vBRAIN_GRP_SEQ = dsSLIP_D.NameString(curRow,"BRAIN_GRP_SEQ");
	var	lrRet = new LNumRange(0,0);
	
	for(var i = curRow ; i >= 1 ; --i)
	{
		if( vBRAIN_GRP_SEQ == dsSLIP_D.NameString(i,"BRAIN_GRP_SEQ") ) 
		{
			lrRet.StartRow = i;
		}
		else
		{
			break;
		}
	}
	var		vCount = dsSLIP_D.CountRow;
	for(var i = curRow ; i <= vCount ; ++i)
	{
		if( vBRAIN_GRP_SEQ == dsSLIP_D.NameString(i,"BRAIN_GRP_SEQ") ) 
		{
			lrRet.EndRow = i;
		}
		else
		{
			break;
		}
	}
	return lrRet;
}
function	getGrpRangeLast(curRow)
{
	var vBRAIN_GRP_SEQ = dsSLIP_D.NameString(curRow,"BRAIN_GRP_SEQ");
	var		vCount = dsSLIP_D.CountRow;
	var		vLastRow = 0;
	for(var i = curRow ; i <= vCount ; ++i)
	{
		if( vBRAIN_GRP_SEQ == dsSLIP_D.NameString(i,"BRAIN_GRP_SEQ") ) 
		{
			vLastRow = i;
		}
		else
		{
			break;
		}
	}
	return vLastRow;
}
function	syncVatDtImpl(curRow)
{
	var		lrRange = getGrpRange(curRow);
	if(lrRange.IsEmpty())
	{
		return;
	}
	var		lsVatDt = dsSLIP_D.NameString(curRow,"VAT_DT");
	for(var i = lrRange.StartRow ; i <= lrRange.EndRow ; ++ i)
	{
		if(dsSLIP_D.NameString(i,"MNG_NAME_DT1") == "계산서일자" || dsSLIP_D.NameString(i,"MNG_NAME_DT1") == "세금계산서일자")
		{
			dsSLIP_D.NameString(i,"MNG_ITEM_DT1") = lsVatDt;
		}
	}
}
function	syncVatDt(curRow)
{
	if(vatdtLOCK) return;
	vatdtLOCK = true;
	try
	{
		syncVatDtImpl(curRow);
	}
	catch(e)
	{
		alert(e.toString());
	}
	vatdtLOCK = false;
}

function	syncDeptCodeImpl(curRow)
{
	var		lrRange = getGrpRange(curRow);
	if(lrRange.IsEmpty())
	{
		return;
	}

	if(curRow!=lrRange.StartRow)
	{
		return;
	}

	var		lsDeptCode = dsSLIP_D.NameString(curRow,"DEPT_CODE");
	var		lsDeptName = dsSLIP_D.NameString(curRow,"DEPT_NAME");
	var		lsClassCode = dsSLIP_D.NameString(curRow,"CLASS_CODE");
	var		lsClassName = dsSLIP_D.NameString(curRow,"CLASS_CODE_NAME");

	for(var i = lrRange.StartRow ; i <= lrRange.EndRow ; ++ i)
	{
		dsSLIP_D.NameString(i,"DEPT_CODE")	= lsDeptCode;
		dsSLIP_D.NameString(i,"DEPT_NAME")	= lsDeptName;
		dsSLIP_D.NameString(i,"CLASS_CODE")			= lsClassCode;
		dsSLIP_D.NameString(i,"CLASS_CODE_NAME")	= lsClassName;
	}
}
function	syncDeptCode(curRow)
{
	if(deptcodeLOCK) return;
	deptcodeLOCK = true;
	try
	{
		syncDeptCodeImpl(curRow);
	}
	catch(e)
	{
		alert(e.toString());
	}
	deptcodeLOCK = false;
}
function MakeBrainDB_Equal_CR(curRow){
	var vBRAIN_GRP_SEQ = dsSLIP_D.NameString(curRow,"BRAIN_GRP_SEQ");
	var idx = 0;

	var first_Idx = 0;

	for (idx=1;idx<=dsSLIP_D.CountRow;idx++) { 
		if( vBRAIN_GRP_SEQ == dsSLIP_D.NameString(idx,"BRAIN_GRP_SEQ") ) {
			if( C_isNull(dsSLIP_D.NameString(idx,"RCPTBILL_CLS"))
				//&&
				//(dsSLIP_D.NameString(idx,"BRAIN_ACC_POSITION")=="D")
			) {
				first_Idx = idx;
				break;
			}
		}
	}
	if(first_Idx==0) return;

	var vSUPAMT = 0;
	var strSUPAMT = "0";

	// 부가세 계정찾아 1/10
	for (idx=first_Idx;idx<=dsSLIP_D.CountRow;idx++) {
		if( vBRAIN_GRP_SEQ == dsSLIP_D.NameString(idx,"BRAIN_GRP_SEQ") ) {

			if (!C_isNull(dsSLIP_D.NameString(idx,"RCPTBILL_CLS")))
			{
				if(curRow == idx) {
					dsSLIP_D.NameString(idx, "VATAMT") = SafeToInt(dsSLIP_D.NameString(idx,"DB_AMT")) + SafeToInt(dsSLIP_D.NameString(idx,"CR_AMT"));
					break;
				}

				var vVATAMT = 0;
				var strVATAMT = 0;
				
				if (dsSLIP_D.NameString(idx,"VATOCCUR_CLS") == "T")
				{
					vVATAMT = SafeToInt( ""+(vSUPAMT/10) );
					strVATAMT = C_toNumberFormatString(vVATAMT);
				} else {
					vVATAMT = 0;
					strVATAMT = C_toNumberFormatString(vVATAMT);
				}

				if( dsSLIP_D.NameString(idx,"BRAIN_ACC_POSITION") == "D" ) {
					dsSLIP_D.NameString(idx, "DB_AMT") = vVATAMT;
					dsSLIP_D.NameString(idx, "DB_AMT_D") = strVATAMT;

					dsSLIP_D.NameString(idx, "CR_AMT") = "0";
					dsSLIP_D.NameString(idx, "CR_AMT_D") = "0";

					dsSLIP_D.NameString(idx, "SUPAMT") = strSUPAMT;
					dsSLIP_D.NameString(idx, "VATAMT") = strVATAMT;
				} else {
					dsSLIP_D.NameString(idx, "DB_AMT") = "0";
					dsSLIP_D.NameString(idx, "DB_AMT_D") = "0";

					dsSLIP_D.NameString(idx, "CR_AMT") = vVATAMT;
					dsSLIP_D.NameString(idx, "CR_AMT_D") = strVATAMT;

					dsSLIP_D.NameString(idx, "SUPAMT") = strSUPAMT;
					dsSLIP_D.NameString(idx, "VATAMT") = strVATAMT;
				}
				break;
			} else {
				vSUPAMT = vSUPAMT + SafeToInt(dsSLIP_D.NameString(idx,"DB_AMT")) + SafeToInt(dsSLIP_D.NameString(idx,"CR_AMT"));
				strSUPAMT = C_toNumberFormatString(vSUPAMT);
			}
		}
	}

	var dbSum = 0;
	var crSum = 0;
	var eleCnt = 0;
	var last_Idx = 0;

	for (idx=1;idx<=dsSLIP_D.CountRow;idx++) {
		if( vBRAIN_GRP_SEQ == dsSLIP_D.NameString(idx,"BRAIN_GRP_SEQ") ) {
			dbSum = dbSum + dsSLIP_D.NameValue(idx, "DB_AMT");
			crSum = crSum + dsSLIP_D.NameValue(idx, "CR_AMT");

			eleCnt++;
			//if( dsSLIP_D.NameString(idx,"BRAIN_ACC_POSITION") == "C" ) {
				if(first_Idx==0) first_Idx = idx;
				last_Idx = idx;
			//}
		}
	}

	if(eleCnt == 1) return;
	if(last_Idx == curRow) return;

	dbSum = dbSum - dsSLIP_D.NameString(last_Idx, "DB_AMT");
	crSum = crSum - dsSLIP_D.NameString(last_Idx, "CR_AMT");
	if(dbSum>crSum) {
		dsSLIP_D.NameString(last_Idx, "DB_AMT") = "0";
		dsSLIP_D.NameString(last_Idx, "DB_AMT_D") = "0";
		dsSLIP_D.NameString(last_Idx, "CR_AMT") = dbSum-crSum;
		dsSLIP_D.NameString(last_Idx, "CR_AMT_D") = C_toNumberFormatString(dsSLIP_D.NameString(last_Idx, "CR_AMT"));
	} else {
		dsSLIP_D.NameString(last_Idx, "CR_AMT") = "0";
		dsSLIP_D.NameString(last_Idx, "CR_AMT_D") = "0";
		dsSLIP_D.NameString(last_Idx, "DB_AMT") = crSum-dbSum;
		dsSLIP_D.NameString(last_Idx, "DB_AMT_D") = C_toNumberFormatString(dsSLIP_D.NameString(last_Idx, "DB_AMT"));
	}
}

function MakeDB_Equal_CR(row){
	var dbSum = dsSLIP_D.NameSum("DB_AMT",0,0);
	var crSum = dsSLIP_D.NameSum("CR_AMT",0,0);
	dbSum = dbSum - dsSLIP_D.NameString(row, "DB_AMT");
	crSum = crSum - dsSLIP_D.NameString(row, "CR_AMT");
	if(dbSum>crSum) {
		dsSLIP_D.NameString(row, "DB_AMT") = "0";
		dsSLIP_D.NameString(row, "DB_AMT_D") = "0";
		dsSLIP_D.NameString(row, "CR_AMT") = dbSum-crSum;
		dsSLIP_D.NameString(row, "CR_AMT_D") = C_toNumberFormatString(dsSLIP_D.NameString(row, "CR_AMT"));
	} else {
		dsSLIP_D.NameString(row, "CR_AMT") = "0";
		dsSLIP_D.NameString(row, "CR_AMT_D") = "0";
		dsSLIP_D.NameString(row, "DB_AMT") = crSum-dbSum;
		dsSLIP_D.NameString(row, "DB_AMT_D") = C_toNumberFormatString(dsSLIP_D.NameString(row, "DB_AMT"));
	}
}

function document_onKeyDown(){
	if(event.ctrlLeft == true && event.shiftLeft == true && event.keyCode==68) {
		C_msgError(G_FocusDataset.ExportData(1, G_FocusDataset.CountRow, true),"확인")
	}
	else if(event.altLeft == true && event.keyCode==69) {
		if(dsSLIP_D.CountRow<2) return;
		if(!vUpdate) {
			C_msgOk("입력/수정 모드가 아닙니다.", "확인");
		}
		MakeDB_Equal_CR(dsSLIP_D.RowPosition);
		
		Input_Detail_Display();
		Input_Detail_Clear();
		Input_Color_ReadOnly();
		Input_Clear();
	}
	else if (event.ctrlLeft == true && event.shiftLeft == true && event.keyCode == 83)
	{
		var strSql = "";
		strSql += " -- 헤더조회쿼리 ( SLIP_ID = "+dsSLIP_H.NameString(dsSLIP_H.RowPosition, "SLIP_ID")+" )\n ";
		strSql += " \n";
		strSql += " Select	A.SLIP_ID , \n";
		strSql += " 		A.MAKE_SLIPCLS , \n";
		strSql += " 		A.MAKE_SLIPNO , \n";
		strSql += " 		A.MAKE_COMP_CODE , \n";
		strSql += " 		B.COMPANY_NAME , \n";
		strSql += " 		A.MAKE_DEPT_CODE , \n";
		strSql += " 		C.DEPT_NAME MAKE_DEPT_NAME , \n";
		strSql += " 		A.MAKE_DT , \n";
		strSql += " 		A.MAKE_DT_TRANS , \n";
		strSql += " 		A.MAKE_SEQ , \n";
		strSql += " 		A.INOUT_DEPT_CODE , \n";
		strSql += " 		D.DEPT_NAME  INOUT_DEPT_NAME , \n";
		strSql += " 		A.MAKE_PERS , \n";
		strSql += " 		A.MAKE_NAME , \n";
		strSql += " 		A.GROUPWARE_SLIPSTATUS , \n";
		strSql += " 		DECODE(A.KEEP_SLIPNO, NULL, 'F', 'T') KEEP_CLS , \n";
		strSql += " 		A.KEEP_SLIPNO , \n";
		strSql += " 		A.KEEP_DT , \n";
		strSql += " 		A.KEEP_DT_TRANS , \n";
		strSql += " 		A.KEEP_SEQ , \n";
		strSql += " 		A.KEEP_DEPT_CODE , \n";
		strSql += " 		E.DEPT_NAME KEEP_DEPT_NAME , \n";
		strSql += " 		A.KEEP_KEEPER , \n";
		strSql += " 		A.WORK_CODE , \n";
		strSql += " 		F.WORK_NAME , \n";
		strSql += " 		A.CHARGE_PERS , \n";
		strSql += " 		G.NAME CHARGE_PERS_NAME , \n";
		strSql += " 		A.SLIP_KIND_TAG , \n";
		strSql += " 		NVL(A.TRANSFER_TAG, 'F') TRANSFER_TAG, \n";
		strSql += " 		NVL(A.IGNORE_SET_RESET_TAG, 'F') IGNORE_SET_RESET_TAG, \n";
		strSql += " 		NVL(F.SLIP_UPDATE_CLS, 'T') SLIP_UPDATE_CLS \n";
		strSql += " From	T_ACC_SLIP_HEAD A, \n";
		strSql += " 		T_COMPANY B, \n";
		strSql += " 		T_DEPT_CODE C, \n";
		strSql += " 		T_DEPT_CODE D, \n";
		strSql += " 		T_DEPT_CODE E, \n";
		strSql += " 		T_WORK_CODE F, \n";
		strSql += " 		Z_AUTHORITY_USER G \n";
		strSql += " Where	A.MAKE_COMP_CODE = B.COMP_CODE \n";
		strSql += " And		A.MAKE_DEPT_CODE = C.DEPT_CODE \n";
		strSql += " And		A.INOUT_DEPT_CODE = D.DEPT_CODE(+) \n";
		strSql += " And		A.KEEP_DEPT_CODE = E.DEPT_CODE(+) \n";
		strSql += " And		A.WORK_CODE = F.WORK_CODE(+) \n";
		strSql += " And		A.CHARGE_PERS = G.EMPNO(+) \n";
		strSql += " And		A.SLIP_ID = "+dsSLIP_H.NameString(dsSLIP_H.RowPosition, "SLIP_ID");
		
		C_msgError(strSql, "전표조회 정보");
	}
}

//설정반제내역
function btnRESET_SLIP_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SLIP_ID", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_ID"));
	lrArgs.set("SLIP_IDSEQ", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_IDSEQ"));

	lrRet = C_LOV("T_SLIP_SEARCH_RESET", lrArgs, "T");

	if (lrRet == null) return;
	
	if (dsSLIP_D.IsUpdated || G_isChanged(dsSLIP_D.id))
	{
		var	vRet	= C_msgYesNoCancel("변경된 내용이 있습니다.<br><br>" + G_MSG_SAVE, "저장");
		if (vRet == "Y")
		{
			if(!btnsave_proc_onclick()) return;
		}
		else if (vRet == "C")
		{
			return;
		}
	}

	txtMAKE_COMP_CODE.value	= lrRet.get("MAKE_COMP_CODE");
	txtMAKE_DT.value		= lrRet.get("MAKE_DT");
	txtMAKE_DT_TRANS.value	= lrRet.get("MAKE_DT_TRANS");
	txtMAKE_SEQ.value		= lrRet.get("MAKE_SEQ");
	cboSLIP_KIND_TAG.value	= lrRet.get("SLIP_KIND_TAG");
	
	vMAKE_COMP_CODE			= lrRet.get("MAKE_COMP_CODE");
	vMAKE_DT_TRANS			= lrRet.get("MAKE_DT_TRANS");
	vMAKE_SEQ				= lrRet.get("MAKE_SEQ");
	vSLIP_KIND_TAG			= lrRet.get("SLIP_KIND_TAG");
	
	// G_Load(dsSLIP_H, null);
}

//설정반제내역
function btnBUDG_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("COMP_NAME", txtCOMP_NAME.value);
	lrArgs.set("DEPT_CODE", txtDEPT_CODE.value);
	lrArgs.set("DEPT_NAME", txtDEPT_NAME.value);
	lrArgs.set("BUDG_YM", txtMAKE_DT_TRANS.value.replace(/-/gi,"").substring(0,6));
	lrArgs.set("ACC_CODE", txtACC_CODE.value);
	lrArgs.set("ACC_NAME", txtACC_NAME.value);

	var	lrRet = window.showModalDialog(
		"t_PBudgRetrieve.jsp",
		lrArgs,
		"center:yes; dialogWidth:976px;	dialogHeight:623px;	status:no; help:no;	scroll:no"
	);
}

//전표출력
function btnSLIP_PRINT_onClick()
{
	// 공통 Check
	//if (!checkCommon()) return;
	if(dsSLIP_H.NameString(1, "SLIP_ID")=="0"||dsSLIP_H.NameString(1, "SLIP_ID")=="")
	{
		C_msgOk("전표조회상태가 아닙니다.<br>조회 후 다시 실행해 주십시오.", "확인");
		return;
	}

	var vTmp = "SLIP_ID:DECIMAL";
	dsMAIN.ClearAll();
	dsMAIN.SetDataHeader(vTmp);
	dsMAIN.AddRow();
	dsMAIN.NameString(1,"SLIP_ID") = dsSLIP_H.NameString(1, "SLIP_ID");

	transMAIN.Parameters = "ACT=SLIP_PRINT";
	G_saveData(dsMAIN);

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
	frmList.EXPORT_TAG.value = "P";
	frmList.RUN_TAG.value = "1";
	frmList.REQUEST_NAME.value = "";
	frmList.REPORT_NO.value = '--';
	frmList.REPORT_FILE_NAME.value = 'r_t_010005.rpt';
	
	
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
	
	//if (!S_Submit(document.all)) return;
	frmList.submit();
	//S_ObjectAllFormat(document.all);
	strTemp ="";
}

//전표복사
function btnSLIP_COPY_onClick()
{
	if (dsSLIP_H.CountRow == 0)
	{
		C_msgOk("먼저 새전표 생성후 전표복사를 하세요.", "확인");
		return;
	}
	
	if(txtKEEP_CLS.value == "확정") {
		C_msgOk("확정된 전표입니다.<br>수정하시려면 먼저 확정을 취소하셔야 합니다.", "확인");
		return;
	}
	
	if(dsSLIP_D.CountRow !=0) {
	
	   	Input_Error_Check();
	
		if (vError_Flag == 'T')
		{
			//C_msgOk("현재 라인에 필수항목이 입력되지 않았습니다.", "확인");
			vOBJ.focus();
			vError_Flag = "F";
			return;
		}
	}

	var lrArgs = new Array();
	var lsURL = "./t_PSlipCopyR.jsp";
	
	lrArgs.opener = window;
	//lrArgs.CompCode = txtMAKE_COMP_CODE.value;
	//lrArgs.CompName = txtCOMP_NAME.value;

	var vUpdateOrg = vUpdate;
	vUpdate = false;		
	var lsRtn = window.showModalDialog(lsURL, lrArgs, "center:yes; dialogWidth:920px; dialogHeight:500px; status:yes; help:no; scroll:no");
	if(lsRtn!=null) {
		//dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_REFUND_NO") = lsRtn.LOAN_NO;
		//dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_REFUND_NO_S") = lsRtn.LOAN_NO;
	}
	vUpdate = vUpdateOrg;
}

//전표확정
function btnSLIP_CONFIRM_onClick()
{
	if( !chkDayClose(true) ) return;
	
	if (dsSLIP_D.CountRow == 0)	return;
	
	if (dsSLIP_D.IsUpdated || G_isChanged(dsSLIP_D.id))
	{
		var	ret	= C_msgYesNoCancel("변경된 내용이 있습니다.\n\n" + G_MSG_SAVE, "저장");
		if (ret	== "Y")
		{
			if(!btnsave_proc_onclick()) return;
		}
		else if	(ret ==	"C")
		{
			return;
		}
	}

	var	myObject = new Object;
	myObject.window	= window;

	var	vSlipId			= dsSLIP_H.NameString(dsSLIP_H.RowPosition,"SLIP_ID");
	var	vMakeSlipNo		= dsSLIP_H.NameString(dsSLIP_H.RowPosition,"MAKE_SLIPNO");
	var	vMAKE_DT		= dsSLIP_H.NameString(dsSLIP_H.RowPosition,"MAKE_DT");

	var	arrRtn = window.showModalDialog(
		"t_PSlipConfR.jsp?TYPE=CONF_T"+
		"&SLIP_ID="+vSlipId+
		"&MAKE_SLIPNO="+vMakeSlipNo+
		"&MAKE_DT="+C_toDateFormatString(vMAKE_DT),
		myObject,
		"center:yes; dialogWidth:406px;	dialogHeight:255px;	status:no; help:no;	scroll:no"
	);
	
	if( (arrRtn==null) || (arrRtn.RESULT=="작업취소"))
	{
		//상단의 X버튼이 눌려진	경우..
		/*
		Value_Readonly(false);
		document.all.btnSLIP_SAVE.disabled		= false;
		document.all.btnSLIP_CONFIRM.disabled	= false;
		document.all.btnSLIP_CANCEL.disabled	= true;
		document.all.btnSLIP_DELETE.disabled	= false;
		document.all.btnSLIP_GROUPWARE.disabled	= false;
		return;
		*/
	}
	else if(arrRtn.RESULT=="확정완료")
	{
		//정상처리되었을 경우..
		//txtKEEP_DT.value  =	arrRtn.KEEP_DT.replace(/-/gi,"");
		btnquery_onclick();
	}
}

//전표확정취소
function btnSLIP_CANCEL_onClick()
{
	if( !chkDayClose(true) ) return;
	
	if (dsSLIP_D.CountRow == 0)	return;
	
	if (dsSLIP_D.IsUpdated || G_isChanged(dsSLIP_D.id))
	{
		var	ret	= C_msgYesNoCancel("변경된 내용이 있습니다.\n\n" + G_MSG_SAVE, "저장");
		if (ret	== "Y")
		{
			if(!btnsave_proc_onclick()) return;;
		}
		else if	(ret ==	"C")
		{
			return;
		}
	}

	var	myObject = new Object;
	myObject.window	= window;

	var	vSlipId			= dsSLIP_H.NameString(dsSLIP_H.RowPosition,"SLIP_ID");
	var	vMakeSlipNo		= dsSLIP_H.NameString(dsSLIP_H.RowPosition,"MAKE_SLIPNO");
	var	vKEEP_DT		= dsSLIP_H.NameString(dsSLIP_H.RowPosition,"KEEP_DT_TRANS");

	var	arrRtn = window.showModalDialog(
		"t_PSlipConfR.jsp?TYPE=CONF_F"+
		"&SLIP_ID="+vSlipId+
		"&MAKE_SLIPNO="+vMakeSlipNo+
		"&MAKE_DT="+C_toDateFormatString(vKEEP_DT),
		myObject,
		"center:yes; dialogWidth:406px;	dialogHeight:255px;	status:no; help:no;	scroll:no"
	);
	
	if( (arrRtn==null) || (arrRtn.RESULT=="작업취소"))
	{
		//상단의 X버튼이 눌려진	경우..
		/*
		Value_Readonly(false);
		document.all.btnSLIP_SAVE.disabled		= false;
		document.all.btnSLIP_CONFIRM.disabled	= false;
		document.all.btnSLIP_CANCEL.disabled	= true;
		document.all.btnSLIP_DELETE.disabled	= false;
		document.all.btnSLIP_GROUPWARE.disabled	= false;
		return;
		*/
	}
	else if(arrRtn.RESULT=="확정취소")
	{
		//정상처리되었을 경우..
		//txtKEEP_DT.value  =	arrRtn.KEEP_DT.replace(/-/gi,"");
		btnquery_onclick();
	}
}

//라인추가
function btnDETAIL_ADD_onClick()
{
	if (dsSLIP_H.CountRow == 0)
	{
		C_msgOk("먼저 새전표 생성후 라인추가를 하세요.", "확인");
		return;
	}
	
	if (dsSLIP_D.CountRow != 0)
	{
		Input_Error_Check();
	
		if (vError_Flag == 'T')
		{
			vOBJ.focus();
			vError_Flag = "F";
			return;
		}
	}
	
	G_addRow(dsSLIP_D);
	txtACC_CODE.focus();
	
	if(dsSLIP_D.RowPosition == 1) {
		if( dsSLIP_H.NameString(dsSLIP_H.CountRow, "MAKE_SLIPCLS") == "2" ) {
			// 전표구분 현금
			txtACC_CODE_F.value = "";
			txtACC_CODE.value = vCashAccCode;
			txtACC_CODE_onblur();
			txtSUMMARY1.value = "현금";
			btnDETAIL_ADD_onClick();
		}
	}
	
}

//라인삽입
function btnDETAIL_INSERT_onClick()
{
	if (dsSLIP_H.CountRow == 0)
	{
		C_msgOk("먼저 새전표 생성후 라인삽입를 하세요.", "확인");
		return;
	}
	
	if (dsSLIP_D.CountRow != 0)
	{
		Input_Error_Check();
	
		if (vError_Flag == 'T')
		{
			vOBJ.focus();
			vError_Flag = "F";
			return;
		}
	}

	if(dsSLIP_D.RowPosition == 1) {
		if( dsSLIP_H.NameString(dsSLIP_H.CountRow, "MAKE_SLIPCLS") == "2" ) {
			C_msgOk("현금전표의 첫라인에 삽입할 수 없습니다.", "확인");
			return;
		}
	}

	var vSelectBrainGrpSeq = dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_GRP_SEQ");

	if( vSelectBrainGrpSeq == "" || vSelectBrainGrpSeq == "0" ) {
		G_insertRow(dsSLIP_D, dsSLIP_D.RowPosition);
	} else {
		for (i=1;i<=dsSLIP_D.CountRow;i++) {
			if(dsSLIP_D.NameString(i, "BRAIN_GRP_SEQ") == vSelectBrainGrpSeq){
				G_insertRow(dsSLIP_D, i);
				break;
			}
		}
	}

	txtACC_CODE.focus();	
}

//라인복사
function btnDETAIL_COPY_onClick()
{
	var i = 0;
	var j = 0;
	
	if(dsSLIP_D.CountRow==0) return;
	
	if (dsSLIP_D.CountRow != 0)
	{
		Input_Error_Check();
	
		if (vError_Flag == 'T')
		{
			vOBJ.focus();
			vError_Flag = "F";
			return;
		}
	}

	if(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_REPEAT_CLS")=='T') {
		if(bRowPosChangging == true) return;
		bRowPosChangging = true;
		var vUpdateOrg = vUpdate;
		vUpdate = false;

		var vBRAIN_GRP_SEQ = dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_GRP_SEQ");
		G_insertRow(dsSLIP_D, dsSLIP_D.RowPosition+1);
		// G_insertRow시 새로 삽입된 행으로 입력포커스가 바뀜
		AccSlipDataCopy(dsSLIP_D, dsSLIP_D.RowPosition-1, dsSLIP_D, dsSLIP_D.RowPosition);
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_GRP_SEQ") = vBRAIN_GRP_SEQ;

		Remake_BRAIN_SORT_SEQ(vBRAIN_GRP_SEQ);

		var idx = 0;
		for (idx=1;idx<=dsSLIP_D.CountRow;idx++) { 
			if( vBRAIN_GRP_SEQ == dsSLIP_D.NameString(idx,"BRAIN_GRP_SEQ") ) {
				if( C_isNull(dsSLIP_D.NameString(idx,"RCPTBILL_CLS")) ) {
					MakeBrainDB_Equal_CR(idx);
					break;
				}
			}
		}

		bRowPosChangging = false;
		vUpdate = vUpdateOrg;

		Input_Detail_Display();
		Input_Detail_Clear();
		Input_Color_ReadOnly();
		Input_Clear();
		return;
	}

	// 표준적요 라인
	var arSelectBrainGrpSeq = new Array();
	var arSelectBrainRow = new Array();
	// 일반라인	
	var arSelectRow = new Array();
	
	for (i=1;i<=dsSLIP_D.CountRow;i++) {
		if( dsSLIP_D.RowMark(i) == 1 ) {
			if(dsSLIP_D.NameString(i, "BRAIN_GRP_SEQ") != ""){
				// 표준적요 그룹번호 추출
				if( arSelectBrainGrpSeq.length == 0 ) {
					arSelectBrainGrpSeq.push(dsSLIP_D.NameString(i, "BRAIN_GRP_SEQ"));
				} 
				else if( arSelectBrainGrpSeq[arSelectBrainGrpSeq.length-1]!=dsSLIP_D.NameString(i, "BRAIN_GRP_SEQ") )
				{
					arSelectBrainGrpSeq.push(dsSLIP_D.NameString(i, "BRAIN_GRP_SEQ"));
				}
			} else {
				// 일반라인
				arSelectRow.push(i);
			}
		}
	}

	var vBrainGrpSeq = 0;

	for(i=0;i<arSelectBrainGrpSeq.length;i++){
		vBrainGrpSeq = arSelectBrainGrpSeq[i];
		for (j=1;j<=dsSLIP_D.CountRow;j++) {
			if( vBrainGrpSeq==dsSLIP_D.NameString(j, "BRAIN_GRP_SEQ") ) {
				arSelectBrainRow.push(j);
			}
		}
	}

	if(bRowPosChangging == true) return;
	bRowPosChangging = true;
	var vUpdateOrg = vUpdate;
	vUpdate = false;

	var orgIdx = 0;
	var curIdx = 0;

	// 표준적요라인 복사
	for(i=0;i<arSelectBrainRow.length;i++){
		G_addRow(dsSLIP_D);
		orgIdx = arSelectBrainRow[i];
		curIdx = dsSLIP_D.RowPosition;
		// AccSlipDataCopy(formDS, fromROW, toDS, toROW)
		AccSlipDataCopy(dsSLIP_D, orgIdx, dsSLIP_D, curIdx);
		// 표준적요 그룹번호 가져오기
		if( orgIdx == 1 ) {
			G_Load(dsBRAIN_GRP_SEQ, null);
		} 
		else if( dsSLIP_D.NameString(orgIdx-1, "BRAIN_GRP_SEQ")!=dsSLIP_D.NameString(orgIdx, "BRAIN_GRP_SEQ") )
		{
			G_Load(dsBRAIN_GRP_SEQ, null);
		}

		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_GRP_SEQ") = dsBRAIN_GRP_SEQ.NameString(dsBRAIN_GRP_SEQ.RowPosition, "BRAIN_GRP_SEQ");
	}

	// 일반라인 복사
	for(i=0;i<arSelectRow.length;i++){
		G_addRow(dsSLIP_D);
		orgIdx = arSelectRow[i];
		curIdx = dsSLIP_D.RowPosition;
		// AccSlipDataCopy(formDS, fromROW, toDS, toROW)
		AccSlipDataCopy(dsSLIP_D, orgIdx, dsSLIP_D, curIdx);
	}
	bRowPosChangging = false;
	vUpdate = vUpdateOrg;
		
	Input_Detail_Display();
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	
	//txtACC_CODE.focus();
}

function AccSlipDataCopy(formDS, fromROW, toDS, toROW){
	for(i=1;i<=toDS.CountColumn;i++) {
		var colName = toDS.ColumnID(i);
		if(colName == "SLIP_ID") continue;
		if(colName == "SLIP_IDSEQ") continue;
		if(colName == "MAKE_SLIPLINE") continue;

		if(colName == "BRAIN_GRP_SEQ") continue;
		//if(colName == "BRAIN_SLIP_NAME") continue;
		//if(colName == "BRAIN_SLIP_SEQ1") continue;
		//if(colName == "BRAIN_SLIP_SEQ2") continue;
		//if(colName == "BRAIN_SLIP_LINE") continue;
		//if(colName == "BRAIN_SORT_SEQ") continue;
		//if(colName == "BRAIN_ACC_POSITION") continue;
		//if(colName == "BRAIN_REPEAT_CLS") continue;
		//if(colName == "BRAIN_DEL_CLS") continue;

		//if(colName == "TAX_COMP_CODE") continue;
		//if(colName == "COMP_CODE") continue;

		//if(colName == "DEPT_CODE") continue;
		//if(colName == "DEPT_NAME") continue;

		//if(colName == "CLASS_CODE") continue;
		//if(colName == "CLASS_CODE_NAME") continue;
		
		if(colName == "RESET_SLIP_ID") continue;
		if(colName == "RESET_SLIP_IDSEQ") continue;
		if(colName == "RESET_SLIPNO") continue;
		
		//당좌		
		if(colName == "CHK_NO") continue;
		if(colName == "CHK_PUBL_DT") continue;
		
		//지급어음		
		if(colName == "BILL_NO") continue;
		if(colName == "BILL_NO_S") continue;
		if(colName == "BILL_PUBL_DT") continue;
		if(colName == "BILL_EXPR_DT") continue;
		
		if(colName == "BILL_NO_R") continue;
		if(colName == "BILL_PUBL_DT_R") continue;
		if(colName == "BILL_EXPR_DT_R") continue;
		if(colName == "BILL_CHG_EXPR_DT_R") continue;
		
		//받을어음
		if(colName == "REC_BILL_NO") continue;
		if(colName == "REC_BILL_NO_S") continue;
		if(colName == "REC_BILL_PUBL_DT") continue;
		if(colName == "REC_BILL_EXPR_DT") continue;
		
		if(colName == "REC_BILL_NO_R") continue;
		if(colName == "REC_BILL_PUBL_DT_R") continue;
		if(colName == "REC_BILL_EXPR_DT_R") continue;
		if(colName == "REC_BILL_PUBL_AMT_R") continue;
		
		//CP설정
		if(colName == "CP_NO") continue;
		if(colName == "CP_NO_S") continue;
		if(colName == "CP_BUY_PUBL_DT") continue;		
		if(colName == "CP_BUY_EXPR_DT") continue;		
		if(colName == "CP_BUY_DUSE_DT") continue;
		if(colName == "CP_BUY_PUBL_AMT") continue;		
		if(colName == "CP_BUY_INCOME_AMT") continue;		
		if(colName == "CP_BUY_PUBL_PLACE") continue;		
		if(colName == "CP_BUY_PUBL_NAME") continue;		
		if(colName == "CP_BUY_INTR_RAT") continue;		
		if(colName == "CP_BUY_CUST_SEQ") continue;		
		if(colName == "CP_BUY_CUST_CODE") continue;		
		if(colName == "CP_BUY_CUST_NAME") continue;	
		
		//CP반제		
		if(colName == "CP_NO_R") continue;
		if(colName == "CP_BUY_PUBL_DT_R") continue;		
		if(colName == "CP_BUY_EXPR_DT_R") continue;		
		if(colName == "CP_BUY_DUSE_DT_R") continue;
		if(colName == "CP_BUY_PUBL_AMT_R") continue;		
		if(colName == "CP_BUY_INCOME_AMT_R") continue;		
		if(colName == "CP_BUY_PUBL_PLACE_R") continue;		
		if(colName == "CP_BUY_PUBL_NAME_R") continue;		
		if(colName == "CP_BUY_INTR_RAT_R") continue;		
		if(colName == "CP_BUY_CUST_SEQ_R") continue;		
		if(colName == "CP_BUY_CUST_CODE_R") continue;		
		if(colName == "CP_BUY_CUST_NAME_R") continue;		
		if(colName == "CP_BUY_RESET_AMT_R") continue;
		
		//유가증권	
		if(colName == "SECU_NO") continue;
		if(colName == "SECU_REAL_SECU_NO") continue;
		if(colName == "SECU_NO_S") continue;
		if(colName == "SECU_REAL_SECU_NO_S") continue;
		if(colName == "SECU_SEC_KIND_CODE") continue;
		if(colName == "SECU_GET_DT") continue;
		if(colName == "SECU_GET_PLACE") continue;
		if(colName == "SECU_PERSTOCK_AMT") continue;
		if(colName == "SECU_INCOME_AMT") continue;
		if(colName == "SECU_BF_GET_ITR_AMT") continue;
		if(colName == "SECU_GET_ITR_AMT") continue;
		if(colName == "SECU_PUBL_DT") continue;
		if(colName == "SECU_ITR_TAG") continue;
		if(colName == "SECU_EXPR_DT") continue;
		if(colName == "SECU_INTR_RATE") continue;
		
		//유가증권 반제
		if(colName == "SECU_NO_R") continue;
		if(colName == "SECU_REAL_SECU_NO_R") continue;
		if(colName == "SECU_PERSTOCK_AMT_R") continue;
		if(colName == "SECU_PUBL_DT_R") continue;
		if(colName == "SECU_EXPR_DT_R") continue;
		if(colName == "SECU_INTR_RATE_R") continue;
		if(colName == "SECU_SALE_AMT_R") continue;
		if(colName == "SECU_SALE_DT_R") continue;
		if(colName == "SECU_RETURN_DT_R") continue;
		if(colName == "SECU_CONSIGN_BANK_R") continue;
		if(colName == "SECU_SALE_ITR_AMT_R") continue;
		if(colName == "SECU_SALE_TAX_R") continue;
		if(colName == "SECU_SALE_LOSS_R") continue;
		if(colName == "SECU_SALE_NP_ITR_AMT_R") continue;

		//차입
		if(colName == "LOAN_REFUND_NO") continue;
		if(colName == "LOAN_REFUND_SEQ") continue;
						
		if(colName == "LOAN_REFUND_NO_S") continue;
		if(colName == "LOAN_REFUND_SEQ_S") continue;
		if(colName == "LOAN_REAL_LOAN_NO") continue;
		if(colName == "LOAN_NAME") continue;
		if(colName == "LOAN_KIND_CODE") continue;
		if(colName == "LOAN_EXPR_DT") continue;
		if(colName == "LOAN_FDT") continue;

		//차입상환						
		if(colName == "LOAN_REFUND_NO_R") continue;
		if(colName == "LOAN_REFUND_SEQ_R") continue;
		if(colName == "LOAN_REAL_LOAN_NO_R") continue;
		if(colName == "LOAN_NAME_R") continue;
		if(colName == "LOAN_KIND_CODE_R") continue;
		if(colName == "LOAN_EXPR_DT_R") continue;
		if(colName == "LOAN_FDT_R") continue;

		//차입이자						
		if(colName == "LOAN_REFUND_NO_I") continue;
		if(colName == "LOAN_REFUND_SEQ_I") continue;
		if(colName == "LOAN_REAL_LOAN_NO_I") continue;
		if(colName == "LOAN_NAME_I") continue;
		if(colName == "LOAN_KIND_CODE_I") continue;
		if(colName == "LOAN_EXPR_DT_I") continue;
		if(colName == "LOAN_FDT_I") continue;

		//적금
		if(colName == "DEPOSIT_ACCNO") continue;
		if(colName == "PAYMENT_SEQ") continue;
		if(colName == "PAYMENT_SCH_DT") continue;
		if(colName == "PAYMENT_SCH_AMT") continue;
		if(colName == "PAYMENT_DT") continue;
		if(colName == "PAYMENT_AMT") continue;

		//고정자산
		if(colName == "FIX_ASSET_SEQ") continue;
		if(colName == "FIX_ASSET_MNG_NO") continue;
		if(colName == "FIX_GET_DT") continue;
		if(colName == "FIX_ASSET_NAME") continue;
		if(colName == "FIX_ASSET_SIZE") continue;
		if(colName == "FIX_PRODUCTION") continue;
		if(colName == "FIX_CUST_NAME") continue;
		if(colName == "FIX_MNG_DEPT_NAME") continue;
		if(colName == "FIX_DEPT_NAME") continue;

		// 현금영수증
		if(colName == "CASH_SEQ") continue;
		if(colName == "CASH_CASHNO") continue;                     
		if(colName == "CASH_USE_DT") continue;
		if(colName == "CASH_TRADE_AMT") continue;
		if(colName == "CASH_REQ_TG") continue;
		
		// 신용카드                                                                     
		if(colName == "CARD_SEQ") continue;                     
		if(colName == "CARD_CARDNO") continue;                     
		if(colName == "CARD_USE_DT") continue;                     
		if(colName == "CARD_HAVE_PERS") continue;                                    
		if(colName == "CARD_TRADE_AMT") continue;                    
		if(colName == "CARD_REQ_TG") continue;
		
		toDS.NameString(toROW, colName) = formDS.NameString(fromROW, colName);
	}

	//잔액관리설정
	if ((toDS.NameString(toROW,"ACC_REMAIN_MNG") == "T") && (IsValidAccThisSideCurrent()))
	{
		txtRESET_SLIPNO.value = txtMAKE_SLIPNO.value+"-"+txtMAKE_SLIPLINE.value;
		toDS.NameString(toROW, "RESET_SLIP_ID")		= toDS.NameString(toROW, "SLIP_ID");
		toDS.NameString(toROW, "RESET_SLIP_IDSEQ")	= toDS.NameString(toROW, "SLIP_IDSEQ");
		//alert(txtRESET_SLIPNO.value);
	}
}

//라인삭제
function btnDETAIL_DELETE_onClick()
{
	if( dsSLIP_H.NameString(dsSLIP_H.CountRow, "MAKE_SLIPCLS") == "2" && dsSLIP_D.RowPosition == 1 )
	{
		C_msgOk("현금전표의 현금라인은 삭제할 수 없습니다.", "확인");
		return false;
	}

	if(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_DEL_CLS")=='T') {
		if(bRowPosChangging == true) return;
		bRowPosChangging = true;
		var vUpdateOrg = vUpdate;
		vUpdate = false;

		var vBRAIN_GRP_SEQ = dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_GRP_SEQ");
		G_deleteRow(dsSLIP_D, dsSLIP_D.RowPosition);

		Remake_BRAIN_SORT_SEQ(vBRAIN_GRP_SEQ);
		Make_Slipline();

		var idx = 0;
		for (idx=1;idx<=dsSLIP_D.CountRow;idx++) { 
			if( vBRAIN_GRP_SEQ == dsSLIP_D.NameString(idx,"BRAIN_GRP_SEQ") ) {
				if( C_isNull(dsSLIP_D.NameString(idx,"RCPTBILL_CLS")) ) {
					MakeBrainDB_Equal_CR(idx);
					break;
				}
			}
		}

		bRowPosChangging = false;
		vUpdate = vUpdateOrg;

		Input_Detail_Display();
		Input_Detail_Clear();
		Input_Color_ReadOnly();
		Input_Clear();
		return;
	}

	// 표준적요 라인
	var arSelectBrainGrpSeq = new Array();
	var arSelectBrainRow = new Array();
	// 일반라인	
	var arSelectRow = new Array();
	
	for (i=1;i<=dsSLIP_D.CountRow;i++) {
		if( dsSLIP_D.RowMark(i) == 1 ) {
			if(dsSLIP_D.NameString(i, "BRAIN_GRP_SEQ") != ""){
				// 표준적요 그룹번호 추출
				if( arSelectBrainGrpSeq.length == 0 ) {
					arSelectBrainGrpSeq.push(dsSLIP_D.NameString(i, "BRAIN_GRP_SEQ"));
				} 
				else if( arSelectBrainGrpSeq[arSelectBrainGrpSeq.length-1]!=dsSLIP_D.NameString(i, "BRAIN_GRP_SEQ") )
				{
					arSelectBrainGrpSeq.push(dsSLIP_D.NameString(i, "BRAIN_GRP_SEQ"));
				}
			} else {
				// 일반라인
				arSelectRow.push(i);
			}
		}
	}

	var vBrainGrpSeq = 0;

	for(i=0;i<arSelectBrainGrpSeq.length;i++){
		vBrainGrpSeq = arSelectBrainGrpSeq[i];
		for (j=1;j<=dsSLIP_D.CountRow;j++) {
			if( vBrainGrpSeq==dsSLIP_D.NameString(j, "BRAIN_GRP_SEQ") ) {
				arSelectBrainRow.push(j);
			}
		}
	}

	bRowPosChangging = true;
	var vUpdateOrg = vUpdate;
	vUpdate = false;

	// 표준적요 라인 삭제	
	for(i=(arSelectBrainRow.length-1);i>=0;i--){
		G_deleteRow(dsSLIP_D, arSelectBrainRow[i]);
	}

	// 일반라인	삭제
	for(i=(arSelectRow.length-1);i>=0;i--){
		if( dsSLIP_H.NameString(dsSLIP_H.CountRow, "MAKE_SLIPCLS") == "2" && arSelectRow[i] == 1 )
		{
			C_msgOk("현금전표의 현금라인은 삭제할 수 없습니다.", "확인");
			continue;
		}
		G_deleteRow(dsSLIP_D, arSelectRow[i]);
	}

	Make_Slipline();

	bRowPosChangging = false;
	vUpdate = vUpdateOrg;

	Input_Detail_Display();
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "MAKE_DT")
	{
		txtMAKE_DT_TRANS.value = asDate.replace(/-/gi,"");
		txtMAKE_DT.value = asDate;
	}
	else if (asCalendarID == "VAT_DT")
	{
		txtVAT_DT.value = asDate;
	}
	else if (asCalendarID == "CHK_PUBL_DT")
	{
		txtCHK_PUBL_DT.value = asDate;
	}
	else if (asCalendarID == "CHK_COLL_DT")
	{
		txtCHK_COLL_DT.value = asDate;
	}
	else if (asCalendarID == "BILL_PUBL_DT")
	{
		txtBILL_PUBL_DT.value = asDate;
	}
	else if (asCalendarID == "BILL_EXPR_DT")
	{
		txtBILL_EXPR_DT.value = asDate;
	}
	else if (asCalendarID == "BILL_COLL_DT_R")
	{
		txtBILL_COLL_DT_R.value = asDate;
	}
	else if (asCalendarID == "REC_BILL_PUBL_DT")
	{
		txtREC_BILL_PUBL_DT.value = asDate;
	}
	else if (asCalendarID == "REC_BILL_EXPR_DT")
	{
		txtREC_BILL_EXPR_DT.value = asDate;
	}
	
	else if (asCalendarID == "REC_BILL_DISH_DT_R")
	{
		txtREC_BILL_DISH_DT_R.value = asDate;
	}
	
	else if (asCalendarID == "REC_BILL_TRUST_DT_R")
	{
		txtREC_BILL_TRUST_DT_R.value = asDate;
	}
	
	else if (asCalendarID == "REC_BILL_DISC_DT_R")
	{
		txtREC_BILL_DISC_DT_R.value = asDate;
	}

	else if (asCalendarID == "SECU_GET_DT")
	{
		txtSECU_GET_DT.value = asDate;
	}
	else if (asCalendarID == "SECU_PUBL_DT")
	{
		txtSECU_PUBL_DT.value = asDate;
	}
	else if (asCalendarID == "SECU_EXPR_DT")
	{
		txtSECU_EXPR_DT.value = asDate;
	}
	else if (asCalendarID == "SECU_SALE_DT_R")
	{
		txtSECU_SALE_DT_R.value = asDate;
	}
	else if (asCalendarID == "SECU_RETURN_DT_R")
	{
		txtSECU_RETURN_DT_R.value = asDate;
	}
	else if (asCalendarID == "LOAN_TRANS_DT")
	{
		txtLOAN_TRANS_DT.value = asDate;
	}
	else if (asCalendarID == "LOAN_TRANS_DT_R")
	{
		txtLOAN_TRANS_DT_R.value = asDate;
	}
	else if (asCalendarID == "LOAN_REFUND_SCH_DT_R")
	{
		txtLOAN_REFUND_SCH_DT_R.value = asDate;
	}
	else if (asCalendarID == "LOAN_REFUND_DT_R")
	{
		txtLOAN_REFUND_DT_R.value = asDate;
	}
	else if (asCalendarID == "PAYMENT_DT")
	{
		txtPAYMENT_DT.value = asDate;
	}
	else if (asCalendarID == "PAY_CON_BILL_DT")
	{
		txtPAY_CON_BILL_DT.value = asDate;
	}
	
	else if (asCalendarID == "CP_BUY_PUBL_DT")
	{
		txtCP_BUY_PUBL_DT.value = asDate;
	}
	
	else if (asCalendarID == "CP_BUY_EXPR_DT")
	{
		txtCP_BUY_EXPR_DT.value = asDate;
	}
	
	else if (asCalendarID == "CP_BUY_DUSE_DT")
	{
		txtCP_BUY_DUSE_DT.value = asDate;
	}

	else if (asCalendarID == "ANTICIPATION_DT")
	{
		txtANTICIPATION_DT.value = asDate;
	}
	
	else if (asCalendarID == "CASH_USE_DT")
	{
		txtCASH_USE_DT.value = asDate;
	}
	
	else if (asCalendarID == "CARD_USE_DT")
	{
		txtCARD_USE_DT.value = asDate;
	}
	
	else if (asCalendarID == "MNG_ITEM_DT1")
	{
		txtMNG_ITEM_DT1.value = asDate;
	}

	else if (asCalendarID == "MNG_ITEM_DT22")
	{
		txtMNG_ITEM_DT2.value = asDate;
	}

	else if (asCalendarID == "MNG_ITEM_DT3")
	{
		txtMNG_ITEM_DT3.value = asDate;
	}

	else if (asCalendarID == "MNG_ITEM_DT4")
	{
		txtMNG_ITEM_DT4.value = asDate;
	}

}

function LovRetrunBefore(asLovNameID, asCtrl, lrArgs)
{
	var rtnMsg = null;
	if (asLovNameID == "T_DEPT_CODE3")
	{
		if( asCtrl == btnINOUT_DEPT_CODE )
		{
			//rtnMsg가 null이 아니면 팝업이 닫히지 않는다.
			//rtnMsg = "T_DEPT_CODE3 : LovRetrunBefore(...) 테스트입니다.";
		}
	}
	
	else if (asLovNameID == "T_DEPT_CODE4")
	{
		if( asCtrl == null )
		{
			//rtnMsg가 null이 아니면 팝업이 닫히지 않는다.
			//rtnMsg = "T_DEPT_CODE4 : LovRetrunBefore(...) 테스트입니다.";
		}
	}
	
	else if (asLovNameID == "T_ACC_SLIP_REMAIN01")
	{
		if( asCtrl == btnRESET_SLIPNO )
		{
			//rtnMsg가 null이 아니면 팝업이 닫히지 않는다.
			var vSLIP_AMT = SafeToInt(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DB_AMT")) + SafeToInt(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CR_AMT"));
	
			if(vSLIP_AMT>parseInt(lrArgs.get("JAN_AMT"))) {
				rtnMsg = "반제전표 금액이 설정전표 잔액을 초과하여 선택할 수 없습니다.";
			}
		}
	}
	else if (asLovNameID == "T_ACC_SLIP_REMAIN02")
	{
		if( asCtrl == btnRESET_SLIPNO )
		{
			//rtnMsg가 null이 아니면 팝업이 닫히지 않는다.
			var vSLIP_AMT = SafeToInt(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DB_AMT")) + SafeToInt(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CR_AMT"));
	
			if(vSLIP_AMT>parseInt(lrArgs.get("JAN_AMT"))) {
				rtnMsg = "반제전표 금액이 설정전표 잔액을 초과하여 선택할 수 없습니다.";
			}
		}
	}
	
	// rtnMsg이 null이면 팝업 정상종료..
	return rtnMsg;
}

function	OnFail(dataset, trans, msg)
{
	C_msgOk(msg);
	var		lsLineNoTitle = "라인번호 :";
	var		liLinePos1 = msg.indexOf(lsLineNoTitle)+lsLineNoTitle.length;
	if(liLinePos1 > 0)
	{
		var		liLinePos2 = msg.indexOf("<br>",liLinePos1);
		var		liGoToLine = C_convSafeFloat(msg.substring(liLinePos1,liLinePos2));
		if(liGoToLine > 0 )
		{
			dsSLIP_D.RowPosition = liGoToLine;
		}
	}
}

function OnLoadCompleted(dataset, rowcnt)
{
	if (dataset == dsSLIP_H)
	{
		if (dsSLIP_H.CountRow != 0)
		{
			txtMAKE_COMP_CODE.value		= dsSLIP_H.NameString(dsSLIP_H.RowPosition, "MAKE_COMP_CODE");
			txtMAKE_COMP_CODE_F.value	= dsSLIP_H.NameString(dsSLIP_H.RowPosition, "MAKE_COMP_CODE");
			txtMAKE_DT.value			= dsSLIP_H.NameString(dsSLIP_H.RowPosition, "MAKE_DT");
			txtMAKE_DT_TRANS_F.value	= dsSLIP_H.NameString(dsSLIP_H.RowPosition, "MAKE_DT_TRANS");
			txtMAKE_DT_TRANS.value		= dsSLIP_H.NameString(dsSLIP_H.RowPosition, "MAKE_DT_TRANS");
			txtMAKE_SEQ_F.value			= dsSLIP_H.NameString(dsSLIP_H.RowPosition, "MAKE_SEQ");
			txtMAKE_SEQ.value			= dsSLIP_H.NameString(dsSLIP_H.RowPosition, "MAKE_SEQ");
			cboSLIP_KIND_TAG.value		= dsSLIP_H.NameString(dsSLIP_H.RowPosition, "SLIP_KIND_TAG");
			txtINOUT_DEPT_CODE.value	= dsSLIP_H.NameString(dsSLIP_H.RowPosition, "INOUT_DEPT_CODE");
			txtINOUT_DEPT_NAME.value	= dsSLIP_H.NameString(dsSLIP_H.RowPosition, "INOUT_DEPT_NAME");
			txtWORK_NAME.value			= dsSLIP_H.NameString(dsSLIP_H.RowPosition, "WORK_NAME");
			cboMAKE_SLIPCLS.value		= dsSLIP_H.NameString(dsSLIP_H.RowPosition, "MAKE_SLIPCLS");
			txtCOMPANY_NAME.value		= dsSLIP_H.NameString(dsSLIP_H.RowPosition, "COMPANY_NAME");
			txtMAKE_DEPT_CODE.value		= dsSLIP_H.NameString(dsSLIP_H.RowPosition, "MAKE_DEPT_CODE");
			txtMAKE_DEPT_NAME.value		= dsSLIP_H.NameString(dsSLIP_H.RowPosition, "MAKE_DEPT_NAME");
			txtMAKE_PERS.value			= dsSLIP_H.NameString(dsSLIP_H.RowPosition, "MAKE_PERS");
			txtMAKE_NAME.value			= dsSLIP_H.NameString(dsSLIP_H.RowPosition, "MAKE_NAME");
			txtMAKE_SLIPNO.value		= dsSLIP_H.NameString(dsSLIP_H.RowPosition, "MAKE_SLIPNO");
			if (dsSLIP_H.NameString(dsSLIP_H.RowPosition, "KEEP_CLS") == "T")
			{
				txtKEEP_CLS.value		= "확정";
			}
			else
			{
				txtKEEP_CLS.value		= "미확정";
			}
			
			txtCHARGE_PERS.value		= dsSLIP_H.NameString(dsSLIP_H.RowPosition, "CHARGE_PERS");
			txtCHARGE_PERS_NAME.value	= dsSLIP_H.NameString(dsSLIP_H.RowPosition, "CHARGE_PERS_NAME");
			
			Confirm_Trans_Button();
			
			if( (vMAKE_COMP_CODE != "")&&(vMAKE_DT_TRANS!="") ) {
				// 최초에 vMAKE_COMP_CODE, vMAKE_DT_TRANS의 값이 세팅이 안된 상태로 호출될 때는 체크하지 않는다.
				chkDayClose(true);// 경고창 팝업은은 true, 아니면 false 
			}
			
			//회기마감 여부에 따라 입력/수정 제한처리~
			if( ( vAccClse == true ) || ( vMonClse == true ) || ( vDayClse == true )  || ( vDeptClse == true ) ) {
				D_Div_ReadOnly(divSLIP_D, true);
				vUpdate = false;
			} else if (vsREADONLY_TF == "T") {
				D_Div_ReadOnly(divSLIP_D, true);
				vUpdate = false;
			} else if (dsSLIP_H.NameString(dsSLIP_H.RowPosition, "KEEP_CLS") == "T") {
				// 확정전표면 무조건 전표 Body 읽기전용  
				D_Div_ReadOnly(divSLIP_D, true);
				vUpdate = false;
			} else if (
				(dsSLIP_H.NameString(dsSLIP_H.RowPosition, "WORK_CODE")!="") 
				&& 
				(dsSLIP_H.NameString(dsSLIP_H.RowPosition, "SLIP_UPDATE_CLS") != "T")
				) 
			{
				// 업무구분의 수정가능여부가 "T"가 아니면면  전표 Body 읽기전용
				D_Div_ReadOnly(divSLIP_D, true);
				vUpdate = false;
			} else {
				// 기타의 경우면 전표 Body 수정가능
				D_Div_ReadOnly(divSLIP_D, false);
				vUpdate = true;
			}
			Slip_Head_ReadOnly(true);
		}

	}
	else if(dataset == dsSLIP_D)
	{
		Input_Detail_Display();
		Input_Color_ReadOnly();
	}
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

function OnRowInserted(dataset, row)
{
	if (dataset == dsSLIP_H)
	{ 
		G_Load(dsSLIP_ID, null);
		dsSLIP_H.NameString(row, "SLIP_ID") 		= dsSLIP_ID.NameString(dsSLIP_ID.RowPosition, "SLIP_ID");
		dsSLIP_H.NameString(row, "MAKE_SLIPCLS")	= cboMAKE_SLIPCLS.value;
		dsSLIP_H.NameString(row, "MAKE_COMP_CODE")	= txtMAKE_COMP_CODE.value;
		dsSLIP_H.NameString(row, "COMPANY_NAME")	= txtCOMPANY_NAME.value;
		dsSLIP_H.NameString(row, "MAKE_DEPT_CODE")	= txtMAKE_DEPT_CODE.value;
		dsSLIP_H.NameString(row, "MAKE_DEPT_NAME")	= txtMAKE_DEPT_NAME.value;
		dsSLIP_H.NameString(row, "MAKE_DT")			= txtMAKE_DT.value;
		dsSLIP_H.NameString(row, "MAKE_DT_TRANS")	= txtMAKE_DT_TRANS.value;

		/*
		G_Load(dsMAKE_SEQ, null);
		dsSLIP_H.NameString(row, "MAKE_SEQ")		= dsMAKE_SEQ.NameString(dsMAKE_SEQ.RowPosition, "MAKE_SEQ");
		txtMAKE_SEQ.value 							= dsMAKE_SEQ.NameString(dsMAKE_SEQ.RowPosition, "MAKE_SEQ");
		*/
		// MAKE_SEQ는 저장시점에 부여한다.
		//dsSLIP_H.NameString(row, "MAKE_SEQ")		= "0";
		//txtMAKE_SEQ.value 						= "0";

		//cboSLIP_KIND_TAG.value = "A";
		dsSLIP_H.NameString(row, "SLIP_KIND_TAG")	= cboSLIP_KIND_TAG.value;
		
		//txtMAKE_SLIPNO.value						= txtMAKE_DT_TRANS.value.substring(2) + cboSLIP_KIND_TAG.value + '' + txtMAKE_COMP_CODE.value + '' + LPad(txtMAKE_SEQ.value,4);
		//dsSLIP_H.NameString(row, "MAKE_SLIPNO")	= txtMAKE_DT_TRANS.value.substring(2) + cboSLIP_KIND_TAG.value + '' + txtMAKE_COMP_CODE.value + '' + LPad(txtMAKE_SEQ.value,4);
		
		dsSLIP_H.NameString(row, "INOUT_DEPT_CODE")	= txtINOUT_DEPT_CODE.value;
		dsSLIP_H.NameString(row, "INOUT_DEPT_NAME")	= txtINOUT_DEPT_NAME.value;
		dsSLIP_H.NameString(row, "MAKE_PERS")		= txtMAKE_PERS.value;
		dsSLIP_H.NameString(row, "MAKE_NAME")		= txtMAKE_NAME.value;
		dsSLIP_H.NameString(row, "KEEP_CLS")		= "F";
		
		// 전표등록에서는 이월전표 구분이 항상 "F"		
		dsSLIP_H.NameString(row, "TRANSFER_TAG")	= "F";
		
		// 조정전표이고 이월전표가 아니면 설정반제(IGNORE_SET_RESET_TAG) 무시
		if( cboSLIP_KIND_TAG.value == "Z" && dsSLIP_H.NameString(row, "TRANSFER_TAG") == "F" ) {
			dsSLIP_H.NameString(row, "IGNORE_SET_RESET_TAG")	= "T";
		} else {
			dsSLIP_H.NameString(row, "IGNORE_SET_RESET_TAG")	= "F";
		}

		txtKEEP_CLS.value		= "미확정";
		
		dsSLIP_H.NameString(row, "CHARGE_PERS")	= txtCHARGE_PERS.value;
		dsSLIP_H.NameString(row, "CHARGE_PERS_NAME")	= txtCHARGE_PERS_NAME.value;
		
		D_Div_ReadOnly(divSLIP_D, false);
		vUpdate = true;
	
		if (sDept_Chg_Cls == "F")
		{
			document.all.txtDEPT_CODE.readOnly			= true;
			document.all.btnDEPT_CODE.disabled			= true;
		}
		else
		{
			document.all.txtDEPT_CODE.readOnly			= false;
			document.all.btnDEPT_CODE.disabled			= false;
		}
	
		G_Load(dsCLASS_CODE, null);
		btnDETAIL_ADD_onClick();
	}
	else if (dataset == dsSLIP_D)
	{
		G_Load(dsSLIP_IDSEQ, null);
		dsSLIP_D.NameString(row, "SLIP_IDSEQ")		= dsSLIP_IDSEQ.NameString(dsSLIP_IDSEQ.RowPosition, "SLIP_IDSEQ");
		Make_Slipline(); 
		
		if (row == 1)
		{
			dsSLIP_D.NameString(row, "COMP_CODE")		= sDept_CompCode;
			dsSLIP_D.NameString(row, "COMP_NAME")		= sDept_CompName;
			dsSLIP_D.NameString(row, "DEPT_CODE")		= sDeptCode;
			dsSLIP_D.NameString(row, "DEPT_NAME")		= sDeptName;
			dsSLIP_D.NameString(row, "TAX_COMP_CODE")	= sDept_Tax_CompCode;
			dsSLIP_D.NameString(row, "TAX_COMP_NAME")	= sDept_Tax_CompName;
			dsSLIP_D.NameString(row, "DB_AMT_D")		= "";
			dsSLIP_D.NameString(row, "CR_AMT_D")		= "";
			dsSLIP_D.NameString(row, "CLASS_CODE")		= dsCLASS_CODE.NameString(dsCLASS_CODE.RowPosition, "CLASS_CODE");
			dsSLIP_D.NameString(row, "CLASS_CODE_NAME")	= dsCLASS_CODE.NameString(dsCLASS_CODE.RowPosition, "CLASS_CODE_NAME");
		}
		else
		{
			dsSLIP_D.NameString(row, "COMP_CODE")		= dsSLIP_D.NameString(row-1, "COMP_CODE");
			dsSLIP_D.NameString(row, "COMP_NAME")		= dsSLIP_D.NameString(row-1, "COMP_NAME");
			dsSLIP_D.NameString(row, "DEPT_CODE")		= dsSLIP_D.NameString(row-1, "DEPT_CODE");
			dsSLIP_D.NameString(row, "DEPT_NAME")		= dsSLIP_D.NameString(row-1, "DEPT_NAME");
			dsSLIP_D.NameString(row, "TAX_COMP_CODE")	= dsSLIP_D.NameString(row-1, "TAX_COMP_CODE");
			dsSLIP_D.NameString(row, "TAX_COMP_NAME")	= dsSLIP_D.NameString(row-1, "TAX_COMP_NAME");
			dsSLIP_D.NameString(row, "DB_AMT_D")		= "";
			dsSLIP_D.NameString(row, "CR_AMT_D")		= "";
			dsSLIP_D.NameString(row, "CLASS_CODE")		= dsSLIP_D.NameString(row-1, "CLASS_CODE");
			dsSLIP_D.NameString(row, "CLASS_CODE_NAME")	= dsSLIP_D.NameString(row-1, "CLASS_CODE_NAME");
		}
	}
}

function OnRowDeleteBefore(dataset)
{
	if (dataset == dsSLIP_D)
	{
		G_Load(dsRESET_CNT, null);
		
		if (dsRESET_CNT.NameString(dsRESET_CNT.RowPosition, "RESET_CNT") > 1)
		{
			C_msgOk("반제내역이 존재합니다. 삭제할수 없습니다.", "확인");
			return false;
		}
	}
	return true;
}

function OnRowDeleted(dataset, row)
{
	if (dataset == dsSLIP_D)
	{
	}
}

var bRowPosChangging = false;
function OnRowPosChanged(dataset, row)
{
	if(dataset == dsSLIP_H)
	{
		Confirm_Trans_Button();
	}
	else if(dataset == dsSLIP_D)
	{
		Confirm_Trans_Button();
		
		Input_Detail_Display();
		Input_Color_ReadOnly();
		Input_Clear();

		if(bRowPosChangging == true) return;
		bRowPosChangging = true;
		// 조회직후 자동갱신이 안돼서 하는 삽질
		if(
			dsSLIP_D.RowPosition==1&&
			dsBRAIN_SLIP_SEQ1.RowPosition!=1&&
			dsBRAIN_SLIP_SEQ2.CountRow==1
		) {
			var rowValue = dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BRAIN_SLIP_SEQ2")
			G_Load(dsBRAIN_SLIP_SEQ2, null);
			dsBRAIN_SLIP_SEQ2.RowPosition = dsBRAIN_SLIP_SEQ2.NameValueRow("BRAIN_SLIP_SEQ2",rowValue);
		}
		bRowPosChangging = false;
	}
}

function OnRowPosChangeBefore(dataset, row)
{
	// 차대 입력상태에서 Row Change...
	dsSLIP_D.NameString(dsSLIP_D.RowPosition,'DB_AMT') = C_removeComma(txtDB_AMT_D.value);
	txtDB_AMT_D.value = C_toNumberFormatString(C_removeComma(txtDB_AMT_D.value));

	dsSLIP_D.NameString(dsSLIP_D.RowPosition,'CR_AMT') = C_removeComma(txtCR_AMT_D.value);
	txtCR_AMT_D.value = C_toNumberFormatString(C_removeComma(txtCR_AMT_D.value));

	//확정전표는 Check 안함
	if (dsSLIP_H.NameString(dsSLIP_H.RowPosition,"KEEP_CLS") == "T")
	{
		return true;
	}
	
	//필수 입력항목 기본 Check
	if (dataset	== dsSLIP_D)
	{
	   	Input_Error_Check();
	
		if (vError_Flag == 'T')
		{
			vOBJ.focus();
			vError_Flag = "F";
			return false;
		}
	}
	return true;
}
function OnColumnChanged(dataset, row, colid)
{
	if(dataset == dsSLIP_H)
	{
	}
	else if(dataset == dsSLIP_D)
	{
		if(colid ==	"ACC_CODE")
		{
		}
		else if(colid == "DB_AMT")
		{
			if(amtLOCK == true) return;
			amtLOCK = true;
			
			//dataset.NameString(row,"DB_AMT") = C_removeComma(dataset.NameString(row,colid));
			
			if (
				((dataset.NameString(row,"DB_AMT") != "0") && (dataset.NameString(row,"CR_AMT") != "0"))
				||
				((dataset.NameString(row,"DB_AMT") == "0") && (dataset.NameString(row,"CR_AMT") == "0"))
			)
			{
				dataset.NameString(row,"CR_AMT") = "0";
				dataset.NameString(row,"CR_AMT_D") = "0";
				dataset.NameString(row,"CHK_NO") = "";
				dataset.NameString(row,"CHK_PUBL_DT") = "";
				dataset.NameString(row,"CHK_COLL_DT") = "";
				dataset.NameString(row,"BILL_NO_S") = "";
				dataset.NameString(row,"BILL_PUBL_DT") = "";
				dataset.NameString(row,"BILL_EXPR_DT") = "";
				dataset.NameString(row,"BILL_NO_R") = "";
				dataset.NameString(row,"BILL_PUBL_DT_R") = "";
				dataset.NameString(row,"BILL_EXPR_DT_R") = "";
				dataset.NameString(row,"BILL_COLL_DT_R") = "";
				dataset.NameString(row,"REC_BILL_NO_S") = "";
				dataset.NameString(row,"REC_BILL_PUBL_DT") = "";
				dataset.NameString(row,"REC_BILL_EXPR_DT") = "";
				dataset.NameString(row,"REC_BILL_PUBL_AMT") = "";
			}
			
			//if ( dataset.NameString(row,"DB_AMT_D").length <= 2 )
			{
				Input_Detail_Display();
				Input_Detail_Clear();
				Input_Color_ReadOnly();
				Input_Clear();
			}

			var vBRAIN_GRP_SEQ = dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BRAIN_GRP_SEQ");
			// 표준적요 그룹내 맨 마지막 라인에 차대맞춰 입력
			if( !(vBRAIN_GRP_SEQ=="0" || vBRAIN_GRP_SEQ=="") ) MakeBrainDB_Equal_CR(row);
			
			if( dsSLIP_H.NameString(dsSLIP_H.CountRow, "MAKE_SLIPCLS") == "2" ) {
				// 전표구분 현금
				if(dsSLIP_D.RowPosition != 1) MakeDB_Equal_CR(1);
			}


			amtLOCK = false;
		}
		else if(colid == "CR_AMT")
		{
			if(amtLOCK == true) return;
			amtLOCK = true;
			//dataset.NameString(row,"CR_AMT") = C_removeComma(dataset.NameString(row,colid));
			
			if (
				((dataset.NameString(row,"DB_AMT") != "0") && (dataset.NameString(row,"CR_AMT") != "0"))
				||
				((dataset.NameString(row,"DB_AMT") == "0") && (dataset.NameString(row,"CR_AMT") == "0"))
			)
			{
				dataset.NameString(row,"CR_AMT") = "0";
				dataset.NameString(row,"CR_AMT_D") = "0";
				dataset.NameString(row,"CHK_NO") = "";
				dataset.NameString(row,"CHK_PUBL_DT") = "";
				dataset.NameString(row,"CHK_COLL_DT") = "";
				dataset.NameString(row,"BILL_NO_S") = "";
				dataset.NameString(row,"BILL_PUBL_DT") = "";
				dataset.NameString(row,"BILL_EXPR_DT") = "";
				dataset.NameString(row,"BILL_NO_R") = "";
				dataset.NameString(row,"BILL_PUBL_DT_R") = "";
				dataset.NameString(row,"BILL_EXPR_DT_R") = "";
				dataset.NameString(row,"BILL_COLL_DT_R") = "";
				dataset.NameString(row,"REC_BILL_NO_S") = "";
				dataset.NameString(row,"REC_BILL_PUBL_DT") = "";
				dataset.NameString(row,"REC_BILL_EXPR_DT") = "";
				dataset.NameString(row,"REC_BILL_PUBL_AMT") = "";
			}
			
			//if ( dataset.NameString(row,"CR_AMT_D").length <= 2 )
			{
				Input_Detail_Display();
				Input_Detail_Clear();
				Input_Color_ReadOnly();
				Input_Clear();
			}

			var vBRAIN_GRP_SEQ = dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BRAIN_GRP_SEQ");
			// 표준적요 그룹내 맨 마지막 라인에 차대맞춰 입력
			if( !(vBRAIN_GRP_SEQ=="0" || vBRAIN_GRP_SEQ=="") ) MakeBrainDB_Equal_CR(row);

			if( dsSLIP_H.NameString(dsSLIP_H.CountRow, "MAKE_SLIPCLS") == "2" ) {
				// 전표구분 현금
				if(dsSLIP_D.RowPosition != 1) MakeDB_Equal_CR(1);
			}
			amtLOCK = false;			
		}
		else if(colid == "VAT_CODE")
		{
			//createBrainSlipLine(dataset, row, colid);
		}
		else if(colid == "BILL_EXPR_DT")
		{
			if (C_isNull(dataset.NameString(row,"BILL_EXPR_DT")))
			{
				if(dataset.NameString(row,"BILL_EXPR_DT").replace(/-/gi,"") > dataset.NameString(row,"BILL_EXPR_DT").replace(/-/gi,""))
				{
					C_msgOk("발행일이 만기일보다 큽니다.", "확인");
					dataset.NameString(row,"BILL_EXPR_DT") = "";
					return;
				}
			}
		}
		else if(colid == "VAT_DT")
		{
			syncVatDt(row);//계산서일자 동기화
		}
		else if(colid == "BRAIN_SLIP_SEQ2")
		{
			createBrainSlipLine(dataset, row, colid);
		}

	}
}

function createBrainSlipLine(dataset, row, colid) {
	if(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_SORT_SEQ") > 1) return;

	if(bRowPosChangging == true) return;
	bRowPosChangging = true;
	var vUpdateOrg = vUpdate;
	vUpdate = false;

	var vRowPosition = 0;
	if(
		( dataset.NameString(row,"BRAIN_SLIP_SEQ1")=="" || dataset.NameString(row,"BRAIN_SLIP_SEQ1")=="0" )
		||
		( dataset.NameString(row,"BRAIN_SLIP_SEQ2")=="" || dataset.NameString(row,"BRAIN_SLIP_SEQ2")=="0" )
		||
		( dataset.NameString(row,"VAT_CODE")=="" )
	) {
		// alert("표준적요 라인 삭제!!");
		var vBRAIN_GRP_SEQ = dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BRAIN_GRP_SEQ");

		if( !(vBRAIN_GRP_SEQ=="0" || vBRAIN_GRP_SEQ=="") ){
			var arSelectRow = new Array();
			
			for (i=dsSLIP_D.CountRow;i>=1;i--) {
				if( vBRAIN_GRP_SEQ == dsSLIP_D.NameString(i,"BRAIN_GRP_SEQ") ) {
					arSelectRow.push(i);
				}
			}
			
			for(i=0;i<arSelectRow.length;i++){
				if(i==(arSelectRow.length-1)){
					dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_GRP_SEQ")      = "";
					dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_SLIP_NAME")    = "-";
					//dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_SLIP_SEQ1")    = "";
					//dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_SLIP_SEQ2")    = "";
					dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_SLIP_LINE")     = "";
					dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_SORT_SEQ")     = "";
					dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_ACC_POSITION") = "";
					dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_REPEAT_CLS") = "";
					dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_DEL_CLS") = "";
					vRowPosition = arSelectRow[i];
				} else {
					G_deleteRow(dsSLIP_D, arSelectRow[i]);
				}
			}
		}
	} else {
		//alert("표준적요 라인 삭제!!");
		var vBRAIN_GRP_SEQ = dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BRAIN_GRP_SEQ");

		if( !(vBRAIN_GRP_SEQ=="0" || vBRAIN_GRP_SEQ=="") ){
			var arSelectRow = new Array();
			
			for (i=dsSLIP_D.CountRow;i>=1;i--) {
				if( vBRAIN_GRP_SEQ == dsSLIP_D.NameString(i,"BRAIN_GRP_SEQ") ) {
					arSelectRow.push(i);
				}
			}
			
			for(i=0;i<arSelectRow.length;i++){
				if(i==(arSelectRow.length-1)){
					dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_GRP_SEQ")      = "";
					dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_SLIP_NAME")    = "-";
					//dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_SLIP_SEQ1")    = "";
					//dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_SLIP_SEQ2")    = "";
					dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_SLIP_LINE")     = "";
					dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_SORT_SEQ")     = "";
					dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_ACC_POSITION") = "";
					dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_REPEAT_CLS") = "";
					dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_DEL_CLS") = "";
					dsSLIP_D.RowPosition = arSelectRow[i];
				} else {
					G_deleteRow(dsSLIP_D, arSelectRow[i]);
				}
			}
		}

		//alert("표준적요 라인 추가!!");
		G_Load(dsBRAIN_SLIP_BODY, null);
		G_Load(dsBRAIN_GRP_SEQ, null);
		
		var rowIdx = 0;
		var rowCnt = dsBRAIN_SLIP_BODY.CountRow;

		if(rowCnt!=0){
			for( rowIdx=1;rowIdx<=rowCnt;rowIdx++){
				dsBRAIN_SLIP_BODY.RowPosition = rowIdx;
				if(rowIdx==1) {
					// 첫번째라인은 현재라인에 덮어쓴다. 
				} else {
					G_insertRow(dsSLIP_D, dsSLIP_D.RowPosition+1, false);
				}
				setAccCodeInfoBrain(dsBRAIN_SLIP_BODY);
			}
			vRowPosition = dsSLIP_D.RowPosition - (rowCnt - 1);
		} else {
			C_msgOk("선택된 표준적요에 계정코드가 등록되지 않았습니다.", "확인");
			dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_GRP_SEQ")      = "";
			dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_SLIP_NAME")    = "-";
			//dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_SLIP_SEQ1")    = "";
			//dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_SLIP_SEQ2")    = "";
			dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_SLIP_LINE")     = "";
			dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_SORT_SEQ")     = "";
			dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_ACC_POSITION") = "";
			dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_REPEAT_CLS") = "";
			dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_DEL_CLS") = "";
		}
	}
	bRowPosChangging = false;
	vUpdate = vUpdateOrg;
	dsSLIP_D.RowMark(dsSLIP_D.RowPosition) = 0;
	if(vRowPosition != 0) dsSLIP_D.RowPosition = vRowPosition;
}

function calcSUPAMT() {
	if (!C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"RCPTBILL_CLS")))
	{
		vVATAMT = SafeToInt(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"DB_AMT")) + SafeToInt(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CR_AMT"));
		txtVATAMT.value = C_toNumberFormatString(vVATAMT);
		
		if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"VATOCCUR_CLS") == "T")
		{
			txtSUPAMT.value	= C_toNumberFormatString(Math.floor(parseFloat(vVATAMT) * 10));
		}
	}
}

function calcVATAMT() {
	if (!C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"RCPTBILL_CLS")))
	{
		var vSUPAMT = SafeToInt(txtSUPAMT.value.replace(/,/gi,""));
		
		if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"VATOCCUR_CLS") == "T")
		{
			vVATAMT = SafeToInt( ""+(vSUPAMT/10) );
			txtVATAMT.value = C_toNumberFormatString(vVATAMT);
		} else {
			vVATAMT = 0;
			txtVATAMT.value = C_toNumberFormatString(vVATAMT);
		}
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
}

function OnPopup(dataset, grid, row, colid, data)
{
}

function OnKillFocus(dataset, grid) {
}

//전표 Header Setting
function Slip_Head_Setting()
{
	txtMAKE_COMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtMAKE_DT.value = sDate;
	txtMAKE_DT_TRANS.value = sDt_Trans;
	txtMAKE_SEQ.value = "";
	txtMAKE_SLIPNO.value = "";
	cboSLIP_KIND_TAG.value	= "G";
	txtMAKE_DEPT_CODE.value = sDeptCode;
	txtMAKE_DEPT_NAME.value = sDeptName;
	txtINOUT_DEPT_CODE.value = sInout_DeptCode;
	txtINOUT_DEPT_NAME.value = sInout_DeptName;
	txtMAKE_PERS.value = sEmpno;
	txtMAKE_NAME.value = sName;
	
	txtCHARGE_PERS.value		= sCHARGE_PERS;
	txtCHARGE_PERS_NAME.value	= sCHARGE_PERS_NAME;

	Confirm_Trans_Button();
}

function Slip_Head_ReadOnly(bReadonly)
{
	//document.all.txtMAKE_COMP_CODE.readOnly		= !vUpdate;
	//document.all.txtMAKE_DT_TRANS.readOnly		= !vUpdate;
	//document.all.btnMAKE_DT.disabled			= !vUpdate;
	//document.all.txtMAKE_SEQ.readOnly			= !vUpdate;
	//document.all.txtMAKE_SLIPNO.readOnly		= !vUpdate;
	//document.all.cboSLIP_KIND_TAG.disabled		= !vUpdate;
	document.all.cboMAKE_SLIPCLS.disabled		= !vUpdate;
	document.all.btnMAKE_COMP_CODE.disabled		= !vUpdate;
	document.all.btnMAKE_DEPT_CODE.disabled		= !vUpdate;

	document.all.txtMAKE_DT_TRANS.style.background	= !vUpdate?"#EFEFEF":"white";
	//document.all.txtMAKE_SEQ.style.background		= !vUpdate?"#EFEFEF":"white";
	//document.all.txtMAKE_SLIPNO.style.background	= !vUpdate?"#EFEFEF":"white";

	if (sDept_Chg_Cls == "T")
	{
		document.all.txtMAKE_COMP_CODE.readOnly				= !vUpdate;
		document.all.txtMAKE_COMP_CODE.style.background		= !vUpdate?"#EFEFEF":"white";

		//document.all.txtCOMPANY_NAME.readOnly		= !vUpdate;
		document.all.txtCOMPANY_NAME.readOnly		= true;
		document.all.btnMAKE_COMP_CODE.style.display= !vUpdate?"none":"";
		//document.all.txtMAKE_DEPT_NAME.readOnly		= !vUpdate;
		document.all.txtMAKE_DEPT_NAME.readOnly		= true;
		document.all.btnMAKE_DEPT_CODE.style.display= !vUpdate?"none":"";
	}
	else
	{
		document.all.txtMAKE_COMP_CODE.readOnly				= true;
		document.all.txtMAKE_COMP_CODE.style.background		= "#EFEFEF";

		document.all.txtCOMPANY_NAME.readOnly		= true;
		document.all.btnMAKE_COMP_CODE.style.display= "none";
		document.all.txtMAKE_DEPT_NAME.readOnly		= true;
		document.all.btnMAKE_DEPT_CODE.style.display= "none";
	}

	txtINOUT_DEPT_NAME.readOnly			= !vUpdate;
	btnINOUT_DEPT_CODE.style.display	= !vUpdate?"none":"";
	txtINOUT_DEPT_NAME.style.background	= !vUpdate?"#EFEFEF":"white";

	txtCHARGE_PERS_NAME.readOnly		= !vUpdate;
	btnCHARGE_PERS.style.display		= !vUpdate?"none":"";
	txtCHARGE_PERS_NAME.style.background= !vUpdate?"#EFEFEF":"white";
}

//라인번호 Setting
function Make_Slipline()
{
	for	(var i=dsSLIP_D.RowPosition; i <= dsSLIP_D.CountRow;i++)
	{
		dsSLIP_D.NameString(i,"MAKE_SLIPLINE") = i;
	}
}

//표준적요 그룹내 순번 Setting
function Remake_BRAIN_SORT_SEQ(pBRAIN_GRP_SEQ)
{
	var vBRAIN_SORT_SEQ = 0;
	for	(var i=1;i<= dsSLIP_D.CountRow;i++)
	{
		if(dsSLIP_D.NameString(i, "BRAIN_GRP_SEQ") == pBRAIN_GRP_SEQ){
			vBRAIN_SORT_SEQ++;
			dsSLIP_D.NameString(i,"BRAIN_SORT_SEQ") = vBRAIN_SORT_SEQ;
		}
	}
}

//전표 확정버튼 Setting
function Confirm_Trans_Button()
{
	
	if (dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BUDG_MNG") == "T")
	{
		document.all.btnBUDG.style.display	= "";
	} else {
		document.all.btnBUDG.style.display	= "none";
	}
	
	if (dsSLIP_D.NameString(dsSLIP_D.RowPosition, "ACC_REMAIN_MNG") == "T")
	{
		document.all.btnRESET_SLIP.style.display	= "";
	} else {
		document.all.btnRESET_SLIP.style.display	= "none";
	}
	
	document.all.btnSLIP_PRINT.style.display	= "";

	if (sSlip_Trans_Cls == "T")
	{
		if (dsSLIP_H.NameString(dsSLIP_H.RowPosition, "KEEP_CLS") == "T")
		{
			document.all.btnSLIP_CONFIRM.style.display	= "none";
			document.all.btnSLIP_CANCEL.style.display	= "";
			document.all.btnSLIP_COPY.style.display	= "none";
			document.all.btnDETAIL_INSERT.style.display	= "none";
			document.all.btnDETAIL_ADD.style.display	= "none";
			document.all.btnDETAIL_COPY.style.display	= "none";
			document.all.btnDETAIL_DELETE.style.display	= "none";
		}
		else
		{
			document.all.btnSLIP_CONFIRM.style.display	= "";
			document.all.btnSLIP_CANCEL.style.display	= "none";
			document.all.btnSLIP_COPY.style.display	= "";
			document.all.btnDETAIL_INSERT.style.display	= "";
			document.all.btnDETAIL_ADD.style.display	= "";
			document.all.btnDETAIL_COPY.style.display	= "";
			document.all.btnDETAIL_DELETE.style.display	= "";
		}
	}
	else
	{
		if (dsSLIP_H.NameString(dsSLIP_H.RowPosition, "KEEP_CLS") == "T")
		{
			document.all.btnSLIP_CONFIRM.style.display	= "none";
			document.all.btnSLIP_CANCEL.style.display	= "none";
			document.all.btnSLIP_COPY.style.display	= "none";
			document.all.btnDETAIL_INSERT.style.display	= "none";
			document.all.btnDETAIL_ADD.style.display	= "none";
			document.all.btnDETAIL_COPY.style.display	= "none";
			document.all.btnDETAIL_DELETE.style.display	= "none";
		}
		else
		{
			document.all.btnSLIP_CONFIRM.style.display	= "none";
			document.all.btnSLIP_CANCEL.style.display	= "none";
			document.all.btnSLIP_COPY.style.display	= "";
			document.all.btnDETAIL_INSERT.style.display	= "";
			document.all.btnDETAIL_ADD.style.display	= "";
			document.all.btnDETAIL_COPY.style.display	= "";
			document.all.btnDETAIL_DELETE.style.display	= "";
		}
	}

	if (isPopup == true)
	{
		document.all.btnSLIP_SEARCH.style.display	= "";
		if(vUpdate) {
			document.all.btnSLIP_NEW.style.display		= "";
			document.all.btnSLIP_DELETE.style.display	= "";
			document.all.btnSLIP_SAVE.style.display		= "";
		} else {
			document.all.btnSLIP_NEW.style.display		= "none";
			document.all.btnSLIP_DELETE.style.display	= "none";
			document.all.btnSLIP_SAVE.style.display		= "none";

			//document.all.btnSLIP_CONFIRM.style.display	= "none";
			//document.all.btnSLIP_CANCEL.style.display	= "none";
			document.all.btnSLIP_COPY.style.display		= "none";
			document.all.btnDETAIL_INSERT.style.display	= "none";
			document.all.btnDETAIL_ADD.style.display	= "none";
			document.all.btnDETAIL_COPY.style.display	= "none";
			document.all.btnDETAIL_DELETE.style.display	= "none";
		}
	}
	else
	{
		document.all.btnSLIP_SEARCH.style.display	= "none";
		document.all.btnSLIP_NEW.style.display		= "none";
		document.all.btnSLIP_DELETE.style.display	= "none";
		document.all.btnSLIP_SAVE.style.display		= "none";
	}
}

//코드에 따른 항목 타이틀 제어 
function Input_Color_ReadOnly()
{
	if(
		//dsSLIP_D.NameString(dsSLIP_D.RowPosition,"VAT_CODE") != ""
		//&&
		!( dsSLIP_H.NameString(dsSLIP_H.CountRow, "MAKE_SLIPCLS") == "2" && dsSLIP_D.RowPosition == 1 )
	) {
		if(
			!(
				( dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BRAIN_SLIP_SEQ1")=="" || dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BRAIN_SLIP_SEQ1")=="0" )
				||
				( dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BRAIN_SLIP_SEQ2")=="" || dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BRAIN_SLIP_SEQ2")=="0" )
			)
		) {
			// 표준적요 각 그룹의 첫번째 항목만 활성화..
			if (
				(
					(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_GRP_SEQ")!=dsSLIP_D.NameString(dsSLIP_D.RowPosition-1, "BRAIN_GRP_SEQ"))
					&&
					(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_SORT_SEQ") == "1")
				)
				||
				( dsSLIP_D.RowPosition == 1)
			) {
				cboBRAIN_SLIP_SEQ1.enable = vUpdate;
				cboBRAIN_SLIP_SEQ2.enable = vUpdate;

				txtVAT_CODE.style.background	= !vUpdate?"#EFEFEF":"white";
				txtVAT_CODE.readOnly	= !vUpdate;
				btnVAT_CODE.disabled	= !vUpdate;
			} else {
				cboBRAIN_SLIP_SEQ1.enable = false;
				cboBRAIN_SLIP_SEQ2.enable = false;

				txtVAT_CODE.style.background	= "#EFEFEF";
				txtVAT_CODE.readOnly	= true;
				btnVAT_CODE.disabled	= true;
			}
		} else {
			cboBRAIN_SLIP_SEQ1.enable = vUpdate;
			cboBRAIN_SLIP_SEQ2.enable = vUpdate;

			txtVAT_CODE.style.background	= !vUpdate?"#EFEFEF":"white";
			txtVAT_CODE.readOnly	= !vUpdate;
			btnVAT_CODE.disabled	= !vUpdate;
		}
	} else {
		cboBRAIN_SLIP_SEQ1.enable = false;
		cboBRAIN_SLIP_SEQ2.enable = false;
		
		txtVAT_CODE.style.background	= "white";
		txtVAT_CODE.readOnly	= false;
		btnVAT_CODE.disabled	= false;
	}


	// 표준적요 차대입력설정
	if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BRAIN_ACC_POSITION")=="D") {
		txtDB_AMT_D.readOnly = !vUpdate;
		txtCR_AMT_D.readOnly = true;

		txtDB_AMT_D.style.background = "#FFECEC";
		txtCR_AMT_D.style.background = "#EFEFEF";
	} else if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BRAIN_ACC_POSITION")=="C") {
		txtDB_AMT_D.readOnly = true;
		txtCR_AMT_D.readOnly = !vUpdate;

		txtDB_AMT_D.style.background = "#EFEFEF";
		txtCR_AMT_D.style.background = "#FFECEC";
	} else {
		txtDB_AMT_D.readOnly = !vUpdate;
		txtCR_AMT_D.readOnly = !vUpdate;

		txtDB_AMT_D.style.background = "#FFECEC";
		txtCR_AMT_D.style.background = "#E0F4FF";
	}

	var vSUPAMT = 0;
	
	//부가세관련
	if (!C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"RCPTBILL_CLS")))
	{
		document.all.txtVAT_DT.style.background		    			= "white";
		document.all.txtSUPAMT.style.background		    			= "white";
		document.getElementById("titSUPAMT").innerHTML				= '<font color="black">공급가액</font>';
		document.all.txtVAT_DT.readOnly				    			= !vUpdate;
		document.all.txtSUPAMT.readOnly				    			= !vUpdate;
		document.all.btnVAT_DT.disabled				    			= !vUpdate;
		if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"VATOCCUR_CLS") == "T")
		{
			document.all.txtVATAMT.style.background						= "white";
			document.getElementById("titVATAMT").innerHTML				= '<font color="black">부가세</font>';
			document.all.txtVATAMT.readOnly				    			= !vUpdate;
		}
		else
		{
			document.all.txtVATAMT.style.background						= "#EFEFEF";
			document.getElementById("titVATAMT").innerHTML				= '<font color="#888888">부가세</font>';
			document.all.txtVATAMT.readOnly				    			= true;
		}
	}
	else
	{
		document.all.txtVAT_DT.style.background		    			= "#EFEFEF";
		document.all.txtSUPAMT.style.background		    			= "#EFEFEF";
		document.all.txtVATAMT.style.background						= "#EFEFEF";
		document.getElementById("titSUPAMT").innerHTML				= '<font color="#888888">공급가액</font>';
		document.getElementById("titVATAMT").innerHTML				= '<font color="#888888">부가세</font>';
		document.all.txtVAT_DT.readOnly				    			= true;
		document.all.txtSUPAMT.readOnly				    			= true;
		document.all.txtVATAMT.readOnly				    			= true;
		document.all.btnVAT_DT.disabled				    			= true;
	}

	if (
		C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"PAY_CON_BILL"))
		||
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"PAY_CON_BILL")=="0"
	)
	{
		txtPAY_CON_BILL_DAYS.style.background	= "#EFEFEF";
		txtPAY_CON_BILL_DAYS.readOnly			= true;
	}
	else
	{
		txtPAY_CON_BILL_DAYS.style.background	= "white";
		txtPAY_CON_BILL_DAYS.readOnly			= !vUpdate;
	}
	
	// 관리항목별... 타이틀 색상제어는 집어친다.
	/*	
	//거래처코드
	if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CUST_CODE_MNG_TG") == "T")
	{
		document.getElementById("titCUST_CODE").innerHTML				= '<font color="black">거래처코드</font>';
	}
	else
	{
		document.getElementById("titCUST_CODE").innerHTML				= '<font color="#888888">거래처코드</font>';
	}
	
	//거래처명
	if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CUST_NAME_MNG_TG") == "T")
	{
		document.getElementById("titCUST_NAME").innerHTML				= '<font color="black">거래처명</font>';
	}
	else
	{
		document.getElementById("titCUST_NAME").innerHTML				= '<font color="#888888">거래처명</font>';
	}
	
	//은행코드
	if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BANK_MNG_TG") == "T")
	{
		document.getElementById("titBANK_CODE").innerHTML				= '<font color="black">은행코드</font>';
	}
	else
	{
		document.getElementById("titBANK_CODE").innerHTML				= '<font color="#888888">은행코드</font>';
	}
	
	//계좌번호
	if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"ACCNO_MNG_TG") == "T")
	{
		document.getElementById("titACCNO_CODE").innerHTML				= '<font color="black">계좌번호</font>';
	}
	else
	{
		document.getElementById("titACCNO_CODE").innerHTML				= '<font color="#888888">계좌번호</font>';
	}
	
	//당좌수표
	if (!C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CHK_NO")))
	{
		document.getElementById("titCHK_NO").innerHTML				= '<font color="black">수표번호</font>';
		document.getElementById("titCHK_PUBL_DT").innerHTML			= '<font color="black">발행일</font>';
	}
	else
	{
		document.getElementById("titCHK_NO").innerHTML				= '<font color="#888888">수표번호</font>';
		document.getElementById("titCHK_PUBL_DT").innerHTML			= '<font color="#888888">발행일</font>';
	}
	
	//지급어음
	if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BILL_NO_MNG_TG") == 'T')
	{
		document.getElementById("titBILL_NO").innerHTML				= '<font color="black">어음번호</font>';
		document.getElementById("titBILL_PUBL_DT").innerHTML		= '<font color="black">발행일</font>';
		document.getElementById("titBILL_EXPR_DT").innerHTML		= '<font color="black">만기일</font>';
		document.getElementById("titBILL_NO_R").innerHTML			= '<font color="black">어음번호</font>';
		document.getElementById("titBILL_PUBL_DT_R").innerHTML		= '<font color="black">발행일</font>';
		document.getElementById("titBILL_EXPR_DT_R").innerHTML		= '<font color="black">만기일</font>';
		document.getElementById("titBILL_CHG_EXPR_DT_R").innerHTML	= '<font color="black">변경만기일</font>';
	}
	else
	{
		document.getElementById("titBILL_NO").innerHTML				= '<font color="#888888">어음번호</font>';
		document.getElementById("titBILL_PUBL_DT").innerHTML		= '<font color="#888888">발행일</font>';
		document.getElementById("titBILL_EXPR_DT").innerHTML		= '<font color="#888888">만기일</font>';
		document.getElementById("titBILL_NO_R").innerHTML			= '<font color="#888888">어음번호</font>';
		document.getElementById("titBILL_PUBL_DT_R").innerHTML		= '<font color="#888888">발행일</font>';
		document.getElementById("titBILL_EXPR_DT_R").innerHTML		= '<font color="#888888">만기일</font>';
		document.getElementById("titBILL_CHG_EXPR_DT_R").innerHTML	= '<font color="#888888">변경만기일</font>';
	}
	
	//받을어음
	if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"REC_BILL_NO_MNG_TG") == 'T')
	{
		document.getElementById("titREC_BILL_NO").innerHTML				= '<font color="black">어음번호</font>';
		document.getElementById("titREC_BILL_PUBL_DT").innerHTML		= '<font color="black">발행일</font>';
		document.getElementById("titREC_BILL_EXPR_DT").innerHTML		= '<font color="black">만기일</font>';
		document.getElementById("titREC_BILL_NO_R").innerHTML			= '<font color="black">어음번호</font>';
		document.getElementById("titREC_BILL_PUBL_DT_R").innerHTML		= '<font color="black">발행일</font>';
		document.getElementById("titREC_BILL_EXPR_DT_R").innerHTML		= '<font color="black">만기일</font>';
		document.getElementById("titREC_BILL_PUBL_AMT_R").innerHTML		= '<font color="black">발행금액</font>';
	}
	else
	{
		document.getElementById("titREC_BILL_NO").innerHTML				= '<font color="#888888">어음번호</font>';
		document.getElementById("titREC_BILL_PUBL_DT").innerHTML		= '<font color="#888888">발행일</font>';
		document.getElementById("titREC_BILL_EXPR_DT").innerHTML		= '<font color="#888888">만기일</font>';
		document.getElementById("titREC_BILL_NO_R").innerHTML			= '<font color="#888888">어음번호</font>';
		document.getElementById("titREC_BILL_PUBL_DT_R").innerHTML		= '<font color="#888888">발행일</font>';
		document.getElementById("titREC_BILL_EXPR_DT_R").innerHTML		= '<font color="#888888">만기일</font>';
		document.getElementById("titREC_BILL_PUBL_AMT_R").innerHTML		= '<font color="#888888">발행금액</font>';
	}
	*/
}

//코드에 따른 명칭 및 그에 따른 데이타 Clear
function Input_Clear()
{
	if(!vUpdate) {
		// 수정모드가 아니면 리턴...
		return;
	}

	if (C_isNull(txtMAKE_COMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
	}
	
	if (C_isNull(txtTAX_COMP_CODE.value))
	{
		txtTAX_COMP_NAME.value = "";
	}
	
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMP_NAME.value = "";
		txtDEPT_CODE.value = "";
		// 귀속사업장별 계좌번호 관리
		txtACCNO_CODE.value = "";
	}

	if (C_isNull(txtDEPT_CODE.value))
	{
		txtDEPT_NAME.value = "";
		txtCLASS_CODE.value = "";
		//txtACC_CODE.value = "";
	}
	
	if (C_isNull(txtCLASS_CODE.value))
	{
		txtCLASS_CODE_NAME.value = "";
	}
	
	if (C_isNull(txtACC_CODE.value))
	{
		txtACC_NAME.value = "";
		setAccCodeInfo(null);
		
		//txtVAT_CODE.value = "";
		txtSUMMARY_CODE.value = "";

		txtVAT_DT.value = "";
		txtSUPAMT.value	= "0";
		txtVATAMT.value	= "0";

		//txtACCNO_CODE.value = "";
		
		//txtRESET_SLIPNO.value = "";
	} else {
		//calcVATAMT();
	}
	
	if (C_isNull(txtVAT_CODE.value))
	{
		txtVAT_NAME.value = "";
	} else {
	}
	
	if (C_isNull(txtCUST_CODE.value))
	{
		txtCUST_SEQ.value = "";
		txtCUST_NAME.value = "";

		var vBRAIN_GRP_SEQ = dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BRAIN_GRP_SEQ");
		if( (vBRAIN_GRP_SEQ=="0" || vBRAIN_GRP_SEQ=="") )
			txtRESET_SLIPNO.value = "";
	}
	
	if (C_isNull(txtBANK_CODE.value))
	{
		txtBANK_NAME.value = "";
		
		txtACCNO_CODE.value = "";
	}

	if (C_isNull(txtCARD_NO.value))
	{
		txtCARD_SEQ_B.value = "";
	}

	if (C_isNull(txtCHK_NO.value))
	{
		txtCHK_PUBL_DT.value = "";
		txtCHK_COLL_DT.value = "";
	}
	
	if (C_isNull(txtBILL_NO_S.value))
	{
		txtBILL_PUBL_DT.value = "";
		txtBILL_EXPR_DT.value = "";
	}
	
	if (C_isNull(txtBILL_NO_R.value))
	{
		txtBILL_PUBL_DT_R.value = "";
		txtBILL_EXPR_DT_R.value = "";
		txtBILL_CHG_EXPR_DT_R.value = "";
		txtBILL_COLL_DT_R.value = "";
	}
	

	if (C_isNull(txtREC_BILL_NO_S.value))
	{
		txtREC_BILL_PUBL_DT.value = "";
		txtREC_BILL_EXPR_DT.value = "";
	}
	
	if (C_isNull(txtREC_BILL_NO_R.value))
	{
		txtREC_BILL_PUBL_DT_R.value = "";
		txtREC_BILL_EXPR_DT_R.value = "";
		txtREC_BILL_PUBL_AMT_R.value = "";
		txtREC_BILL_DISH_DT_R.value = "";
		txtREC_BILL_TRUST_DT_R.value = "";
		txtREC_BILL_TRUST_BANK_CODE_R.value = "";
		txtREC_BILL_TRUST_BANK_NAME_R.value = "";
		txtREC_BILL_DISC_DT_R.value = "";
		txtREC_BILL_DISC_BANK_CODE_R.value = "";
		txtREC_BILL_DISC_BANK_NAME_R.value = "";
		txtREC_BILL_DISC_RAT_R.value = "";
		txtREC_BILL_DISC_AMT_R.value = "";
	}
	
	if (C_isNull(txtRESET_SLIPNO.value))
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_ID")		= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_IDSEQ")	= "";
	}
}

//각종 세부사항 Display 컨트롤에 따른 데이타 클리어
function Input_Detail_Clear()
{
	if(!vUpdate) {
		// 수정모드가 아니면 리턴...
		return;
	}

	//거래처코드
	if (
		(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CASH_MNG") == "F")
		&&
		(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CARD_MNG") == "F")
		&&
		(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CUST_CODE_MNG") == "F")
	)
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CUST_SEQ")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CUST_CODE")	= "";
	}
	_Debug(1);
		
	//거래처명
	if (
		(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CASH_MNG") == "F")
		&&
		(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CARD_MNG") == "F")
		&&
		(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CUST_CODE_MNG") == "F")
	)
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CUST_NAME")	= "";
	}
	_Debug(1);
	//은행코드
	if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BANK_MNG") == "F")
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BANK_CODE")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BANK_NAME")	= "";
	}
	_Debug(1);
	//계좌관리
	if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"ACCNO_MNG") == "F")
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "ACCNO")	= "";
	}
	_Debug(1);
	//카드번호
	if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CARD_SEQ_MNG") == "F")
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_SEQ_B")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_NO")	= "";
	}
	//당좌수표
	if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CHK_NO_MNG") == "T")
	{
	}
	else
	{ 
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CHK_NO")		= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CHK_PUBL_DT")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CHK_COLL_DT")	= "";
	}


	_Debug(5);
	//잔액관리설정
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"ACC_REMAIN_MNG") == "T") && (IsValidAccThisSideCurrent()))
	{
		
		txtRESET_SLIPNO.value = txtMAKE_SLIPNO.value+"-"+txtMAKE_SLIPLINE.value;
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_ID")		= dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_ID");
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_IDSEQ")	= dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_IDSEQ");
	}
	//잔액관리반제
	else if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"ACC_REMAIN_MNG") == "T") && (IsValidAccOSideCurrent()))
	{
		if(txtRESET_SLIPNO.value == (txtMAKE_SLIPNO.value+"-"+txtMAKE_SLIPLINE.value)) {
			txtRESET_SLIPNO.value = "";
			dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_ID")		= "";
			dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_IDSEQ")	= "";
		}
	} else {
		// 설정/반제 항목이 아니면 설정/반제전표번호(RESET_SLIPNO) 초기화...
		txtRESET_SLIPNO.value = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_ID")		= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_IDSEQ")	= "";
	}
_Debug(6);
	//지급어음설정
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BILL_NO_MNG") == "T") && (IsValidAccThisSideCurrent()))
	{
	}
	else
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_NO_S")			= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_PUBL_DT")		= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_EXPR_DT")		= "";
	}
	_Debug(1);
	//지급어음반제
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BILL_NO_MNG") == "T") && (IsValidAccOSideCurrent()))
	{
	}
	else
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_NO_R")			= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_PUBL_DT_R")		= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_EXPR_DT_R")		= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_CHG_EXPR_DT_R")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_COLL_DT_R")	= "";
	}
_Debug(1);
	//지급어음번호
	if ((C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_NO_S"))) && (C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_NO_R"))))
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_NO")				= "";
	}
	_Debug(1);
	//받을어음설정
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"REC_BILL_NO_MNG") == "T") && (IsValidAccThisSideCurrent()))
	{
	}
	else
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_NO_S")		= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_PUBL_DT")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_EXPR_DT")	= "";
	}
	_Debug(1);
	//받을어음반제
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"REC_BILL_NO_MNG") == "T") && (IsValidAccOSideCurrent()))
	{
	}
	else
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_NO_R")		= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_PUBL_DT_R")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_EXPR_DT_R")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_PUBL_AMT_R")= "";
	}
	_Debug(1);
	//받을어음번호
	if ((C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_NO_S"))) && (C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_NO_R"))))
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_NO")				= "";
	}
_Debug(1);
	//유가증권설정
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"SECU_MNG") == "T") && (IsValidAccThisSideCurrent()))
	{
	}
	else
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_REAL_SECU_NO_S")= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_PERSTOCK_AMT")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_PUBL_DT")		= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_EXPR_DT")		= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_INTR_RATE")		= "";
	}
	_Debug(1);
	//유가증권반제
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"SECU_MNG") == "T") && (IsValidAccOSideCurrent()))
	{
	}
	else
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_REAL_SECU_NO_R")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_PERSTOCK_AMT_R")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_PUBL_DT_R")			= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_EXPR_DT_R")			= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_INTR_RATE_R")		= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_SALE_AMT_R")		= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_SALE_DT_R")			= "";
	}
	_Debug(1);
	//유가증권번호
	if ((C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_REAL_SECU_NO_S"))) && (C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_REAL_SECU_NO_R"))))
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_REAL_SECU_NO")				= "";
	}
	
	//차입설정
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"LOAN_NO_MNG") == "T") && (IsValidAccThisSideCurrent()))
	{
	}
	else
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_REFUND_NO_S")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_REFUND_SEQ_S")	= "";

		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_REAL_LOAN_NO") = ""; 
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_NAME") = ""; 
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_KIND_CODE") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_EXPR_DT") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_FDT") = "";
	}
	_Debug(1);
	//차입반제(상환)
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"LOAN_NO_MNG") == "T") && (IsValidAccOSideCurrent()))
	{
	}
	else
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_REFUND_NO_R")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_REFUND_SEQ_R")	= "";

		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_REAL_LOAN_NO_R") = ""; 
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_NAME_R") = ""; 
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_KIND_CODE_R") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_EXPR_DT_R") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_FDT_R") = "";
	}
	_Debug(1);
	//차입/상환번호
	if (
		(C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_REFUND_NO_S"))) &&
		(C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_REFUND_NO_R"))) &&
		(C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_REFUND_NO_I")))
	)
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_REFUND_NO")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_REFUND_SEQ")= "";
	}
	_Debug(1);
	//적금불입 
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"DEPOSIT_PAY_MNG") == "T") && (IsValidAccThisSideCurrent()))
	{
		//설정반제아님...
	}
	else
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DEPOSIT_ACCNO")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "PAYMENT_SEQ")	= "";

		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "PAYMENT_SCH_DT")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "PAYMENT_SCH_AMT")= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "PAYMENT_DT")		= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "PAYMENT_AMT")	= "";
	}
	//고정자산 
	if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"FIXED_MNG") == "T")
	{
		//설정반제아님...
	}
	else
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "FIX_ASSET_SEQ")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "FIX_ASSET_MNG_NO")	= "";

		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "PAYMENT_SCH_DT")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "PAYMENT_SCH_AMT")= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "PAYMENT_DT")		= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "PAYMENT_AMT")	= "";
	}

_Debug(1);
	//대금지급조건 
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"PAY_CON_MNG") == "T") && (IsValidAccThisSideCurrent()))
	{
		//설정반제아님...
	}
	else
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "PAY_CON_CASH")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "PAY_CON_BILL")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "PAY_CON_BILL_DAYS")= "";
	}

	//어음만기일 
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BILL_EXPR_MNG") == "T") && (IsValidAccThisSideCurrent()))
	{
		//설정반제아님...
	}
	else
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "PAY_CON_BILL_DT")= "";
	}
	_Debug(1);
	//CP매입설정
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CP_NO_MNG") == "T") && (IsValidAccThisSideCurrent()))
	{
	}
	else
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_NO_S")			= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_PUBL_DT")		= "";   
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_EXPR_DT")		= "";   
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_DUSE_DT")		= "";   
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_PUBL_AMT")	= "";  
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_INCOME_AMT")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_PUBL_PLACE")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_PUBL_NAME")	= ""; 
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_INTR_RAT")	= "";  
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_CUST_SEQ")	= "";  
	}
	_Debug(1);
	//CP매입반제
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CP_NO_MNG") == "T") && (IsValidAccOSideCurrent()))
	{
	}
	else
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_NO_R")				= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_PUBL_DT_R")		= "";   
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_EXPR_DT_R")		= "";   
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_DUSE_DT_R")		= "";   
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_PUBL_AMT_R")		= "";  
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_INCOME_AMT_R")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_PUBL_PLACE_R")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_PUBL_NAME_R")		= ""; 
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_INTR_RAT_R")		= "";  
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_CUST_SEQ_R")		= "";  
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_RESET_AMT_R")		= "";  
	}
	_Debug(1);
	//CP매입번호
	if ((C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_NO_S"))) && (C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_NO_R"))))
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_NO")	= "";
	}

	//사원번호
	if (
		(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CASH_MNG") == "F")
		&&
		(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CARD_MNG") == "F")
		&&
		(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"EMP_NO_MNG") == "F")
	)
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "EMP_NO")		= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "EMP_NAME")	= "";
	}
	
	
	
	//현금영수증
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CASH_MNG") == "T") && (IsValidAccThisSideCurrent()))
	{
		//설정반제아님...
	}
	else
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CASH_SEQ")		= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CASH_CASHNO")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CASH_USE_DT")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CASH_TRADE_AMT")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CASH_REQ_TG")	= "";
	}
	_Debug(1);
	//신용카드
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CARD_MNG") == "T") && (IsValidAccThisSideCurrent()))
	{
		//설정반제아님...
	}
	else
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_SEQ")		= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_CARDNO")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_USE_DT")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_HAVE_PERS")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_TRADE_AMT")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_REQ_TG")	= "";
	}
_Debug(1);
	
}

//각종 세부사항 Display 컨트롤
function Input_Detail_Display()
{
	//거래처코드
	if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CUST_CODE_MNG") == "T")
	{
		if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CUST_CODE_MNG_TG") == "T")
		{
			document.all.divCUST_CODE.style.display	= "";
			D_Div_hideFocus(divCUST_CODE);
		}
		else
		{
			document.all.divCUST_CODE.style.display	= "none";
			D_Div_hideFocus(divCUST_CODE);
		}
	}
	else
	{
		document.all.divCUST_CODE.style.display	= "none";
		D_Div_hideFocus(divCUST_CODE);
	}
	
	//거래처명
	if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CUST_NAME_MNG") == "T")
	{
		if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CUST_NAME_MNG_TG") == "T")
		{
			document.all.divCUST_NAME.style.display	= "";
			D_Div_hideFocus(divCUST_NAME);
		}
		else
		{
			document.all.divCUST_NAME.style.display	= "none";
			D_Div_hideFocus(divCUST_NAME);
		}
	}
	else
	{
		document.all.divCUST_NAME.style.display	= "none";
		D_Div_hideFocus(divCUST_NAME);
	}
	
	//은행코드
	if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BANK_MNG") == "T")
	{
		document.all.divBANK_CODE.style.display	= "";
		D_Div_hideFocus(divBANK_CODE);
	}
	else
	{
		document.all.divBANK_CODE.style.display	= "none";
		D_Div_hideFocus(divBANK_CODE);
	}
	
	//계좌관리
	if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"ACCNO_MNG") == "T")
	{
		document.all.divACCNO_CODE.style.display	= "";
		D_Div_hideFocus(divACCNO_CODE);
	}
	else
	{
		document.all.divACCNO_CODE.style.display	= "none";
		D_Div_hideFocus(divACCNO_CODE);
	}

	//카드번호
	if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CARD_SEQ_MNG") == "T")
	{
		document.all.divCARD_SEQ.style.display	= "";
		D_Div_hideFocus(divCARD_SEQ);
	}
	else
	{
		document.all.divCARD_SEQ.style.display	= "none";
		D_Div_hideFocus(divCARD_SEQ);
	}
	
	//당좌수표
	if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CHK_NO_MNG") == "T")
	{
		document.all.divCHK_NO.style.display	= "";
		D_Div_hideFocus(divCHK_NO);

		if(IsValidAccOSideCurrent()) {
			// 발행
			txtCHK_PUBL_DT.readOnly = !vUpdate;
			btnCHK_PUBL_DT.disabled	= !vUpdate;
			txtCHK_PUBL_DT.style.background	= "white";

			txtCHK_COLL_DT.readOnly = true;
			btnCHK_COLL_DT.disabled	= true;
			txtCHK_COLL_DT.style.background	= "#EFEFEF";
		} else if(IsValidAccThisSideCurrent()) {
			// 회수
			txtCHK_PUBL_DT.readOnly = true;
			btnCHK_PUBL_DT.disabled	= true;
			txtCHK_PUBL_DT.style.background	= "#EFEFEF";

			txtCHK_COLL_DT.readOnly = !vUpdate;
			btnCHK_COLL_DT.disabled	= !vUpdate;
			txtCHK_COLL_DT.style.background	= "white";
		}
	}
	else
	{
		document.all.divCHK_NO.style.display	= "none";
		D_Div_hideFocus(divCHK_NO);
	}
	
	//지급어음설정
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BILL_NO_MNG") == "T") && (IsValidAccThisSideCurrent()))
	{
		document.all.divBILL_NO.style.display	= "";
		D_Div_hideFocus(divBILL_NO);
	}
	else
	{
		document.all.divBILL_NO.style.display	= "none";
		D_Div_hideFocus(divBILL_NO);
	}
	
	//지급어음반제
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BILL_NO_MNG") == "T") && (IsValidAccOSideCurrent()))
	{
		document.all.divBILL_NO_R.style.display	= "";
		D_Div_hideFocus(divBILL_NO_R);
	}
	else
	{
		document.all.divBILL_NO_R.style.display	= "none";
		D_Div_hideFocus(divBILL_NO_R);
	}
	
	//받을어음설정
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"REC_BILL_NO_MNG") == "T") && (IsValidAccThisSideCurrent()))
	{
		document.all.divREC_BILL_NO.style.display	= "";
		D_Div_hideFocus(divREC_BILL_NO);
	}
	else
	{
		document.all.divREC_BILL_NO.style.display	= "none";
		D_Div_hideFocus(divREC_BILL_NO);
	}
	
	//받을어음반제
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"REC_BILL_NO_MNG") == "T") && (IsValidAccOSideCurrent()))
	{
		document.all.divREC_BILL_NO_R.style.display	= "";
		D_Div_hideFocus(divREC_BILL_NO_R);
	}
	else
	{
		document.all.divREC_BILL_NO_R.style.display	= "none";
		D_Div_hideFocus(divREC_BILL_NO_R);
	}

	//유가증권설정
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"SECU_MNG") == "T") && (IsValidAccThisSideCurrent()))
	{
		document.all.divSECU_NO.style.display	= "";
		D_Div_hideFocus(divSECU_NO);
	}
	else
	{
		document.all.divSECU_NO.style.display	= "none";
		D_Div_hideFocus(divSECU_NO);
	}

	//유가증권반제
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"SECU_MNG") == "T") && (IsValidAccOSideCurrent()))
	{
		document.all.divSECU_NO_R.style.display	= "";
		D_Div_hideFocus(divSECU_NO_R);
	}
	else
	{
		document.all.divSECU_NO_R.style.display	= "none";
		D_Div_hideFocus(divSECU_NO_R);
	}

	//차입설정(차입)
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"LOAN_NO_MNG") == "T") && (IsValidAccThisSideCurrent()))
	{
		document.all.divLOAN_NO_S.style.display	= "";
		D_Div_hideFocus(divLOAN_NO_S);
	}
	else
	{
		document.all.divLOAN_NO_S.style.display	= "none";
		D_Div_hideFocus(divLOAN_NO_S);
	}

	//차입반제(상환)
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"LOAN_NO_MNG") == "T") && (IsValidAccOSideCurrent()))
	{
		document.all.divLOAN_NO_R.style.display	= "";
		D_Div_hideFocus(divLOAN_NO_R);
	}
	else
	{
		document.all.divLOAN_NO_R.style.display	= "none";
		D_Div_hideFocus(divLOAN_NO_R);
	}
	
	//예적금 설정(반제없음)
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"DEPOSIT_PAY_MNG") == "T") && (IsValidAccThisSideCurrent()))
	{
		document.all.divDEPOSIT_PAYMENT.style.display	= "";
		D_Div_hideFocus(divDEPOSIT_PAYMENT);
	}
	else
	{
		document.all.divDEPOSIT_PAYMENT.style.display	= "none";
		D_Div_hideFocus(divDEPOSIT_PAYMENT);
	}

	//고정자산
	if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"FIXED_MNG") == "T")
	{
		document.all.divFIX.style.display	= "";
		D_Div_hideFocus(divFIX);
	}
	else
	{
		document.all.divFIX.style.display	= "none";
		D_Div_hideFocus(divFIX);
	}



	//대금지급조건
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"PAY_CON_MNG") == "T") && (IsValidAccThisSideCurrent()))
	{
		document.all.divPAY_CON.style.display	= "";
		D_Div_hideFocus(divPAY_CON);
	}
	else
	{
		document.all.divPAY_CON.style.display	= "none";
		D_Div_hideFocus(divPAY_CON);
	}

	//대금지불어음만기일
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BILL_EXPR_MNG") == "T") && (IsValidAccThisSideCurrent()))
	{
		document.all.divPAY_CON_BILL_DT.style.display	= "";
		D_Div_hideFocus(divPAY_CON_BILL_DT);
	}
	else
	{
		document.all.divPAY_CON_BILL_DT.style.display	= "none";
		D_Div_hideFocus(divPAY_CON_BILL_DT);
	}
	
	//CP매입설정
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CP_NO_MNG") == "T") && (IsValidAccThisSideCurrent()))
	{
		document.all.divCP_NO.style.display	= "";
		D_Div_hideFocus(divCP_NO);
	}
	else
	{
		document.all.divCP_NO.style.display	= "none";
		D_Div_hideFocus(divCP_NO);
	}

	//CP매입반제
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CP_NO_MNG") == "T") && (IsValidAccOSideCurrent()))
	{
		document.all.divCP_NO_R.style.display	= "";
		D_Div_hideFocus(divCP_NO_R);
	}
	else
	{
		document.all.divCP_NO_R.style.display	= "none";
		D_Div_hideFocus(divCP_NO_R);
	}

	//사원번호
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"EMP_NO_MNG") == "T") && (IsValidAccThisSideCurrent()))
	{
		document.all.divEMP_NO.style.display	= "";
		D_Div_hideFocus(divEMP_NO);
	}
	else
	{
		document.all.divEMP_NO.style.display	= "none";
		D_Div_hideFocus(divEMP_NO);
	}

	//지급희망일
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"ANTICIPATION_DT_MNG") == "T") && (IsValidAccThisSideCurrent()))
	{
		document.all.divANTICIPATION_DATE.style.display	= "";
		D_Div_hideFocus(divANTICIPATION_DATE);
	}
	else
	{
		document.all.divANTICIPATION_DATE.style.display	= "none";
		D_Div_hideFocus(divANTICIPATION_DATE);
	}

	//현금영수증
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CASH_MNG") == "T") && (IsValidAccThisSideCurrent()))
	{
		//거래처코드
		document.all.divCUST_CODE.style.display	= "";
		D_Div_hideFocus(divCUST_CODE);
		
		//거래처명		
		document.all.divCUST_NAME.style.display	= "";
		D_Div_hideFocus(divCUST_NAME);
		
		//사원번호		
		document.all.divEMP_NO.style.display	= "";
		D_Div_hideFocus(divEMP_NO);
		
		document.all.divCASH.style.display	= "";
		D_Div_hideFocus(divCASH);
	}
	else
	{
		document.all.divCASH.style.display	= "none";
		D_Div_hideFocus(divCASH);
	}
	
	//신용카드
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CARD_MNG") == "T") && (IsValidAccThisSideCurrent()))
	{
		//거래처코드
		document.all.divCUST_CODE.style.display	= "";
		D_Div_hideFocus(divCUST_CODE);
		
		//거래처명		
		document.all.divCUST_NAME.style.display	= "";
		D_Div_hideFocus(divCUST_NAME);
		
		//사원번호			
		document.all.divEMP_NO.style.display	= "";
		D_Div_hideFocus(divEMP_NO);
		
		document.all.divCARD.style.display	= "";
		D_Div_hideFocus(divCARD);
	}
	else
	{
		document.all.divCARD.style.display	= "none";
		D_Div_hideFocus(divCARD);
	}

	// 잔액관리
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"ACC_REMAIN_MNG") == "T") && (IsValidAccOSideCurrent()))
	{
		if(
			(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BILL_NO_MNG") == "T") ||     // 지급어음
			(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"REC_BILL_NO_MNG") == "T") || // 받을어음
			(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"SECU_MNG") == "T") ||        // 유가증권
			(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CP_NO_MNG") == "T")          // CP매입
		) {
			document.all.divRESET_SLIPNO.style.display	= "";
			btnRESET_SLIPNO.style.display = "none";
			txtRESET_SLIPNO.readOnly = true;
			D_Div_hideFocus(divRESET_SLIPNO);
		} else if(
			(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"LOAN_NO_MNG") == "T")
		){
			// 차입 : 설정전표를 직접 찾아 입력한다.
			document.all.divRESET_SLIPNO.style.display	= "";
			btnRESET_SLIPNO.style.display	= "";
			txtRESET_SLIPNO.readOnly = !vUpdate;
			D_Div_hideFocus(divRESET_SLIPNO);
		} else {
			// 기타 : 설정전표를 직접 찾아 입력한다.
			document.all.divRESET_SLIPNO.style.display	= "";
			btnRESET_SLIPNO.style.display	= "";
			txtRESET_SLIPNO.readOnly = !vUpdate;
			D_Div_hideFocus(divRESET_SLIPNO);
		}
	} else {
		document.all.divRESET_SLIPNO.style.display	= "none";
		btnRESET_SLIPNO.style.display	= "none";
		txtRESET_SLIPNO.readOnly = true;
		D_Div_hideFocus(divRESET_SLIPNO);
	}

	if(!vUpdate) {
		btnRESET_SLIPNO.style.display = "none";
		txtRESET_SLIPNO.readOnly = true;
	}
	
	// 관리항목(문자)
	if ( (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"MNG_NAME_CHAR1") != "") ) {		
		document.all.divMNG_ITEM_CHAR1.style.display	= "";
		D_Div_hideFocus(divMNG_ITEM_CHAR1);
	} else {
		document.all.divMNG_ITEM_CHAR1.style.display	= "none";
		D_Div_hideFocus(divMNG_ITEM_CHAR1);
	}
	
	if ( (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"MNG_NAME_CHAR2") != "") ) {		
		document.all.divMNG_ITEM_CHAR2.style.display	= "";
		D_Div_hideFocus(divMNG_ITEM_CHAR2);
	} else {
		document.all.divMNG_ITEM_CHAR2.style.display	= "none";
		D_Div_hideFocus(divMNG_ITEM_CHAR2);
	}

	if ( (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"MNG_NAME_CHAR3") != "") ) {		
		document.all.divMNG_ITEM_CHAR3.style.display	= "";
		D_Div_hideFocus(divMNG_ITEM_CHAR3);
	} else {
		document.all.divMNG_ITEM_CHAR3.style.display	= "none";
		D_Div_hideFocus(divMNG_ITEM_CHAR3);
	}

	if ( (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"MNG_NAME_CHAR4") != "") ) {		
		document.all.divMNG_ITEM_CHAR4.style.display	= "";
		D_Div_hideFocus(divMNG_ITEM_CHAR4);
	} else {
		document.all.divMNG_ITEM_CHAR4.style.display	= "none";
		D_Div_hideFocus(divMNG_ITEM_CHAR4);
	}
	
	// 관리항목(숫자)
	if ( (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"MNG_NAME_NUM1") != "") ) {		
		document.all.divMNG_ITEM_NUM1.style.display	= "";
		D_Div_hideFocus(divMNG_ITEM_NUM1);
	} else {
		document.all.divMNG_ITEM_NUM1.style.display	= "none";
		D_Div_hideFocus(divMNG_ITEM_NUM1);
	}
	
	if ( (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"MNG_NAME_NUM2") != "") ) {		
		document.all.divMNG_ITEM_NUM2.style.display	= "";
		D_Div_hideFocus(divMNG_ITEM_NUM2);
	} else {
		document.all.divMNG_ITEM_NUM2.style.display	= "none";
		D_Div_hideFocus(divMNG_ITEM_NUM2);
	}

	if ( (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"MNG_NAME_NUM3") != "") ) {		
		document.all.divMNG_ITEM_NUM3.style.display	= "";
		D_Div_hideFocus(divMNG_ITEM_NUM3);
	} else {
		document.all.divMNG_ITEM_NUM3.style.display	= "none";
		D_Div_hideFocus(divMNG_ITEM_NUM3);
	}

	if ( (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"MNG_NAME_NUM4") != "") ) {		
		document.all.divMNG_ITEM_NUM4.style.display	= "";
		D_Div_hideFocus(divMNG_ITEM_NUM4);
	} else {
		document.all.divMNG_ITEM_NUM4.style.display	= "none";
		D_Div_hideFocus(divMNG_ITEM_NUM4);
	}
	
	// 관리항목(날짜)
	if ( (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"MNG_NAME_DT1") != "") ) {		
		document.all.divMNG_ITEM_DT1.style.display	= "";
		D_Div_hideFocus(divMNG_ITEM_DT1);
	} else {
		document.all.divMNG_ITEM_DT1.style.display	= "none";
		D_Div_hideFocus(divMNG_ITEM_DT1);
	}
	
	if ( (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"MNG_NAME_DT2") != "") ) {		
		document.all.divMNG_ITEM_DT2.style.display	= "";
		D_Div_hideFocus(divMNG_ITEM_DT2);
	} else {
		document.all.divMNG_ITEM_DT2.style.display	= "none";
		D_Div_hideFocus(divMNG_ITEM_DT2);
	}

	if ( (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"MNG_NAME_DT3") != "") ) {		
		document.all.divMNG_ITEM_DT3.style.display	= "";
		D_Div_hideFocus(divMNG_ITEM_DT3);
	} else {
		document.all.divMNG_ITEM_DT3.style.display	= "none";
		D_Div_hideFocus(divMNG_ITEM_DT3);
	}

	if ( (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"MNG_NAME_DT4") != "") ) {		
		document.all.divMNG_ITEM_DT4.style.display	= "";
		D_Div_hideFocus(divMNG_ITEM_DT4);
	} else {
		document.all.divMNG_ITEM_DT4.style.display	= "none";
		D_Div_hideFocus(divMNG_ITEM_DT4);
	}
}

function Input_Error_Check()
{
	if(!vUpdate) {
		// 수정모드가 아니면 리턴...
		return;
	}

	if(
		!(
			( dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BRAIN_SLIP_SEQ1")=="" || dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BRAIN_SLIP_SEQ1")=="0" )
			||
			( dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BRAIN_SLIP_SEQ2")=="" || dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BRAIN_SLIP_SEQ2")=="0" )
		)
	) {
		// 표준적요 전표입력에서는 입력시 필수 체크를 할지 선택..
		// 현재는 입력체크 안함
		return;
	}

	if (C_isNull(txtMAKE_DT_TRANS.value))
	{
		C_msgOk("발의일자를 먼저 입력하세요.", "확인");
		txtMAKE_DT_TRANS.focus();
		return;
	}
	
	if (cboSLIP_KIND_TAG.value=='%')
	{
		C_msgOk("전표분류코드를 먼저 선택하세요.", "확인");
		cboSLIP_KIND_TAG.focus();
		return;
	}

	if (C_isNull(txtCOMPANY_NAME.value))
   	{
   		C_msgOk("사업장은 반드시 입력해야 합니다.", "확인");
   		vError_Flag = "T";
		vOBJ = txtCOMPANY_NAME;
   		return;
   	}

	if (C_isNull(txtMAKE_DEPT_NAME.value))
   	{
   		C_msgOk("작성부서는 반드시 입력해야 합니다.", "확인");
   		vError_Flag = "T";
		vOBJ = txtMAKE_DEPT_NAME;
   		return;
   	}

	if (C_isNull(txtCHARGE_PERS_NAME.value))
   	{
   		C_msgOk("관리담당는 반드시 입력해야 합니다.", "확인");
   		vError_Flag = "T";
		vOBJ = txtCHARGE_PERS_NAME;
   		return;
   	}

	if (C_isNull(txtINOUT_DEPT_NAME.value))
   	{
   		C_msgOk("출납부서는 반드시 입력해야 합니다.", "확인");
   		vError_Flag = "T";
		vOBJ = txtINOUT_DEPT_NAME;
   		return;
   	}

	if (C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"ACC_CODE")))
   	{
   		C_msgOk("계정과목은 반드시 입력해야 합니다.", "확인");
   		vError_Flag = "T";
		vOBJ = txtACC_CODE;
   		return;
   	}
   	
   	if (C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"SUMMARY1")))
   	{
   		C_msgOk("적요1은 반드시 입력해야 합니다.", "확인");
   		vError_Flag = "T";
		vOBJ = txtSUMMARY1;
   		return;
   	}
   	
   	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"DB_AMT") == 0) && (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CR_AMT") == 0))
   	{
		if( dsSLIP_H.NameString(dsSLIP_H.CountRow, "MAKE_SLIPCLS") == "2" && dsSLIP_D.RowPosition == 1 ) {
			// 전표구분 현금
			// 차/대금액이 모두 "0" 허용. 저장시에는 "0" 허용 안됨
		} else if (!C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"RCPTBILL_CLS")) && (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"VATOCCUR_CLS") == "F") ) {
			// 부가세계정 라인이고 부가세발생 없음 설정이면
			// 차/대금액이 모두 "0" 허용. 저장시에도 "0" 허용
		} else {
	   		C_msgOk("차/대변 금액중	하나는 반드시 입력해야 합니다.", "확인");
	   		vError_Flag = "T";
			vOBJ = txtDB_AMT_D;
	   		return;
	   	}
   	}

   	if (C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"TAX_COMP_CODE")))
   	{
   		C_msgOk("세무사업장코드는 반드시 입력해야 합니다.", "확인");
   		vError_Flag = "T";
		vOBJ = txtTAX_COMP_CODE;
   		return;
   	}
   	
   	if (C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"DEPT_CODE")))
   	{
   		C_msgOk("귀속부서는 반드시 입력해야 합니다.", "확인");
   		vError_Flag = "T";
		vOBJ = txtDEPT_CODE;
   		return;
   	}
   	
   	if (C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CLASS_CODE")))
   	{
   		C_msgOk("부문코드는 반드시 입력해야 합니다.", "확인");
   		vError_Flag = "T";
		vOBJ = txtCLASS_CODE;
   		return;
   	}
   	
   	if (!C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"RCPTBILL_CLS")))
   	{
   		if (C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"VAT_DT")))
   		{
   			C_msgOk("증빙일자는 반드시 입력해야 합니다.", "확인");
   			vError_Flag = "T";
			vOBJ = txtVAT_DT;
	   		return;
   		}
   		
   		if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"SUPAMT") == "0")
   		{
   			C_msgOk("공급가액은 반드시 입력해야 합니다.", "확인");
   			vError_Flag = "T";
			vOBJ = txtSUPAMT;
	   		return;
   		}
   		
   		if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"VATOCCUR_CLS") == "T") && (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"VATAMT") == "0"))
   		{
   			C_msgOk("부가세를 반드시 입력해야 합니다.", "확인");
   			vError_Flag = "T";
			vOBJ = txtVATAMT;
	   		return;
   		}
   	}
}

// 이벤트관련---------------------------------------------------------------//
//발의사업장
function txtMAKE_COMP_CODE_onblur()
{
	if (txtMAKE_COMP_CODE_F.value == txtMAKE_COMP_CODE.value) return;
	
	if (C_isNull(txtMAKE_COMP_CODE.value))
	{
		Input_Clear();
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtMAKE_COMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE1", lrArgs,"T");

	if (lrRet == null) return;

	if (txtMAKE_COMP_CODE_F.value == txtMAKE_COMP_CODE.value) return;
		
	txtMAKE_COMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	txtINOUT_DEPT_CODE.value = lrRet.get("DEPT_CODE");
	txtINOUT_DEPT_NAME.value = lrRet.get("DEPT_NAME");
	txtMAKE_DEPT_CODE.value = "";
	txtMAKE_DEPT_NAME.value = "";
	txtMAKE_SEQ.value = "";
	txtMAKE_SLIPNO.value = "";
	txtCHARGE_PERS.value = "";
	txtCHARGE_PERS_NAME.value = "";

	if(
		txtMAKE_DT_TRANS.value==dsSLIP_H.NameString(1,"MAKE_DT_TRANS") &&
		txtMAKE_COMP_CODE.value==dsSLIP_H.NameString(1,"MAKE_COMP_CODE") &&
		cboSLIP_KIND_TAG.value==dsSLIP_H.NameString(1,"SLIP_KIND_TAG")
	) {
		txtMAKE_SEQ.value	= dsSLIP_H.NameString(1,"MAKE_SEQ");
		txtMAKE_SLIPNO.value= dsSLIP_H.NameString(1,"MAKE_SLIPNO");
	}
}

function btnMAKE_COMP_CODE_onClick()
{
	txtMAKE_COMP_CODE_F.value = txtMAKE_COMP_CODE.value
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE1", lrArgs,"T");

	if (lrRet == null) return;

	if (txtMAKE_COMP_CODE_F.value == lrRet.get("COMP_CODE")) return;
	
	txtMAKE_COMP_CODE.value	 = lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	 = lrRet.get("COMPANY_NAME");
	txtINOUT_DEPT_CODE.value = lrRet.get("DEPT_CODE");
	txtINOUT_DEPT_NAME.value = lrRet.get("DEPT_NAME");
	txtMAKE_DEPT_CODE.value  = "";
	txtMAKE_DEPT_NAME.value  = "";
	txtMAKE_SEQ.value = "";
	txtMAKE_SLIPNO.value = "";
	txtCHARGE_PERS.value = "";
	txtCHARGE_PERS_NAME.value = "";

	if(
		txtMAKE_DT_TRANS.value==dsSLIP_H.NameString(1,"MAKE_DT_TRANS") &&
		txtMAKE_COMP_CODE.value==dsSLIP_H.NameString(1,"MAKE_COMP_CODE") &&
		cboSLIP_KIND_TAG.value==dsSLIP_H.NameString(1,"SLIP_KIND_TAG")
	) {
		txtMAKE_SEQ.value	= dsSLIP_H.NameString(1,"MAKE_SEQ");
		txtMAKE_SLIPNO.value= dsSLIP_H.NameString(1,"MAKE_SLIPNO");
	}
}

//발의일자
function txtMAKE_DT_TRANS_onblur()
{
	if (txtMAKE_DT_TRANS_F.value == txtMAKE_DT_TRANS.value) return;

	if (!S_isValidDate(txtMAKE_DT_TRANS.value))
	{
		C_msgOk(ERR_MSG);
		txtMAKE_DT_TRANS.focus();
		return;
	}
	
	txtMAKE_DT.value = txtMAKE_DT_TRANS.value.substr(0,4)+"-"+txtMAKE_DT_TRANS.value.substr(4,2)+"-"+txtMAKE_DT_TRANS.value.substr(6,2);
	txtMAKE_SEQ.value = "";
	txtMAKE_SLIPNO.value = "";

	if(
		txtMAKE_DT_TRANS.value==dsSLIP_H.NameString(1,"MAKE_DT_TRANS") &&
		txtMAKE_COMP_CODE.value==dsSLIP_H.NameString(1,"MAKE_COMP_CODE") &&
		cboSLIP_KIND_TAG.value==dsSLIP_H.NameString(1,"SLIP_KIND_TAG")
	) {
		txtMAKE_SEQ.value	= dsSLIP_H.NameString(1,"MAKE_SEQ");
		txtMAKE_SLIPNO.value= dsSLIP_H.NameString(1,"MAKE_SLIPNO");
	}
}

function btnMAKE_DT_onClick()
{
	txtMAKE_DT_TRANS_F.value = txtMAKE_DT_TRANS.value;
	
	C_Calendar("MAKE_DT", "D", txtMAKE_DT.value);
	
	if (txtMAKE_DT_TRANS_F.value == txtMAKE_DT_TRANS.value) return;
	
	txtMAKE_SEQ.value = "";
	txtMAKE_SLIPNO.value = "";

	if(
		txtMAKE_DT_TRANS.value==dsSLIP_H.NameString(1,"MAKE_DT_TRANS") &&
		txtMAKE_COMP_CODE.value==dsSLIP_H.NameString(1,"MAKE_COMP_CODE") &&
		cboSLIP_KIND_TAG.value==dsSLIP_H.NameString(1,"SLIP_KIND_TAG")
	) {
		txtMAKE_SEQ.value	= dsSLIP_H.NameString(1,"MAKE_SEQ");
		txtMAKE_SLIPNO.value= dsSLIP_H.NameString(1,"MAKE_SLIPNO");
	}
}

//전표분류
function cboSLIP_KIND_TAG_onChange()
{
	txtMAKE_SEQ.value = "";
	txtMAKE_SLIPNO.value = "";

	if(
		txtMAKE_DT_TRANS.value==dsSLIP_H.NameString(1,"MAKE_DT_TRANS") &&
		txtMAKE_COMP_CODE.value==dsSLIP_H.NameString(1,"MAKE_COMP_CODE") &&
		cboSLIP_KIND_TAG.value==dsSLIP_H.NameString(1,"SLIP_KIND_TAG")
	) {
		txtMAKE_SEQ.value	= dsSLIP_H.NameString(1,"MAKE_SEQ");
		txtMAKE_SLIPNO.value= dsSLIP_H.NameString(1,"MAKE_SLIPNO");
	}
}

//발의순번
function txtMAKE_SEQ_onblur()
{
	if (txtMAKE_SEQ_F.value == txtMAKE_SEQ.value) return;
	
	if (dsSLIP_D.IsUpdated || G_isChanged(dsSLIP_D.id))
	{
		var	vRet	= C_msgYesNo("변경된 내용이 있습니다.<br>발의일자를 변경하면 현재 작업한 내용이 취소됩니다.<br><br>그래도 사업장을 변경하시겠습니까?", "확인");
		if (vRet == "N")
		{
			vMAKE_COMP_CODE = "";
			vMAKE_DT_TRANS = "";
			vMAKE_SEQ = "";
			
			G_Load(dsSLIP_H, null);
			D_Div_ReadOnly(divSLIP_D, true);
			Input_Clear();
		}
		else
		{
			txtMAKE_SEQ.value = txtMAKE_SEQ_F.value;
		}
	}
}

//회기마감
function chkDayClose(bMsgView)
{
	G_Load(dsDAY_CLOSE, null);
	if(dsDAY_CLOSE.CountRow==0) {
		if(bMsgView) C_msgOk("해당일자의 사업장별 마감정보가 등록되지 않았습니다.", "확인");
		vAccClse = false;
		vMonClse = false;
		vDayClse = false;
		vDeptClse = false;
		return false;
	}
	
	if(dsDAY_CLOSE.NameString(dsDAY_CLOSE.RowPosition, "ACC_CLSE_CLS") == "T")
	{
		if(bMsgView) C_msgOk("해당일자는 회기마감되었습니다.", "확인");
		vAccClse = true;
		return false;
	} else {
		vAccClse = false;
	}
	
	if(dsDAY_CLOSE.NameString(dsDAY_CLOSE.RowPosition, "MON_CLSE_CLS") == "T")
	{
		if(bMsgView) C_msgOk("해당일자는 월마감되었습니다.", "확인");
		vMonClse = true;
		return false;
	} else {
		vMonClse = false;
	}
	
	if(dsDAY_CLOSE.NameString(dsDAY_CLOSE.RowPosition, "DAY_CLSE_CLS") == "T")
	{
		if(bMsgView) C_msgOk("해당일자는 일마감되었습니다.", "확인");
		vDayClse = true;
		return false;
	} else {
		vDayClse = false;
	}
	
	if(dsDAY_CLOSE.NameString(dsDAY_CLOSE.RowPosition, "DEPT_CLSE_CLS") == "T")
	{		
		if(bMsgView) C_msgOk(txtMAKE_DEPT_NAME.value+"의 전표입력기간이 종료되었습니다.<BR>* 전표입력가능기간 : ("+dsDAY_CLOSE.NameString(dsDAY_CLOSE.RowPosition, "INPUT_DT")+")", "확인");
		vDeptClse = true;
		return false;
	} else {
		vDeptClse = false;
	}
	
	return true;
}

//전표검색
function btnMAKE_SLIPNO_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("MAKE_COMP_CODE", txtMAKE_COMP_CODE.value);
	lrArgs.set("MAKE_DEPT_CODE", txtMAKE_DEPT_CODE.value);
	
	if (C_isNull(txtMAKE_DT.value))
	{
		lrArgs.set("MAKE_DT_F", txtMAKE_DT.value);
		lrArgs.set("MAKE_DT_T", txtMAKE_DT.value);
	}
	else
	{
		lrArgs.set("MAKE_DT_F", txtMAKE_DT_TRANS.value);//.substring(0,6)+"-01");
		lrArgs.set("MAKE_DT_T", txtMAKE_DT_TRANS.value);
	}
	
	lrArgs.set("SLIP_KIND_TAG", cboSLIP_KIND_TAG.value);

	if (C_isNull(txtMAKE_DT.value))
	{
		lrRet = C_LOV("T_SLIP_SEARCH1", lrArgs, "F");
	}
	else
	{
		lrRet = C_LOV("T_SLIP_SEARCH1", lrArgs, "T");
	}

	if (lrRet == null) return;
	
	if (dsSLIP_D.IsUpdated || G_isChanged(dsSLIP_D.id))
	{
		var	vRet	= C_msgYesNoCancel("변경된 내용이 있습니다.<br><br>" + G_MSG_SAVE, "저장");
		if (vRet == "Y")
		{
			if(!btnsave_proc_onclick()) return;
		}
		else if (vRet == "C")
		{
			return;
		}
	}

	txtMAKE_COMP_CODE.value	= lrRet.get("MAKE_COMP_CODE");
	txtMAKE_DT.value		= lrRet.get("MAKE_DT");
	txtMAKE_DT_TRANS.value	= lrRet.get("MAKE_DT_TRANS");
	txtMAKE_SEQ.value		= lrRet.get("MAKE_SEQ");
	cboSLIP_KIND_TAG.value	= lrRet.get("SLIP_KIND_TAG");
	
	vMAKE_COMP_CODE			= lrRet.get("MAKE_COMP_CODE");
	vMAKE_DT_TRANS			= lrRet.get("MAKE_DT_TRANS");
	vMAKE_SEQ				= lrRet.get("MAKE_SEQ");
	vSLIP_KIND_TAG			= lrRet.get("SLIP_KIND_TAG");
	
	G_Load(dsSLIP_H, null);
}

//전표구분
function cboMAKE_SLIPCLS_onChange()
{
	if (dsSLIP_H.CountRow == 0)
	{
		//C_msgOk("먼저 새전표 생성후 라인추가를 하세요.", "확인");
		return;
	}
	var vUpdateOrg = vUpdate;
	vUpdate = false;

	// 현금에서 대체, 자금으로 변경..
	if(
		dsSLIP_H.NameString(dsSLIP_H.CountRow, "MAKE_SLIPCLS") == "2"
		&&
		cboMAKE_SLIPCLS.value != "2"
	) {
		G_deleteRow(dsSLIP_D, 1);
		Make_Slipline();
	}
	// 대체, 자금에서 현금으로 변경..
	else if(
		dsSLIP_H.NameString(dsSLIP_H.CountRow, "MAKE_SLIPCLS") != "2"
		&&
		cboMAKE_SLIPCLS.value == "2"
	) {
		G_insertRow(dsSLIP_D,1);
		
		if(dsSLIP_D.RowPosition == 1) {
			// 전표구분 현금
			txtACC_CODE_F.value = "";
			txtACC_CODE.value = vCashAccCode;
			txtACC_CODE_onblur();
			txtSUMMARY1.value = "현금";
			MakeDB_Equal_CR(1);
		}
		dsSLIP_D.RowMark(1) = 0;
		dsSLIP_D.RowPosition = 2;
		txtACC_CODE.focus();
	}
	// 대체, 자금끼리 변경..
	else {
		// NULL;
	}

	vUpdate = vUpdateOrg;
	dsSLIP_H.NameString(dsSLIP_H.CountRow, "MAKE_SLIPCLS") = cboMAKE_SLIPCLS.value;
}

//출납부서
function txtINOUT_DEPT_NAME_onblur()
{
	// 입력값이 이전값과 같으면 리턴
	if (txtINOUT_DEPT_NAME_F.value == txtINOUT_DEPT_NAME.value) return;
	
	// 입력값이 ''이면 리턴
	if (C_isNull(txtINOUT_DEPT_NAME.value))
	{
		txtINOUT_DEPT_CODE.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("COMP_CODE", txtMAKE_COMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtINOUT_DEPT_NAME.value);

	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE3", lrArgs,"T");
	
	// 팝업취소(X)하면 이전값으로 복원후 리턴
	if (lrRet == null) {
		txtINOUT_DEPT_NAME.value = txtINOUT_DEPT_NAME_F.value;
		return;
	}
	
	txtINOUT_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtINOUT_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
}

function btnINOUT_DEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtMAKE_COMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");

	//lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"T");
	lrRet = C_LOV_NEW("T_DEPT_CODE3", txtINOUT_DEPT_NAME, lrArgs,"T");

	if (lrRet == null) return;

	txtINOUT_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtINOUT_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
}

//발의부서
function btnMAKE_DEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtMAKE_COMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_DEPT_CODE4", lrArgs,"T");

	if (lrRet == null) return;

	txtMAKE_DEPT_CODE.value		= lrRet.get("DEPT_CODE");
	txtMAKE_DEPT_NAME.value		= lrRet.get("DEPT_NAME");
	txtCHARGE_PERS.value		= lrRet.get("CHARGE_PERS");
	txtCHARGE_PERS_NAME.value	= lrRet.get("CHARGE_PERS_NAME");
	G_Load(dsCLASS_CODE, null);
}

//관리담당
function txtCHARGE_PERS_NAME_onblur()
{
	if (txtCHARGE_PERS_NAME_F.value == txtCHARGE_PERS_NAME.value) return;
	
	if (C_isNull(txtCHARGE_PERS_NAME.value))
	{
		txtCHARGE_PERS_NAME.value = "";
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtCHARGE_PERS_NAME.value);

	lrRet = C_AutoLov(dsLOV,"Z_AUTHORITY_USER02", lrArgs,"T");

	if (lrRet == null) {
		txtCHARGE_PERS_NAME.value = txtCHARGE_PERS_NAME_F.value;
		return;
	}
	
	txtCHARGE_PERS.value	= lrRet.get("EMPNO");
	txtCHARGE_PERS_NAME.value	= lrRet.get("NAME");
}

function btnCHARGE_PERS_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtMAKE_COMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("Z_AUTHORITY_USER02", lrArgs,"T");

	if (lrRet == null) return;

	txtCHARGE_PERS.value	= lrRet.get("EMPNO");
	txtCHARGE_PERS_NAME.value	= lrRet.get("NAME");
}


//계정과목
function txtACC_CODE_onblur()
{
	// 입력값이 이전값과 같으면 리턴
	if (txtACC_CODE_F.value == txtACC_CODE.value) return;
	
	// 입력값이 ''이면 리턴	
	if (C_isNull(txtACC_CODE.value))
	{
		Input_Clear();
		return;
	}
	
   	if (C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"DEPT_CODE")))
   	{
   		C_msgOk("귀속부서는 반드시 입력해야 합니다.", "확인");
		txtDEPT_CODE.focus();
   		return;
   	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("DEPT_CODE", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DEPT_CODE"));
	lrArgs.set("SEARCH_CONDITION", txtACC_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_ACC_CODE0", lrArgs,"T");
	
	// 팝업취소(X)하면 이전값으로 복원후 리턴
	if (lrRet == null) {
		txtACC_CODE.value = txtACC_CODE_F.value
		return;
	}
	
	// 팝업선택값이 이전값과 같으면 복원후 리턴	
	if (txtACC_CODE_F.value == lrRet.get("ACC_CODE")) {
		txtACC_CODE.value = txtACC_CODE_F.value;
		return;
	}
	
	// 값 변경시에만 실행
	txtACC_CODE.value = "";
	Input_Clear();

	setAccCodeInfo(lrRet);
	
	Input_Detail_Display();
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	//S_nextFocus(btnACC_CODE);
	txtDB_AMT_D.focus();
	txtDB_AMT_D.select();
}

function btnACC_CODE_onClick()
{
   	if (C_isNull(dsSLIP_D.NameString(dsSLIP_D.RowPosition,"DEPT_CODE")))
   	{
   		C_msgOk("귀속부서는 반드시 입력해야 합니다.", "확인");
		txtDEPT_CODE.focus();
   		return;
   	}
   	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("DEPT_CODE", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DEPT_CODE"));
	lrArgs.set("SEARCH_CONDITION", txtACC_CODE.value);

	if (C_isNull(txtACC_CODE.value))
	{
		lrRet = C_LOV("T_ACC_CODE0", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_ACC_CODE0", lrArgs,"T");
	}
	
	// 팝업취소(X)하면
	if (lrRet == null) return;
	
	// 팝업선택값이 이전값과 같으면 그냥 리턴	
	if (txtCOMP_CODE.value == lrRet.get("COMP_CODE")) return; 
	
	// 값 변경시에만 실행
	txtACC_CODE.value = "";
	Input_Clear();
	
	setAccCodeInfo(lrRet);

	Input_Detail_Display();
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	//S_nextFocus(btnACC_CODE);
	txtDB_AMT_D.focus();
	txtDB_AMT_D.select();
}

//적요코드
function txtSUMMARY_CODE_onblur()
{
	if (txtSUMMARY_CODE_F.value == txtSUMMARY_CODE.value) return;
	
	if (C_isNull(txtSUMMARY_CODE.value))
	{
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("ACC_CODE", txtACC_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtSUMMARY_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_SUMMARY_CODE", lrArgs,"T");

	if (lrRet == null) return;
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SUMMARY_CODE")	= lrRet.get("SUMMARY_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SUMMARY1")		= lrRet.get("SUMMARY_NAME");
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	//S_nextFocus(btnCLASS_CODE);
	txtVAT_CODE.focus();
	txtVAT_CODE.select();
	setBRAIN_SUMMARY1(dsSLIP_D.RowPosition);
}

function btnSUMMARY_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("ACC_CODE", txtACC_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtSUMMARY_CODE.value);

	if (C_isNull(txtSUMMARY_CODE.value))
	{
		lrRet = C_LOV("T_SUMMARY_CODE", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_SUMMARY_CODE", lrArgs,"T");
	}

	if (lrRet == null) return;

	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SUMMARY_CODE")	= lrRet.get("SUMMARY_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SUMMARY1")		= lrRet.get("SUMMARY_NAME");
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	//S_nextFocus(btnCLASS_CODE);
	txtVAT_CODE.focus();
	txtVAT_CODE.select();
	setBRAIN_SUMMARY1(dsSLIP_D.RowPosition);
}

function txtSUMMARY1_onchange()
{
	setBRAIN_SUMMARY1(dsSLIP_D.RowPosition);
}

function setBRAIN_SUMMARY1(curRow){
	var vBRAIN_GRP_SEQ = dsSLIP_D.NameString(curRow,"BRAIN_GRP_SEQ");

	if( !(vBRAIN_GRP_SEQ=="0" || vBRAIN_GRP_SEQ=="") ) {
		//CUST_CODE_MNG
		var idx = 0;
		for (idx=1;idx<=dsSLIP_D.CountRow;idx++) {
			if( vBRAIN_GRP_SEQ == dsSLIP_D.NameString(idx,"BRAIN_GRP_SEQ") ) {
				dsSLIP_D.NameString(idx,"SUMMARY1") = dsSLIP_D.NameString(curRow, "SUMMARY1");
			}
		}
	}
}

//세무사업장
function txtTAX_COMP_CODE_onblur() 
{
	if (txtTAX_COMP_CODE_F.value == txtTAX_COMP_CODE.value) return;
	
	if (C_isNull(txtTAX_COMP_CODE.value))
	{
		Input_Clear();
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtTAX_COMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE", lrArgs,"T");

	if (lrRet == null) return;
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "TAX_COMP_CODE")	= lrRet.get("COMP_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "TAX_COMP_NAME")	= lrRet.get("COMPANY_NAME");
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	//S_nextFocus(btnTAX_COMP_CODE);
	txtACC_CODE.focus();
	txtACC_CODE.select();
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

	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "TAX_COMP_CODE")	= lrRet.get("COMP_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "TAX_COMP_NAME")	= lrRet.get("COMPANY_NAME");
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	//S_nextFocus(btnTAX_COMP_CODE);
	txtACC_CODE.focus();
	txtACC_CODE.select();
}

//귀속사업장
function txtCOMP_CODE_onblur() 
{
	// 입력값이 이전값과 같으면 리턴
	if (txtCOMP_CODE_F.value == txtCOMP_CODE.value) return;
	
	// 입력값이 ''이면 리턴
	if (C_isNull(txtCOMP_CODE.value)) {
		Input_Clear();
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE", lrArgs,"T");

	// 팝업취소(X)하면 이전값으로 복원후 리턴
	if (lrRet == null) {
		txtCOMP_CODE.value = txtCOMP_CODE_F.value;
		return;
	}
	
	// 팝업선택값이 이전값과 같으면 복원후 리턴	
	if (txtCOMP_CODE_F.value == lrRet.get("COMP_CODE")) {
		txtCOMP_CODE.value = txtCOMP_CODE_F.value;
		return;
	}
	
	// 값 변경시에만 실행
	txtCOMP_CODE.value = "";
	txtACC_CODE.value = "";
	Input_Clear();
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "COMP_CODE")	= lrRet.get("COMP_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "COMP_NAME")	= lrRet.get("COMPANY_NAME");
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	//S_nextFocus(btnCOMP_CODE);
	txtDEPT_CODE.focus();
	txtDEPT_CODE.select();
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	if (C_isNull(txtCOMP_CODE.value))
	{
		lrRet = C_LOV("T_COMP_CODE", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_COMP_CODE", lrArgs,"T");
	}
	
	// 팝업취소(X)하면
	if (lrRet == null) return;
	
	// 팝업선택값이 이전값과 같으면 그냥 리턴	
	if (txtCOMP_CODE.value == lrRet.get("COMP_CODE")) return;
	
	// 값 변경시에만 실행
	txtCOMP_CODE.value = "";
	txtACC_CODE.value = "";
	Input_Clear();
	

	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "COMP_CODE")	= lrRet.get("COMP_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "COMP_NAME")	= lrRet.get("COMPANY_NAME");
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	//S_nextFocus(btnCOMP_CODE);
	txtDEPT_CODE.focus();
	txtDEPT_CODE.select();
}


//귀속부서
function txtDEPT_CODE_onblur()
{
	// 입력값이 이전값과 같으면 리턴
	if (txtDEPT_CODE_F.value == txtDEPT_CODE.value) return;
	
	// 입력값이 ''이면 리턴
	if (C_isNull(txtDEPT_CODE.value))
	{
		Input_Clear();
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE3", lrArgs,"T");
	
	// 팝업취소(X)하면 이전값으로 복원후 리턴
	if (lrRet == null) {
		txtDEPT_CODE.value = txtDEPT_CODE_F.value;
		return;
	}
	
	// 팝업선택값이 이전값과 같으면 복원후 리턴	
	if (txtDEPT_CODE_F.value == lrRet.get("DEPT_CODE")) {
		txtDEPT_CODE.value = txtDEPT_CODE_F.value;
		return;
	}
	
	// 값 변경시에만 실행
	txtDEPT_CODE.value = "";
	Input_Clear();
		
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DEPT_CODE")		= lrRet.get("DEPT_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DEPT_NAME")		= lrRet.get("DEPT_NAME");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "COMP_CODE")		= lrRet.get("COMP_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "TAX_COMP_CODE")	= lrRet.get("TAX_COMP_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "TAX_COMP_NAME")	= lrRet.get("TAX_COMP_NAME");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CLASS_CODE")		= lrRet.get("CLASS_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CLASS_CODE_NAME")	= lrRet.get("CLASS_CODE_NAME");

	syncDeptCodeImpl(dsSLIP_D.RowPosition);

	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	Input_Detail_Display();
	//S_nextFocus(btnDEPT_CODE);
	txtCLASS_CODE.focus();
	txtCLASS_CODE.select();
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

	// 팝업취소(X)하면
	if (lrRet == null) return;
	
	// 팝업선택값이 이전값과 같으면 그냥 리턴	
	if (txtDEPT_CODE.value == lrRet.get("DEPT_CODE")) return;
	
	// 값 변경시에만 실행
	txtDEPT_CODE.value = "";
	Input_Clear();
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DEPT_CODE")		= lrRet.get("DEPT_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DEPT_NAME")		= lrRet.get("DEPT_NAME");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "COMP_CODE")		= lrRet.get("COMP_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "TAX_COMP_CODE")	= lrRet.get("TAX_COMP_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "TAX_COMP_NAME")	= lrRet.get("TAX_COMP_NAME");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CLASS_CODE")		= lrRet.get("CLASS_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CLASS_CODE_NAME")	= lrRet.get("CLASS_CODE_NAME");

	syncDeptCodeImpl(dsSLIP_D.RowPosition);

	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	Input_Detail_Display();
	//S_nextFocus(btnDEPT_CODE);
	txtCLASS_CODE.focus();
	txtCLASS_CODE.select();
}

function setAccCodeInfoBrain(dsSrc){
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_GRP_SEQ")           = (dsSrc==null)?"":dsBRAIN_GRP_SEQ.NameString(dsBRAIN_GRP_SEQ.RowPosition, "BRAIN_GRP_SEQ");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "VAT_CODE")                = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "VAT_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "VAT_NAME")                = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "VAT_NAME");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_SLIP_NAME")         = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "BRAIN_SLIP_NAME");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_SLIP_NAME")         = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "BRAIN_SLIP_NAME");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_SLIP_SEQ1")         = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "BRAIN_SLIP_SEQ1");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_SLIP_SEQ2")         = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "BRAIN_SLIP_SEQ2");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_SLIP_LINE")          = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "BRAIN_SLIP_LINE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_SORT_SEQ")          = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "BRAIN_SORT_SEQ");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_ACC_POSITION")      = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "BRAIN_ACC_POSITION");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_REPEAT_CLS")		= (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "BRAIN_REPEAT_CLS");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_DEL_CLS")			= (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "BRAIN_DEL_CLS");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SUMMARY_CODE")            = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "SUMMARY_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SUMMARY1")                = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "SUMMARY1");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SUMMARY2")                = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "SUMMARY2");

	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DB_AMT")                  = "0";
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DB_AMT_D")                = "0";
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CR_AMT")                  = "0";
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CR_AMT_D")                = "0";
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "ACC_CODE")                = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "ACC_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "ACC_NAME")                = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "ACC_NAME");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "ACC_REMAIN_POSITION")     = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "ACC_REMAIN_POSITION");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SUMMARY_CLS")     	     = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "SUMMARY_CLS");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BUDG_MNG")				= (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "BUDG_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BUDG_EXEC_CLS")     	     = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "BUDG_EXEC_CLS");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CUST_CODE_MNG")           = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "CUST_CODE_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CUST_CODE_MNG_TG")        = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "CUST_CODE_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CUST_NAME_MNG")           = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "CUST_NAME_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CUST_NAME_MNG_TG")        = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "CUST_NAME_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BANK_MNG")                = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "BANK_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BANK_MNG_TG")             = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "BANK_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "ACCNO_MNG")               = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "ACCNO_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "ACCNO_MNG_TG")            = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "ACCNO_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "ACC_REMAIN_MNG")          = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "ACC_REMAIN_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_SEQ_MNG")            = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "CARD_SEQ_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_SEQ_MNG_TG")         = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "CARD_SEQ_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CHK_NO_MNG")              = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "CHK_NO_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CHK_NO_MNG_TG")           = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "CHK_NO_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_NO_MNG")             = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "BILL_NO_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_NO_MNG_TG")          = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "BILL_NO_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_NO_MNG")         = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "REC_BILL_NO_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_NO_MNG_TG")      = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "REC_BILL_NO_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_NO_MNG")               = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "CP_NO_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_NO_MNG_TG")            = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "CP_NO_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_MNG")                = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "SECU_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_MNG_TG")             = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "SECU_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_NO_MNG")             = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "LOAN_NO_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_NO_MNG_TG")          = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "LOAN_NO_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "FIXED_MNG")               = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "FIXED_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "FIXED_MNG_TG")            = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "FIXED_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DEPOSIT_PAY_MNG")         = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "DEPOSIT_PAY_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DEPOSIT_PAY_MNG_TG")      = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "DEPOSIT_PAY_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "PAY_CON_MNG")             = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "PAY_CON_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "PAY_CON_MNG_TG")          = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "PAY_CON_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_EXPR_MNG")           = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "BILL_EXPR_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_EXPR_MNG_TG")        = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "BILL_EXPR_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "EMP_NO_MNG")              = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "EMP_NO_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "EMP_NO_MNG_TG")           = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "EMP_NO_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "ANTICIPATION_DT_MNG")     = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "ANTICIPATION_DT_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "ANTICIPATION_DT_MNG_TG")  = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "ANTICIPATION_DT_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_NAME_CHAR1")          = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "MNG_NAME_CHAR1");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_TG_CHAR1")            = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "MNG_TG_CHAR1");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_NAME_CHAR2")          = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "MNG_NAME_CHAR2");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_TG_CHAR2")            = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "MNG_TG_CHAR2");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_NAME_CHAR3")          = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "MNG_NAME_CHAR3");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_TG_CHAR3")            = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "MNG_TG_CHAR3");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_NAME_CHAR4")          = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "MNG_NAME_CHAR4");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_TG_CHAR4")            = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "MNG_TG_CHAR4");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_NAME_NUM1")           = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "MNG_NAME_NUM1");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_TG_NUM1")             = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "MNG_TG_NUM1");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_NAME_NUM2")           = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "MNG_NAME_NUM2");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_TG_NUM2")             = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "MNG_TG_NUM2");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_NAME_NUM3")           = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "MNG_NAME_NUM3");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_TG_NUM3")             = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "MNG_TG_NUM3");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_NAME_NUM4")           = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "MNG_NAME_NUM4");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_TG_NUM4")             = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "MNG_TG_NUM4");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_NAME_DT1")            = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "MNG_NAME_DT1");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_TG_DT1")              = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "MNG_TG_DT1");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_NAME_DT2")            = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "MNG_NAME_DT2");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_TG_DT2")              = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "MNG_TG_DT2");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_NAME_DT3")            = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "MNG_NAME_DT3");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_TG_DT3")              = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "MNG_TG_DT3");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_NAME_DT4")            = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "MNG_NAME_DT4");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_TG_DT4")              = (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "MNG_TG_DT4");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RCPTBILL_CLS")	= (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "RCPTBILL_CLS");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SUBTR_CLS")		= (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "SUBTR_CLS");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SALEBUY_CLS")	= (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "SALEBUY_CLS");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "VATOCCUR_CLS")	= (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "VATOCCUR_CLS");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_DETAIL_LIST")	= (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "SLIP_DETAIL_LIST");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CASH_MNG")		= (dsSrc==null)?"F":dsSrc.NameString(dsSrc.RowPosition, "CASH_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_MNG")		= (dsSrc==null)?"F":dsSrc.NameString(dsSrc.RowPosition, "CARD_MNG");
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BANK_CODE")		= (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "BANK_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BANK_NAME")		= (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "BANK_NAME");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "ACCNO")		= (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "ACCNO");
	//dsSLIP_D.NameString(dsSLIP_D.RowPosition, "ACCT_NAME")	= (dsSrc==null)?"":dsSrc.NameString(dsSrc.RowPosition, "ACCT_NAME");
	if(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "EMP_NO_MNG") == 'T'){
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "EMP_NO") = sEmpno;
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "EMP_NAME") = sName;
	} else {
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "EMP_NO") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "EMP_NAME") = "";
	}
	//잔액관리설정
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"ACC_REMAIN_MNG") == "T")
		&&
		(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BRAIN_ACC_POSITION")==dsSLIP_D.NameString(dsSLIP_D.RowPosition, "ACC_REMAIN_POSITION"))
	) {
		txtRESET_SLIPNO.value = txtMAKE_SLIPNO.value+"-"+txtMAKE_SLIPLINE.value;
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_ID")		= dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_ID");
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_IDSEQ")	= dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_IDSEQ");
		//alert(txtRESET_SLIPNO.value);
	}
}

function setAccCodeInfo(lrRet){
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "ACC_CODE")                = (lrRet==null)?"":lrRet.get("ACC_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "ACC_NAME")                = (lrRet==null)?"":lrRet.get("ACC_NAME");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "ACC_REMAIN_POSITION")     = (lrRet==null)?"":lrRet.get("ACC_REMAIN_POSITION");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SUMMARY_CLS")     		= (lrRet==null)?"":lrRet.get("SUMMARY_CLS");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BUDG_MNG")     			= (lrRet==null)?"":lrRet.get("BUDG_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BUDG_EXEC_CLS")     		= (lrRet==null)?"":lrRet.get("BUDG_EXEC_CLS");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CUST_CODE_MNG")           = (lrRet==null)?"":lrRet.get("CUST_CODE_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CUST_CODE_MNG_TG")        = (lrRet==null)?"":lrRet.get("CUST_CODE_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CUST_NAME_MNG")           = (lrRet==null)?"":lrRet.get("CUST_NAME_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CUST_NAME_MNG_TG")        = (lrRet==null)?"":lrRet.get("CUST_NAME_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BANK_MNG")                = (lrRet==null)?"":lrRet.get("BANK_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BANK_MNG_TG")             = (lrRet==null)?"":lrRet.get("BANK_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "ACCNO_MNG")               = (lrRet==null)?"":lrRet.get("ACCNO_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "ACCNO_MNG_TG")            = (lrRet==null)?"":lrRet.get("ACCNO_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "ACC_REMAIN_MNG")          = (lrRet==null)?"":lrRet.get("ACC_REMAIN_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_SEQ_MNG")            = (lrRet==null)?"":lrRet.get("CARD_SEQ_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_SEQ_MNG_TG")         = (lrRet==null)?"":lrRet.get("CARD_SEQ_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CHK_NO_MNG")              = (lrRet==null)?"":lrRet.get("CHK_NO_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CHK_NO_MNG_TG")           = (lrRet==null)?"":lrRet.get("CHK_NO_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_NO_MNG")             = (lrRet==null)?"":lrRet.get("BILL_NO_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_NO_MNG_TG")          = (lrRet==null)?"":lrRet.get("BILL_NO_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_NO_MNG")         = (lrRet==null)?"":lrRet.get("REC_BILL_NO_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_NO_MNG_TG")      = (lrRet==null)?"":lrRet.get("REC_BILL_NO_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_NO_MNG")               = (lrRet==null)?"":lrRet.get("CP_NO_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_NO_MNG_TG")            = (lrRet==null)?"":lrRet.get("CP_NO_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_MNG")                = (lrRet==null)?"":lrRet.get("SECU_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_MNG_TG")             = (lrRet==null)?"":lrRet.get("SECU_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_NO_MNG")             = (lrRet==null)?"":lrRet.get("LOAN_NO_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_NO_MNG_TG")          = (lrRet==null)?"":lrRet.get("LOAN_NO_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "FIXED_MNG")               = (lrRet==null)?"":lrRet.get("FIXED_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "FIXED_MNG_TG")            = (lrRet==null)?"":lrRet.get("FIXED_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DEPOSIT_PAY_MNG")         = (lrRet==null)?"":lrRet.get("DEPOSIT_PAY_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DEPOSIT_PAY_MNG_TG")      = (lrRet==null)?"":lrRet.get("DEPOSIT_PAY_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "PAY_CON_MNG")             = (lrRet==null)?"":lrRet.get("PAY_CON_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "PAY_CON_MNG_TG")          = (lrRet==null)?"":lrRet.get("PAY_CON_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_EXPR_MNG")           = (lrRet==null)?"":lrRet.get("BILL_EXPR_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_EXPR_MNG_TG")        = (lrRet==null)?"":lrRet.get("BILL_EXPR_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "EMP_NO_MNG")              = (lrRet==null)?"":lrRet.get("EMP_NO_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "EMP_NO_MNG_TG")           = (lrRet==null)?"":lrRet.get("EMP_NO_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "ANTICIPATION_DT_MNG")     = (lrRet==null)?"":lrRet.get("ANTICIPATION_DT_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "ANTICIPATION_DT_MNG_TG")  = (lrRet==null)?"":lrRet.get("ANTICIPATION_DT_MNG_TG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_NAME_CHAR1")          = (lrRet==null)?"":lrRet.get("MNG_NAME_CHAR1");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_TG_CHAR1")            = (lrRet==null)?"":lrRet.get("MNG_TG_CHAR1");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_NAME_CHAR2")          = (lrRet==null)?"":lrRet.get("MNG_NAME_CHAR2");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_TG_CHAR2")            = (lrRet==null)?"":lrRet.get("MNG_TG_CHAR2");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_NAME_CHAR3")          = (lrRet==null)?"":lrRet.get("MNG_NAME_CHAR3");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_TG_CHAR3")            = (lrRet==null)?"":lrRet.get("MNG_TG_CHAR3");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_NAME_CHAR4")          = (lrRet==null)?"":lrRet.get("MNG_NAME_CHAR4");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_TG_CHAR4")            = (lrRet==null)?"":lrRet.get("MNG_TG_CHAR4");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_NAME_NUM1")           = (lrRet==null)?"":lrRet.get("MNG_NAME_NUM1");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_TG_NUM1")             = (lrRet==null)?"":lrRet.get("MNG_TG_NUM1");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_NAME_NUM2")           = (lrRet==null)?"":lrRet.get("MNG_NAME_NUM2");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_TG_NUM2")             = (lrRet==null)?"":lrRet.get("MNG_TG_NUM2");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_NAME_NUM3")           = (lrRet==null)?"":lrRet.get("MNG_NAME_NUM3");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_TG_NUM3")             = (lrRet==null)?"":lrRet.get("MNG_TG_NUM3");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_NAME_NUM4")           = (lrRet==null)?"":lrRet.get("MNG_NAME_NUM4");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_TG_NUM4")             = (lrRet==null)?"":lrRet.get("MNG_TG_NUM4");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_NAME_DT1")            = (lrRet==null)?"":lrRet.get("MNG_NAME_DT1");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_TG_DT1")              = (lrRet==null)?"":lrRet.get("MNG_TG_DT1");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_NAME_DT2")            = (lrRet==null)?"":lrRet.get("MNG_NAME_DT2");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_TG_DT2")              = (lrRet==null)?"":lrRet.get("MNG_TG_DT2");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_NAME_DT3")            = (lrRet==null)?"":lrRet.get("MNG_NAME_DT3");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_TG_DT3")              = (lrRet==null)?"":lrRet.get("MNG_TG_DT3");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_NAME_DT4")            = (lrRet==null)?"":lrRet.get("MNG_NAME_DT4");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "MNG_TG_DT4")              = (lrRet==null)?"":lrRet.get("MNG_TG_DT4");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RCPTBILL_CLS")			 = (lrRet==null)?"":lrRet.get("RCPTBILL_CLS");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SUBTR_CLS")				 = (lrRet==null)?"":lrRet.get("SUBTR_CLS");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SALEBUY_CLS")			 = (lrRet==null)?"":lrRet.get("SALEBUY_CLS");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "VATOCCUR_CLS")			 = (lrRet==null)?"":lrRet.get("VATOCCUR_CLS");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_DETAIL_LIST")		 = (lrRet==null)?"":lrRet.get("SLIP_DETAIL_LIST");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CASH_MNG")				 = (lrRet==null)?"F":lrRet.get("CASH_MNG");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_MNG")				 = (lrRet==null)?"F":lrRet.get("CARD_MNG");
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BANK_CODE")				 = (lrRet==null)?"":lrRet.get("BANK_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BANK_NAME")				 = (lrRet==null)?"":lrRet.get("BANK_NAME");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "ACCNO")					= (lrRet==null)?"":lrRet.get("ACCNO");
	//dsSLIP_D.NameString(dsSLIP_D.RowPosition, "ACCT_NAME")			= (lrRet==null)?"":lrRet.get("ACCT_NAME");
	if(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "EMP_NO_MNG") == 'T'){
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "EMP_NO") = sEmpno;
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "EMP_NAME") = sName;
	} else {
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "EMP_NO") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "EMP_NAME") = "";
	}
}

//부문코드
function txtCLASS_CODE_onblur()
{
	if (txtCLASS_CODE_F.value == txtCLASS_CODE.value) return;
	
	if (C_isNull(txtCLASS_CODE.value))
	{
		Input_Clear();
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCLASS_CODE.value);
	lrArgs.set("DEPT_CODE", txtDEPT_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_CLASS_CODE1", lrArgs,"T");

	if (lrRet == null) return;
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CLASS_CODE")		= lrRet.get("CLASS_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CLASS_CODE_NAME")	= lrRet.get("CLASS_CODE_NAME");
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	//S_nextFocus(txtSUMMARY2);
	txtTAX_COMP_CODE.focus();
	txtTAX_COMP_CODE.select();
}

function btnCLASS_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCLASS_CODE.value);
	lrArgs.set("DEPT_CODE", txtDEPT_CODE.value);

	if (C_isNull(txtCLASS_CODE.value))
	{
		lrRet = C_LOV("T_CLASS_CODE1", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_CLASS_CODE1", lrArgs,"T");
	}

	if (lrRet == null) return;

	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CLASS_CODE")		= lrRet.get("CLASS_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CLASS_CODE_NAME")	= lrRet.get("CLASS_CODE_NAME");
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	//S_nextFocus(txtSUMMARY2);
	txtTAX_COMP_CODE.focus();
	txtTAX_COMP_CODE.select();
}

//증빙코드
function txtVAT_CODE_onblur()
{
	if (txtVAT_CODE_F.value == txtVAT_CODE.value) return;
	
	if (C_isNull(txtVAT_CODE.value))
	{
		//증빙코드에따라 현금영수증/신용카드 세부가 결정되기 때문에 Input_Clear()를 먼저 실행시킨다.
		Input_Clear();
		Input_Detail_Display();
		Input_Detail_Clear();
		Input_Color_ReadOnly();
		Input_Clear();
		createBrainSlipLine(dsSLIP_D, dsSLIP_D.RowPosition, "VAT_CODE");
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtVAT_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_VAT_CODE1", lrArgs,"T");

	if (lrRet == null) {
		txtVAT_CODE.value = txtVAT_CODE_F.value;
		return;
	}
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "VAT_CODE")			= lrRet.get("VAT_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "VAT_NAME")			= lrRet.get("VAT_NAME");

	Input_Detail_Display();
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	//S_nextFocus(btnVAT_CODE);
	txtVAT_DT.focus();
	txtVAT_DT.select();
	createBrainSlipLine(dsSLIP_D, dsSLIP_D.RowPosition, "VAT_CODE");
}

function btnVAT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	if (C_isNull(txtVAT_CODE.value))
	{
		lrRet = C_LOV("T_VAT_CODE1", lrArgs,"T");
	}
	else
	{
		lrRet = C_LOV("T_VAT_CODE1", lrArgs,"T");
	}

	if (lrRet == null) {
		txtVAT_CODE.value = txtVAT_CODE_F.value;
		return;
	}

	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "VAT_CODE")			= lrRet.get("VAT_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "VAT_NAME")			= lrRet.get("VAT_NAME");

	Input_Detail_Display();
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	//S_nextFocus(btnVAT_CODE);
	txtVAT_DT.focus();
	txtVAT_DT.select();
	createBrainSlipLine(dsSLIP_D, dsSLIP_D.RowPosition, "VAT_CODE");
}

//증빙일자
function btnVAT_DT_onClick()
{
	C_Calendar("VAT_DT", "D", txtVAT_DT.value);
}

//거래처코드
function txtCUST_CODE_onblur()
{
	if (txtCUST_CODE_F.value == txtCUST_CODE.value) {
		Input_Clear();
		return;
	}
	
	if (C_isNull(txtCUST_CODE.value))
	{
		Input_Clear();
		return;
	}

	G_Load(dsCUST_CODE, null);

	if(dsCUST_CODE.CountRow == 1) {
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CUST_SEQ")	= dsCUST_CODE.NameString(1, "CUST_SEQ");
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CUST_CODE")	= dsCUST_CODE.NameString(1, "CUST_CODE");
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CUST_NAME")	= dsCUST_CODE.NameString(1, "CUST_NAME");
		Input_Detail_Clear();
		Input_Color_ReadOnly();
		Input_Clear();
		S_nextFocus(btnCUST_CODE);
		setBRAIN_CUST_CODE(dsSLIP_D.RowPosition);
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("CUST_CODE", txtCUST_CODE.value);

	var	lrRet = window.showModalDialog(
		"t_RCustCodeR.jsp",
		lrArgs,
		"center:yes; dialogWidth:806px;	dialogHeight:423px;	status:no; help:no;	scroll:no"
	);

	if (lrRet == null) {
		txtCUST_CODE.value = txtCUST_CODE_F.value;
		Input_Clear();
		return;
	}
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CUST_SEQ")	= lrRet.CUST_SEQ;
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CUST_CODE")	= lrRet.CUST_CODE;
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CUST_NAME")	= lrRet.CUST_NAME;
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnCUST_CODE);

	setBRAIN_CUST_CODE(dsSLIP_D.RowPosition);
}

function btnCUST_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("CUST_CODE", txtCUST_CODE.value);

	var	lrRet = window.showModalDialog(
		"t_RCustCodeR.jsp",
		lrArgs,
		"center:yes; dialogWidth:806px;	dialogHeight:423px;	status:no; help:no;	scroll:no"
	);

	if (lrRet == null){
		Input_Clear();
		return;
	}

	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CUST_SEQ")	= lrRet.CUST_SEQ;
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CUST_CODE")	= lrRet.CUST_CODE;
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CUST_NAME")	= lrRet.CUST_NAME;
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnCUST_CODE);

	setBRAIN_CUST_CODE(dsSLIP_D.RowPosition);
}
function setBRAIN_CUST_CODE(curRow){
	var vBRAIN_GRP_SEQ = dsSLIP_D.NameString(curRow,"BRAIN_GRP_SEQ");

	if( !(vBRAIN_GRP_SEQ=="0" || vBRAIN_GRP_SEQ=="") ) {
		//CUST_CODE_MNG
		var idx = 0;
		for (idx=1;idx<=dsSLIP_D.CountRow;idx++) {
			if( vBRAIN_GRP_SEQ == dsSLIP_D.NameString(idx,"BRAIN_GRP_SEQ") ) {
				if( dsSLIP_D.NameString(idx,"CUST_CODE_MNG") == "T" ){
					dsSLIP_D.NameString(idx,"CUST_SEQ") = dsSLIP_D.NameString(curRow, "CUST_SEQ");
					dsSLIP_D.NameString(idx,"CUST_CODE") = dsSLIP_D.NameString(curRow, "CUST_CODE");
					dsSLIP_D.NameString(idx,"CUST_NAME") = dsSLIP_D.NameString(curRow, "CUST_NAME");
				}
			}
		}
	}
}

// 은행코드
// 
function txtBANK_CODE_onblur()
{
	if (txtBANK_CODE_F.value == txtBANK_CODE.value) return;
	
	if (C_isNull(txtBANK_CODE.value))
	{
		Input_Clear();
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtBANK_CODE.value);

	if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CHK_NO_MNG") == "T")
	{
		lrRet = C_AutoLov(dsLOV,"T_BANK_CODE2", lrArgs,"T");
	}
	else
	{
		if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BILL_NO_MNG") == "T")
		{
			lrRet = C_AutoLov(dsLOV,"T_BANK_CODE3", lrArgs,"T");
		}
		else
		{
			lrRet = C_AutoLov(dsLOV,"T_BANK_CODE1", lrArgs,"T");
		}
	}

	if (lrRet == null) return;

	if (txtBANK_CODE_F.value != txtBANK_CODE.value)
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"ACCNO") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CHK_NO") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CHK_PUBL_DT") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BILL_NO") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BILL_PUBL_DT") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BILL_EXPR_DT") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BILL_NO_R") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BILL_PUBL_DT_R") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BILL_EXPR_DT_R") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"REC_BILL_NO") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"REC_BILL_PUBL_DT") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"REC_BILL_EXPR_DT") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"REC_BILL_PUBL_AMT") = "";
	}
		
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BANK_CODE")	= lrRet.get("BANK_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BANK_NAME")	= lrRet.get("BANK_NAME");
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnBANK_CODE);
}

function btnBANK_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtBANK_CODE.value);
	
	if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CHK_NO_MNG") == "T")
	{
		lrRet = C_LOV("T_BANK_CODE2", lrArgs,"T");
	}
	else
	{
		if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BILL_NO_MNG") == "T")
		{
			lrRet = C_LOV("T_BANK_CODE3", lrArgs,"T");
		}
		else
		{
			if (C_isNull(txtBANK_CODE.value))
			{
				lrRet = C_LOV("T_BANK_CODE1", lrArgs,"F");
			}
			else
			{
				lrRet = C_LOV("T_BANK_CODE1", lrArgs,"T");
			}
		}
	}

	if (lrRet == null) return;
	
	if (txtBANK_CODE_F.value != txtBANK_CODE.value)
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"ACCNO") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CHK_NO") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CHK_PUBL_DT") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BILL_NO") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BILL_PUBL_DT") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BILL_EXPR_DT") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BILL_NO_R") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BILL_PUBL_DT_R") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"BILL_EXPR_DT_R") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"REC_BILL_NO") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"REC_BILL_PUBL_DT") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"REC_BILL_EXPR_DT") = "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"REC_BILL_PUBL_AMT") = "";
	}

	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BANK_CODE")	= lrRet.get("BANK_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BANK_NAME")	= lrRet.get("BANK_NAME");
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnBANK_CODE);
}

//카드번호
function txtCARD_NO_onblur()
{
	if (txtCARD_NO_F.value == txtCARD_NO.value) return;
	
	if (C_isNull(txtCARD_NO.value))
	{
		Input_Clear();
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("CARD_CLS", "1");
	lrArgs.set("CARDNO", txtCARD_NO.value);

	lrRet = C_AutoLov(dsLOV,"T_ACC_CREDCARD1", lrArgs,"T");

	if (lrRet == null) return;
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_SEQ_B")		= lrRet.get("CARD_SEQ");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_NO")		= lrRet.get("CARDNO");
	//dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_HAVE_PERS")	= lrRet.get("CARD_OWNER");
	
	Input_Detail_Display();
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnCARD_NO);
}

function btnCARD_NO_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("CARD_CLS", "1");
	lrArgs.set("CARDNO", txtCARD_NO.value);

	lrRet = C_LOV("T_ACC_CREDCARD1", lrArgs,"T");

	if (lrRet == null) return;
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_SEQ_B")		= lrRet.get("CARD_SEQ");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_NO")		= lrRet.get("CARDNO");
	//dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_HAVE_PERS")	= lrRet.get("CARD_OWNER");
	Input_Detail_Display();
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnCARD_NO);
}

//계좌번호
function txtACCNO_CODE_onblur()
{
	if (txtACCNO_CODE_F.value == txtACCNO_CODE.value) return;
	
	if (C_isNull(txtACCNO_CODE.value))
	{
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null; 

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("BANK_CODE", txtBANK_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtACCNO_CODE.value);
	
	if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CHK_NO_MNG") == "T")
	{
		lrRet = C_AutoLov(dsLOV,"T_ACCNO_CODE2", lrArgs,"T");
	}
	else
	{
		lrRet = C_AutoLov(dsLOV,"T_ACCNO_CODE1", lrArgs,"T");
	}

	if (lrRet == null) return;
	
	if (C_isNull(txtBANK_CODE.value))
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BANK_CODE")	= lrRet.get("BANK_CODE");
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BANK_NAME")	= lrRet.get("BANK_NAME");
	}
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "ACCNO")		= lrRet.get("ACCNO");
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnACCNO_CODE);
}

function btnACCNO_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("BANK_CODE", txtBANK_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtACCNO_CODE.value);

	if (dsSLIP_D.NameString(dsSLIP_D.RowPosition,"CHK_NO_MNG") == "T")
	{
		lrRet = C_LOV("T_ACCNO_CODE2", lrArgs,"T");
	}
	else
	{
		if (C_isNull(txtBANK_CODE.value))
		{
			lrRet = C_LOV("T_ACCNO_CODE1", lrArgs,"F");
		}
		else
		{
			lrRet = C_LOV("T_ACCNO_CODE1", lrArgs,"T");
		}
	}

	if (lrRet == null) return;

	if (C_isNull(txtBANK_CODE.value))
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BANK_CODE")	= lrRet.get("BANK_CODE");
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BANK_NAME")	= lrRet.get("BANK_NAME");
	}

	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "ACCNO")		= lrRet.get("ACCNO");
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnACCNO_CODE);
}

//당좌수표
function txtCHK_NO_onblur()
{
	if (txtCHK_NO_F.value == txtCHK_NO.value) return;
	
	if (C_isNull(txtCHK_NO.value))
	{
		Input_Clear();
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("BANK_CODE", txtBANK_CODE.value);
	lrArgs.set("SLIP_ID", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_ID"));
	lrArgs.set("SLIP_IDSEQ", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_IDSEQ"));
	lrArgs.set("SEARCH_CONDITION", txtCHK_NO.value);

	if(IsValidAccOSideCurrent()) {
		// 발행
		lrRet = C_AutoLov(dsLOV,"T_CHECK_NO1", lrArgs,"T");
	} else if(IsValidAccThisSideCurrent()) {
		// 회수
		lrRet = C_AutoLov(dsLOV,"T_CHECK_NO2", lrArgs,"T");
	}
	if (lrRet == null) return;

	var	vRowIdx	= dsSLIP_D.NameValueRow("CHK_NO",lrRet.get("CHK_BILL_NO"));
	if ((vRowIdx	!= 0) && (dsSLIP_D.RowPosition == vRowIdx))
	{
		C_msgOk(dsSLIP_D.NameString(vRowIdx, "MAKE_SLIPLINE") + "번 라인에서 이미 발행되었습니다.", "확인");
		return;
	}
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CHK_NO")	= lrRet.get("CHK_BILL_NO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CHK_PUBL_DT")	= lrRet.get("PUBL_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CHK_COLL_DT")	= lrRet.get("COLL_DT");
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnCHK_NO);
}

function btnCHK_NO_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("BANK_CODE", txtBANK_CODE.value);
	lrArgs.set("SLIP_ID", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_ID"));
	lrArgs.set("SLIP_IDSEQ", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_IDSEQ"));
	lrArgs.set("SEARCH_CONDITION", txtCHK_NO.value);

	if(IsValidAccOSideCurrent()) {
		// 발행
		lrRet = C_LOV("T_CHECK_NO1", lrArgs,"T");
	} else if(IsValidAccThisSideCurrent()) {
		// 회수
		lrRet = C_LOV("T_CHECK_NO2", lrArgs,"T");
	}

	if (lrRet == null) return;

	var	vRowIdx	= dsSLIP_D.NameValueRow("CHK_NO",lrRet.get("CHK_BILL_NO"));
	if ((vRowIdx	!= 0) && (dsSLIP_D.RowPosition != vRowIdx))
	{
		C_msgOk(dsSLIP_D.NameString(vRowIdx, "MAKE_SLIPLINE") + "번 라인에서 이미 발행되었습니다.", "확인");
		return;
	}
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CHK_NO")	= lrRet.get("CHK_BILL_NO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CHK_PUBL_DT")	= lrRet.get("PUBL_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CHK_COLL_DT")	= lrRet.get("COLL_DT");
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnCHK_NO);
}

function btnCHK_PUBL_DT_onClick()
{
	C_Calendar("CHK_PUBL_DT", "D", txtCHK_PUBL_DT.value);
	S_nextFocus(btnCHK_PUBL_DT);
}

function btnCHK_COLL_DT_onClick()
{
	C_Calendar("CHK_COLL_DT", "D", txtCHK_COLL_DT.value);
	S_nextFocus(btnCHK_COLL_DT);
}

//지급어음 설정
function txtBILL_NO_S_onblur()
{
	if (txtBILL_NO_S_F.value == txtBILL_NO_S.value) return;
	
	if (C_isNull(txtBILL_NO_S.value))
	{
		Input_Clear();
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("BANK_CODE", txtBANK_CODE.value);
	lrArgs.set("SLIP_ID", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_ID"));
	lrArgs.set("SLIP_IDSEQ", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_IDSEQ"));
	lrArgs.set("SEARCH_CONDITION", txtBILL_NO_S.value);

	lrRet = C_AutoLov(dsLOV,"T_BILL_NO1", lrArgs,"T");

	if (lrRet == null) return;

	var	vRowIdx	= dsSLIP_D.NameValueRow("BILL_NO_S",lrRet.get("CHK_BILL_NO"));
	if ((vRowIdx	!= 0) && (dsSLIP_D.RowPosition != vRowIdx))
	{
		C_msgOk(dsSLIP_D.NameString(vRowIdx, "MAKE_SLIPLINE") + "번 라인에서 이미 발행되었습니다.", "확인");
		return;
	}
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_NO")		= lrRet.get("CHK_BILL_NO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_NO_S")	= lrRet.get("CHK_BILL_NO");
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnBILL_NO);
}

function btnBILL_NO_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("BANK_CODE", txtBANK_CODE.value);
	lrArgs.set("SLIP_ID", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_ID"));
	lrArgs.set("SLIP_IDSEQ", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_IDSEQ"));
	lrArgs.set("SEARCH_CONDITION", txtBILL_NO_S.value);

	lrRet = C_LOV("T_BILL_NO1", lrArgs,"T");

	if (lrRet == null) return;

	var	vRowIdx	= dsSLIP_D.NameValueRow("BILL_NO_S",lrRet.get("CHK_BILL_NO"));
	if ((vRowIdx	!= 0) && (dsSLIP_D.RowPosition != vRowIdx))
	{
		C_msgOk(dsSLIP_D.NameString(vRowIdx, "MAKE_SLIPLINE") + "번 라인에서 이미 발행되었습니다.", "확인");
		return;
	}
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_NO")	= lrRet.get("CHK_BILL_NO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_NO_S")	= lrRet.get("CHK_BILL_NO");
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnBILL_NO);
}

function btnBILL_PUBL_DT_onClick()
{
	C_Calendar("BILL_PUBL_DT", "D", txtBILL_PUBL_DT.value);
	S_nextFocus(btnBILL_PUBL_DT);
}

function btnBILL_EXPR_DT_onClick()
{
	C_Calendar("BILL_EXPR_DT", "D", txtBILL_EXPR_DT.value);
	S_nextFocus(btnBILL_PUBL_DT);
}

//지급어음 반제
function txtBILL_NO_R_onblur()
{
	if (txtBILL_NO_R_F.value == txtBILL_NO_R.value) return;
	
	if (C_isNull(txtBILL_NO_R.value))
	{
		Input_Clear();
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("BANK_CODE", txtBANK_CODE.value);
	lrArgs.set("SLIP_ID", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_ID"));
	lrArgs.set("SLIP_IDSEQ", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_IDSEQ"));
	lrArgs.set("SEARCH_CONDITION", txtBILL_NO_R.value);

	lrRet = C_AutoLov(dsLOV,"T_BILL_NO2", lrArgs,"T");

	if (lrRet == null) return;
	
	var vSLIP_AMT = SafeToInt(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DB_AMT")) + SafeToInt(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CR_AMT"));
	if (vSLIP_AMT != SafeToInt(lrRet.get("PUBL_AMT")))
	{
		C_msgOk("전표금액과 어음발행금액이 일치하지 않습니다.", "확인");
		return;
	}

	var	vRowIdx	= dsSLIP_D.NameValueRow("BILL_NO_R",lrRet.get("CHK_BILL_NO"));
	if ((vRowIdx	!= 0) && (dsSLIP_D.RowPosition != vRowIdx))
	{
		C_msgOk(dsSLIP_D.NameString(vRowIdx, "MAKE_SLIPLINE") + "번 라인에서 이미 반제되었습니다.", "확인");
		return;
	}
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_NO")				= lrRet.get("CHK_BILL_NO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_NO_R")			= lrRet.get("CHK_BILL_NO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_PUBL_DT_R")		= lrRet.get("PUBL_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_EXPR_DT_R")		= lrRet.get("EXPR_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_CHG_EXPR_DT_R")	= lrRet.get("CHG_EXPR_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_ID")		= lrRet.get("SLIP_ID");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_IDSEQ")	= lrRet.get("SLIP_IDSEQ");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIPNO")		= lrRet.get("MAKE_SLIPNO");
	Input_Detail_Display();
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnBILL_NO_R);
}

function btnBILL_NO_R_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("BANK_CODE", txtBANK_CODE.value);
	lrArgs.set("SLIP_ID", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_ID"));
	lrArgs.set("SLIP_IDSEQ", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_IDSEQ"));
	lrArgs.set("SEARCH_CONDITION", txtBILL_NO_R.value);

	lrRet = C_LOV("T_BILL_NO2", lrArgs,"T");

	if (lrRet == null) return;

	var vSLIP_AMT = SafeToInt(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DB_AMT")) + SafeToInt(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CR_AMT"));
	if (vSLIP_AMT != SafeToInt(lrRet.get("PUBL_AMT")))
	{
		C_msgOk("전표금액과 어음발행금액이 일치하지 않습니다.", "확인");
		return;
	}

	var	vRowIdx	= dsSLIP_D.NameValueRow("BILL_NO_R",lrRet.get("CHK_BILL_NO"));
	if ((vRowIdx	!= 0) && (dsSLIP_D.RowPosition != vRowIdx))
	{
		C_msgOk(dsSLIP_D.NameString(vRowIdx, "MAKE_SLIPLINE") + "번 라인에서 이미 반제되었습니다.", "확인");
		return;
	}
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_NO")				= lrRet.get("CHK_BILL_NO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_NO_R")			= lrRet.get("CHK_BILL_NO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_PUBL_DT_R")		= lrRet.get("PUBL_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_EXPR_DT_R")		= lrRet.get("EXPR_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "BILL_CHG_EXPR_DT_R")	= lrRet.get("CHG_EXPR_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_ID")		= lrRet.get("SLIP_ID");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_IDSEQ")	= lrRet.get("SLIP_IDSEQ");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIPNO")		= lrRet.get("MAKE_SLIPNO");
	Input_Detail_Display();
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnBILL_NO_R);
}

function btnBILL_COLL_DT_R_onClick()
{
	C_Calendar("BILL_COLL_DT_R", "D", txtBILL_COLL_DT_R.value);
	S_nextFocus(btnBILL_COLL_DT_R);
}

//받을어음 설정
function txtREC_BILL_NO_S_onblur()
{
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_NO") = dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_NO_S");

	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(txtREC_BILL_NO_S);
}

function btnREC_BILL_PUBL_DT_onClick()
{
	C_Calendar("REC_BILL_PUBL_DT", "D", txtREC_BILL_PUBL_DT.value);
	S_nextFocus(btnREC_BILL_PUBL_DT);
}

function btnREC_BILL_EXPR_DT_onClick()
{
	C_Calendar("REC_BILL_EXPR_DT", "D", txtREC_BILL_EXPR_DT.value);
	S_nextFocus(btnREC_BILL_PUBL_DT);
}

//받을어음 반제

//어음번호
function txtREC_BILL_NO_R_onblur()
{
	if (txtREC_BILL_NO_R_F.value == txtREC_BILL_NO_R.value) return;
	
	if (C_isNull(txtREC_BILL_NO_R.value))
	{
		Input_Clear();
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SLIP_ID", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_ID"));
	lrArgs.set("SLIP_IDSEQ", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_IDSEQ"));
	lrArgs.set("SEARCH_CONDITION", txtREC_BILL_NO_R.value);

	lrRet = C_AutoLov(dsLOV,"T_FIN_RECEIVE_CHK_BILL02", lrArgs,"T");

	if (lrRet == null) return;
	
	var vSLIP_AMT = SafeToInt(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DB_AMT")) + SafeToInt(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CR_AMT"));
	if (vSLIP_AMT != SafeToInt(lrRet.get("PUBL_AMT").replace(/,/g, "")))
	{
		C_msgOk("전표금액과 어음발행금액이 일치하지 않습니다.", "확인");
		return;
	}

	var	vRowIdx	= dsSLIP_D.NameValueRow("REC_BILL_NO_R",lrRet.get("REC_CHK_BILL_NO"));
	if ((vRowIdx	!= 0) && (dsSLIP_D.RowPosition != vRowIdx))
	{
		C_msgOk(dsSLIP_D.NameString(vRowIdx, "MAKE_SLIPLINE") + "번 라인에서 이미 반제되었습니다.", "확인");
		return;
	}
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_NO")			= lrRet.get("REC_CHK_BILL_NO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_NO_R")		= lrRet.get("REC_CHK_BILL_NO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_PUBL_DT_R")	= lrRet.get("PUBL_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_EXPR_DT_R")	= lrRet.get("EXPR_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_PUBL_AMT_R")	= lrRet.get("PUBL_AMT");
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_DISH_DT_R")	= lrRet.get("DISH_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_TRUST_DT_R")	= lrRet.get("TRUST_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_TRUST_BANK_CODE_R")	= lrRet.get("TRUST_BANK_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_TRUST_BANK_NAME_R")	= lrRet.get("TRUST_BANK_NAME");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_DISC_DT_R")	= lrRet.get("DISC_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_DISC_BANK_CODE_R")	= lrRet.get("DISC_BANK_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_DISC_BANK_NAME_R")	= lrRet.get("DISC_BANK_NAME");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_DISC_RAT_R")	= lrRet.get("DISC_RAT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_DISC_AMT_R")	= lrRet.get("DISC_AMT");
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_ID")		= lrRet.get("SLIP_ID");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_IDSEQ")	= lrRet.get("SLIP_IDSEQ");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIPNO")		= lrRet.get("MAKE_SLIPNO");
	Input_Detail_Display();
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnREC_BILL_NO_R);
}

function btnREC_BILL_NO_R_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SLIP_ID", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_ID"));
	lrArgs.set("SLIP_IDSEQ", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_IDSEQ"));
	lrArgs.set("SEARCH_CONDITION", txtREC_BILL_NO_R.value);

	lrRet = C_LOV("T_FIN_RECEIVE_CHK_BILL02", lrArgs,"T");

	if (lrRet == null) return;

	var vSLIP_AMT = SafeToInt(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DB_AMT")) + SafeToInt(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CR_AMT"));
	if (vSLIP_AMT != SafeToInt(lrRet.get("PUBL_AMT").replace(/,/g, "")))
	{
		C_msgOk("전표금액과 어음발행금액이 일치하지 않습니다.", "확인");
		return;
	}

	var	vRowIdx	= dsSLIP_D.NameValueRow("REC_BILL_NO_R",lrRet.get("REC_CHK_BILL_NO"));
	if ((vRowIdx	!= 0) && (dsSLIP_D.RowPosition != vRowIdx))
	{
		C_msgOk(dsSLIP_D.NameString(vRowIdx, "MAKE_SLIPLINE") + "번 라인에서 이미 반제되었습니다.", "확인");
		return;
	}
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_NO")			= lrRet.get("REC_CHK_BILL_NO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_NO_R")		= lrRet.get("REC_CHK_BILL_NO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_PUBL_DT_R")	= lrRet.get("PUBL_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_EXPR_DT_R")	= lrRet.get("EXPR_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_PUBL_AMT_R")	= lrRet.get("PUBL_AMT");
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_DISH_DT_R")	= lrRet.get("DISH_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_TRUST_DT_R")	= lrRet.get("TRUST_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_TRUST_BANK_CODE_R")	= lrRet.get("TRUST_BANK_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_TRUST_BANK_NAME_R")	= lrRet.get("TRUST_BANK_NAME");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_DISC_DT_R")	= lrRet.get("DISC_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_DISC_BANK_CODE_R")	= lrRet.get("DISC_BANK_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_DISC_BANK_NAME_R")	= lrRet.get("DISC_BANK_NAME");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_DISC_RAT_R")	= lrRet.get("DISC_RAT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_DISC_AMT_R")	= lrRet.get("DISC_AMT");
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_ID")		= lrRet.get("SLIP_ID");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_IDSEQ")	= lrRet.get("SLIP_IDSEQ");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIPNO")		= lrRet.get("MAKE_SLIPNO");
	Input_Detail_Display();
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnREC_BILL_NO_R);
}
//부도일    
function btnREC_BILL_DISH_DT_R_onClick()
{
	C_Calendar("REC_BILL_DISH_DT_R", "D", txtREC_BILL_DISH_DT_R.value);
	S_nextFocus(btnREC_BILL_DISH_DT_R);
}
//수탁일
function btnREC_BILL_TRUST_DT_R_onClick()
{
	C_Calendar("REC_BILL_TRUST_DT_R", "D", txtREC_BILL_TRUST_DT_R.value);
	S_nextFocus(btnREC_BILL_TRUST_DT_R);
}
//수탁은행
function txtREC_BILL_TRUST_BANK_CODE_R_onblur()
{
	if (txtREC_BILL_TRUST_BANK_CODE_R_F.value == txtREC_BILL_TRUST_BANK_CODE_R.value) return;
	if (C_isNull(txtREC_BILL_TRUST_BANK_CODE_R.value))
	{
		//Input_Clear();
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_TRUST_BANK_NAME_R")	= "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtREC_BILL_TRUST_BANK_CODE_R.value);

	lrRet = C_AutoLov(dsLOV,"T_BANK_CODE1", lrArgs,"T");

	if (lrRet == null) return;

	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_TRUST_BANK_CODE_R")	= lrRet.get("BANK_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_TRUST_BANK_NAME_R")	= lrRet.get("BANK_NAME");
	S_nextFocus(btnBANK_CODE);
}

function btnREC_BILL_TRUST_BANK_CODE_R_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_BANK_CODE1", lrArgs,"F");

	if (lrRet == null) return;

	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_TRUST_BANK_CODE_R")	= lrRet.get("BANK_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_TRUST_BANK_NAME_R")	= lrRet.get("BANK_NAME");
	S_nextFocus(btnBANK_CODE);
}   
//할인일
function btnREC_BILL_DISC_DT_R_onClick()
{
	C_Calendar("REC_BILL_DISC_DT_R", "D", txtREC_BILL_DISC_DT_R.value);
	S_nextFocus(btnREC_BILL_DISC_DT_R);
}
//할인은행
function txtREC_BILL_DISC_BANK_CODE_R_onblur()
{
	if (txtREC_BILL_DISC_BANK_CODE_R_F.value == txtREC_BILL_DISC_BANK_CODE_R.value) return;
	if (C_isNull(txtREC_BILL_DISC_BANK_CODE_R.value))
	{
		//Input_Clear();
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_DISC_BANK_NAME_R")	= "";
		return;
	}
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtREC_BILL_DISC_BANK_CODE_R.value);

	lrRet = C_AutoLov(dsLOV,"T_BANK_CODE1", lrArgs,"T");

	if (lrRet == null) return;

	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_DISC_BANK_CODE_R")	= lrRet.get("BANK_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_DISC_BANK_NAME_R")	= lrRet.get("BANK_NAME");
	S_nextFocus(btnBANK_CODE);
}

function btnREC_BILL_DISC_BANK_CODE_R_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_BANK_CODE1", lrArgs,"F");

	if (lrRet == null) return;

	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_DISC_BANK_CODE_R")	= lrRet.get("BANK_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "REC_BILL_DISC_BANK_NAME_R")	= lrRet.get("BANK_NAME");
	S_nextFocus(btnBANK_CODE);
}   

//유가증권 설정
function txtSECU_REAL_SECU_NO_S_onblur()
{
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_REAL_SECU_NO") = dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_REAL_SECU_NO_S");
}

function btnSECU_GET_DT_onClick()
{
	C_Calendar("SECU_GET_DT", "D", txtSECU_GET_DT.value);
	S_nextFocus(btnSECU_GET_DT);
}

function btnSECU_PUBL_DT_onClick()
{
	C_Calendar("SECU_PUBL_DT", "D", txtSECU_PUBL_DT.value);
	S_nextFocus(btnSECU_PUBL_DT);
}

function btnSECU_EXPR_DT_onClick()
{
	C_Calendar("SECU_EXPR_DT", "D", txtSECU_EXPR_DT.value);
	S_nextFocus(btnSECU_PUBL_DT);
}

//유가증권 반제
function txtSECU_REAL_SECU_NO_R_onblur()
{
	if (txtSECU_REAL_SECU_NO_R_F.value == txtSECU_REAL_SECU_NO_R.value) return;
	
	if (C_isNull(txtSECU_REAL_SECU_NO_R.value))
	{
		Input_Clear();
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtSECU_REAL_SECU_NO_R.value);

	lrRet = C_AutoLov(dsLOV,"T_FIN_SECURTY_02", lrArgs,"T");

	if (lrRet == null) return;
	
	var vSLIP_AMT = SafeToInt(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DB_AMT")) + SafeToInt(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CR_AMT"));
	if (vSLIP_AMT != SafeToInt(lrRet.get("PERSTOCK_AMT")))
	{
		C_msgOk("전표금액과 유가증권금액이 일치하지 않습니다.", "확인");
		return;
	}

	var	vRowIdx	= dsSLIP_D.NameValueRow("SECU_REAL_SECU_NO_R",lrRet.get("REAL_SECU_NO"));
	if ((vRowIdx	!= 0) && (dsSLIP_D.RowPosition != vRowIdx))
	{
		C_msgOk(dsSLIP_D.NameString(vRowIdx, "MAKE_SLIPLINE") + "번 라인에서 이미 반제되었습니다.", "확인");
		return;
	}
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_NO")				= lrRet.get("SECU_NO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_NO_R")			= lrRet.get("SECU_NO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_REAL_SECU_NO")	= lrRet.get("REAL_SECU_NO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_REAL_SECU_NO_R")	= lrRet.get("REAL_SECU_NO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_PERSTOCK_AMT_R")	= lrRet.get("PERSTOCK_AMT_D");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_PUBL_DT_R")		= lrRet.get("PUBL_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_EXPR_DT_R")		= lrRet.get("EXPR_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_INTR_RATE_R")	= lrRet.get("INTR_RATE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_SALE_AMT_R")		= lrRet.get("SALE_AMT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_ID")		= lrRet.get("SLIP_ID");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_IDSEQ")	= lrRet.get("SLIP_IDSEQ");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIPNO")		= lrRet.get("MAKE_SLIPNO");
	Input_Detail_Display();
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnSECU_REAL_SECU_NO_R);
}

function btnSECU_REAL_SECU_NO_R_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SLIP_ID", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_ID"));
	lrArgs.set("SLIP_IDSEQ", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_IDSEQ"));
	lrArgs.set("SEARCH_CONDITION", txtSECU_REAL_SECU_NO_R.value);

	lrRet = C_LOV("T_FIN_SECURTY_02", lrArgs,"T");

	if (lrRet == null) return;

	var vSLIP_AMT = SafeToInt(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DB_AMT")) + SafeToInt(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CR_AMT"));
	if (vSLIP_AMT != SafeToInt(lrRet.get("PERSTOCK_AMT")))
	{
		C_msgOk("전표금액과 유가증권금액이 일치하지 않습니다.", "확인");
		return;
	}

	var	vRowIdx	= dsSLIP_D.NameValueRow("SECU_REAL_SECU_NO_R",lrRet.get("REAL_SECU_NO"));
	if ((vRowIdx	!= 0) && (dsSLIP_D.RowPosition != vRowIdx))
	{
		C_msgOk(dsSLIP_D.NameString(vRowIdx, "MAKE_SLIPLINE") + "번 라인에서 이미 반제되었습니다.", "확인");
		return;
	}
	

	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_NO")			= lrRet.get("SECU_NO");	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_NO_R")			= lrRet.get("SECU_NO");	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_REAL_SECU_NO")	= lrRet.get("REAL_SECU_NO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_REAL_SECU_NO_R")	= lrRet.get("REAL_SECU_NO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_PERSTOCK_AMT_R")	= lrRet.get("PERSTOCK_AMT_D");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_PUBL_DT_R")		= lrRet.get("PUBL_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_EXPR_DT_R")		= lrRet.get("EXPR_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_INTR_RATE_R")	= lrRet.get("INTR_RATE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SECU_SALE_AMT_R")		= lrRet.get("SALE_AMT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_ID")		= lrRet.get("SLIP_ID");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_IDSEQ")	= lrRet.get("SLIP_IDSEQ");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIPNO")		= lrRet.get("MAKE_SLIPNO");
	Input_Detail_Display();
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnSECU_REAL_SECU_NO_R);
	
}

function btnSECU_SALE_DT_R_onClick()
{
	C_Calendar("SECU_SALE_DT_R", "D", txtSECU_SALE_DT_R.value);
	S_nextFocus(btnSECU_SALE_DT_R);
}

function btnSECU_RETURN_DT_R_onClick()
{
	C_Calendar("SECU_RETURN_DT_R", "D", txtSECU_RETURN_DT_R.value);
	S_nextFocus(btnSECU_RETURN_DT_R);
}

function txtSECU_CONSIGN_BANK_R_onblur()
{
	if (txtSECU_CONSIGN_BANK_R_F.value == txtSECU_CONSIGN_BANK_R.value) return;
	
	if (C_isNull(txtSECU_CONSIGN_BANK_R.value))
	{
		Input_Clear();
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtSECU_CONSIGN_BANK_R.value);

	lrRet = C_LOV("T_BANK_CODE1", lrArgs);

	if (lrRet == null) {
		txtSECU_CONSIGN_BANK_R.value = txtSECU_CONSIGN_BANK_R_F.value;
		return;
	}

	dsSLIP_D.NameString(dsSLIP_D.RowPosition,"SECU_CONSIGN_BANK_R") = lrRet.get("BANK_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition,"SECU_CONSIGN_BANK_NAME_R") = lrRet.get("BANK_NAME");
	
	S_nextFocus(btnSECU_CONSIGN_BANK_R);
}

function btnSECU_CONSIGN_BANK_R_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtSECU_CONSIGN_BANK_R.value);

	lrRet = C_LOV("T_BANK_CODE1", lrArgs);

	if (lrRet == null) {
		return;
	}

	dsSLIP_D.NameString(dsSLIP_D.RowPosition,"SECU_CONSIGN_BANK_R") = lrRet.get("BANK_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition,"SECU_CONSIGN_BANK_NAME_R") = lrRet.get("BANK_NAME");
	
	S_nextFocus(btnSECU_CONSIGN_BANK_R);
}

//차입 설정
function btnLOAN_REAL_LOAN_NO_onClick()
{
	var lrArgs = new Array();
	var lsURL = "./t_PFinLoanSheetR.jsp";
	
	lrArgs.CompCode = txtCOMP_CODE.value;
	lrArgs.CompName = txtCOMP_NAME.value;

	if (C_isNull(txtBANK_CODE.value))
	{
		C_msgOk("은행코드가 입력되지 않았습니다.", "확인");
		return;
	}
	
	lrArgs.BankCode = txtBANK_CODE.value;
	lrArgs.BankName = txtBANK_NAME.value;
	lrArgs.AccCode = txtACC_CODE.value;
	
	if (C_isNull(txtDB_AMT.value)&&C_isNull(txtCR_AMT.value))
	{
		C_msgOk("차/대 금액이 입력되지 않았습니다.", "확인");
		txtDB_AMT.focus();
		return;
	}
	lrArgs.DbCr = (SafeToInt(txtDB_AMT.value)==0)?"C":"D";
	
	lrArgs.SlipId = dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_ID");
	lrArgs.SlipIdSeg = dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_IDSEQ");
	
	lrArgs.DbCrAmt = dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DB_AMT")+dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CR_AMT");

	//C_msgError(lrArgs.CompCode+"\n"+lrArgs.CompName+"\n"+lrArgs.BankCode+"\n"+lrArgs.BankName+"\n"+lrArgs.AccCode +"\n"+lrArgs.DbCr, "확인");
		
	var lsRtn = window.showModalDialog(lsURL, lrArgs, "center:yes; dialogWidth:840px; dialogHeight:500px; status:yes; help:no; scroll:no");
	if(lsRtn!=null) {
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_REFUND_NO") = lsRtn.LOAN_NO;
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_REFUND_NO_S") = lsRtn.LOAN_NO;
		
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_REAL_LOAN_NO") = lsRtn.REAL_LOAN_NO; 
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_NAME") = lsRtn.LOAN_NAME; 
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_KIND_CODE") = lsRtn.LOAN_KIND_CODE;
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_EXPR_DT") = lsRtn.LOAN_EXPR_DT;
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_FDT") = lsRtn.LOAN_FDT;
	}
}

function btnLOAN_TRANS_DT_onClick()
{
	C_Calendar("LOAN_TRANS_DT", "D", txtLOAN_TRANS_DT.value);
	S_nextFocus(btnLOAN_TRANS_DT);
}

//차입 상환(차입 반제)
function btnLOAN_REAL_LOAN_NO_R_onClick()
{
	var lrArgs = new Array();
	var lsURL = "./t_PFinLoanSheetR.jsp";
	
	lrArgs.CompCode = txtCOMP_CODE.value;
	lrArgs.CompName = txtCOMP_NAME.value;

	if (C_isNull(txtBANK_CODE.value))
	{
		C_msgOk("은행코드가 입력되지 않았습니다.", "확인");
		return;
	}
	
	lrArgs.BankCode = txtBANK_CODE.value;
	lrArgs.BankName = txtBANK_NAME.value;
	lrArgs.AccCode = txtACC_CODE.value;
	
	if (C_isNull(txtDB_AMT.value)&&C_isNull(txtCR_AMT.value))
	{
		C_msgOk("차/대 금액이 입력되지 않았습니다.", "확인");
		txtDB_AMT.focus();
		return;
	}
	lrArgs.DbCr = (SafeToInt(txtDB_AMT.value)==0)?"C":"D";
	
	lrArgs.SlipId = dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_ID");
	lrArgs.SlipIdSeg = dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_IDSEQ");
	
	lrArgs.DbCrAmt = dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DB_AMT")+dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CR_AMT");

	var lsRtn = window.showModalDialog(lsURL, lrArgs, "center:yes; dialogWidth:840px; dialogHeight:500px; status:yes; help:no; scroll:no");
	if(lsRtn!=null) {
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_REFUND_NO") = lsRtn.LOAN_NO;
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_REFUND_NO_R") = lsRtn.LOAN_NO;

		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_REAL_LOAN_NO_R") = lsRtn.REAL_LOAN_NO;		
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_NAME_R") = lsRtn.LOAN_NAME; 
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_KIND_CODE_R") = lsRtn.LOAN_KIND_CODE;
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_EXPR_DT_R") = lsRtn.LOAN_EXPR_DT;
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "LOAN_FDT_R") = lsRtn.LOAN_FDT;
	}
}

function btnLOAN_TRANS_DT_R_onClick()
{
	C_Calendar("LOAN_TRANS_DT_R", "D", txtLOAN_TRANS_DT_R.value);
	S_nextFocus(btnLOAN_TRANS_DT_R);
}

function btnLOAN_REFUND_SCH_DT_R_onClick()
{
	C_Calendar("LOAN_REFUND_SCH_DT_R", "D", txtLOAN_REFUND_SCH_DT_R.value);
	S_nextFocus(btnLOAN_REFUND_SCH_DT_R);
}

function btnLOAN_REFUND_DT_R_onClick()
{
	C_Calendar("LOAN_REFUND_DT_R", "D", txtLOAN_REFUND_DT_R.value);
	S_nextFocus(btnLOAN_REFUND_DT_R);
}

// 예적금
function btnPAYMENT_SEQ_onClick()
{
	/*
	if (txtPAYMENT_SEQ_F.value == txtPAYMENT_SEQ.value) return;
	
	if (C_isNull(txtPAYMENT_SEQ.value))
	{
		return;
	}
	*/

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("ACCNO", txtACCNO_CODE.value);
	
	lrRet = C_AutoLov(dsLOV,"T_DEPOSIT_PAYMENT_LIST1", lrArgs,"T");

	if (lrRet == null) return;
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DEPOSIT_ACCNO")	= lrRet.get("ACCNO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "PAYMENT_SEQ")		= lrRet.get("PAYMENT_SEQ");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "PAYMENT_SCH_DT")	= lrRet.get("PAYMENT_SCH_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "PAYMENT_SCH_AMT")	= lrRet.get("PAYMENT_SCH_AMT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "PAYMENT_DT")		= "";
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "PAYMENT_AMT")		= "";

	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnACCNO_CODE);
}

function btnPAYMENT_DT_onClick()
{
	C_Calendar("PAYMENT_DT", "D", txtPAYMENT_DT.value);
	S_nextFocus(btnPAYMENT_DT);
}

//고정자산
function txtFIX_ASSET_MNG_NO_onblur()
{
	if (txtFIX_ASSET_MNG_NO_F.value == txtFIX_ASSET_MNG_NO.value) {
		Input_Clear();
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtFIX_ASSET_MNG_NO.value);

	lrRet = C_AutoLov(dsLOV,"T_FIX_SHEET_01", lrArgs,"T");

	if (lrRet == null) {
		txtFIX_ASSET_MNG_NO.value = txtFIX_ASSET_MNG_NO_F.value;
		return;
	}

	txtFIX_ASSET_SEQ.value		= lrRet.get("FIX_ASSET_SEQ");
	txtFIX_ASSET_MNG_NO.value	= lrRet.get("ASSET_MNG_NO");
	txtFIX_ASSET_NAME.value		= lrRet.get("ASSET_NAME");
	txtFIX_GET_DT.value			= lrRet.get("GET_DT");
	txtFIX_PRODUCTION.value		= lrRet.get("PRODUCTION");
	txtFIX_MNG_DEPT_NAME.value	= lrRet.get("MNG_DEPT_NAME");
	txtFIX_DEPT_NAME.value		= lrRet.get("DEPT_NAME");
	txtFIX_CUST_NAME.value		= lrRet.get("CUST_NAME");
	
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnCUST_CODE);
}

function btnFIX_ASSET_MNG_NOE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_AutoLov(dsLOV,"T_FIX_SHEET_01", lrArgs,"F");

	if (lrRet == null) {
		txtFIX_ASSET_MNG_NO.value = txtFIX_ASSET_MNG_NO_F.value;
		return;
	}

	txtFIX_ASSET_SEQ.value		= lrRet.get("FIX_ASSET_SEQ");
	txtFIX_ASSET_MNG_NO.value	= lrRet.get("ASSET_MNG_NO");
	txtFIX_ASSET_NAME.value		= lrRet.get("ASSET_NAME");
	txtFIX_GET_DT.value			= lrRet.get("GET_DT");
	txtFIX_PRODUCTION.value		= lrRet.get("PRODUCTION");
	txtFIX_MNG_DEPT_NAME.value	= lrRet.get("MNG_DEPT_NAME");
	txtFIX_DEPT_NAME.value		= lrRet.get("DEPT_NAME");
	txtFIX_CUST_NAME.value		= lrRet.get("CUST_NAME");

	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnCUST_CODE);
}


// 대금지불
function btnPAY_CON_BILL_DT_onClick()
{
	C_Calendar("PAY_CON_BILL_DT", "D", txtPAY_CON_BILL_DT.value);
	S_nextFocus(btnPAY_CON_BILL_DT);
}

// CP매입 설정
function txtCP_NO_S_onblur()
{
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_NO") = dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_NO_S");
}

function btnCP_BUY_PUBL_DT_onClick()
{
	C_Calendar("CP_BUY_PUBL_DT", "D", txtCP_BUY_PUBL_DT.value);
	S_nextFocus(btnCP_BUY_PUBL_DT);
}

function btnCP_BUY_EXPR_DT_onClick()
{
	C_Calendar("CP_BUY_EXPR_DT", "D", txtCP_BUY_EXPR_DT.value);
	S_nextFocus(btnCP_BUY_EXPR_DT);
}

function btnCP_BUY_DUSE_DT_onClick()
{
	C_Calendar("CP_BUY_DUSE_DT", "D", txtCP_BUY_DUSE_DT.value);
	S_nextFocus(btnCP_BUY_DUSE_DT);
}

//주관사(거래처코드)
function txtCP_BUY_CUST_CODE_onblur()
{
	if (txtCP_BUY_CUST_CODE_F.value == txtCP_BUY_CUST_CODE.value) return;
	
	if (C_isNull(txtCP_BUY_CUST_CODE.value))
	{
		Input_Clear();
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCP_BUY_CUST_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_CUST_CODE1", lrArgs,"T");

	if (lrRet == null) return;
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_CUST_SEQ")	= lrRet.get("CUST_SEQ");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_CUST_CODE")	= lrRet.get("CUST_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_CUST_NAME")	= lrRet.get("CUST_NAME");
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnCP_BUY_CUST_CODE);
}

function btnCP_BUY_CUST_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCP_BUY_CUST_CODE.value);

	if (C_isNull(txtCP_BUY_CUST_CODE.value))
	{
		lrRet = C_LOV("T_CUST_CODE1", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_CUST_CODE1", lrArgs,"T");
	}

	if (lrRet == null) return;

	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_CUST_SEQ")	= lrRet.get("CUST_SEQ");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_CUST_CODE")	= lrRet.get("CUST_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_CUST_NAME")	= lrRet.get("CUST_NAME");
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnCP_BUY_CUST_CODE);
}

// CP매입 반제
function txtCP_NO_R_onblur()
{
	if (txtCP_NO_R_F.value == txtCP_NO_R.value) return;
	
	if (C_isNull(txtCP_NO_R.value))
	{
		Input_Clear();
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SLIP_ID", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_ID"));
	lrArgs.set("SLIP_IDSEQ", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_IDSEQ"));
	lrArgs.set("SEARCH_CONDITION", txtCP_NO_R.value);

	lrRet = C_AutoLov(dsLOV,"T_FIN_CP_BUY_01", lrArgs,"T");

	if (lrRet == null) {
		txtCP_NO_R.value = txtCP_NO_R_F.value;
		return;
	}
	
	var vSLIP_AMT = SafeToInt(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DB_AMT")) + SafeToInt(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CR_AMT"));
	if (vSLIP_AMT != SafeToInt(lrRet.get("PUBL_AMT").replace(/,/g, "")))
	{
		C_msgOk("전표금액과 어음발행금액이 일치하지 않습니다.", "확인");
		return;
	}

	var	vRowIdx	= dsSLIP_D.NameValueRow("CP_NO_R",lrRet.get("CP_NO"));
	if ((vRowIdx	!= 0) && (dsSLIP_D.RowPosition != vRowIdx))
	{
		C_msgOk(dsSLIP_D.NameString(vRowIdx, "MAKE_SLIPLINE") + "번 라인에서 이미 반제되었습니다.", "확인");
		return;
	}

	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_NO")				= lrRet.get("CP_NO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_NO_R")				= lrRet.get("CP_NO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_PUBL_DT_R")	= lrRet.get("PUBL_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_EXPR_DT_R")	= lrRet.get("EXPR_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_DUSE_DT_R")	= lrRet.get("DUSE_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_PUBL_AMT_R")	= lrRet.get("PUBL_AMT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_INCOME_AMT_R")	= lrRet.get("INCOME_AMT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_RESET_AMT_R")	= lrRet.get("RESET_AMT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_PUBL_PLACE_R")	= lrRet.get("PUBL_PLACE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_PUBL_NAME_R")	= lrRet.get("PUBL_NAME");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_INTR_RAT_R")	= lrRet.get("INTR_RAT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_CUST_SEQ_R")	= lrRet.get("CUST_SEQ");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_CUST_CODE_R")	= lrRet.get("CUST_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_CUST_NAME_R")	= lrRet.get("CUST_NAME");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_ID")		= lrRet.get("SLIP_ID");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_IDSEQ")	= lrRet.get("SLIP_IDSEQ");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIPNO")		= lrRet.get("SLIPNO");
	Input_Detail_Display();
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnCP_NO_R);
}

function btnCP_NO_R_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SLIP_ID", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_ID"));
	lrArgs.set("SLIP_IDSEQ", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_IDSEQ"));
	lrArgs.set("SEARCH_CONDITION", txtCP_NO_R.value);

	lrRet = C_LOV("T_FIN_CP_BUY_01", lrArgs,"T");

	if (lrRet == null) {
		txtCP_NO_R.value = txtCP_NO_R_F.value;
		return;
	}

	var vSLIP_AMT = SafeToInt(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DB_AMT")) + SafeToInt(dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CR_AMT"));
	if (vSLIP_AMT != SafeToInt(lrRet.get("PUBL_AMT").replace(/,/g, "")))
	{
		C_msgOk("전표금액과 어음발행금액이 일치하지 않습니다.", "확인");
		return;
	}

	var	vRowIdx	= dsSLIP_D.NameValueRow("CP_NO_R",lrRet.get("CP_NO"));
	if ((vRowIdx	!= 0) && (dsSLIP_D.RowPosition != vRowIdx))
	{
		C_msgOk(dsSLIP_D.NameString(vRowIdx, "MAKE_SLIPLINE") + "번 라인에서 이미 반제되었습니다.", "확인");
		return;
	}
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_NO")				= lrRet.get("CP_NO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_NO_R")				= lrRet.get("CP_NO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_PUBL_DT_R")	= lrRet.get("PUBL_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_EXPR_DT_R")	= lrRet.get("EXPR_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_DUSE_DT_R")	= lrRet.get("DUSE_DT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_PUBL_AMT_R")	= lrRet.get("PUBL_AMT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_INCOME_AMT_R")	= lrRet.get("INCOME_AMT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_RESET_AMT_R")	= lrRet.get("RESET_AMT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_PUBL_PLACE_R")	= lrRet.get("PUBL_PLACE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_PUBL_NAME_R")	= lrRet.get("PUBL_NAME");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_INTR_RAT_R")	= lrRet.get("INTR_RAT");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_CUST_SEQ_R")	= lrRet.get("CUST_SEQ");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_CUST_CODE_R")	= lrRet.get("CUST_CODE");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CP_BUY_CUST_NAME_R")	= lrRet.get("CUST_NAME");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_ID")		= lrRet.get("SLIP_ID");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_IDSEQ")	= lrRet.get("SLIP_IDSEQ");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIPNO")		= lrRet.get("SLIPNO");
	Input_Detail_Display();
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnCP_NO_R);
}

// 사원번호
function txtEMP_NO_onblur()
{
	if (txtEMP_NO_F.value == txtEMP_NO.value) return;
	
	if (C_isNull(txtEMP_NO.value))
	{
		Input_Clear();
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtEMP_NO.value);

	lrRet = C_AutoLov(dsLOV,"Z_AUTHORITY_USER01", lrArgs,"T");

	if (lrRet == null) {
		txtEMP_NO.value = txtEMP_NO_F.value;
		return;
	}
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "EMP_NO")		= lrRet.get("EMPNO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "EMP_NAME")	= lrRet.get("NAME");
	
	Input_Detail_Display();
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnEMP_NO);
}

function btnEMP_NO_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtEMP_NO.value);

	lrRet = C_LOV("Z_AUTHORITY_USER01", lrArgs,"T");

	if (lrRet == null) {
		txtEMP_NO.value = (txtEMP_NO_F.value=="")?txtEMP_NO.value:txtEMP_NO_F.value;
		return;
	}
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "EMP_NO")		= lrRet.get("EMPNO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "EMP_NAME")	= lrRet.get("NAME");

	Input_Detail_Display();
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnEMP_NO);
}

// 지급희망일
function btnANTICIPATION_DT_onClick()
{
	C_Calendar("ANTICIPATION_DT", "D", txtANTICIPATION_DT.value);
	S_nextFocus(btnANTICIPATION_DT);
}

// 현금영수증
function btnCASH_USE_DT_onClick()
{
	C_Calendar("CASH_USE_DT", "D", txtCASH_USE_DT.value);
	S_nextFocus(btnCASH_USE_DT);
}

// 카드영수증
function txtCARD_CARDNO_onblur()
{
	if (txtCARD_CARDNO_F.value == txtCARD_CARDNO.value) return;
	
	if (C_isNull(txtCARD_CARDNO.value))
	{
		Input_Clear();
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("CARD_CLS", "1");
	lrArgs.set("CARDNO", txtCARD_CARDNO.value);

	lrRet = C_AutoLov(dsLOV,"T_ACC_CREDCARD1", lrArgs,"T");

	if (lrRet == null) return;
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_SEQ")		= lrRet.get("CARD_SEQ");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_CARDNO")		= lrRet.get("CARDNO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_HAVE_PERS")	= lrRet.get("CARD_OWNER");
	
	Input_Detail_Display();
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnCARD_CARDNO);
}

function btnCARD_CARDNO_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("CARD_CLS", "1");
	lrArgs.set("CARDNO", txtCARD_CARDNO.value);

	lrRet = C_AutoLov(dsLOV,"T_ACC_CREDCARD1", lrArgs,"T");

	if (lrRet == null) return;
	
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_SEQ")		= lrRet.get("CARD_SEQ");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_CARDNO")		= lrRet.get("CARDNO");
	dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CARD_HAVE_PERS")	= lrRet.get("CARD_OWNER");
	Input_Detail_Display();
	Input_Detail_Clear();
	Input_Color_ReadOnly();
	Input_Clear();
	S_nextFocus(btnCARD_CARDNO);
}

function btnCARD_USE_DT_onClick()
{
	C_Calendar("CARD_USE_DT", "D", txtCARD_USE_DT.value);
	S_nextFocus(btnCARD_USE_DT);
}

// 잔액관리
function txtRESET_SLIPNO_onblur()
{
   	Input_Clear()
}

function btnRESET_SLIPNO_onClick()
{
	//차입설정
	if ((dsSLIP_D.NameString(dsSLIP_D.RowPosition,"LOAN_NO_MNG") == "T") && (IsValidAccOSideCurrent))
	{
		var lrArgs = new C_Dictionary();
		var lrRet = null;
		lrArgs.set("CUR_SLIP_ID1", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_ID"));
		lrArgs.set("CUR_SLIP_IDSEQ1", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_IDSEQ"));
		lrArgs.set("CUR_SLIP_ID2", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_ID"));
		lrArgs.set("CUR_SLIP_IDSEQ2", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_IDSEQ"));	
		lrArgs.set("CUR_SLIP_ID3", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_ID"));
		lrArgs.set("CUR_SLIP_IDSEQ3", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_IDSEQ"));	
		lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
		lrArgs.set("DEPT_CODE", txtDEPT_CODE.value);
		lrArgs.set("CUST_SEQ", txtCUST_SEQ.value);
		lrArgs.set("ACC_CODE", txtACC_CODE.value);
		lrArgs.set("LOAN_REFUND_NO", txtLOAN_NO_R.value);
	
		lrRet = C_LOV_NEW("T_ACC_SLIP_REMAIN02", btnRESET_SLIPNO, lrArgs, "T");
	
		if (lrRet == null) return;
	
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIPNO")		= lrRet.get("MAKE_SLIPNO");
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_ID")		= lrRet.get("SLIP_ID");
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_IDSEQ")	= lrRet.get("SLIP_IDSEQ");
		Input_Detail_Display();
		Input_Detail_Clear();
		Input_Color_ReadOnly();
		Input_Clear();
		S_nextFocus(btnRESET_SLIPNO);
	} else {
		var lrArgs = new C_Dictionary();
		var lrRet = null;
		lrArgs.set("CUR_SLIP_ID1", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_ID"));
		lrArgs.set("CUR_SLIP_IDSEQ1", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_IDSEQ"));
		lrArgs.set("CUR_SLIP_ID2", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_ID"));
		lrArgs.set("CUR_SLIP_IDSEQ2", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_IDSEQ"));	
		lrArgs.set("CUR_SLIP_ID3", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_ID"));
		lrArgs.set("CUR_SLIP_IDSEQ3", dsSLIP_D.NameString(dsSLIP_D.RowPosition, "SLIP_IDSEQ"));	
		lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
		lrArgs.set("DEPT_CODE", txtDEPT_CODE.value);
		lrArgs.set("CUST_SEQ1", txtCUST_SEQ.value);
		lrArgs.set("CUST_SEQ2", txtCUST_SEQ.value);
		lrArgs.set("ACC_CODE", txtACC_CODE.value);
	
		lrRet = C_LOV_NEW("T_ACC_SLIP_REMAIN01", btnRESET_SLIPNO, lrArgs, "T");
	
		if (lrRet == null) return;

		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DEPT_CODE")	= lrRet.get("DEPT_CODE");
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "DEPT_NAME")	= lrRet.get("DEPT_NAME");
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CLASS_CODE")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CLASS_NAME")	= "";
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CUST_SEQ")	= lrRet.get("CUST_SEQ");
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CUST_CODE")	= lrRet.get("CUST_CODE");
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "CUST_NAME")	= lrRet.get("CUST_NAME");
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIPNO")		= lrRet.get("MAKE_SLIPNO");
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_ID")		= lrRet.get("SLIP_ID");
		dsSLIP_D.NameString(dsSLIP_D.RowPosition, "RESET_SLIP_IDSEQ")	= lrRet.get("SLIP_IDSEQ");
		Input_Detail_Display();
		Input_Detail_Clear();
		Input_Color_ReadOnly();
		Input_Clear();
		S_nextFocus(btnRESET_SLIPNO);
	}
}

// 대금지불현금
function txtPAY_CON_CASH_onblur()
{
	if(!vUpdate) return;
	var vPAY_CON_CASH = parseInt(txtPAY_CON_CASH.value==""?"0":txtPAY_CON_CASH.value);
	var vPAY_CON_BILL = parseInt(txtPAY_CON_BILL.value==""?"0":txtPAY_CON_BILL.value);

	vPAY_CON_BILL = 100 - vPAY_CON_CASH;

	txtPAY_CON_CASH.value = vPAY_CON_CASH;
	txtPAY_CON_BILL.value = vPAY_CON_BILL;

	if(vPAY_CON_BILL == 0) txtPAY_CON_BILL_DAYS.value = "0";
	else txtPAY_CON_BILL_DAYS.focus();

	//Input_Detail_Display();
	//Input_Detail_Clear();
	Input_Color_ReadOnly();
	//Input_Clear();
	//S_nextFocus(txtPAY_CON_CASH);
}

// 대금지불어음
function txtPAY_CON_BILL_onblur()
{
	if(!vUpdate) return;
	var vPAY_CON_CASH = parseInt(txtPAY_CON_CASH.value==""?"0":txtPAY_CON_CASH.value);
	var vPAY_CON_BILL = parseInt(txtPAY_CON_BILL.value==""?"0":txtPAY_CON_BILL.value);

	vPAY_CON_CASH = 100 - vPAY_CON_BILL;

	txtPAY_CON_CASH.value = vPAY_CON_CASH;
	txtPAY_CON_BILL.value = vPAY_CON_BILL;

	if(vPAY_CON_BILL == 0) txtPAY_CON_BILL_DAYS.value = "0";
	else txtPAY_CON_BILL_DAYS.focus();

	//Input_Detail_Display();
	//Input_Detail_Clear();
	Input_Color_ReadOnly();
	//Input_Clear();
	//S_nextFocus(txtPAY_CON_BILL);
}

// 관리항목
function btnMNG_ITEM_DT1_onClick() {
	C_Calendar("MNG_ITEM_DT1", "D", txtMNG_ITEM_DT1.value);
	S_nextFocus(txtMNG_ITEM_DT1);
}

function btnMNG_ITEM_DT2_onClick() {
	C_Calendar("MNG_ITEM_DT2", "D", txtMNG_ITEM_DT2.value);
	S_nextFocus(txtMNG_ITEM_DT2);
}

function btnMNG_ITEM_DT3_onClick() {
	C_Calendar("MNG_ITEM_DT3", "D", txtMNG_ITEM_DT3.value);
	S_nextFocus(txtMNG_ITEM_DT3);
}

function btnMNG_ITEM_DT4_onClick() {
	C_Calendar("MNG_ITEM_DT4", "D", txtMNG_ITEM_DT4.value);
	S_nextFocus(txtMNG_ITEM_DT4);
}