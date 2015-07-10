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

	G_addDataSet(dsMAIN,  null,   null, sSelectPageName+D_P1("ACT","MAIN"), "�����Ű���");
	G_addDataSet(dsLIST02_1, null, gridLIST02_1, null, "���ݰ�꼭 �հ�ǥ");
	G_addDataSet(dsLIST02_2, null, gridLIST02_2, null, "���ݰ�꼭 �հ�ǥ ����");
	G_addDataSet(dsLIST02_3, null, gridLIST02_3, null, "���ݰ�꼭 �հ�ǥ �����հ�");

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;

	/*	
	G_addRel(dsMAIN,dsLIST02);
	G_addRelCol(dsLIST02,"COMP_CODE","COMP_CODE");
	G_addRelCol(dsLIST02,"WORK_NO","WORK_NO");

	
	G_setLovCol(gridLIST02,"ACC_CODE");

	G_setReadOnlyCol(gridLIST02, "MAKE_SLIPNOLINE");
	G_setReadOnlyCol(gridLIST02, "ACC_NAME");


	G_setLovCol(gridLIST02,"TAX_COMP_CODE");
	G_setLovCol(gridLIST02,"TAX_COMP_NAME");

	G_setLovCol(gridLIST02,"PUBL_DT");
	G_setLovCol(gridLIST02,"DEPT_NAME");
	G_setLovCol(gridLIST02,"CUST_NAME");

	gridLIST02.RejectEnterkeyOnPopupStyle = true;	//�׸��忡�� enter Ű �Է½� popup�� ���� �ʰ��Ѵ�.
	gridLIST02.TabToss = false;
	*/

	cboTAX_YEAR.value = vDate.substring(0,4);
	divMain01.style.display = "";
	//btnquery_onclick();
	G_Load(dsMAIN);
}

