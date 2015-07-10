/**************************************************************************/
/* 1. 프 로 그 램 id : t_WBudgDeptMapR(예산편성부서정보설정)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-21)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var			fgManager = null;
var			arTF = null;
var			arControlTag = null;
var			bEnter = false;
function Initialize()
{
	G_addDataSet(dsMAIN, trans, null, sSelectPageName+D_P1("ACT","MAIN"), "예산코드목록");
	G_addDataSet(dsMAIN_D, trans, null, sSelectPageName+D_P1("ACT","MAIN_D"), "예산코드목록삭제");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	G_addDataSet(dsBUDG_CODE_NO, null, null, sSelectPageName+D_P1("ACT","BUDG_CODE_NO"), "예산항목번호");
	
	arTF = new Array();
	arTF.push(new F_CodeName("T","예"));
	arTF.push(new F_CodeName("F","아니오"));
	arControlTag = new Array();
	arControlTag.push(new F_CodeName("T","통제기준레벨"));
	arControlTag.push(new F_CodeName("F","통제기준레벨아님"));
	
	fgManager = F_addFlexGrid(fg,dsMAIN,dsMAIN_D,1,"BUDG_CODE_NAME","LV","LEVEL_SEQ","BUDG_CODE_NO","P_BUDG_CODE_NO","신규예산항목");
	//항상 label column을 제일 먼저 설정해야 한다.
	fgManager.addColumn(new F_FlexGridColumnInfo("BUDG_CODE_NAME",STRING_DATA,EDITSTYLE_NORMAL,null,3600,true,null,null));
	fgManager.addColumn(new F_FlexGridColumnInfo("BUDG_CODE_NO",NUMBER_DATA,EDITSTYLE_NORMAL,null,0,false,null,null));
	fgManager.addColumn(new F_FlexGridColumnInfo("P_BUDG_CODE_NO",NUMBER_DATA,EDITSTYLE_NORMAL,null,0,false,null,null));
	fgManager.addColumn(new F_FlexGridColumnInfo("LEVEL_SEQ",NUMBER_DATA,EDITSTYLE_NORMAL,null,0,false,null,null));
	//fgManager.addColumn(new F_FlexGridColumnInfo("BUDG_ITEM_CODE",STRING_DATA,EDITSTYLE_NORMAL,null,1400,true,null,null));
	fgManager.addColumn(new F_FlexGridColumnInfo("CONTROL_LEVEL_TAG",STRING_DATA,EDITSTYLE_COMBO,null,1400,true,arTF,true));
	fgManager.addColumn(new F_FlexGridColumnInfo("USE_CLS",STRING_DATA,EDITSTYLE_COMBO,null,1400,true,arTF,true));
	fgManager.addColumn(new F_FlexGridColumnInfo("ACC_CODE",STRING_DATA,EDITSTYLE_POPUP,null,1400,true,null,true));
	fgManager.addColumn(new F_FlexGridColumnInfo("ACC_NAME",STRING_DATA,EDITSTYLE_POPUP,null,3400,true,null,true));
	fgManager.addColumn(new F_FlexGridColumnInfo("MAKE_DEPT",STRING_DATA,EDITSTYLE_POPUP,null,1400,true,null,true));
	fgManager.addColumn(new F_FlexGridColumnInfo("MAKE_DEPT_NAME",STRING_DATA,EDITSTYLE_POPUP,null,2400,true,null,true));
	fgManager.addColumn(new F_FlexGridColumnInfo("ASSIGN_TAG",NUMBER_DATA,EDITSTYLE_COMBO,null,1400,true,arTF,true));
	
	fgManager.initGrid();
	
	fg.FrozenCols = 1;
	F_setCellValue(fg,0,fgManager.getColumnIndex("BUDG_CODE_NAME"),"예산항목명");
	//F_setCellValue(fg,0,fgManager.getColumnIndex("BUDG_ITEM_CODE"),"예산항목코드");
	F_setCellValue(fg,0,fgManager.getColumnIndex("CONTROL_LEVEL_TAG"),"예산통제레벨");
	F_setCellValue(fg,0,fgManager.getColumnIndex("USE_CLS"),"사용여부");
	F_setCellValue(fg,0,fgManager.getColumnIndex("ACC_CODE"),"관련계정코드");
	F_setCellValue(fg,0,fgManager.getColumnIndex("ACC_NAME"),"관련계정명");
       F_setCellValue(fg,0,fgManager.getColumnIndex("MAKE_DEPT"),"편성부서코드");
	F_setCellValue(fg,0,fgManager.getColumnIndex("MAKE_DEPT_NAME"),"편성부서");
	F_setCellValue(fg,0,fgManager.getColumnIndex("ASSIGN_TAG"),"편성여부");
	
      
	fg.FixedAlignment(fgManager.getColumnIndex("BUDG_CODE_NAME")) = FlexAlignCenterCenter;
	//fg.FixedAlignment(fgManager.getColumnIndex("BUDG_ITEM_CODE")) = FlexAlignCenterCenter;
	fg.FixedAlignment(fgManager.getColumnIndex("CONTROL_LEVEL_TAG")) = FlexAlignCenterCenter;
	fg.FixedAlignment(fgManager.getColumnIndex("USE_CLS")) = FlexAlignCenterCenter;
	fg.FixedAlignment(fgManager.getColumnIndex("ACC_CODE")) = FlexAlignCenterCenter;
	fg.FixedAlignment(fgManager.getColumnIndex("ACC_NAME")) = FlexAlignCenterCenter;
	fg.FixedAlignment(fgManager.getColumnIndex("MAKE_DEPT")) = FlexAlignCenterCenter;
	fg.FixedAlignment(fgManager.getColumnIndex("MAKE_DEPT_NAME")) = FlexAlignCenterCenter;
	fg.FixedAlignment(fgManager.getColumnIndex("ASSIGN_TAG")) = FlexAlignCenterCenter;

	fg.ColAlignment(fgManager.getColumnIndex("BUDG_CODE_NAME")) = FlexAlignLeftCenter;
	//fg.ColAlignment(fgManager.getColumnIndex("BUDG_ITEM_CODE")) = FlexAlignCenterCenter;
	fg.ColAlignment(fgManager.getColumnIndex("CONTROL_LEVEL_TAG")) = FlexAlignCenterCenter;
	fg.ColAlignment(fgManager.getColumnIndex("USE_CLS")) = FlexAlignCenterCenter;
	fg.ColAlignment(fgManager.getColumnIndex("ACC_CODE")) = FlexAlignCenterCenter;
	fg.ColAlignment(fgManager.getColumnIndex("ACC_NAME")) = FlexAlignLeftCenter;
	fg.ColAlignment(fgManager.getColumnIndex("MAKE_DEPT")) = FlexAlignCenterCenter;
	fg.ColAlignment(fgManager.getColumnIndex("MAKE_DEPT_NAME")) = FlexAlignLeftCenter;
	fg.ColAlignment(fgManager.getColumnIndex("ASSIGN_TAG")) = FlexAlignCenterCenter;
	


	fg.focus();
	
	// 삭제해야함.
	var aa = CM_createContextMenu("TestContextMenu", fg);
	
	aa.addMenu("Menu1", "N", "조회", false);
	aa.addMenu("Menu2", "L", "", false);
	aa.addMenu("Menu3", "N", "자식추가", false);
	aa.addMenu("Menu4", "N", "형제추가", false);
	aa.addMenu("Menu5", "L", "", false);
	aa.addMenu("Menu6", "N", "삭제", false);
	aa.addMenu("Menu7", "L", "", false);
	aa.addMenu("Menu8", "N", "위로이동", false);
	aa.addMenu("Menu9", "N", "아래로이동", false);
	aa.addMenu("Menu10", "L", "", false);
	aa.addMenu("Menu11", "N", "저장", false);
	
	//CM_ContextMenuShow("TestContextMenu");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
}

// 삭제해야함.
function OnContextMenuBefore(ContextMenu, ContextMenuID, FlexGrid)
{
	if (dsMAIN.CountRow < 1)
	{
		ContextMenu.setMenu("Menu3", "N", "자식추가", true);
		ContextMenu.setMenu("Menu4", "N", "형제추가", true);
		ContextMenu.setMenu("Menu6", "N", "삭제", true);
		ContextMenu.setMenu("Menu8", "N", "위로이동", true);
		ContextMenu.setMenu("Menu9", "N", "아래로이동", true);
	}
	else
	{
		ContextMenu.setMenu("Menu3", "N", "자식추가", false);
		ContextMenu.setMenu("Menu4", "N", "형제추가", false);
		ContextMenu.setMenu("Menu6", "N", "삭제", false);
		ContextMenu.setMenu("Menu8", "N", "위로이동", false);
		ContextMenu.setMenu("Menu9", "N", "아래로이동", false);
	}
	
	return true;
}

// 삭제해야함.
function OnContextMenuAfter(ContextMenuID, MenuID, FlexGrid)
{
	if (ContextMenuID == "TestContextMenu")
	{
		if (MenuID == "Menu1")
		{
			btnquery_onclick();
		}
		else if (MenuID == "Menu3")
		{
			btnAddChild_onClick();
		}
		else if (MenuID == "Menu4")
		{
			btnAddSibling_onClick();
		}
		else if (MenuID == "Menu6")
		{
			btnDelete_onClick();
		}
		else if (MenuID == "Menu8")
		{
			btnMoveUp_onClick();
		}
		else if (MenuID == "Menu9")
		{
			btnMoveDn_onClick();
		}
		else if (MenuID == "Menu11")
		{
			btnsave_onclick();
		}
	}
}

function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//시스템명 가져오기
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
										+ D_P2("COMP_CODE",txtCOMP_CODE.value);
	}
	else if(dataset == dsMAIN_D)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN_D")
										+ D_P2("COMP_CODE",txtCOMP_CODE.value);
	}
	else if(dataset == dsBUDG_CODE_NO)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","BUDG_CODE_NO");
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
function	AddChild()
{
	if(!G_isLoaded(dsMAIN.id))
	{
		C_msgOk("먼저 조회를 수행하신 후 작업하십시오.");
		return;
	}
	fgManager.addChildInternal();
	fg.focus();
	fg.EditCell();
}
function	AddSibling()
{
	if(!G_isLoaded(dsMAIN.id))
	{
		C_msgOk("먼저 조회를 수행하신 후 작업하십시오.");
		return;
	}
	fgManager.addSiblingInternal();
	fg.focus();
	fg.EditCell();
}
function	MoveUp()
{
	if(!G_isLoaded(dsMAIN.id))
	{
		C_msgOk("먼저 조회를 수행하신 후 작업하십시오.");
		return;
	}
	if(fg.Row < fg.FixedRows || fg.Row >= fg.Rows)
	{
		C_msgOk("먼저 이동할 행을 선택하십시오.");
		return;
	}
	fgManager.moveUp();
	fg.focus();
}
function	MoveDn()
{
	if(!G_isLoaded(dsMAIN.id))
	{
		C_msgOk("먼저 조회를 수행하신 후 작업하십시오.");
		return;
	}
	if(fg.Row < fg.FixedRows || fg.Row >= fg.Rows)
	{
		C_msgOk("먼저 이동할 행을 선택하십시오.");
		return;
	}
	fgManager.moveDn();
	fg.focus();
}
function	DeleteNode()
{
	if(!G_isLoaded(dsMAIN.id))
	{
		C_msgOk("먼저 조회를 수행하신 후 작업하십시오.");
		return;
	}
	if(fg.Row < fg.FixedRows || fg.Row >= fg.Rows)
	{
		C_msgOk("먼저 삭제할 행을 선택하십시오.");
		return;
	}
	fgManager.deleteInternal();
	fg.focus();
}
function	PopAutoLovAccCode(Row,lsNewData,liDataRow,arCode)
{
	if(liDataRow < 1) return;
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", lsNewData);

	lrRet = C_AutoLov(dsLOV,"T_BUDG_REL_ACC_CODE", lrArgs,"T");
	if (lrRet != null)
	{
		dsMAIN.NameString(liDataRow,"ACC_CODE") = lrRet.get("ACC_CODE");
		dsMAIN.NameString(liDataRow,"ACC_NAME") = lrRet.get("ACC_NAME");
		F_setCellValue(fg,Row,fgManager.getColumnIndex("ACC_CODE"),lrRet.get("ACC_CODE"))
		F_setCellValue(fg,Row,fgManager.getColumnIndex("ACC_NAME"),lrRet.get("ACC_NAME"));
	}
	else
	{
		F_setCellValue(fg,Row,fgManager.getColumnIndex(arCode),dsMAIN.NameString(liDataRow,arCode));
	}
}

function	PopAutoLovMakeDept(Row,lsNewData,liDataRow,arCode)
{
	if(liDataRow < 1) return;
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("COMP_CODE", sCompCode);
	lrArgs.set("SEARCH_CONDITION", lsNewData);

	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE4", lrArgs,"T");
	if (lrRet != null)
	{
		dsMAIN.NameString(liDataRow,"MAKE_DEPT") = lrRet.get("DEPT_CODE");
		dsMAIN.NameString(liDataRow,"MAKE_DEPT_NAME") = lrRet.get("DEPT_NAME");
		F_setCellValue(fg,Row,fgManager.getColumnIndex("MAKE_DEPT"),lrRet.get("DEPT_CODE"))
		F_setCellValue(fg,Row,fgManager.getColumnIndex("MAKE_DEPT_NAME"),lrRet.get("DEPT_NAME"));
	}
	else
	{
		F_setCellValue(fg,Row,fgManager.getColumnIndex(arCode),dsMAIN.NameString(liDataRow,arCode));
	}
}

function	ProcessAfterEdit(arfg,Row,Col)
{
	if(Row < arfg.FixedRows) return;
	if(Col < arfg.FixedCols) return;
	var liDataRow = fgManager.getDataRow(Row);
	var lsNewData = F_getCellValue(arfg,Row,Col);
	if(fg == arfg)
	{
		/** 나의 테스트코드 시작
		if(Col == fgManager.getColumnIndex("BUDG_ITEM_CODE"))
		{
			if(dsMAIN.NameString(liDataRow,"BUDG_ITEM_CODE") == lsNewData) return;
			if(C_isNull(lsNewData))
			{
				dsMAIN.NameString(liDataRow,"BUDG_ITEM_CODE") = "";
				F_setCellValue(fg,Row,fgManager.getColumnIndex("BUDG_ITEM_CODE"),"(널)");
			}
			else
			{
				PopAutoLovAccCode(Row,lsNewData,liDataRow,"ACC_CODE");
			}
		}
		else
		나의 테스트코드 끝 **/
		
		if(Col == fgManager.getColumnIndex("ACC_CODE"))
		{
			if(dsMAIN.NameString(liDataRow,"ACC_CODE") == lsNewData) return;
			if(C_isNull(lsNewData))
			{
				dsMAIN.NameString(liDataRow,"ACC_CODE") = "";
				dsMAIN.NameString(liDataRow,"ACC_NAME") = "";
				F_setCellValue(fg,Row,fgManager.getColumnIndex("ACC_NAME"),"");
			}
			else
			{
				PopAutoLovAccCode(Row,lsNewData,liDataRow,"ACC_CODE");
			}
		}
		else if(Col == fgManager.getColumnIndex("ACC_NAME"))
		{
			if(dsMAIN.NameString(liDataRow,"ACC_NAME") == lsNewData) return;
			if(C_isNull(lsNewData))
			{
				dsMAIN.NameString(liDataRow,"ACC_CODE") = "";
				dsMAIN.NameString(liDataRow,"ACC_NAME") = "";
				F_setCellValue(fg,Row,fgManager.getColumnIndex("ACC_CODE"),"");
			}
			else
			{
				PopAutoLovAccCode(Row,lsNewData,liDataRow,"ACC_NAME");
			}
		}
		else if(Col == fgManager.getColumnIndex("MAKE_DEPT"))
		{
			if(dsMAIN.NameString(liDataRow,"MAKE_DEPT") == lsNewData) return;
			if(C_isNull(lsNewData))
			{
				dsMAIN.NameString(liDataRow,"MAKE_DEPT") = "";
				dsMAIN.NameString(liDataRow,"MAKE_DEPT_NAME") = "";
				F_setCellValue(fg,Row,fgManager.getColumnIndex("MAKE_DEPT_NAME"),"");
			}
			else
			{
				PopAutoLovMakeDept(Row,lsNewData,liDataRow,"MAKE_DEPT");
			}
		}
		else if(Col == fgManager.getColumnIndex("MAKE_DEPT_NAME"))
		{
			if(dsMAIN.NameString(liDataRow,"MAKE_DEPT_NAME") == lsNewData) return;
			if(C_isNull(lsNewData))
			{
				dsMAIN.NameString(liDataRow,"MAKE_DEPT") = "";
				dsMAIN.NameString(liDataRow,"MAKE_DEPT_NAME") = "";
				F_setCellValue(fg,Row,fgManager.getColumnIndex("MAKE_DEPT"),"");
			}
			else
			{
				PopAutoLovMakeDept(Row,lsNewData,liDataRow,"MAKE_DEPT_NAME");
			}
		}
	}
}

