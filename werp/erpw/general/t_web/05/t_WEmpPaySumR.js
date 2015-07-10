/**************************************************************************/
/* 1. 프 로 그 램 id : t_WBudgDeptMapR(예산신청)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-30)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var lrArgs = window.dialogArguments;

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
}

function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//시스템명 가져오기
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("DT_F",txtDT_F.value.replace(/-/gi,""))
											+ D_P2("CHUL_TAG",cboChulTag.value);
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
   	var vDT_F   = txtDT_F.value;
   	
   	if ( C_isNull(vDT_F))
   	{
   		C_msgOk("작업월을 입력하세요");
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
	
	var vDT_F   = txtDT_F.value.replace(/-/g, "");
   
	// 보고서 디렉토리
   	var reportFile = sReportName;
   	
	frmList.EXPORT_TAG.value =cboExportTag.value;
	frmList.RUN_TAG.value = cboRunTag.value;
	frmList.REQUEST_NAME.value = txtRequestName.value;
	frmList.REPORT_NO.value = '--';
	if( cboChulTag.value == "1" ) {
		frmList.REPORT_FILE_NAME.value = reportFile +'_1.rpt';
	} else if( cboChulTag.value == "2" ) {
		frmList.REPORT_FILE_NAME.value = reportFile +'_2.rpt';
	} else if( cboChulTag.value == "3" ) {
		frmList.REPORT_FILE_NAME.value = reportFile +'_3.rpt';
	}
	
	var strTemp = "";
	// 프로그래머 파라메터 추가
	// 파라메터1__값1&&파라메터2__값2&&....
	// 예제
	//strTemp += "ProjCode__" + strProjCode + "&&";
	//strTemp += "ConsultSeq__" + strConsultSeq;
	
	//strTemp += "pCOMP_CODE__" + vCompCode;
	//strTemp += "&&pCOMP_NAME__" + vCompName;
	strTemp += "pDT_F__" + vDT_F;
	//strTemp += "&&pDEPT_CODE__" + vDeptCode;
	//strTemp += "&&pDEPT_NAME__" + vDeptName;
	//strTemp += "&&pACC_CODE__" + vAccCode;
	
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
	if(!print_condition_check()) return;
	if( cboChulTag.value == "1" ) {
		gridMAIN.ColumnProp("TEAM_DEPT_NAME", "Show") = "false";
		gridMAIN.ColumnProp("DEPT_NAME", "Show") = "false";
	} else if( cboChulTag.value == "2" ) {
		gridMAIN.ColumnProp("TEAM_DEPT_NAME", "Show") = "true";
		gridMAIN.ColumnProp("DEPT_NAME", "Show") = "false";
	} else if( cboChulTag.value == "3" ) {
		gridMAIN.ColumnProp("TEAM_DEPT_NAME", "Show") = "false";
		gridMAIN.ColumnProp("DEPT_NAME", "Show") = "true";
	}
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
		if(dataset.NameString(row,"ACC_CODE") == "")
		{
			C_msgOk("집계항목은 상세조회를 할 수 없습니다.", "확인");
			return;
		}
		
		var lsURL = "./t_PSlipRetrieveR.jsp";
		var lrArgs = new C_Dictionary();
		var lrRet = null;

		lrArgs.set("EMP_CLASS_CODE", dataset.NameString(row,"EMP_CLASS_CODE"));
		lrArgs.set("EMP_CLASS_NAME", dataset.NameString(row,"EMP_CLASS_NAME"));
		lrArgs.set("ACC_CODE", dataset.NameString(row,"ACC_CODE"));
		lrArgs.set("ACC_NAME", dataset.NameString(row,"ACC_SHRT_NAME"));
		lrArgs.set("DT_F", txtDT_F.value+"-01");
		lrArgs.set("DT_T", txtDT_F.value+"-"+C_getEndDay(txtDT_F.value));
		if( cboChulTag.value == "1" ) {
			lrArgs.set("DEPT_CODE", "");
			lrArgs.set("DEPT_NAME", "");
		} else if( cboChulTag.value == "2" ) {
			lrArgs.set("DEPT_CODE", dataset.NameString(row,"TEAM_DEPT_CODE"));
			lrArgs.set("DEPT_NAME", dataset.NameString(row,"TEAM_DEPT_NAME"));
		} else if( cboChulTag.value == "3" ) {
			lrArgs.set("DEPT_CODE", dataset.NameString(row,"DEPT_CODE"));
			lrArgs.set("DEPT_NAME", dataset.NameString(row,"DEPT_NAME"));
		}

		var lrRet = window.showModalDialog(lsURL, lrArgs, "center:yes; dialogWidth:920px; dialogHeight:500px; status:yes; help:no; scroll:no");

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

function btnDT_F_onClick()
{
	C_Calendar("DT_F", "M", txtDT_F.value);
	 
}