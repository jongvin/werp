declare
lsmail			long;
lsRet			Varchar2(2000);
begin
dbms_output.Enable;
lsmail := '';
lsmail := '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> '||chr(10)||
' <html> '||chr(10)||
' 	<head> '||chr(10)||
' 		<title>�׽�Ʈ����</title> '||chr(10)||
' 	</head> '||chr(10)||
' 	<body> '||chr(10)||
' 		<table width="100%" border="1" cellpadding="0" cellspacing="0"> '||chr(10)||
' 			<tr> '||chr(10)||
' 				<td> '||chr(10)||
' 					���ޱ��� '||chr(10)||
' 				</td> '||chr(10)||
' 				<td> '||chr(10)||
' 					���޾� '||chr(10)||
' 				</td> '||chr(10)||
' 				<td> '||chr(10)||
' 					���� '||chr(10)||
' 				</td> '||chr(10)||
' 				<td> '||chr(10)||
' 					���ް��� '||chr(10)||
' 				</td> '||chr(10)||
' 			</tr> '||chr(10)||
' 			<tr> '||chr(10)||
' 				<td> '||chr(10)||
' 					���� '||chr(10)||
' 				</td> '||chr(10)||
' 				<td> '||chr(10)||
' 					1,000,400 '||chr(10)||
' 				</td> '||chr(10)||
' 				<td> '||chr(10)||
' 					�ϳ����� '||chr(10)||
' 				</td> '||chr(10)||
' 				<td> '||chr(10)||
' 					200-984-048498 '||chr(10)||
' 				</td> '||chr(10)||
' 			</tr> '||chr(10)||
' 			<tr> '||chr(10)||
' 				<td> '||chr(10)||
' 					���� '||chr(10)||
' 				</td> '||chr(10)||
' 				<td> '||chr(10)||
' 					1,000,400 '||chr(10)||
' 				</td> '||chr(10)||
' 				<td> '||chr(10)||
' 					�츮���� '||chr(10)||
' 				</td> '||chr(10)||
' 				<td> '||chr(10)||
' 					200-984-048498 '||chr(10)||
' 				</td> '||chr(10)||
' 			</tr> '||chr(10)||
' 		</table> '||chr(10)||
' 	</body> '||chr(10)||
' <html> ';
lsRet := FBS_UTIL_PKG.mail_send('��öȫ<cholhong@cj.net>',null,'�׽�Ʈ����',lsmail,'Y');
dbms_output.put_line(lsRet);
end;
/
