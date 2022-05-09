
<%@ page import="java.sql.*" %>
<%@ include file="adminHeader.jsp"%>
<%@ include file="../footer.jsp"%>
<html>
<head>
<link rel="stylesheet" href="../css/addNewProduct-style.css">
<title>Add New Product</title>
<style>
body{
  background-image: url('https://ordinaryfaith.net/wp-content/uploads/2016/03/Gray-plain-website-background.jpg');
  background-repeat: no-repeat;
  background-size: cover;

}
</style>
</head>
<body>
<%
String msg = request.getParameter("msg");
if("done".equals(msg))
{
%>
<h3 class="alert">Product Added Successfully!</h3>
<%
}
%>
<%
if("wrong".equals(msg))
{
%>
<h3 class="alert">Some thing went wrong! Try Again!</h3>
<%
}
%>
<%
int id = 1;
try{
        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1522:xe","system","abc123");

        String sql = "select max(id) from product";
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        while(rs.next()){
            id = rs.getInt(1);
            id = id+1;

        }

}catch(Exception e){

}
%>
<form method="post">

<h3 style="color: yellow;">Product ID: <% out.println(id);%> </h3>
<input type="hidden" name="idb" value="<%out.println(id); %>">

<div class="left-div">
 <h3>Enter Name</h3>
 <input class="input-style" type = "text" name="name" placeholder="Enter Name" required> 
<hr>
</div>

<div class="right-div">
<h3>Enter Category</h3>
 
 <input class="input-style" type = "text" name="category" placeholder="Enter Category" required>
<hr>
</div>

<div class="left-div">
<h3>Enter Price</h3>

 <input class="input-style" type = "number" name="price" placeholder="Enter Price" required>
 
<hr>
</div>

<div class="right-div">
<h3>Active</h3>
<select class="input-style" name="active">
<option value="Yes">Yes</option>
<option value = "No"> No
</option>
</select>
<hr>
</div>
 <button class="button" name="b1">Save<i class='far fa-arrow-alt-circle-right'></i></button>
</form>
<%
    
 if(request.getParameter("b1")!=null){
     String idb = request.getParameter("idb");
     String name = request.getParameter("name");
     String category = request.getParameter("category");
     String price = request.getParameter("price");
     String active = request.getParameter("active");
     System.out.println(active);

     try{

          DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
                Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1522:xe","system","abc123");
                
                String sqli = "insert into product values(?,?,?,?,?)";
                 
                PreparedStatement pst = con.prepareStatement(sqli);
                System.out.println("idb->"+idb);
                pst.setInt(1,Integer.parseInt(idb.trim()));
                pst.setString(2,name);
                pst.setString(3,category);
                pst.setString(4,price);
                pst.setString(5,active);

                pst.executeUpdate();

                response.sendRedirect("addNewProduct.jsp?msg=done");


     }catch(Exception e){

        System.out.println(e);
        response.sendRedirect("addNewProduct.jsp?msg=wrong");

     }
 
 
 }

%>




</body>
<br><br><br>
</body>
</html>