<%@ page import="java.sql.*" %>
<%@ include file="header.jsp"%>
<%@ include file="footer.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home</title>
<style>
body{
  background-image: url('https://ordinaryfaith.net/wp-content/uploads/2016/03/Gray-plain-website-background.jpg');
  background-repeat: no-repeat;
  background-size: cover;

}
</style>
</head>
<body>
<div style="color: white; text-align: center; font-size: 30px;">My Orders <i class='fab fa-elementor'></i></div>
<table>
        <thead>
          <tr>
            <th scope="col">S.No</th>
            <th scope="col">Product Name</th>
            <th scope="col">category</th>
            <th scope="col"><i class="fa fa-inr"></i>  Price</th>
            <th scope="col">Quantity</th>
            <th scope="col"><i class="fa fa-inr"></i> Sub Total</th>
            <th scope="col">Order Date</th>
             <th scope="col">Expected Delivery Date</th>
             <th scope="col">Payment Method</th>
              <th scope="col">Status</th>
              
          </tr>
        </thead>
        <tbody>
        <%
        int sno=0;
        try{
          DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1522:xe","system","abc123");

        String sql = "select * from cart inner join product on cart.product_id=product.id and cart.email = '"+email+"' and cart.orderDate is not NULL ORDER BY orderDate DESC";

        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        while(rs.next()){
          sno = sno+1;
        
        
        %>
          <tr>
            <td><%out.println(sno);%></td>
            <td><%=rs.getString(17)%></td>
            <td><%=rs.getString(18)%></td>
            <td><i class="fa fa-inr"></i> <%=rs.getString(19)%></td>
            <td><%=rs.getString(3)%></td>
            <td><i class="fa fa-inr"></i> <%=rs.getString(5)%></td>
             <td><%=rs.getString(11)%></td>
              <td><%=rs.getString(12)%></td>
               <td><%=rs.getString(13)%></td>
               <td><%=rs.getString(15)%></td>
            </tr>

<%
        }
        }
        catch(Exception e){
          System.out.println(e);
        }
%>

        </tbody>
      </table>
      <br>
      <br>
      <br>

</body>
</html>