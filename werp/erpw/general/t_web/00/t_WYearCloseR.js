/**************************************************************************/
/* 1. �� �� �� �� id : t_WYearCloseR.js(ȸ����)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : ȸ�� ���, ��ȸ 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-25)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, null, gridMAIN, null, "�������");
	G_addDataSet(dsLIST, trans, gridLIST, null, "ȸ����");
	
	G_addRel(dsMAIN, dsLIST);
	G_addRelCol(dsLIST, "COMP_CODE", "COMP_CODE");
	
	gridLIST.RejectEnterkeyOnPopupStyle = true;
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
	}
	else if(dataset == dsLIST)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","LIST")
											+ D_P2("COMP_CODE", dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE"));
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
	D_defaultAdd();
}

// ����
function btninsert_onclick()
{
	D_defaultInsert();
}

// ����
function btndelete_onclick()
{
	D_defaultDelete();
}

// ����
function btnsave_onclick()
{
	if(dsLIST.NameString(dsLIST.RowPosition,"CLSE_CLS")=="T")
	{
		if(dsLIST.NameString(dsLIST.RowPosition,"CLSE_DT")=="")
		{
			C_msgOk("�������� �Է��ϼ���", "Ȯ��");
			return false; 
		}
	}
	D_defaultSave(dsLIST);
}

// ���
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "ACCOUNT_FDT")
	{
		dsLIST.NameString(dsLIST.RowPosition,"ACCOUNT_FDT") = asDate;
	}
	else if (asCalendarID == "ACCOUNT_EDT")
	{
		dsLIST.NameString(dsLIST.RowPosition,"ACCOUNT_EDT") = asDate;
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
	dsLIST.NameString(row,"CLSE_CLS") = "F";
	dsLIST.NameString(row,"COMP_CODE") = dsMAIN.NameString(dsMAIN.RowPosition,"COMP_CODE");
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
	if (dataset == dsLIST)
	{
		if(colid == "CLSE_CLS")
		{
			if(dsLIST.NameString(row,"CLSE_CLS")=="F")
			{
				dsLIST.NameString(row,"CLSE_DT") = ""; 
			}
			else
			{
				dsLIST.NameString(row,"CLSE_DT") = vDate;
			}
		}
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
	var COL_DATA = dsLIST.nameValue(row,colid);
	
	if (dataset == dsLIST)
	{	
		if ( colid == "CLSE_ACC_ID")
		{
			var asValue = dsLIST.NameString(dsLIST.RowPosition,"CLSE_ACC_ID");
			
			var strValue = asValue.toString();
			
			if (C_getByteLength(strValue) != 4 || !C_isNum(strValue))
			{
				ERR_MSG = "ȸ��⵵�� 4�ڸ� �����Դϴ�.";
				C_msgOk(ERR_MSG, "Ȯ��");
				return false;
			}
			
			if (parseInt(asValue) < 1900 || parseInt(asValue) >2990)
			{
				ERR_MSG = "ȸ��⵵�� 1900�⵵ ���� ũ�ų� 2999���� �۾ƾ� �մϴ�";
				C_msgOk(ERR_MSG, "Ȯ��");
				return false;
			}
		}
		else if(colid == "ACCOUNT_FDT")
		{
			if (!C_isNull(dsLIST.NameString(row,"ACCOUNT_EDT")))
			{
				if(dsLIST.NameString(row,"ACCOUNT_FDT").replace(/-/gi,"") > dsLIST.NameString(row,"ACCOUNT_EDT").replace(/-/gi,""))
				{
					C_msgOk("�������� �����Ϻ��� Ů�ϴ�.", "Ȯ��");
					dsLIST.NameString(row,colid) = olddata;
					return;
				}
			}
			
			D_defaultDateProcessInGrid(dataset, row, colid, olddata, COL_DATA);
		}
		else if(colid == "ACCOUNT_EDT")
		{
			if (!C_isNull(dsLIST.NameString(row,"ACCOUNT_EDT")))
			{
				if(dsLIST.NameString(row,"ACCOUNT_FDT").replace(/-/gi,"") > dsLIST.NameString(row,"ACCOUNT_EDT").replace(/-/gi,""))
				{
					C_msgOk("�������� �����Ϻ��� Ů�ϴ�.", "Ȯ��");
					dsLIST.NameString(row,colid) = olddata;
					return;
				}
			}
			D_defaultDateProcessInGrid(dataset, row, colid, olddata, COL_DATA);
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if (dataset == dsLIST)
	{
		if(colid == "ACCOUNT_FDT")
		{
				C_Calendar("ACCOUNT_FDT", "D", dsLIST.NameString(dsLIST.RowPosition,"ACCOUNT_FDT"));
		}
		else if(colid == "ACCOUNT_EDT")
		{
				C_Calendar("ACCOUNT_EDT", "D", dsLIST.NameString(dsLIST.RowPosition,"ACCOUNT_EDT"));		
		}
	}
}

// �̺�Ʈ����-------------------------------------------------------------------//
