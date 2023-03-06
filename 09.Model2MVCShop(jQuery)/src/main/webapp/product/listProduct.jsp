<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--    
<%@ page import="java.util.*"  %>

<%@ page import="com.model2.mvc.service.domain.Product" %>
<%@ page import="com.model2.mvc.common.Search" %>
<%@ page import="com.model2.mvc.common.Page"%>
<%@ page import="com.model2.mvc.common.util.CommonUtil"%>
<%@ page import="com.model2.mvc.service.domain.Product"%>

	
	

<%
	List<Product> list= (List<Product>)request.getAttribute("list");
	Page resultPage=(Page)request.getAttribute("resultPage");

	Search search = (Search)request.getAttribute("search");
	//==> null 을 ""(nullString)으로 변경
	String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());

/*	HashMap<String,Object> map=(HashMap<String,Object>)request.getAttribute("map");
	Search search=(Search)request.getAttribute("search");
	
	int total=0;
	ArrayList<Product> list=null;
	if(map != null){
		total=((Integer)map.get("count")).intValue();
		list=(ArrayList<Product>)map.get("list");
	}
	
	int currentPage=search.getCurrentPage();
	
	int totalPage=0;
	if(total > 0) {
		totalPage= total / search.getPageSize() ;
		if(total%search.getPageSize() >0)
			totalPage += 1;
	} */
	
%> --%>

<!DOCTYPE html>

<html>