function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										 + D_P2("COMP_CODE",txtCOMP_CODE.value)
										 + D_P2("TAX_YEAR",cboTAX_YEAR.value);
	}
	else if (dataset == dsLIST02_1) {
		dataset.DataID = sSelectPageName + D_P1("ACT","LIST02_1")
										 + D_P2("COMP_CODE",txtCOMP_CODE.value)
										 + D_P2("TAX_YEAR",cboTAX_YEAR.value)
										 + D_P2("TAX_GI",dsMAIN.NameString(dsMAIN.RowPosition,"TAX_GI"))
										 + D_P2("TAX_CONF",dsMAIN.NameString(dsMAIN.RowPosition,"TAX_CONF"))
										 + D_P2("WRITE_DT",txtWRITE_DT.value.replace(/-/g, ""));
	}

	else if (dataset == dsLIST02_2) {
		dataset.DataID = sSelectPageName + D_P1("ACT","LIST02_2")
										 + D_P2("COMP_CODE",txtCOMP_CODE.value)
										 + D_P2("TAX_YEAR",cboTAX_YEAR.value)
										 + D_P2("TAX_GI",dsMAIN.NameString(dsMAIN.RowPosition,"TAX_GI"))
										 + D_P2("TAX_CONF",dsMAIN.NameString(dsMAIN.RowPosition,"TAX_CONF"))
										 + D_P2("WRITE_DT",txtWRITE_DT.value.replace(/-/g, ""));
	}

	else if (dataset == dsLIST02_3) {
		dataset.DataID = sSelectPageName + D_P1("ACT","LIST02_3")
										 + D_P2("COMP_CODE",txtCOMP_CODE.value)
										 + D_P2("TAX_YEAR",cboTAX_YEAR.value)
										 + D_P2("TAX_GI",dsMAIN.NameString(dsMAIN.RowPosition,"TAX_GI"))
										 + D_P2("TAX_CONF",dsMAIN.NameString(dsMAIN.RowPosition,"TAX_CONF"))
										 + D_P2("WRITE_DT",txtWRITE_DT.value.replace(/-/g, ""));
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
	if(dsLIST02.CountRow == 0)
	{
   		C_msgOk("����� ����� �����ϴ�.");
   		return false;
   	}
	var i = 0;
	var chk_cnt = 0;
	for(i=1;i<=dsLIST02.CountRow;i++){
		if(dsLIST02.NameString(i,"CHK_CLS")=="T") chk_cnt++;
	}
	if (chk_cnt!=0)
	{
		// ���õ� �׸��� ������
	} else {
		C_msgOk("���õ� �׸��� �����ϴ�.");
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

	trans.Parameters = "ACT=PRINT01";
	G_saveData(dsLIST02);
	
	var i = 0;
	for(i=1;i<=dsLIST02.CountRow;i++){
		dsLIST02.NameString(i,"CHK_CLS")="F";
	}
	dsLIST02.ResetStatus();

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
	//strTemp += "ProjCode__" + strProjCode + "&&";
	//strTemp += "ConsultSeq__" + strConsultSeq;

	
	//alert(frmList.REPORT_FILE_NAME.value);
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}
// �����ü����
function btnCrt2_onClick(){
	form1.action = sSelectPageName_c+ D_P1("COMP_CODE",txtCOMP_CODE.value)
									+ D_P2("TAX_YEAR",cboTAX_YEAR.value)
									+ D_P2("TAX_GI",dsMAIN.NameString(dsMAIN.RowPosition,"TAX_GI"))
									+ D_P2("TAX_CONF",dsMAIN.NameString(dsMAIN.RowPosition,"TAX_CONF"))
									+ D_P2("WRITE_DT",txtWRITE_DT.value.replace(/-/g, ""));
	form1.submit();
}


// ��ȸ
function btnquery_onclick()
{
	//C_msgOk("Ȯ�� �޼��� â(������ 'O'�� ����)", "Ȯ��");
	//C_msgOkCancel("Ȯ��/��� �޼��� â(������ 'O','C'�� ����)", "Ȯ��/���");
	//C_msgYesNo("��/�ƴϿ� �޼��� â(������ 'Y','N'�� ����)", "��/�ƴϿ�");
	//C_msgYesNoCancel("��/�ƴϿ�/��� �޼��� â(������ 'Y','N','C'�� ����)", "��/�ƴϿ�/���");
	G_Load(dsLIST02_1, null);
	G_Load(dsLIST02_2, null);
	G_Load(dsLIST02_3, null);
}

// �߰�
function btnadd_onclick()
{
	if(G_FocusDataset==dsMAIN) {
		if(!CheckCompCode()) return;
		if(!G_addRow(dsMAIN)) return;
		G_Load(dsWORK_NO, null);
		dsMAIN.NameString(dsMAIN.RowPosition, "COMP_CODE") = txtCOMP_CODE.value;
		dsMAIN.NameString(dsMAIN.RowPosition, "WORK_NO") = dsWORK_NO.NameString(1, "WORK_NO");
		dsMAIN.NameString(dsMAIN.RowPosition, "USE_TAG") = "T";
	} else if(G_FocusDataset==dsLIST02) {
		if(dsMAIN.CountRow==0) {
			C_msgOk("�����Ű����� ���� �����ϼ���.", "Ȯ��");
			return;
		}
		if(!G_addRow(dsLIST02)) return;
		G_Load(dsSEQ, null);
		dsLIST02.NameString(dsLIST02.RowPosition, "SEQ") = dsSEQ.NameString(1, "SEQ");
		dsLIST02.NameString(dsLIST02.RowPosition, "UDT_TAG") = "I";
	}
	else if(G_FocusDataset==dsSUB02) {
		if(dsLIST02.CountRow==0) {
			C_msgOk("�ΰ����ڷᰡ ���õ��� �ʾҽ��ϴ�.", "Ȯ��");
			return;
		}
		if(!G_addRow(dsSUB02)) return;
		dsSUB02.NameString(dsSUB02.RowPosition, "BODY_SEQ") = parseInt(dsSUB02.NameMax("BODY_SEQ",0,0))+1;
	}
}

// ����
function btninsert_onclick()
{
	btnadd_onclick();
}

// ����
function btndelete_onclick()
{
	if(G_FocusDataset==dsMAIN) {
		D_defaultDelete();
	} else if(G_FocusDataset==dsLIST02) {
		//dsLIST02.DeleteMarked();
		G_MultiDeleteRow(dsLIST02);
	} else if(G_FocusDataset==dsSUB02) {
		//dsSUB02.DeleteMarked();
		G_MultiDeleteRow(dsSUB02);
	}
}

// ����
function btnsave_onclick()
{
	D_defaultSave(dsLIST02);
}

// ���
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// ��ü����
function btnAllSelect_onClick()
{
	for(i=1;i<=dsLIST02.CountRow;i++)
	{
		dsLIST02.NameString(i,"CHK_CLS") = "T";
	}
}

// ��ü�������
function btnAllSelCancle_onClick()
{
	for(i=1;i<=dsLIST02.CountRow;i++)
	{
		dsLIST02.NameString(i,"CHK_CLS") = "F";
	}
}
// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "DT_F")
	{
		txtDT_F.value = asDate;
	}
	else if (asCalendarID == "DT_T")
	{
		txtDT_T.value = asDate;
	}
	else if (asCalendarID == "WRITE_DT")
	{
		txtWRITE_DT.value = asDate;
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
	else if(dataset == dsLIST02)
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
	else if(dataset == dsLIST02)
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
	if(dataset == dsLIST02)
	{
		//if(dsLIST02.NameString(row,"UDT_TAG")=="O") dsLIST02.NameString(row,"UDT_TAG") = 'U';
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
	else if(dataset == dsLIST02)
	{
		if(colid == "TAX_COMP_CODE" || colid == "TAX_COMP_NAME")
		{
			var		liDataRow = row;
			var			lsNewData = dataset.NameString(row,colid);
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dsLIST02.NameString(liDataRow,"TAX_COMP_CODE") = "";
				dsLIST02.NameString(liDataRow,"TAX_COMP_NAME") = "";
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
					dsLIST02.NameString(liDataRow,"TAX_COMP_CODE") = lrRet.get("COMP_CODE");
					dsLIST02.NameString(liDataRow,"TAX_COMP_NAME") = lrRet.get("COMPANY_NAME");
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
			lrArgs.set("COMP_CODE", dsLIST02.NameString(liDataRow,"COMP_CODE"));
			lrArgs.set("SEARCH_CONDITION", dsLIST02.NameString(liDataRow,"DEPT_NAME"));
		
			lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE3", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsLIST02.NameString(liDataRow,"DEPT_CODE") = lrRet.get("DEPT_CODE");
					dsLIST02.NameString(liDataRow,"DEPT_NAME") = lrRet.get("DEPT_NAME");
				}
			}
		}
		else if(colid == "CUST_CODE" || colid == "CUST_NAME")
		{
			var	liDataRow = row;
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", dsLIST02.NameString(liDataRow,"CUST_NAME").replace(/-/g, ""));
		
			lrRet = C_LOV("T_CUST_CODE1", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsLIST02.NameString(liDataRow,"CUST_SEQ") = lrRet.get("CUST_SEQ");
					dsLIST02.NameString(liDataRow,"CUST_CODE") = lrRet.get("CUST_CODE");
					dsLIST02.NameString(liDataRow,"CUST_NAME") = lrRet.get("CUST_NAME");
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
	else if(dataset == dsLIST02)
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
					dsLIST02.NameString(liDataRow,"TAX_COMP_CODE") = lrRet.get("COMP_CODE");
					dsLIST02.NameString(liDataRow,"TAX_COMP_NAME") = lrRet.get("COMPANY_NAME");
				}
			}
		}

		else if( colid == "PUBL_DT" )
		{
			C_Calendar(colid, "D", dsLIST02.NameString(dsLIST02.RowPosition,colid));
		}

		else if(colid == "DEPT_CODE" || colid == "DEPT_NAME")
		{
			var	liDataRow = row;
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("COMP_CODE", dsLIST02.NameString(liDataRow,"COMP_CODE"));
			lrArgs.set("SEARCH_CONDITION", dsLIST02.NameString(liDataRow,"DEPT_NAME"));
		
			lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE3", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsLIST02.NameString(liDataRow,"DEPT_CODE") = lrRet.get("DEPT_CODE");
					dsLIST02.NameString(liDataRow,"DEPT_NAME") = lrRet.get("DEPT_NAME");
				}
			}
		}
		else if(colid == "CUST_CODE" || colid == "CUST_NAME")
		{
			var	liDataRow = row;
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			lrArgs.set("SEARCH_CONDITION", dsLIST02.NameString(liDataRow,"CUST_NAME").replace(/-/g, ""));
		
			lrRet = C_LOV("T_CUST_CODE1", lrArgs,"T");
			if (lrRet != null)
			{
				if(liDataRow > 0)
				{
					dsLIST02.NameString(liDataRow,"CUST_SEQ") = lrRet.get("CUST_SEQ");
					dsLIST02.NameString(liDataRow,"CUST_CODE") = lrRet.get("CUST_CODE");
					dsLIST02.NameString(liDataRow,"CUST_NAME") = lrRet.get("CUST_NAME");
				}
			}
		}
	}

}

