/**************************************************************************/
/* 1. 프 로 그 램 id : t_WCustCodeR.js(거래처코드)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 최언회 작성(2005-11-15)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "거래처코드");
	G_addDataSet(dsCUST_SEQ, null, null, null, "거래처순번");
	G_addDataSet(dsCUST_CODE, null, null, null, "거래처코드");
	
	G_addDataSet(dsCUST_PAYSTOP_SEQ, null, null, null, "거래처지불정지순번");
	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	gridMAIN.Focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("TRADE_CLS",cboTRADE_CLS.value)
											+ D_P2("CUST_NAME",txtCUST_NAME_S.value);
	}
	else if(dataset == dsCUST_SEQ)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","CUST_SEQ");
	}
	else if(dataset == dsCUST_CODE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","CUST_CODE")
											+ D_P2("CUST_NAME",txtCUST_CODE.value.replace(/-/gi,""));
	}
	
	else if(dataset == dsCUST_PAYSTOP_SEQ)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","CUST_PAYSTOP_SEQ");
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
	if(C_isNull(txtCUST_NAME_S.value))
	{
		C_msgOk("거래처명을 입력하세요");
		return false;	
	}
	D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
	if ((G_FocusDataset == dsMAIN) && (cboTRADE_CLS.value == "%"))
	{
		C_msgOk("거래처구분이 전체일때는 추가할수 없습니다. <br><br> 먼저 거래추구분을 선택하세요.", "확인");
		return;
	}
	
	D_defaultAdd();
	
	//if ((G_FocusDataset == dsCUST_ACCNO) && (dsCUST_ACCNO.NameString(dsCUST_ACCNO.Rowposition,"SEQ") == "0"))
	//{
		//dsCUST_ACCNO.NameString(dsCUST_ACCNO.Rowposition,"SEQ") = parseInt(dsCUST_ACCNO.NameMax("SEQ",0,0))+1;
	//}
}

// 삽입
function btninsert_onclick()
{
	if ((G_FocusDataset == dsMAIN) && (cboTRADE_CLS.value == "%"))
	{
		C_msgOk("거래처구분이 전체일때는 삽입할수 없습니다. <br><br> 먼저 거래추구분을 선택하세요.", "확인");
		return;
	}
	
	D_defaultInsert();

	//if ((G_FocusDataset == dsCUST_ACCNO) && (dsCUST_ACCNO.NameString(dsCUST_ACCNO.Rowposition,"SEQ") == "0"))
	//{
		//dsCUST_ACCNO.NameString(dsCUST_ACCNO.Rowposition,"SEQ") = parseInt(dsCUST_ACCNO.NameMax("SEQ",0,0))+1;
	//}
}

// 삭제
function btndelete_onclick()
{
	D_defaultDelete();
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
//인쇄
function btnquery_prt_onclick()
{
	// 프로그래머 유효성검사 추가
				
	// 공통 Check

       var  vTRADE_CLS = cboTRADE_CLS.value;

   	var reportFile ="";
	
   	reportFile ="r_t_000002";  

	frmList.EXPORT_TAG.value =cboExportTag.value;
	frmList.RUN_TAG.value = cboRunTag.value;
	frmList.REQUEST_NAME.value = txtRequestName.value;
	frmList.REPORT_NO.value = '--';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	var strTemp = "";
	
	if(vTRADE_CLS=='%')
	{
		vTRADE_CLS_NAME ='전체';	
	}
	else if(vTRADE_CLS=='1')
	{
		vTRADE_CLS_NAME ='사업자';	
	}
	else if(vTRADE_CLS=='2')
	{
		vTRADE_CLS_NAME ='개인';	
	}
	else if(vTRADE_CLS=='3')
	{
		vTRADE_CLS_NAME ='은행지점';	
	}
	else if(vTRADE_CLS=='4')
	{
		vTRADE_CLS_NAME ='사원번호';	
	}
	else if(vTRADE_CLS=='5')
	{
		vTRADE_CLS_NAME ='부서';	
	}
	else if(vTRADE_CLS=='9')
	{
		vTRADE_CLS_NAME ='기타';	
	}

	strTemp += "P_TRADE_CLS__" + vTRADE_CLS;
	strTemp += "&&P_TRADE_CLS_NAME__" + vTRADE_CLS_NAME;

	frmList.PARAMETERS.value = strTemp;
	
	//if (!S_Submit(document.all)) return;
	frmList.submit();

	S_ObjectAllFormat(document.all);
	strTemp ="";
}
// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "PAY_STOPSTR_DT")
	{
		dsPAY_STOP.NameString(dsPAY_STOP.RowPosition,"PAY_STOPSTR_DT") = asDate;
	}
	else if (asCalendarID == "PAY_STOPEND_DT")
	{
		dsPAY_STOP.NameString(dsPAY_STOP.RowPosition,"PAY_STOPEND_DT") = asDate;
	}
	else if (asCalendarID == "CLOSE_DT")
	{
		//dsCUST_ACCNO.NameString(dsCUST_ACCNO.RowPosition,"CLOSE_DT") = asDate;
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
	if (dataset == dsMAIN)
	{
		txtTRADE_CLS.value = cboTRADE_CLS.value;
		G_Load(dsCUST_SEQ, null);
		dsMAIN.NameValue(dsMAIN.RowPosition, "CUST_SEQ") = dsCUST_SEQ.NameValue(dsCUST_SEQ.RowPosition, "CUST_SEQ");
		dsMAIN.NameValue(dsMAIN.RowPosition, "GROUP_COMP_CLS") = "F";
		dsMAIN.NameValue(dsMAIN.RowPosition, "USE_CLS") = "T";
	}
	//else if (dataset == dsCUST_ACCNO)
	//{
		//dsCUST_ACCNO.NameValue(row, "USE_TG") = "T";
	//}
	else if (dataset == dsPAY_STOP)
	{
		G_Load(dsCUST_PAYSTOP_SEQ, null);
		dsPAY_STOP.NameValue(row, "PAY_STOP_SEQ") = "T";
		dsPAY_STOP.NameValue(row, "PAY_STOP_CLS") = "1";
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

function OnExit(dataset, grid, row, colid, olddata)
{
	if (dataset == dsPAY_STOP)
	{
		var COL_DATA = dsPAY_STOP.NameString(row,colid);
		
		if(colid == "PAY_STOPSTR_DT")
		{
			if (C_isNull(dsPAY_STOP.NameString(row,"PAY_STOPEND_DT")))
			{
				if(dsPAY_STOP.NameString(row,"PAY_STOPSTR_DT").replace(/-/gi,"") > dsPAY_STOP.NameString(row,"PAY_STOPEND_DT").replace(/-/gi,""))
				{
					C_msgOk("시작일이 종료일보다 큽니다.", "확인");
					dsPAY_STOP.NameString(row,colid) = olddata;
					return;
				}
			}
			
			D_defaultDateProcessInGrid(dataset, row, colid, olddata, COL_DATA);
		}
		else if(colid == "PAY_STOPEND_DT")
		{
			if (C_isNull(dsPAY_STOP.NameString(row,"PAY_STOPEND_DT")))
			{
				if(dsPAY_STOP.NameString(row,"PAY_STOPSTR_DT").replace(/-/gi,"") > dsPAY_STOP.NameString(row,"PAY_STOPEND_DT").replace(/-/gi,""))
				{
					C_msgOk("시작일이 종료일보다 큽니다.", "확인");
					dsPAY_STOP.NameString(row,colid) = olddata;
					return;
				}
			}
			
			D_defaultDateProcessInGrid(dataset, row, colid, olddata, COL_DATA);
		}
		else if(colid=='DEPT_NAME')
		{
			if(C_isNull(dsPAY_STOP.NameString(row,"DEPT_NAME")))
			{
				//dsCUST_ACCNO.NameString(row,"DEPT_CODE") = "";
				return;
			}
			
			var lrArgs = new C_Dictionary();
			lrArgs.set("SEARCH_CONDITION", dsPAY_STOP.NameString(row,"DEPT_NAME"));

			var		lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE1",lrArgs, "T");

			if (lrRet != null)
			{
				dsPAY_STOP.NameString(row,"DEPT_CODE")	= lrRet.get("DEPT_CODE");
				dsPAY_STOP.NameString(row,"DEPT_NAME")	= lrRet.get("DEPT_NAME");
			}
		}
	}
	/*
	if (dataset == dsCUST_ACCNO)
	{
		var COL_DATA = dataset.NameString(row,colid);
		if(colid=='BANK_MAIN_NAME')
		{
			if(C_isNull(dsCUST_ACCNO.NameString(row,"BANK_MAIN_NAME")))
			{
				dsCUST_ACCNO.NameString(row,"BANK_MAIN_CODE") = "";
				return;
			}
			
			var lrArgs = new C_Dictionary();
			lrArgs.set("SEARCH_CONDITION", dsCUST_ACCNO.NameString(row,"BANK_MAIN_NAME"));

			var		lrRet = C_AutoLov(dsLOV,"T_BANK_MAIN",lrArgs, "T");

			if (lrRet != null)
			{
				dsCUST_ACCNO.NameString(row,"BANK_MAIN_CODE")	= lrRet.get("BANK_MAIN_CODE");
				dsCUST_ACCNO.NameString(row,"BANK_MAIN_NAME")	= lrRet.get("BANK_MAIN_NAME");
			}
		}
		else if(colid == "CLOSE_DT")
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata, COL_DATA);
		}
		else if(colid == "OUT_ACCNO")
		{
			var COL_DATA = dataset.NameString(row,colid);
			if(C_isNull(COL_DATA))
			{
				return;
			}
			var lrArgs = new C_Dictionary();
			
			lrArgs.set("COMP_CODE", "");
			lrArgs.set("BANK_CODE", "");
			lrArgs.set("ACCT_CLS", "");
			lrArgs.set("SEARCH_CONDITION", "");
			
			var lrRet = null;
	
			lrRet = C_AutoLov(dsLOV,"T_ACCNO_CODE1", lrArgs, "T");
	
			if (lrRet == null)
			{
				dataset.NameString(row,"OUT_ACCNO")	= olddata;
				return;
			}
			
			dataset.NameString(row,"OUT_ACCNO")	= lrRet.get("ACCNO");
		}
	}
	*/
}

