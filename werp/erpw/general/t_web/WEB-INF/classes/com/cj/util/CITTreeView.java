/*
	프로그램명 : 트리뷰구현
	파일명     : CITTreeViewjava
	최초작성자 : 김흥수
	최초작성일 : 2004-06-25
	주요사항   : 

	최종수정자 : 
	최종수정일 : 
	수정사항   : 
*/
package com.cj.util;

import	java.util.*;
import	com.cj.util.*;
import	com.cj.common.*;

public	class	CITTreeView
{
	public	static	void	main(String[] args)
	{
		CITTreeView		lrTree = new CITTreeView();
		lrTree.TableWidth = "400";
		lrTree.TreeImagePath = "images/Tree/";
		lrTree.addColumn("현장", 300, "");
		lrTree.addColumn("비고", 100, "");
		lrTree.addNode(10, 0, true, new String [] {"동문건설(주)", ""});
		lrTree.addNode(2, 10, true, new String [] {"현장", ""});
		lrTree.addNode(5, 2, false, new String [] {"사리현", ""});
		lrTree.addNode(6, 2, false, new String [] {"일산", ""});
		lrTree.addNode(30, 6, false, new String [] {"일산-굿모닝힐 1단지", ""});
		lrTree.addNode(31, 6, false, new String [] {"일산-굿모닝힐 2단지", ""});
		lrTree.addNode(3, 10, false, new String [] {"총무부", ""});
		lrTree.addNode(4, 10, false, new String [] {"주택사업부", ""});
		lrTree.addNode(20, 4, false, new String [] {"주택사업부-A팀", "팀장:홍길동"});
		lrTree.addNode(21, 4, false, new String [] {"주택사업부-B팀", "팀장:강감찬"});
		String	strTree = lrTree.CreateHtml();
		System.out.println(strTree);
		lrTree.TableWidth = "760";
		lrTree.TableHeight = "393";
		lrTree.TitleHeight = "16";
		strTree = lrTree.CreateHtmlSplitScroll();
		System.out.println(strTree);
	}
	public	String	TreeName = "tree";
	public	String	TableWidth;
	public	String	TableHeight;
	public	String	TitleHeight;
	public	int		FixedCol = 0;
	public	String	TreeImagePath;

	private TreeMap Nodes;
	private TreeMap NodeInx;
	private ArrayList Columns;
	private int[]	TreeStack;
	private int		TreeStackSize;
	private int		intArrCnt;
	private boolean bolSwitch;
	private String strScript;

	private static String ICON_COLLAPSE_END = "icon_collapse_end.gif";
	private static String ICON_COLLAPSE_MORE = "icon_collapse_more.gif";
	private static String ICON_EXPAND_END = "icon_expand_end.gif";
	private static String ICON_EXPAND_MORE = "icon_expand_more.gif";
	private static String ICON_CONNECT_END = "icon_connect_end.gif";
	private static String ICON_CONNECT_MORE = "icon_connect_more.gif";
	private static String ICON_CONNECT_BRIDGE = "icon_connect_bridge.gif";
	private static String ICON_EMPTY = "icon_empty.gif";
	private static String ICON_FOLDER_CLOSE = "icon_folder_close.gif";

	int		intLeftDivWidth;
	int		intRightTitleDivWidth;
	int		intRightDataDivWidth;
	int		intRightTableWidth;
	int		intLeftTableHeight;
	int		intRightTableHeight;
	int		intTitleHeight;
	int		intTableHeight;
	int		intTableWidth;
	int		intRightColumnWidthTotal;

	public CITTreeView()
	{
		Nodes = new TreeMap();
		NodeInx = new TreeMap();
		Columns = new ArrayList();
		TreeStack = new int[1024];
		bolSwitch = true;
	}

	public void addColumn(String asTitle, int aiWidth, String asAlign)
	{
		CITTreeColumn lrColumn = new CITTreeColumn();
		lrColumn.title = asTitle;
		lrColumn.width = aiWidth;
		lrColumn.align = asAlign;
		Columns.add(lrColumn);
	}

	public void addNode(int adID, int adPID, boolean abExpand, String [] asNodeText)
	{
		addNode(adID, adPID, abExpand, asNodeText, "");
	}
	
