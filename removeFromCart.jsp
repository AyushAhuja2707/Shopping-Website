<%@ page import="java.sql.*" %>

<%
String email = session.getAttribute("email").toString();
String product_id = request.getParameter("id");

try{
DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1522:xe","system","abc123");
    String sql = "delete from cart where email = '"+email+"' and product_id = '"+product_id+"' and address is null";
    Statement stmt = con.createStatement();
    stmt.executeUpdate(sql);
    response.sendRedirect("myCart.jsp?msg=removed");


}catch(Exception e){
    response.sendRedirect("myCart.jsp?msg=error");

}



%>