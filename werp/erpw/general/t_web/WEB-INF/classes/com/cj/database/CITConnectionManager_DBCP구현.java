package com.cj.database;

import java.util.*;
import java.sql.*;
import javax.sql.*;
import oracle.jdbc.pool.*;

import com.cj.database.*;
import com.cj.common.*;

/*单捞鸥海捞胶 立加包府磊 努贰胶*/
public class CITConnectionManager
{
	protected static Vector pools = null;

	public CITConnectionManager()
	{
	}

	public static void main(String[] args) throws Exception
	{
		/*
		System.out.println("acms : " + getConnection("acms", "acms").isClosed());
		System.out.println("ccms : " + getConnection("ccms", "ccms").isClosed());
		System.out.println("iams : " + getConnection("iams", "iams").isClosed());
		System.out.println("pools size : " + pools.size());
		System.out.println("acms : " + getConnection("acms").isClosed());
		System.out.println("ccms : " + getConnection("ccms").isClosed());
		System.out.println("iams : " + getConnection("iams").isClosed());
		System.out.println("pools size : " + pools.size());

		for (int i = 0; i < 10000; i++)
		{
			System.out.println("acms : " + getConnection("acms", "acms").isClosed());
			System.out.println("ccms : " + getConnection("ccms", "ccms").isClosed());
			System.out.println("iams : " + getConnection("iams", "iams").isClosed());
			System.out.println("pools size : " + pools.size());
		}
		*/
	}

	/*货肺款 ConnectionPoolDataSource 积己*/
	private static OracleConnectionPoolDataSource newConnectionPoolDataSource(String asDataSource) throws Exception
	{
		return newConnectionPoolDataSource(asDataSource, CITDatabase.getURL(asDataSource), CITDatabase.getUser(asDataSource), CITDatabase.getPassword(asDataSource));
	}

	private static OracleConnectionPoolDataSource newConnectionPoolDataSource(String asDataSource, String asURL, String asUser, String asPassword) throws Exception
	{
		OracleConnectionPoolDataSource newPool = new OracleConnectionPoolDataSource();

		newPool.setDataSourceName(asDataSource);
		newPool.setURL(asURL);
		newPool.setUser(asUser);
		newPool.setPassword(asPassword);

		return newPool;
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
		//return getConnection(CITDatabase.DEFAULT_DATA_SOURCE, abAutoCommit);
		return getConnection(CITDatabase.getDataSourceName(), abAutoCommit);
	}

	public static Connection getConnection(String asDataSource, boolean abAutoCommit) throws SQLException, Exception
	{
		Connection conn = null;
		OracleConnectionPoolDataSource pool = null;

		if (pools == null)
		{
			pools = new Vector();
		}

		for (int i = 0; i < pools.size(); i++)
		{
			OracleConnectionPoolDataSource tmpPool = (OracleConnectionPoolDataSource)pools.get(i);

			if (tmpPool.getDataSourceName().equals(asDataSource))
			{
				pool = tmpPool;
				break;
			}
		}

		if (pool == null)
		{
			pool = newConnectionPoolDataSource(asDataSource);
			pools.add(pool);
		}
		
		try
		{
			PooledConnection pc = pool.getPooledConnection();
			conn = pc.getConnection();
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
		OracleConnectionPoolDataSource pool = null;

		if (pools == null)
		{
			pools = new Vector();
		}

		for (int i = 0; i < pools.size(); i++)
		{
			OracleConnectionPoolDataSource tmpPool = (OracleConnectionPoolDataSource)pools.get(i);

			if (tmpPool.getDataSourceName().equals(asUser))
			{
				pool = tmpPool;
				break;
			}
		}

		if (pool == null)
		{
			//pool = newConnectionPoolDataSource(asUser, CITDatabase.getURL(CITDatabase.DEFAULT_DATA_SOURCE), asUser, asPassword);
			pool = newConnectionPoolDataSource(asUser, CITDatabase.getURL(), asUser, asPassword);
			pools.add(pool);
		}

		try
		{
			PooledConnection pc = pool.getPooledConnection(asUser, asPassword);
			conn = pc.getConnection();
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
		OracleConnectionPoolDataSource pool = null;

		if (pools == null) return null;

		for (int i = 0; i < pools.size(); i++)
		{
			pool = (OracleConnectionPoolDataSource)pools.get(i);

			if (pool.getDataSourceName().equals(asDataSource))
			{
				break;
			}
		}

		return pool;
	}

	public static Vector getConnectionPools() throws Exception
	{
		return pools;
	}

	public static void clearConnectionPools() throws Exception
	{
		if (pools != null) pools.clear();
	}
}