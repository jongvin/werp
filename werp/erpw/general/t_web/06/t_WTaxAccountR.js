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

	G_addDataSet(dsMAIN,  null,   null, sSelectPageName+D_P1("ACT","MAIN"), "세무신고기수");
	G_addDataSet(dsSUB01, trans,  gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "부가세자료");

	G_addDataSet(dsSEQ,  null,   null, null, "SEQ");

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	
	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"COMP_CODE","COMP_CODE");
	G_addRelCol(dsSUB01,"WORK_NO","WORK_NO");

	
	//G_setLovCol(gridSUB01,"ACC_CODE");

	G_setReadOnlyCol(gridSUB01, "MAKE_SLIPNOLINE");
	G_setReadOnlyCol(gridSUB01, "RCPTBILL_CLS");
	G_setReadOnlyCol(gridSUB01, "SALEBUY_CLS");
	G_setReadOnlyCol(gridSUB01, "SUBTR_CLS");
	G_setReadOnlyCol(gridSUB01, "COMMBUY_CLS");
	G_setReadOnlyCol(gridSUB01, "MAKE_DT");


	G_setLovCol(gridSUB01,"TAX_COMP_CODE");
	G_setLovCol(gridSUB01,"TAX_COMP_NAME");
	G_setLovCol(gridSUB01,"ACC_CODE");
	G_setLovCol(gridSUB01,"ACC_NAME");

	G_setLovCol(gridSUB01,"PUBL_DT");
	G_setLovCol(gridSUB01,"DEPT_NAME");
	G_setLovCol(gridSUB01,"CUST_NAME");

	gridSUB01.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	gridSUB01.TabToss = false;

	cboTAX_YEAR.value = vDate.substring(0,4);
	G_Load(dsMAIN);
	gridSUB01.focus();
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
		var vCompCode = txtCOMP_CODE.value;
		var vCompName = txtCOMPANY_NAME.value;
		var vDeptCode = (txtDEPT_CODE.value=="")?"%":txtDEPT_CODE.value;
		var vDeptName = (txtDEPT_NAME.value=="")?"전체":txtDEPT_NAME.value;
		var vCustCode = (txtCUST_CODE.value=="")?"%":txtCUST_CODE.value;
		var vCustName = (txtCUST_NAME.value=="")?"전체":txtCUST_NAME.value;
		var vVatCode  = (txtVAT_CODE.value=="")?"%":txtVAT_CODE.value;
		var vVatName  = (txtVAT_NAME.value=="")?"전체":txtVAT_NAME.value;
		var vTaxYear  = cboTAX_YEAR.value;
		var vSaleBuyCls	= cboSALEBUY_CLS.value;
		var vRcptBillCls= cboRCPTBILL_CLS.value;
		var vSubtrCls	= cboSUBTR_CLS.value;
		var vAccCode	= (txtACC_CODE.value=="")?"%":txtACC_CODE.value;
		var vAccName	= (txtACC_NAME.value=="")?"전체":txtACC_NAME.value;
		var vDT_F   = txtDT_F.value;
		var vDT_T   = txtDT_T.value;

		if( bLoading == 1 ) {
			bLoading = 0;
			vCompCode = "0";
		}

		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
										 + D_P2("COMP_CODE",	vCompCode)
										 + D_P2("WORK_NO",dsMAIN.NameString(dsMAIN.RowPosition, "WORK_NO"))
										 + D_P2("COMP_NAME",	vCompName)
										 + D_P2("DEPT_CODE",	vDeptCode)
										 + D_P2("DEPT_NSME",	vDeptName)
										 + D_P2("CUST_CODE",	vCustCode)
										 + D_P2("CUST_NAME",	vCustName)
										 + D_P2("VAT_CODE",		vVatCode)
										 + D_P2("VAT_NAME",		vVatName)
										 + D_P2("TAX_YEAR",		vTaxYear)
										 + D_P2("SALEBUY_CLS",	vSaleBuyCls)
										 + D_P2("RCPTBILL_CLS",	vRcptBillCls)
										 + D_P2("SUBTR_CLS",	vSubtrCls)
										 + D_P2("ACC_CODE",	vAccCode)
										 + D_P2("ACC_NAME",	vAccName)
										 + D_P2("DT_F",	vDT_F)
										 + D_P2("DT_T",	vDT_T)
										 + D_P2("DATE_CLS",	cboDATE_CLS.value);
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

// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//

// 조회
function btnquery_onclick()
{
	dsSUB01.ResetStatus();
	D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
	if(G_FocusDataset==dsMAIN) {
		if(!CheckCompCode()) return;
		if(!G_addRow(dsMAIN)) return;
		G_Load(dsWORK_NO, null);
		dsMAIN.NameString(dsMAIN.RowPosition, "COMP_CODE") = txtCOMP_CODE.value;
		dsMAIN.NameString(dsMAIN.RowPosition, "WORK_NO") = dsWORK_NO.NameString(1, "WORK_NO");
		dsMAIN.NameString(dsMAIN.RowPosition, "USE_TAG") = "T";
	} else if(G_FocusDataset==dsSUB01) {
		if(dsMAIN.CountRow==0) {
			C_msgOk("세무신고기수를 먼저 선택하세요.", "확인");
			return;
		}
		if(!G_addRow(dsSUB01)) return;
		G_Load(dsSEQ, null);
		dsSUB01.NameString(dsSUB01.RowPosition, "SEQ") = dsSEQ.NameString(1, "SEQ");
		dsSUB01.NameString(dsSUB01.RowPosition, "UDT_TAG") = "I";
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
	if(G_FocusDataset==dsMAIN) {
		D_defaultDelete();
	} else if(G_FocusDataset==dsSUB01) {
		//dsSUB01.DeleteMarked();
		//G_MultiDeleteRow(dsSUB01);
		var curRowPosition = 0;
		var arSelectRow = new Array();
		
		for (i=1;i<=G_FocusDataset.CountRow;i++) {
			if( G_FocusDataset.RowMark(i) == 1 ) {
				if(curRowPosition==0) curRowPosition = i;
				arSelectRow.push(i);
				G_FocusDataset.RowMark(i) = 0;
			}
		}

		G_FocusDataset.UndoMarked();

		for(i=(arSelectRow.length-1);i>=0;i--){
			if(G_FocusDataset.NameString(arSelectRow[i], "UDT_TAG") == "I")
				G_deleteRow(G_FocusDataset, arSelectRow[i], true);
			else
				G_FocusDataset.NameString(arSelectRow[i], "UDT_TAG") = "D";
		}
	}
}

// 삭제-->수정
function btndelete_to_update_onclick()
{
	if(G_FocusDataset==dsMAIN) {
		D_defaultDelete();
	} else if(G_FocusDataset==dsSUB01) {
		//dsSUB01.DeleteMarked();
		//G_MultiDeleteRow(dsSUB01);
		var curRowPosition = 0;
		var arSelectRow = new Array();
		
		for (i=1;i<=G_FocusDataset.CountRow;i++) {
			if( G_FocusDataset.RowMark(i) == 1 ) {
				if(curRowPosition==0) curRowPosition = i;
				arSelectRow.push(i);
				G_FocusDataset.RowMark(i) = 0;
			}
		}

		G_FocusDataset.UndoMarked();

		for(i=(arSelectRow.length-1);i>=0;i--){
			if(G_FocusDataset.NameString(arSelectRow[i], "UDT_TAG") == "D")
				G_FocusDataset.NameString(arSelectRow[i], "UDT_TAG") = "U";
		}
	}
}


// 저장
function btnsave_onclick()
{
	trans.Parameters = "";
	D_defaultSave(dsSUB01);
}

// 취소
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
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

}