function OnPopup(dataset, grid, row, colid, data)
{
	/*
	if(dataset == dsCUST_ACCNO)
	{
		if(colid == "BANK_MAIN_NAME")
		{
			var lrArgs = new C_Dictionary();
			
			lrArgs.set("SEARCH_CONDITION", "");
			
			var lrRet = null;
	
			lrRet = C_LOV("T_BANK_MAIN", lrArgs, "F");
	
			if (lrRet == null) return;
			
			dsCUST_ACCNO.NameString(row,"BANK_MAIN_CODE")	= lrRet.get("BANK_MAIN_CODE");
			dsCUST_ACCNO.NameString(row,"BANK_MAIN_NAME")	= lrRet.get("BANK_MAIN_NAME");
		}
		if(colid == "CLOSE_DT")
		{
			C_Calendar("CLOSE_DT", "D", dsCUST_ACCNO.NameString(dsCUST_ACCNO.RowPosition,"CLOSE_DT"));
		}
		else if(colid == "OUT_ACCNO")
		{
			var lrArgs = new C_Dictionary();
			
			lrArgs.set("COMP_CODE", "");
			lrArgs.set("BANK_CODE", "");
			lrArgs.set("ACCT_CLS", "");
			lrArgs.set("SEARCH_CONDITION", "");
			
			var lrRet = null;
	
			lrRet = C_LOV("T_ACCNO_CODE1", lrArgs, "F");
	
			if (lrRet == null) return;
			
			dataset.NameString(row,"OUT_ACCNO")	= lrRet.get("ACCNO");
		}
	}
	*/
	if(dataset == dsPAY_STOP)
	{
		if(colid == "PAY_STOPSTR_DT")
		{
			C_Calendar("PAY_STOPSTR_DT", "D", dsPAY_STOP.NameString(dsPAY_STOP.RowPosition,"PAY_STOPSTR_DT"));
		}
		else if(colid == "PAY_STOPEND_DT")
		{
			C_Calendar("PAY_STOPEND_DT", "D", dsPAY_STOP.NameString(dsPAY_STOP.RowPosition,"PAY_STOPEND_DT"));
		}
		else if(colid == "DEPT_NAME")
		{
			var lrArgs = new C_Dictionary();
			
			lrArgs.set("SEARCH_CONDITION", "");
			
			var lrRet = null;
	
			lrRet = C_LOV("T_DEPT_CODE1", lrArgs, "F");
	
			if (lrRet == null) return;
			
			dsPAY_STOP.NameString(row,"DEPT_CODE")	= lrRet.get("DEPT_CODE");
			dsPAY_STOP.NameString(row,"DEPT_NAME")	= lrRet.get("DEPT_NAME");
		}
	}
}

