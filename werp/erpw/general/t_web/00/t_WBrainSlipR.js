/**************************************************************************/
/* 1. �� �� �� �� id : t_WBrainSlipR.js(��ǥ_ǥ������_��з����)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : ��ǥ_ǥ������_��з���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-06)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "ǥ�������з�");
	G_addDataSet(dsLIST, trans, gridLIST, sSelectPageName+D_P1("ACT","LIST"), "ǥ�������ߺз�");
	G_addDataSet(dsBRAIN_SLIP_SEQ1, null, null, null, "BRAIN_SLIP_SEQ1");
	G_addDataSet(dsBRAIN_SLIP_SEQ2, null, null, null, "BRAIN_SLIP_SEQ2");
	
	G_addRel(dsMAIN, dsLIST);
	G_addRelCol(dsLIST, "BRAIN_SLIP_SEQ1", "BRAIN_SLIP_SEQ1");
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
		dataset.DataID = sSelectPageName + D_P1("ACT","LIST")
										+ D_P2("BRAIN_SLIP_SEQ1",dsMAIN.NameString(dsMAIN.RowPosition,"BRAIN_SLIP_SEQ1"));
	}
	else if(dataset == dsBRAIN_SLIP_SEQ1)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","BRAIN_SLIP_SEQ1");
	}
	else if(dataset == dsBRAIN_SLIP_SEQ2)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","BRAIN_SLIP_SEQ2");
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
	D_defaultSave(dsMAIN);
}

// ���
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}
//�μ�
function btnquery_prt_onclick()
{
	// ���α׷��� ��ȿ���˻� �߰�
				
	// ���� Check
	
       //var  vACC_GRP = cboACC_GRP.value;
   	var reportFile ="";

   	reportFile ="r_t_080050";  

	frmList.EXPORT_TAG.value =cboExportTag.value;
	frmList.RUN_TAG.value = cboRunTag.value;
	frmList.REQUEST_NAME.value = txtRequestName.value;
	frmList.REPORT_NO.value = '--';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	var strTemp = "";

	
	//strTemp += "P_ACC_GRP__" + vACC_GRP;


	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}
// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function OnRowInserted(dataset, row)
{
	if (dataset == dsMAIN)
	{
		G_Load(dsBRAIN_SLIP_SEQ1, null);
		dataset.NameString(row,"BRAIN_SLIP_SEQ1") = dsBRAIN_SLIP_SEQ1.NameString(dsBRAIN_SLIP_SEQ1.RowPosition,"BRAIN_SLIP_SEQ1");
	}
	else if (dataset == dsLIST)
	{
		G_Load(dsBRAIN_SLIP_SEQ2, null);
		dataset.NameString(row,"BRAIN_SLIP_SEQ2") = dsBRAIN_SLIP_SEQ2.NameString(dsBRAIN_SLIP_SEQ2.RowPosition,"BRAIN_SLIP_SEQ2");
		dataset.NameString(row,"USE_CLS") = "T";
	}
}

// �̺�Ʈ����-------------------------------------------------------------------//
//���
function btnPreView_onClick()
{
	btnquery_prt_onclick();
}