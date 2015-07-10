/**************************************************************************/
/* 1. 프 로 그 램 id : t_WBudgItemCostR.js(예산코드항목등록)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 예산코드항목등록 
/* 4. 변  경  이  력 : 한재원 작성(2005-12-08)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "예산코드항목",null,null,true);
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "직급별단가");
	G_addDataSet(dsBUDG_CODE_NO, null, null, null, "최상위예산코드");
	G_addDataSet(dsCHILD_BUDG_CODE_NO, null, null, null, "예산코드");
	
	G_addDataSet(dsGRADE_COPY, transGradeCopy, null, null, "직급코드");
	G_addDataSet(dsLOV, null, null, null, "LOV");
	G_addDataSet(dsITEM_NO, null, null, null, "ITEM_NO");

	G_addRel(dsBUDG_CODE_NO, dsCHILD_BUDG_CODE_NO);
	G_addRelCol(dsCHILD_BUDG_CODE_NO, "BUDG_CODE_NO", "BUDG_CODE_NO");

	G_addRel(dsMAIN, dsSUB01);
	G_addRelCol(dsSUB01, "BUDG_CODE_NO", "BUDG_CODE_NO");
	G_addRelCol(dsSUB01, "ITEM_NO", "ITEM_NO");
	G_addRelCol(dsSUB01, "COMP_CODE", "COMP_CODE");
	G_addRelCol(dsSUB01, "CLSE_ACC_ID", "CLSE_ACC_ID");
		
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value = sAccId;
	
	//txtBUDG_CODE_NO.readOnly=true;
	//txtBUDG_CODE_NO.style.backgroundColor = "#EFEFEF";
	//btnBUDG_CODE_NO.disabled  = true;
	gridMAIN.focus();
	
	G_Load(dsBUDG_CODE_NO, null);

}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		var strP_BUDG_CODE_NO = dsBUDG_CODE_NO.NameValue(dsBUDG_CODE_NO.RowPosition,"BUDG_CODE_NO");
		 
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										 + D_P2("CHECK", strCheck)
										 + D_P2("P_BUDG_CODE_NO",   strP_BUDG_CODE_NO)
										 + D_P2("BUDG_CODE_NO",  txtBUDG_CODE_NO.value)
										 + D_P2("COMP_CODE",  txtCOMP_CODE.value)
										 + D_P2("CLSE_ACC_ID",  txtCLSE_ACC_ID.value);
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
										 + D_P2("BUDG_CODE_NO",dsMAIN.NameString(dsMAIN.RowPosition,"BUDG_CODE_NO"))
										 + D_P2("ITEM_NO",dsMAIN.NameString(dsMAIN.RowPosition,"ITEM_NO"))
										 + D_P2("COMP_CODE",  txtCOMP_CODE.value)
										 + D_P2("CLSE_ACC_ID",  txtCLSE_ACC_ID.value);
	}
	else if(dataset == dsBUDG_CODE_NO)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","BUDG_CODE_NO")
									 + D_P2("COMP_CODE",  txtCOMP_CODE.value);
	}
	else if(dataset == dsCHILD_BUDG_CODE_NO)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","CHILD_BUDG_CODE_NO")
										 + D_P2("BUDG_CODE_NAME", dsBUDG_CODE_NO.NameString(dsBUDG_CODE_NO.RowPosition,"BUDG_CODE_NAME"));
	}
	else if(dataset == dsITEM_NO)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","ITEM_NO");
	}
	else if(dataset == dsGRADE_COPY)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","GRADE_COPY");
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
function getParentBudgeCode()
{
	if ( dsBUDG_CODE_NO.NameString(dsBUDG_CODE_NO.RowPosition,"BUDG_CODE_NAME")=="전체") 
	{
		strPARENT_BUDG_CODE_NAME="전체";
	}
	else 
	{
		strPARENT_BUDG_CODE_NAME = dsBUDG_CODE_NO.NameString(dsBUDG_CODE_NO.RowPosition,"BUDG_CODE_NAME");
		
	}
	
	return 	strPARENT_BUDG_CODE_NAME;
}
function getBudgCode()
{
	if (getParentBudgeCode() == "전체")
	{
		strBUDG_CODE_NO ="";
	} 
	else
	{
		strBUDG_CODE_NO = dsCHILD_BUDG_CODE_NO.NameString(dsCHILD_BUDG_CODE_NO.RowPosition,"BUDG_CODE_NAME");
	}
	return strBUDG_CODE_NO;
}
// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	
	D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
	if (C_isNull(txtCLSE_ACC_ID.value))
	{
		C_msgOk("회기를 입력하세요");
		return;	
	}
	
	if (G_FocusDataset.id == "dsMAIN")
	{
		var lrArgs = new C_Dictionary();
		var lrRet = null;
		
		lrArgs.set("1COMP_CODE", txtCOMP_CODE.value);
		lrArgs.set("2COMP_CODE", txtCOMP_CODE.value);
		lrArgs.set("3COMP_CODE", txtCOMP_CODE.value);
		lrArgs.set("DEPT_CODE", strDEPT_CODE);
		lrArgs.set("SEARCH_CONDITION", "");
	
		lrRet = C_LOV("T_BUDG_CODE2", lrArgs,"F");
		
		if (lrRet == null) return;
	
		strA_BUDG_CODE_NO	    = lrRet.get("BUDG_CODE_NO");
		strA_BUDG_CODE_NAME	    = lrRet.get("BUDG_CODE_NAME");
	}
	
	if (G_FocusDataset.id == "dsSUB01")
	{
		
		if (dsMAIN.NameString(dsMAIN.RowPosition, "GRADE_UNIT_TAG") == "F")
		{
			C_msgOk("단가여부를 선택하세요");
			return;	
		}	
	}
	D_defaultAdd();
}

// 삽입
function btninsert_onclick()
{
	btnadd_onclick();
}

// 삭제
function btndelete_onclick()
{
	strFlag ="ADD";
	D_defaultDelete();
}

// 저장
function btnsave_onclick()
{
	strFlag ="ADD";
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
		
		G_Load(dsITEM_NO, null);
		
		if ( strFlag =="ADD")
		{
			dataset.NameString(row, "BUDG_CODE_NO")   = strA_BUDG_CODE_NO;
			dataset.NameString(row, "BUDG_CODE_NAME") = strA_BUDG_CODE_NAME;
			dataset.NameString(row, "ITEM_NO") 		  = dsITEM_NO.NameString(dsITEM_NO.RowPosition, "ITEM_NO");
			dataset.NameString(row, "DAY_CALC_TAG")   = "D";
			dataset.NameString(row, "UNIT_TAG")       = "D";
			dataset.NameString(row, "GRADE_UNIT_TAG") 	= "F";
			dataset.NameString(row, "CLSE_ACC_ID") 		= txtCLSE_ACC_ID.value;
			dataset.NameString(row, "COMP_CODE") 		= txtCOMP_CODE.value;
		}
		//G_Load(dsITEM_NO, null);
		else if ( strFlag == "COPY")
		{
			
			dataset.NameString(row, "BUDG_CODE_NO") 	= strCOPY_BUDG_CODE_NO; 
			dataset.NameString(row, "BUDG_CODE_NAME") 	= strCOPY_BUDG_CODE_NAME;
			dataset.NameString(row, "ITEM_NAME") 		= strCOPY_ITEM_NAME;
			dataset.NameString(row, "ITEM_NO") 			= dsITEM_NO.NameString(dsITEM_NO.RowPosition, "ITEM_NO");
			dataset.NameString(row, "DAY_CALC_TAG") 	= strCOPY_DAY_CALC_TAG;
			dataset.NameString(row, "UNIT_TAG") 		= strCOPY_UNIT_TAG;
			dataset.NameString(row, "GRADE_UNIT_TAG") 	= strCOPY_GRADE_UNIT_TAG;
			dataset.NameString(row, "UNIT_COST") 		= strCOPY_UNIT_COST;
			dataset.NameString(row, "CLSE_ACC_ID") 		= txtCLSE_ACC_ID.value;
			dataset.NameString(row, "COMP_CODE") 		= txtCOMP_CODE.value;
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
	if (dataset == dsMAIN)
	{
		if ( colid =="GRADE_UNIT_TAG")
		{
			if( dataset.NameString(row, "GRADE_UNIT_TAG") =="F")
			{
				if ( dsSUB01.CountRow != 0)
				{
					C_msgOk("직급별단가를 삭제해주세요");
					dataset.NameString(row, "GRADE_UNIT_TAG") = "T";
					return;
				}					
			}
			else if( dataset.NameString(row, "GRADE_UNIT_TAG") =="T")
			{
				dataset.NameString(row, "UNIT_COST") = 0;
			}	
		}
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
}

function OnPopup(dataset, grid, row, colid, data)
{
}

// 이벤트관련-------------------------------------------------------------------//
function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		dsMAIN.ClearData();
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	txtCLSE_ACC_ID.value = "";
	txtACC_ID.value = "";
	dsMAIN.ClearData();
}
function txtCLSE_ACC_ID_onblur()
{
	if(!CheckCompCode()) return;
	if (C_isNull(txtCLSE_ACC_ID.value))
	{
		txtACC_ID.value = "";
		dsMAIN.ClearData();
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	lrArgs.set("CLSE_ACC_ID", txtCLSE_ACC_ID.value);
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_BUDG_YEAR", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");
	G_Load(dsMASTER);
	
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
	txtCLSE_ACC_ID.value = "";
	txtACC_ID.value = "";
	dsMAIN.ClearData();
}
function btnACC_ID_onClick()
{
	if(!CheckCompCode()) return;
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("CLSE_ACC_ID", "");
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_LOV("T_BUDG_YEAR", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");
	G_Load(dsMASTER);
	
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
function txtBUDG_CODE_NO_onblur()
{
	if (C_isNull(txtBUDG_CODE_NO.value))
	{
		txtBUDG_CODE_NAME.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	lrArgs.set("1COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("2COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("P_BUDG_CODE_NO",dsBUDG_CODE_NO.NameValue(dsBUDG_CODE_NO.RowPosition, "BUDG_CODE_NO"));
	lrArgs.set("SEARCH_CONDITION", "");
	
	if (!C_isNull(txtBUDG_CODE_NO.value))
	lrRet = C_AutoLov(dsLOV, "T_BUDG_CODE4", lrArgs, "T");
	
	if (lrRet == null) 
	{
		return;
	}
	txtBUDG_CODE_NO.value		= lrRet.get("BUDG_CODE_NO");
	txtBUDG_CODE_NAME.value		= lrRet.get("BUDG_CODE_NAME");
}

function btnBUDG_CODE_NO_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	lrArgs.set("1COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("2COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("P_BUDG_CODE_NO",dsBUDG_CODE_NO.NameValue(dsBUDG_CODE_NO.RowPosition, "BUDG_CODE_NO"));
	lrArgs.set("SEARCH_CONDITION", txtBUDG_CODE_NO.value);

	lrRet = C_LOV("T_BUDG_CODE4", lrArgs,"F");
	
	if (lrRet == null) return;

	txtBUDG_CODE_NO.value	= lrRet.get("BUDG_CODE_NO");
	txtBUDG_CODE_NAME.value	= lrRet.get("BUDG_CODE_NAME");

}

function btnCopy_onClick()
{
	//if (parseInt(dsMAIN.RowStatus(dsMAIN.RowPosition)) != 0)
	//{ 
		//C_msgOk("저장을 하고 복사하세요");
		//return;
	//}
	//else
	//{
		strFlag ="COPY";
		strCOPY_BUDG_CODE_NO   = dsMAIN.NameString(dsMAIN.RowPosition, "BUDG_CODE_NO");
		strCOPY_BUDG_CODE_NAME = dsMAIN.NameString(dsMAIN.RowPosition, "BUDG_CODE_NAME");
		strCOPY_ITEM_NAME      = dsMAIN.NameString(dsMAIN.RowPosition, "ITEM_NAME");
		//strCOPY_ITEM_NO        = dsMAIN.NameString(dsMAIN.RowPosition, "ITEM_NO");
		strCOPY_DAY_CALC_TAG   = dsMAIN.NameString(dsMAIN.RowPosition, "DAY_CALC_TAG");
		strCOPY_UNIT_TAG       = dsMAIN.NameString(dsMAIN.RowPosition, "UNIT_TAG");
		strCOPY_GRADE_UNIT_TAG = dsMAIN.NameString(dsMAIN.RowPosition, "GRADE_UNIT_TAG");
		strCOPY_UNIT_COST      = dsMAIN.NameString(dsMAIN.RowPosition, "UNIT_COST");	
		D_defaultAdd();
	//}	
}

function btnGradeCopy_onClick()
{
	if (dsMAIN.NameString(dsMAIN.RowPosition ,"GRADE_UNIT_TAG")=='F')
	{
		C_msgOk("직급별 단가가 적용되는 경우만 직급복사 요청이 됩니다");
		return false;	
	}
	G_Load(dsGRADE_COPY);

	dsGRADE_COPY.NameString(dsGRADE_COPY.RowPosition,"COMP_CODE")   		=  txtCOMP_CODE.value;
	dsGRADE_COPY.NameString(dsGRADE_COPY.RowPosition,"CLSE_ACC_ID")  	=  txtCLSE_ACC_ID.value;
	dsGRADE_COPY.NameString(dsGRADE_COPY.RowPosition,"BUDG_CODE_NO")   	=  dsMAIN.NameString(dsMAIN.RowPosition ,"BUDG_CODE_NO");
	dsGRADE_COPY.NameString(dsGRADE_COPY.RowPosition,"ITEM_NO") 	       =  dsMAIN.NameString(dsMAIN.RowPosition ,"ITEM_NO");
	
	transGradeCopy.Parameters = "ACT=GRADE_COPY";
	if(!G_saveData(dsGRADE_COPY))return;
	C_msgOk("직급복사가  정상처리되었습니다.");
	G_Load(dsMAIN);
}