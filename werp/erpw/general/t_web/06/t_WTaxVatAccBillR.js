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

	G_setReadOnlyCol(gridSUB01, "MAKE_SLIPNOLINE");
	G_setReadOnlyCol(gridSUB01, "RCPTBILL_CLS");
	G_setReadOnlyCol(gridSUB01, "SALEBUY_CLS");
	G_setReadOnlyCol(gridSUB01, "SUBTR_CLS");
	G_setReadOnlyCol(gridSUB01, "COMMBUY_CLS");
	G_setReadOnlyCol(gridSUB01, "MAKE_DT");


	G_setLovCol(gridMAIN,"WORK_DATE");
	G_setLovCol(gridMAIN,"BASE_DT_F");
	G_setLovCol(gridMAIN,"BASE_DT_T");
	G_setLovCol(gridMAIN,"MISSING_PROCESS_DT_F");

	G_setLovCol(gridSUB01,"TAX_COMP_CODE");
	G_setLovCol(gridSUB01,"TAX_COMP_NAME");
	G_setLovCol(gridSUB01,"ACC_CODE");
	G_setLovCol(gridSUB01,"ACC_NAME");

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


// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
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
		dsMAIN.NameString(dsMAIN.RowPosition, "TAX_YEAR") = cboTAX_YEAR.value;
		dsMAIN.NameString(dsMAIN.RowPosition, "WORK_DATE") = vDate;
		dsMAIN.NameString(dsMAIN.RowPosition, "APPLY_TAG") = "T";
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
	if(dataset == dsMAIN)
	{
		if( dsMAIN.NameString(row,"TAX_YEAR")!="" && dsMAIN.NameString(row,"TAX_GI")!="" && dsMAIN.NameString(row,"TAX_CONF")!="" ) {
			if( dsMAIN.NameString(row,"TAX_GI")=="1" ) {
				if( dsMAIN.NameString(row,"TAX_CONF")=="1" ) {
					dsMAIN.NameString(row,"BASE_DT_F")=dsMAIN.NameString(row,"TAX_YEAR")+"-01-01";
					dsMAIN.NameString(row,"BASE_DT_T")=dsMAIN.NameString(row,"TAX_YEAR")+"-03-31";
					dsMAIN.NameString(row,"MISSING_PROCESS_DT_F")=dsMAIN.NameString(row,"TAX_YEAR")+"-01-01";
				} else {
					dsMAIN.NameString(row,"BASE_DT_F")=dsMAIN.NameString(row,"TAX_YEAR")+"-04-01";
					dsMAIN.NameString(row,"BASE_DT_T")=dsMAIN.NameString(row,"TAX_YEAR")+"-06-30";
					dsMAIN.NameString(row,"MISSING_PROCESS_DT_F")=dsMAIN.NameString(row,"TAX_YEAR")+"-04-01";
				}
			} else {
				if( dsMAIN.NameString(row,"TAX_CONF")=="1" ) {
					dsMAIN.NameString(row,"BASE_DT_F")=dsMAIN.NameString(row,"TAX_YEAR")+"-07-01";
					dsMAIN.NameString(row,"BASE_DT_T")=dsMAIN.NameString(row,"TAX_YEAR")+"-09-30";
					dsMAIN.NameString(row,"MISSING_PROCESS_DT_F")=dsMAIN.NameString(row,"TAX_YEAR")+"-07-01";
				} else {
					dsMAIN.NameString(row,"BASE_DT_F")=dsMAIN.NameString(row,"TAX_YEAR")+"-10-01";
					dsMAIN.NameString(row,"BASE_DT_T")=dsMAIN.NameString(row,"TAX_YEAR")+"-12-31";
					dsMAIN.NameString(row,"MISSING_PROCESS_DT_F")=dsMAIN.NameString(row,"TAX_YEAR")+"-10-01";
				}
			}
		} else {
		}
	}
	else if(dataset == dsSUB01)
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
			var		lsNewData = dataset.NameString(row,colid);
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
		
			lrRet = C_AutoLov(dsLOV,"T_CUST_CODE1", lrArgs,"T");
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

