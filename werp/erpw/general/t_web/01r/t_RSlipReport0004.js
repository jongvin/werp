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
	//G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "�ڵ���ǥ�ڵ�");

	G_addDataSet(dsMAIN, null, null, sSelectPageName+D_P1("ACT","MAIN"), "�����");
	G_addDataSet(dsLIST00, null, null,  sSelectPageName+D_P1("ACT","LIST00"), "����庰 �μ����");

	G_addDataSet(dsLIST02, null, null, sSelectPageName+D_P1("ACT","LIST02")	, "�μ���-���� ��û����");

	G_addDataSet(dsLOV, null, null,  null, "LOV");

	G_addRel(dsMAIN, dsLIST00);

	G_addRelCol(dsLIST00, "COMP_CODE", "COMP_CODE");

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtDEPT_CODE.value = sDeptCode;
	txtDEPT_NAME.value = sDeptName;
	
	//G_Load(dsMAIN, null);
	
	//gridLIST02.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN");
	}

	
	else if (dataset == dsLIST00)
	{
		var vCOMP_CODE = txtCOMP_CODE.value;
		
		dataset.DataID = sSelectPageName + D_P1("ACT","LIST00")
									 + D_P2("COMP_CODE",vCOMP_CODE);
	}

	else if (dataset == dsLIST02)
	{
		var vCOMP_CODE = txtCOMP_CODE.value;
		var vDT_F = txtDT_F.value;
		var vDT_T = txtDT_T.value;
		var vDEPT_CODE = dsLIST00.NameString(dsLIST00.RowPosition,"DEPT_CODE");

		dataset.DataID = sSelectPageName + D_P1("ACT","LIST02")
									 + D_P2("COMP_CODE",vCOMP_CODE)
									 + D_P2("DT_F",vDT_F)
									 + D_P2("DT_T",vDT_T)
									 + D_P2("DEPT_CODE",vDEPT_CODE)
									 ;

		//makeGridTitle(gridLIST02);
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
function btnSch2_onClick()
{
	G_Load(dsLIST02, null);
}

//�˻�����üũ
function print_condition_check()
{
	var vCompCode = txtCOMP_CODE.value;
   	var vDT_F   = txtDT_F.value;
   	var vDT_T   = txtDT_T.value;

	if ( cboRunTag.value == "2" && txtRequestName.value == "")
   	{
   		C_msgOk("���౸���� ��û�϶� ��û���� �� �Է��ϼž� �մϴ�.");
   		return false;
   	}

   	if ( C_isNull(vCompCode))
   	{
   		C_msgOk("������� �����ϼ���");
   		return false;
   	}
   	
   	if ( C_isNull(vDT_F))
   	{
   		C_msgOk("�۾����� �Է��ϼ���");
   		return false;
   	}
   	
   	if ( C_isNull(vDT_T))
   	{
   		C_msgOk("�۾����� �Է��ϼ���");
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
	
	var vCompCode  = txtCOMP_CODE.value;
	var vCompName  = txtCOMPANY_NAME.value;
	var vDeptCode  = (txtDEPT_CODE.value=="")?"%":txtDEPT_CODE.value;
	var vDeptName  = (txtDEPT_NAME.value=="")?"��ü":txtDEPT_NAME.value;
   	var vDT_F   = txtDT_F.value;
   	var vDT_T   = txtDT_T.value;
   
	// ���� ���丮
   	var reportFile = sReportName;
   	
	frmList.EXPORT_TAG.value =cboExportTag.value;
	frmList.RUN_TAG.value = cboRunTag.value;
	frmList.REQUEST_NAME.value = txtRequestName.value;
	frmList.REPORT_NO.value = '--';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	var strTemp = "";
	// ���α׷��� �Ķ���� �߰�
	// �Ķ����1__��1&&�Ķ����2__��2&&....
	// ����
	//strTemp += "ProjCode__" + strProjCode + "&&";
	//strTemp += "ConsultSeq__" + strConsultSeq;

	strTemp += "pCOMP_CODE__" + vCompCode;
	strTemp += "&&pCOMP_NAME__" + vCompName;
	strTemp += "&&pDEPT_CODE__" + vDeptCode;
	strTemp += "&&pDEPT_NAME__" + vDeptName;
	strTemp  += "&&pDT_T__" + vDT_T;
	strTemp += "&&pDT_F__" + vDT_F;

	
	//alert(frmList.REPORT_FILE_NAME.value);
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "DT_F")
	{
		txtDT_F.value = asDate;
		if( parseInt(txtDT_F.value.replace(/-/g, "")) > parseInt(txtDT_T.value.replace(/-/g, "")) )
		{
			C_msgOk("�������� �����Ϻ��� Ů�ϴ�");
			txtDT_F.value="";
			btnDT_F.focus();
		}
	}
	else if (asCalendarID == "DT_T")
	{
		txtDT_T.value = asDate;
		if( parseInt(txtDT_F.value.replace(/-/g, "")) > parseInt(txtDT_T.value.replace(/-/g, "")) )
		{
			C_msgOk("�������� �����Ϻ��� Ů�ϴ�");
			txtDT_T.value="";
			btnDT_T.focus();
		}
	}
	
}
function OnRowPosChanged(dataset, row)
{
	if(row==0) return;
	if (dataset == dsMAIN) {
		//�������
	}
	else if (dataset == dsLIST00)
	{
		//�μ�
		var vDeptCode = dsLIST00.NameString(dsLIST00.RowPosition,"DEPT_CODE");
	
		//G_Load(dsLIST02,null);
	}

}

// �̺�Ʈ����-------------------------------------------------------------------//
//�ͼӻ����
function txtCOMP_CODE_onblur() 
{
	// �Է°��� �������� ������ ����
	if (txtCOMP_CODE_F.value == txtCOMP_CODE.value) return;
	
	// �Է°��� ''�̸� ����
	if (C_isNull(txtCOMP_CODE.value)) {
		txtCOMPANY_NAME.value = "";
		txtDEPT_CODE.value = "";
		txtDEPT_NAME.value = "";
		return;
	}

	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE", lrArgs,"T");

	// �˾����(X)�ϸ� ���������� ������ ����
	if (lrRet == null) {
		txtCOMP_CODE.value = txtCOMP_CODE_F.value;
		return;
	}
	
	// �˾����ð��� �������� ������ ������ ����	
	if (txtCOMP_CODE_F.value == lrRet.get("COMP_CODE")) {
		txtCOMP_CODE.value = txtCOMP_CODE_F.value;
		return;
	}
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	txtDEPT_CODE.value = "";
	txtDEPT_NAME.value = "";
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE", lrArgs,"F");
	
	// �˾����(X)�ϸ�
	if (lrRet == null) return;
	
	// �˾����ð��� �������� ������ �׳� ����	
	if (txtCOMP_CODE.value == lrRet.get("COMP_CODE")) return;	

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	txtDEPT_CODE.value = "";
	txtDEPT_NAME.value = "";
}

//�ͼӺμ�
function txtDEPT_CODE_onblur()
{
	// �Է°��� �������� ������ ����
	if (txtDEPT_CODE_F.value == txtDEPT_CODE.value) return;
	
	// �Է°��� ''�̸� ����
	if (C_isNull(txtDEPT_CODE.value))
	{
		txtDEPT_CODE.value = "";
		txtDEPT_NAME.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE3", lrArgs,"T");
	
	// �˾����(X)�ϸ� ���������� ������ ����
	if (lrRet == null) {
		txtDEPT_CODE.value = txtDEPT_CODE_F.value;
		return;
	}
	
	// �˾����ð��� �������� ������ ������ ����	
	if (txtDEPT_CODE_F.value == lrRet.get("DEPT_CODE")) {
		txtDEPT_CODE.value = txtDEPT_CODE_F.value;
		return;
	}
		
	txtDEPT_CODE.value = lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value = lrRet.get("DEPT_NAME");
}

function btnDEPT_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_DEPT_CODE3", lrArgs,"F");

	// �˾����(X)�ϸ�
	if (lrRet == null) return;
	
	// �˾����ð��� �������� ������ �׳� ����	
	if (txtDEPT_CODE.value == lrRet.get("DEPT_CODE")) return;
	
	txtDEPT_CODE.value = lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value = lrRet.get("DEPT_NAME");
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

function	CheckBudgYyyyMm()
{
	if (C_isNull(txtDT_F.value))
	{
		C_msgOk("�۾����ۿ��� �Է��ϼ���.", "Ȯ��");
		return false;
	}
	if (C_isNull(txtDT_T.value))
	{
		C_msgOk("�۾�������� �Է��ϼ���.", "Ȯ��");
		return false;
	}
	return true;
}

function btnDT_F_onClick()
{
	C_Calendar("DT_F", "D", txtDT_F.value);
	 
}

function btnDT_T_onClick()
{
	C_Calendar("DT_T", "D", txtDT_T.value);
	
}
 
function accFlag_onChange()
{
	G_Load(dsLIST02,null);	
}

 function deptFlag_onChange()
{
	G_Load(dsLIST02,null);	
}
//���
function btnPreView_onClick()
{
	btnquery_prt_onclick();
}