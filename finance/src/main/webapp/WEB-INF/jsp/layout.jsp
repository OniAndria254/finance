<%
    String pg = (String) request.getAttribute("page");
    pg = pg + ".jsp";
    String alert = (String) request.getParameter("alert");

%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="description" content="Responsive HTML Admin Dashboard Template based on Bootstrap 5">
    <meta name="author" content="NobleUI">
    <meta name="keywords" content="nobleui, bootstrap, bootstrap 5, bootstrap5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">

    <title>Gestion</title>
    <!-- core:css -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700;900&display=swap" rel="stylesheet">
    <!-- End fonts -->

    <!-- core:css -->
    <link rel="stylesheet" href="/assets/vendors/core/core.css">
    <!-- endinject -->

    <!-- Plugin css for this page -->
    <link rel="stylesheet" href="/assets/vendors/bootstrap-datepicker/bootstrap-datepicker.min.css">
    <!-- End plugin css for this page -->

    <!-- inject:css -->
    <link rel="stylesheet" href="/assets/fonts/feather-font/css/iconfont.css">
    <link rel="stylesheet" href="/assets/vendors/flag-icon-css/css/flag-icon.min.css">
    <!-- endinject -->

    <!-- Layout styles -->
    <link rel="stylesheet" href="/assets/css/demo2/style.css">

    <!-- End layout styles -->

    <link rel="shortcut icon" href="../assets/images/favicon.png" />
</head>
<body>
<!-- core:js -->
<script src="/assets/vendors/core/core.js"></script>
<!-- endinject -->

<!-- Plugin js for this page -->
<!-- End plugin js for this page -->

<!-- inject:js -->
<script src="/assets/vendors/feather-icons/feather.min.js"></script>
<script src="/assets/js/template.js"></script>
<script src="/assets/vendors/chartjs/Chart.min.js"></script>
<script src="/assets/vendors/jquery.flot/jquery.flot.js"></script>
<script src="/assets/vendors/jquery.flot/jquery.flot.resize.js"></script>
<script src="/assets/vendors/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
<script src="/assets/vendors/apexcharts/apexcharts.min.js"></script>
<script src="/assets/vendors/feather-icons/feather.min.js"></script>
<script src="/assets/js/template.js"></script>
<script src="/assets/js/dashboard-dark.js"></script>
<script src="/assets/js/datepicker.js"></script>
<!-- endinject -->
<div class="main-wrapper">
    <nav class="sidebar">
        <div class="sidebar-header">
            <a href="#" class="sidebar-brand">
                Gestion
            </a>

        </div>
        <div class="sidebar-body ps ps--active-y">
            <ul class="nav">
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="collapse" href="#list" role="button" aria-expanded="false" aria-controls="list">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-box link-icon"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path><polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline><line x1="12" y1="22.08" x2="12" y2="12"></line></svg>
                        <span class="link-title">Entreprise</span>
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-chevron-down link-arrow">
                            <polyline points="6 9 12 15 18 9"></polyline>
                        </svg>
                    </a>
                    <div class="collapse" id="list">
                        <ul class="nav sub-menu">
                            <li class="nav-item">
                                <a href="/entreprises/create" class="nav-link">Ajout</a>
                            </li>
                            <li class="nav-item">
                                <a href="/entreprises/list" class="nav-link">Liste</a>
                            </li>
                        </ul>
                    </div>
                </li>

                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="collapse" href="#bilan" role="button" aria-expanded="false" aria-controls="bilan">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-box link-icon"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path><polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline><line x1="12" y1="22.08" x2="12" y2="12"></line></svg>
                        <span class="link-title">Bilan</span>
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-chevron-down link-arrow">
                            <polyline points="6 9 12 15 18 9"></polyline>
                        </svg>
                    </a>
                    <div class="collapse" id="bilan">
                        <ul class="nav sub-menu">
                            <li class="nav-item">
                                <a href="/bilan/add" class="nav-link">Ajout</a>
                            </li>
                            <li class="nav-item">
                                <a href="/bilan/afficher" class="nav-link">Afficher</a>
                            </li>
                        </ul>
                    </div>
                </li>

                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="collapse" href="#compte" role="button" aria-expanded="false" aria-controls="compte">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-box link-icon"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path><polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline><line x1="12" y1="22.08" x2="12" y2="12"></line></svg>
                        <span class="link-title">Compte de résultat</span>
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-chevron-down link-arrow">
                            <polyline points="6 9 12 15 18 9"></polyline>
                        </svg>
                    </a>
                    <div class="collapse" id="compte">
                        <ul class="nav sub-menu">
                            <li class="nav-item">
                                <a href="/compte_resultat/ajout" class="nav-link">Ajout</a>
                            </li>
                            <li class="nav-item">
                                <a href="/compte_resultat/afficher" class="nav-link">Afficher</a>
                            </li>

                            <li class="nav-item">
                                <a href="/indicateurs_financiers/indicateurs" class="nav-link">Indicateurs</a>
                            </li>
                        </ul>
                    </div>
                </li>
            </ul>
        </div>
    </nav>

    <div class="page-wrapper">
        <nav class="navbar">
            <a href="#" class="sidebar-toggler">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-menu"><line x1="3" y1="12" x2="21" y2="12"></line><line x1="3" y1="6" x2="21" y2="6"></line><line x1="3" y1="18" x2="21" y2="18"></line></svg>
            </a>
            <div class="navbar-content">
                <form class="search-form">
                    <div class="input-group">
                        <div class="input-group-text">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        </div>
                    </div>
                </form>
                <ul class="navbar-nav">

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="profileDropdown" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <img class="wd-30 ht-30 rounded-circle" src="/assets/images/profil.png" alt="profile">
                        </a>
                        <div class="dropdown-menu p-0" aria-labelledby="profileDropdown">
                            <div class="d-flex flex-column align-items-center border-bottom px-5 py-3">
                                <div class="mb-3">
                                    <img class="wd-80 ht-80 rounded-circle" src="/assets/images/profil.png" alt="">
                                </div>

                            </div>
                            <ul class="list-unstyled p-1">


                            </ul>
                        </div>
                    </li>
                </ul>
            </div>
        </nav>


    <% if (alert != null) { %>
    <div class="alert">
        <% out.println(alert); %>
    </div>
<% } %>

<div class="page-content">
    <jsp:include page="<%= pg %>"/>
</div>

        <footer class="footer d-flex flex-column flex-md-row align-items-center justify-content-between px-4 py-3 border-top small">
            <p class="text-muted mb-1 mb-md-0">Copyright © 2024 <a href="" target="_blank">IT University</a>.</p>
            <p class="text-muted">Handcrafted With <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-heart mb-1 text-primary ms-1 icon-sm"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path></svg></p>
        </footer>
    </div>
</div>
</body>

</html>
