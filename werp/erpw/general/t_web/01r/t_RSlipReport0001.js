/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFixAssetClsCodeR.js(자산종류코드등록)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 자산종류코드등록
/* 4. 변  경  이  력 :  한재원작성(2006-01-16)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	//G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "자동전표코드");

	G_addDataSet(dsMAIN, null, null, sSelectPageName+D_P1("ACT","MAIN"), "사업장");
	G_addDataSet(dsLIST00, null, null,  sSelectPageName+D_P1("ACT","LIST00"), "사업장별 부서목록");

	G_addDataSet(dsLIST02, null, null, sSelectPageName+D_P1("ACT","LIST02")	, "부서별-월별 신청내역");

	G_addDataSet(dsLOV, null, null,  null, "LOV");

	G_addRel(dsMAIN, dsLIST00);

	G_addRelCol(dsLIST00, "COMP_CODE", "COMP_CODE");

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtDEPT_CODE.value = sDeptCode;
	txtDEPT_NAME.value = sDeptName;
	
	//G_Load(dsMAIN, null);
	
	//gridLIST02.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
	}

	
	else if (dataset == dsLIST00)
	{
		var vCOMP_CODE = txtCOMP_CODE.value;
		
		dataset.DataID = sSelectPageName + D_P1("ACT","LIST00")
									 + D_P2("COMP_CODE",vCOMP_CODE);
	}

	else if (dataset == dsLIST02)
	{
		var vCOMP_CODE = txtCOMP_CODE.value;
		var vDT_F = txtDT_F.value;
		var vDT_T = txtDT_T.value;
		var vDEPT_CODE = dsLIST00.NameString(dsLIST00.RowPosition,"DEPT_CODE");

		dataset.DataID = sSelectPageName + D_P1("ACT","LIST02")
									 + D_P2("COMP_CODE",vCOMP_CODE)
									 + D_P2("DT_F",vDT_F)
									 + D_P2("DT_T",vDT_T)
									 + D_P2("DEPT_CODE",vDEPT_CODE)
									 ;

		//makeGridTitle(gridLIST02);
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
function btnSch2_onClick()
{
	G_Load(dsLIST02, null);
}

//검색조건체크
function print_condition_check()
{
	var vCompCode = txtCOMP_CODE.value;
   	var vDT_F   = txtDT_F.value;
   	var vDT_T   = txtDT_T.value;

	if ( cboRunTag.value == "2" && txtRequestName.value == "")
   	{
   		C_msgOk("실행구분이 요청일때 요청명을 꼭 입력하셔야 합니다.");
   		return false;
   	}

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
	var vDeptCode  = (txtDEPT_CODE.value=="")?"%":txtDEPT_CODE.value;
	var vDeptName  = (txtDEPT_NAME.value=="")?"전체":txtDEPT_NAME.value;
   	var vDT_F   = txtDT_F.value;
   	var vDT_T   = txtDT_T.value;
   
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

	strTemp += "pCOMP_CODE__" + vCompCode;
	strTemp += "&&pCOMP_NAME__" + vCompName;
	strTemp += "&&pDEPT_CODE__" + vDeptCode;
	strTemp += "&&pDEPT_NAME__" + vDeptName;
	strTemp  += "&&pDT_T__" + vDT_T;
	strTemp += "&&pDT_F__" + vDT_F;

	
	//alert(frmList.REPORT_FILE_NAME.value);
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "DT_F")
	{
		txtDT_F.value = asDate;
		if( parseInt(txtDT_F.value.replace(/-/g, "")) > parseInt(txtDT_T.value.replace(/-/g, "")) )
		{
			C_msgOk("시작일이 종료일보다 큽니다");
			txtDT_F.value="";
			btnDT_F.focus();
		}
	}
	else if (asCalendarID == "DT_T")
	{
		txtDT_T.value = asDate;
		if( parseInt(txtDT_F.value.replace(/-/g, "")) > parseInt(txtDT_T.value.replace(/-/g, "")) )
		{
			C_msgOk("시작일이 종료일보다 큽니다");
			txtDT_T.value="";
			btnDT_T.focus();
		}
	}
	
}
function OnRowPosChanged(dataset, row)
{
	if(row==0) return;
	if (dataset == dsMAIN) {
		//사업장목록
	}
	else if (dataset == dsLIST00)
	{
		//부서
		var vDeptCode = dsLIST00.NameString(dsLIST00.RowPosition,"DEPT_CODE");
	
		//G_Load(dsLIST02,null);
	}

}

// 이벤트관련-------------------------------------------------------------------//
//귀속사업장
function txtCOMP_CODE_onblur() 
{
	// 입력값이 이전값과 같으면 리턴
	if (txtCOMP_CODE_F.value == txtCOMP_CODE.value) return;
	
	// 입력값이 ''이면 리턴
	if (C_isNull(txtCOMP_CODE.value)) {
		txtCOMPANY_NAME.value = "";
		txtDEPT_CODE.value = "";
		txtDEPT_NAME.value = "";
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
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	txtDEPT_CODE.value = "";
	txtDEPT_NAME.value = "";
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE", lrArgs,"F");
	
	// 팝업취소(X)하면
	if (lrRet == null) return;
	
	// 팝업선택값이 이전값과 같으면 그냥 리턴	
	if (txtCOMP_CODE.value == lrRet.get("COMP_CODE")) return;	

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	txtDEPT_CODE.value = "";
	txtDEPT_NAME.value = "";
}

//귀속부서
function txtDEPT_CODE_onblur()
{
	// 입력값이 이전값과 같으면 리턴
	if (txtDEPT_CODE_F.value == txtDEPT_CODE.value) return;
	
	// 입력값이 ''이면 리턴
	if (C_isNull(txtDEPT_CODE.value))
	{
		txtDEPT_CODE.value = "";
		txtDEPT_NAME.value = "";
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
		
	txtDEPT_CODE.value = lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value = lrRet.get("DEPT_NAME");
}

function btnDEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"F");

	// 팝업취소(X)하면
	if (lrRet == null) return;
	
	// 팝업선택값이 이전값과 같으면 그냥 리턴	
	if (txtDEPT_CODE.value == lrRet.get("DEPT_CODE")) return;
	
	txtDEPT_CODE.value = lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value = lrRet.get("DEPT_NAME");
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

function	CheckBudgYyyyMm()
{
	if (C_isNull(txtDT_F.value))
	{
		C_msgOk("작업시작월을 입력하세요.", "확인");
		return false;
	}
	if (C_isNull(txtDT_T.value))
	{
		C_msgOk("작업종료월을 입력하세요.", "확인");
		return false;
	}
	return true;
}

function btnDT_F_onClick()
{
	C_Calendar("DT_F", "D", txtDT_F.value);
	 
}

function btnDT_T_onClick()
{
	C_Calendar("DT_T", "D", txtDT_T.value);
	
}
 
function accFlag_onChange()
{
	G_Load(dsLIST02,null);	
}

 function deptFlag_onChange()
{
	G_Load(dsLIST02,null);	
}
//출력
function btnPreView_onClick()
{
	btnquery_prt_onclick();
}