function OnRowPosChanged(dataset, row, colid)
{
	if(dataset == dsMAIN)
	{
		if( dsMAIN.NameString(row,"TAX_YEAR")!="" && dsMAIN.NameString(row,"TAX_GI")!="" && dsMAIN.NameString(row,"TAX_CONF")!="" ) {
			if( dsMAIN.NameString(row,"TAX_GI")=="1" ) {
				if( dsMAIN.NameString(row,"TAX_CONF")=="1" ) {
					txtDT_F.value = cboTAX_YEAR.value+"-01-01";
					txtDT_T.value = cboTAX_YEAR.value+"-03-31";
				} else {
					txtDT_F.value = cboTAX_YEAR.value+"-04-01";
					txtDT_T.value = cboTAX_YEAR.value+"-06-30";
				}
			} else {
				if( dsMAIN.NameString(row,"TAX_CONF")=="1" ) {
					txtDT_F.value = cboTAX_YEAR.value+"-07-01";
					txtDT_T.value = cboTAX_YEAR.value+"-09-30";
				} else {
					txtDT_F.value = cboTAX_YEAR.value+"-10-01";
					txtDT_T.value = cboTAX_YEAR.value+"-12-31";
				}
			}
		} else {
		}
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
		if(colid == "ACC_CODE" || colid == "ACC_NAME")
		{
			var		liDataRow = row;
			var		lsNewData = dataset.NameString(row,colid);
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dsSUB01.NameString(row,"ACC_CODE")	= "";
				dsSUB01.NameString(row,"ACC_NAME")	= "";
				dsSUB01.NameString(row,"RCPTBILL_CLS")	= "";
				dsSUB01.NameString(row,"SALEBUY_CLS")	= "";
				dsSUB01.NameString(row,"SUBTR_CLS")	= "";
				dsSUB01.NameString(row,"COMMBUY_CLS")	= "F";
				return;
			}

			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", dsSUB01.NameString(row,"ACC_NAME"));
		
			if (C_isNull(dsSUB01.NameString(row,"ACC_NAME")))
			{
				lrRet = C_AutoLov(dsLOV,"T_ACC_CODE10", lrArgs,"F");
			}
			else
			{
				lrRet = C_AutoLov(dsLOV,"T_ACC_CODE10", lrArgs,"T");
			}
			
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsSUB01.NameString(liDataRow,"ACC_CODE")	= lrRet.get("ACC_CODE");
					dsSUB01.NameString(liDataRow,"ACC_NAME")	= lrRet.get("ACC_NAME");
					dsSUB01.NameString(liDataRow,"RCPTBILL_CLS")	= lrRet.get("RCPTBILL_CLS");
					dsSUB01.NameString(liDataRow,"SALEBUY_CLS")	= lrRet.get("SALEBUY_CLS");
					dsSUB01.NameString(liDataRow,"SUBTR_CLS")	= lrRet.get("SUBTR_CLS");
				}
			}
			else
			{
				dataset.NameString(liDataRow,colid) = olddata;
			}
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
		if(colid == "ACC_CODE" || colid == "ACC_NAME")
		{
			var	liDataRow = row;
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE10", lrArgs,"T");
			
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsSUB01.NameString(liDataRow,"ACC_CODE")	= lrRet.get("ACC_CODE");
					dsSUB01.NameString(liDataRow,"ACC_NAME")	= lrRet.get("ACC_NAME");
					dsSUB01.NameString(liDataRow,"RCPTBILL_CLS")= lrRet.get("RCPTBILL_CLS");
					dsSUB01.NameString(liDataRow,"SALEBUY_CLS")	= lrRet.get("SALEBUY_CLS");
					dsSUB01.NameString(liDataRow,"SUBTR_CLS")	= lrRet.get("SUBTR_CLS");
				}
			}
		}
		else if(colid == "TAX_COMP_CODE" || colid == "TAX_COMP_NAME")
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
		if(colid == "ACC_CODE" || colid == "ACC_NAME" || colid == "RCPTBILL_CLS" || colid == "SALEBUY_CLS" || colid == "SUBTR_CLS")
		{
			if(row>=2) {
				dsSUB01.NameString(row,"ACC_CODE")	= dsSUB01.NameString(row-1,"ACC_CODE");
				dsSUB01.NameString(row,"ACC_NAME")	= dsSUB01.NameString(row-1,"ACC_NAME");
				dsSUB01.NameString(row,"RCPTBILL_CLS")	= dsSUB01.NameString(row-1,"RCPTBILL_CLS");
				dsSUB01.NameString(row,"SALEBUY_CLS")	= dsSUB01.NameString(row-1,"SALEBUY_CLS");
				dsSUB01.NameString(row,"SUBTR_CLS")	= dsSUB01.NameString(row-1,"SUBTR_CLS");
			}
		}
		else if(colid == "TAX_COMP_CODE" || colid == "TAX_COMP_NAME")
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