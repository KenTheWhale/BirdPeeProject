<%-- 
    Document   : AD_Dashboard
    Created on : Jul 27, 2023, 2:09:27 PM
    Author     : Admin
--%>

<%@page import="com.team1.BirdPee.DTO.Customer"%>
<%@page import="com.team1.BirdPee.DTO.Feedback"%>
<%@page import="com.team1.BirdPee.DTO.Product"%>
<%@page import="com.team1.BirdPee.DAO.BirdPeeDAO"%>
<%@page import="com.team1.BirdPee.DTO.Shop"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.team1.BirdPee.DTO.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <link rel="stylesheet" href="css/AD_Dashboard.css">
        <link rel="stylesheet" type="text/css"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
              integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="icon" type="image/x-icon" href="images/logo2.png" />
        <title>BirdPee - Admin</title>
    </head>
    <body>
        <%
            Account ac = (Account) session.getAttribute("user");
            if (ac == null) {
                response.sendRedirect("Login.jsp");
            } else {
                ArrayList<Shop> listShop = BirdPeeDAO.ADMIN_getAllShops();
                ArrayList<Product> listProduct = BirdPeeDAO.ADMIN_getAllProducts();
                ArrayList<Feedback> listReport = BirdPeeDAO.ADMIN_getAllReports();
                ArrayList<Customer> listCustomer = BirdPeeDAO.ADMIN_getAllCustomers();
        %>
        <main>
            <nav class="navbar navbar-expand-lg navbar-light " style="background-color: #76a463; width: 100vw;">
                <nav class="navbar navbar-light" style="background-color: #76a463;">
                    <a class=" navbar-brand d-flex align-items-center" href="AD_Dashboard.jsp">
                        <img src="images/Logo.png" width="75" height="75" class="d-inline-block align-top" alt="">

                    </a>
                </nav>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                        aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item active">
                            <a class="nav-link" style="font-size: larger;" href="AD_ShopManagement.jsp">Manage Shop <span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link" style="font-size: larger;" href="AD_CustomerManagement.jsp">Manage Customer <span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link" style="font-size: larger;" href="AD_ReportManagement.jsp">Manage Report <span class="sr-only">(current)</span></a>
                        </li>


                    </ul>
                    <form class="form-inline my-2 my-lg-0" style="margin-right: 2%;">

                        <a class="nav-link" href="Login.jsp"
                           style="color: black; font-size: 20px; display: flex; align-items: center;gap: 5%;"> <i
                                class="fa-solid fa-right-from-bracket"></i> Logout <span class="sr-only">(current)</span></a>

                    </form>
                </div>
            </nav>
            <div class="container-all">
                <div class="box-overview">
                    <div class="box">
                        <div class="box-desc">
                            <div class="box-desc-number"><%= listShop.size()%></div>
                            <div class="box-desc-name">Shop</div>
                        </div>
                        <div class="box-logo">
                            <i class="fa-solid fa-store"></i>
                        </div>
                    </div>
                    <div class="box">
                        <div class="box-desc">
                            <div class="box-desc-number"><%= listProduct.size()%></div>
                            <div class="box-desc-name">Product</div>
                        </div>
                        <div class="box-logo">
                            <i class="fa-solid fa-cube"></i>
                        </div>
                    </div>
                    <div class="box">
                        <div class="box-desc">
                            <div class="box-desc-number"><%= listReport.size()%></div>
                            <div class="box-desc-name">Report</div>
                        </div>
                        <div class="box-logo">
                            <i class="fa-solid fa-store"></i>
                        </div>
                    </div>
                    <div class="box">
                        <div class="box-desc">
                            <div class="box-desc-number"><%= listCustomer.size()%></div>
                            <div class="box-desc-name">Customer</div>
                        </div>
                        <div class="box-logo">
                            <i class="fa-regular fa-user"></i>
                        </div>
                    </div>
                </div>
                <!-- Shop Revenue -->
                <%
                    ArrayList<String> listSR = BirdPeeDAO.ADMIN_shopRevenueBarChart();
                    for (int i = 0; i < listSR.size(); i++) {
                        String name = listSR.get(i).split("@")[0].trim();
                        String revenue = listSR.get(i).split("@")[1].trim();
                %>
                <input type="hidden" id="SR_title<%= i + 1%>" value="<%= name%>"/>
                <input type="hidden" id="SR_data<%= i + 1%>" value="<%= revenue%>"/>
                <%
                    }
                %>
                <!-- Shop Revenue -->

                <!-- Product Category -->
                <%
                    ArrayList<String> listPC = BirdPeeDAO.ADMIN_productCategoryBarChart();
                    for (int i = 0; i < listPC.size(); i++) {
                        String name = listPC.get(i).split("@")[0].trim();
                        String productAmount = listPC.get(i).split("@")[1].trim();
                %>
                <input type="hidden" id="PC_title<%= i + 1%>" value="<%= name%>"/>
                <input type="hidden" id="PC_data<%= i + 1%>" value="<%= productAmount%>"/>
                <%
                    }
                %>
                <!-- Product Category -->

                <!-- Shop Report -->
                <%
                    ArrayList<String> listSBR = BirdPeeDAO.ADMIN_shopReportBarChart();
                    for (int i = 0; i < listSBR.size(); i++) {
                        String name = listSBR.get(i).split("@")[0].trim();
                        String reportAmount = listSBR.get(i).split("@")[1].trim();
                %>
                <input type="hidden" id="SBR_title<%= i + 1%>" value="<%= name%>"/>
                <input type="hidden" id="SBR_data<%= i + 1%>" value="<%= reportAmount%>"/>
                <%
                    }
                %>
                <!-- Shop Report -->

                <!-- Shop Join -->
                <%
                    ArrayList<String> listSJ = BirdPeeDAO.ADMIN_ShopJoinBarChart();
                    for (int i = 0; i < listSJ.size(); i++) {
                        String month = listSJ.get(i).split("@")[0].trim();
                        String joinAmount = listSJ.get(i).split("@")[1].trim();
                %>
                <input type="hidden" id="SJ_title<%= i + 1%>" value="<%= month%>"/>
                <input type="hidden" id="SJ_data<%= i + 1%>" value="<%= joinAmount%>"/>
                <%
                    }
                %>
                <!-- Shop Join -->
                <div class="chart1-container">
                    <div class="chart-container">
                        <div style="font-size: 20px; margin-left: 30%;font-weight: bold;margin-bottom: 2%;">Top 10 shop's revenue</div>
                        <div id="BC_ShopRevenue" style="width: 100%; height: 400px; padding: 10px 10px 10px 10px; background-color: antiquewhite;box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);"></div>
                    </div>
                    <div class="chart-container">
                        <div style="font-size: 20px; margin-left: 30%;font-weight: bold;margin-bottom: 2%;">Product type on BirdPee</div>
                        <div id="BC_ProductCategory" style="width: 100%; height: 400px;  padding: 10px 10px 10px 10px; background-color: antiquewhite;box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);"></div>
                    </div>
                </div>
                <div class="chart1-container">
                    <div class="chart-container">
                        <div style="font-size: 20px; margin-left: 30%;font-weight: bold;margin-bottom: 2%;">Number of reported shop</div>
                        <div id="BC_ShopReport" style="width: 100%; height: 400px; padding: 10px 10px 10px 10px; background-color: antiquewhite;box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);"></div>
                    </div>
                    <div class="chart-container">
                        <div style="font-size: 20px; margin-left: 30%;font-weight: bold;margin-bottom: 2%;">Shop registered by month</div>
                        <div id="BC_ShopJoin" style="width: 100%; height: 400px; padding: 10px 10px 10px 10px; background-color: antiquewhite;box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);"></div>
                    </div>
                </div>
            </div>
        </main>
        <%
            }
        %>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript">
            let SR_title1 = document.getElementById("SR_title1");
            let SR_title2 = document.getElementById("SR_title2");
            let SR_title3 = document.getElementById("SR_title3");
            let SR_title4 = document.getElementById("SR_title4");
            let SR_title5 = document.getElementById("SR_title5");
            let SR_title6 = document.getElementById("SR_title6");

            let SR_data1 = document.getElementById("SR_data1");
            let SR_data2 = document.getElementById("SR_data2");
            let SR_data3 = document.getElementById("SR_data3");
            let SR_data4 = document.getElementById("SR_data4");
            let SR_data5 = document.getElementById("SR_data5");
            let SR_data6 = document.getElementById("SR_data6");

            if (SR_title1 === null)
                SR_title1 = " ";
            if (SR_title2 === null)
                SR_title2 = " ";
            if (SR_title3 === null)
                SR_title3 = " ";
            if (SR_title4 === null)
                SR_title4 = " ";
            if (SR_title5 === null)
                SR_title5 = " ";
            if (SR_title6 === null)
                SR_title6 = " ";

            if (SR_data1 === null)
                SR_data1 = 0;
            if (SR_data2 === null)
                SR_data2 = 0;
            if (SR_data3 === null)
                SR_data3 = 0;
            if (SR_data4 === null)
                SR_data4 = 0;
            if (SR_data5 === null)
                SR_data5 = 0;
            if (SR_data6 === null)
                SR_data6 = 0;

            google.charts.load('current', {'packages': ['bar']});
            google.charts.setOnLoadCallback(drawStuff);
            function drawStuff() {
                var data = new google.visualization.arrayToDataTable([
                    ['Shop Name', 'VND'],
                    [SR_title1.value, parseFloat(SR_data1.value)],
                    [SR_title2.value, parseFloat(SR_data2.value)],
                    [SR_title3.value, parseFloat(SR_data3.value)],
                    [SR_title4.value, parseFloat(SR_data4.value)],
                    [SR_title5.value, parseFloat(SR_data5.value)],
                    [SR_title6.value, parseFloat(SR_data6.value)]
                ]);
                var options = {

                    legend: {position: 'none'},

                    chartArea: {width: '100%', height: '100%'},
                    bar: {groupWidth: "80%"},
                    bars: 'horizontal',
                };
                var chart = new google.charts.Bar(document.getElementById('BC_ShopRevenue'));
                chart.draw(data, options);
            }
            ;
        </script>
        <script type="text/javascript">
            let PC_title1 = document.getElementById("PC_title1");
            let PC_title2 = document.getElementById("PC_title2");
            let PC_title3 = document.getElementById("PC_title3");
            let PC_title4 = document.getElementById("PC_title4");
            let PC_title5 = document.getElementById("PC_title5");
            let PC_title6 = document.getElementById("PC_title6");

            let PC_data1 = document.getElementById("PC_data1");
            let PC_data2 = document.getElementById("PC_data2");
            let PC_data3 = document.getElementById("PC_data3");
            let PC_data4 = document.getElementById("PC_data4");
            let PC_data5 = document.getElementById("PC_data5");
            let PC_data6 = document.getElementById("PC_data6");

            if (PC_title1 === null)
                PC_title1 = " ";
            if (PC_title2 === null)
                PC_title2 = " ";
            if (PC_title3 === null)
                PC_title3 = " ";
            if (PC_title4 === null)
                PC_title4 = " ";
            if (PC_title5 === null)
                PC_title5 = " ";
            if (PC_title6 === null)
                PC_title6 = " ";

            if (PC_data1 === null)
                PC_data1 = 0;
            if (PC_data2 === null)
                PC_data2 = 0;
            if (PC_data3 === null)
                PC_data3 = 0;
            if (PC_data4 === null)
                PC_data4 = 0;
            if (PC_data5 === null)
                PC_data5 = 0;
            if (PC_data6 === null)
                PC_data6 = 0;

            google.charts.load("current", {packages: ["corechart"]});
            google.charts.setOnLoadCallback(drawChart);
            function drawChart() {
                var data = google.visualization.arrayToDataTable([
                    ['Language', 'Succesfull order'],
                    [PC_title1.value, parseFloat(PC_data1.value)],
                    [PC_title2.value, parseFloat(PC_data2.value)],
                    [PC_title3.value, parseFloat(PC_data3.value)],
                    [PC_title4.value, parseFloat(PC_data4.value)],
                    [PC_title5.value, parseFloat(PC_data5.value)],
                    [PC_title6.value, parseFloat(PC_data6.value)]
                ]);
                var options = {

                    legend: {

                        alignment: 'center', // Align the legend items to the center
                        textStyle: {fontSize: 20}
                    },

                    chartArea: {left: 20, width: '750%', height: '85%'},
                    pieStartAngle: 100,

                };
                var chart = new google.visualization.PieChart(document.getElementById('BC_ProductCategory'));
                chart.draw(data, options);
            }
        </script>
        <script type="text/javascript">
            let SBR_title1 = document.getElementById("SBR_title1");
            let SBR_title2 = document.getElementById("SBR_title2");
            let SBR_title3 = document.getElementById("SBR_title3");
            let SBR_title4 = document.getElementById("SBR_title4");
            let SBR_title5 = document.getElementById("SBR_title5");
            let SBR_title6 = document.getElementById("SBR_title6");

            let SBR_data1 = document.getElementById("SBR_data1");
            let SBR_data2 = document.getElementById("SBR_data2");
            let SBR_data3 = document.getElementById("SBR_data3");
            let SBR_data4 = document.getElementById("SBR_data4");
            let SBR_data5 = document.getElementById("SBR_data5");
            let SBR_data6 = document.getElementById("SBR_data6");

            if (SBR_title1 === null)
                SBR_title1 = " ";
            if (SBR_title2 === null)
                SBR_title2 = " ";
            if (SBR_title3 === null)
                SBR_title3 = " ";
            if (SBR_title4 === null)
                SBR_title4 = " ";
            if (SBR_title5 === null)
                SBR_title5 = " ";
            if (SBR_title6 === null)
                SBR_title6 = " ";

            if (SBR_data1 === null)
                SBR_data1 = 0;
            if (SBR_data2 === null)
                SBR_data2 = 0;
            if (SBR_data3 === null)
                SBR_data3 = 0;
            if (SBR_data4 === null)
                SBR_data4 = 0;
            if (SBR_data5 === null)
                SBR_data5 = 0;
            if (SBR_data6 === null)
                SBR_data6 = 0;
            
            console.log(SBR_title2.value);
            
            google.charts.load('current', {'packages': ['bar']});
            google.charts.setOnLoadCallback(drawStuff);
            function drawStuff() {
                var data = new google.visualization.arrayToDataTable([
                    ['Shop Name', 'Report Amount'],
                    [SBR_title1.value, parseFloat(SBR_data1.value)],
                    [SBR_title2.value, parseFloat(SBR_data2.value)],
                    [SBR_title3.value, parseFloat(SBR_data3.value)],
                    [SBR_title4.value, parseFloat(SBR_data4.value)],
                    [SBR_title5.value, parseFloat(SBR_data5.value)],
//                    [SBR_title6.value, parseFloat(SBR_data6.value)]
                ]);
                var options = {

                    legend: {alignment: 'center', textStyle: {fontSize: 10}},

                    chartArea: {width: '100%', height: '100%'},
                    bar: {groupWidth: "80%"}
                };
                var chart = new google.charts.Bar(document.getElementById('BC_ShopReport'));
                // Convert the Classic options to Material options.
                chart.draw(data, google.charts.Bar.convertOptions(options));
            }
            ;
        </script>
        <script type="text/javascript">
            let SJ_title1 = document.getElementById("SJ_title1");
            let SJ_title2 = document.getElementById("SJ_title2");
            let SJ_title3 = document.getElementById("SJ_title3");
            let SJ_title4 = document.getElementById("SJ_title4");
            let SJ_title5 = document.getElementById("SJ_title5");
            let SJ_title6 = document.getElementById("SJ_title6");

            let SJ_data1 = document.getElementById("SJ_data1");
            let SJ_data2 = document.getElementById("SJ_data2");
            let SJ_data3 = document.getElementById("SJ_data3");
            let SJ_data4 = document.getElementById("SJ_data4");
            let SJ_data5 = document.getElementById("SJ_data5");
            let SJ_data6 = document.getElementById("SJ_data6");

            if (SJ_title1 === null)
                SJ_title1 = " ";
            if (SJ_title2 === null)
                SJ_title2 = " ";
            if (SJ_title3 === null)
                SJ_title3 = " ";
            if (SJ_title4 === null)
                SJ_title4 = " ";
            if (SJ_title5 === null)
                SJ_title5 = " ";
            if (SJ_title6 === null)
                SJ_title6 = " ";

            if (SJ_data1 === null)
                SJ_data1 = 0;
            if (SJ_data2 === null)
                SJ_data2 = 0;
            if (SJ_data3 === null)
                SJ_data3 = 0;
            if (SJ_data4 === null)
                SJ_data4 = 0;
            if (SJ_data5 === null)
                SJ_data5 = 0;
            if (SJ_data6 === null)
                SJ_data6 = 0;

            google.charts.load('current', {'packages': ['line']});
            google.charts.setOnLoadCallback(drawChart);

            function drawChart() {
                var data = google.visualization.arrayToDataTable([
                    ['Month', 'Join Amount'],
                    [SJ_title6.value, parseFloat(SJ_data6.value)],
                    [SJ_title5.value, parseFloat(SJ_data5.value)],
                    [SJ_title4.value, parseFloat(SJ_data4.value)],
                    [SJ_title3.value, parseFloat(SJ_data3.value)],
                    [SJ_title2.value, parseFloat(SJ_data2.value)],
                    [SJ_title1.value, parseFloat(SJ_data1.value)]
                ]);
                var options = {

                    legend: {alignment: 'center', textStyle: {fontSize: 10}},
                    axes: {
                        x: {
                            0: {side: 'bottomn'}
                        }
                    }
                };
                var chart = new google.charts.Line(document.getElementById('BC_ShopJoin'));

                chart.draw(data, google.charts.Line.convertOptions(options));
            }
        </script>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
