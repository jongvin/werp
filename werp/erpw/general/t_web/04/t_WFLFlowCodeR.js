/**************************************************************************/
/* 1. �� �� �� �� id : t_WFLFlowCodeR(�����ڱݼ����з��ڵ���)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-02)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
var			fgManager = null;
var			bEnter = false;
var			sAccCode = "";
var			sAccName = "";
var			sInputCls = "";
function Initialize()
{
	G_addDataSet(dsMAIN, trans, null, sSelectPageName+D_P1("ACT","MAIN"), "�����ڱݼ����ڵ�");
	G_addDataSet(dsMAIN_D, trans, null, sSelectPageName+D_P1("ACT","MAIN_D"), "�����ڱݼ����ڵ����");
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "����������ذ�������");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	G_addDataSet(dsACC_CODE, null, null, sSelectPageName+D_P1("ACT","ACC_CODE"), "ACC_CODE");
	
	G_addDataSet(dsFLOW_CODE, null, null, sSelectPageName+D_P1("ACT","FLOW_CODE"), "�����ڱݼ����ڵ��ȣ");
	G_addDataSet(dsAPPLY_SEQ, null, null, sSelectPageName+D_P1("ACT","APPLY_SEQ"), "���ð�����ȣ");
	
	
	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"FLOW_CODE","FLOW_CODE");
	
	
	fgManager = F_addFlexGrid(fg,dsMAIN,dsMAIN_D,1,"FLOW_ITEM_NAME","LV","LEVEL_SEQ","FLOW_CODE","P_NO","�ű��ڱݼ����׸�");
	//�׻� label column�� ���� ���� �����ؾ� �Ѵ�.
	fgManager.addColumn(new F_FlexGridColumnInfo("FLOW_ITEM_NAME",STRING_DATA,EDITSTYLE_NORMAL,null,3000,true,null,null));
	fgManager.addColumn(new F_FlexGridColumnInfo("MNG_CODE",STRING_DATA,EDITSTYLE_NORMAL,null,2000,true,null,null));
	fgManager.addColumn(new F_FlexGridColumnInfo("FLOW_CODE",NUMBER_DATA,EDITSTYLE_NORMAL,null,0,false,null,null));
	fgManager.addColumn(new F_FlexGridColumnInfo("P_NO",NUMBER_DATA,EDITSTYLE_NORMAL,null,0,false,null,null));
	fgManager.addColumn(new F_FlexGridColumnInfo("LEVEL_SEQ",NUMBER_DATA,EDITSTYLE_NORMAL,null,0,false,null,null));
	fgManager.addColumn(new F_FlexGridColumnInfo("FLOW_ITEM_KIND",STRING_DATA,EDITSTYLE_COMBO,null,2400,true,arTF,true));
	fgManager.addColumn(new F_FlexGridColumnInfo("DEPT_PLN_FUNC_NO",STRING_DATA,EDITSTYLE_COMBO,null,2400,true,arCODE1,true));
	fgManager.addColumn(new F_FlexGridColumnInfo("DEPT_EXE_FUNC_NO",STRING_DATA,EDITSTYLE_COMBO,null,2400,true,arCODE2,true));
	fgManager.addColumn(new F_FlexGridColumnInfo("DEPT_FOR_FUNC_NO",STRING_DATA,EDITSTYLE_COMBO,null,2400,true,arCODE3,true));
	
	fgManager.initGrid();
	
	fg.FrozenCols = 1;
	F_setCellValue(fg,0,fgManager.getColumnIndex("FLOW_ITEM_NAME"),"�ڱݼ����׸��");
	F_setCellValue(fg,0,fgManager.getColumnIndex("MNG_CODE"),"�����ڵ�");
	F_setCellValue(fg,0,fgManager.getColumnIndex("FLOW_ITEM_KIND"),"�׸񱸺�");
	F_setCellValue(fg,0,fgManager.getColumnIndex("DEPT_PLN_FUNC_NO"),"��ȹ������");
	F_setCellValue(fg,0,fgManager.getColumnIndex("DEPT_EXE_FUNC_NO"),"����������");
	F_setCellValue(fg,0,fgManager.getColumnIndex("DEPT_FOR_FUNC_NO"),"����������");
	
      
	fg.FixedAlignment(fgManager.getColumnIndex("FLOW_ITEM_NAME")) = FlexAlignCenterCenter;
	fg.FixedAlignment(fgManager.getColumnIndex("MNG_CODE")) = FlexAlignCenterCenter;
	fg.FixedAlignment(fgManager.getColumnIndex("FLOW_ITEM_KIND")) = FlexAlignCenterCenter;
	fg.FixedAlignment(fgManager.getColumnIndex("DEPT_PLN_FUNC_NO")) = FlexAlignCenterCenter;
	fg.FixedAlignment(fgManager.getColumnIndex("DEPT_EXE_FUNC_NO")) = FlexAlignCenterCenter;
	fg.FixedAlignment(fgManager.getColumnIndex("DEPT_FOR_FUNC_NO")) = FlexAlignCenterCenter;

	fg.ColAlignment(fgManager.getColumnIndex("FLOW_ITEM_NAME")) = FlexAlignLeftCenter;
	fg.ColAlignment(fgManager.getColumnIndex("MNG_CODE")) = FlexAlignLeftCenter;
	fg.ColAlignment(fgManager.getColumnIndex("FLOW_ITEM_KIND")) = FlexAlignCenterCenter;
	fg.ColAlignment(fgManager.getColumnIndex("DEPT_PLN_FUNC_NO")) = FlexAlignCenterCenter;
	fg.ColAlignment(fgManager.getColumnIndex("DEPT_EXE_FUNC_NO")) = FlexAlignCenterCenter;
	fg.ColAlignment(fgManager.getColumnIndex("DEPT_FOR_FUNC_NO")) = FlexAlignCenterCenter;


	fg.focus();
	
	G_setReadOnlyCol(gridSUB01,"ACC_CODE");
	G_setReadOnlyCol(gridSUB01,"ACC_NAME");
	G_setLovCol(gridSUB01,"SETOFF_ACC_CODE");
	G_setLovCol(gridSUB01,"SETOFF_ACC_NAME");
	
	// �����ؾ���.
	var aa = CM_createContextMenu("TestContextMenu", fg);
	
	aa.addMenu("Menu1", "N", "��ȸ", false);
	aa.addMenu("Menu2", "L", "", false);
	aa.addMenu("Menu3", "N", "�ڽ��߰�", false);
	aa.addMenu("Menu4", "N", "�����߰�", false);
	aa.addMenu("Menu5", "L", "", false);
	aa.addMenu("Menu6", "N", "����", false);
	aa.addMenu("Menu7", "L", "", false);
	aa.addMenu("Menu8", "N", "�����̵�", false);
	aa.addMenu("Menu9", "N", "�Ʒ����̵�", false);
	aa.addMenu("Menu10", "L", "", false);
	aa.addMenu("Menu11", "N", "����", false);
	
	//CM_ContextMenuShow("TestContextMenu");
	
	gridSUB01.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.
	gridSUB01.TabToss = false;
}

// �����ؾ���.
function OnContextMenuBefore(ContextMenu, ContextMenuID, FlexGrid)
{
	if (dsMAIN.CountRow < 1)
	{
		ContextMenu.setMenu("Menu3", "N", "�ڽ��߰�", true);
		ContextMenu.setMenu("Menu4", "N", "�����߰�", true);
		ContextMenu.setMenu("Menu6", "N", "����", true);
		ContextMenu.setMenu("Menu8", "N", "�����̵�", true);
		ContextMenu.setMenu("Menu9", "N", "�Ʒ����̵�", true);
	}
	else
	{
		ContextMenu.setMenu("Menu3", "N", "�ڽ��߰�", false);
		ContextMenu.setMenu("Menu4", "N", "�����߰�", false);
		ContextMenu.setMenu("Menu6", "N", "����", false);
		ContextMenu.setMenu("Menu8", "N", "�����̵�", false);
		ContextMenu.setMenu("Menu9", "N", "�Ʒ����̵�", false);
	}
	
	return true;
}

// �����ؾ���.
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
	if (dataset == dsMAIN)	//�ý��۸� ��������
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN");
	}
	else if(dataset == dsMAIN_D)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN_D");
	}
	else if(dataset == dsFLOW_CODE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","FLOW_CODE");
	}
	else if(dataset == dsAPPLY_SEQ)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","APPLY_SEQ");
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","SUB01")
											+ D_P2("FLOW_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"FLOW_CODE"));
	}
	else if(dataset == dsACC_CODE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","ACC_CODE")
											+ D_P2("ACC_CODE",sAccCode);
	}
	
}

// ���ǰ��� �Լ�----------------------------------------------------------------//
function SetSession()
{
}

function GetSession()
{
}

function ReportSession(asName, asValue)
{
}

// �Լ�����---------------------------------------------------------------------//
function	AddChild()
{
	if(!G_isLoaded(dsMAIN.id))
	{
		C_msgOk("���� ��ȸ�� �����Ͻ� �� �۾��Ͻʽÿ�.");
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
		C_msgOk("���� ��ȸ�� �����Ͻ� �� �۾��Ͻʽÿ�.");
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
		C_msgOk("���� ��ȸ�� �����Ͻ� �� �۾��Ͻʽÿ�.");
		return;
	}
	if(fg.Row < fg.FixedRows || fg.Row >= fg.Rows)
	{
		C_msgOk("���� �̵��� ���� �����Ͻʽÿ�.");
		return;
	}
	fgManager.moveUp();
	fg.focus();
}
function	MoveDn()
{
	if(!G_isLoaded(dsMAIN.id))
	{
		C_msgOk("���� ��ȸ�� �����Ͻ� �� �۾��Ͻʽÿ�.");
		return;
	}
	if(fg.Row < fg.FixedRows || fg.Row >= fg.Rows)
	{
		C_msgOk("���� �̵��� ���� �����Ͻʽÿ�.");
		return;
	}
	fgManager.moveDn();
	fg.focus();
}
function	DeleteNode()
{
	if(!G_isLoaded(dsMAIN.id))
	{
		C_msgOk("���� ��ȸ�� �����Ͻ� �� �۾��Ͻʽÿ�.");
		return;
	}
	if(fg.Row < fg.FixedRows || fg.Row >= fg.Rows)
	{
		C_msgOk("���� ������ ���� �����Ͻʽÿ�.");
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

// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
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
			var ret = C_msgYesNoCancel("����� ������ �����Ͻðڽ��ϱ�?" , "����");
	
			if (ret == "Y")
			{
				if(!G_saveAllData(dsMAIN)) return false;
			}
			else if(ret == "C")
			{
				return false;
			}
		}
		
		//�ڷḦ �н��ϴ�.
		if(!G_Load(dsMAIN)) return false;
		fg.focus();
	}
}

// �߰�
function btnadd_onclick()
{
	if(G_FocusDataset == dsSUB01)
	{
		ProcessAddSub();
	}
}

// ����
function btninsert_onclick()
{
	if(G_FocusDataset == dsSUB01)
	{
		ProcessAddSub();
	}
}

// ����
function btndelete_onclick()
{
	if(G_FocusDataset == dsSUB01)
	{
		D_defaultDelete();
	}
}

// ����
function btnsave_onclick()
{
	D_defaultSave(dsMAIN);
}

// ���
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//
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
		G_Load(dsFLOW_CODE);
		dsMAIN.NameString(row,"FLOW_CODE") = dsFLOW_CODE.NameString(dsFLOW_CODE.RowPosition,"FLOW_CODE");
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
			dataset.NameString(row,"SUM_MTHD_TAG") = "1";
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
// �̺�Ʈ����-------------------------------------------------------------------//
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
