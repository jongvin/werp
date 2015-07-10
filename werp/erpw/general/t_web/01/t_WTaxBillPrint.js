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
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "부서목록");
	G_addDataSet(dsSUB02, trans,  gridSUB02, sSelectPageName+D_P1("ACT","SUB02"), "부가세자료");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	
	gridSUB01.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	
	//G_setReadOnlyCol(gridSUB01,"DEPT_CODE");
	//G_setReadOnlyCol(gridSUB01,"DEPT_NAME");

	G_addRel(dsSUB01,dsSUB02);
	G_addRelCol(dsSUB02,"SLIP_ID","SLIP_ID");
	G_addRelCol(dsSUB02,"SLIP_IDSEQ","SLIP_IDSEQ");

	G_setLovCol(gridSUB01,"TAX_COMP_CODE");
	G_setLovCol(gridSUB01,"TAX_COMP_NAME");
	
	//G_setReadOnlyCol(gridSUB01,"CLSE_ACC_ID");
	//G_setReadOnlyCol(gridSUB01,"ACC_ID");
	G_setReadOnlyCol(gridSUB01, "KEEP_CLS");
	G_setReadOnlyCol(gridSUB01, "RCPTBILL_CLS");
	G_setReadOnlyCol(gridSUB01, "CUST_CODE");
	G_setReadOnlyCol(gridSUB01, "CUST_NAME");
	//G_setReadOnlyCol(gridSUB01, "SUPAMT");
	//G_setReadOnlyCol(gridSUB01, "VATAMT");
	G_setReadOnlyCol(gridSUB01, "SUMMARY1");
	G_setReadOnlyCol(gridSUB01, "VAT_DT");
	G_setReadOnlyCol(gridSUB01, "DEPT_NAME");
	G_setReadOnlyCol(gridSUB01, "ACC_CODE");
	G_setReadOnlyCol(gridSUB01, "ACC_NAME");
	G_setReadOnlyCol(gridSUB01, "BANK_NAME");
	G_setReadOnlyCol(gridSUB01, "EMP_NO");
	G_setReadOnlyCol(gridSUB01, "EMP_NAME");
	
	G_setLovCol(gridSUB01,"INPUT_DT_F");
	G_setLovCol(gridSUB01,"INPUT_DT_T");

	G_setLovCol(gridSUB02,"PUBL_DT");

	gridSUB01.focus();

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;

	txtMAKE_DEPT_CODE.value = sDeptCode;
	txtMAKE_DEPT_NAME.value = sDeptName;

	txtMAKE_PERS.value = sEmpno;
	txtMAKE_PERS_NAME.value = sName;

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
	if (dataset == dsSUB01)	//시스템명 가져오기
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","SUB01")
											+ D_P2("DATE_CLS",cboDATE_CLS.value)
											+ D_P2("DT_F",txtDT_F.value)
											+ D_P2("DT_T",txtDT_T.value)
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("CUST_CODE",txtCUST_CODE.value)
											+ D_P2("AMT_CLS",cboAMT_CLS.value)
											+ D_P2("DBCR_FAMT",txtDBCR_FAMT.value.replace(/,/gi,""))
											+ D_P2("DBCR_EAMT",txtDBCR_EAMT.value.replace(/,/gi,""))
											+ D_P2("ACC_CODE",txtACC_CODE.value)
											+ D_P2("KEEP_CLS",cboKEEP_CLS.value)
											+ D_P2("RCPTBILL_CLS",	cboRCPTBILL_CLS.value)
											+ D_P2("MAKE_DEPT_CODE",txtMAKE_DEPT_CODE.value)
											+ D_P2("VAT_CODE",txtVAT_CODE.value)
											+ D_P2("DEPT_CODE",txtDEPT_CODE.value)
											+ D_P2("SUMMARY1",txtSUMMARY1.value)
											+ D_P2("TAX_COMP_CODE",txtTAX_COMP_CODE.value)
											+ D_P2("CHARGE_PERS",txtCHARGE_PERS.value)
											+ D_P2("MAKE_PERS",txtMAKE_PERS.value)
											+ D_P2("MAKE_SLIPNO",txtMAKE_SLIPNO.value)
											+ D_P2("SLIP_KIND_TAG",cboSLIP_KIND_TAG.value);
	}
	else if(dataset == dsSUB02)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB02")
										 + D_P2("SLIP_ID",dsSUB01.NameString(dsSUB01.RowPosition, "SLIP_ID"))
										 + D_P2("SLIP_IDSEQ",		dsSUB01.NameString(dsSUB01.RowPosition, "SLIP_IDSEQ"));
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
	if(dsSUB01.CountRow == 0)
	{
   		C_msgOk("출력할 대상이 없습니다.");
   		return false;
   	}
	var i = 0;
	var chk_cnt = 0;
	for(i=1;i<=dsSUB01.CountRow;i++){
		if(dsSUB01.NameString(i,"CHK_CLS")=="T") chk_cnt++;
	}
	if (chk_cnt!=0)
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

	trans.Parameters = "ACT=PRINT01";
	G_saveData(dsSUB01);
	
	var i = 0;
	for(i=1;i<=dsSUB01.CountRow;i++){
		dsSUB01.NameString(i,"CHK_CLS")="F";
	}
	dsSUB01.ResetStatus();

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
	strTemp += "PAGE_ID__" + vPAGE_ID + "&&";
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
	if(!CheckCompCode()) return;
	dsSUB01.ResetStatus();
	dsSUB02.ResetStatus();
	D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
	if(G_FocusDataset==dsSUB01) {
	}
	else if(G_FocusDataset==dsSUB02) {
		if(dsSUB01.CountRow==0) {
			C_msgOk("전표자료가 선택되지 않았습니다.", "확인");
			return;
		}
		if(!G_addRow(dsSUB02)) return;
		dsSUB02.NameString(dsSUB02.RowPosition, "BODY_SEQ") = parseInt(dsSUB02.NameMax("BODY_SEQ",0,0))+1;
	}

}

