<%-- 
    Document   : news
    Created on : 24 thg 10, 2024, 10:05:02
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.News" %>
<%@page import="dal.NewsDAO" %>
<%@page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/png" href="img/flyezy-logo3.png"/>
        <link rel="stylesheet" href="css/styleNews.css"/>
        <title>JSP Page</title>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <div class="box" >
            <div style="display: ${empty param.id ? '' : 'none'};margin: 130px 0">
                <h1 style="margin-bottom: 20px; text-align: center;">Tin tức</h1>
                <div class="news-container">
                    <% 
                        List<News> listNew = (List<News>) request.getAttribute("listNew");
                        if (listNew != null) {
                            for (int i = listNew.size() - 1; i >= 0; i--) {
                                News n = listNew.get(i);
                    %>
                    <div class="news-item" onclick="viewNews('<%= n.getId() %>');">
                        <img src="<%= n.getImage() %>" alt="<%= n.getTitle() %>">
                        
                        <h2><%= n.getTitle() %></h2>
                        <div class="news-content" style="display: none;">
                            <p><%= n.getContent() %></p>
                        </div>
                    </div>
                    <% 
                           }
                       }
                    %>    
                </div>
            </div>

            <div id="selected" style="display: ${empty param.id ? 'none' : ''}" class="row">
                <div class="col-md-2"></div>
                <div class="col-md-6" style="margin: 130px 0">
                    <% 
                    NewsDAO nd = new NewsDAO();
                    String newsIdStr = request.getParameter("id");
                    if (newsIdStr != null) {
                        try {
                            int newsId = Integer.parseInt(newsIdStr);
                            News selectedNews = nd.getNewsById(newsId); 
                            if (selectedNews != null) {
                    %>
                    <div class="selected-news">
                        <h1><%= selectedNews.getTitle() %></h1>
                        <img src="<%= selectedNews.getImage() %>" alt="<%= selectedNews.getTitle() %>">
                        <p><%= selectedNews.getContent() %></p>
"
                    </div>

                    <% 
                        }
                            } catch (NumberFormatException e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </div>

                <div class="col-md-4" style="margin: 130px 0">
                    <div class="news-list">
                        <% 
                            if (listNew != null) {
                                for (int i = listNew.size() - 1; i >= 0; i--) {
                                    News n = listNew.get(i);
                        %>
                        <div class="news-item-small" onclick="viewNews('<%= n.getId() %>');">
                            <img src="<%= n.getImage() %>" alt="<%= n.getTitle() %>">
                            <h2><%= n.getTitle() %></h2>

                        </div>
                        <% 
                                }
                            }
                        %>
                    </div>
                </div>




            </div>
        </div>
        <script>
            function viewNews(newsId) {
                window.location.href = 'News?id=' + newsId;
            }
        </script>
    </body>
</html>
