/**************************************************************************/
/* 1. �� �� �� �� id : t_WCostConvAccCodeR.jsp(������ü�������� ���)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ������ü�������� ��� ��ȸ
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-10) 
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "������ü��������");
	G_addDataSet(dsSUB01, trans, gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "������ü��������");
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");
	
	
	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"COST_CONV_CODE","COST_CONV_CODE");

	
	gridSUB01.RejectEnterkeyOnPopupStyle = true;
	gridMAIN.RejectEnterkeyOnPopupStyle = true;

	gridSUB01.TabToss = false;
	gridMAIN.TabToss = false;

	G_setLovCol(gridSUB01,"R_ACC_CODE");
	G_setLovCol(gridSUB01,"ACC_NAME_CONV");
	G_setLovCol(gridSUB01,"R_ACC_CODE2");
	G_setLovCol(gridSUB01,"ACC_NAME_CONV2");
	G_setLovCol(gridSUB01,"R_ACC_CODE3");
	G_setLovCol(gridSUB01,"ACC_NAME_CONV3");
	G_setLovCol(gridSUB01,"R_ACC_CODE4");
	G_setLovCol(gridSUB01,"ACC_NAME_CONV4");
	G_setLovCol(gridSUB01,"R_ACC_CODE5");
	G_setLovCol(gridSUB01,"ACC_NAME_CONV5");

	G_setLovCol(gridMAIN,"SALE_ACC_CODE");
	G_setLovCol(gridMAIN,"ACC_NAME");

	G_setReadOnlyCol(gridSUB01,"ACC_CODE");
	G_setReadOnlyCol(gridSUB01,"ACC_NAME_COST");

	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
										+ D_P2("COST_CONV_CODE",dsMAIN.NameString(dsMAIN.RowPosition,"COST_CONV_CODE"));
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

// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
	D_defaultLoad();
}

// �߰�
function btnadd_onclick()
{
	if(G_FocusDataset == dsSUB01)
	{
		var lrArgs = new C_Dictionary();
		var lrRet = null;
	
		lrArgs.set("SEARCH_CONDITION", "");
		lrArgs.set("COST_CONV_CODE", dsMAIN.NameString(dsMAIN.RowPosition,"COST_CONV_CODE"));
		
	
		lrRet = C_LOV_NEW("T_ACC_CODE15", null, lrArgs, "F", "T");
		
		if (lrRet == null) return;
	
		var idx = 0;
		for (idx = 0; idx < lrRet.length; idx++)
		{
			lrArgs = lrRet[idx];
			G_addRow(dsSUB01);
	
			dsSUB01.NameString(dsSUB01.RowPosition,"ACC_CODE") = lrArgs.get("ACC_CODE");
			dsSUB01.NameString(dsSUB01.RowPosition,"ACC_NAME_COST") = lrArgs.get("ACC_NAME");
		}
	}
	else
	{
		D_defaultAdd();
	}
}

// ����
function btninsert_onclick()
{
	if(G_FocusDataset == dsSUB01)
	{
		btnadd_onclick();
	}
	else
	{
		D_defaultInsert();
	}
}

// ����
function btndelete_onclick()
{
	D_defaultDelete();
}

// ����
function btnsave_onclick()
{
	D_defaultSave(dsSUB01);
}

// ���
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//

function OnRowInserted(dataset, row)
{
	if(dataset == dsSUB01)
	{
		if(row > 1)
		{
			dataset.NameString(row,"R_ACC_CODE") = dataset.NameString(row-1,"R_ACC_CODE");
			dataset.NameString(row,"ACC_NAME_CONV") = dataset.NameString(row-1,"ACC_NAME_CONV");
		}
	}
}

function OnColumnChanged(dataset, row, colid)
{
}

function OnExit(dataset, grid, row, colid, olddata)
{
	if(dataset == dsMAIN)
	{
		var		liDataRow = row;
		if(colid == "SALE_ACC_CODE" || colid == "ACC_NAME")
		{
			var			lsNewData = dataset.NameString(row,colid);
			var			lsTargetCode ="";
			var			lsTargetName ="";
			lsTargetCode = "SALE_ACC_CODE";
			lsTargetName = "ACC_NAME";
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dataset.NameString(liDataRow,lsTargetCode) = "";
				dataset.NameString(liDataRow,lsTargetName) = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_ACC_CODE1", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,lsTargetCode) = lrRet.get("ACC_CODE");
					dataset.NameString(liDataRow,lsTargetName) = lrRet.get("ACC_NAME");
				}
			}
			else
			{
				dataset.NameString(liDataRow,colid) = olddata;
			}
		}
	}
	else if(dataset == dsSUB01)
	{
		var		liDataRow = row;
		if(colid == "R_ACC_CODE" || colid == "ACC_NAME_CONV")
		{
			var			lsNewData = dataset.NameString(row,colid);
			var			lsTargetCode ="";
			var			lsTargetName ="";
			lsTargetCode = "R_ACC_CODE";
			lsTargetName = "ACC_NAME_CONV";
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dataset.NameString(liDataRow,lsTargetCode) = "";
				dataset.NameString(liDataRow,lsTargetName) = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_ACC_CODE1", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,lsTargetCode) = lrRet.get("ACC_CODE");
					dataset.NameString(liDataRow,lsTargetName) = lrRet.get("ACC_NAME");
				}
			}
			else
			{
				dataset.NameString(liDataRow,colid) = olddata;
			}
		}
		else if(colid == "R_ACC_CODE2" || colid == "ACC_NAME_CONV2")
		{
			var			lsNewData = dataset.NameString(row,colid);
			var			lsTargetCode ="";
			var			lsTargetName ="";
			lsTargetCode = "R_ACC_CODE2";
			lsTargetName = "ACC_NAME_CONV2";
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dataset.NameString(liDataRow,lsTargetCode) = "";
				dataset.NameString(liDataRow,lsTargetName) = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_ACC_CODE1", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,lsTargetCode) = lrRet.get("ACC_CODE");
					dataset.NameString(liDataRow,lsTargetName) = lrRet.get("ACC_NAME");
				}
			}
			else
			{
				dataset.NameString(liDataRow,colid) = olddata;
			}
		}
		else if(colid == "R_ACC_CODE3" || colid == "ACC_NAME_CONV3")
		{
			var			lsNewData = dataset.NameString(row,colid);
			var			lsTargetCode ="";
			var			lsTargetName ="";
			lsTargetCode = "R_ACC_CODE3";
			lsTargetName = "ACC_NAME_CONV3";
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dataset.NameString(liDataRow,lsTargetCode) = "";
				dataset.NameString(liDataRow,lsTargetName) = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_ACC_CODE1", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,lsTargetCode) = lrRet.get("ACC_CODE");
					dataset.NameString(liDataRow,lsTargetName) = lrRet.get("ACC_NAME");
				}
			}
			else
			{
				dataset.NameString(liDataRow,colid) = olddata;
			}
		}
		else if(colid == "R_ACC_CODE4" || colid == "ACC_NAME_CONV4")
		{
			var			lsNewData = dataset.NameString(row,colid);
			var			lsTargetCode ="";
			var			lsTargetName ="";
			lsTargetCode = "R_ACC_CODE4";
			lsTargetName = "ACC_NAME_CONV4";
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dataset.NameString(liDataRow,lsTargetCode) = "";
				dataset.NameString(liDataRow,lsTargetName) = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_ACC_CODE1", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,lsTargetCode) = lrRet.get("ACC_CODE");
					dataset.NameString(liDataRow,lsTargetName) = lrRet.get("ACC_NAME");
				}
			}
			else
			{
				dataset.NameString(liDataRow,colid) = olddata;
			}
		}
		else if(colid == "R_ACC_CODE5" || colid == "ACC_NAME_CONV5")
		{
			var			lsNewData = dataset.NameString(row,colid);
			var			lsTargetCode ="";
			var			lsTargetName ="";
			lsTargetCode = "R_ACC_CODE5";
			lsTargetName = "ACC_NAME_CONV5";
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dataset.NameString(liDataRow,lsTargetCode) = "";
				dataset.NameString(liDataRow,lsTargetName) = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_ACC_CODE1", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,lsTargetCode) = lrRet.get("ACC_CODE");
					dataset.NameString(liDataRow,lsTargetName) = lrRet.get("ACC_NAME");
				}
			}
			else
			{
				dataset.NameString(liDataRow,colid) = olddata;
			}
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsMAIN)
	{
		var		liDataRow = row;
		if(colid == "SALE_ACC_CODE" || colid == "ACC_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,"SALE_ACC_CODE") = lrRet.get("ACC_CODE");
					dataset.NameString(liDataRow,"ACC_NAME") = lrRet.get("ACC_NAME");
				}
			}
		}
	}
	else if(dataset == dsSUB01)
	{
		var		liDataRow = row;
		if(colid == "R_ACC_CODE" || colid == "ACC_NAME_CONV")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,"R_ACC_CODE") = lrRet.get("ACC_CODE");
					dataset.NameString(liDataRow,"ACC_NAME_CONV") = lrRet.get("ACC_NAME");
				}
			}
		}
		else if(colid == "R_ACC_CODE2" || colid == "ACC_NAME_CONV2")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,"R_ACC_CODE2") = lrRet.get("ACC_CODE");
					dataset.NameString(liDataRow,"ACC_NAME_CONV2") = lrRet.get("ACC_NAME");
				}
			}
		}
		else if(colid == "R_ACC_CODE3" || colid == "ACC_NAME_CONV3")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,"R_ACC_CODE3") = lrRet.get("ACC_CODE");
					dataset.NameString(liDataRow,"ACC_NAME_CONV3") = lrRet.get("ACC_NAME");
				}
			}
		}
		else if(colid == "R_ACC_CODE4" || colid == "ACC_NAME_CONV4")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,"R_ACC_CODE4") = lrRet.get("ACC_CODE");
					dataset.NameString(liDataRow,"ACC_NAME_CONV4") = lrRet.get("ACC_NAME");
				}
			}
		}
		else if(colid == "R_ACC_CODE5" || colid == "ACC_NAME_CONV5")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dataset.NameString(liDataRow,"R_ACC_CODE5") = lrRet.get("ACC_CODE");
					dataset.NameString(liDataRow,"ACC_NAME_CONV5") = lrRet.get("ACC_NAME");
				}
			}
		}
	}
}
function	OnDuplicateColumn(dataset,grid,row,colid)
{
	if(colid == "R_ACC_CODE")
	{
		dataset.NameString(row,"ACC_NAME_CONV") = dataset.NameString(row - 1,"ACC_NAME_CONV");
	}
	else if(colid == "R_ACC_CODE2")
	{
		dataset.NameString(row,"ACC_NAME_CONV2") = dataset.NameString(row - 1,"ACC_NAME_CONV2");
	}
	else if(colid == "R_ACC_CODE3")
	{
		dataset.NameString(row,"ACC_NAME_CONV3") = dataset.NameString(row - 1,"ACC_NAME_CONV3");
	}
	else if(colid == "R_ACC_CODE4")
	{
		dataset.NameString(row,"ACC_NAME_CONV4") = dataset.NameString(row - 1,"ACC_NAME_CONV4");
	}
	else if(colid == "R_ACC_CODE5")
	{
		dataset.NameString(row,"ACC_NAME_CONV5") = dataset.NameString(row - 1,"ACC_NAME_CONV5");
	}
	else if(colid == "ACC_NAME_CONV")
	{
		dataset.NameString(row,"R_ACC_CODE") = dataset.NameString(row - 1,"R_ACC_CODE");
	}
	else if(colid == "ACC_NAME_CONV2")
	{
		dataset.NameString(row,"R_ACC_CODE2") = dataset.NameString(row - 1,"R_ACC_CODE2");
	}
	else if(colid == "ACC_NAME_CONV3")
	{
		dataset.NameString(row,"R_ACC_CODE3") = dataset.NameString(row - 1,"R_ACC_CODE3");
	}
	else if(colid == "ACC_NAME_CONV4")
	{
		dataset.NameString(row,"R_ACC_CODE4") = dataset.NameString(row - 1,"R_ACC_CODE4");
	}
	else if(colid == "ACC_NAME_CONV5")
	{
		dataset.NameString(row,"R_ACC_CODE5") = dataset.NameString(row - 1,"R_ACC_CODE5");
	}
}

// �̺�Ʈ����-------------------------------------------------------------------//