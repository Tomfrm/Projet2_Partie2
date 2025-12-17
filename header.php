<?php
// header.php
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Accueil</title>
    <!-- Lien Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="public/css/style.css" rel="stylesheet">

</head>
<body>
<div class="container">

<!-- Barre de navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <a class="navbar-brand" href="index.php">Accueil</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="index.php?chx1=accueil">Accueil</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="index.php?chx1=procedure">Accès médecin</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="index.php?chx1=fonction">Accès assistant</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="index.php?chx1=trigger">Accès client</a>
                </li>
            </ul>
        </div>
   
</nav>