// 삽입
function btninsert_onclick()
{
	btnadd_onclick();
}

// 삭제
function btndelete_onclick()
{
	if(G_FocusDataset==dsSUB01) {
	} else if(G_FocusDataset==dsSUB02) {
		//dsSUB02.DeleteMarked();
		G_MultiDeleteRow(dsSUB02);
	}
}

// 저장
function btnsave_onclick()
{
	trans.Parameters = "";
	D_defaultSave(dsSUB01);

	gridSUB01.focus();
	D_defaultLoad();
}

// 취소
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 전체선택
function btnAllSelect_onClick()
{
	for(i=1;i<=dsSUB01.CountRow;i++)
	{
		dsSUB01.NameString(i,"CHK_CLS") = "T";
	}
}

// 전체선택취소
function btnAllSelCancle_onClick()
{
	for(i=1;i<=dsSUB01.CountRow;i++)
	{
		dsSUB01.NameString(i,"CHK_CLS") = "F";
	}
}
// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "INPUT_DT_F")
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"INPUT_DT_F") = asDate;
	}
	else if (asCalendarID == "INPUT_DT_T")
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"INPUT_DT_T") = asDate;
	}
	else if (asCalendarID == "DT_F")
	{
		txtDT_F.value = asDate;
	}
	else if (asCalendarID == "DT_T")
	{
		txtDT_T.value = asDate;
	}
	else if (asCalendarID == "PUBL_DT")
	{
		G_FocusDataset.NameString(G_FocusDataset.RowPosition,"PUBL_DT") = asDate;
	}
}