	public void addNode(int adID, int adPID, boolean abExpand, String [] asNodeText, String asValue)
	{
		CITTreeNode lrNewNode = new CITTreeNode();
		CITTreeNode lrNode;

		NodeInx.put(new Integer(adID), new Integer(adPID));

		lrNewNode.id = adID;
		lrNewNode.pid = adPID;
		lrNewNode.nodetext = asNodeText;
		lrNewNode.expand = abExpand;
		lrNewNode.value = asValue.replaceAll("'", "").replaceAll("\"", "").replaceAll("\r", "").replaceAll("\n", "").replaceAll(",", "");

		if (adPID == 0)
		{
			Nodes.put(new Integer(adID), lrNewNode);
		}
		else
		{
			TreeStack[0] = adID;
			TreeStackSize = 1;

			while (((Integer)NodeInx.get(new Integer(    TreeStack[TreeStackSize - 1]    ))).intValue() != 0)
			{
				TreeStack[TreeStackSize] = ((Integer)NodeInx.get(new Integer(TreeStack[TreeStackSize - 1]))).intValue();
				TreeStackSize++;
			}

			lrNode = (CITTreeNode)Nodes.get(new Integer(TreeStack[TreeStackSize - 1]));

			TreeStackSize--;

			lrNode = (CITTreeNode)Nodes.get(new Integer(TreeStack[TreeStackSize]));

			while (lrNode.id != adPID)
			{
				TreeStackSize--;
				lrNode = (CITTreeNode)lrNode.ChildNode.get(new Integer(TreeStack[TreeStackSize]));
			}

			TreeStackSize = 0;
			lrNode.ChildNode.put(new Integer(adID), lrNewNode);
		}
	}

