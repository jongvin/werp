// ContextMenu �迭
var CM_arrContextMenu = new Array();

// Menu HTML
var CM_MENU_HTML = "";

// ContextMenu ��ü
function CM_ContextMenu(aContextMenuID, aFlexGrid)
{
	try
	{
		if (C_isNull(aContextMenuID))
		{
			C_msgOk("ContextMenuID�� ��(Null) �Դϴ�.");
			return;
		}
		
		if (aFlexGrid == null)
		{
			C_msgOk("ContextMenu�� FlexGrid�� ��(Null) �Դϴ�.");
			return;
		}
		
		if (CM_arrContextMenu == null) CM_arrContextMenu = new Array();
		
		aFlexGrid.attachEvent("MouseDown", new Function("button", "shift", "x", "y", "cancel", "CM_OnMouseDown(" + aFlexGrid.id + ", button, shift, x, y, cancel);"));
		aFlexGrid.attachEvent("onclick", new Function("CM_OnClick(" + aFlexGrid.id + ");"));
		//aFlexGrid.attachEvent("onblur", new Function("CM_OnBlur();"));
		
		this.ContextMenuID = aContextMenuID;
		this.FlexGrid = aFlexGrid;
		this.Menus = new Array();
		this.addMenu = CM_addMenu;
		this.getMenu = CM_getMenu;
		this.setMenu = CM_setMenu;
		
		CM_arrContextMenu.push(this);
	}
	catch (e)
	{
		C_msgOk("CM_ContextMenu ���� : " + e.message, "����");
		return;
	}
}

// Menu ��ü
// ���� : �޴�ID, �޴�Ÿ��(N:�Ϲ�, L:����), �޴���, Ȱ��ȭ����
function CM_Menu(aMenuID, aMenuType, aMenuTitle, aDisabled)
{
	try
	{
		if (C_isNull(aMenuID))
		{
			C_msgOk("MenuID�� ��(Null) �Դϴ�.");
			return;
		}
		
		this.MenuID = aMenuID;
		this.MenuType = C_isNull(aMenuType) ? "N" : aMenuType;
		this.MenuTitle = C_isNull(aMenuTitle) ? aMenuID : aMenuTitle;
		this.Disabled = aDisabled == null ? false : aDisabled;
		
		if (this.MenuType == "L") this.Disabled = true;
	}
	catch (e)
	{
		C_msgOk("CM_Menu ���� : " + e.message, "����");
		return;
	}
}

function CM_createContextMenu(aContextMenuID, aFlexGrid)
{
	var oContextMenu = null;
	
	try
	{
		oContextMenu = new CM_ContextMenu(aContextMenuID, aFlexGrid);
		return oContextMenu;
	}
	catch (e)
	{
		C_msgOk("CM_createContextMenu ���� : " + e.message, "����");
		return null;
	}
}

// Menu �߰�
// ���� : �޴�ID, �޴�Ÿ��(N:�Ϲ�, L:����), �޴���, ��Ȱ������
function CM_addMenu(aMenuID, aMenuType, aMenuTitle, aDisabled)
{
	try
	{
		if (this.Menus == null) this.Menus = new Array();
		
		this.Menus.push(new CM_Menu(aMenuID, aMenuType, aMenuTitle, aDisabled));
	}
	catch (e)
	{
		C_msgOk("CM_addMenu ���� : " + e.message, "����");
		return;
	}
}

// Menu ��������
// ���� : �޴�ID
function CM_getMenu(aMenuID)
{
	var oMenu = null;
	
	try
	{
		if (C_isNull(aMenuID))
		{
			C_msgOk("MenuID�� ��(Null) �Դϴ�.");
			return null;
		}
		
		if (this.Menus == null || this.Menus.length < 1) return null;
		
		for (var i = 0; i < this.Menus.length; i++)
		{
			if (this.Menus[i].MenuID == aMenuID)
			{
				oMenu = this.Menus[i];
				break;
			}
		}
		
		return oMenu;
	}
	catch (e)
	{
		C_msgOk("CM_getMenu ���� : " + e.message, "����");
		return null;
	}
}

