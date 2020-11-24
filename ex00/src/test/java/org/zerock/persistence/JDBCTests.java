package org.zerock.persistence;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class JDBCTests {

	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	private String coninfo = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
	private String idinfo = "kjh";
	private String pwdinfo = "1211";
	
	@Test
	public void testConnection() {
		
		
		
		try(Connection conn = DriverManager.getConnection(coninfo, idinfo, pwdinfo)){
				log.info(conn);
		} catch( Exception e) {
			e.printStackTrace();
		}
	}
}
