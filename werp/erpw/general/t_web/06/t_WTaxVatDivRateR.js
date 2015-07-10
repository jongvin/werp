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

	G_addDataSet(dsBATCH01, transBATCH01, null, null, "�μ����");

	G_addDataSet(dsMAIN,  trans,   gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�����Ű���");
	G_addDataSet(dsSUB01, trans,  gridSUB01, sSelectPageName+D_P1("ACT","SUB01"), "�ΰ����ڷ�");

	G_addDataSet(dsWORK_NO,  null,   null, null, "WORK_NO");
	G_addDataSet(dsSEQ,  null,   null, null, "SEQ");

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	
	G_addRel(dsMAIN,dsSUB01);
	G_addRelCol(dsSUB01,"COMP_CODE","COMP_CODE");
	G_addRelCol(dsSUB01,"WORK_NO","WORK_NO");

	
	//G_setLovCol(gridSUB01,"ACC_CODE");

	G_setReadOnlyCol(gridSUB01, "CUR_DIV_RATIO");
	G_setReadOnlyCol(gridSUB01, "GONG_DIV_RATIO");
	G_setReadOnlyCol(gridSUB01, "PRE_DIV_RATIO");
	G_setReadOnlyCol(gridSUB01, "CUR_DIV_TAX_AMT");
	G_setReadOnlyCol(gridSUB01, "CUR_DIV_ACC_AMT");

	G_setLovCol(gridMAIN,"WORK_DATE");
	G_setLovCol(gridMAIN,"BASE_DT_F");
	G_setLovCol(gridMAIN,"BASE_DT_T");
	G_setLovCol(gridMAIN,"MISSING_PROCESS_DT_F");

	G_setLovCol(gridSUB01,"TAX_COMP_CODE");
	G_setLovCol(gridSUB01,"TAX_COMP_NAME");

	G_setLovCol(gridSUB01,"PUBL_DT");
	G_setLovCol(gridSUB01,"DEPT_NAME");
	G_setLovCol(gridSUB01,"CUST_NAME");

	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.
	gridMAIN.TabToss = false;
	gridSUB01.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.
	gridSUB01.TabToss = false;

	cboTAX_YEAR.value = vDate.substring(0,4);

	gridMAIN.focus();
	//btnquery_onclick();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										 + D_P2("COMP_CODE",txtCOMP_CODE.value)
										 + D_P2("TAX_YEAR",cboTAX_YEAR.value);
	}
	else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SUB01")
										 + D_P2("COMP_CODE",dsMAIN.NameString(dsMAIN.RowPosition, "COMP_CODE"))
										 + D_P2("WORK_NO",dsMAIN.NameString(dsMAIN.RowPosition, "WORK_NO"));
	}
	else if(dataset == dsWORK_NO)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","WORK_NO");
	}
	else if(dataset == dsSEQ)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SEQ");
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
//�˻�����üũ
function print_condition_check()
{
	if(dsMAIN.CountRow == 0)
	{
   		C_msgOk("�����Ű����� ���õ��� �ʾҽ��ϴ�.");
   		return false;
   	}

	return true;
}

// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
//�μ�
function btnquery_prt_onclick()
{
	// ���α׷��� ��ȿ���˻� �߰�
				
	// ���� Check
	//if (!checkCommon()) return;
	if(!print_condition_check()) return;

	var vCompCode = txtCOMP_CODE.value;
	var vCompName = txtCOMPANY_NAME.value;
	//var vWorkNo   = dsMAIN.NameString(dsMAIN.RowPosition,"WORK_NO");
	var vTaxYear	= dsMAIN.NameString(dsMAIN.RowPosition,"TAX_YEAR");
	var vTaxGi		= dsMAIN.NameString(dsMAIN.RowPosition,"TAX_GI");
	var vTaxConf	= dsMAIN.NameString(dsMAIN.RowPosition,"TAX_CONF");
	var vPublDtF	= dsMAIN.NameString(dsMAIN.RowPosition,"BASE_DT_F");
	var vPublDtT	= dsMAIN.NameString(dsMAIN.RowPosition,"BASE_DT_T");
	var vMakeDt		= vDate;

	// ���� ���丮
   	var reportFile = sReportName;
   	
	frmList.EXPORT_TAG.value = 'P';//cboExportTag.value;
	frmList.RUN_TAG.value = '1';//cboRunTag.value;
	frmList.REQUEST_NAME.value = '';//txtRequestName.value;
	frmList.REPORT_NO.value = '--';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	var strTemp = "";
	// ���α׷��� �Ķ���� �߰�
	// �Ķ����1__��1&&�Ķ����2__��2&&....
	// ����
	strTemp += "pCOMP_CODE__" + vCompCode;
	strTemp += "&&pTAX_YEAR__" + vTaxYear;
	strTemp += "&&pTAX_GI__" + vTaxGi;
	strTemp += "&&pTAX_CONF__" + vTaxConf;
	strTemp += "&&pPUBL_DT_F__" + vPublDtF
	strTemp += "&&pPUBL_DT_T__" + vPublDtT
	strTemp += "&&pMAKE_DT__" + vMakeDt
	//strTemp += "ConsultSeq__" + strConsultSeq;

	
	//alert(frmList.REPORT_FILE_NAME.value);
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}

// ��ȸ
function btnquery_onclick()
{
	D_defaultLoad();
}

// �߰�
function btnadd_onclick()
{
	C_msgOk("�� ���α׷������� �߰�/���� ����� �������� �ʽ��ϴ�.", "Ȯ��");
	return;
}

// ����
function btninsert_onclick()
{
	C_msgOk("�� ���α׷������� �߰�/���� ����� �������� �ʽ��ϴ�.", "Ȯ��");
	return;
}

// ����
function btndelete_onclick()
{
	if(G_FocusDataset==dsMAIN) {
		//D_defaultDelete();
	} else if(G_FocusDataset==dsSUB01) {
		//dsSUB01.DeleteMarked();
		G_MultiDeleteRow(dsSUB01);
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
	if (asCalendarID == "WORK_DATE")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"WORK_DATE") = asDate;
	}
	else if (asCalendarID == "BASE_DT_F")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"BASE_DT_F") = asDate;
	}
	else if (asCalendarID == "BASE_DT_T")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"BASE_DT_T") = asDate;
	}
	else if (asCalendarID == "MISSING_PROCESS_DT_F")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"MISSING_PROCESS_DT_F") = asDate;
	}
	else if (asCalendarID == "PUBL_DT")
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"PUBL_DT") = asDate;
	}
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
	}
	return true;
}