function	ProcessAfterRowColChange(arfg, OldRow, OldCol, NewRow, NewCol)
{
	if(NewRow < arfg.FixedRows) return;
	if(NewCol < arfg.FixedCols) return;
	var liDataRow = fgManager.getDataRow(NewRow);
	var lsNewData = F_getCellValue(arfg,NewRow,NewCol);

	if(fg == arfg)
	{
		dsMAIN.RowPosition = liDataRow;
		/** 나의 테스트코드 시작
		if(Col == fgManager.getColumnIndex("BUDG_ITEM_CODE"))
		{
			if(dsMAIN.NameString(liDataRow,"BUDG_ITEM_CODE") == lsNewData) return;
			if(C_isNull(lsNewData))
			{
				dsMAIN.NameString(liDataRow,"BUDG_ITEM_CODE") = "";
				F_setCellValue(fg,Row,fgManager.getColumnIndex("BUDG_ITEM_CODE"),"(널)");
			}
			else
			{
				PopAutoLovAccCode(Row,lsNewData,liDataRow,"ACC_CODE");
			}
		}
		else
		나의 테스트코드 끝 **/
		
		if(Col == fgManager.getColumnIndex("ACC_CODE"))
		{
		}
		else if(Col == fgManager.getColumnIndex("ACC_NAME"))
		{
		}
	}
}

// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	if (dsMAIN.IsUpdated || G_isChanged(dsMAIN.id)||dsMAIN_D.IsUpdated || G_isChanged(dsMAIN_D.id))
	{
		var ret = C_msgYesNoCancel("변경된 내용을 저장하시겠습니까?" , "저장");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMAIN)) return false;
		}
		else if(ret == "C")
		{
			return false;
		}
	}
	
	//자료를 읽습니다.
	if(!G_Load(dsMAIN)) return false;
	fg.focus();
}

// 추가
function btnadd_onclick()
{
	//D_defaultAdd();
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
	btnDelete_onClick();
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
}

function OnLoadCompleted(dataset, rowcnt)
{
	if(dataset == dsMAIN)
	{
		fgManager.displayData();
	}
	
}

function OnRowInsertBefore(dataset)
{
	return true;
}

function OnRowInserted(dataset, row)
{
	if(dataset == dsMAIN)
	{
		G_Load(dsBUDG_CODE_NO);
		dsMAIN.NameString(row,"BUDG_CODE_NO") = dsBUDG_CODE_NO.NameString(dsBUDG_CODE_NO.RowPosition,"BUDG_CODE_NO");
		dsMAIN.NameString(row,"USE_CLS") = "T";
		dsMAIN.NameString(row,"CONTROL_LEVEL_TAG") = "T";
		dsMAIN.NameString(row,"COMP_CODE") = txtCOMP_CODE.value;
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

function OnRowPosChanged(dataset, row)
{
	//alert(row);
}

function OnExit(dataset, grid, row, colid, olddata)
{
}

function OnPopup(dataset, grid, row, colid, data)
{
}
function OnSuccess(dataset, trans)
{
	G_Load(dsMAIN_D);
}
// 이벤트관련-------------------------------------------------------------------//
function	btnAddChild_onClick()
{
	AddChild();
}
function	btnAddSibling_onClick()
{
	AddSibling();
}
function	btnDelete_onClick()
{
	DeleteNode();
}
function	btnMoveUp_onClick()
{
	MoveUp();
}
function	btnMoveDn_onClick()
{
	MoveDn();
}
function	document_onKeyDown()
{
	if(event.altLeft && event.keyCode == 112)
	{
		AddChild();
	}
	else if(event.altLeft && event.keyCode == 113)
	{
		AddSibling();
	}
	else if(event.altLeft && event.keyCode == 38)
	{
		MoveUp();
	}
	else if(event.altLeft && event.keyCode == 40)
	{
		MoveDn();
	}
	else if(event.altLeft && event.keyCode == 68)
	{
		DeleteNode();
	}
}
function	OnCellButtonClick(arfg,Row,Col)
{
	if(Row < arfg.FixedRows) return;
	if(Col < arfg.FixedCols) return;
	if(arfg == fg && (Col == fgManager.getColumnIndex("ACC_CODE") || 
		Col == fgManager.getColumnIndex("ACC_NAME")))
	{
		var lrArgs = new C_Dictionary();
		var lrRet = null;
	
		lrArgs.set("SEARCH_CONDITION", "");
	
		lrRet = C_LOV("T_BUDG_REL_ACC_CODE", lrArgs,"F");
		if (lrRet != null)
		{
			var		liDataRow = fgManager.getDataRow(Row);
			if(liDataRow > 0)
			{
				dsMAIN.NameString(liDataRow,"ACC_CODE") = lrRet.get("ACC_CODE");
				dsMAIN.NameString(liDataRow,"ACC_NAME") = lrRet.get("ACC_NAME");
				F_setCellValue(fg,Row,fgManager.getColumnIndex("ACC_CODE"),lrRet.get("ACC_CODE"))
				F_setCellValue(fg,Row,fgManager.getColumnIndex("ACC_NAME"),lrRet.get("ACC_NAME"));
			}
		}
	}
	else if(arfg == fg && (Col == fgManager.getColumnIndex("MAKE_DEPT") || 
		Col == fgManager.getColumnIndex("MAKE_DEPT_NAME")))
	{
		var lrArgs = new C_Dictionary();
		var lrRet = null;
		
		lrArgs.set("COMP_CODE", sCompCode);
		lrArgs.set("SEARCH_CONDITION", "");
	
		lrRet = C_LOV("T_DEPT_CODE4", lrArgs,"F");
		if (lrRet != null)
		{
			var		liDataRow = fgManager.getDataRow(Row);
			if(liDataRow > 0)
			{
				dsMAIN.NameString(liDataRow,"MAKE_DEPT") = lrRet.get("DEPT_CODE");
				dsMAIN.NameString(liDataRow,"MAKE_DEPT_NAME") = lrRet.get("DEPT_NAME");
				F_setCellValue(fg,Row,fgManager.getColumnIndex("MAKE_DEPT"),lrRet.get("DEPT_CODE"))
				F_setCellValue(fg,Row,fgManager.getColumnIndex("MAKE_DEPT_NAME"),lrRet.get("DEPT_NAME"));
			}
		}
	}
}

function	OnGridAfterEdit(arfg,Row,Col)
{
	if(bEnter) return;
	bEnter = true;
	try
	{
		ProcessAfterEdit(arfg,Row,Col);
	}
	catch(e)
	{
	}
	bEnter = false;
}

function	OnGridAfterRowColChange(arfg, OldRow, OldCol, NewRow, NewCol)
{
	if(bEnter) return;
	bEnter = true;
	try
	{
		ProcessAfterRowColChange(arfg, OldRow, OldCol, NewRow, NewCol);
	}
	catch(e)
	{
	}
	bEnter = false;
}
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