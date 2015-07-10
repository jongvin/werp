/**************************************************************************/
/* 1. 프 로 그 램 id : t_WWorkCodeR.js(자동전표코드등록)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-18)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var bLoading = 1;
function Initialize()
{
	G_addDataSet(dsLOV,  null,   null, null, "LOV");

	G_addDataSet(dsSUB01, trans,  gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "부가세자료");

	G_addDataSet(dsWORK_NO,  null,   null, null, "WORK_NO");
	G_addDataSet(dsSEQ,  null,   null, null, "SEQ");

	txtTAX_COMP_CODE.value = sCompCode;
	txtTAX_COMPANY_NAME.value = sCompName;
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	
	//G_addRel(dsMAIN,dsSUB01);
	//G_addRelCol(dsSUB01,"COMP_CODE","COMP_CODE");
	//G_addRelCol(dsSUB01,"WORK_NO","WORK_NO");

	
	//G_setLovCol(gridSUB01,"ACC_CODE");

	G_setReadOnlyCol(gridSUB01, "MAKE_SLIPNOLINE");
	G_setReadOnlyCol(gridSUB01, "RCPTBILL_CLS");
	G_setReadOnlyCol(gridSUB01, "SALEBUY_CLS");
	G_setReadOnlyCol(gridSUB01, "MAKE_DT");

	//G_setLovCol(gridMAIN,"WORK_DATE");
	//G_setLovCol(gridMAIN,"BASE_DT_F");
	//G_setLovCol(gridMAIN,"BASE_DT_T");
	//G_setLovCol(gridMAIN,"MISSING_PROCESS_DT_F");

	//G_setLovCol(gridSUB01,"TAX_COMP_CODE");
	//G_setLovCol(gridSUB01,"TAX_COMP_NAME");

	//G_setLovCol(gridSUB01,"PUBL_DT");
	//G_setLovCol(gridSUB01,"DEPT_NAME");
	//G_setLovCol(gridSUB01,"CUST_NAME");

	gridSUB01.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	gridSUB01.TabToss = false;


	gridSUB01.focus();
	//btnquery_onclick();
}

function OnLoadBefore(dataset)
{
	if(dataset == dsSUB01)
	{
		var vTaxCompCode = txtTAX_COMP_CODE.value;
		var vTaxCompName = txtTAX_COMPANY_NAME.value;
		var vCompCode = txtCOMP_CODE.value;
		var vCompName = txtCOMPANY_NAME.value;
		var vDeptCode = (txtDEPT_CODE.value=="")?"%":txtDEPT_CODE.value;
		var vDeptName = (txtDEPT_NAME.value=="")?"전체":txtDEPT_NAME.value;
		var vCustCode = (txtCUST_CODE.value=="")?"%":txtCUST_CODE.value;
		var vCustName = (txtCUST_NAME.value=="")?"전체":txtCUST_NAME.value;
		var vVatCode  = (txtVAT_CODE.value=="")?"%":txtVAT_CODE.value;
		var vVatName  = (txtVAT_NAME.value=="")?"전체":txtVAT_NAME.value;
		var vSaleBuyCls	= cboSALEBUY_CLS.value;
		var vRcptBillCls= cboRCPTBILL_CLS.value;
		var vSubtrCls	= cboSUBTR_CLS.value;
		var vSubtrClsExt= cboSUBTR_CLS_EXT.value;
		var vAccCode	= (txtACC_CODE.value=="")?"%":txtACC_CODE.value;
		var vAccName	= (txtACC_NAME.value=="")?"전체":txtACC_NAME.value;
		var vDT_F   = txtDT_F.value;
		var vDT_T   = txtDT_T.value;

		/*
		if( bLoading == 1 ) {
			bLoading = 0;
			vTaxCompCode = "0";
			vCompCode = "0";
		}
		*/

		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
										 + D_P2("TAX_COMP_CODE",	vTaxCompCode)
										 + D_P2("TAX_COMP_NAME",	vTaxCompName)
										 + D_P2("COMP_CODE",	vCompCode)
										 + D_P2("COMP_NAME",	vCompName)
										 + D_P2("DEPT_CODE",	vDeptCode)
										 + D_P2("DEPT_NSME",	vDeptName)
										 + D_P2("CUST_CODE",	vCustCode)
										 + D_P2("CUST_NAME",	vCustName)
										 + D_P2("VAT_CODE",		vVatCode)
										 + D_P2("VAT_NAME",		vVatName)
										 + D_P2("SALEBUY_CLS",	vSaleBuyCls)
										 + D_P2("RCPTBILL_CLS",	vRcptBillCls)
										 + D_P2("SUBTR_CLS",	vSubtrCls)
										 + D_P2("SUBTR_CLS_EXT",vSubtrClsExt)
										 + D_P2("ACC_CODE",	vAccCode)
										 + D_P2("ACC_NAME",	vAccName)
										 + D_P2("DT_F",	vDT_F)
										 + D_P2("DT_T",	vDT_T)
										 + D_P2("DATE_CLS",	cboDATE_CLS.value)
										 + D_P2("DIV_CODE",	txtDIV_CODE.value);
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

	var vTaxCompCode = txtTAX_COMP_CODE.value;
	var vTaxCompName = txtTAX_COMPANY_NAME.value;
	var vCompCode = txtCOMP_CODE.value;
	var vCompName = txtCOMPANY_NAME.value;
	var vDeptCode = (txtDEPT_CODE.value=="")?"%":txtDEPT_CODE.value;
	var vDeptName = (txtDEPT_NAME.value=="")?"전체":txtDEPT_NAME.value;
	var vCustCode = (txtCUST_CODE.value=="")?"%":txtCUST_CODE.value;
	var vCustName = (txtCUST_NAME.value=="")?"전체":txtCUST_NAME.value;
	var vVatCode  = (txtVAT_CODE.value=="")?"%":txtVAT_CODE.value;
	var vVatName  = (txtVAT_NAME.value=="")?"전체":txtVAT_NAME.value;
	var vSaleBuyCls	= cboSALEBUY_CLS.value;
	var vRcptBillCls= cboRCPTBILL_CLS.value;
	var vSubtrCls	= cboSUBTR_CLS.value;
	var vAccCode	= (txtACC_CODE.value=="")?"%":txtACC_CODE.value;
	var vAccName	= (txtACC_NAME.value=="")?"전체":txtACC_NAME.value;
	var vDT_F   = txtDT_F.value;
	var vDT_T   = txtDT_T.value;
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
	//strTemp += "ProjCode__" + strProjCode + "&&";
	//strTemp += "ConsultSeq__" + strConsultSeq;

	strTemp += "pTAX_COMP_CODE__" + vTaxCompCode;
	strTemp += "&&pTAX_COMP_NAME__" + vTaxCompName;
	strTemp += "&&pCOMP_CODE__" + vCompCode;
	strTemp += "&&pCOMP_NAME__" + vCompName;
	strTemp += "&&pDEPT_CODE__" + vDeptCode;
	strTemp += "&&pDEPT_NAME__" + vDeptName;
	strTemp += "&&pCUST_CODE__" + vCustCode;
	strTemp += "&&pCUST_NAME__" + vCustName;
	strTemp += "&&pVAT_CODE__" + vVatCode;
	strTemp += "&&pVAT_NAME__" + vVatName;
	strTemp += "&&pTAX_YEAR__" + vTaxYear;
	strTemp += "&&pSALEBUY_CLS__" + vSaleBuyCls;
	strTemp += "&&pRCPTBILL_CLS__" + vRcptBillCls;
	strTemp += "&&pSUBTR_CLS__" + vSubtrCls;
	strTemp += "&&pACC_CODE__" + vAccCode;
	strTemp += "&&pACC_NAME__" + vAccName;
	strTemp  += "&&pDT_T__" + vDT_T.replace(/-/gi,"");
	strTemp += "&&pDT_F__" + vDT_F.replace(/-/gi,"");

	
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
	D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
}