function OnDuplicateColumn(dataset,grid,row,colid) {
	if(dataset == dsLIST02)
	{
		if(colid == "TAX_COMP_CODE" || colid == "TAX_COMP_NAME")
		{
			if(row>=2) {
				dsLIST02.NameString(row,"TAX_COMP_CODE") = dsLIST02.NameString(row-1,"TAX_COMP_CODE");
				dsLIST02.NameString(row,"TAX_COMP_NAME") = dsLIST02.NameString(row-1,"TAX_COMP_NAME");
			}
		}
		else if(colid == "DEPT_CODE" || colid == "DEPT_NAME")
		{
			if(row>=2) {
				dsLIST02.NameString(row,"DEPT_CODE") = dsLIST02.NameString(row-1,"DEPT_CODE");
				dsLIST02.NameString(row,"DEPT_NAME") = dsLIST02.NameString(row-1,"DEPT_NAME");
			}
		}
		else if(colid == "CUST_CODE" || colid == "CUST_NAME")
		{
			if(row>=2) {
				dsLIST02.NameString(row,"CUST_SEQ") = dsLIST02.NameString(row-1,"CUST_SEQ");
				dsLIST02.NameString(row,"CUST_CODE") = dsLIST02.NameString(row-1,"CUST_CODE");
				dsLIST02.NameString(row,"CUST_NAME") = dsLIST02.NameString(row-1,"CUST_NAME");
			}
		}
	}
}