function OnRowInserted(dataset, row)
{
	var idx = 0;
	if (dataset == dsMAIN)
	{
	}
	else if(dataset == dsSUB01)
	{
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
	if(dataset == dsSUB01)
	{
		//if(dsSUB01.NameString(row,"UDT_TAG")=="O") dsSUB01.NameString(row,"UDT_TAG") = 'U';
	}
}

function OnExit(dataset, grid, row, colid, olddata)
{
	if (dataset == dsMAIN)
	{
		if( colid == "WORK_DATE" || colid == "BASE_DT_F" || colid == "BASE_DT_T" || colid == "MISSING_PROCESS_DT_F")
		{
			var		COL_DATA;
			COL_DATA = dataset.NameString(row,colid);
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
	}
	else if(dataset == dsSUB01)
	{
		if(colid == "TAX_COMP_CODE" || colid == "TAX_COMP_NAME")
		{
			var		liDataRow = row;
			var			lsNewData = dataset.NameString(row,colid);
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dsSUB01.NameString(liDataRow,"TAX_COMP_CODE") = "";
				dsSUB01.NameString(liDataRow,"TAX_COMP_NAME") = "";
				return;
			}
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("COMP_CODE", dsMAIN.NameString(liDataRow,"COMP_CODE"));
			lrArgs.set("SEARCH_CONDITION", lsNewData);
		
			lrRet = C_AutoLov(dsLOV,"T_COMP_CODE", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsSUB01.NameString(liDataRow,"TAX_COMP_CODE") = lrRet.get("COMP_CODE");
					dsSUB01.NameString(liDataRow,"TAX_COMP_NAME") = lrRet.get("COMPANY_NAME");
				}
			}
			else
			{
				dataset.NameString(liDataRow,colid) = olddata;
			}
		}
		else if( colid == "PUBL_DT" )
		{
			var		COL_DATA;
			COL_DATA = dataset.NameString(row,colid);
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
		}
		else if(colid == "DEPT_CODE" || colid == "DEPT_NAME")
		{
			var	liDataRow = row;
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("COMP_CODE", dsSUB01.NameString(liDataRow,"COMP_CODE"));
			lrArgs.set("SEARCH_CONDITION", dsSUB01.NameString(liDataRow,"DEPT_NAME"));
		
			lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE3", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsSUB01.NameString(liDataRow,"DEPT_CODE") = lrRet.get("DEPT_CODE");
					dsSUB01.NameString(liDataRow,"DEPT_NAME") = lrRet.get("DEPT_NAME");
				}
			}
		}
		else if(colid == "CUST_CODE" || colid == "CUST_NAME")
		{
			var	liDataRow = row;
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", dsSUB01.NameString(liDataRow,"CUST_NAME").replace(/-/g, ""));
		
			lrRet = C_LOV("T_CUST_CODE1", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsSUB01.NameString(liDataRow,"CUST_SEQ") = lrRet.get("CUST_SEQ");
					dsSUB01.NameString(liDataRow,"CUST_CODE") = lrRet.get("CUST_CODE");
					dsSUB01.NameString(liDataRow,"CUST_NAME") = lrRet.get("CUST_NAME");
				}
			}
		}
	}
}

function OnPopup(dataset, grid, row, colid, olddata)
{
	if (dataset == dsMAIN)
	{
		if( colid == "WORK_DATE" )
		{
			C_Calendar(colid, "D", dsMAIN.NameString(dsMAIN.RowPosition,colid));
		}
		else if( colid == "BASE_DT_F" )
		{
			C_Calendar(colid, "D", dsMAIN.NameString(dsMAIN.RowPosition,colid));
		}
		else if( colid == "BASE_DT_T" )
		{
			C_Calendar(colid, "D", dsMAIN.NameString(dsMAIN.RowPosition,colid));
		}
		else if( colid == "MISSING_PROCESS_DT_F")
		{
			C_Calendar(colid, "D", dsMAIN.NameString(dsMAIN.RowPosition,colid));
		}
	}
	else if(dataset == dsSUB01)
	{
		if(colid == "TAX_COMP_CODE" || colid == "TAX_COMP_NAME")
		{
			var	liDataRow = row;
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_COMP_CODE", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsSUB01.NameString(liDataRow,"TAX_COMP_CODE") = lrRet.get("COMP_CODE");
					dsSUB01.NameString(liDataRow,"TAX_COMP_NAME") = lrRet.get("COMPANY_NAME");
				}
			}
		}

		else if( colid == "PUBL_DT" )
		{
			C_Calendar(colid, "D", dsSUB01.NameString(dsSUB01.RowPosition,colid));
		}

		else if(colid == "DEPT_CODE" || colid == "DEPT_NAME")
		{
			var	liDataRow = row;
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("COMP_CODE", dsSUB01.NameString(liDataRow,"COMP_CODE"));
			lrArgs.set("SEARCH_CONDITION", dsSUB01.NameString(liDataRow,"DEPT_NAME"));
		
			lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE3", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsSUB01.NameString(liDataRow,"DEPT_CODE") = lrRet.get("DEPT_CODE");
					dsSUB01.NameString(liDataRow,"DEPT_NAME") = lrRet.get("DEPT_NAME");
				}
			}
		}
		else if(colid == "CUST_CODE" || colid == "CUST_NAME")
		{
			var	liDataRow = row;
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", dsSUB01.NameString(liDataRow,"CUST_NAME").replace(/-/g, ""));
		
			lrRet = C_LOV("T_CUST_CODE1", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsSUB01.NameString(liDataRow,"CUST_SEQ") = lrRet.get("CUST_SEQ");
					dsSUB01.NameString(liDataRow,"CUST_CODE") = lrRet.get("CUST_CODE");
					dsSUB01.NameString(liDataRow,"CUST_NAME") = lrRet.get("CUST_NAME");
				}
			}
		}
	}

}