	private	static	String	toIntString(int i)
	{
		return (new Integer(i)).toString();
	}
	public String CreateHtmlSplitScroll()
	{
		String lsHtml = "";
		String lsHtmlLeftTitle = "";
		String lsHtmlRightTitle = "";
		String lsHtmlLeftData = "";
		String lsHtmlRightData = "";
		String lsTdStyle;
		String lsDivScrollFunctionName = TreeName + "divDataRight_onScroll()";

		CITTreeColumn lrColumn;
		intLeftDivWidth = 0;
		intRightTitleDivWidth = 0;
		intRightDataDivWidth = 0;
		intRightTableWidth = 0;
		intLeftTableHeight = 0;
		intRightTableHeight = 0;
		intTitleHeight = Integer.parseInt(TitleHeight);
		intTableHeight = Integer.parseInt(TableHeight);
		intTableWidth = Integer.parseInt(TableWidth);
		intRightColumnWidthTotal = 0;
		intLeftDivWidth = 0;
		intRightTableWidth = 0;
		for ( int i = 0 ; i < Columns.size() ; i ++)
		{
			lrColumn = (CITTreeColumn)Columns.get(i);
			if(i <= FixedCol)
			{
				intLeftDivWidth += lrColumn.width;
			}
			else
			{
				intRightTableWidth += lrColumn.width;
			}
		}
		intRightDataDivWidth = intTableWidth - intLeftDivWidth;
		intRightTitleDivWidth = intRightDataDivWidth - 16;
		intRightTableHeight = intTableHeight - intTitleHeight;
		intLeftTableHeight = intRightTableHeight - 16;
		intArrCnt = 0;
		strScript = "<script language='javascript'>\n"+
						"function	"+lsDivScrollFunctionName+"\n"+
						"{\n"+
						"	divDataLeft.scrollTop = divDataRight.scrollTop;\n"+
						"	divTitleRight.scrollLeft = divDataRight.scrollLeft;\n"+
						"}\n"+
						"var	arrRowID = new Array();\n";
		strScript += "strTreeImagePath = '" + TreeImagePath + "';\n";

		lsHtml += "<table id='"+TreeName +"' onmouseover=\"document.body.style.cursor='default';\" onmouseout=\"document.body.style.cursor='default';\" border='0' cellpadding='0' cellspacing='0' width='" + TableWidth + "' height='"+TableHeight+"' >";
		lsHtmlLeftTitle = 	"<td><DIV id='divTitleLeft' style='OVERFLOW: hidden; WIDTH:"+ toIntString(intLeftDivWidth)+"px ' >\n"+
							"<table border='0' cellpadding='0' cellspacing='0' width='"+toIntString(intLeftDivWidth)+"'>\n"+
							"<thead style='background-color:buttonface; height:"+TitleHeight+"px'>\n"+
							"<tr>\n";
		lsHtmlRightTitle =	"<td><DIV id='divTitleRight' style='OVERFLOW: hidden; WIDTH: "+toIntString(intRightTitleDivWidth)+"px '>\n"+
							"<table border='0' cellpadding='0' cellspacing='0' width='"+toIntString(intRightTableWidth)+"'>\n"+
							"<thead style='background-color:buttonface; height:"+TitleHeight+"px'>\n"+
							"<tr>\n";
		lsTdStyle = "border-top:1px solid #404040; border-left:0px solid #404040; border-bottom:0px solid #404040;";

		for (int i = 0; i < Columns.size(); i++)
		{
			lrColumn = (CITTreeColumn)Columns.get(i);


			if(i <= FixedCol)
			{
				lsHtmlLeftTitle += "<td style='" + lsTdStyle + "' nowrap width='" + (lrColumn.width ) + "'>\n";
				lsHtmlLeftTitle += "<table border='0' cellpadding='0' cellspacing='0' width='100%' height='100%'>\n";
				lsHtmlLeftTitle += "<tr><td style='border:1px outset; padding-left:3px; padding-right:3px' ";
				lsHtmlLeftTitle += "nowrap align='" + lrColumn.align + "'>" + lrColumn.title + "</td></tr>\n</table></td>\n";
			}
			else
			{
				lsHtmlRightTitle += "<td style='" + lsTdStyle + "' nowrap width='" + (lrColumn.width )+ "'>\n";
				lsHtmlRightTitle += "<table border='0' cellpadding='0' cellspacing='0' width='100%' height='100%'>\n";
				lsHtmlRightTitle += "<tr><td style='border:1px outset; padding-left:3px; padding-right:3px' ";
				lsHtmlRightTitle += "nowrap align='" + lrColumn.align + "'>" + lrColumn.title + "</td></tr>\n</table></td>\n";
				intRightColumnWidthTotal += lrColumn.width;
			}
		}
		if(intRightColumnWidthTotal < intRightTitleDivWidth)
		{
			lsHtmlRightTitle += "<td style='" + lsTdStyle + "' nowrap width='" + (intRightTitleDivWidth - intRightColumnWidthTotal) + "'>\n";
			lsHtmlRightTitle += "<table border='0' cellpadding='0' cellspacing='0' width='100%' height='100%'>\n";
			lsHtmlRightTitle += "<tr><td style='border:1px outset; padding-left:3px; padding-right:3px' ";
			lsHtmlRightTitle += "nowrap align='center'>&nbsp;</td></tr>\n</table></td>\n";
		}
		lsHtmlLeftTitle += "</tr></thead></table></DIV></td>";
		lsHtmlRightTitle += "</tr></thead></table></DIV></td>";
		lsHtml += "<tr>"+lsHtmlLeftTitle+lsHtmlRightTitle+"</tr><tr valign='top'>";
		
		lsHtmlLeftData =	"<td><DIV id='divDataLeft' style='OVERFLOW: hidden; WIDTH: "+ toIntString(intLeftDivWidth)+"px ; HEIGHT:"+ toIntString(intLeftTableHeight)+"px'>\n"+
							"<table border='0' cellpadding='0' cellspacing='0' width='"+ toIntString(intLeftDivWidth)+"'>\n"+
							"<tbody style='text-indent: 4px'>";

		lsHtmlRightData =	"<td><DIV id='divDataRight' style='OVERFLOW: scroll; WIDTH: "+ toIntString(intRightDataDivWidth)+"px ; HEIGHT:"+ toIntString(intRightTableHeight)+"px' onscroll='"+lsDivScrollFunctionName+"'>\n"+
							"<table border='0' cellpadding='0' cellspacing='0' width='"+ toIntString(intRightTableWidth)+"'>\n"+
							"<tbody style='text-indent: 4px'>";
		
		Object[]		lrNodes = Nodes.values().toArray();
		boolean			bloBack = bolSwitch;
		for (int i = 0; i < lrNodes.length; i++)
		{
			bolSwitch = bloBack;
			bloBack = bolSwitch;
			lsHtmlLeftData += getBranchSplitLeft((CITTreeNode)lrNodes[i]);
			bolSwitch = bloBack;
			lsHtmlRightData += getBranchSplitRight((CITTreeNode)lrNodes[i]);
			bloBack = bolSwitch;
		}
		lsHtmlLeftData += "</tbody></table></DIV></td>";
		lsHtmlRightData += "</tbody></table></DIV></td>";
		lsHtml += lsHtmlLeftData + lsHtmlRightData+"</tr></table>";
		strScript += "</script>\n";

		return strScript + lsHtml;
	}
	public String CreateHtml()
	{
		String lsHtml = "";
		String lsTdStyle;
		CITTreeColumn lrColumn;

		intArrCnt = 0;
		strScript = "<script language='javascript'>\nvar	arrRowID = new Array();\n";
		strScript += "strTreeImagePath = '" + TreeImagePath + "';\n";

		lsHtml += "<table onmouseover=\"document.body.style.cursor='default';\" onmouseout=\"document.body.style.cursor='default';\" border='0' cellpadding='0' cellspacing='0' width='" + TableWidth + "'>";
		lsHtml += "<thead style='background-color:buttonface;'><tr> \n";

		for (int i = 0; i < Columns.size(); i++)
		{
			lrColumn = (CITTreeColumn)Columns.get(i);

			lsTdStyle = "border-top:1px solid #404040; border-left:1px solid #404040; border-bottom:1px solid #404040;";

			lsHtml += "<td style='" + lsTdStyle + "' nowrap width='" + (lrColumn.width ) + "'>\n";
			lsHtml += "<table border='0' cellpadding='0' cellspacing='0' width='100%' height='100%'>\n";
			lsHtml += "<tr><td style='border:1px outset; padding-left:3px; padding-right:3px' ";
			lsHtml += "nowrap align='" + lrColumn.align + "'>" + lrColumn.title + "</td></tr>\n</table></td>\n";
		}

		lsHtml += "</tr></thead><tbody style='text-indent: 4px'>";
		
		
		Object[]		lrNodes = Nodes.values().toArray();
		for (int i = 0; i < lrNodes.length; i++)
		{
			lsHtml += getBranch((CITTreeNode)lrNodes[i]);
		}

		lsHtml += "</tbody></table>";
		strScript += "</script>\n";

		return strScript + lsHtml;
	}