function OnDblClick(dataset, grid, row, colid) {
	if(dataset == dsLIST02_2)
	{
		if(dataset.NameString(row,"MAKE_COMP_CODE") == "")
		{
			C_msgOk("��ü�����׸��� ��ǥ��ȸ�� �� �� �����ϴ�.", "Ȯ��");
			return;
		}
		var pSLIP_ID        = dataset.NameString(row,"SLIP_ID");
		var pSLIP_IDSEQ     = dataset.NameString(row,"SLIP_IDSEQ");
		var pMAKE_COMP_CODE = dataset.NameString(row,"MAKE_COMP_CODE");
		var pMAKE_DT 	     = dataset.NameString(row,"MAKE_DT");
		var pMAKE_SEQ     	 = dataset.NameString(row,"MAKE_SEQ");
		var pSLIP_KIND_TAG  = dataset.NameString(row,"SLIP_KIND_TAG");
		var pREADONLY_TF    = "F";
		
		PopupOpen_AccSlipRetrieve (
			pSLIP_ID,
			pSLIP_IDSEQ,
			pMAKE_DT,
			pMAKE_SEQ,
			pSLIP_KIND_TAG,
			pMAKE_COMP_CODE,
			pREADONLY_TF
		);
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

//�ͼӺμ�
function txtDEPT_CODE_onblur()
{
	if (C_isNull(txtDEPT_CODE.value))
	{
		txtDEPT_CODE.value = '';
		txtDEPT_NAME.value = '';
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE3", lrArgs,"T");

	if (lrRet == null) {
		txtDEPT_CODE.value = txtDEPT_CODE_F.value;
		return;
	}
	
	if (txtDEPT_CODE.value == lrRet.get("DEPT_CODE")) return;
	
	txtDEPT_CODE.value = lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value = lrRet.get("DEPT_NAME");
	//dsSLIP_D.NameValue(dsSLIP_D.RowPosition, "TAX_COMP_CODE")	= lrRet.get("TAX_COMP_CODE");
	//dsSLIP_D.NameValue(dsSLIP_D.RowPosition, "TAX_COMP_NAME")	= lrRet.get("TAX_COMP_NAME");
}

function btnDEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);

	if (C_isNull(txtDEPT_CODE.value))
	{
		lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"T");
	}

	if (lrRet == null) return;
	if (txtDEPT_CODE.value == lrRet.get("DEPT_CODE")) return;
	
	txtDEPT_CODE.value = lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value = lrRet.get("DEPT_NAME");
}

