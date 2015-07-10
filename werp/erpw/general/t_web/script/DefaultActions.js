//읽기 동작에 대한 기본 동작을 정의합니다.
function	D_defaultLoadProcess()
{
	if(!D_checkSelectDataset("읽기")) return false;
	if (G_isChangedDataset(G_FocusDataset))
	{
		var ret = C_msgYesNoCancel("변경된 내용을 저장하시겠습니까?" , "저장");

		if (ret == "Y")
		{
			if(!G_saveAllData(G_FocusDataset)) return false;
		}
		else if(ret == "C")
		{
			return false;
		}
	}
	
	//자료를 읽습니다.
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
//추가 동작에 대한 기본 동작을 정의합니다.
function	D_defaultAdd()
{
	if(!D_checkSelectDataset("추가")) return false;
	if(!D_checkIsLoaded()) return false;
	if(!D_checkWriteEnable()) return false;
	if(!D_checkMasterRowExists("추가")) return false;
	G_addRow(G_FocusDataset);
	if (G_FocusObject != null) G_FocusObject.focus();
	return true;
}
//삽입 동작에 대한 기본 동작을 정의합니다.
function	D_defaultInsert()
{
	if(!D_checkSelectDataset("삽입")) return false;
	if(!D_checkIsLoaded()) return false;
	if(!D_checkWriteEnable()) return false;
	if(!D_checkMasterRowExists("삽입")) return false;
	G_insertRow(G_FocusDataset);
	if (G_FocusObject != null) G_FocusObject.focus();
	return true;
}
//삭제 동작에 대한 기본 동작을 정의합니다.
function	D_defaultDelete()
{
	if(!D_checkSelectDataset("삭제")) return false;
	if(!D_checkIsLoaded()) return false;
	if(!D_checkWriteEnable()) return false;
	if (G_FocusDataset.CountRow < 1)
	{
		C_msgOk("삭제할 행을 선택하십시오.");
		return false;
	}
	var ret = C_msgYesNo("정말 삭제하시겠습니까?", "선택");
	
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
//저장 동작에 대한 기본 동작을 정의합니다.
function	D_defaultSave(aDataset)
{
	var		lrDataset = aDataset == null ? G_FocusDataset:aDataset;
	if(lrDataset == null||lrDataset == undefined) return false;
	var		lbRet = G_saveDataMsg(lrDataset);
	if (G_FocusObject != null) G_FocusObject.focus();
	return lbRet;
}
//삭제시 하위 데이타셑 자동 clear여부 검증
function	D_checkClearChild()
{
	var datasetinfo = null;
	try
	{
		datasetinfo = G_searchDataSetInfo(G_FocusDataset.id);
	}
	catch (e)
	{
		C_msgOk("D_checkClearChild 에러 : " + e.message, "에러");
		return false;
	}
	if(datasetinfo == null)
	{
		C_msgOk("D_checkClearChild 에러 : 데이타셑이 등록되어 있지 않습니다." , "에러");
		return false;
	}
	return datasetinfo.isClearChild;
}
//기본 동작에 앞서서 동작대상이 되는 데이타셑이 선택되어 있는지를 검증합니다.
function	D_checkSelectDataset(asActionDesc)
{
	if(G_FocusDataset == null || G_FocusDataset == undefined)
	{
		C_msgOk(asActionDesc+"를(을) 위한 목록을 선택하십시오");
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
		C_msgOk("D_checkIsLoaded 에러 : " + e.message, "에러");
		return false;
	}
	if(datasetinfo == null)
	{
		C_msgOk("D_checkIsLoaded 에러 : 데이타셑이 등록되어 있지 않습니다." , "에러");
		return false;
	}
	if(!datasetinfo.isLoaded)
	{
		C_msgOk("먼저 조회를 수행하신 후 작업하십시오.");
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
		C_msgOk("D_checkMasterRowExists 에러 : " + e.message, "에러");
		return false;
	}
	if(datasetinfo == null)
	{
		C_msgOk("D_checkMasterRowExists 에러 : 데이타셑이 등록되어 있지 않습니다." , "에러");
		return false;
	}
	if( datasetinfo.dataset.ReadOnly )
	{
		C_msgOk("해당 목록은 읽기 전용입니다.");
		return false;
	}
	if(datasetinfo.grid != null)
	{
		if(!datasetinfo.grid.Editable)
		{
			C_msgOk("해당 목록은 읽기 전용입니다.");
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
		C_msgOk("D_checkMasterRowExists 에러 : " + e.message, "에러");
		return false;
	}
	if(datasetinfo == null)
	{
		C_msgOk("D_checkMasterRowExists 에러 : 데이타셑이 등록되어 있지 않습니다." , "에러");
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
		C_msgOk("D_checkMasterRowExists 에러 : " + e.message, "에러");
		return false;
	}
	if(masterdatasetinfo == null)
	{
		C_msgOk("D_checkMasterRowExists 에러 : 마스터 데이타셑이 등록되어 있지 않습니다." , "에러");
		return false;
	}
	if(!masterdatasetinfo.isLoaded)
	{
		C_msgOk(masterdatasetinfo.dataset_title+"를 먼저 조회해야만 "+asActionDesc+"가(이) 가능합니다.","확인");
		return false;
	}
	if(masterdatasetinfo.dataset.CountRow < 1)
	{
		C_msgOk(masterdatasetinfo.dataset_title+"에 자료가 있어야만 "+asActionDesc+"가(이) 가능합니다.","확인");
		return false;
	}
	if(masterdatasetinfo.dataset.RowPosition < 1)
	{
		C_msgOk(masterdatasetinfo.dataset_title+"의 자료를 먼저 선택하여야만 "+asActionDesc+"가(이) 가능합니다.","확인");
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

//document의 특정 div에 각종 객체들에 대해서 입력가능여부 결정해준다.
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

//document의 특정 div에 각종 객체들에 대해서 hideFocus를 결정해 준다.
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