function btnBatchInput_onClick()
{
	if(dsMAIN.CountRow==0) {
		C_msgOk("세무신고기수를 먼저 선택하세요.", "확인");
		return;
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

function btnBatchDelete_onClick()
{
	if(dsMAIN.CountRow==0) {
		C_msgOk("세무신고기수를 먼저 선택하세요.", "확인");
		return;
	}

	if(dsSUB01.CountRow!=0) {
		var	vRet = C_msgYesNo("현재신고기수에 부가세자료가 존재합니다. 계속진행하면 현 데이터를 모두 삭제합니다.<br>계속 진행하시겠습니까?", "경고");
		if (vRet != "Y") return;
	}
	
	var vTmp = "COMP_CODE:STRING(30),WORK_NO:DECIMAL";
	dsBATCH01.ClearAll();
	dsBATCH01.SetDataHeader(vTmp);
	dsBATCH01.AddRow();
	dsBATCH01.NameString(1,"COMP_CODE") = dsMAIN.NameString(dsMAIN.RowPosition, "COMP_CODE");
	dsBATCH01.NameString(1,"WORK_NO") = dsMAIN.NameString(dsMAIN.RowPosition, "WORK_NO");

	transBATCH01.Parameters = "ACT=BATCH02";
	G_saveDataMsg(dsBATCH01);

	G_Load(dsSUB01, null);
}

function btnNotBatchInput_onClick()
{
	if(dsMAIN.CountRow==0) {
		C_msgOk("세무신고기수를 먼저 선택하세요.", "확인");
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("BASE_DT_F0", dsMAIN.NameString(dsMAIN.RowPosition, "BASE_DT_F"));
	lrArgs.set("COMP_CODE1", dsMAIN.NameString(dsMAIN.RowPosition, "COMP_CODE"));
	lrArgs.set("WORK_NO", dsMAIN.NameString(dsMAIN.RowPosition, "WORK_NO"));
	lrArgs.set("COMP_CODE2", dsMAIN.NameString(dsMAIN.RowPosition, "COMP_CODE"));
	lrArgs.set("MISSING_PROCESS_DT_F", dsMAIN.NameString(dsMAIN.RowPosition, "MISSING_PROCESS_DT_F"));
	lrArgs.set("BASE_DT_F1", dsMAIN.NameString(dsMAIN.RowPosition, "BASE_DT_F"));
	lrArgs.set("BASE_DT_F2", dsMAIN.NameString(dsMAIN.RowPosition, "BASE_DT_F"));
	lrArgs.set("BASE_DT_T", dsMAIN.NameString(dsMAIN.RowPosition, "BASE_DT_T"));
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV_NEW("T_ACC_TAX_BILL_MEDIA_01", null, lrArgs, "T", "T");
	
	if (lrRet == null) return;

	var idx = 0;
	for (idx = 0; idx < lrRet.length; idx++)
	{
		lrArgs = lrRet[idx];
		//D_defaultAdd();
		if(!G_addRow(dsSUB01)) return;

		G_Load(dsSEQ, null);
		dsSUB01.NameString(dsSUB01.RowPosition, "SEQ") = dsSEQ.NameString(1, "SEQ");
		dsSUB01.NameString(dsSUB01.RowPosition, "UDT_TAG") = "O";

		//dsSUB01.NameString(dsSUB01.RowPosition, "COMP_CODE")	   = lrArgs.get("COMP_CODE");
		//dsSUB01.NameString(dsSUB01.RowPosition, "WORK_NO")		   = lrArgs.get("WORK_NO");
		//dsSUB01.NameString(dsSUB01.RowPosition, "SEQ")			   = lrArgs.get("SEQ");
		dsSUB01.NameString(dsSUB01.RowPosition, "TAX_COMP_CODE")   = lrArgs.get("TAX_COMP_CODE");
		dsSUB01.NameString(dsSUB01.RowPosition, "TAX_COMP_NAME")   = lrArgs.get("TAX_COMP_NAME");
		dsSUB01.NameString(dsSUB01.RowPosition, "RCPTBILL_CLS")	   = lrArgs.get("RCPTBILL_CLS");
		dsSUB01.NameString(dsSUB01.RowPosition, "SALEBUY_CLS")	   = lrArgs.get("SALEBUY_CLS");
		dsSUB01.NameString(dsSUB01.RowPosition, "SUBTR_CLS")	   = lrArgs.get("SUBTR_CLS");
		dsSUB01.NameString(dsSUB01.RowPosition, "PUBL_DT")		   = lrArgs.get("PUBL_DT");
		dsSUB01.NameString(dsSUB01.RowPosition, "MAKE_DT")		   = lrArgs.get("MAKE_DT");
		dsSUB01.NameString(dsSUB01.RowPosition, "VAT_CODE")		   = lrArgs.get("VAT_CODE");
		dsSUB01.NameString(dsSUB01.RowPosition, "BOOK_NO")		   = lrArgs.get("BOOK_NO");
		dsSUB01.NameString(dsSUB01.RowPosition, "BOOK_SEQ")		   = lrArgs.get("BOOK_SEQ");
		dsSUB01.NameString(dsSUB01.RowPosition, "DEPT_CODE")	   = lrArgs.get("DEPT_CODE");
		dsSUB01.NameString(dsSUB01.RowPosition, "DEPT_NAME")	   = lrArgs.get( "DEPT_NAME");
		dsSUB01.NameString(dsSUB01.RowPosition, "CUST_SEQ")		   = lrArgs.get("CUST_SEQ");
		dsSUB01.NameString(dsSUB01.RowPosition, "CUST_CODE")	   = lrArgs.get("CUST_CODE");
		dsSUB01.NameString(dsSUB01.RowPosition, "CUST_NAME")	   = lrArgs.get("CUST_NAME");
		dsSUB01.NameString(dsSUB01.RowPosition, "SUPAMT")		   = lrArgs.get("SUPAMT");
		dsSUB01.NameString(dsSUB01.RowPosition, "VATAMT")		   = lrArgs.get("VATAMT");
		dsSUB01.NameString(dsSUB01.RowPosition, "ANNULMENT_CLS")   = lrArgs.get( "ANNULMENT_CLS");
		dsSUB01.NameString(dsSUB01.RowPosition, "ANNULMENT_DT")	   = lrArgs.get( "ANNULMENT_DT");
		dsSUB01.NameString(dsSUB01.RowPosition, "OUT_CNT")		   = lrArgs.get("OUT_CNT");
		dsSUB01.NameString(dsSUB01.RowPosition, "MISSING_TAG")	   = lrArgs.get("MISSING_TAG");
		dsSUB01.NameString(dsSUB01.RowPosition, "REMARK")		   = lrArgs.get("REMARK");
		dsSUB01.NameString(dsSUB01.RowPosition, "UDT_TAG")		   = lrArgs.get("UDT_TAG");
		dsSUB01.NameString(dsSUB01.RowPosition, "CARD_CASH_NO")	   = lrArgs.get("CARD_CASH_NO");
		dsSUB01.NameString(dsSUB01.RowPosition, "SLIP_ID")		   = lrArgs.get("SLIP_ID");
		dsSUB01.NameString(dsSUB01.RowPosition, "SLIP_IDSEQ")	   = lrArgs.get("SLIP_IDSEQ");
		dsSUB01.NameString(dsSUB01.RowPosition, "MAKE_SLIPNOLINE") = lrArgs.get("MAKE_SLIPNOLINE");
		dsSUB01.NameString(dsSUB01.RowPosition, "ACC_CODE")		   = lrArgs.get("ACC_CODE");
		dsSUB01.NameString(dsSUB01.RowPosition, "ACC_NAME")		   = lrArgs.get("ACC_NAME");
	}
}