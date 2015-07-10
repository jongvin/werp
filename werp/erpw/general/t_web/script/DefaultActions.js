//�б� ���ۿ� ���� �⺻ ������ �����մϴ�.
function	D_defaultLoadProcess()
{
	if(!D_checkSelectDataset("�б�")) return false;
	if (G_isChangedDataset(G_FocusDataset))
	{
		var ret = C_msgYesNoCancel("����� ������ �����Ͻðڽ��ϱ�?" , "����");

		if (ret == "Y")
		{
			if(!G_saveAllData(G_FocusDataset)) return false;
		}
		else if(ret == "C")
		{
			return false;
		}
	}
	
	//�ڷḦ �н��ϴ�.
	if(!G_Load(G_FocusDataset)) return false;
	return true;
}
function	D_defaultLoad()
{
	document.body.focus();
	var		lbRet = D_defaultLoadProcess();
	if (G_FocusObject != null) G_FocusObject.focus();
	return lbRet;
}
//�߰� ���ۿ� ���� �⺻ ������ �����մϴ�.
function	D_defaultAdd()
{
	if(!D_checkSelectDataset("�߰�")) return false;
	if(!D_checkIsLoaded()) return false;
	if(!D_checkWriteEnable()) return false;
	if(!D_checkMasterRowExists("�߰�")) return false;
	G_addRow(G_FocusDataset);
	if (G_FocusObject != null) G_FocusObject.focus();
	return true;
}
//���� ���ۿ� ���� �⺻ ������ �����մϴ�.
function	D_defaultInsert()
{
	if(!D_checkSelectDataset("����")) return false;
	if(!D_checkIsLoaded()) return false;
	if(!D_checkWriteEnable()) return false;
	if(!D_checkMasterRowExists("����")) return false;
	G_insertRow(G_FocusDataset);
	if (G_FocusObject != null) G_FocusObject.focus();
	return true;
}
//���� ���ۿ� ���� �⺻ ������ �����մϴ�.
function	D_defaultDelete()
{
	if(!D_checkSelectDataset("����")) return false;
	if(!D_checkIsLoaded()) return false;
	if(!D_checkWriteEnable()) return false;
	if (G_FocusDataset.CountRow < 1)
	{
		C_msgOk("������ ���� �����Ͻʽÿ�.");
		return false;
	}
	var ret = C_msgYesNo("���� �����Ͻðڽ��ϱ�?", "����");
	
	if (ret == "Y")
	{
		if(D_checkClearChild())
		{
			G_clearDetailDataSet(G_FocusDataset.id);
		}
		G_deleteRow(G_FocusDataset);
	}
	if (G_FocusObject != null) G_FocusObject.focus();
	return true;
}
//���� ���ۿ� ���� �⺻ ������ �����մϴ�.
function	D_defaultSave(aDataset)
{
	var		lrDataset = aDataset == null ? G_FocusDataset:aDataset;
	if(lrDataset == null||lrDataset == undefined) return false;
	var		lbRet = G_saveDataMsg(lrDataset);
	if (G_FocusObject != null) G_FocusObject.focus();
	return lbRet;
}
//������ ���� ����Ÿ�V �ڵ� clear���� ����
function	D_checkClearChild()
{
	var datasetinfo = null;
	try
	{
		datasetinfo = G_searchDataSetInfo(G_FocusDataset.id);
	}
	catch (e)
	{
		C_msgOk("D_checkClearChild ���� : " + e.message, "����");
		return false;
	}
	if(datasetinfo == null)
	{
		C_msgOk("D_checkClearChild ���� : ����Ÿ�V�� ��ϵǾ� ���� �ʽ��ϴ�." , "����");
		return false;
	}
	return datasetinfo.isClearChild;
}
//�⺻ ���ۿ� �ռ��� ���۴���� �Ǵ� ����Ÿ�V�� ���õǾ� �ִ����� �����մϴ�.
function	D_checkSelectDataset(asActionDesc)
{
	if(G_FocusDataset == null || G_FocusDataset == undefined)
	{
		C_msgOk(asActionDesc+"��(��) ���� ����� �����Ͻʽÿ�");
		return false;
	}
	return true;
}
function	D_checkIsLoaded()
{
	return D_checkIsLoadedInternal(G_FocusDataset);
}
function	D_checkIsLoadedInternal(aDataset)
{
	var datasetinfo = null;
	try
	{
		datasetinfo = G_searchDataSetInfo(aDataset.id);
	}
	catch (e)
	{
		C_msgOk("D_checkIsLoaded ���� : " + e.message, "����");
		return false;
	}
	if(datasetinfo == null)
	{
		C_msgOk("D_checkIsLoaded ���� : ����Ÿ�V�� ��ϵǾ� ���� �ʽ��ϴ�." , "����");
		return false;
	}
	if(!datasetinfo.isLoaded)
	{
		C_msgOk("���� ��ȸ�� �����Ͻ� �� �۾��Ͻʽÿ�.");
		return false;
	}
	return true;
}
function	D_checkWriteEnable()
{
	return D_checkWriteEnableInternal(G_FocusDataset);
}
function	D_checkWriteEnableInternal(aDataset)
{
	var datasetinfo = null;
	try
	{
		datasetinfo = G_searchDataSetInfo(aDataset.id);
	}
	catch (e)
	{
		C_msgOk("D_checkMasterRowExists ���� : " + e.message, "����");
		return false;
	}
	if(datasetinfo == null)
	{
		C_msgOk("D_checkMasterRowExists ���� : ����Ÿ�V�� ��ϵǾ� ���� �ʽ��ϴ�." , "����");
		return false;
	}
	if( datasetinfo.dataset.ReadOnly )
	{
		C_msgOk("�ش� ����� �б� �����Դϴ�.");
		return false;
	}
	if(datasetinfo.grid != null)
	{
		if(!datasetinfo.grid.Editable)
		{
			C_msgOk("�ش� ����� �б� �����Դϴ�.");
			return false;
		}
	}
	return true;
}
function	D_checkMasterRowExistsInternal(aDataSet,asActionDesc)
{
	var datasetinfo = null;
	var masterdatasetinfo = null;
	try
	{
		datasetinfo = G_searchDataSetInfo(aDataSet.id);
	}
	catch (e)
	{
		C_msgOk("D_checkMasterRowExists ���� : " + e.message, "����");
		return false;
	}
	if(datasetinfo == null)
	{
		C_msgOk("D_checkMasterRowExists ���� : ����Ÿ�V�� ��ϵǾ� ���� �ʽ��ϴ�." , "����");
		return false;
	}
	if(datasetinfo.masterDataSet == null || datasetinfo.masterDataSet == undefined)
	{
		return true;
	}
	try
	{
		masterdatasetinfo = G_searchDataSetInfo(datasetinfo.masterDataSet.dataset.id);
	}
	catch (e)
	{
		C_msgOk("D_checkMasterRowExists ���� : " + e.message, "����");
		return false;
	}
	if(masterdatasetinfo == null)
	{
		C_msgOk("D_checkMasterRowExists ���� : ������ ����Ÿ�V�� ��ϵǾ� ���� �ʽ��ϴ�." , "����");
		return false;
	}
	if(!masterdatasetinfo.isLoaded)
	{
		C_msgOk(masterdatasetinfo.dataset_title+"�� ���� ��ȸ�ؾ߸� "+asActionDesc+"��(��) �����մϴ�.","Ȯ��");
		return false;
	}
	if(masterdatasetinfo.dataset.CountRow < 1)
	{
		C_msgOk(masterdatasetinfo.dataset_title+"�� �ڷᰡ �־�߸� "+asActionDesc+"��(��) �����մϴ�.","Ȯ��");
		return false;
	}
	if(masterdatasetinfo.dataset.RowPosition < 1)
	{
		C_msgOk(masterdatasetinfo.dataset_title+"�� �ڷḦ ���� �����Ͽ��߸� "+asActionDesc+"��(��) �����մϴ�.","Ȯ��");
		return false;
	}
	return true;
}
function	D_checkMasterRowExists(asActionDesc)
{
	return D_checkMasterRowExistsInternal(G_FocusDataset,asActionDesc);
}
function	D_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA)
{
	G_defaultDateProcessInGrid(dataset, row, colid, olddata,COL_DATA);
}
function	D_defaultYmProcessInGrid(dataset, row, colid, olddata,COL_DATA)
{
	G_defaultYmProcessInGrid(dataset, row, colid, olddata,COL_DATA);
}
function	D_P1(asPName,asPValue)
{
	return "?"+asPName+"="+asPValue;
}
function	D_P2(asPName,asPValue)
{
	return "&"+asPName+"="+asPValue;
}

