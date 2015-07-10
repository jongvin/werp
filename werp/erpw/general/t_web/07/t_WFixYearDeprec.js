/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFixYearDeprec.js(회기별상각액)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 회기별상각액 
/* 4. 변  경  이  력 : 한재원 작성(2006-01-23)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, null, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "고정자산대장");
	G_addDataSet(dsMAIN2, trans, gridMAIN2, sSelectPageName+D_P1("ACT","MAIN2"), "회기별상각액");
	G_addDataSet(dsASSETCLS, null, null, sSelectPageName+D_P1("ACT","ASSET_CLS_CODE"), "자산종류");
	G_addDataSet(dsDEPREC_FINISH, null, null, sSelectPageName+D_P1("ACT","DEPREC_FINISH"), "상각완료구분");

	
	G_addDataSet(dsLOV, null, null,null, "LOV");
	G_addDataSet(dsCUR_DATE, null, null,sSelectPageName+D_P1("ACT","CUR_DATE"), "오늘날짜");
	
	G_addRel(dsMAIN, dsMAIN2);
	G_addRelCol(dsMAIN2, "FIX_ASSET_SEQ", "FIX_ASSET_SEQ");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value = sAccId;
	
	G_setReadOnlyCol(gridMAIN,"ASSET_MNG_NO");
	G_setReadOnlyCol(gridMAIN,"ASSET_NAME");
	G_setReadOnlyCol(gridMAIN,"DEPREC_FINISH");
	G_setReadOnlyCol(gridMAIN,"ASSET_SIZE");
	G_setReadOnlyCol(gridMAIN,"GET_DT");
	G_setReadOnlyCol(gridMAIN,"SRVLIFE");
	G_setReadOnlyCol(gridMAIN,"GET_COST_AMT");
	G_setReadOnlyCol(gridMAIN,"BASE_AMT");
	G_setReadOnlyCol(gridMAIN,"MNG_DEPT_NAME");
	G_setReadOnlyCol(gridMAIN,"REMARK");
	
	gridMAIN.focus();
	G_Load(dsCUR_DATE, null);
	G_Load(dsASSETCLS, null);
	G_Load(dsDEPREC_FINISH, null);
	chkTotal01.checked = true;
	chkTotal01_onclick();
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
									 + D_P2("FIX_ASSET_SEQ", dsMAIN.NameString(dsMAIN.RowPosition,"FIX_ASSET_SEQ"))
									 + D_P2("COMP_CODE", txtCOMP_CODE.value)
									 + D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value);
	}
	else if(dataset == dsASSETCLS)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","ASSET_CLS_CODE");									
	}
	else if(dataset == dsDEPREC_FINISH)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","DEPREC_FINISH");									
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
function	CheckCompCode()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("먼저 사업장코드를 선택하세요.", "확인");
		return false;
	}
	return true;
}

//전체 선택 시작
function	chkTotal01_onclick()
{
	if(chkTotal01.checked)
	{
		txtITEM_CODE.value ="";
		txtITEM_NAME.value ="";
		txtITEM_CODE.readOnly=true;
		txtITEM_CODE.style.backgroundColor = "#EFEFEF";
		btnITEM_CODE.disabled  = true;

		txtITEM_NM_CODE.value ="";
		txtITEM_NM_NAME.value ="";
		txtITEM_NM_CODE.readOnly=true;
		txtITEM_NM_CODE.style.backgroundColor = "#EFEFEF";
		btnITEM_NM_CODE.disabled  = true;
		chkTotal02.checked = true;
	}
else
	{
		txtITEM_CODE.readOnly=false;
		txtITEM_CODE.style.backgroundColor = "#ffffff";
		btnITEM_CODE.disabled = false;

		txtITEM_NM_CODE.readOnly=false;
		txtITEM_NM_CODE.style.backgroundColor = "#ffffff";
		btnITEM_NM_CODE.disabled = false;
		chkTotal02.checked = false;
	}
}
function	chkTotal02_onclick()
{
	if(chkTotal02.checked)
	{
		txtITEM_NM_CODE.value ="";
		txtITEM_NM_NAME.value ="";
		txtITEM_NM_CODE.readOnly=true;
		txtITEM_NM_CODE.style.backgroundColor = "#EFEFEF";
		btnITEM_NM_CODE.disabled  = true;
	}
	else
	{
		txtITEM_NM_CODE.readOnly=false;
		txtITEM_NM_CODE.style.backgroundColor = "#ffffff";
		btnITEM_NM_CODE.disabled = false;
	}
}

//조회시 체크
function checkCondition()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("사업장을  선택하십시요.", "확인");
		return;
	}
	if (txtITEM_CODE.value == "" && chkTotal01.checked == false)
	{
		C_msgOk("품목코드를 입력하시거나 '전체'를 선택하십시요.", "확인");
		return;
	}
	if (txtITEM_NM_CODE.value == "" && chkTotal02.checked == false)
	{
		C_msgOk("품명코드를 입력하시거나 '전체'를 선택하십시요.", "확인");
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
	D_defaultDelete();
}

// 저장
function btnsave_onclick()
{	

	D_defaultSave(dsMAIN2);
	D_defaultLoad();
}

// 취소
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "MOVE_DT_FROM")
	{
		dsMAIN2.NameString(dsMAIN2.RowPosition,"MOVE_DT_FROM") = asDate;
		if ( !C_isNull(dsMAIN2.NameValue(dsMAIN2.RowPosition, "MOVE_DT_FROM")))
		{
			strMoveDtFrom = dsMAIN2.NameValue(dsMAIN2.RowPosition, "MOVE_DT_FROM").replace(/-/gi,"");
			strMoveDtTo	 = dsMAIN2.NameValue(dsMAIN2.RowPosition, "MOVE_DT_TO").replace(/-/gi,"");

			if (parseInt(strMoveDtFrom) > parseInt(strMoveDtTo))
			{
				C_msgOk("시작일은 종료일보다 작게 입력하세요");
				dsMAIN2.NameValue(dsMAIN2.RowPosition, "MOVE_DT_FROM") = olddata;
				return;
			}
		}	
	}
	else if (asCalendarID == "MOVE_DT_TO")
	{
		dsMAIN2.NameString(dsMAIN2.RowPosition,"MOVE_DT_TO") = asDate;
		if ( !C_isNull(dsMAIN2.NameValue(dsMAIN2.RowPosition, "MOVE_DT_TO")))
		{
			strMoveDtFrom = dsMAIN2.NameValue(dsMAIN2.RowPosition, "MOVE_DT_FROM").replace(/-/gi,"");
			strMoveDtTo	 = dsMAIN2.NameValue(dsMAIN2.RowPosition, "MOVE_DT_TO").replace(/-/gi,"");

			if (parseInt(strMoveDtFrom) > parseInt(strMoveDtTo))
			{
				C_msgOk("시작일은 종료일보다 작게 입력하세요");
				dsMAIN2.NameValue(dsMAIN2.RowPosition, "MOVE_DT_TO") = olddata;
				return;
			}
		}	
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
	
	if (dataset == dsMAIN2)
	{
		G_Load(dsMOVE_SEQ, null);
	
		dataset.NameString(dataset.RowPosition,"MOVE_SEQ") 		= dsMOVE_SEQ.NameValue(dsMOVE_SEQ.RowPosition,"MOVE_SEQ");
		dataset.NameString(dsMAIN.RowPosition,"MOVE_DT_FROM") 	= dsCUR_DATE.NameValue(dsCUR_DATE.RowPosition,"CUR_DATE");//디폴트오늘날짜입력
		gridMAIN2.focus();
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
	var		COL_DATA;
	COL_DATA = dsMAIN2.NameString(row,colid);
	if (COL_DATA == "") return;
	if(colid == "MOVE_DT_FROM")
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
				
				if ( !C_isNull(dataset.NameValue(row, "MOVE_DT_FROM")))
				{
					strMoveDtFrom = dataset.NameValue(row, "MOVE_DT_FROM").replace(/-/gi,"");
					strMoveDtTo	 = dataset.NameValue(row, "MOVE_DT_TO").replace(/-/gi,"");

					if (parseInt(strMoveDtFrom) > parseInt(strMoveDtTo))
					{
						C_msgOk("시작일은 종료일보다 작게 입력하세요");
						dataset.NameValue(row, "MOVE_DT_FROM") = olddata;
						return;
					}
				}	
			}
			else
			{
				dsMAIN2.NameString(row,colid) = olddata;
				C_msgOk("날짜값이 잘못 입력되었습니다.","알림");
    
				return ;
			}
		}
	}
	else if(colid == "MOVE_DT_TO")
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
				
				if ( !C_isNull(dataset.NameValue(row, "MOVE_DT_TO")))
				{
					strMoveDtFrom = dataset.NameValue(row, "MOVE_DT_FROM").replace(/-/gi,"");
					strMoveDtTo	 = dataset.NameValue(row, "MOVE_DT_TO").replace(/-/gi,"");

					if (parseInt(strMoveDtFrom) > parseInt(strMoveDtTo))
					{
						C_msgOk("시작일은 종료일보다 작게 입력하세요");
						dataset.NameValue(row, "MOVE_DT_TO") = olddata;
						return;
					}
				}	
			}
			else
			{
				dsMAIN2.NameString(row,colid) = olddata;
				C_msgOk("날짜값이 잘못 입력되었습니다.","알림");
    
				return ;
			}
		}
	}
	else if(colid == "DEPT_NAME")
	{
		var lrArgs = new C_Dictionary();
		var lrRet = null;
		
		lrArgs.set("SEARCH_CONDITION", dataset.NameValue(row, "DEPT_NAME"));
		
		if ( C_isNull(dataset.NameValue(row, "DEPT_NAME")))
		{
			dataset.NameValue(row, "DEPT_CODE") ="";	
		}
		else
		{
			lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE1", lrArgs,"T");
		}
		if (lrRet == null) 
		{
			dataset.NameValue(row, "DEPT_CODE")		= "";
			dataset.NameValue(row, "DEPT_NAME")	= "";
			return;
		}
		
		
		dataset.NameValue(row, "DEPT_CODE")		= lrRet.get("DEPT_CODE");
		dataset.NameValue(row, "DEPT_NAME")	= lrRet.get("DEPT_NAME");
	}
	else if(colid == "EMP_NM")
	{
		var lrArgs = new C_Dictionary();
		var lrRet = null;
		
		lrArgs.set("SEARCH_CONDITION",dataset.NameValue(row, "EMP_NM"));
		
		if ( C_isNull(dataset.NameValue(row, "EMP_NM")))
		{
			dataset.NameValue(row, "EMP_NO") ="";	
		}
		else
		{
			lrRet = C_AutoLov(dsLOV,"T_EMP_NO1", lrArgs,"T");
		}
		if (lrRet == null)
		{
			dataset.NameValue(row, "EMP_NO")	= "";
			dataset.NameValue(row, "EMP_NM")	= "";
		 	return;
		}
		dataset.NameValue(row, "EMP_NO")	= lrRet.get("EMPNO");
		dataset.NameValue(row, "EMP_NM")	= lrRet.get("NAME");
	}
	
	else if(colid == "MNG_MAIN_NM")
	{
		var lrArgs = new C_Dictionary();
		var lrRet = null;
		
		lrArgs.set("SEARCH_CONDITION",dataset.NameValue(row, "MNG_MAIN_NM"));
		
		if ( C_isNull(dataset.NameValue(row, "MNG_MAIN_NM")))
		{
			dataset.NameValue(row, "MNG_MAIN") ="";	
		}
		else
		{
			lrRet = C_AutoLov(dsLOV,"T_EMP_NO1", lrArgs,"T");
		}
		if (lrRet == null)
		{
			dataset.NameValue(row, "MNG_MAIN")	= "";
			dataset.NameValue(row, "MNG_MAIN_NM")	="";
			 return;
		}
		dataset.NameValue(row, "MNG_MAIN")		= lrRet.get("EMPNO");
		dataset.NameValue(row, "MNG_MAIN_NM")	= lrRet.get("NAME");
	}
	else if(colid == "MNG_SUB_NM")
	{
		var lrArgs = new C_Dictionary();
		var lrRet = null;
		
		lrArgs.set("SEARCH_CONDITION",dataset.NameValue(row, "MNG_SUB_NM"));
		
		if ( C_isNull(dataset.NameValue(row, "MNG_SUB_NM")))
		{
			dataset.NameValue(row, "MNG_SUB") ="";	
		}
		else
		{
			lrRet = C_AutoLov(dsLOV,"T_EMP_NO1", lrArgs,"T");
		}
		if (lrRet == null)
		{
			dataset.NameValue(row, "MNG_SUB")	= "";
			dataset.NameValue(row, "MNG_SUB_NM")	="";	
			 return;
		}
		dataset.NameValue(row, "MNG_SUB")	= lrRet.get("EMPNO");
		dataset.NameValue(row, "MNG_SUB_NM")	= lrRet.get("NAME");
	}
	
}

function OnPopup(dataset, grid, row, colid, data)
{
	if ( dataset == dsMAIN2)
	{
		if(colid == "MOVE_DT_FROM")
		{
			C_Calendar("MOVE_DT_FROM", "D", dataset.NameString(row,"MOVE_DT_FROM"));
		}
		else if(colid == "MOVE_DT_TO")
		{
			C_Calendar("MOVE_DT_TO", "D", dataset.NameString(row,"MOVE_DT_TO"));
		}
		else if(colid == "DEPT_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_DEPT_CODE1", lrArgs,"F");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row, "DEPT_CODE")		= lrRet.get("DEPT_CODE");
			dataset.NameValue(row, "DEPT_NAME")	= lrRet.get("DEPT_NAME");
		}
		else if(colid == "EMP_NM")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION","");
		
			lrRet = C_LOV("T_EMP_NO1", lrArgs,"F");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row, "EMP_NO")	= lrRet.get("EMPNO");
			dataset.NameValue(row, "EMP_NM")	= lrRet.get("NAME");
		}
		else if(colid == "MNG_MAIN_NM")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_EMP_NO1", lrArgs,"F");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row, "MNG_MAIN")	= lrRet.get("EMPNO");
			dataset.NameValue(row, "MNG_MAIN_NM")	= lrRet.get("NAME");
		}
		else if(colid == "MNG_SUB_NM")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_EMP_NO1", lrArgs,"F");
			
			if (lrRet == null) return;
		
			dataset.NameValue(row, "MNG_SUB")	= lrRet.get("EMPNO");
			dataset.NameValue(row, "MNG_SUB_NM")	= lrRet.get("NAME");
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

	lrRet = C_LOV("T_COMP_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}
//품목코드
function txtITEM_CODE_onblur()
{
	
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

	if (txtITEM_CODE.value == "")
	{
		C_msgOk("품목코드를 먼저을 입력하십시오.");
		return;
	}
	if (txtITEM_NM_CODE.value == "")
	{
		txtITEM_NM_NAME.value 	= "";
		txtITEM_NM_CODE.value 	= "";
		txtITEM_NM_NAME.value 	= "";
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
		C_msgOk("품목코드를 먼저을 입력하십시오.");
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("ASSET_CLS_CODE", dsASSETCLS.NameValue(dsASSETCLS.RowPosition, "ASSET_CLS_CODE"));
	lrArgs.set("ITEM_CODE", txtITEM_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_FIX_ITEM_NM_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;

	txtITEM_NM_CODE.value	= lrRet.get("ITEM_NM_CODE");
	txtITEM_NM_NAME.value	= lrRet.get("ITEM_NM_NAME");
}//권한없는 부서현장(전사업장)
//계정코드찾기
function txtACC_CODE_onblur()
{
	if (txtACC_CODE.value == "")
	{
		txtACC_NAME.value 	= "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", txtACC_CODE.value);
	
	//입력가능,불가능계정
	lrRet = C_AutoLov(dsLOV,"T_ACC_CODE3", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtACC_CODE.value	= lrRet.get("ACC_CODE");
	txtACC_NAME.value	= lrRet.get("ACC_NAME");
}
function btnACC_CODE_onClick()
{
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", "");
	
	lrRet = C_LOV("T_ACC_CODE3", lrArgs,"F");
	
	if (lrRet == null) return;

	txtACC_CODE.value	= lrRet.get("ACC_CODE");
	txtACC_NAME.value	= lrRet.get("ACC_NAME");
}
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
function txtCLSE_ACC_ID_onblur()
{
	if(!CheckCompCode()) return;
	if (C_isNull(txtCLSE_ACC_ID.value))
	{
		txtACC_ID.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("CLSE_ACC_ID", txtCLSE_ACC_ID.value);
	

	lrRet = C_AutoLov(dsLOV,"T_YEAR", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");
	
	btnquery_onclick();
	
}
function btnACC_ID_onClick()
{
	if(!CheckCompCode()) return;
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("CLSE_ACC_ID", "");
	
	lrRet = C_LOV("T_YEAR", lrArgs,"F");
	
	if (lrRet == null) return;
	
	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");
	
	btnquery_onclick();

}