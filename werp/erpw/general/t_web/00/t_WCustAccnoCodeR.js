/**************************************************************************/
/* 1. �� �� �� �� id : t_WCustAccnoCodeR.js(�ŷ�ó�����¹�ȣ)
/* 2. ����(�ó�����) : Left-Right(Master-Detail)
/* 3. ��  ��  ��  �� : �ŷ�ó �� ���¹�ȣ�� ���
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-24)
/* 5. ����  ���α׷� : ����
/* 6. Ư  ��  ��  �� : ����
/**************************************************************************/
function Initialize()
{
	
	G_addDataSet(dsMAIN, null, gridMAIN, null, "�ŷ�ó�ڵ�");
	G_addDataSet(dsLIST, trans, gridLIST, null, "�ŷ�ó�����¹�ȣ");
	G_addDataSet(dsLOV, null, null, null, "LOV");
	
	G_addRel(dsMAIN, dsLIST);
	G_addRelCol(dsLIST, "CUST_SEQ", "CUST_SEQ");
	
	gridMAIN.focus();

}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		var 	strTRADE_CLS = cboTRADE_CLS.value;
		var 	strCUST_NAME = txtCUST_NAME_S.value;
		
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("TRADE_CLS",strTRADE_CLS)
											+ D_P2("CUST_NAME",strCUST_NAME);
	}
	
	else if(dataset == dsLIST)
	{
		var 	strCUST_SEQ = dsMAIN.NameString(dsMAIN.RowPosition,"CUST_SEQ");

		dataset.DataID = sSelectPageName	+ D_P1("ACT","LIST")
											+ D_P2("CUST_SEQ",strCUST_SEQ);
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
	if(dataset == dsLIST)
	{
		dsLIST.NameString(row,"ACCNO_CLS") = "1";
		dsLIST.NameString(row,"USE_TG") = "T";
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
	if (dataset == dsLIST)
	{
		if(colid == "BANK_MAIN_NAME")
		{
			if(dsLIST.NameString(row,"BANK_MAIN_NAME")=="")
			{
				dsLIST.NameString(row,"BANK_MAIN_CODE") ="";
			}
			
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			
			lrArgs.set("SEARCH_CONDITION", dsLIST.NameString(row,"BANK_MAIN_NAME"));
			
			lrRet = C_AutoLov(dsLOV,"T_BANK_MAIN", lrArgs,"T");
			
			if (lrRet == null) return;
			
			dsLIST.NameString(row,"BANK_MAIN_CODE")	= lrRet.get("BANK_MAIN_CODE");
			dsLIST.NameString(row,"BANK_MAIN_NAME")	= lrRet.get("BANK_MAIN_NAME");
		}
	}				
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsLIST)
	{
			
		var lrArgs = new C_Dictionary();
		
		lrArgs.set("SEARCH_CONDITION", "");
		
		var lrRet = null;

		lrRet = C_LOV("T_BANK_MAIN", lrArgs);

		if (lrRet != null)
		{
			dsLIST.NameString(row,"BANK_MAIN_CODE")	= lrRet.get("BANK_MAIN_CODE");
			dsLIST.NameString(row,"BANK_MAIN_NAME")	= lrRet.get("BANK_MAIN_NAME");
		}
	}
}

// �̺�Ʈ����-------------------------------------------------------------------//