//document�� Ư�� div�� ���� ��ü�鿡 ���ؼ� �Է°��ɿ��� �������ش�.
function	D_Div_ReadOnly(asDivName, asTF)
{
	var lsIE = true;
	var elem = null;
	var obj = null;
	
	elem = lsIE ? asDivName.all.tags('INPUT') : document.getElementsByTagName("INPUT");
	
	for (var i = 0; i < elem.length; i++)
	{
		obj = elem[i];
		
		try
		{
			if (elem[i] == null || (typeof elem[i] == "undefined")) continue;
			if (elem[i].type == null || elem[i].type == "undefined") continue;
		}
		catch(e)
		{
			continue;
		}

		switch (obj.type)
		{
			case "radio" :
				elem[i].disabled = asTF;
				break;
			case "checkbox" :
				elem[i].disabled = asTF;
				break;
			case "image" :
				elem[i].disabled = asTF;
				break;
			case "button" :
				elem[i].disabled = asTF;
				break;
			case "text" :
				if (elem[i].getAttribute("adsreadonly") == null)
				{
					elem[i].readOnly = asTF;
				}
				break;
			case "password" :
				elem[i].readOnly = asTF;
				break;
		}
	}
	
	elem = lsIE ? asDivName.all.tags('SELECT') : document.getElementsByTagName("SELECT");
	
	for (var i = 0; i < elem.length; i++)
	{
		elem[i].disabled = asTF;
	}
	
	elem = lsIE ? asDivName.all.tags('TEXTAREA') : document.getElementsByTagName("TEXTAREA");
	
	for (var i = 0; i < elem.length; i++)
	{
		if (elem[i].getAttribute("adsreadonly") == null)
		{
			elem[i].readOnly = asTF;
		}
	}

	elem = lsIE ? asDivName.all.tags("OBJECT") : document.getElementsByTagName("OBJECT");
	
	for (var i = 0; i < elem.length; i++)
	{
		obj = elem[i];
		switch (obj.classid)
		{
			case "clsid:60109D65-70C0-425C-B3A4-4CB001513C69" : // LuxeComboID.Enable
				elem[i].Enable = !asTF;
				break;
		}
	}
}

