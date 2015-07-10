package com.cj.database;

import java.util.*;
import java.sql.*;
import javax.naming.*;
import javax.sql.*;
import oracle.jdbc.pool.*;

import com.cj.database.*;
import com.cj.common.*;

/*데이타베이스 접속관리자 클래스*/
public class CITConnectionManager
{
	public CITConnectionManager()
	{
	}

	public static void main(String[] args) throws Exception
	{
		/*
		System.out.println("hsm001 : " + getConnection("hsm001").isClosed());
		System.out.println("hsm001 : " + getConnection("hsm001").isClosed());
		System.out.println("hsm002 : " + getConnection("hsm002").isClosed());
		System.out.println("hsm002 : " + getConnection("hsm002").isClosed());
		System.out.println("hsm002 : " + getConnection("hsm002").isClosed());
		System.out.println("hsm002 : " + getConnection("hsm002").isClosed());
		System.out.println("pools size : " + pools.size());
		*/
	}

	public static Connection getConnection() throws SQLException, Exception
	{
		//return getConnection(CITDatabase.DEFAULT_DATA_SOURCE, true);
		return getConnection(CITDatabase.getDataSourceName(), true);
	}

	public static Connection getConnection(String asDataSource) throws SQLException, Exception
	{
		return getConnection(asDataSource, true);
	}

	public static Connection getConnection(boolean abAutoCommit) throws SQLException, Exception
	{
		return getConnection(CITDatabase.getDataSourceName(), abAutoCommit);
	}

	public static Connection getConnection(String asDataSource, boolean abAutoCommit) throws SQLException, Exception
	{
		Connection conn = null;

		try
		{
			InitialContext initContext = new InitialContext();
			//Context envContext = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)initContext.lookup(asDataSource);
			conn = ds.getConnection();
		}
		catch (Exception ex)
		{
			throw new SQLException ("CITConnectionManager getConnection Error : " + ex.getMessage());
		}

		conn.setAutoCommit(abAutoCommit);

		return conn;
	}

	public static Connection getConnection(String asUser, String asPassword) throws SQLException, Exception
	{
		return getConnection(asUser, asPassword, true);
	}

	public static Connection getConnection(String asUser, String asPassword, boolean abAutoCommit) throws SQLException, Exception
	{
		Connection conn = null;

		try
		{
			InitialContext initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:/comp/env");
			OracleDataSource ds = (OracleDataSource)envContext.lookup(CITDatabase.getDataSourceName());
			conn = ds.getConnection(asUser, asPassword);
		}
		catch (Exception ex)
		{
			throw new SQLException ("CITConnectionManager getConnection Error : " + ex.getMessage());
		}

		conn.setAutoCommit(abAutoCommit);

		return conn;
	}
	
	public static void freeConnection(Connection aConnection) throws SQLException
	{
		try
		{
			if (aConnection != null)
			{
				if (!aConnection.getAutoCommit())
				{
					aConnection.rollback();
				}

				aConnection.close();
				aConnection = null;
			}
		}
		catch (SQLException ex)
		{
			throw new SQLException ("CITConnectionManager freeConnection Error : " + ex.getMessage());
		}
	}

	public static boolean isUseConnection(Connection aConnection)
	{
		Statement stat = null;

		try
		{
			if (aConnection.isClosed())
			{
				return false;
			}
			else
			{
				try
				{
					stat = aConnection.createStatement();
					stat.close();
				}
				catch (SQLException ex)
				{
					return false;
				}
			}
		}
		catch (SQLException ex)
		{
			return false;
		}

		return true;
	}
	
	public static OracleConnectionPoolDataSource getConnectionPool(String asDataSource) throws Exception
	{
		return null;
	}
	
	public static Vector getConnectionPools() throws Exception
	{
		return null;
	}

	public static void clearConnectionPools() throws Exception
	{
	}
}