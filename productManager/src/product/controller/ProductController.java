package product.controller;

import java.util.ArrayList;

import product.model.service.ProductService;
import product.model.vo.Product;
import product.view.ProductView;

public class ProductController {

	private ProductService pService = new ProductService();

	public ArrayList<Product> selectId(String pId) {
		ArrayList<Product> list = pService.selectId(pId);
		if (list.size() > 0) {
			return list;
		} else {
			return null;
		}
	}

	public ArrayList<Product> selectName(String pName) {
		ArrayList<Product> list = pService.selectName(pName);
		if (list.size() > 0) {
			return list;
		} else {
			return null;
		}
	}

	public ArrayList<Product> selectAll() {
		ArrayList<Product> list = pService.selectAllList();
		if (list.size() > 0) {
			return list;
		} else {
			return null;
		}
	}

	public void insertProduct(String pId, String pName, int price, String pDescription) {
		Product product = new Product(pId, pName, price, pDescription);
		int result = pService.insertProduct(product);
		if (result > 0) {
			System.out.println("정상적으로 추가되었습니다.");
		} else {
			System.out.println("추가에 실패하였습니다.");
		}
	}

	public void updateProduct(String pId, String pName, int price, String pDescription) {
		Product product = new Product(pId, pName, price, pDescription);
		int result = pService.updateProduct(product);
		if (result > 0) {
			System.out.println("정상적으로 갱신되었습니다.");
		} else {
			System.out.println("갱신에 실패하였습니다.");
		}
	}

	public void deleteProduct(String pId) {
		int result = pService.deleteProduct(pId);
		if (result > 0) {
			System.out.println("정상적으로 삭제되었습니다.");
		} else {
			System.out.println("삭제에 실패하였습니다.");
		}
	}

	public ArrayList<Product> descendingName() {
		ArrayList<Product> list = pService.descendingName();
		if (list.size() > 0) {
			return list;
		} else {
			return null;
		}
	}

	public ArrayList<Product> ascendingName() {
		ArrayList<Product> list = pService.ascendingName();
		if (list.size() > 0) {
			return list;
		} else {
			return null;
		}
	}

	public ArrayList<Product> descendingPrice() {
		ArrayList<Product> list = pService.descendingPrice();
		if (list.size() > 0) {
			return list;
		} else {
			return null;
		}
	}

	public ArrayList<Product> ascendingPrice() {
		ArrayList<Product> list = pService.ascendingPrice();
		if (list.size() > 0) {
			return list;
		} else {
			return null;
		}
	}

	public String getLastId() {
		String lastId = pService.getLastId();
		if (lastId != null) {
			return lastId;
		} else {
			return null;
		}
	}

	public ArrayList<Product> priceTop3() {
		ArrayList<Product> list = pService.priceTop3();
		if (list.size() > 0) {
			return list;
		} else {
			return null;
		}
	}
}