//document�� Ư�� div�� ���� ��ü�鿡 ���ؼ� hideFocus�� ������ �ش�.
function	D_Div_hideFocus(asDivName)
{
	var lsIE = true;
	var elem_div = null;
	var elem = null;
	var obj = null;
	
	if (asDivName == null)
	{
		elem_div = lsIE ? document.all.tags('DIV') : document.getElementsByTagName("DIV");
		
		for (var j = 0; j < elem_div.length; j++)
		{
			elem = lsIE ? elem_div[j].all.tags('INPUT') : document.getElementsByTagName("INPUT");

			for (var i = 0; i < elem.length; i++)
			{
				if (elem_div[j].style.getAttribute("display") == "none")
				{
					elem[i].hideFocus = true;
				}
				else
				{
					elem[i].hideFocus = false;
				}
			}
			
			elem = lsIE ? elem_div[j].all.tags('SELECT') : document.getElementsByTagName("SELECT");
			
			for (var i = 0; i < elem.length; i++)
			{
				if (elem_div[j].style.getAttribute("display") == "none")
				{
					elem[i].hideFocus = true;
				}
				else
				{
					elem[i].hideFocus = false;
				}
			}
			
			elem = lsIE ? elem_div[j].all.tags('TEXTAREA') : document.getElementsByTagName("TEXTAREA");
			
			for (var i = 0; i < elem.length; i++)
			{
				if (elem_div[j].style.getAttribute("display") == "none")
				{
					elem[i].hideFocus = true;
				}
				else
				{
					elem[i].hideFocus = false;
				}
			}

			elem = lsIE ? asDivName.all.tags("OBJECT") : document.getElementsByTagName("OBJECT");

			for (var i = 0; i < elem.length; i++)
			{
				obj = elem[i];
				switch (obj.classid)
				{
					case "clsid:60109D65-70C0-425C-B3A4-4CB001513C69" : // LuxeComboID.Enable
						if (asDivName.style.getAttribute("display") == "none")
						{
							elem[i].hideFocus = true;
						}
						else
						{
							elem[i].hideFocus = false;
						}
						break;
				}
			}
		}
	}
	else
	{
		elem = lsIE ? asDivName.all.tags('INPUT') : document.getElementsByTagName("INPUT");

		for (var i = 0; i < elem.length; i++)
		{
			if (asDivName.style.getAttribute("display") == "none")
			{
				elem[i].hideFocus = true;
			}
			else
			{
				elem[i].hideFocus = false;
			}
		}
		
		elem = lsIE ? asDivName.all.tags('SELECT') : document.getElementsByTagName("SELECT");
		
		for (var i = 0; i < elem.length; i++)
		{
			if (asDivName.style.getAttribute("display") == "none")
			{
				elem[i].hideFocus = true;
			}
			else
			{
				elem[i].hideFocus = false;
			}
		}
		
		elem = lsIE ? asDivName.all.tags('TEXTAREA') : document.getElementsByTagName("TEXTAREA");
		
		for (var i = 0; i < elem.length; i++)
		{
			if (asDivName.style.getAttribute("display") == "none")
			{
				elem[i].hideFocus = true;
			}
			else
			{
				elem[i].hideFocus = false;
			}
		}

		elem = lsIE ? asDivName.all.tags("OBJECT") : document.getElementsByTagName("OBJECT");
		
		for (var i = 0; i < elem.length; i++)
		{
			obj = elem[i];
			switch (obj.classid)
			{
				case "clsid:60109D65-70C0-425C-B3A4-4CB001513C69" : // LuxeComboID.Enable
					if (asDivName.style.getAttribute("display") == "none")
					{
						elem[i].hideFocus = true;
					}
					else
					{
						elem[i].hideFocus = false;
					}
					break;
			}
		}
	}
}
