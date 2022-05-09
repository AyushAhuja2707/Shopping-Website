<%@ page import="java.sql.*" %>
<%@ include file="header.jsp"%>
<%@ include file="footer.jsp"%>


<%
String em = session.getAttribute("email").toString();
String product_id = request.getParameter("id");
int quantity = 1;
int product_price = 0;
int product_total = 0;
int cart_total = 0;

int z = 0;

    try{
        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1522:xe","system","abc123");

        String sql = "select * from product where id ='"+product_id+"'";
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        while(rs.next()){
            product_price=rs.getInt(4);
            product_total=product_price;

        }
        ResultSet rs1 = stmt.executeQuery("select * from cart where product_id ="+product_id+" and email='"+em+"' and address is NULL");
        while(rs1.next()){
            System.out.println("In");
            cart_total=rs1.getInt(5);
            cart_total = cart_total + product_total;
            quantity = rs1.getInt(3);
            quantity = quantity+1;
            z = 1;

        }
        if(z==1){
            stmt.executeQuery("update cart set total ='"+cart_total+"',quantity='"+quantity+"' where product_id='"+product_id+"'and email='"+email+"' and address is NULL");
            response.sendRedirect("home.jsp?msg=exist");
        }
        if(z==0){
            PreparedStatement ps = con.prepareStatement("insert into cart(email,product_id,quantity,price,total) values(?,?,?,?,?)");
            ps.setString(1,em);
            ps.setString(2,product_id);
            ps.setInt(3,quantity);
            ps.setInt(4,product_price);
            ps.setInt(5,product_total);
            ps.executeUpdate();
            response.sendRedirect("home.jsp?msg=added");

        }


}catch(Exception e){
    System.out.println(e);
    response.sendRedirect("home.jsp?msg=invalid");

}

%>