<head>
	<meta charset="EUC-KR">
	<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

	//=====기존Code 주석 처리 후  jQuery 변경 ======//
	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용
	function fncGetList(currentPage) {
		//document.getElementById("currentPage").value = currentPage;
		$("#currentPage").val(currentPage)
   		//document.detailForm.submit();
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${menu}").submit();
	}
	//===========================================//
	//==> 추가된부분 : "검색" ,  userId link  Event 연결 및 처리
	 $(function() {
			 
			//==> 검색 Event 연결처리부분
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함. 
			$( "td.ct_btn01:contains('검색')" ).on("click", function() {
					//Debug..
					//alert(  $( "td.ct_btn01:contains('검색')" ).html() );
					
					fncGetList(${ search.currentPage })		
			});
			
			$("#yeon_ho").on("keydown", function(e) {
				  if (e.keyCode === 13) {
					    e.preventDefault();
					    fncGetList(${ search.currentPage })		
					  };
			});
	 
			
			//==> prodName LINK Event 연결처리
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 3 과 1 방법 조합 : $(".className tagName:filter함수") 사용함.
			$( ".ct_list_pop td:nth-child(3)" ).on("click", function() {					
				//Debug..				
				//console.log( $(this) ); // <== 이 값을 이용해서, 자식에게 접근?
										  // <== this로 접근하는게 아닌, 해당 태그로 바로
										  //	 접근하면 넘버값이 고정돼버림.										  
				//alert( $(this).children('input').val()); // this로 접근. prodNo 정상출력				
				//alert( $(this).children('input').attr('value')); // this로 접근. prodNo 정상출력
																   // .val() == .attr('value') ??? 
				//alert( $('#input[name="product"]').val()); // undefined 나옴. 접근태그 잘못쓴것같음.
				//alert( $('input[name="product"]').attr('value')); // 해당 태그로 바로 접근
					  											    // prodNo는 출력되나, 고정돼버림.
						if(${menu=='manage'}) {					
							self.location ="/product/updateProductView?prodNo="+$(this).children('input').val()+"&menu="+$($(this).children('input')[1]).val()					
											
						}else{					
							self.location ="/product/getProduct?prodNo="+$(this).children('input').val()+"&menu="+$($(this).children('input')[1]).val()				
					
						}														
			});
			
			//==> UI 수정 추가부분  :  userId LINK Event End User 에게 보일수 있도록 
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			$("h7").css("color" , "red");
			
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
			
	 });

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
				<%--<% if(menu.equals("manage")) {%>				
					<td width="93%" class="ct_ttl01">상품 관리</td>
					<%}else{ %>
					<td width="93%" class="ct_ttl01">상품 목록조회</td>
					<%} %> --%>
					
					<c:choose>
						<c:when test = "${menu=='manage' }">
						<td width="93%" class="ct_ttl01">상품 관리</td>
						</c:when>
						<c:otherwise>
						<td width="93%" class="ct_ttl01">상품 목록조회</td>
						</c:otherwise>
					</c:choose>					
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>	
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">		
			<%--<option value="0" <%= (searchCondition.equals("0") ? "selected" : "") %>>상품명</option>
				<option value="0" <%= (searchCondition.equals("1") ? "selected" : "") %>>상품코드</option> --%>
				
				<option value="0" ${ ! empty searchCondition && search.searchCondition==0 ? "selected" : "" }>상품명</option>
				<option value="1" ${ ! empty searchCondition && search.searchCondition==1 ? "selected" : "" }>상품코드</option>				
			</select>
		<%--<input 	type="text" name="searchKeyword"  value="<%= searchKeyword %>" --%> 
			<input id="yeon_ho"	type="text" name="searchKeyword" 
					value="${ ! empty search.searchKeyword ? search.searchKeyword :""}"
							class="ct_input_g" style="width:200px; height:19px" >
		</td>	
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23"></td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
					<%--<a href="javascript:fncGetProductList('<%=search.getCurrentPage()%>');">검색</a> --%>
					<!--	<a href="javascript:fncGetList('${ search.currentPage }');">검색</a> -->
					검색
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>		
		<%--전체  <%= resultPage.getTotalCount() %> 건수, 현재 <%= resultPage.getCurrentPage() %> 페이지 --%>
		<td colspan="11" >
			전체  ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명<br>
		<c:choose>
			<c:when test = "${menu=='manage'}">
				<h7 >(상품명 click<br>:상품수정)</h7>
			</c:when>
			<c:otherwise>
				<h7 >(상품명 click<br>:상세정보)</h7>
			</c:otherwise>
		</c:choose>
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">등록일</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">현재상태</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	
<%--<% 	
		for(int i=0; i<list.size(); i++) {
			Product vo = list.get(i);
	%>		
	<tr class="ct_list_pop">
		<td align="center"><%= i + 1 %></td>
		<td></td>
		<td align="left">
	<% if(menu.equals("manage")) {%>
		<a href="/updateProductView.do?prodNo=<%=vo.getProdNo() %>&menu=<%= menu %>"><%=vo.getProdName() %></a>		
	<%}else{ %>		
		<a href="/getProduct.do?prodNo=<%=vo.getProdNo() %>&menu=<%= menu %>"><%=vo.getProdName() %></a>			
		</td>
	<%} %>
		<td></td>
		<td align="left"><%= vo.getPrice() %></td>
		<td></td>
		<td align="left"><%= vo.getManuDate() %></td>
		<td></td>
		<td align="left"><%= vo.getProTranCode() %>		
		</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	<% } %> --%>	
	
	<c:set var="i" value="0" />
	<c:forEach var="product" items="${list}" >
		
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>
			<td align="left">
			<input type="hidden" id="product" name="product" value="${product.prodNo}"/>
			<input type="hidden" id="menu" name="menu" value="${param.menu}"/> 
			<!--			
	 		<c:choose>
				<c:when test = "${menu=='manage'}">
				<td align="left"><a href="/product/updateProductView?prodNo=${ product.prodNo }&menu=${ menu }">${ product.prodName }</a></td>
				</c:when>
				<c:otherwise>
				
				<td align="left"><a href="/product/getProduct?prodNo=${ product.prodNo }&menu=${ menu }">${ product.prodName }</a></td>
				</c:otherwise>
			</c:choose>
			 -->
			 ${product.prodName}
			 </td>
			<td></td>
		<td align="left">${ product.price }</td>
		<td></td>
		<td align="left">${ product.manuDate }</td>
		<td></td>
		<td align="left">${ product.proTranCode }		
		</td>
	</tr>
	<tr>
	<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	</c:forEach>	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		 <input type="hidden" id="currentPage" name="currentPage" value=""/>
		<%--<% if( resultPage.getCurrentPage() <= resultPage.getPageUnit() ){ %>
					◀ 이전
			<% }else{ %>
					<a href="javascript:fncGetProductList('<%=resultPage.getCurrentPage()-1%>')">◀ 이전</a>
			<% } %>

			<%	for(int i=resultPage.getBeginUnitPage();i<= resultPage.getEndUnitPage() ;i++){	%>
					<a href="javascript:fncGetProductList('<%=i %>');"><%=i %></a>
			<% 	}  %>
	
			<% if( resultPage.getEndUnitPage() >= resultPage.getMaxPage() ){ %>
					이후 ▶
			<% }else{ %>
					<a href="javascript:fncGetProductList('<%=resultPage.getEndUnitPage()+1%>')">이후 ▶</a>
			<% } %> --%>
		<%--###### pageNavigator if문 돌려보기 실패 ######
 		<jsp:include page="../common/pageNavigator.jsp?uri=${ uri }"/>
		--%>	
		<jsp:include page="../common/pageNavigator.jsp"/>
    	</td>
	</tr>
</table>

</form>

</div>
</body>
</html>
    