// 이벤트관련-------------------------------------------------------------------//
function txtCUST_CODE_onBlur()
{
	if(C_isNull(txtCUST_CODE.value))
	{
		txtCUST_NAME.value = "";
		return;
	}
	
	if (txtCUST_CODE_F.value == txtCUST_CODE.value) return;
	
	G_Load(dsCUST_CODE, null)
	
	if (dsCUST_CODE.CountRow != 0)
	{
		if(C_msgYesNo("입력하신 거래처코드와 같은 거래처코드가 이미 존재합니다.<br><br>그래도 등록하시겠습니까?","확인") == "N")
		{
			return;
		}
	}
	
	var vCUST_CODE = txtCUST_CODE.value.replace(/-/g, "");
	
	if (txtTRADE_CLS.value == '1')
	{
		if (!C_isValidCustNo(txtCUST_CODE.value))
		{
			C_msgOk(ERR_MSG);
		}
		txtCUST_CODE.value = vCUST_CODE.substr(0, 3) + "-" + vCUST_CODE.substr(3, 2) + "-" + vCUST_CODE.substr(5, 5);
	}
	else if (txtTRADE_CLS.value == '2')
	{
		if (!C_isValidRegNo(txtCUST_CODE.value))
		{
			C_msgOk(ERR_MSG);
		}
		txtCUST_CODE.value = vCUST_CODE.substr(0, 6) + "-" + vCUST_CODE.substr(6, 7);
	}
	
	if (C_isNull(txtREPRESENT_CUST_CODE.value))
	{
		txtREPRESENT_CUST_SEQ.value		= txtCUST_SEQ.value;
		txtREPRESENT_CUST_CODE.value	= txtCUST_CODE.value;
		txtREPRESENT_CUST_NAME.value	= txtCUST_NAME.value;
	}
}

