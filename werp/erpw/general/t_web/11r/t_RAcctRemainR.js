/**************************************************************************/
/* 1. �� �� �� �� id : t_RAcctRemainR.js(�Ⱓ�������ܾ׳���)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : �Ⱓ�������ܾ׳���
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-02)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{

	G_addDataSet(dsLOV, null, null,  null, "LOV");

}
function OnLoadBefore(dataset)
{
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
	if(!CheckBudgYyyyMm()) return false;
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
	
	 
   	var vBudgYyyyMmFr   = txtBUDG_YYYY_MM_FR.value.replace(/-/g,"");
   	var vBudgYyyyMmTo   = txtBUDG_YYYY_MM_TO.value.replace(/-/g,"");
   
   
   	var reportFile ="r_t_110001.rpt";
	
	
	frmList.EXPORT_TAG.value =cboExportTag.value;
	frmList.RUN_TAG.value = cboRunTag.value;
	frmList.REQUEST_NAME.value = txtRequestName.value;
	frmList.REPORT_NO.value = '00';
	frmList.REPORT_FILE_NAME.value = reportFile;
	
	var strTemp = "";
	// ���α׷��� �Ķ���� �߰�
	// �Ķ����1__��1&&�Ķ����2__��2&&....
	// ����
	//strTemp += "ProjCode__" + strProjCode + "&&";
	//strTemp += "ConsultSeq__" + strConsultSeq;
	
	
	strTemp   = "P_STD_YMD_F__" + vBudgYyyyMmFr;
	strTemp += "&&P_STD_YMD_T__" + vBudgYyyyMmTo;
	
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "BUDG_YYYY_MM_FR")
	{
		txtBUDG_YYYY_MM_FR.value = asDate;
	}
	else if (asCalendarID == "BUDG_YYYY_MM_TO")
	{
		txtBUDG_YYYY_MM_TO.value = asDate;
	}
}
function OnRowPosChanged(dataset, row)
{

}

// �̺�Ʈ����-------------------------------------------------------------------//

 
 
function	CheckCompCode()
{
	return true;
}

function	CheckBudgYyyyMm()
{
	if (C_isNull(txtBUDG_YYYY_MM_FR.value))
	{
		C_msgOk("�Ⱓ�� �Է��ϼ���.", "Ȯ��");
		return false;
	}
	if (C_isNull(txtBUDG_YYYY_MM_TO.value))
	{
		C_msgOk("�Ⱓ�� �Է��ϼ���.", "Ȯ��");
		return false;
	}
	return true;
}

function btnBUDG_YYYY_MM_FR_onClick()
{
	C_Calendar("BUDG_YYYY_MM_FR", "D", txtBUDG_YYYY_MM_FR.value);
	 
}

function btnBUDG_YYYY_MM_TO_onClick()
{
	C_Calendar("BUDG_YYYY_MM_TO", "D", txtBUDG_YYYY_MM_TO.value);
	
}
 
