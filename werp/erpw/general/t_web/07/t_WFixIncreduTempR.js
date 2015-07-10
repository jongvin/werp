/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFixIncreduR.js(고정자산증감사항등록)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 고정자산증감사항등록 
/* 4. 변  경  이  력 : 한재원 작성(2006-01-19)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, null, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "고정자산대장");
	G_addDataSet(dsMAIN2, trans, gridMAIN2, sSelectPageName+D_P1("ACT","MAIN2"), "고정자산증감현황");
	G_addDataSet(dsASSETCLS, null, null, sSelectPageName+D_P1("ACT","ASSET_CLS_CODE"), "자산종류");
	G_addDataSet(dsDEPREC_FINISH, null, null, sSelectPageName+D_P1("ACT","DEPREC_FINISH"), "상각완료구분");

	G_addDataSet(dsINCREDU_SEQ, null, null, sSelectPageName+D_P1("ACT","INCREDU_SEQ"), "증감순번");
	G_addDataSet(dsLOV, null, null,null, "LOV");
	G_addDataSet(dsCUR_DATE, null, null,sSelectPageName+D_P1("ACT","CUR_DATE"), "오늘날짜");
	
	G_addRel(dsMAIN, dsMAIN2);
	G_addRelCol(dsMAIN2, "FIX_ASSET_SEQ", "FIX_ASSET_SEQ");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	
	G_setReadOnlyCol(gridMAIN,"ASSET_MNG_NO");
	G_setReadOnlyCol(gridMAIN,"ASSET_NAME");
	G_setReadOnlyCol(gridMAIN,"DEPREC_FINISH");
	G_setReadOnlyCol(gridMAIN,"ASSET_SIZE");
	G_setReadOnlyCol(gridMAIN,"GET_DT");
	G_setReadOnlyCol(gridMAIN,"SRVLIFE");
	G_setReadOnlyCol(gridMAIN,"GET_COST_AMT");
	G_setReadOnlyCol(gridMAIN,"BASE_AMT");
	G_setReadOnlyCol(gridMAIN,"MNG_DEPT_NAME");
	G_setReadOnlyCol(gridMAIN,"DEPT_NAME");
	G_setReadOnlyCol(gridMAIN,"REMARK");
	
	gridMAIN.focus();
	G_Load(dsCUR_DATE, null);
	G_Load(dsASSETCLS, null);
	G_Load(dsDEPREC_FINISH, null);

}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									 + D_P2("COMP_CODE", txtCOMP_CODE.value)
									 + D_P2("ASSET_CLS_CODE",dsASSETCLS.NameString(dsASSETCLS.RowPosition,"ASSET_CLS_CODE"))
									 + D_P2("ITEM_CODE",txtITEM_CODE.value)
									 + D_P2("ITEM_NM_CODE", txtITEM_NM_CODE.value)
									 + D_P2("DEPREC_FINISH",dsDEPREC_FINISH.NameString(dsDEPREC_FINISH.RowPosition,"CODE_LIST_ID"));
	}
	else if(dataset == dsMAIN2)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN2")
									 + D_P2("FIX_ASSET_SEQ",dsMAIN.NameString(dsMAIN.RowPosition,"FIX_ASSET_SEQ"));
	}
	else if(dataset == dsASSETCLS)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","ASSET_CLS_CODE");									
	}
	else if(dataset == dsDEPREC_FINISH)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","DEPREC_FINISH");									
	}
	else if(dataset == dsINCREDU_SEQ)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","INCREDU_SEQ");								
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



//조회시 체크
function checkCondition()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("사업장을 선택하세요.", "확인");
		return;
	}
	
	return true;
}
//전체 선택 종료
// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	if(!checkCondition()) return;
	D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
	if ( !G_isLoaded("dsMAIN"))
	{
		C_msgOk("자산목록을 먼저조회하세요");
		return;	
	}
	
	if ( dsMAIN.CountRow <1)
	{
		C_msgOk("자산목록이 없으므로 증감사항을 등록할 수 없습니다");
		return;	
	}
	G_addRow(dsMAIN2);
}

// 삽입
function btninsert_onclick()
{
	btnadd_onclick();
}

// 삭제
function btndelete_onclick()
{
	if (G_FocusDataset == dsMAIN2)
	{
		if (dsMAIN.NameString(dsMAIN.RowPosition,"DEPREC_FINISH") == '3' ||  dsMAIN.NameString(dsMAIN.RowPosition,"DEPREC_FINISH") == '4' )
		{
			C_msgOk("매각또는 폐기된 고정자산은 <br>증감 내역을 삭제할 수 없습니다.");
			return false;	
		}
	}
	D_defaultDelete();
}

// 저장
function btnsave_onclick()
{	

	D_defaultSave(dsMAIN2);
}

// 취소
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "INCREDU_DT")
	{
		dsMAIN2.NameString(dsMAIN2.RowPosition,"INCREDU_DT") = asDate;
	}
}
function OnDblClick(dataset, grid, row, colid)
{
	if (dataset == dsMAIN2)
	{
		if (dsMAIN.NameString(dsMAIN.RowPosition,"DEPREC_FINISH") == '3' ||  dsMAIN.NameString(dsMAIN.RowPosition,"DEPREC_FINISH") == '4' )
		{
			C_msgOk("매각또는 폐기된 고정자산은 <br>증감 내역을 수정할 수 없습니다. <br>증감내역을 변경하려면 대장정보에서 <br> 완료구분을 변경하세요");
			return false;	
		}
	}
}

function OnLoadCompleted(dataset, rowcnt)
{
}

function OnRowInsertBefore(dataset)
{
	if (dataset == dsMAIN2)
	{
		if (dsMAIN.NameString(dsMAIN.RowPosition,"DEPREC_FINISH") == '3' ||  dsMAIN.NameString(dsMAIN.RowPosition,"DEPREC_FINISH") == '4' )
		{
			C_msgOk("매각또는 폐기된 고정자산은 <br>증감 내역을 입력할 수 없습니다.");
			return false;	
		}
	}
	return true;
}

function OnRowInserted(dataset, row)
{
	
	if (dataset == dsMAIN2)
	{
		G_Load(dsINCREDU_SEQ, null);
	
		dataset.NameString(dataset.RowPosition,"INCREDU_SEQ") 	= dsINCREDU_SEQ.NameValue(dsINCREDU_SEQ.RowPosition,"INCREDU_SEQ");
		//dataset.NameString(dataset.RowPosition,"INCREDU_CLS") 	= "1";
		dataset.NameString(dataset.RowPosition,"INCREDU_DT") 	= dsCUR_DATE.NameValue(dsCUR_DATE.RowPosition,"INCREDU_DT");//디폴트오늘날짜입력
		dataset.NameString(dataset.RowPosition,"INCSUB_CNT") 	= "1";
		gridMAIN2.focus();
	}
}
function OnRowPosChanged(dataset, row)
{
	if (dataset == dsMAIN)
	{
		if (dataset.NameString(dataset.RowPosition,"DEPREC_FINISH") == '3' ||  dataset.NameString(dataset.RowPosition,"DEPREC_FINISH") == '4' )
		{
			gridMAIN2.Editable='false';	
		}
		else
		{
			gridMAIN2.Editable='true';
		}
	}
	else if(dataset == dsMAIN2)
	{
		
		if(dataset.NameValue(row, 'INCREDU_CLS')=='1')
		{
			gridMAIN2.ColumnProp('INCSUB_AMT','Name')='자본적지출금액';
			gridMAIN2.ColumnProp('INCREDU_DT','Name')='자본적지출일자';
			G_setReadOnlyCol(gridMAIN2,"CUST_NAME");
			G_setReadOnlyCol(gridMAIN2,"EMP_NAME");
		}
		else if(dataset.NameValue(row,  'INCREDU_CLS')=='3')
		{
			gridMAIN2.ColumnProp('INCSUB_AMT','Name')='폐기금액';
			gridMAIN2.ColumnProp('INCREDU_DT','Name')='폐기일자';
			gridMAIN2.ColumnProp('CUST_NAME','Name')='폐기처';
			gridMAIN2.ColumnProp('EMP_NAME','Name')='폐기담당자';
			
			G_setReadWriteCol(gridMAIN2, 'CUST_NAME');
			G_setReadWriteCol(gridMAIN2, 'EMP_NAME');
		}
		else if(dataset.NameValue(row,  'INCREDU_CLS')=='4')
		{
			gridMAIN2.ColumnProp('INCSUB_AMT','Name')='매각금액';
			gridMAIN2.ColumnProp('INCREDU_DT','Name')='매각일자';
			gridMAIN2.ColumnProp('CUST_NAME','Name')='매각처';
		       gridMAIN2.ColumnProp('EMP_NAME','Name')='매각담당자';
		       G_setReadWriteCol(gridMAIN2, 'CUST_NAME');
			G_setReadWriteCol(gridMAIN2, 'EMP_NAME');
		}
		
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
	if(dataset == dsMAIN2)
	{
		if(colid =='INCREDU_CLS')
		{
			if(dataset.NameValue(row, colid)=='1')
			{
				gridMAIN2.ColumnProp('INCSUB_AMT','Name')='자본적지출금액';
				gridMAIN2.ColumnProp('INCREDU_DT','Name')='자본적지출일자';
				G_setReadOnlyCol(gridMAIN2,"CUST_NAME");
				G_setReadOnlyCol(gridMAIN2,"EMP_NAME");
			}
			else if(dataset.NameValue(row, colid)=='3')
			{
				gridMAIN2.ColumnProp('INCSUB_AMT','Name')='폐기금액';
				gridMAIN2.ColumnProp('INCREDU_DT','Name')='폐기일자';
				gridMAIN2.ColumnProp('CUST_NAME','Name')='폐기처';
				gridMAIN2.ColumnProp('EMP_NAME','Name')='폐기담당자';
				G_setReadWriteCol(gridMAIN2, 'CUST_NAME');
				G_setReadWriteCol(gridMAIN2, 'EMP_NAME');
			}
			else if(dataset.NameValue(row, colid)=='4')
			{
				gridMAIN2.ColumnProp('INCSUB_AMT','Name')='매각금액';
				gridMAIN2.ColumnProp('INCREDU_DT','Name')='매각일자';
				gridMAIN2.ColumnProp('CUST_NAME','Name')='매각처';
				gridMAIN2.ColumnProp('EMP_NAME','Name')='매각담당자';
				G_setReadWriteCol(gridMAIN2, 'CUST_NAME');
				G_setReadWriteCol(gridMAIN2, 'EMP_NAME');
			}
			
		}
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
	var		COL_DATA;
	COL_DATA = dsMAIN2.NameString(row,colid);
	if (COL_DATA == "") return;
	if(colid == "INCREDU_DT")
	{
		if(C_isNull(COL_DATA))
		{
			return ;
		}
		else
		{
			if(C_isValidDate(COL_DATA))
			{
				dsMAIN2.NameString(row,colid) = C_toDateFormatString(COL_DATA);
			}
			else
			{
				dsMAIN2.NameString(row,colid) = olddata;
				C_msgOk("날짜값이 잘못 입력되었습니다.","알림");
    
				return ;
			}
		}
	}
	else if(colid == "CUST_NAME")
	{
		if(C_isNull(COL_DATA))
		{
			dataset.NameValue(row, "CUST_NAME")	="";
			dataset.NameValue(row, "ST_CUST_SEQ")	= "";
			return false ;
		}
	
		
	}
	else if(colid == "EMP_NAME")
	{
		if(C_isNull(COL_DATA))
		{
			dataset.NameValue(row, "ST_EMP_NO")	="";
			dataset.NameValue(row, "EMP_NAME")	= "";
			return false ;
		}
	
		
	}		
}

function OnPopup(dataset, grid, row, colid, data)
{
	
	if ( dataset == dsMAIN2)
	{
		if(colid == "INCREDU_DT")
		{
			C_Calendar("INCREDU_DT", "D", dataset.NameString(dataset.RowPosition,"INCREDU_DT"));
		}
		else if(colid == "CUST_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			
			lrArgs.set("SEARCH_CONDITION", "");
			
			lrRet = C_LOV("T_CUST_CODE1", lrArgs,"F");
			
			if (lrRet == null) return;
		
			dataset.NameValue(row, "CUST_NAME")	= lrRet.get("CUST_NAME");
			dataset.NameValue(row, "ST_CUST_SEQ")	= lrRet.get("CUST_SEQ");
		}
		else if(colid == "EMP_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			
			lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
			lrArgs.set("SEARCH_CONDITION", "");
			
			lrRet = C_LOV("Z_AUTHORITY_USER01", lrArgs,"F");
			
			if (lrRet == null) return;
		
			dataset.NameValue(row, "ST_EMP_NO")	= lrRet.get("EMPNO");
			dataset.NameValue(row, "EMP_NAME")	= lrRet.get("NAME");
		}		
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

	lrRet = C_LOV("T_COMP_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}
//품목코드
function txtITEM_CODE_onblur()
{
	if (C_isNull(txtITEM_CODE.value))
	{
		txtITEM_NAME.value = "";
		return;
	}
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_AutoLov(dsLOV,"T_FIX_ITEM_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtITEM_CODE.value	= lrRet.get("ITEM_CODE");
	txtITEM_NAME.value	= lrRet.get("ITEM_NAME");
}

function btnITEM_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_FIX_ITEM_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;

	txtITEM_CODE.value	= lrRet.get("ITEM_CODE");
	txtITEM_NAME.value	= lrRet.get("ITEM_NAME");
}
//품명코드
function txtITEM_NM_CODE_onblur()
{

	if (!C_isNull(txtITEM_NM_CODE.value))
	{
		if (C_isNull(txtITEM_CODE.value))
		{
			C_msgOk("품목구분을 먼저 선택하세요.");
			return;
		}
	}
	
	if (C_isNull(txtITEM_NM_CODE.value))
	{
		txtITEM_NM_NAME.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("ITEM_CODE", txtITEM_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_AutoLov(dsLOV,"T_FIX_ITEM_NM_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtITEM_NM_CODE.value	= lrRet.get("ITEM_NM_CODE");
	txtITEM_NM_NAME.value	= lrRet.get("ITEM_NM_NAME");
}

function btnITEM_NM_CODE_onClick()
{
	if (txtITEM_CODE.value == "")
	{
		C_msgOk("품목구분을 먼저 선택하세요.");
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("ITEM_CODE", txtITEM_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_FIX_ITEM_NM_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtITEM_NM_CODE.value	= lrRet.get("ITEM_NM_CODE");
	txtITEM_NM_NAME.value	= lrRet.get("ITEM_NM_NAME");
}//권한없는 부서현장(전사업장)

//구매부서
function txtMNG_DEPT_CODE_onblur()
{
	if (txtMNG_DEPT_CODE.value == "")
	{
		txtMNG_DEPT_NAME.value 	= "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", txtMNG_DEPT_CODE.value);
	
	//부서/현장 전사업장
	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtMNG_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtMNG_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
}
function btnMNG_DEPT_CODE_onClick()
{
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_DEPT_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtMNG_DEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtMNG_DEPT_NAME.value	= lrRet.get("DEPT_NAME");
}
//배치현장
function txtDEPT_CODE_onblur()
{
	if (txtDEPT_CODE.value == "")
	{
		txtDEPT_NAME.value 	= "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);
	
	//부서/현장 전사업장
	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
}
function btnDEPT_CODE_onClick()
{
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_DEPT_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");
}
//거래처검색
function txtCUST_CODE_onblur()
{
	if (txtCUST_CODE.value == "")
	{
		txtCUST_NAME.value 	= "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", txtCUST_CODE.value);
	

	lrRet = C_AutoLov(dsLOV,"T_CUST_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCUST_CODE.value	= lrRet.get("CUST_CODE");
	txtCUST_NAME.value	= lrRet.get("CUST_NAME");
	hiCUST_SEQ.value		= lrRet.get("CUST_SEQ");
}
function btnCUST_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_CUST_CODE1", lrArgs,"F");
	
	if (lrRet == null) return;

	txtCUST_CODE.value	= lrRet.get("CUST_CODE");
	txtCUST_NAME.value	= lrRet.get("CUST_NAME");
	hiCUST_SEQ.value		= lrRet.get("CUST_SEQ");
}

//자동전표발행(자본적 지출)
function btnAutoSlipMake_onClick()
{
	//if (!G_isLoaded("dsMAIN"))
	//{
		//C_msgOk("먼저 조회를 수행하세요");
		//return;	
	//}		
	
	//if (dsMAIN.CountRow  < 1)
	//{
		//C_msgOk("자동발행할 고정자산이 없습니다");	
		//return;
	//}
	
	var arrRtn = null;
	var arrRtn2 = null;
	
	arrRtn2 = window.showModalDialog("t_PSlip01FixIncreduR.jsp", arrRtn, "center:yes; dialogWidth:1024px; dialogHeight:768px; status:no; help:no; scroll:no");

	if(arrRtn2 == null) return;
}

//매각 자동전표발행
function btnAutoSlipMake2_onClick()
{
	//if (!G_isLoaded("dsMAIN"))
	//{
		//C_msgOk("먼저 조회를 수행하세요");
		//return;	
	//}		
	
	//if (dsMAIN.CountRow  < 1)
	//{
		//C_msgOk("자동발행할 고정자산이 없습니다");	
		//return;
	//}
	
	var arrRtn = null;
	var arrRtn2 = null;
	
	arrRtn2 = window.showModalDialog("t_PSlip02FixIncreduR.jsp", arrRtn, "center:yes; dialogWidth:1024px; dialogHeight:768px; status:no; help:no; scroll:no");

	if(arrRtn2 == null) return;
}

//폐기 자동전표발행
function btnAutoSlipMake3_onClick()
{
	//if (!G_isLoaded("dsMAIN"))
	//{
		//C_msgOk("먼저 조회를 수행하세요");
		//return;	
	//}		
	
	//if (dsMAIN.CountRow  < 1)
	//{
		//C_msgOk("자동발행할 고정자산이 없습니다");	
		//return;
	//}
	
	var arrRtn = null;
	var arrRtn2 = null;
	
	arrRtn2 = window.showModalDialog("t_PSlip03FixIncreduR.jsp", arrRtn, "center:yes; dialogWidth:1024px; dialogHeight:768px; status:no; help:no; scroll:no");

	if(arrRtn2 == null) return;
}
