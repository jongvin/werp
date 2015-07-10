/**************************************************************************/
/* 1. 프 로 그 램 id : t_WWorkCodeR.js(자동전표코드등록)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-18)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsLOV,  null,   null, null, "LOV");

	G_addDataSet(dsBATCH01, transBATCH01, null, null, "부서목록");

	G_addDataSet(dsMAIN,  trans,   gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "세무신고기수");
	G_addDataSet(dsSUB01, trans,  gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "부가세자료");

	G_addDataSet(dsWORK_NO,  null,   null, null, "WORK_NO");
	G_addDataSet(dsSEQ,  null,   null, null, "SEQ");

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	
	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"COMP_CODE","COMP_CODE");
	G_addRelCol(dsSUB01,"WORK_NO","WORK_NO");

	
	//G_setLovCol(gridSUB01,"ACC_CODE");

	G_setReadOnlyCol(gridSUB01, "CUR_DIV_RATIO");
	G_setReadOnlyCol(gridSUB01, "GONG_DIV_RATIO");
	G_setReadOnlyCol(gridSUB01, "PRE_DIV_RATIO");
	G_setReadOnlyCol(gridSUB01, "CUR_DIV_TAX_AMT");
	G_setReadOnlyCol(gridSUB01, "CUR_DIV_ACC_AMT");

	G_setLovCol(gridMAIN,"WORK_DATE");
	G_setLovCol(gridMAIN,"BASE_DT_F");
	G_setLovCol(gridMAIN,"BASE_DT_T");
	G_setLovCol(gridMAIN,"MISSING_PROCESS_DT_F");

	G_setLovCol(gridSUB01,"TAX_COMP_CODE");
	G_setLovCol(gridSUB01,"TAX_COMP_NAME");

	G_setLovCol(gridSUB01,"PUBL_DT");
	G_setLovCol(gridSUB01,"DEPT_NAME");
	G_setLovCol(gridSUB01,"CUST_NAME");

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	gridMAIN.TabToss = false;
	gridSUB01.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	gridSUB01.TabToss = false;

	cboTAX_YEAR.value = vDate.substring(0,4);

	gridMAIN.focus();
	//btnquery_onclick();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										 + D_P2("COMP_CODE",txtCOMP_CODE.value)
										 + D_P2("TAX_YEAR",cboTAX_YEAR.value);
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
										 + D_P2("COMP_CODE",dsMAIN.NameString(dsMAIN.RowPosition, "COMP_CODE"))
										 + D_P2("WORK_NO",dsMAIN.NameString(dsMAIN.RowPosition, "WORK_NO"));
	}
	else if(dataset == dsWORK_NO)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","WORK_NO");
	}
	else if(dataset == dsSEQ)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SEQ");
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
   		C_msgOk("세무신고기수가 선택되지 않았습니다.");
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

	var vCompCode = txtCOMP_CODE.value;
	var vCompName = txtCOMPANY_NAME.value;
	//var vWorkNo   = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_NO");
	var vTaxYear	= dsMAIN.NameString(dsMAIN.RowPosition,"TAX_YEAR");
	var vTaxGi		= dsMAIN.NameString(dsMAIN.RowPosition,"TAX_GI");
	var vTaxConf	= dsMAIN.NameString(dsMAIN.RowPosition,"TAX_CONF");
	var vPublDtF	= dsMAIN.NameString(dsMAIN.RowPosition,"BASE_DT_F");
	var vPublDtT	= dsMAIN.NameString(dsMAIN.RowPosition,"BASE_DT_T");
	var vMakeDt		= vDate;

	// 보고서 디렉토리
   	var reportFile = sReportName;
   	
	frmList.EXPORT_TAG.value = 'P';//cboExportTag.value;
	frmList.RUN_TAG.value = '1';//cboRunTag.value;
	frmList.REQUEST_NAME.value = '';//txtRequestName.value;
	frmList.REPORT_NO.value = '--';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	var strTemp = "";
	// 프로그래머 파라메터 추가
	// 파라메터1__값1&&파라메터2__값2&&....
	// 예제
	strTemp += "pCOMP_CODE__" + vCompCode;
	strTemp += "&&pTAX_YEAR__" + vTaxYear;
	strTemp += "&&pTAX_GI__" + vTaxGi;
	strTemp += "&&pTAX_CONF__" + vTaxConf;
	strTemp += "&&pPUBL_DT_F__" + vPublDtF
	strTemp += "&&pPUBL_DT_T__" + vPublDtT
	strTemp += "&&pMAKE_DT__" + vMakeDt
	//strTemp += "ConsultSeq__" + strConsultSeq;

	
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
	D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
	C_msgOk("현 프로그램에서는 추가/삽입 기능을 지원하지 않습니다.", "확인");
	return;
}

// 삽입
function btninsert_onclick()
{
	C_msgOk("현 프로그램에서는 추가/삽입 기능을 지원하지 않습니다.", "확인");
	return;
}

// 삭제
function btndelete_onclick()
{
	if(G_FocusDataset==dsMAIN) {
		//D_defaultDelete();
	} else if(G_FocusDataset==dsSUB01) {
		//dsSUB01.DeleteMarked();
		G_MultiDeleteRow(dsSUB01);
	}
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
	if (asCalendarID == "WORK_DATE")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"WORK_DATE") = asDate;
	}
	else if (asCalendarID == "BASE_DT_F")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"BASE_DT_F") = asDate;
	}
	else if (asCalendarID == "BASE_DT_T")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"BASE_DT_T") = asDate;
	}
	else if (asCalendarID == "MISSING_PROCESS_DT_F")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"MISSING_PROCESS_DT_F") = asDate;
	}
	else if (asCalendarID == "PUBL_DT")
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"PUBL_DT") = asDate;
	}
}

function OnLoadCompleted(dataset, rowcnt)
{
}

function OnRowInsertBefore(dataset)
{
	if (dataset == dsMAIN)
	{
	}
	else if(dataset == dsSUB01)
	{
	}
	return true;
}

function OnRowInserted(dataset, row)
{
	var idx = 0;
	if (dataset == dsMAIN)
	{
	}
	else if(dataset == dsSUB01)
	{
	}
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
	if(dataset == dsSUB01)
	{
		//if(dsSUB01.NameString(row,"UDT_TAG")=="O") dsSUB01.NameString(row,"UDT_TAG") = 'U';
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
	if (dataset == dsMAIN)
	{
		if( colid == "WORK_DATE" || colid == "BASE_DT_F" || colid == "BASE_DT_T" || colid == "MISSING_PROCESS_DT_F")
		{
			var		COL_DATA;
			COL_DATA = dataset.NameString(row,colid);
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
	else if(dataset == dsSUB01)
	{
		if(colid == "TAX_COMP_CODE" || colid == "TAX_COMP_NAME")
		{
			var		liDataRow = row;
			var			lsNewData = dataset.NameString(row,colid);
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dsSUB01.NameString(liDataRow,"TAX_COMP_CODE") = "";
				dsSUB01.NameString(liDataRow,"TAX_COMP_NAME") = "";
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
					dsSUB01.NameString(liDataRow,"TAX_COMP_CODE") = lrRet.get("COMP_CODE");
					dsSUB01.NameString(liDataRow,"TAX_COMP_NAME") = lrRet.get("COMPANY_NAME");
				}
			}
			else
			{
				dataset.NameString(liDataRow,colid) = olddata;
			}
		}
		else if( colid == "PUBL_DT" )
		{
			var		COL_DATA;
			COL_DATA = dataset.NameString(row,colid);
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
		else if(colid == "DEPT_CODE" || colid == "DEPT_NAME")
		{
			var	liDataRow = row;
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("COMP_CODE", dsSUB01.NameString(liDataRow,"COMP_CODE"));
			lrArgs.set("SEARCH_CONDITION", dsSUB01.NameString(liDataRow,"DEPT_NAME"));
		
			lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE3", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsSUB01.NameString(liDataRow,"DEPT_CODE") = lrRet.get("DEPT_CODE");
					dsSUB01.NameString(liDataRow,"DEPT_NAME") = lrRet.get("DEPT_NAME");
				}
			}
		}
		else if(colid == "CUST_CODE" || colid == "CUST_NAME")
		{
			var	liDataRow = row;
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", dsSUB01.NameString(liDataRow,"CUST_NAME").replace(/-/g, ""));
		
			lrRet = C_LOV("T_CUST_CODE1", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsSUB01.NameString(liDataRow,"CUST_SEQ") = lrRet.get("CUST_SEQ");
					dsSUB01.NameString(liDataRow,"CUST_CODE") = lrRet.get("CUST_CODE");
					dsSUB01.NameString(liDataRow,"CUST_NAME") = lrRet.get("CUST_NAME");
				}
			}
		}
	}
}

function OnPopup(dataset, grid, row, colid, olddata)
{
	if (dataset == dsMAIN)
	{
		if( colid == "WORK_DATE" )
		{
			C_Calendar(colid, "D", dsMAIN.NameString(dsMAIN.RowPosition,colid));
		}
		else if( colid == "BASE_DT_F" )
		{
			C_Calendar(colid, "D", dsMAIN.NameString(dsMAIN.RowPosition,colid));
		}
		else if( colid == "BASE_DT_T" )
		{
			C_Calendar(colid, "D", dsMAIN.NameString(dsMAIN.RowPosition,colid));
		}
		else if( colid == "MISSING_PROCESS_DT_F")
		{
			C_Calendar(colid, "D", dsMAIN.NameString(dsMAIN.RowPosition,colid));
		}
	}
	else if(dataset == dsSUB01)
	{
		if(colid == "TAX_COMP_CODE" || colid == "TAX_COMP_NAME")
		{
			var	liDataRow = row;
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_COMP_CODE", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsSUB01.NameString(liDataRow,"TAX_COMP_CODE") = lrRet.get("COMP_CODE");
					dsSUB01.NameString(liDataRow,"TAX_COMP_NAME") = lrRet.get("COMPANY_NAME");
				}
			}
		}

		else if( colid == "PUBL_DT" )
		{
			C_Calendar(colid, "D", dsSUB01.NameString(dsSUB01.RowPosition,colid));
		}

		else if(colid == "DEPT_CODE" || colid == "DEPT_NAME")
		{
			var	liDataRow = row;
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("COMP_CODE", dsSUB01.NameString(liDataRow,"COMP_CODE"));
			lrArgs.set("SEARCH_CONDITION", dsSUB01.NameString(liDataRow,"DEPT_NAME"));
		
			lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE3", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsSUB01.NameString(liDataRow,"DEPT_CODE") = lrRet.get("DEPT_CODE");
					dsSUB01.NameString(liDataRow,"DEPT_NAME") = lrRet.get("DEPT_NAME");
				}
			}
		}
		else if(colid == "CUST_CODE" || colid == "CUST_NAME")
		{
			var	liDataRow = row;
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", dsSUB01.NameString(liDataRow,"CUST_NAME").replace(/-/g, ""));
		
			lrRet = C_LOV("T_CUST_CODE1", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsSUB01.NameString(liDataRow,"CUST_SEQ") = lrRet.get("CUST_SEQ");
					dsSUB01.NameString(liDataRow,"CUST_CODE") = lrRet.get("CUST_CODE");
					dsSUB01.NameString(liDataRow,"CUST_NAME") = lrRet.get("CUST_NAME");
				}
			}
		}
	}

}

function OnDuplicateColumn(dataset,grid,row,colid) {
	if(dataset == dsSUB01)
	{
		if(colid == "TAX_COMP_CODE" || colid == "TAX_COMP_NAME")
		{
			if(row>=2) {
				dsSUB01.NameString(row,"TAX_COMP_CODE") = dsSUB01.NameString(row-1,"TAX_COMP_CODE");
				dsSUB01.NameString(row,"TAX_COMP_NAME") = dsSUB01.NameString(row-1,"TAX_COMP_NAME");
			}
		}
		else if(colid == "DEPT_CODE" || colid == "DEPT_NAME")
		{
			if(row>=2) {
				dsSUB01.NameString(row,"DEPT_CODE") = dsSUB01.NameString(row-1,"DEPT_CODE");
				dsSUB01.NameString(row,"DEPT_NAME") = dsSUB01.NameString(row-1,"DEPT_NAME");
			}
		}
		else if(colid == "CUST_CODE" || colid == "CUST_NAME")
		{
			if(row>=2) {
				dsSUB01.NameString(row,"CUST_SEQ") = dsSUB01.NameString(row-1,"CUST_SEQ");
				dsSUB01.NameString(row,"CUST_CODE") = dsSUB01.NameString(row-1,"CUST_CODE");
				dsSUB01.NameString(row,"CUST_NAME") = dsSUB01.NameString(row-1,"CUST_NAME");
			}
		}
	}
}

// 이벤트관련-------------------------------------------------------------------//
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

function btnBatchInput_onClick()
{
	if(dsMAIN.CountRow==0) {
		C_msgOk("세무신고기수를 먼저 선택하세요.", "확인");
		return;
	}
	if(dsSUB01.CountRow!=0) {
		var	vRet = C_msgYesNo("현재신고기수에 안분비율 산출내역이 존재합니다. 계속진행하면 현 데이터를 모두 삭제하고 재계산합니다.<br>계속 진행하시겠습니까?", "경고");
		if (vRet != "Y") return;
	}

	var vTmp = "COMP_CODE:STRING(30),WORK_NO:DECIMAL";
	dsBATCH01.ClearAll();
	dsBATCH01.SetDataHeader(vTmp);
	dsBATCH01.AddRow();
	dsBATCH01.NameString(1,"COMP_CODE") = dsMAIN.NameString(dsMAIN.RowPosition, "COMP_CODE");
	dsBATCH01.NameString(1,"WORK_NO") = dsMAIN.NameString(dsMAIN.RowPosition, "WORK_NO");

	transBATCH01.Parameters = "ACT=BATCH01";
	G_saveData(dsBATCH01);

	G_Load(dsSUB01, null);
}