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
	

	G_addDataSet(dsLOV, null, null,  null, "LOV");
	
			
	txtYMD.value = sYMD;
	
	
}
function OnLoadBefore(dataset)
{

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
function condition_check()
{
	
   	if ( C_isNull(txtYMD.value))
   	{
   		C_msgOk("작업일을 선택하세요");
   		return;
   	}
   
   	
   	return true;
   	
}
// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
//인쇄
function btnquery_prt_onclick()
{
	// 프로그래머 유효성검사 추가
				
	// 공통 Check
	if (!condition_check()) return;
	
	
      
       var vYMD = txtYMD.value

   	//alert(vYear);
   	//alert(vMonth);
  	//return;
  	
   	var reportFile ="";

   	reportFile ="r_t_040047";  

	frmList.EXPORT_TAG.value =cboExportTag.value;
	frmList.RUN_TAG.value = cboRunTag.value;
	frmList.REQUEST_NAME.value = txtRequestName.value;
	frmList.REPORT_NO.value = '00';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
		
	var strTemp = "";

	strTemp = "P_WORK_DT__" + vYMD;
	//strTemp += "&&P_WORK_DT2__" + vYMD;
	//strTemp += "&&P_WORK_DT3__" + vYMD;


	//alert(strTemp);
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}


// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "YMD")
	{
		txtYMD.value = asDate;
	}
}


// 이벤트관련-------------------------------------------------------------------//



function btnYMD_onClick()
{
	C_Calendar("YMD", "D", txtYMD.value);
}


