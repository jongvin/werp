/**************************************************************************/
/* 1. 프 로 그 램 id : t_WBudgAssignAmtAgainstBudgReqAmtR.js(신청대비배정금액)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 신청대비배정금액
/* 4. 변  경  이  력 : 한재원 작성(2006-1-03)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	
	G_addDataSet(dsLIST00, null, null,  sSelectPageName+D_P1("ACT","LIST00"), "사업장별 부서목록");

	G_addDataSet(dsLIST02, null, gridLIST02, sSelectPageName+D_P1("ACT","LIST02")	, "부서별-월별 신청내역");

	G_addDataSet(dsLOV, null, null,  null, "LOV");
	G_addDataSet(dsDATE, null, null,  null, "DATE");

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	
	G_Load(dsDATE, null);
	txtBUDG_YYYY_MM_FR.value = dsDATE.NameValue(dsDATE.RowPosition, "CDATE");
	txtBUDG_YYYY_MM_TO.value= dsDATE.NameValue(dsDATE.RowPosition, "CDATE");

	G_Load(dsLIST00, null);
	
	gridLIST02.focus();
}
function OnLoadBefore(dataset)
{
	if (dataset == dsLIST00)
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

	var vDeptFlag = selDeptFlag.value;

	var gridTitle = "";

	
	if(vDeptFlag !="ALL"){
		gridTitle += "<FC> Name=팀  ID=chk_dept_name Sort=true Align=Left HeadAlign=Center     Width=80 suppress=3";
		gridTitle += "</FC>                                                                                                                               ";
	}
	if(vDeptFlag !="ALL" && vDeptFlag !="CHK_DEPT" ){
		gridTitle += "<FC> Name=부서  ID=DEPT_NAME Sort=true Align=Left HeadAlign=Center     Width=80 suppress=2";
		gridTitle += "</FC>                                                                                                                               ";
	}
	gridTitle += "<FC> Name=상위계정 ID=p_acc_name Sort=true Align=left HeadAlign=Center    Width=100    suppress=1           ";
	gridTitle += "</FC>                                                                                                                               ";
	gridTitle += "<FC> Name=계정 ID=ACC_NAME Sort=true Align=Left HeadAlign=Center    Width=250               ";
	gridTitle += "</FC>                                                                                                                               ";
	gridTitle += "	<C> Name=신청액 ID=re1 Align=Right HeadAlign=Center  Width=150 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=배정액 ID=as1 Align=Right HeadAlign=Center  Width=150 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=%    ID=r1 Align=Right HeadAlign=Center  Width=40</C>                                                                   ";

	grid.Format = gridTitle;
}
//검색조건체크
function CheckCondition()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("먼저 사업장코드를 선택하세요.", "확인");
		return false;
	}
	
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
	
	if( txtBUDG_YYYY_MM_FR.value.substr(0,4) != txtBUDG_YYYY_MM_TO.value.substr(0,4))
	{
		C_msgOk("동일한 작업년도를 입력하세요.", "확인");
		return false;	
	}
	return true;
	
}
// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
//인쇄
function btnquery_prt_onclick()                      
//------------------------------------------------------------------------
{
	if(!CheckCondition()) return;
	
	var vCompCode  = txtCOMP_CODE.value;
	var vCompName  = txtCOMPANY_NAME.value;
	 
   	var vBudgYyyyMmFr   = txtBUDG_YYYY_MM_FR.value;
   	var vBudgYyyyMmTo   = txtBUDG_YYYY_MM_TO.value;
       var vDeptCode   = dsLIST00.NameString(dsLIST00.RowPosition,"DEPT_CODE");
      
   	var vDeptFlag = selDeptFlag.value;
   
  	var arg_temp;
   
   
   	var reportFile ="";
   
   	
   	reportFile ="r_t_080020";  //전체

   	arg_temp = arg_temp + reportFile ;   // 보고서명 
   	
   	frmList.EXPORT_TAG.value ="P";
	frmList.RUN_TAG.value = "1";
	frmList.REQUEST_NAME.value = "신청대비배정금액";
	frmList.REPORT_NO.value = '00';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	var strTemp = "";

	strTemp += "P_COMP_CODE__" + vCompCode;
	strTemp  += "&&P_BUDG_YYYY_MM_FR__" + vBudgYyyyMmFr;
	strTemp += "&&P_BUDG_YYYY_MM_TO__" + vBudgYyyyMmTo;
	
	strTemp += "&&P_DEPT_CODE__" + vDeptCode;
	strTemp += "&&P_DEPT_FLAG__" + vDeptFlag;
	strTemp  += "&&P_COMP_NAME__" + vCompName;
	
	
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
   	
}
// 조회
function btnquery_onclick()
{
	if(!CheckCondition()) return;
	D_defaultLoad();
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
       if (dataset == dsLIST00)
	{
		//부서
		var vDeptCode = dsLIST00.NameString(dsLIST00.RowPosition,"DEPT_CODE");
		
		selDeptFlag.options.length = "0"; 
		var i = 0;
		if(vDeptCode == "%") selDeptFlag.options.options[i++] = new Option("전 체","ALL");
		if(vDeptCode == "%") selDeptFlag.options.options[i++] = new Option("팀별","CHK_DEPT");
		if(vDeptCode == "%") selDeptFlag.options.options[i++] = new Option("부서별","DEPT");
		if(vDeptCode != "%") selDeptFlag.options.options[i++] = new Option("팀별","CHK_DEPT");
		if(vDeptCode != "%") selDeptFlag.options.options[i++] = new Option("부서별","DEPT");
		
	}

}

// 이벤트관련-------------------------------------------------------------------//
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

	if (lrRet == null) return;

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
 

function btnBUDG_YYYY_MM_FR_onClick()
{
	C_Calendar("BUDG_YYYY_MM_FR", "M", txtBUDG_YYYY_MM_FR.value);
	 
}

function btnBUDG_YYYY_MM_TO_onClick()
{
	C_Calendar("BUDG_YYYY_MM_TO", "M", txtBUDG_YYYY_MM_TO.value);
	
}
 
//출력
function btnPreView_onClick()
{
	btnquery_prt_onclick();
}
 

