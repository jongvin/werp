import java.lang.*;
import java.io.*;

public class ExecCommand 
{

	public static void main(String[] args) 
	{
        Process command_process ;
        
		try
		{
			switch( args.length ) {
				case 1 : command_process = Runtime.getRuntime().exec( "cmd /c " + args[0] );	
						 break;

				case 2 : command_process = Runtime.getRuntime().exec( "cmd /c " + args[0] + " " + args[1] );	
						 break;

				case 3 : command_process = Runtime.getRuntime().exec( "cmd /c " + args[0] + " " + args[1] + " " + args[2] );	
						 break;
				
				case 4 : command_process = Runtime.getRuntime().exec( "cmd /c " + args[0] + " " + args[1] + " " + args[2] + " " + args[3] );	
						 break;

			}
			
		}
		catch (Exception e)
		{

		}
	
	}

	public static String exec(String args) 
	{
        Process command_process ;
        String filepath = "<<ALL FILES>>"; 
        String actionStr = "execute"; 
        FilePermission prsn = new  FilePermission(filepath, actionStr); 
        boolean isprsn=false;

           try
	   {
              isprsn = prsn.implies(prsn);
              command_process = Runtime.getRuntime().exec( "cmd /c " + args );	
              return("OK");
			
	   }
	   catch (Exception e)
	   {
              return(e.toString());
	   }
	
	}

}