function txtCUST_CODE_onblur()
{
	if (C_isNull(txtCUST_CODE.value))
	{
		txtCUST_CODE.value = '';
		txtCUST_NAME.value = '';
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCUST_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_CUST_CODE1", lrArgs,"T");

	if (lrRet == null) return;
	
	txtCUST_CODE.value = lrRet.get("CUST_CODE");
	txtCUST_NAME.value = lrRet.get("CUST_NAME");
}

function btnCUST_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCUST_CODE.value);

	if (C_isNull(txtCUST_CODE.value))
	{
		lrRet = C_LOV("T_CUST_CODE1", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_CUST_CODE1", lrArgs,"T");
	}

	if (lrRet == null) return;

	txtCUST_CODE.value = lrRet.get("CUST_CODE");
	txtCUST_NAME.value = lrRet.get("CUST_NAME");
}

function txtVAT_CODE_onblur()
{
	if (C_isNull(txtVAT_CODE.value))
	{
		txtVAT_CODE.value = '';
		txtVAT_NAME.value = '';
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtVAT_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_VAT_CODE1", lrArgs,"T");

	if (lrRet == null) return;
	
	txtVAT_CODE.value = lrRet.get("VAT_CODE");
	txtVAT_NAME.value = lrRet.get("VAT_NAME");


}

function btnVAT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtVAT_CODE.value);

	if (C_isNull(txtVAT_CODE.value))
	{
		lrRet = C_LOV("T_VAT_CODE1", lrArgs,"F");
	}
	else
	{
		lrRet = C_LOV("T_VAT_CODE1", lrArgs,"T");
	}

	if (lrRet == null) return;

	txtVAT_CODE.value = lrRet.get("VAT_CODE");
	txtVAT_NAME.value = lrRet.get("VAT_NAME");
}

function txtACC_CODE_onblur()
{
	if (C_isNull(txtACC_CODE.value))
	{
		txtACC_CODE.value = '';
		txtACC_NAME.value = '';
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtACC_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_ACC_CODE10", lrArgs,"T");

	if (lrRet == null) return;

	txtACC_CODE.value = lrRet.get("ACC_CODE");
	txtACC_NAME.value = lrRet.get("ACC_NAME");
}

function btnACC_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_ACC_CODE10", lrArgs,"T");
	
	if (lrRet == null) return;

	txtACC_CODE.value = lrRet.get("ACC_CODE");
	txtACC_NAME.value = lrRet.get("ACC_NAME");
}

function btnDT_F_onClick()
{
	C_Calendar("DT_F", "D", txtDT_F.value);
	S_nextFocus(btnDT_F);
}

function btnDT_T_onClick()
{
	C_Calendar("DT_T", "D", txtDT_T.value);
	S_nextFocus(btnDT_T);
}

function btnWRITE_DT_onClick()
{
	C_Calendar("WRITE_DT", "D", txtWRITE_DT.value);
	S_nextFocus(btnWRITE_DT);
}