function txtCUST_NAME_onBlur()
{
	if (txtCUST_NAME_F.value == txtCUST_NAME.value) return;
	
	if (C_isNull(txtREPRESENT_CUST_NAME.value))
	{
		txtREPRESENT_CUST_SEQ.value		= txtCUST_SEQ.value;
		txtREPRESENT_CUST_CODE.value	= txtCUST_CODE.value;
		txtREPRESENT_CUST_NAME.value	= txtCUST_NAME.value;
	}
}

function txtZIPCODE_onBlur()
{
	if(C_isNull(txtZIPCODE.value))
	{
		txtADDR1.value = "";
		return;
	}
	
	if (txtZIPCODE_F.value == txtZIPCODE.value) return;
	
	var lrArgs = new C_Dictionary();
	lrArgs.set("SEARCH_CONDITION", txtZIPCODE.value);

	var		lrRet = C_AutoLov(dsLOV,"T_ZIP_CODE",lrArgs, "T");

	if (lrRet == null) return;

	txtZIPCODE.value	= lrRet.get("MASKED_ZIPCODE");
	txtADDR1.value		= lrRet.get("AREA_NAME");
	txtADDR2.focus();
}

function btnZIPCODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtZIPCODE.value);

	lrRet = C_LOV("T_ZIP_CODE", lrArgs,"F");
	
	if (lrRet == null) return;

	txtZIPCODE.value	= lrRet.get("MASKED_ZIPCODE");
	txtADDR1.value		= lrRet.get("AREA_NAME");
	txtADDR2.focus();
}

function btnREPRESENT_CUST_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtREPRESENT_CUST_CODE.value);

	lrRet = C_LOV("T_CUST_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtREPRESENT_CUST_SEQ.value		= lrRet.get("CUST_SEQ");
	txtREPRESENT_CUST_CODE.value	= lrRet.get("CUST_CODE");
	txtREPRESENT_CUST_NAME.value	= lrRet.get("CUST_NAME");
	cboTRADE_CLS.focus();
}
//출력
function btnPreView_onClick()
{
	
	btnquery_prt_onclick();
}