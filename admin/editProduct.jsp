<%@ page import="java.sql.*" %>
<%@ include file="adminHeader.jsp"%>
<%@ include file="../footer.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTM
<html>
<head>
<link rel="stylesheet" href="../css/addNewProduct-style.css">
<title>Add New Product</title>
<style>
.back
{
  color: white;
  margin-left: 2.5%
}
</style>
</head>
<body>
 <h2><a class="back" href="allProductEditProduct.jsp"><i class='fas fa-arrow-circle-left'> Back</i></a></h2>

<%
String id = request.getParameter("id");

try{
        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1522:xe","system","abc123");

        String sql = "select * from product where id ='"+id+"'";
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        while(rs.next()){

       

%>
<form method="post">
<input type="hidden" name="idb" value=<%out.println(id);%>>
<div class="left-div">
 <h3>Enter Name</h3>
 <input class="input-style" type="text" name="name" value="<%=rs.getString(2)%>" required>

<hr>
</div>

<div class="right-div">
<h3>Enter Category</h3>
 
 <input class="input-style" type="text" name="category" value="<%=rs.getString(3)%>" required>

<hr>
</div>

<div class="left-div">
<h3>Enter Price</h3>
 
 <input class="input-style" type="text" name="price" value="<%=rs.getString(4)%>" required>

<hr>
</div>

<div class="right-div">
<h3>Active</h3>

<select class="input-style" name="active">
<option value="Yes">Yes</option>
<option value="No">No</option>

</select>
 <hr>
</div>
<button class="button" name="b1">Save <i class='far fa-arrow-alt-circle-right'></i></button>
</form>
<%
 }


}catch(Exception e){
  
}

%>

<%
if(request.getParameter("b1")!=null){
String idb=request.getParameter("idb");
String name=request.getParameter("name");
String category=request.getParameter("category");
String price=request.getParameter("price");
String active=request.getParameter("active");
try{
      DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
      Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1522:xe","system","abc123");

      String sql = "update product set name='"+name+"' , category ='"+category+"',price='"+price+"',active='"+active+"' where id='"+id+"'";
      Statement stmt = con.createStatement();
      stmt.executeUpdate(sql);
      if(active.equals("No")){
        stmt.executeUpdate("delete from cart where product_id='"+id+"' and address is NULL");
      }
      response.sendRedirect("allProductEditProduct.jsp?msg=done");

}catch(Exception e){
  System.out.println(e);
  response.sendRedirect("allProductEditProduct.jsp?msg=wrong");
}



}
%>

</body>
<br><br><br>
</body>
</html>