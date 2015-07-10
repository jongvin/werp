/**************************************************************************/
/* 1. �� �� �� �� id : t_WWorkCodeR.js(�ڵ���ǥ�ڵ���)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-18)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsLOV,  null,   null, null, "LOV");

	G_addDataSet(dsMAIN,  trans,   gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�ڵ���ǥ�ڵ�");
	G_addDataSet(dsSUB01, trans,  gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "�����ڵ�");
	G_addDataSet(dsSUB02, trans,  gridSUB02, sSelectPageName+D_P1("ACT","SUB02"), "�ΰ����ڵ�");
	G_addDataSet(dsSUB03, trans,  gridSUB03, sSelectPageName+D_P1("ACT","SUB03"), "���������");
	G_addDataSet(dsSUB01COPY, null,  null, sSelectPageName+D_P1("ACT","SUB01"), "�����ڵ�");
	G_addDataSet(dsSUB02COPY, null,  null, sSelectPageName+D_P1("ACT","SUB02"), "�ΰ����ڵ�");
	
	
	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"WORK_CODE","WORK_CODE");

	G_addRel(dsMAIN,dsSUB02);
	G_addRelCol(dsSUB02,"WORK_CODE","WORK_CODE");
	
	G_addRel(dsMAIN,dsSUB03);
	G_addRelCol(dsSUB03,"WORK_CODE","WORK_CODE");

	G_setReadOnlyCol(gridSUB01,"COST_DEPT_KND_NAME");
	G_setReadOnlyCol(gridSUB02,"COST_DEPT_KND_NAME");
	
	G_setLovCol(gridSUB01,"ACC_CODE");
	G_setLovCol(gridSUB01,"ACC_NAME");
	G_setLovCol(gridSUB02,"VAT_CODE");
	G_setLovCol(gridSUB02,"VAT_NAME");
	G_setLovCol(gridSUB03,"CHARGE_PERS_NAME");
	G_setLovCol(gridSUB03,"CHARGE_PERS");


	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.
	gridMAIN.TabToss = false;
	gridSUB01.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.
	gridSUB01.TabToss = false;
	gridSUB02.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.
	gridSUB02.TabToss = false;
	gridSUB03.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.
	gridSUB03.TabToss = false;



	
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
										 + D_P2("WORK_CODE",dsMAIN.NameString(dsMAIN.RowPosition, "WORK_CODE"))
										 + D_P2("COST_DEPT_KND_TAG",cboCOST_DEPT_KND_TAG.value);
	}
	else if(dataset == dsSUB02)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB02")
										 + D_P2("WORK_CODE",dsMAIN.NameString(dsMAIN.RowPosition, "WORK_CODE"))
										 + D_P2("COST_DEPT_KND_TAG",cboCOST_DEPT_KND_TAG.value);
	}
	else if(dataset == dsSUB03)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB03")
										 + D_P2("WORK_CODE",dsMAIN.NameString(dsMAIN.RowPosition, "WORK_CODE"));
	}
	else if(dataset == dsSUB01COPY)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
										 + D_P2("WORK_CODE",dsMAIN.NameString(dsMAIN.RowPosition, "WORK_CODE"))
										 + D_P2("COST_DEPT_KND_TAG",cboCOST_DEPT_KND_TAG2.value);
	}
	else if(dataset == dsSUB02COPY)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB02")
										 + D_P2("WORK_CODE",dsMAIN.NameString(dsMAIN.RowPosition, "WORK_CODE"))
										 + D_P2("COST_DEPT_KND_TAG",cboCOST_DEPT_KND_TAG3.value);
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

function selectTab(index, totcount)
{
	// ���������� �̹��� ��ȯ �����Լ�
	if (!C_selectTab(index, totcount)) return;
	switch (index)
	{
		case 1:
			divTabPage1.style.display = "";
			divTabPage2.style.display = "none";
			divTabPage3.style.display = "none";
			sTab = "1";
			gridSUB01.focus();
			break;
		case 2:
			divTabPage1.style.display = "none";
			divTabPage2.style.display = "";
			divTabPage3.style.display = "none";
			sTab = "2";
			gridSUB02.focus();
			break;
		case 3:
			divTabPage1.style.display = "none";
			divTabPage2.style.display = "none";
			divTabPage3.style.display = "";
			sTab = "3";
			gridSUB03.focus();
			break;

	}
}

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
	if (dataset == dsMAIN)
	{
	}
	else if(dataset == dsSUB01)
	{
		if(cboCOST_DEPT_KND_TAG.value == '%') {
			C_msgOk("�������屸���� ���� �����ϼ���.", "Ȯ��");
			return false;
		}
	}
	else if(dataset == dsSUB02)
	{
		if(cboCOST_DEPT_KND_TAG.value == '%') {
			C_msgOk("�������屸���� ���� �����ϼ���.", "Ȯ��");
			return false;
		}
	}
	return true;
}

function OnRowInserted(dataset, row)
{
	var idx = 0;
	if (dataset == dsMAIN)
	{
		dataset.NameString(dataset.RowPosition,"SLIP_UPDATE_CLS") = "F";
	}
	else if(dataset == dsSUB01)
	{
		idx = cboCOST_DEPT_KND_TAG.options.selectedIndex;
		dataset.NameString(row,"COST_DEPT_KND_TAG") = cboCOST_DEPT_KND_TAG.options[idx].value;
		dataset.NameString(row,"COST_DEPT_KND_NAME") = cboCOST_DEPT_KND_TAG.options[idx].text;
		dataset.NameString(row,"USE_TAG") = 'T';
		dataset.NameString(row,"SEQ") = dataset.NameMax("SEQ",0,0)+1;
	}
	else if(dataset == dsSUB02)
	{
		idx = cboCOST_DEPT_KND_TAG.options.selectedIndex;
		dataset.NameString(row,"COST_DEPT_KND_TAG") = cboCOST_DEPT_KND_TAG.options[idx].value;
		dataset.NameString(row,"COST_DEPT_KND_NAME") = cboCOST_DEPT_KND_TAG.options[idx].text;
		dataset.NameString(row,"USE_TAG") = 'T';
		dataset.NameString(row,"SEQ") = dataset.NameMax("SEQ",0,0)+1;
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
	if (dataset == dsMAIN)
	{
	}
	else if(dataset == dsSUB01)
	{
		if (colid == "ACC_CODE")
		{
			var			lsNewData = dataset.NameString(row,colid);
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_ACC_CODE1", lrArgs,"T");
			
			if (lrRet == null) return;
		
			dataset.NameValue(row,"ACC_CODE")	= lrRet.get("ACC_CODE");
			dataset.NameValue(row,"ACC_NAME")	= lrRet.get("ACC_NAME");
			dataset.NameValue(row,"SUMMARY_CODE")	= "";
			dataset.NameValue(row,"SUMMARY1") = "";
		}
		else if (colid == "ACC_NAME")
		{
			var			lsNewData = dataset.NameString(row,colid);
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_ACC_CODE1", lrArgs,"T");
			
			if (lrRet == null) return;
		
			dataset.NameValue(row,"ACC_CODE")	= lrRet.get("ACC_CODE");
			dataset.NameValue(row,"ACC_NAME")	= lrRet.get("ACC_NAME");
			dataset.NameValue(row,"SUMMARY_CODE")	= "";
			dataset.NameValue(row,"SUMMARY1") = "";
		}
		else if (colid == "SUMMARY_CODE")
		{
			var			lsNewData = dataset.NameString(row,colid);
			//if(!chkAccCode()) return false;
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("ACC_CODE", dataset.NameValue(row,"ACC_CODE"));
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov("T_SUMMARY_CODE", lrArgs,"T");
			
			if (lrRet == null) return;
		
			dataset.NameValue(row,"SUMMARY_CODE")	= lrRet.get("SUMMARY_CODE");
			dataset.NameValue(row,"SUMMARY1")	= lrRet.get("SUMMARY_NAME");
		}
	}
	else if(dataset == dsSUB02)
	{
		if (colid == "VAT_CODE" || colid == "VAT_NAME")
		{
			var			lsNewData = dataset.NameString(row,colid);
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_VAT_CODE1", lrArgs,"T");
			
			if (lrRet == null) return;
		
			dataset.NameValue(row,"VAT_CODE")	= lrRet.get("VAT_CODE");
			dataset.NameValue(row,"VAT_NAME")	= lrRet.get("VAT_NAME");
		}	
	}
	else if(dataset == dsSUB03)
	{
		if (colid == "CHARGE_PERS_NAME" || colid == "CHARGE_PERS")
		{
			//�������
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			
			lrArgs.set("COMP_CODE", "");
			lrArgs.set("SEARCH_CONDITION", dataset.NameString(row,colid));
			
			lrRet = C_AutoLov(dsLOV,"Z_AUTHORITY_USER01", lrArgs,"T");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row,"CHARGE_PERS") = lrRet.get("EMPNO");
			dataset.NameValue(row,"CHARGE_PERS_NAME") = lrRet.get("NAME");
		}
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if(dataset == dsSUB01)
	{
		if (colid == "ACC_CODE" || colid == "ACC_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			
			if (lrRet == null) return;
		
			dataset.NameValue(row,"ACC_CODE")	= lrRet.get("ACC_CODE");
			dataset.NameValue(row,"ACC_NAME")	= lrRet.get("ACC_NAME");
			dataset.NameValue(row,"SUMMARY_CODE")	= "";
			dataset.NameValue(row,"SUMMARY1") = "";
		}
		
		else if (colid == "SUMMARY_CODE")
		{
			//if(!chkAccCode()) return false;
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("ACC_CODE", dataset.NameValue(row,"ACC_CODE"));
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_SUMMARY_CODE", lrArgs,"T");
			
			if (lrRet == null) return;
		
			dataset.NameValue(row,"SUMMARY_CODE")	= lrRet.get("SUMMARY_CODE");
			dataset.NameValue(row,"SUMMARY1")	= lrRet.get("SUMMARY_NAME");
		}
	}
	else if(dataset == dsSUB02)
	{
		if (colid == "VAT_CODE" || colid == "VAT_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_VAT_CODE1", lrArgs,"F");
			
			if (lrRet == null) return;
		
			dataset.NameValue(row,"VAT_CODE")	= lrRet.get("VAT_CODE");
			dataset.NameValue(row,"VAT_NAME")	= lrRet.get("VAT_NAME");
		}	
	}
	else if (dataset == dsSUB03)
	{
		if (colid == "CHARGE_PERS_NAME" || colid == "CHARGE_PERS")
		{
			//�������
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			
			lrArgs.set("COMP_CODE", "");
			lrArgs.set("SEARCH_CONDITION", "");
			
			lrRet = C_LOV("Z_AUTHORITY_USER01", lrArgs,"F");
			
			if (lrRet == null) return;
			
			dataset.NameValue(row,"CHARGE_PERS") = lrRet.get("EMPNO");
			dataset.NameValue(row,"CHARGE_PERS_NAME") = lrRet.get("NAME");
		}
	}

}

function OnDuplicateColumn(dataset,grid,row,colid)
{
	if(dataset == dsMAIN)
	{
		if(colid == "CHARGE_PERS" || colid == "CHARGE_PERS_NAME")
		{
			if(row>=2) {
				dsMAIN.NameString(row,"CHARGE_PERS") = dsMAIN.NameString(row-1,"CHARGE_PERS");
				dsMAIN.NameString(row,"CHARGE_PERS_NAME") = dsMAIN.NameString(row-1,"CHARGE_PERS_NAME");
			}
		}
	}
	else if(dataset == dsSUB02)
	{
		if(colid == "ACC_CODE" || colid == "ACC_NAME")
		{
			if(row>=2) {
				dataset.NameString(row,"ACC_CODE") = dataset.NameString(row-1,"ACC_CODE");
				dataset.NameString(row,"ACC_NAME") = dataset.NameString(row-1,"ACC_NAME");
			}
		}
	}
	else if(dataset == dsSUB02)
	{
		if(colid == "VAT_CODE" || colid == "VAT_NAME")
		{
			if(row>=2) {
				dataset.NameString(row,"VAT_CODE") = dataset.NameString(row-1,"VAT_CODE");
				dataset.NameString(row,"VAT_NAME") = dataset.NameString(row-1,"VAT_NAME");
			}
		}
	}
	else if(dataset == dsSUB03)
	{
		if(colid == "CHARGE_PERS" || colid == "CHARGE_PERS_NAME")
		{
			if(row>=2) {
				dataset.NameString(row,"CHARGE_PERS") = dataset.NameString(row-1,"CHARGE_PERS");
				dataset.NameString(row,"CHARGE_PERS_NAME") = dataset.NameString(row-1,"CHARGE_PERS_NAME");
			}
		}
	}
}

// �̺�Ʈ����-------------------------------------------------------------------//
function cboCOST_DEPT_KND_TAG_onchange() {
	G_Load(dsSUB01, null);
	G_Load(dsSUB02, null);
}
function	btnCopy1_onClick()
{
	if(cboCOST_DEPT_KND_TAG.value == '%') {
		C_msgOk("�������屸���� ���� �����ϼ���.", "Ȯ��");
		return false;
	}
	G_Load(dsSUB01COPY);
	for(var i = 1 ; i <= dsSUB01COPY.CountRow ; i ++)
	{
		var		lsAccCode = dsSUB01COPY.NameString(i,"ACC_CODE");
		if(dsSUB01.NameValueRow("ACC_CODE",lsAccCode) < 1)
		{
			G_addRow(dsSUB01);
			dsSUB01.NameString(dsSUB01.RowPosition,"ACC_CODE") = dsSUB01COPY.NameString(i,"ACC_CODE");
			dsSUB01.NameString(dsSUB01.RowPosition,"ACC_NAME") = dsSUB01COPY.NameString(i,"ACC_NAME");
			dsSUB01.NameString(dsSUB01.RowPosition,"ACC_POSITION") = dsSUB01COPY.NameString(i,"ACC_POSITION");
			dsSUB01.NameString(dsSUB01.RowPosition,"SUMMARY_CODE") = dsSUB01COPY.NameString(i,"SUMMARY_CODE");
			dsSUB01.NameString(dsSUB01.RowPosition,"SUMMARY1") = dsSUB01COPY.NameString(i,"SUMMARY1");
			dsSUB01.NameString(dsSUB01.RowPosition,"SUMMARY2") = dsSUB01COPY.NameString(i,"SUMMARY2");
			dsSUB01.NameString(dsSUB01.RowPosition,"VAT_CODE") = dsSUB01COPY.NameString(i,"VAT_CODE");
			dsSUB01.NameString(dsSUB01.RowPosition,"SEQ") = dsSUB01COPY.NameString(i,"SEQ");
			dsSUB01.NameString(dsSUB01.RowPosition,"USE_TAG") = dsSUB01COPY.NameString(i,"USE_TAG");
		}
	}
}
function	btnCopy2_onClick()
{
	if(cboCOST_DEPT_KND_TAG.value == '%') {
		C_msgOk("�������屸���� ���� �����ϼ���.", "Ȯ��");
		return false;
	}
	G_Load(dsSUB02COPY);
	for(var i = 1 ; i <= dsSUB02COPY.CountRow ; i ++)
	{
		var		lsAccCode = dsSUB02COPY.NameString(i,"ACC_CODE");
		if(dsSUB02.NameValueRow("ACC_CODE",lsAccCode) < 1)
		{
			G_addRow(dsSUB02);
			dsSUB02.NameString(dsSUB02.RowPosition,"VAT_CODE") = dsSUB02COPY.NameString(i,"VAT_CODE");
			dsSUB02.NameString(dsSUB02.RowPosition,"VAT_NAME") = dsSUB02COPY.NameString(i,"VAT_NAME");
			dsSUB02.NameString(dsSUB02.RowPosition,"SEQ") = dsSUB02COPY.NameString(i,"SEQ");
			dsSUB02.NameString(dsSUB02.RowPosition,"USE_TAG") = dsSUB02COPY.NameString(i,"USE_TAG");
		}
	}
}