// Menu �߰� �� ����
// ���� : �޴�ID, �޴�Ÿ��(N:�Ϲ�, L:����), �޴���, ��Ȱ������
function CM_setMenu(aMenuID, aMenuType, aMenuTitle, aDisabled)
{
	try
	{
		if (C_isNull(aMenuID))
		{
			C_msgOk("MenuID�� ��(Null) �Դϴ�.");
			return;
		}
		
		if (this.Menus == null) this.Menus = new Array();
		
		for (var i = 0; i < this.Menus.length; i++)
		{
			if (this.Menus[i].MenuID == aMenuID)
			{
				this.Menus[i].MenuType = C_isNull(aMenuType) ? "N" : aMenuType;
				this.Menus[i].MenuTitle = C_isNull(aMenuTitle) ? aMenuID : aMenuTitle;
				this.Menus[i].Disabled = aDisabled == null ? false : aDisabled;
				return;
			}
		}
		
		this.Menus.push(new CM_Menu(aMenuID, aMenuType, aMenuTitle, aDisabled));
	}
	catch (e)
	{
		C_msgOk("CM_setMenu ���� : " + e.message, "����");
		return;
	}
}

function CM_getContextMenu(aContextMenuID)
{
	var oContextMenu = null;
	
	try
	{
		if (C_isNull(aContextMenuID))
		{
			C_msgOk("ContextMenuID�� ��(Null) �Դϴ�.");
			return null;
		}
		
		if (CM_arrContextMenu == null || CM_arrContextMenu.length < 1) return null;
		
		for (var i = 0; i < CM_arrContextMenu.length; i++)
		{
			if (CM_arrContextMenu[i].ContextMenuID == aContextMenuID)
			{
				oContextMenu = CM_arrContextMenu[i];
				break;
			}
		}
		
		return oContextMenu;
	}
	catch (e)
	{
		C_msgOk("CM_getContextMenu ���� : " + e.message, "����");
		return null;
	}
}

function CM_ContextMenuShow(aContextMenuID, aTop, aLeft)
{
	var frmContextMenu = null;
	var oContextMenu = null;
	var liTop = 0;
	var liLeft = 0;
	var liWidth = 170;
	var liHeight = 0;
	var liX = 0;
	var liY = 0;
	var lsTemp = "";
	
	try
	{
		if (C_isNull(aContextMenuID))
		{
			C_msgOk("ContextMenuID�� ��(Null) �Դϴ�.");
			return;
		}
		
		oContextMenu = CM_getContextMenu(aContextMenuID);
		
		try
		{
			// ������ ���� �Լ� Call
			if (!OnContextMenuBefore(oContextMenu, oContextMenu.ContextMenuID, oContextMenu.FlexGrid)) return;
		}
		catch (e)
		{
			if (typeof(OnContextMenuBefore) == "function")
			{
				C_msgOk("OnContextMenuBefore �̺�Ʈ�� ������ ���� �Լ� Call ���� : " + e.message, "����");
			}
		}
		
		if (oContextMenu == null || oContextMenu.Menus == null || oContextMenu.Menus.length < 1) return;
		
		for (var i = 0; i < oContextMenu.Menus.length; i++)
		{
			var lsMenuID = oContextMenu.Menus[i].MenuID;
			var lsClassName = oContextMenu.Menus[i].MenuType == "L" ? "lineItem" : "menuItem";
			var lsTitle = oContextMenu.Menus[i].MenuType == "L" ? "��������������������������" : oContextMenu.Menus[i].MenuTitle;
			var lsDisabled = oContextMenu.Menus[i].Disabled == true ? "disabled" : "";
			
			lsTemp += "<div id=" + lsMenuID + " class='" + lsClassName + "' Hidefocus " + lsDisabled + " onclick=\"selectMenu('" + lsMenuID + "')\">" + lsTitle + "</div> \n";
			liHeight += 18;
		}
		
		CM_MENU_HTML = lsTemp;
		
		if (event != null)
		{
			liX = event.x;
			liY = event.y;
		}
		else
		{
			//liX = document.body.clientWidth / 2 - liWidth / 2;
			//liY = document.body.clientHeight / 2 - liHeight / 2;
		}
		
		if (aTop == null)
		{
			liTop = document.body.clientHeight - liY > liHeight + 4 ? liY : liY - (liHeight + 4);
		}
		
		if (aLeft == null)
		{
			liLeft = document.body.clientWidth - liX > liWidth ? liX : liX - liWidth;
		}
		
		frmContextMenu = document.getElementById("CM_" + aContextMenuID);
		
		if (frmContextMenu == null)
		{
			frmContextMenu = document.createElement("<iframe id='CM_" + aContextMenuID + "' width='0' height='0' Hidefocus style='position:absolute;' frameborder='0' scrolling='no'></iframe>");
			document.body.insertBefore(frmContextMenu);
		}
		
		frmContextMenu.width = liWidth;
		frmContextMenu.height = liHeight + 4;
		frmContextMenu.style.top = liTop;
		frmContextMenu.style.left = liLeft;
		frmContextMenu.style.visibility = "visible";
		frmContextMenu.src = COMM_PATH + "ContextMenu.jsp?CMID=" + aContextMenuID;
	}
	catch (e)
	{
		C_msgOk("CM_ContextMenuShow ���� : " + e.message, "����");
		return;
	}
}

