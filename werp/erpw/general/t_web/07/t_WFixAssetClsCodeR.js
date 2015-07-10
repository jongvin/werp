/**************************************************************************/
/* 1. �� �� �� �� id : t_WFixAssetClsCodeR.js(�ڻ������ڵ���)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : �ڻ������ڵ���
/* 4. ��  ��  ��  �� :  ������ۼ�(2006-01-16)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�����ڻ������ڵ�");
	
	G_addDataSet(dsLOV, null, null, sSelectPageName+D_P1("ACT","LOV"), "LOV");

	
	 gridMAIN.focus();
	 G_setReadOnlyCol(gridMAIN, "ASSET_ACC_NAME");
	 D_defaultLoad();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
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
	D_defaultAdd();
}

// ����
function btninsert_onclick()
{
	D_defaultAdd();
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
		//�����ڻ����
		if ( colid == "ASSET_ACC_NAME")
		{
			if (C_isNull(dataset.NameValue(row, "ASSET_ACC_NAME")))
			dataset.NameValue(row, "ASSET_ACC_CODE")	= "";	
		}
		//�ڻ����-�����󰢴���� ����
		else if ( colid == "SUM_ACC_NAME")
		{

			if (C_isNull(dataset.NameValue(row, "SUM_ACC_NAME")))
			dataset.NameValue(row, "SUM_ACC_CODE")	= "";
				
		}
		//���úΰ��� ����
		else if ( colid == "VAT_ACC_NAME")
		{
			if (C_isNull(dataset.NameValue(row, "VAT_ACC_NAME")))
			dataset.NameValue(row, "VAT_ACC_CODE")	= "";
				
		}
		//�ں�������ΰ�������
		else if ( colid == "CAP_EXP_VAT_ACC_NAME")
		{
			if (C_isNull(dataset.NameValue(row, "CAP_EXP_VAT_ACC_NAME")))
			dataset.NameValue(row, "CAP_EXP_VAT_ACC_CODE")	= "";
				
		}
		//�ں��� �������
		else if ( colid == "CAP_EXP_ACC_NAME")
		{
			if (C_isNull(dataset.NameValue(row, "CAP_EXP_ACC_NAME")))
			dataset.NameValue(row, "CAP_EXP_ACC_CODE")	= "";
				
		}
		//�Ű�����
		else if ( colid == "SELL_ACC_NAME")
		{
			if (C_isNull(dataset.NameValue(row, "SELL_ACC_NAME")))
			dataset.NameValue(row, "SELL_ACC_CODE")	="";
		}
		//��� ����
		else if ( colid == "TRA_ACC_NAME")
		{
			if (C_isNull(dataset.NameValue(row, "TRA_ACC_NAME")))
			dataset.NameValue(row, "TRA_ACC_CODE")	="";				
		}
		//���Ͱ���
		else if ( colid == "SELL_PORF_ACC_NAME")
		{
			if (C_isNull(dataset.NameValue(row, "SELL_PORF_ACC_NAME")))
			dataset.NameValue(row, "SELL_PORF_ACC_CODE")	= "";
		}
		//���Ͱ���
		else if ( colid == "SELL_LOSS_ACC_NAME")
		{
			if (C_isNull(dataset.NameValue(row, "SELL_LOSS_ACC_NAME")))
			dataset.NameValue(row, "SELL_LOSS_ACC_CODE")	="";
		}
		//���Ͱ���
		else if ( colid == "APPR_PROF_ACC_NAME")
		{
			if (C_isNull(dataset.NameValue(row, "APPR_PROF_ACC_NAME")))
			dataset.NameValue(row, "APPR_PROF_ACC_CODE")	= "";
		}
		//���Ͱ���
		else if ( colid == "APPR_LOSS_ACC_NAME")
		{
			if (C_isNull(dataset.NameValue(row, "APPR_PROF_ACC_NAME")))
			dataset.NameValue(row, "APPR_LOSS_ACC_CODE")	="";
		}
		
	}
}

function OnRowPosChanged(dataset, row)
{
	if (dataset == dsMAIN)
	{
		oldData = dataset.NameValue(row, "ASSET_ACC_CODE");	
	}
}
function OnExit(dataset, grid, row, colid, olddata)
{
	if (dataset == dsMAIN)
	{
		if ( colid == "ASSET_ACC_CODE")
		{
			if ( C_isNull(dataset.NameValue(row, "ASSET_ACC_CODE")))
			{
				dataset.NameValue(row, "ASSET_ACC_NAME") = "";
			}
			else
			{
				var lrArgs = new C_Dictionary();
				var lrRet = null;
			
				
				
				lrArgs.set("SEARCH_CONDITION", dataset.NameValue(row, "ASSET_ACC_CODE"));
				lrRet = C_AutoLov(dsLOV,"T_ACC_CODE3", lrArgs,"T");
				
				if (lrRet == null) 
				{
					dataset.NameValue(row, "ASSET_ACC_CODE") = oldData;
					
					return;
				}
				
				dataset.NameValue(row, "ASSET_ACC_CODE")	= lrRet.get("ACC_CODE");
				dataset.NameValue(row, "ASSET_ACC_NAME")	= lrRet.get("ACC_NAME");
			}	
		}		
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if (dataset == dsMAIN)
	{
		//�����ڻ����
		if ( colid == "ASSET_ACC_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE3", lrArgs,"F");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row, "ASSET_ACC_CODE")	= lrRet.get("ACC_CODE");
			dataset.NameValue(row, "ASSET_ACC_NAME")	= lrRet.get("ACC_NAME");
	 
		}
		//�ڻ����-�����󰢴���� ����
		else if ( colid == "SUM_ACC_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row, "SUM_ACC_CODE")	= lrRet.get("ACC_CODE");
			dataset.NameValue(row, "SUM_ACC_NAME")	= lrRet.get("ACC_NAME");
				
		}
		//���úΰ��� ����
		else if ( colid == "VAT_ACC_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE10", lrArgs,"F");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row, "VAT_ACC_CODE")	= lrRet.get("ACC_CODE");
			dataset.NameValue(row, "VAT_ACC_NAME")	= lrRet.get("ACC_NAME");
				
		}
		//�ں�������ΰ�������
		else if ( colid == "CAP_EXP_VAT_ACC_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE10", lrArgs,"F");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row, "CAP_EXP_VAT_ACC_CODE")	= lrRet.get("ACC_CODE");
			dataset.NameValue(row, "CAP_EXP_VAT_ACC_NAME")	= lrRet.get("ACC_NAME");
				
		}
		//�ں��� �������
		else if ( colid == "CAP_EXP_ACC_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row, "CAP_EXP_ACC_CODE")	= lrRet.get("ACC_CODE");
			dataset.NameValue(row, "CAP_EXP_ACC_NAME")	= lrRet.get("ACC_NAME");
				
		}
		//�Ű�����
		else if ( colid == "SELL_ACC_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row, "SELL_ACC_CODE")	= lrRet.get("ACC_CODE");
			dataset.NameValue(row, "SELL_ACC_NAME")	= lrRet.get("ACC_NAME");
				
		}
		//�Ű��ΰ�������
		else if ( colid == "SELL_VAT_ACC_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE10", lrArgs,"F");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row, "SELL_VAT_ACC_CODE")	= lrRet.get("ACC_CODE");
			dataset.NameValue(row, "SELL_VAT_ACC_NAME")	= lrRet.get("ACC_NAME");
				
		}
		//��� ����
		else if ( colid == "TRA_ACC_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row, "TRA_ACC_CODE")	= lrRet.get("ACC_CODE");
			dataset.NameValue(row, "TRA_ACC_NAME")	= lrRet.get("ACC_NAME");
				
		}
		//���Ͱ���
		else if ( colid == "SELL_PORF_ACC_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row, "SELL_PORF_ACC_CODE")	= lrRet.get("ACC_CODE");
			dataset.NameValue(row, "SELL_PORF_ACC_NAME")	= lrRet.get("ACC_NAME");
			
		}
		//���Ͱ���
		else if ( colid == "SELL_LOSS_ACC_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row, "SELL_LOSS_ACC_CODE")	= lrRet.get("ACC_CODE");
			dataset.NameValue(row, "SELL_LOSS_ACC_NAME")	= lrRet.get("ACC_NAME");
			
		}
		//���Ͱ���
		else if ( colid == "APPR_PROF_ACC_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row, "APPR_PROF_ACC_CODE")	=  lrRet.get("ACC_CODE");
			dataset.NameValue(row, "APPR_PROF_ACC_NAME")	=  lrRet.get("ACC_NAME");
			
		}
		//���Ͱ���
		else if ( colid == "APPR_LOSS_ACC_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			
			lrArgs.set("SEARCH_CONDITION", "");
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row, "APPR_LOSS_ACC_CODE")	= lrRet.get("ACC_CODE");
			dataset.NameValue(row, "APPR_LOSS_ACC_NAME")	= lrRet.get("ACC_NAME");
			
		}
		
	}
}

// �̺�Ʈ����-------------------------------------------------------------------//
