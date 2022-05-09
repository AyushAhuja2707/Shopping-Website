<%@ page import="java.sql.*" %>

<%
String email = session.getAttribute("email").toString();
String id = request.getParameter("id");
String incdec = request.getParameter("quantity");
int price = 0;
int total = 0;
int quantity = 0;
int final_total = 0;
try{
    DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1522:xe","system","abc123");
    String sql = "select * from cart where email = '"+email+"' and product_id = '"+id+"' and address is null";
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        while(rs.next()){

            price = rs.getInt(4);
            total = rs.getInt(5);
            quantity = rs.getInt(3);

        }
    System.out.println("Quantity -> "+quantity);
    if(quantity==1 && incdec.equals("dec")){
        response.sendRedirect("myCart.jsp?msg=notPossible");
    }
    else if(quantity!=1 && incdec.equals("dec")){
        total = total - price;
        quantity = quantity - 1;
        stmt.executeUpdate("update cart set total ="+total+",quantity="+quantity+" where email = '"+email+"' and product_id = '"+id+"' and address is null");
        response.sendRedirect("myCart.jsp?msg=dec");

    }else{
        total = total + price;
        quantity = quantity + 1;
        stmt.executeUpdate("update cart set total ="+total+",quantity ="+quantity+" where email ='"+email+"' and product_id = '"+id+"' and address is null");
        response.sendRedirect("myCart.jsp?msg=inc");


    }


}catch(Exception e){
    
    response.sendRedirect("myCart.jsp?msg=except");

    System.out.println(e.getMessage());
}

%>