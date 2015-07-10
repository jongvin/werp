/**************************************************************************/
/* 1. 프 로 그 램 id : t_WPLPlItemR(경영계획항목등록)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-27)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var			fgManager = null;
var			bEnter = false;
var			sAccCode = "";
var			sAccName = "";
var			sInputCls = "";
var			arLEVEL ;
var			arTF ;
function Initialize()
{
	arLEVEL =  new Array();
	arLEVEL.push(new F_CodeName("1","최상위레벨"));
	arLEVEL.push(new F_CodeName("2","집계조회레벨"));
	arLEVEL.push(new F_CodeName("3","상세내역레벨"));
	arTF = new Array();
	arTF.push(new F_CodeName("T","예"));
	arTF.push(new F_CodeName("F","아니오"));
	G_addDataSet(dsMAIN, trans, null, sSelectPageName+D_P1("ACT","MAIN"), "경영계획항목");
	G_addDataSet(dsMAIN_D, trans, null, sSelectPageName+D_P1("ACT","MAIN_D"), "경영계획항목삭제");
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "실적집계기준계정정의");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	G_addDataSet(dsACC_CODE, null, null, sSelectPageName+D_P1("ACT","ACC_CODE"), "ACC_CODE");
	
	G_addDataSet(dsBIZ_PLAN_ITEM_NO, null, null, sSelectPageName+D_P1("ACT","BIZ_PLAN_ITEM_NO"), "경영계획항목번호");
	G_addDataSet(dsAPPLY_SEQ, null, null, sSelectPageName+D_P1("ACT","APPLY_SEQ"), "관련계정번호");
	
	
	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"BIZ_PLAN_ITEM_NO","BIZ_PLAN_ITEM_NO");
	
	
	fgManager = F_addFlexGrid(fg,dsMAIN,dsMAIN_D,1,"BIZ_PLAN_ITEM_NAME","LV","ITEM_LEVEL_SEQ","BIZ_PLAN_ITEM_NO","P_NO","신규경영계획항목");
	//항상 label column을 제일 먼저 설정해야 한다.
	fgManager.addColumn(new F_FlexGridColumnInfo("BIZ_PLAN_ITEM_NAME",STRING_DATA,EDITSTYLE_NORMAL,null,3000,true,null,null));
	fgManager.addColumn(new F_FlexGridColumnInfo("MNG_CODE",STRING_DATA,EDITSTYLE_NORMAL,null,2000,true,null,null));
	fgManager.addColumn(new F_FlexGridColumnInfo("BIZ_PLAN_ITEM_NO",NUMBER_DATA,EDITSTYLE_NORMAL,null,0,false,null,null));
	fgManager.addColumn(new F_FlexGridColumnInfo("P_NO",NUMBER_DATA,EDITSTYLE_NORMAL,null,0,false,null,null));
	fgManager.addColumn(new F_FlexGridColumnInfo("ITEM_LEVEL_SEQ",NUMBER_DATA,EDITSTYLE_NORMAL,null,0,false,null,null));
	fgManager.addColumn(new F_FlexGridColumnInfo("ITEM_TAG",STRING_DATA,EDITSTYLE_COMBO,null,2400,true,arITEM_KIND,true));
	fgManager.addColumn(new F_FlexGridColumnInfo("LEVEL_TAG",STRING_DATA,EDITSTYLE_COMBO,null,1600,true,arLEVEL,true));
	fgManager.addColumn(new F_FlexGridColumnInfo("DEPT_TAG",STRING_DATA,EDITSTYLE_COMBO,null,1400,true,arTF,true));
	fgManager.addColumn(new F_FlexGridColumnInfo("COMP_PLN_FUNC_NO",STRING_DATA,EDITSTYLE_COMBO,null,2400,true,arCODE1,true));
	fgManager.addColumn(new F_FlexGridColumnInfo("COMP_FOR_FUNC_NO",STRING_DATA,EDITSTYLE_COMBO,null,2400,true,arCODE3,true));
	fgManager.addColumn(new F_FlexGridColumnInfo("COMP_PLN_FUNC_NO_B",STRING_DATA,EDITSTYLE_COMBO,null,2400,true,arCODE4,true));
	fgManager.addColumn(new F_FlexGridColumnInfo("COMP_EXE_FUNC_NO_B",STRING_DATA,EDITSTYLE_COMBO,null,2400,true,arCODE5,true));
	fgManager.addColumn(new F_FlexGridColumnInfo("COMP_FOR_FUNC_NO_B",STRING_DATA,EDITSTYLE_COMBO,null,2400,true,arCODE6,true));
	
	fgManager.initGrid();
	
	fg.FrozenCols = 1;
	F_setCellValue(fg,0,fgManager.getColumnIndex("BIZ_PLAN_ITEM_NAME"),"경영계획항목명");
	F_setCellValue(fg,0,fgManager.getColumnIndex("MNG_CODE"),"관리코드");
	F_setCellValue(fg,0,fgManager.getColumnIndex("ITEM_TAG"),"항목구분");
	F_setCellValue(fg,0,fgManager.getColumnIndex("LEVEL_TAG"),"레벨구분");
	F_setCellValue(fg,0,fgManager.getColumnIndex("DEPT_TAG"),"현장편성여부");
	F_setCellValue(fg,0,fgManager.getColumnIndex("COMP_PLN_FUNC_NO"),"현장계획집계방법");
	F_setCellValue(fg,0,fgManager.getColumnIndex("COMP_FOR_FUNC_NO"),"현장전망집계방법");
	F_setCellValue(fg,0,fgManager.getColumnIndex("COMP_PLN_FUNC_NO_B"),"본사계획집계방법");
	F_setCellValue(fg,0,fgManager.getColumnIndex("COMP_EXE_FUNC_NO_B"),"실적집계방법");
	F_setCellValue(fg,0,fgManager.getColumnIndex("COMP_FOR_FUNC_NO_B"),"본사전망집계방법");
	
      
	fg.FixedAlignment(fgManager.getColumnIndex("BIZ_PLAN_ITEM_NAME")) = FlexAlignCenterCenter;
	fg.FixedAlignment(fgManager.getColumnIndex("MNG_CODE")) = FlexAlignCenterCenter;
	fg.FixedAlignment(fgManager.getColumnIndex("ITEM_TAG")) = FlexAlignCenterCenter;
	fg.FixedAlignment(fgManager.getColumnIndex("LEVEL_TAG")) = FlexAlignCenterCenter;
	fg.FixedAlignment(fgManager.getColumnIndex("DEPT_TAG")) = FlexAlignCenterCenter;
	fg.FixedAlignment(fgManager.getColumnIndex("COMP_PLN_FUNC_NO")) = FlexAlignCenterCenter;
	fg.FixedAlignment(fgManager.getColumnIndex("COMP_FOR_FUNC_NO")) = FlexAlignCenterCenter;
	fg.FixedAlignment(fgManager.getColumnIndex("COMP_PLN_FUNC_NO_B")) = FlexAlignCenterCenter;
	fg.FixedAlignment(fgManager.getColumnIndex("COMP_EXE_FUNC_NO_B")) = FlexAlignCenterCenter;
	fg.FixedAlignment(fgManager.getColumnIndex("COMP_FOR_FUNC_NO_B")) = FlexAlignCenterCenter;

	fg.ColAlignment(fgManager.getColumnIndex("BIZ_PLAN_ITEM_NAME")) = FlexAlignLeftCenter;
	fg.ColAlignment(fgManager.getColumnIndex("MNG_CODE")) = FlexAlignLeftCenter;
	fg.ColAlignment(fgManager.getColumnIndex("ITEM_TAG")) = FlexAlignCenterCenter;
	fg.ColAlignment(fgManager.getColumnIndex("LEVEL_TAG")) = FlexAlignCenterCenter;
	fg.ColAlignment(fgManager.getColumnIndex("DEPT_TAG")) = FlexAlignCenterCenter;
	fg.ColAlignment(fgManager.getColumnIndex("COMP_PLN_FUNC_NO")) = FlexAlignCenterCenter;
	fg.ColAlignment(fgManager.getColumnIndex("COMP_FOR_FUNC_NO")) = FlexAlignCenterCenter;
	fg.ColAlignment(fgManager.getColumnIndex("COMP_PLN_FUNC_NO_B")) = FlexAlignCenterCenter;
	fg.ColAlignment(fgManager.getColumnIndex("COMP_EXE_FUNC_NO_B")) = FlexAlignCenterCenter;
	fg.ColAlignment(fgManager.getColumnIndex("COMP_FOR_FUNC_NO_B")) = FlexAlignCenterCenter;


	fg.focus();
	
	G_setReadOnlyCol(gridSUB01,"ACC_CODE");
	G_setReadOnlyCol(gridSUB01,"ACC_NAME");
	G_setLovCol(gridSUB01,"SETOFF_ACC_CODE");
	G_setLovCol(gridSUB01,"SETOFF_ACC_NAME");
	
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
	
	gridSUB01.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	gridSUB01.TabToss = false;
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
			btnDeleteNode_onClick();
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
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN");
	}
	else if(dataset == dsMAIN_D)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN_D");
	}
	else if(dataset == dsBIZ_PLAN_ITEM_NO)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","BIZ_PLAN_ITEM_NO");
	}
	else if(dataset == dsAPPLY_SEQ)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","APPLY_SEQ");
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","SUB01")
											+ D_P2("BIZ_PLAN_ITEM_NO",dsMAIN.NameString(dsMAIN.RowPosition,"BIZ_PLAN_ITEM_NO"));
	}
	else if(dataset == dsACC_CODE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","ACC_CODE")
											+ D_P2("ACC_CODE",sAccCode);
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
	//fg.focus();
	//fg.EditCell();
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


function	ProcessAfterEdit(arfg,Row,Col)
{
}

function	ProcessAfterRowColChange(arfg, OldRow, OldCol, NewRow, NewCol)
{
	if(NewRow != OldRow)
	{
		var		lrFgInfo = F_findGridInfo(fg);
		var		liDataRow = lrFgInfo.getDataRow(NewRow);
		dsMAIN.RowPosition = liDataRow;
		
		if(dsMAIN.RowPosition != liDataRow)
		{
			arfg.Row = OldRow;
		}
	}
}
function	ProcessAddSub()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_ACC_CODE_ALL", lrArgs,"F");
	if (lrRet != null)
	{
		sAccCode = lrRet.get("ACC_CODE");
		sAccName = lrRet.get("ACC_NAME");
		sInputCls = lrRet.get("FUND_INPUT_CLS");
		if(sInputCls == "T")
		{
			G_addRow(dsSUB01);
			return true;
		}
		else
		{
			G_Load(dsACC_CODE);
			var			liCnt = dsACC_CODE.CountRow;
			for(var i = 1 ; i <= liCnt ; ++ i)
			{
				sAccCode = dsACC_CODE.NameString(i,"ACC_CODE");
				sAccName = dsACC_CODE.NameString(i,"ACC_NAME");
				G_addRow(dsSUB01);
			}
		}
	}
}

// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	if(G_FocusDataset == dsSUB01)
	{
		D_defaultLoad();
	}
	else
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
}

// 추가
function btnadd_onclick()
{
	if(G_FocusDataset == dsSUB01)
	{
		ProcessAddSub();
	}
}

// 삽입
function btninsert_onclick()
{
	if(G_FocusDataset == dsSUB01)
	{
		ProcessAddSub();
	}
}

// 삭제
function btndelete_onclick()
{
	if(G_FocusDataset == dsSUB01)
	{
		D_defaultDelete();
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
		G_Load(dsBIZ_PLAN_ITEM_NO);
		dsMAIN.NameString(row,"BIZ_PLAN_ITEM_NO") = dsBIZ_PLAN_ITEM_NO.NameString(dsBIZ_PLAN_ITEM_NO.RowPosition,"BIZ_PLAN_ITEM_NO");
		dsMAIN.NameString(row,"USE_CLS") = "T";
		dsMAIN.NameString(row,"CONTROL_LEVEL_TAG") = "T";
	}
	else if(dataset == dsSUB01)
	{
		G_Load(dsAPPLY_SEQ);
		dataset.NameString(row,"ACC_CODE") = sAccCode;
		dataset.NameString(row,"ACC_NAME") = sAccName;
		dataset.NameString(row,"APPLY_SEQ") = dsAPPLY_SEQ.NameString(dsAPPLY_SEQ.RowPosition,"APPLY_SEQ");
		if(row == 1)
		{
			dataset.NameString(row,"SUM_MTHD_TAG") = "2";
			dataset.NameString(row,"SLIP_SUM_MTHD_TAG") = "1";
			dataset.NameString(row,"SIGN_TAG") = "P";
		}
		else
		{
			dataset.NameString(row,"SUM_MTHD_TAG") = dataset.NameString(row-1,"SUM_MTHD_TAG");
			dataset.NameString(row,"SLIP_SUM_MTHD_TAG") = dataset.NameString(row-1,"SLIP_SUM_MTHD_TAG");
			dataset.NameString(row,"SIGN_TAG") = dataset.NameString(row-1,"SIGN_TAG");
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
}

function OnRowPosChanged(dataset, row)
{
}

function OnExit(dataset, grid, row, colid, olddata)
{
	if(dataset == dsSUB01)
	{
		var		COL_DATA = dataset.NameString(row,colid);
		if(colid == "SETOFF_ACC_CODE" || colid == "SETOFF_ACC_NAME")
		{
			if(C_isNull(COL_DATA))
			{
				dataset.NameString(row,"SETOFF_ACC_CODE") = "";
				dataset.NameString(row,"SETOFF_ACC_NAME") = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", COL_DATA);
		
			lrRet = C_AutoLov(dsLOV,"T_ACC_CODE1", lrArgs,"T");
			if (lrRet != null)
			{
				dataset.NameString(row,"SETOFF_ACC_CODE") = lrRet.get("ACC_CODE");
				dataset.NameString(row,"SETOFF_ACC_NAME") = lrRet.get("ACC_NAME");
			}
			else
			{
				dataset.NameString(row,colid) = olddata;
			}
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsSUB01)
	{
		if(colid == "SETOFF_ACC_CODE" || colid == "SETOFF_ACC_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			if (lrRet != null)
			{
				dataset.NameString(row,"SETOFF_ACC_CODE") = lrRet.get("ACC_CODE");
				dataset.NameString(row,"SETOFF_ACC_NAME") = lrRet.get("ACC_NAME");
			}
		}
	}
}
function OnSuccess(dataset, trans)
{
	G_Load(dsMAIN_D);
}
function	OnDuplicateColumn(dataset,grid,row,colid)
{
	if(colid == "SETOFF_ACC_CODE")
	{
		dataset.NameString(row,"SETOFF_ACC_NAME") = dataset.NameString(row - 1,"SETOFF_ACC_NAME");
	}
	else if(colid == "SETOFF_ACC_NAME")
	{
		dataset.NameString(row,"SETOFF_ACC_CODE") = dataset.NameString(row - 1,"SETOFF_ACC_CODE");
	}
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
function	btnDeleteNode_onClick()
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
function	CopyPrev()
{
	if(fg.Row <= 1) return;
	F_setCellValue(fg,fg.Row,fg.Col,F_getCellValue(fg,fg.Row - 1,fg.Col));
	F_OnGridAfterEdit(fg,fg.Row,fg.Col);
}

function	document_onKeyDown()
{
	if(event.altLeft && event.keyCode == 112)
	{
		if(G_FocusDataset != dsSUB01)
		{
			AddChild();
		}
	}
	else if(event.altLeft && event.keyCode == 113)
	{
		if(G_FocusDataset != dsSUB01)
		{
			AddSibling();
		}
	}
	else if(event.altLeft && event.keyCode == 38)
	{
		if(G_FocusDataset != dsSUB01)
		{
			MoveUp();
		}
	}
	else if(event.altLeft && event.keyCode == 40)
	{
		if(G_FocusDataset != dsSUB01)
		{
			MoveDn();
		}
	}
	else if(event.altLeft && event.keyCode == 68)
	{
		if(G_FocusDataset != dsSUB01)
		{
			DeleteNode();
		}
	}
	else if(event.altLeft && event.keyCode == 67)
	{
		if(G_FocusDataset != dsSUB01)
		{
			CopyPrev();
		}
	}
	
}
function	OnCellButtonClick(arfg,Row,Col)
{
	if(Row < arfg.FixedRows) return;
	if(Col < arfg.FixedCols) return;
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
