/**************************************************************************/
/* 1. �� �� �� �� id : t_WVatCodeR(�ΰ����ڵ���)
/* 2. ����(�ó�����) : �ΰ����ڵ� ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : �ΰ����ڵ带 ��Ϲ� ��ȸ�Ѵ�.
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-10-15)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "�ΰ����������");
	G_addDataSet(dsLOV, null, null, null, "LOV");


	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	gridMAIN.focus();

}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//�ΰ����ڵ� ��������
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
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
	//D_defaultAdd();
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "�ΰ���");

	lrRet = C_LOV_NEW("T_ACC_CODE12", null, lrArgs, "T", "T");
	
	if (lrRet == null) return;

	var idx = 0;
	for (idx = 0; idx < lrRet.length; idx++)
	{
		lrArgs = lrRet[idx];
		//D_defaultAdd();
		G_addRow(dsMAIN);

		dsMAIN.NameString(dsMAIN.RowPosition,"ACC_CODE") = lrArgs.get("ACC_CODE");
		dsMAIN.NameString(dsMAIN.RowPosition,"ACC_NAME") = lrArgs.get("ACC_NAME");
	}
}

// ����
function btninsert_onclick()
{
	//D_defaultInsert();
	btnadd_onclick();
}

// ����
function btndelete_onclick()
{
	D_defaultDelete();
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
}

function OnRowInsertBefore(dataset)
{
	return true;
}

function OnRowInserted(dataset, row)
{
	if(dataset == dsMAIN)
	{
		dsMAIN.NameString(row,"RCPTBILL_CLS") = "01";
		dsMAIN.NameString(row,"SUBTR_CLS") = "1";
		dsMAIN.NameString(row,"SALEBUY_CLS") = "1";
		dsMAIN.NameString(row,"VATOCCUR_CLS") = "F";
		dsMAIN.NameString(row,"SLIP_DETAIL_LIST") = "X";
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
	if(dataset == dsMAIN)
	{
		if(colid=='ACC_CODE')
		{
			if(C_isNull(dsMAIN.NameString(row,"ACC_CODE")))
			{
				dsMAIN.NameString(row,"ACC_NAME") = "";
				return;
			}
			
			var lrArgs = new C_Dictionary();
			lrArgs.set("SEARCH_CONDITION", dsMAIN.NameString(row,"ACC_CODE"));

			var		lrRet = C_AutoLov(dsLOV,"T_ACC_CODE12",lrArgs, "T");

			if (lrRet != null)
			{
				dsMAIN.NameString(row,"ACC_CODE")	= lrRet.get("ACC_CODE");
				dsMAIN.NameString(row,"ACC_NAME")	= lrRet.get("ACC_NAME");
			}
		}
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
}

function OnPopup(dataset, grid, row, colid, data)
{
	if (dataset == dsMAIN)
	{
		if (colid == "ACC_CODE")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", dsMAIN.NameString(row,"ACC_CODE"));
		
			if (C_isNull(dsMAIN.NameString(row,"ACC_CODE")))
			{
				lrRet = C_LOV("T_ACC_CODE12", lrArgs,"F");
			}
			else
			{
				lrRet = C_LOV("T_ACC_CODE12", lrArgs,"T");
			}
			
			if (lrRet == null) return;
		
			dsMAIN.NameString(row,"ACC_CODE")	= lrRet.get("ACC_CODE");
			dsMAIN.NameString(row,"ACC_NAME")	= lrRet.get("ACC_NAME");
		}
	}
}

// �̺�Ʈ����-------------------------------------------------------------------//
