/**************************************************************************/
/* 1. �� �� �� �� id : t_WBudgDeptMapR(�������μ���������)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-21)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
var			fgManager = null;
var			arTF = null;
var			arControlTag = null;
var			bEnter = false;
function Initialize()
{
	G_addDataSet(dsMAIN, trans, null, sSelectPageName+D_P1("ACT","MAIN"), "�����ڵ���");
	G_addDataSet(dsMAIN_D, trans, null, sSelectPageName+D_P1("ACT","MAIN_D"), "�����ڵ��ϻ���");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	G_addDataSet(dsBUDG_CODE_NO, null, null, sSelectPageName+D_P1("ACT","BUDG_CODE_NO"), "�����׸��ȣ");
	
	arTF = new Array();
	arTF.push(new F_CodeName("T","��"));
	arTF.push(new F_CodeName("F","�ƴϿ�"));
	arControlTag = new Array();
	arControlTag.push(new F_CodeName("T","�������ط���"));
	arControlTag.push(new F_CodeName("F","�������ط����ƴ�"));
	
	fgManager = F_addFlexGrid(fg,dsMAIN,dsMAIN_D,1,"BUDG_CODE_NAME","LV","LEVEL_SEQ","BUDG_CODE_NO","P_BUDG_CODE_NO","�űԿ����׸�");
	//�׻� label column�� ���� ���� �����ؾ� �Ѵ�.
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
	F_setCellValue(fg,0,fgManager.getColumnIndex("BUDG_CODE_NAME"),"�����׸��");
	//F_setCellValue(fg,0,fgManager.getColumnIndex("BUDG_ITEM_CODE"),"�����׸��ڵ�");
	F_setCellValue(fg,0,fgManager.getColumnIndex("CONTROL_LEVEL_TAG"),"������������");
	F_setCellValue(fg,0,fgManager.getColumnIndex("USE_CLS"),"��뿩��");
	F_setCellValue(fg,0,fgManager.getColumnIndex("ACC_CODE"),"���ð����ڵ�");
	F_setCellValue(fg,0,fgManager.getColumnIndex("ACC_NAME"),"���ð�����");
       F_setCellValue(fg,0,fgManager.getColumnIndex("MAKE_DEPT"),"���μ��ڵ�");
	F_setCellValue(fg,0,fgManager.getColumnIndex("MAKE_DEPT_NAME"),"���μ�");
	F_setCellValue(fg,0,fgManager.getColumnIndex("ASSIGN_TAG"),"������");
	
      
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
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
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
	if (dataset == dsMAIN)	//�ý��۸� ��������
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
	fg.focus();
	fg.EditCell();
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
		/** ���� �׽�Ʈ�ڵ� ����
		if(Col == fgManager.getColumnIndex("BUDG_ITEM_CODE"))
		{
			if(dsMAIN.NameString(liDataRow,"BUDG_ITEM_CODE") == lsNewData) return;
			if(C_isNull(lsNewData))
			{
				dsMAIN.NameString(liDataRow,"BUDG_ITEM_CODE") = "";
				F_setCellValue(fg,Row,fgManager.getColumnIndex("BUDG_ITEM_CODE"),"(��)");
			}
			else
			{
				PopAutoLovAccCode(Row,lsNewData,liDataRow,"ACC_CODE");
			}
		}
		else
		���� �׽�Ʈ�ڵ� �� **/
		
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
		/** ���� �׽�Ʈ�ڵ� ����
		if(Col == fgManager.getColumnIndex("BUDG_ITEM_CODE"))
		{
			if(dsMAIN.NameString(liDataRow,"BUDG_ITEM_CODE") == lsNewData) return;
			if(C_isNull(lsNewData))
			{
				dsMAIN.NameString(liDataRow,"BUDG_ITEM_CODE") = "";
				F_setCellValue(fg,Row,fgManager.getColumnIndex("BUDG_ITEM_CODE"),"(��)");
			}
			else
			{
				PopAutoLovAccCode(Row,lsNewData,liDataRow,"ACC_CODE");
			}
		}
		else
		���� �׽�Ʈ�ڵ� �� **/
		
		if(Col == fgManager.getColumnIndex("ACC_CODE"))
		{
		}
		else if(Col == fgManager.getColumnIndex("ACC_NAME"))
		{
		}
	}
}

// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
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

// �߰�
function btnadd_onclick()
{
	//D_defaultAdd();
}

// ����
function btninsert_onclick()
{
	//D_defaultInsert();
}

// ����
function btndelete_onclick()
{
	//D_defaultDelete();
	btnDelete_onClick();
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
// �̺�Ʈ����-------------------------------------------------------------------//
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