	private String getBranch(CITTreeNode asNode)
	{
		String lsTemp = "";

		lsTemp += MakeRow(asNode);
		Object[]		lrChildNodes = asNode.ChildNode.values().toArray();
		for (int i = 0; i < lrChildNodes.length; i++)
		{
			lsTemp += getBranch((CITTreeNode)lrChildNodes[i]);
		}

		return lsTemp;
	}

	private String MakeRow(CITTreeNode asNode)
	{
		int ldID;
		String lsRowID = "";
		String lsImage = "";
		String lsTemp = "";
		TreeStackSize = 0;
		boolean isEnd = false;
		boolean isVisible = false;

		TreeMap TmpNodes = null;
		int iKey = 0;

		ldID = asNode.id;

		while (ldID > 0)
		{
			TreeStack[TreeStackSize] = ldID;
			TreeStackSize++;
			ldID = ((Integer)NodeInx.get(new Integer(ldID))).intValue();
		}

		lsRowID = "Row";
		lsTemp += "<tr id=\"Row";

		for (int i = TreeStackSize - 1; i >= 0; i--)
		{
			if (i == TreeStackSize - 1)
			{
				TmpNodes = Nodes;
				iKey = ((Integer)Nodes.lastKey()).intValue();
				isVisible = true;
			}
			else
			{
				if (isVisible)
				{
					isVisible = ((CITTreeNode)TmpNodes.get(new Integer(TreeStack[i + 1]))).expand;
				}

				TmpNodes = ((CITTreeNode)TmpNodes.get(new Integer(TreeStack[i + 1]))).ChildNode;
				iKey = ((Integer)TmpNodes.lastKey()).intValue();
			}

			isEnd = ((CITTreeNode)TmpNodes.get(new Integer(TreeStack[i]))).id == iKey ? true : false;

			lsImage += "<img align=\"absmiddle\" width=\"16\" height=\"16\" src=\"" + TreeImagePath;

			lsRowID += "_" + TreeStack[i];

			if (i > 0)
			{
				lsImage += isEnd ? ICON_EMPTY : ICON_CONNECT_BRIDGE;
			}
			else
			{
				if (asNode.ChildNode.size() > 0)
				{
					if (asNode.expand)
					{
						lsImage += isEnd ? ICON_COLLAPSE_END : ICON_COLLAPSE_MORE;
					}
					else
					{
						lsImage += isEnd ? ICON_EXPAND_END : ICON_EXPAND_MORE;
					}

					lsImage += "\" name=\"" + lsRowID.replaceAll("Row", "Imgl") + "\" onclick=\"TfnTreeShowHide(this,'" + lsRowID + "'," + intArrCnt + ")";
				}
				else
				{
					lsImage += isEnd ? ICON_CONNECT_END : ICON_CONNECT_MORE;
				}
			}

			lsImage += "\">";
			lsTemp += "_" + TreeStack[i];
		}
		
		lsTemp += "\" style=\"color:#000000; ";
		lsTemp += isVisible ? "display:block;\"" : "display:none;\"";
		lsTemp += " bgcolor=\"";

		bolSwitch = bolSwitch ? false : true;

		lsTemp += bolSwitch ? "#F7F8FA\"" : "#FFFFFF\"";
		
		if (asNode.ChildNode.size() > 0)
		{
			lsTemp += " ondblclick=\"TfnTreeShowHide(" + lsRowID.replaceAll("Row", "Imgl") + ",'" + lsRowID + "'," + intArrCnt + ")\" onclick=\"TfnRowSelect(this,'" + lsRowID + "'," + intArrCnt + ")\"><td nowrap>";
		}
		else
		{
			lsTemp += " onclick=\"TfnRowSelect(this,'" + lsRowID + "'," + intArrCnt + ")\"><td nowrap>";
		}
		//lsTemp += " onclick=\"TfnRowSelect(this,'" + lsRowID + "'," + intArrCnt + ")\"><td nowrap>";
		lsTemp += lsImage + "<img" + " name=\"" + lsRowID.replaceAll("Row", "Img") + "\" align=\"absmiddle\" width=\"16\" height=\"16\"";
		lsTemp += "  src=\"" + TreeImagePath + ICON_FOLDER_CLOSE + "\">";
		lsTemp += asNode.nodetext[0] + "</td>";

		CITTreeColumn lrColumn;

		//for (int i = 1; i < asNode.nodetext.Length; i++)
		for (int i = 1; i < Columns.size(); i++)
		{
			lrColumn = (CITTreeColumn)Columns.get(i);

			lsTemp += "<td nowrap";
			lsTemp += " align=\"" + lrColumn.align + "\">" + asNode.nodetext[i] + "</td>";
		}

		lsTemp += "</tr>\n";
		strScript += "arrRowID[" + (new Integer(intArrCnt)).toString() + "] = '" + lsRowID;
		strScript += asNode.expand ? ",true" : ",false";
		strScript += asNode.ChildNode.size() > 0 ? ",true" : ",false";
		strScript += bolSwitch ? ",#F7F8FA" : ",#FFFFFF";
		strScript += "," + asNode.value;
		strScript += "';\n";
		intArrCnt++;

		return lsTemp;
	}
	private String getBranchSplitLeft(CITTreeNode asNode)
	{
		String lsTemp = "";

		lsTemp += MakeRowSplitLeft(asNode);
		Object[]		lrChildNodes = asNode.ChildNode.values().toArray();
		for (int i = 0; i < lrChildNodes.length; i++)
		{
			lsTemp += getBranchSplitLeft((CITTreeNode)lrChildNodes[i]);
		}

		return lsTemp;
	}
	private String getBranchSplitRight(CITTreeNode asNode)
	{
		String lsTemp = "";

		lsTemp += MakeRowSplitRight(asNode);
		Object[]		lrChildNodes = asNode.ChildNode.values().toArray();
		for (int i = 0; i < lrChildNodes.length; i++)
		{
			lsTemp += getBranchSplitRight((CITTreeNode)lrChildNodes[i]);
		}

		return lsTemp;
	}
	private String MakeRowSplitLeft(CITTreeNode asNode)
	{
		int ldID;
		String lsRowID = "";
		String lsImage = "";
		String lsTemp = "";
		String lsEndCode = "";
		TreeStackSize = 0;
		boolean isEnd = false;
		boolean isVisible = false;

		TreeMap TmpNodes = null;
		int iKey = 0;

		ldID = asNode.id;

		while (ldID > 0)
		{
			TreeStack[TreeStackSize] = ldID;
			TreeStackSize++;
			ldID = ((Integer)NodeInx.get(new Integer(ldID))).intValue();
		}

		lsRowID = "Row";
		lsTemp += "<tr height='16' id=\"L_Row";
		lsEndCode = "";

		for (int i = TreeStackSize - 1; i >= 0; i--)
		{
			if (i == TreeStackSize - 1)
			{
				TmpNodes = Nodes;
				iKey = ((Integer)Nodes.lastKey()).intValue();
				isVisible = true;
			}
			else
			{
				if (isVisible)
				{
					isVisible = ((CITTreeNode)TmpNodes.get(new Integer(TreeStack[i + 1]))).expand;
				}

				TmpNodes = ((CITTreeNode)TmpNodes.get(new Integer(TreeStack[i + 1]))).ChildNode;
				iKey = ((Integer)TmpNodes.lastKey()).intValue();
			}

			isEnd = ((CITTreeNode)TmpNodes.get(new Integer(TreeStack[i]))).id == iKey ? true : false;

			lsImage += "<img align=\"absmiddle\" width=\"16\" height=\"16\" src=\"" + TreeImagePath;

			lsRowID += "_" + TreeStack[i];
			lsEndCode += "_" + TreeStack[i];

			if (i > 0)
			{
				lsImage += isEnd ? ICON_EMPTY : ICON_CONNECT_BRIDGE;
			}
			else
			{
				if (asNode.ChildNode.size() > 0)
				{
					if (asNode.expand)
					{
						lsImage += isEnd ? ICON_COLLAPSE_END : ICON_COLLAPSE_MORE;
					}
					else
					{
						lsImage += isEnd ? ICON_EXPAND_END : ICON_EXPAND_MORE;
					}

					lsImage += "\" name='Imgl"+lsEndCode+"' onclick=\"TfnTreeShowHideSplit(this)";
				}
				else
				{
					lsImage += isEnd ? ICON_CONNECT_END : ICON_CONNECT_MORE;
				}
			}

			lsImage += "\">";
			lsTemp += "_" + TreeStack[i];
		}

		lsTemp += "\" style=\"color:#000000; ";
		lsTemp += isVisible ? "display:block;\"" : "display:none;\"";
		lsTemp += " bgcolor=\"";

		bolSwitch = bolSwitch ? false : true;

		lsTemp += bolSwitch ? "#F7F8FA\"" : "#FFFFFF\"";
		
		if (asNode.ChildNode.size() > 0)
		{
			lsTemp += " onclick=\"TfnRowSelectSplit(this)\" ondblclick='TfnTreeShowHideSplit_1(eval(\"Imgl"+lsEndCode+"\"))'><td nowrap>";
		}
		else
		{
			lsTemp += " onclick=\"TfnRowSelectSplit(this)\"><td nowrap>";
		}
		
		lsTemp += lsImage + "<img" + " name=\"" + lsRowID.replaceAll("Row", "Img") + "\" align=\"absmiddle\" width=\"16\" height=\"16\"";
		lsTemp += "  src=\"" + TreeImagePath + ICON_FOLDER_CLOSE + "\">";
		lsTemp += asNode.nodetext[0] + "</td>";

		CITTreeColumn lrColumn;

		for (int i = 1; i <= FixedCol ; i++)
		{
			lrColumn = (CITTreeColumn)Columns.get(i);

			lsTemp += "<td nowrap width='" + (lrColumn.width  ) + "' ";
			lsTemp += " align=\"" + lrColumn.align + "\">" + asNode.nodetext[i] + "</td>";
		}

		lsTemp += "</tr>\n";
		strScript += "arrRowID[" + (new Integer(intArrCnt)).toString() + "] = '" + lsRowID;
		strScript += asNode.expand ? ",true" : ",false";
		strScript += asNode.ChildNode.size() > 0 ? ",true" : ",false";
		strScript += bolSwitch ? ",#F7F8FA" : ",#FFFFFF";
		strScript += "," + asNode.value;
		strScript += "';\n";
		intArrCnt++;

		return lsTemp;
	}
	private String MakeRowSplitRight(CITTreeNode asNode)
	{
		int ldID;
		String lsRowID = "";
		String lsTemp = "";
		String lsEndCode = "";
		TreeStackSize = 0;
		boolean isEnd = false;
		boolean isVisible = false;

		TreeMap TmpNodes = null;
		int iKey = 0;

		ldID = asNode.id;

		while (ldID > 0)
		{
			TreeStack[TreeStackSize] = ldID;
			TreeStackSize++;
			ldID = ((Integer)NodeInx.get(new Integer(ldID))).intValue();
		}

		lsRowID = "Row";
		lsTemp += "<tr  height='16' id=\"R_Row";
		lsEndCode = "";

		for (int i = TreeStackSize - 1; i >= 0; i--)
		{
			if (i == TreeStackSize - 1)
			{
				TmpNodes = Nodes;
				iKey = ((Integer)Nodes.lastKey()).intValue();
				isVisible = true;
			}
			else
			{
				if (isVisible)
				{
					isVisible = ((CITTreeNode)TmpNodes.get(new Integer(TreeStack[i + 1]))).expand;
				}

				TmpNodes = ((CITTreeNode)TmpNodes.get(new Integer(TreeStack[i + 1]))).ChildNode;
				iKey = ((Integer)TmpNodes.lastKey()).intValue();
			}

			isEnd = ((CITTreeNode)TmpNodes.get(new Integer(TreeStack[i]))).id == iKey ? true : false;


			lsRowID += "_" + TreeStack[i];
			lsEndCode += "_" + TreeStack[i];
			lsTemp += "_" + TreeStack[i];
		}

		lsTemp += "\" style=\"color:#000000; ";
		lsTemp += isVisible ? "display:block;\"" : "display:none;\"";
		lsTemp += " bgcolor=\"";

		bolSwitch = bolSwitch ? false : true;

		lsTemp += bolSwitch ? "#F7F8FA\"" : "#FFFFFF\"";
		
		if (asNode.ChildNode.size() > 0)
		{
			lsTemp += " onclick=\"TfnRowSelectSplit(this)\" ondblclick='TfnTreeShowHideSplit_1(eval(\"Imgl"+lsEndCode+"\"))'>";
		}
		else
		{
			lsTemp += " onclick=\"TfnRowSelectSplit(this)\">";
		}

		CITTreeColumn lrColumn;

		for (int i = FixedCol + 1; i < Columns.size() ; i++)
		{
			lrColumn = (CITTreeColumn)Columns.get(i);

			lsTemp += "<td nowrap width='" + (lrColumn.width ) + "' ";
			lsTemp += " align=\"" + lrColumn.align + "\">" + asNode.nodetext[i] + "</td>";
		}
		if(intRightColumnWidthTotal < intRightTitleDivWidth)
		{
			lsTemp += "<td nowrap width='" + (intRightTitleDivWidth - intRightColumnWidthTotal) + "' >&nbsp;</td> ";
		}

		lsTemp += "</tr>\n";

		return lsTemp;
	}
}


class CITTreeNode
{
	public	int		id;
	public	int		pid;
	public	String [] nodetext;
	public	boolean expand;
	public	TreeMap ChildNode;
	public	String value;

	public CITTreeNode()
	{
		ChildNode = new TreeMap();
	}
}

class CITTreeColumn
{
	public String	title;
	public int		width;
	public String	align;
}
