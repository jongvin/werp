/**************************************************************************/
/* 1. �� �� �� �� id : t_WFixDeprecSum.js(������ ������Ȳ)
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : ������ ������Ȳ 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-23)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, null, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "������������Ȳ");
	G_addDataSet(dsLOV, null, null, "", "LOV");
	
	txtWORK_DT_FROM.value 	= vDATE.substr(0,4)+"-"+vDATE.substr(4,2)+"-01";
	txtWORK_DT_TO.value 		= vDATE.substr(0,4)+"-"+vDATE.substr(4,2)+"-"+vDATE.substr(6,2);
	txtCOMP_CODE.value		= sCompCode;
	txtCOMPANY_NAME.value	= sCompName;
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		var 	strCOMP_CODE	= txtCOMP_CODE.value;
		var 	strWORK_SEQ		= hiWORK_SEQ.value;
		var   strDEPREC_DIV	= cboDEPREC_DIV.value;
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
									 + D_P2("COMP_CODE", txtCOMP_CODE.value)
									 + D_P2("WORK_SEQ",strWORK_SEQ)
									 + D_P2("DEPREC_DIV",strDEPREC_DIV);
									
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
function setDate_onFocus(div)
{
	if (div=="1")
	{
		olddata1 = txtWORK_DT_FROM.value;
	}
	else
	{
		olddata2 = txtWORK_DT_TO.value;	
	}
}
// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
// ��ȸ
function btnquery_onclick()
{
	if (txtCOMP_CODE.value == "")
	{
		C_msgOk("������� �Է� �Ͻʽÿ�.", "Ȯ��");
		return;
	}
	if (hiWORK_SEQ.value == "" || txtWORK_NAME.value == "" )
	{
		C_msgOk("�۾������� �Է� �Ͻʽÿ�.", "Ȯ��");
		return;
	}
	D_defaultLoad();
}

// �߰�
function btnadd_onclick()
{
	D_defaultAdd();
}

// ���
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "WORK_DT_FROM")
	{
		txtWORK_DT_FROM.value = asDate;
		if ( !C_isNull(txtWORK_DT_FROM.value))
		{
			strWorkDtFrom = txtWORK_DT_FROM.value.replace(/-/gi,"");
			strWorkDtTo	 = txtWORK_DT_TO.value.replace(/-/gi,"");

			if (parseInt(strWorkDtFrom) > parseInt(strWorkDtTo))
			{
				C_msgOk("�������� �����Ϻ��� �۰� �Է��ϼ���");
				txtWORK_DT_FROM.value = olddata1;
				return;
			}
		}	
	}
	else if (asCalendarID == "WORK_DT_TO")
	{
		txtWORK_DT_TO.value = asDate;
		if ( !C_isNull(txtWORK_DT_TO.value))
		{
			strWorkDtFrom = txtWORK_DT_FROM.value.replace(/-/gi,"");
			strWorkDtTo	 = txtWORK_DT_TO.value.replace(/-/gi,"");

			if (parseInt(strWorkDtFrom) > parseInt(strWorkDtTo))
			{
				C_msgOk("�������� �����Ϻ��� �۰� �Է��ϼ���");
				txtWORK_DT_TO.value = olddata2;
				return;
			}
		}	
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
}

function OnPopup(dataset, grid, row, colid, data)
{
}

// �̺�Ʈ����-------------------------------------------------------------------//
function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE.value		= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}

function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE", lrArgs,"T");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value		= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
}
function txtWORK_DT_FROM_onBlur()
{
		
	if ( !C_isNull(txtWORK_DT_FROM.value))
	{
		strWorkDtFrom = txtWORK_DT_FROM.value.replace(/-/gi,"");
		strWorkDtTo	 = txtWORK_DT_TO.value.replace(/-/gi,"");

		if (parseInt(strWorkDtFrom) > parseInt(strWorkDtTo))
		{
			C_msgOk("�������� �����Ϻ��� �۰� �Է��ϼ���");
			txtWORK_DT_FROM.value = olddata1;
			return;
		}
	}	
}
function btnWORK_DT_FROM_onClick()
{
	olddata1 = txtWORK_DT_FROM.value;
	C_Calendar("WORK_DT_FROM", "D", txtWORK_DT_FROM.value);
}
function txtWORK_DT_TO_onBlur()
{	
	
	if ( !C_isNull(txtWORK_DT_TO.value))
	{
		strWorkDtFrom = txtWORK_DT_FROM.value.replace(/-/gi,"");
		strWorkDtTo	 = txtWORK_DT_TO.value.replace(/-/gi,"");

		if (parseInt(strWorkDtFrom) > parseInt(strWorkDtTo))
		{
			C_msgOk("�������� �����Ϻ��� �۰� �Է��ϼ���");
			txtWORK_DT_TO.value = olddata2;
			return;
		}
	}		
}
function btnWORK_DT_TO_onClick()
{
	olddata2 = txtWORK_DT_TO.value; 
	C_Calendar("WORK_DT_TO", "D", txtWORK_DT_TO.value);
}

function btnIWORK_onClick()
{
	if (txtWORK_DT_FROM.value == "" || txtWORK_DT_TO.value == "" )
	{
		C_msgOk("�۾����ڸ� �Է� �Ͻʽÿ�.", "Ȯ��");
		return;
	}
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("WORK_DT_FROM", txtWORK_DT_FROM.value);
	lrArgs.set("WORK_DT_TO", txtWORK_DT_TO.value);

	lrRet = C_LOV("T_FIX_DEPREC_CAL", lrArgs);

	if (lrRet != null)
	{
		hiWORK_SEQ.value			= lrRet.get("WORK_SEQ");
		txtWORK_NAME.value		= lrRet.get("WORK_NAME");
	}
}
