package product.model.service;

import java.sql.Connection;
import java.util.ArrayList;
import product.model.dao.ProductDao;
import product.model.vo.Product;
import static common.JDBCTemplate.*;

public class ProductService {

	private ProductDao pDao = new ProductDao();

	public ArrayList<Product> selectId(String pId) {
		Connection conn = getConnection();
		ArrayList<Product> list = pDao.selectId(conn,pId);
		close(conn);
		return list;
	}
	
	public ArrayList<Product> selectName(String pName) {
		Connection conn = getConnection();
		ArrayList<Product> list = pDao.selectName(conn,pName);
		close(conn);
		return list;
	}

	public ArrayList<Product> selectAllList() {
		Connection conn = getConnection();
		ArrayList<Product> list = pDao.selectList(conn);
		close(conn);
		return list;
	}

	public ArrayList<Product> descendingName() {
		Connection conn = getConnection();
		ArrayList<Product> list = pDao.descendingName(conn);
		close(conn);
		return list;
	}

	public ArrayList<Product> ascendingName() {
		Connection conn = getConnection();
		ArrayList<Product> list = pDao.ascendingName(conn);
		close(conn);
		return list;
	}

	public ArrayList<Product> descendingPrice() {
		Connection conn = getConnection();
		ArrayList<Product> list = pDao.descendingPrice(conn);
		close(conn);
		return list;
	}

	public ArrayList<Product> ascendingPrice() {
		Connection conn = getConnection();
		ArrayList<Product> list = pDao.ascendingPrice(conn);
		close(conn);
		return list;
	}

	public String getLastId() {
		Connection conn = getConnection();
		String lastId = pDao.getLastId(conn);
		close(conn);
		return lastId;
	}

	public int insertProduct(Product product) {
		Connection conn = getConnection();
		int result = pDao.insertProduct(conn,product);
		close(conn);
		return result;
	}

	public int deleteProduct(String pId) {
		Connection conn = getConnection();
		int result = pDao.deleteProduct(conn,pId);
		close(conn);
		return result;
	}

	public int updateProduct(Product product) {
		Connection conn = getConnection();
		int result = pDao.updateProduct(conn,product);
		close(conn);
		return result;
	}

	
	
}