// 삽입
function btninsert_onclick()
{
}

// 삭제
function btndelete_onclick()
{
}

// 저장
function btnsave_onclick()
{
}

// 취소
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 전체선택
function btnAllSelect_onClick()
{
	for(i=1;i<=dsMAIN.CountRow;i++)
	{
		dsMAIN.NameString(i,"CHK_CLS") = "T";
	}
}

// 전체선택취소
function btnAllSelCancle_onClick()
{
	for(i=1;i<=dsMAIN.CountRow;i++)
	{
		dsMAIN.NameString(i,"CHK_CLS") = "F";
	}
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

function OnDblClick(dataset, grid, row, colid) {
	if(dataset == dsSUB01)
	{
		if( grid.ColumnProp(colid,"Edit") == 'NONE' ) {
			if(dataset.NameString(row,"MAKE_COMP_CODE") == "")
			{
				C_msgOk("전표가 존재하지 않습니다.", "확인");
				return;
			}
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
function	txtCOMP_CODE_onChange()
{
	gridMAIN.focus();
	btnquery_onclick();
}

function txtTAX_COMP_CODE_onblur()
{
	if (C_isNull(txtTAX_COMP_CODE.value))
	{
		txtTAX_COMPANY_NAME.value = "";
		dsMAIN.ResetStatus();
		G_Load(dsMAIN);
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtTAX_COMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;

	if (txtTAX_COMPANY_NAME.value == lrRet.get("COMPANY_NAME")) return;
	
	txtTAX_COMP_CODE.value		= lrRet.get("COMP_CODE");
	txtTAX_COMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	dsMAIN.ResetStatus();
	G_Load(dsMAIN);
}

function btnTAX_COMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;

	txtTAX_COMP_CODE.value	= lrRet.get("COMP_CODE");
	txtTAX_COMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	dsMAIN.ResetStatus();
	G_Load(dsMAIN);
}

function	CheckCompCode()
{
	if (C_isNull(txtTAX_COMP_CODE.value))
	{
		C_msgOk("먼저 세무사업장을 선택하세요.", "확인");
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

	if (txtCOMPANY_NAME.value == lrRet.get("COMPANY_NAME")) return;
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	txtDIV_CODE.value = '';
	txtDIV_NAME.value = '';
	txtDEPT_CODE.value = '';
	txtDEPT_NAME.value = '';
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
	txtDIV_CODE.value = '';
	txtDIV_NAME.value = '';
	txtDEPT_CODE.value = '';
	txtDEPT_NAME.value = '';
}

//안분분류
function txtDIV_CODE_onblur()
{
	if (C_isNull(txtDIV_CODE.value))
	{
		txtDIV_CODE.value = '';
		txtDIV_NAME.value = '';
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtDIV_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_ACC_VAT_DIV_CODE_01", lrArgs,"T");

	if (lrRet == null) {
		//txtDIV_CODE.value = txtDIV_CODE_F.value;
		return;
	}
	
	if (txtDIV_NAME.value == lrRet.get("DIV_NAME")) return;
	
	txtDIV_CODE.value = lrRet.get("DIV_CODE");
	txtDIV_NAME.value = lrRet.get("DIV_NAME");
	txtDEPT_CODE.value = '';
	txtDEPT_NAME.value = '';
}

function btnDIV_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtDIV_CODE.value);

	lrRet = C_LOV("T_ACC_VAT_DIV_CODE_01", lrArgs,"T");

	if (lrRet == null) return;
	if (txtDIV_NAME.value == lrRet.get("DIV_NAME")) return;
	
	txtDIV_CODE.value = lrRet.get("DIV_CODE");
	txtDIV_NAME.value = lrRet.get("DIV_NAME");
	txtDEPT_CODE.value = '';
	txtDEPT_NAME.value = '';
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
	lrArgs.set("DIV_CODE", txtDIV_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE13", lrArgs,"T");

	if (lrRet == null) {
		//txtDEPT_CODE.value = txtDEPT_CODE_F.value;
		return;
	}
	
	if (txtDEPT_NAME.value == lrRet.get("DEPT_NAME")) return;
	
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
	lrArgs.set("DIV_CODE", txtDIV_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);

	if (C_isNull(txtDEPT_CODE.value))
	{
		lrRet = C_LOV("T_DEPT_CODE13", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_DEPT_CODE13", lrArgs,"T");
	}

	if (lrRet == null) return;
	if (txtDEPT_NAME.value == lrRet.get("DEPT_NAME")) return;
	
	txtDEPT_CODE.value = lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value = lrRet.get("DEPT_NAME");
}

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

	lrRet = C_AutoLov(dsLOV,"T_ACC_CODE10", lrArgs,"T");

	if (lrRet == null) return;

	txtACC_CODE.value = lrRet.get("ACC_CODE");
	txtACC_NAME.value = lrRet.get("ACC_NAME");
}

function btnACC_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_ACC_CODE10", lrArgs,"T");
	
	if (lrRet == null) return;

	txtACC_CODE.value = lrRet.get("ACC_CODE");
	txtACC_NAME.value = lrRet.get("ACC_NAME");
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