package product.model.service;

import java.sql.Connection;
import java.util.ArrayList;
import product.model.dao.ProductDao;
import product.model.vo.Product;
import static common.JDBCTemplate.*;

public class ProductService {

	private ProductDao pDao = new ProductDao();

	public Product selectId(String pId) {
		// TODO Auto-generated method stub
		return null;
	}

	public ArrayList<Product> selectAllList() {
		Connection conn = getConnection();
		ArrayList<Product> list = pDao.selectList(conn);
		close(conn);
		return list;
	}
	
}