function OnLoadCompleted(dataset, rowcnt)
{
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

function OnColumnChanged(dataset, row, colid)
{
	if(dataset == dsSUB02)
	{
		if( colid == "CNT" )
		{
			dataset.NameString(dataset.RowPosition,"SUPAMT") = 
				dataset.NameString(dataset.RowPosition,"CNT")*dataset.NameString(dataset.RowPosition,"UCOST");
			if (dsSUB01.NameString(dsSUB01.RowPosition,"RCPTBILL_CLS")=='01')
			{
				dataset.NameString(dataset.RowPosition,"VATAMT") = dataset.NameString(dataset.RowPosition,"SUPAMT")/10;
			} else {
				dataset.NameString(dataset.RowPosition,"VATAMT") = 0;
			}
		}
		else if( colid == "UCOST" )
		{
			dataset.NameString(dataset.RowPosition,"SUPAMT") = 
				dataset.NameString(dataset.RowPosition,"CNT")*dataset.NameString(dataset.RowPosition,"UCOST");
			if (dsSUB01.NameString(dsSUB01.RowPosition,"RCPTBILL_CLS")=='01')
			{
				dataset.NameString(dataset.RowPosition,"VATAMT") = dataset.NameString(dataset.RowPosition,"SUPAMT")/10;
			} else {
				dataset.NameString(dataset.RowPosition,"VATAMT") = 0;
			}
		}
		else if( colid == "SUPAMT" )
		{
			if (dsSUB01.NameString(dsSUB01.RowPosition,"RCPTBILL_CLS")=='01')
			{
				dataset.NameString(dataset.RowPosition,"VATAMT") = dataset.NameString(dataset.RowPosition,"SUPAMT")/10;
			} else {
				dataset.NameString(dataset.RowPosition,"VATAMT") = 0;
			}
		}
		else if( colid == "VATAMT" )
		{
		}

	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
	if(dataset == dsSUB01)
	{
		if(colid == "INPUT_DT_F" || colid == "INPUT_DT_T")
		{
			var		COL_DATA;
			COL_DATA = dataset.NameString(row,colid);
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
		else if(colid == "TAX_COMP_CODE" || colid == "TAX_COMP_NAME")
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
		
			lrArgs.set("COMP_CODE", dsSUB01.NameString(liDataRow,"COMP_CODE"));
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
	}
	else if(dataset == dsSUB02)
	{
		if( colid == "PUBL_DT" )
		{
			var		COL_DATA;
			COL_DATA = dataset.NameString(row,colid);
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsSUB01)
	{
		var		liDataRow = row;
		if(colid == "INPUT_DT_F")
		{
			C_Calendar("INPUT_DT_F", "D", dsSUB01.NameString(dsSUB01.RowPosition,"INPUT_DT_F"));
		}
		else if(colid == "INPUT_DT_T")
		{
			C_Calendar("INPUT_DT_T", "D", dsSUB01.NameString(dsSUB01.RowPosition,"INPUT_DT_T"));
		}
		else if(colid == "TAX_COMP_CODE" || colid == "TAX_COMP_NAME")
		{
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
	}
	else if(dataset == dsSUB02)
	{
		if( colid == "PUBL_DT" )
		{
			C_Calendar(colid, "D", dsSUB02.NameString(dsSUB02.RowPosition,colid));
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
	}

}

function OnDblClick(dataset, grid, row, colid) {
	if(dataset == dsSUB01)
	{
		if( grid.ColumnProp(colid,"Edit") == 'NONE' ) {
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
	gridSUB01.focus();
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

//거래처코드
function txtCUST_CODE_onblur()
{
	if (C_isNull(txtCUST_CODE.value))
	{
		txtCUST_CODE.value = '';
		txtCUST_NAME.value = '';
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCUST_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_CUST_CODE1", lrArgs,"T");

	if (lrRet == null) return;
	
	txtCUST_CODE.value = lrRet.get("CUST_CODE");
	txtCUST_NAME.value = lrRet.get("CUST_NAME");
}

function btnCUST_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCUST_CODE.value);

	if (C_isNull(txtCUST_CODE.value))
	{
		lrRet = C_LOV("T_CUST_CODE1", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_CUST_CODE1", lrArgs,"T");
	}

	if (lrRet == null) return;

	txtCUST_CODE.value = lrRet.get("CUST_CODE");
	txtCUST_NAME.value = lrRet.get("CUST_NAME");
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

	lrRet = C_AutoLov(dsLOV,"T_ACC_CODE18", lrArgs,"T");

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
		lrRet = C_LOV("T_ACC_CODE18", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_ACC_CODE18", lrArgs,"T");
	}
	
	if (lrRet == null) return;

	txtACC_CODE.value = lrRet.get("ACC_CODE");
	txtACC_NAME.value = lrRet.get("ACC_NAME");
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
	lrArgs.set("SEARCH_CONDITION", txtMAKE_DEPT_CODE.value);

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
	lrArgs.set("SEARCH_CONDITION", txtMAKE_DEPT_CODE.value);

	lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"T");

	if (lrRet == null) return;

	txtMAKE_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtMAKE_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
	txtMAKE_PERS.value = "";
	txtMAKE_PERS_NAME.value = "";
	//G_Load(dsCLASS_CODE, null);
}

//증빙코드
function txtVAT_CODE_onblur()
{
	if (C_isNull(txtVAT_CODE.value))
	{
		txtVAT_CODE.value = '';
		txtVAT_NAME.value = '';
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtVAT_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_VAT_CODE1", lrArgs,"T");

	if (lrRet == null) return;
	
	txtVAT_CODE.value = lrRet.get("VAT_CODE");
	txtVAT_NAME.value = lrRet.get("VAT_NAME");


}

function btnVAT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtVAT_CODE.value);

	if (C_isNull(txtVAT_CODE.value))
	{
		lrRet = C_LOV("T_VAT_CODE1", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_VAT_CODE1", lrArgs,"T");
	}

	if (lrRet == null) return;

	txtVAT_CODE.value = lrRet.get("VAT_CODE");
	txtVAT_NAME.value = lrRet.get("VAT_NAME");
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
	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE3", lrArgs,"T");

	if (lrRet == null) {
		txtDEPT_CODE.value = txtDEPT_CODE_F.value;
		return;
	}
	
	if (txtDEPT_CODE.value == lrRet.get("DEPT_CODE")) return;
	
	txtDEPT_CODE.value = lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value = lrRet.get("DEPT_NAME");
	//dsSLIP_D.NameValue(dsSLIP_D.RowPosition, "TAX_COMP_CODE")	= lrRet.get("TAX_COMP_CODE");
	//dsSLIP_D.NameValue(dsSLIP_D.RowPosition, "TAX_COMP_NAME")	= lrRet.get("TAX_COMP_NAME");
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

	if (lrRet == null) return;
	if (txtDEPT_CODE.value == lrRet.get("DEPT_CODE")) return;
	
	txtDEPT_CODE.value = lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value = lrRet.get("DEPT_NAME");
}

//세무사업장
function txtTAX_COMP_CODE_onblur() 
{
	
	if (C_isNull(txtTAX_COMP_CODE.value))
	{
		txtTAX_COMP_CODE.value = '';
		txtTAX_COMP_NAME.value = '';
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtTAX_COMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE", lrArgs,"T");

	if (lrRet == null) return;
	
	txtTAX_COMP_CODE.value	= lrRet.get("COMP_CODE");
	txtTAX_COMP_NAME.value	= lrRet.get("COMPANY_NAME");
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

	txtTAX_COMP_CODE.value	= lrRet.get("COMP_CODE");
	txtTAX_COMP_NAME.value	= lrRet.get("COMPANY_NAME");
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