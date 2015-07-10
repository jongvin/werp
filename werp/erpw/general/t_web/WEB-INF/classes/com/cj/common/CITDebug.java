package		com.cj.common;
import	java.io.*;
import	java.util.*;
import	java.io.InputStream;
import	java.io.OutputStream;
public	class	CITDebug
{
	protected	static	final String	LOGFILENAME = "Error.log";
	public	static	String	getCurrentDateTime()
	{
		Calendar rightNow = Calendar.getInstance();
		return (new Integer(rightNow.get(Calendar.YEAR))).toString()+"."+
				(new Integer(rightNow.get(Calendar.MONTH) + 1)).toString()+"."+
				(new Integer(rightNow.get(Calendar.DATE))).toString()+" "+
				(new Integer(rightNow.get(Calendar.HOUR_OF_DAY))).toString()+":"+
				(new Integer(rightNow.get(Calendar.MINUTE))).toString()+":"+
				(new Integer(rightNow.get(Calendar.SECOND))).toString()+" "+
				(new Integer(rightNow.get(Calendar.MILLISECOND))).toString();
	}
	public		static	void	PrintMessages(String	lsMessage)
	{
		try
		{
			lsMessage = getCurrentDateTime() + "==> \r\n"+lsMessage;
			BufferedWriter bwList = null;
		
			bwList = new BufferedWriter(new FileWriter(LOGFILENAME,true));
			bwList.write(lsMessage);
			bwList.newLine();
			
			bwList.flush();
			bwList.close();
		}
		catch(Exception e)
		{
		}
	}
}