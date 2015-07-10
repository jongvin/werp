<%@ LANGUAGE="VBSCRIPT" %>

<%
'=======================================================================
' WORKING WITH THE REPORT DESIGNER COMPONENT AND ASP TO EXPORT A REPORT
'=======================================================================
'
' CONCEPT                                                             
'                                                                     
'  ALWAYS REQUIRED STEPS (contained in AlwaysRequiredSteps.asp)
'   - create the application object                                
'   - create the report object                                     
'   - open the report                                              
'
'  EXPORTING A REPORT
'   - set a variable to reference the ExportOptions Object of the report
'   - set the ExportOptions for the report including the export destination and export type
'   - redirect the user to the newly exported file so they are prompted to download or view
'     the file
'
'  MORE ALWAYS REQUIRED STEPS (contained in MoreRequiredSteps.asp)
'   - retreive the records                                         
'   - create the page engine 
'
'  DISPLAY THE REPORT
'   - display the report using a smart viewer
'==================================================================
%>

<%
' This line creates a string variable called reportname that we will use to pass
' the Crystal Report filename (.rpt file) to the OpenReport method contained in 
' the AlwaysRequiredSteps.asp.

'생성 리포트명
if request("con_gb") = "1" then		'일반품의
	if request("mod") = "" or request("mod") = "0" then
		reportname = "PURNewConsult.rpt"
	else
		reportname = "PURModConsult.rpt"
	end if
else								'단가품의
	reportname = "PURUnitConsult.rpt"	
end if
%>

<%
'==================================================================
' ALWAYS REQUIRED STEPS
'
' Include the file AlwaysRequiredSteps.asp which contains the code    
' for steps:
'   - create the application object
'   - create the report object
'   - open the report
'==================================================================
%>                                                                     
<!-- #include file="../AlwaysRequiredSteps.asp" -->                       
<%
'리포드 파일에 파라미터값 지정
'The following section shows setting single valued parameters of various data types.
Session("oRpt").ParameterFields.GetItemByName("cst_info_id").AddCurrentValue(Clng(request("cst")))
Session("oRpt").ParameterFields.GetItemByName("mod_no").AddCurrentValue(Clng(request("mod")))
Session("oRpt").ParameterFields.GetItemByName("corp_name_len").AddCurrentValue(8)
Session("oRpt").ParameterFields.GetItemByName("acct_cat_code").AddCurrentValue(CStr(request("acct_cat_code")))

'==================================================================
' EXPORTING A REPORT
'==================================================================

Set CrystalExportOptions = Session("oRpt").ExportOptions
'This line of code set a variable to reference the ExportOptions Object.

'The variables below (ExportFileName, ExportDirectory, ReportCacheVirtualDirectory,
'and ExportType) are used as follows:
'  - ExportFileName is the actual file name that should be created by the export process
'  - ExportDirectory is the physical directory where the ExportFileName will be placed
'  - ExportType is a number that specifies the type of file that the export process should
'    create.  For a list of these numbers, please refer to the Crystal Reports Report Design Component
'    help file (crrdc.hlp) in the "ExportOptions Object for the Object Model" section.  Scroll down to 
'    the ExportType property.  To change the type of file that the export process should be creating, change 
'    the value in the ExportType variable, and change the last portion of the ExportFileName 
'    variable.  The example here exports a .doc file, which is a Word file, which is the 
'    ExportType "14".
'
'    Some export types have other properties in the ExportOptions object that require values
'    to be set.  For example exporting to HTML.  This type will require that you will also 
'    set the HTMLFileName property.  For detailed information on which properties to set, 
'    refer to the "ExportOptions Object" topic in the help file (crrdc.hlp)

'파일명칭생성
filename = request("cst_doc_no") & "-" & request("mod")

'리포트 파일에서 변환해서 파일생성/화면출력할 파일명칭
'ExportFileName = "ExportedReport.doc"
ExportFileName = filename & ".pdf"


'Path = Request.ServerVariables("PATH_TRANSLATED")                     
'While (Right(Path, 1) <> "\" And Len(Path) <> 0)                      
'iLen = Len(Path) - 1                                                  
'Path = Left(Path, iLen)                                               
'Wend

'The While/Wend loop is used to determine the physical location
'of the SimpleReportExport.asp so that we can save the 
'ExportedReport.doc in the same location.                                                                  




'ExportDirectory = Path & "doc\"  
'ExportDirectory = "C:\hwenc\ips\repository\pdffiles\PURConsult\"
ExportDirectory = "C:\hwenc\ips\repository\pdffiles\PURConsult\" & request("cst_doc_no") & "\" 

'폴더생성
Set Fso = Server.CreateObject("Scripting.FileSystemObject")

'발주번호
If Not Fso.FolderExists(ExportDirectory) Then
	Fso.CreateFolder(ExportDirectory)   
End if

'변경차수
If Not Fso.FolderExists(ExportDirectory & request("mod") & "\") Then
	Fso.CreateFolder(ExportDirectory & request("mod")  & "\")   
End if

Set Fso = nothing




'파일타입지정
'ExportType = "14"			'doc 파일
ExportType = "31"			'pdf 파일

'Response.Write ExportDirectory
'Response.flush
'Response.end

CrystalExportOptions.DiskFileName = ExportDirectory  & request("mod") & "\" & ExportFileName
'This line of code specifies the physical location and file name to give
'the export result.

CrystalExportOptions.FormatType = CInt(ExportType)
'This line of code specifies the export format (in this case MS Word).

CrystalExportOptions.DestinationType = CInt(1)
'This line of code specifies that the export destinatin is to be disk.

Session("oRpt").Export False                    
'This line of code turns of any prompting when exporting.
'Response.Write ExportDirectory & ExportFileName
'Response.End


'Response.Redirect ("./doc/" & ExportFileName)
'Response.Redirect ("/pdffiles/PURConsult/" & ExportFileName)
Response.Redirect ("/pdffiles/PURConsult/" & request("cst_doc_no") & "/" & request("mod") & "/" & ExportFileName)
'This line of code redirects the URL to the newly exported file.
'It is important to remember that the exporting is taking place on the web server
'so we need to redirect the user to the newly exported file or they will never
'have access to that file.
%>
