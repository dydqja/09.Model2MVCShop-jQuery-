package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.user.UserService;
import com.model2.mvc.service.user.UserDao;;


//==> 상품관리 서비스 구현
@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService{
	
	///Field
	@Autowired
	@Qualifier("productDaoImpl")
	private ProductDao productDao;
	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}
	
	///Constructor
	public ProductServiceImpl() {
		System.out.println(this.getClass());
	}

	///Method
	public void addProduct(Product product) throws Exception {
		System.out.println("ProductServiceImpl에서 addProduct 실행됨");
//		System.out.println("product 값은 = "+ product);
		productDao.addProduct(product);
	}

	public Product getProduct(int prodNo) throws Exception {
		System.out.println("ProductServiceImpl에서 getProduct 실행됨");
//		System.out.println("prodNo 값은 = "+ prodNo);
		return productDao.getProduct(prodNo);
	}
	
	public Map<String , Object > getList(Search search) throws Exception {
		System.out.println("ProductServiceImpl에서 getProductList 실행됨");
		System.out.println("search 값은 =" +search);
		List<Product> list= productDao.getList(search);
		int totalCount = productDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	public void updateProduct(Product product) throws Exception {
		System.out.println("ProductServiceImpl에서 updateProduct 실행됨");
		System.out.println("product 값은 = "+ product);
		productDao.updateProduct(product);
	}
	/* #######################################################################################
	public boolean checkDuplication(String userId) throws Exception {
		System.out.println("UserServiceImpl에서 checkDuplication 실행됨");
		boolean result=true;
		User user=userDao.getUser(userId);
		if(user != null) {
			result=false;
		}
		return result;		
	}
	########################################################### */

	
		
	
}