function OnDuplicateColumn(dataset,grid,row,colid) {
	if(dataset == dsSUB01)
	{
		if(colid == "TAX_COMP_CODE" || colid == "TAX_COMP_NAME")
		{
			if(row>=2) {
				dsSUB01.NameString(row,"TAX_COMP_CODE") = dsSUB01.NameString(row-1,"TAX_COMP_CODE");
				dsSUB01.NameString(row,"TAX_COMP_NAME") = dsSUB01.NameString(row-1,"TAX_COMP_NAME");
			}
		}
		else if(colid == "DEPT_CODE" || colid == "DEPT_NAME")
		{
			if(row>=2) {
				dsSUB01.NameString(row,"DEPT_CODE") = dsSUB01.NameString(row-1,"DEPT_CODE");
				dsSUB01.NameString(row,"DEPT_NAME") = dsSUB01.NameString(row-1,"DEPT_NAME");
			}
		}
		else if(colid == "CUST_CODE" || colid == "CUST_NAME")
		{
			if(row>=2) {
				dsSUB01.NameString(row,"CUST_SEQ") = dsSUB01.NameString(row-1,"CUST_SEQ");
				dsSUB01.NameString(row,"CUST_CODE") = dsSUB01.NameString(row-1,"CUST_CODE");
				dsSUB01.NameString(row,"CUST_NAME") = dsSUB01.NameString(row-1,"CUST_NAME");
			}
		}
	}
}

// �̺�Ʈ����-------------------------------------------------------------------//
function	txtCOMP_CODE_onChange()
{
	gridMAIN.focus();
	btnquery_onclick();
}

function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		return;
	}
	
	if (txtCOMP_CODE.value == '%')
	{
		txtCOMPANY_NAME.value = "��ü";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}

function	CheckCompCode()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("���� ������ڵ带 �����ϼ���.", "Ȯ��");
		return false;
	}
	return true;
}

function btnBatchInput_onClick()
{
	if(dsMAIN.CountRow==0) {
		C_msgOk("�����Ű����� ���� �����ϼ���.", "Ȯ��");
		return;
	}
	if(dsSUB01.CountRow!=0) {
		var	vRet = C_msgYesNo("����Ű����� �Ⱥк��� ���⳻���� �����մϴ�. ��������ϸ� �� �����͸� ��� �����ϰ� �����մϴ�.<br>��� �����Ͻðڽ��ϱ�?", "���");
		if (vRet != "Y") return;
	}

	var vTmp = "COMP_CODE:STRING(30),WORK_NO:DECIMAL";
	dsBATCH01.ClearAll();
	dsBATCH01.SetDataHeader(vTmp);
	dsBATCH01.AddRow();
	dsBATCH01.NameString(1,"COMP_CODE") = dsMAIN.NameString(dsMAIN.RowPosition, "COMP_CODE");
	dsBATCH01.NameString(1,"WORK_NO") = dsMAIN.NameString(dsMAIN.RowPosition, "WORK_NO");

	transBATCH01.Parameters = "ACT=BATCH01";
	G_saveData(dsBATCH01);

	G_Load(dsSUB01, null);
}