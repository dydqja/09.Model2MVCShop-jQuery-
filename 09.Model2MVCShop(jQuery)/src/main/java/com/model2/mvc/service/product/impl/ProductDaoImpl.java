package com.model2.mvc.service.product.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.user.UserDao;


//==> 상품관리 DAO CRUD 구현
@Repository("productDaoImpl")
public class ProductDaoImpl implements ProductDao{
	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		System.out.println("ProductDaoImpl에서 setsqlSession 실행됨");
//		System.out.println("sqlSession 값은 = "+ sqlSession);
		this.sqlSession = sqlSession;
	}
	
	///Constructor
	public ProductDaoImpl() {
		System.out.println(this.getClass());
	}

	///Method
	public void addProduct(Product product) throws Exception {
		System.out.println("ProductDaoImpl에서 addProduct 실행됨");
//		System.out.println("product 값은 = "+ product);
		sqlSession.insert("ProductMapper.addProduct", product);
		
	}		

	public Product getProduct(int prodNo) throws Exception {
		System.out.println("ProductDaoImpl에서 getProduct 실행됨");
//		System.out.println("prodNo 값은 = "+ prodNo);
		return sqlSession.selectOne("ProductMapper.getProduct", prodNo);
	}
		
	public void updateProduct(Product product) throws Exception {
		System.out.println("ProductDaoImpl에서 updateProduct 실행됨");
		System.out.println("product 값은 = "+ product);
		sqlSession.update("ProductMapper.updateProduct", product);
	}
	
	public List<Product> getList(Search search) throws Exception {
		System.out.println("ProductDaoImpl에서 getList 실행됨");
		return sqlSession.selectList("ProductMapper.getList", search);
	}

	// 게시판 Page 처리를 위한 전체 Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception {
		System.out.println("ProductDaoImpl에서 getTotalCount 실행됨");
		return sqlSession.selectOne("ProductMapper.getTotalCount", search);
	}
	
}