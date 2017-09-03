package product.model.dao;

import static common.JDBCTemplate.*;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import product.model.vo.Product;

public class ProductDao {

	private Properties prop = new Properties();
	
	public ProductDao(){
		try {
			prop.load(new FileReader("properties/query.properties"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

	public ArrayList<Product> selectId(Connection conn, String pId) {
		Product product = null;
		ArrayList<Product> list = new ArrayList<Product>();
		PreparedStatement pstmt = null;
		ResultSet result = null;
		String query = prop.getProperty("selectId");
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, "%"+pId+"%");
			result = pstmt.executeQuery();
			while(result.next()){
				product = new Product(result.getString("P_ID"),result.getString("P_NAME"),result.getInt("P_PRICE"),result.getString("P_DESCRIPTION"));
				list.add(product);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(result);
			close(pstmt);
		}		
		return list;		
	}	

	public ArrayList<Product> selectName(Connection conn, String pName) {
		Product product = null;
		ArrayList<Product> list = new ArrayList<Product>();
		PreparedStatement pstmt = null;
		ResultSet result = null;
		String query = prop.getProperty("selectName");
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, "%"+pName+"%");
			result = pstmt.executeQuery();
			while(result.next()){
				product = new Product(result.getString("P_ID"),result.getString("P_NAME"),result.getInt("P_PRICE"),result.getString("P_DESCRIPTION"));
				list.add(product);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(result);
			close(pstmt);
		}		
		return list;	
	}
	
	public ArrayList<Product> selectList(Connection conn) {
		Product product = null;
		ArrayList<Product> list = new ArrayList<Product>();
		PreparedStatement pstmt = null;
		ResultSet result = null;
		String query = prop.getProperty("selectList");
		try {
			pstmt = conn.prepareStatement(query);
			result = pstmt.executeQuery();
			while (result.next()) {// 조회해온 결과의 BOF 다음 값이 있다면
				product = new Product(result.getString("P_ID"),result.getString("P_NAME"),result.getInt("P_PRICE"),result.getString("P_DESCRIPTION"));
				list.add(product);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(result);
			close(pstmt);
		}
		return list;
	}


	public ArrayList<Product> descendingName(Connection conn) {
		Product product = null;
		ArrayList<Product> list = new ArrayList<Product>();
		PreparedStatement pstmt = null;
		ResultSet result = null;
		String query = prop.getProperty("descendingName");
		try {
			pstmt = conn.prepareStatement(query);
			result = pstmt.executeQuery();
			while (result.next()) {// 조회해온 결과의 BOF 다음 값이 있다면
				product = new Product(result.getString("P_ID"),result.getString("P_NAME"),result.getInt("P_PRICE"),result.getString("P_DESCRIPTION"));
				list.add(product);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(result);
			close(pstmt);
		}
		return list;
	}


	public ArrayList<Product> ascendingName(Connection conn) {
		Product product = null;
		ArrayList<Product> list = new ArrayList<Product>();
		PreparedStatement pstmt = null;
		ResultSet result = null;
		String query = prop.getProperty("ascendingName");
		try {
			pstmt = conn.prepareStatement(query);
			result = pstmt.executeQuery();
			while (result.next()) {// 조회해온 결과의 BOF 다음 값이 있다면
				product = new Product(result.getString("P_ID"),result.getString("P_NAME"),result.getInt("P_PRICE"),result.getString("P_DESCRIPTION"));
				list.add(product);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(result);
			close(pstmt);
		}
		return list;
	}


	public ArrayList<Product> descendingPrice(Connection conn) {
		Product product = null;
		ArrayList<Product> list = new ArrayList<Product>();
		PreparedStatement pstmt = null;
		ResultSet result = null;
		String query = prop.getProperty("descendingPrice");
		try {
			pstmt = conn.prepareStatement(query);
			result = pstmt.executeQuery();
			while (result.next()) {// 조회해온 결과의 BOF 다음 값이 있다면
				product = new Product(result.getString("P_ID"),result.getString("P_NAME"),result.getInt("P_PRICE"),result.getString("P_DESCRIPTION"));
				list.add(product);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(result);
			close(pstmt);
		}
		return list;
	}


	public ArrayList<Product> ascendingPrice(Connection conn) {
		Product product = null;
		ArrayList<Product> list = new ArrayList<Product>();
		PreparedStatement pstmt = null;
		ResultSet result = null;
		String query = prop.getProperty("ascendingPrice");
		try {
			pstmt = conn.prepareStatement(query);
			result = pstmt.executeQuery();
			while (result.next()) {// 조회해온 결과의 BOF 다음 값이 있다면
				product = new Product(result.getString("P_ID"),result.getString("P_NAME"),result.getInt("P_PRICE"),result.getString("P_DESCRIPTION"));
				list.add(product);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(result);
			close(pstmt);
		}
		return list;
	}


	public String getLastId(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet result = null;
		String query = prop.getProperty("getLastId");
		String lastId = null;
		try {
			pstmt = conn.prepareStatement(query);
			result = pstmt.executeQuery();
			if(result.next()){
				lastId = result.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(result);
			close(pstmt);
		}
		return lastId;
	}


	public int insertProduct(Connection conn, Product product) {
		PreparedStatement pstmt = null;
		String query = prop.getProperty("insertProduct");
		int result = 0;
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, product.getpId());
			pstmt.setString(2, product.getpName());
			pstmt.setInt(3, product.getPrice());
			pstmt.setString(4, product.getDescription());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			close(pstmt);
		}		
		if(result>0){
			commit(conn);
		}else{
			rollback(conn);
		}
		return result;
	}


	public int deleteProduct(Connection conn, String pId) {
		PreparedStatement pstmt = null;
		String query = prop.getProperty("deleteProduct");
		int result = 0;
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, pId);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			close(pstmt);
		}		
		if(result>0){
			commit(conn);
		}else{
			rollback(conn);
		}
		return result;
	}


	public int updateProduct(Connection conn, Product product) {
		PreparedStatement pstmt = null;
		String query = prop.getProperty("updateProduct");
		int result = 0;
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, product.getpName());
			pstmt.setInt(2, product.getPrice());
			pstmt.setString(3, product.getDescription());
			pstmt.setString(4, product.getpId());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			close(pstmt);
		}		
		if(result>0){
			commit(conn);
		}else{
			rollback(conn);
		}
		return result;
	}




}
