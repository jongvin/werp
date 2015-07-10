/**************************************************************************/
/* 1. 프 로 그 램 id : t_WBudgAssignByDeptByAccForYearR.js(부서별계정별월별현황(년))
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 부서별계정별월별현황(년)
/* 4. 변  경  이  력 : 한재원 작성(2005-12-29)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	//G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "자동전표코드");

	G_addDataSet(dsMAIN, null, null, sSelectPageName+D_P1("ACT","MAIN"), "사업장");
	G_addDataSet(dsLIST00, null, null,  sSelectPageName+D_P1("ACT","LIST00"), "사업장별 부서목록");

	G_addDataSet(dsLIST02, null, gridLIST02, sSelectPageName+D_P1("ACT","LIST02")	, "부서별-월별 신청내역");

	G_addDataSet(dsLOV, null, null,  null, "LOV");
	G_addDataSet(dsDATE, null, null,  null, "DATE");

	G_addRel(dsMAIN, dsLIST00);

	G_addRelCol(dsLIST00, "COMP_CODE", "COMP_CODE");

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	
	G_Load(dsDATE, null);
	txtBUDG_YYYY_MM_FR.value = dsDATE.NameValue(dsDATE.RowPosition, "CDATE");
	txtBUDG_YYYY_MM_TO.value= dsDATE.NameValue(dsDATE.RowPosition, "CDATE");
	G_Load(dsMAIN, null);
	G_Load(dsLIST00, null);
	
	gridLIST02.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
	}

	if (dataset == dsMAIN)
	{
		//사업장별 부서목록
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
		var vBudgYyyyMmFr = txtBUDG_YYYY_MM_FR.value;
		var vBudgYyyyMmTo = txtBUDG_YYYY_MM_TO.value;
		var vDEPT_CODE = dsLIST00.NameString(dsLIST00.RowPosition,"DEPT_CODE");
		var vDeptFlag = selDeptFlag.value;

		dataset.DataID = sSelectPageName + D_P1("ACT","LIST02")
									 + D_P2("COMP_CODE",vCOMP_CODE)
									 + D_P2("BUDG_YYYY_MM_FR",vBudgYyyyMmFr)
									 + D_P2("BUDG_YYYY_MM_TO",vBudgYyyyMmTo)
									 + D_P2("DEPT_CODE",vDEPT_CODE)
									 + D_P2("DEPT_FLAG",vDeptFlag);

		makeGridTitle(gridLIST02);
	}
	
	if (dataset == dsDATE)
	{
		//사업장별 부서목록
		dataset.DataID = sSelectPageName + D_P1("ACT","DATE");

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
function makeGridTitle(grid)
{
	var vBudgFlagName = "";
	var vDeptFlag = selDeptFlag.value;
	var vDeptFlagName = "";

	//if(vBudgFlag == 'BUDG') {
		vBudgFlagName = "예산";
	//} else if(vBudgFlag == 'APPEND_BUDG') {
	//
	//}

	if(vDeptFlag == 'CHK_DEPT') {
		vDeptFlagName = "통제부서";
	}else if(vDeptFlag == 'DEPT') {
		vDeptFlagName = "부서";
	}

	var gridTitle = "";

	
	if(vDeptFlag !="ALL"){
		gridTitle += "<FC> Name="+vDeptFlagName+" ID=DEPT_TITLE Sort=true Align=Left HeadAlign=Center     Width=140 suppress=1";
		gridTitle += "</FC>                                                                                                                               ";
	}
	gridTitle += "<FC> Name=계정코드 ID=ACC_CODE Sort=true Align=Center HeadAlign=Center     Width=80              ";
	gridTitle += "	 Show=false                                                                                                                       ";
	gridTitle += "</FC>                                                                                                                               ";
	gridTitle += "<FC> Name=계정명칭 ID=ACC_NAME Sort=true Align=Left HeadAlign=Center    Width=250               ";
	gridTitle += "</FC>                                                                                                                               ";
	gridTitle += "	<C> Name="+vBudgFlagName+" ID=pb1 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=사용 ID=s1 Align=Right HeadAlign=Center  Width=120 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=%    ID=r1 Align=Right HeadAlign=Center  Width=40</C>                                                                   ";

	grid.Format = gridTitle;
}
//검색조건체크
function print_condition_check()
{
	var vCompCode = txtCOMP_CODE.value;
   	var vBudgYyyyMmFr   = txtBUDG_YYYY_MM_FR.value;
   	var vBudgYyyyMmTo   = txtBUDG_YYYY_MM_TO.value;
   	
   	if ( C_isNull(vCompCode))
   	{
   		C_msgOk("사업장을 선택하세요");
   		return;
   	}
   	
   	if ( C_isNull(vBudgYyyyMmFr))
   	{
   		C_msgOk("작업년월을 입력하세요");
   		return;
   	}
   	
   	if ( C_isNull(vBudgYyyyMmTo))
   	{
   		C_msgOk("작업년월을 입력하세요");
   		return;
   	}
}
// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
//인쇄
function btnquery_prt_onclick()                      
//------------------------------------------------------------------------
{
	print_condition_check();
	
	var vCompCode  = txtCOMP_CODE.value;
	 
   	var vBudgYyyyMmFr   = txtBUDG_YYYY_MM_FR.value;
   	var vBudgYyyyMmTo   = txtBUDG_YYYY_MM_TO.value;
       var vDeptCode   = dsLIST00.NameString(dsLIST00.RowPosition,"DEPT_CODE");
      
   	var vDeptFlag = selDeptFlag.value;
   
  	var arg_temp;
   	arg_temp ="general_rpt/t_web/08r/" ;       // 보고서 디렉토리
   
   	var reportFile ="";
   	if (vDeptFlag =='ALL')  
   	{
   		reportFile ="r_t_080011";  //전체
   	} 
   	else if (vDeptFlag =='CHK_DEPT')
   	{
   		reportFile ="r_t_080012"; //통제부서별
   	}
   	else if (vDeptFlag =='DEPT') 
   	{
   		reportFile ="r_t_080013"; //부서별
   	} 
   	
   	arg_temp = arg_temp + reportFile ;   // 보고서명 
   	
   	arg_temp = arg_temp +  "&RptParams=" + vBudgYyyyMmFr + "&RptParams=" + vBudgYyyyMmTo+   
   	                      "&RptParams=" + vCompCode + "&RptParams=" + vDeptCode +  "&RptParams=" + vDeptFlag;
   	f_crystal_report(arg_temp) ;  //보고서 호출
}
// 조회
function btnquery_onclick()
{
	CheckBudgYyyyMm();
	D_defaultLoad();
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
	if (asCalendarID == "BUDG_YYYY_MM_FR")
	{
		txtBUDG_YYYY_MM_FR.value = asDate;
	}
	else if (asCalendarID == "BUDG_YYYY_MM_TO")
	{
		txtBUDG_YYYY_MM_TO.value = asDate;
	}
	
	 if( parseInt(txtBUDG_YYYY_MM_FR.value.replace(/-/g, "")) > parseInt(txtBUDG_YYYY_MM_TO.value.replace(/-/g, "")) )
	 {
	 	C_msgOk("시작월이 종료월보다 큽니다");
	 	txtBUDG_YYYY_MM_TO.value="";
	 	btnBUDG_YYYY_MM_TO.focus();
	 	return false;	
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
		
		selDeptFlag.options.length = "0"; 
		var i = 0;
		if(vDeptCode == "***") selDeptFlag.options.options[i++] = new Option("전 체","ALL");
		if(vDeptCode == "***") selDeptFlag.options.options[i++] = new Option("통제부서별","CHK_DEPT");
		if(vDeptCode == "***") selDeptFlag.options.options[i++] = new Option("부서별","DEPT");
		if(vDeptCode != "***") selDeptFlag.options.options[i++] = new Option("부서별","DEPT");
		G_Load(dsLIST02, null);
	}

}

// 이벤트관련-------------------------------------------------------------------//
function deptFlag_onChange()
{
	G_Load(dsLIST02,null);	
}
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

	dsMAIN.ClearData();
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

	dsMAIN.ClearData();
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
	if (C_isNull(txtBUDG_YYYY_MM_FR.value))
	{
		C_msgOk("작업시작월을 입력하세요.", "확인");
		return false;
	}
	if (C_isNull(txtBUDG_YYYY_MM_TO.value))
	{
		C_msgOk("작업종료월을 입력하세요.", "확인");
		return false;
	}
	return true;
}

function btnBUDG_YYYY_MM_FR_onClick()
{
	C_Calendar("BUDG_YYYY_MM_FR", "M", txtBUDG_YYYY_MM_FR.value);
	 
}

function btnBUDG_YYYY_MM_TO_onClick()
{
	C_Calendar("BUDG_YYYY_MM_TO", "M", txtBUDG_YYYY_MM_TO.value);
	
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
 

