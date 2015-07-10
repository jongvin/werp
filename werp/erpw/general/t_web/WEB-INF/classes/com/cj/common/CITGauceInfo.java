package com.cj.common;

import java.sql.*;
import javax.servlet.http.*;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.db.*;
import com.gauce.log.*;

import com.cj.database.*;

public class CITGauceInfo
{
	public ServiceLoader loader = null;
	public GauceService service = null;
	public GauceContext context = null;
	public Logger logger = null;
	//2004-11-23  현재 사용 안함
	//public GauceDBConnection connection = null;
	public GauceRequest request = null;
	public GauceResponse response = null;
	
	public CITGauceInfo(HttpServletRequest aRequest, HttpServletResponse aResponse) throws Exception
	{
		try
		{
			this.loader = new ServiceLoader(aRequest, aResponse);
			this.service = loader.newService();
			this.context = service.getContext();
			this.logger = context.getLogger();
			//this.connection = service.getDBConnection();
			this.request = service.getGauceRequest();
			this.response = service.getGauceResponse();
		}
		catch (Exception ex)
		{
			throw new Exception ("CITGauceInfo Constructor Error : " + ex.getMessage());
		}
	}
}