function CM_ContextMenuHide(aContextMenuID, aMenuID)
{
	var frmContextMenu = null;
	var oContextMenu = null;
	
	try
	{
		if (C_isNull(aContextMenuID))
		{
			C_msgOk("ContextMenuID�� ��(Null) �Դϴ�.");
			return;
		}
		
		frmContextMenu = document.getElementById("CM_" + aContextMenuID);
		
		if (frmContextMenu != null)
		{
			frmContextMenu.style.visibility = "hidden";
		}
		
		oContextMenu = CM_getContextMenu(aContextMenuID);
		
		if (oContextMenu == null) return;
		
		try
		{
			if (!C_isNull(aMenuID)) OnContextMenuAfter(aContextMenuID, aMenuID, oContextMenu.FlexGrid);
		}
		catch (e)
		{
			if (typeof(OnContextMenuAfter) == "function")
			{
				C_msgOk("OnContextMenuAfter ������ ���� �Լ� Call ���� : " + e.message, "����");
				return;
			}
			else
			{
				C_msgOk("OnContextMenuAfter ������ ���� �Լ��� �������� �ʽ��ϴ�.", "����");
				return;
			}
		}
		
		oContextMenu.FlexGrid.focus();
	}
	catch (e)
	{
		C_msgOk("CM_ContextMenuShow ���� : " + e.message, "����");
		return;
	}
}

function CM_OnMouseDown(aFlexGrid, button, shift, x, y, cancel)
{
	var eventObj = null;
	
	try
	{
		eventObj = document.createEventObject();
		eventObj.button = button;
		aFlexGrid.fireEvent("onclick", eventObj);
	}
	catch (e)
	{
		C_msgOk("CM_OnMouseDown ���� : " + e.message, "����");
	}
}

function CM_OnClick(aFlexGrid)
{
	try
	{
		if (CM_arrContextMenu == null || CM_arrContextMenu.length < 1) return;
		
		for (var i = 0; i < CM_arrContextMenu.length; i++)
		{
			if (CM_arrContextMenu[i].FlexGrid == aFlexGrid)
			{
				if (event.button == 2)
				{
					CM_ContextMenuShow(CM_arrContextMenu[i].ContextMenuID);
				}
				else
				{
					CM_ContextMenuHide(CM_arrContextMenu[i].ContextMenuID);
				}
				
				return;
			}
		}
	}
	catch (e)
	{
		C_msgOk("CM_OnClick ���� : " + e.message, "����");
	}
}

function CM_OnBlur()
{
	var frmContextMenu = null;
	
	try
	{
		if (CM_arrContextMenu == null || CM_arrContextMenu.length < 1) return;
		
		for (var i = 0; i < CM_arrContextMenu.length; i++)
		{
			frmContextMenu = document.getElementById("CM_" + CM_arrContextMenu[i].ContextMenuID);
		
			if (frmContextMenu != null)
			{
				frmContextMenu.style.visibility = "hidden";
			}
		}
	}
	catch (e)
	{
		C_msgOk("CM_OnBlur ���� : " + e.message, "����");
	}
}
