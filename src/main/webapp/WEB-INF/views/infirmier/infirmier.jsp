<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 15/10/2025
  Time: 09:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Espace Infirmier - Télé-Expertise Médicale</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        /* Header avec nom et déconnexion */
        .header {
            background: white;
            border-radius: 15px;
            padding: 20px 30px;
            margin-bottom: 25px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .welcome {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .welcome-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            font-weight: bold;
        }

        .welcome-text h2 {
            color: #333;
            font-size: 1.5rem;
            margin-bottom: 5px;
        }

        .welcome-text p {
            color: #666;
            font-size: 0.9rem;
        }

        .btn-deconnexion {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(231, 76, 60, 0.3);
        }

        .btn-deconnexion:hover {
            background: #c0392b;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(231, 76, 60, 0.4);
        }

        /* Section Statistiques */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }

        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-card-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 15px;
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
        }

        .stat-icon.patients {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }

        .stat-icon.attente {
            background: linear-gradient(135deg, #f093fb, #f5576c);
            color: white;
        }

        .stat-icon.traites {
            background: linear-gradient(135deg, #4facfe, #00f2fe);
            color: white;
        }

        .stat-info h3 {
            color: #666;
            font-size: 0.9rem;
            font-weight: 500;
            margin-bottom: 5px;
        }

        .stat-number {
            color: #333;
            font-size: 2rem;
            font-weight: 700;
        }

        /* Section principale */
        .main-section {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .section-header h2 {
            color: #333;
            font-size: 1.5rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.5);
        }

        /* Formulaire d'ajout patient */
        .form-container {
            display: none;
            background: #f8f9fa;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 25px;
            animation: slideDown 0.3s ease;
        }

        .form-container.active {
            display: block;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            color: #333;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 0.9rem;
        }

        .form-group input,
        .form-group textarea {
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-section-title {
            color: #667eea;
            font-size: 1.2rem;
            font-weight: 700;
            margin: 20px 0 15px 0;
            padding-bottom: 10px;
            border-bottom: 2px solid #667eea;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }

        /* Table des patients */
        .patients-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .patients-table thead {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }

        .patients-table th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
        }

        .patients-table tbody tr {
            border-bottom: 1px solid #e0e0e0;
            transition: background 0.2s ease;
        }

        .patients-table tbody tr:hover {
            background: #f8f9fa;
        }

        .patients-table td {
            padding: 15px;
            color: #333;
        }

        .badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .badge-attente {
            background: #fff3cd;
            color: #856404;
        }

        .badge-termine {
            background: #d4edda;
            color: #155724;
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: #999;
        }

        .empty-state-icon {
            font-size: 4rem;
            margin-bottom: 15px;
        }

        /* Alert messages */
        .alert {
            padding: 12px 18px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-weight: 600;
        }
        .alert-success { background: #d4edda; color: #155724; }
        .alert-error { background: #f8d7da; color: #721c24; }
    </style>
</head>
<body>

<!-- Header avec nom et déconnexion -->
<div class="header">
    <div class="welcome">
        <div class="welcome-icon">
            <!-- Première lettre du nom -->
            ${sessionScope.utilisateur.nom.substring(0, 1)}
        </div>
        <div class="welcome-text">
            <h2>Bonjour, ${sessionScope.utilisateur.prenom} ${sessionScope.utilisateur.nom}</h2>
            <p>Infirmier(ère) | Espace de Gestion des Patients</p>
        </div>
    </div>
    <form action="${pageContext.request.contextPath}/logout" method="post" style="margin: 0;">
        <button type="submit" class="btn-deconnexion">🚪 Déconnexion</button>
    </form>
</div>

<!-- Messages de session (succès / erreur) -->
<c:if test="${not empty sessionScope.successMessage}">
    <div class="alert alert-success">${sessionScope.successMessage}</div>
    <c:remove var="successMessage" scope="session" />
</c:if>

<c:if test="${not empty sessionScope.errorMessage}">
    <div class="alert alert-error">${sessionScope.errorMessage}</div>
    <c:remove var="errorMessage" scope="session" />
</c:if>

<!-- Statistiques -->
<div class="stats-container">
    <div class="stat-card">
        <div class="stat-card-header">
            <div class="stat-icon patients">👥</div>
            <div class="stat-info">
                <h3>Total Patients</h3>
                <div class="stat-number">${totalPatients != null ? totalPatients : 0}</div>
            </div>
        </div>
    </div>

    <div class="stat-card">
        <div class="stat-card-header">
            <div class="stat-icon attente">⏳</div>
            <div class="stat-info">
                <h3>En Attente</h3>
                <div class="stat-number">${patientsEnAttente != null ? patientsEnAttente : 0}</div>
            </div>
        </div>
    </div>

    <div class="stat-card">
        <div class="stat-card-header">
            <div class="stat-icon traites">✅</div>
            <div class="stat-info">
                <h3>Patients Traités</h3>
                <div class="stat-number">${patientsTraites != null ? patientsTraites : 0}</div>
            </div>
        </div>
    </div>
</div>

<!-- Section principale -->
<div class="main-section">
    <div class="section-header">
        <h2>📋 Gestion des Patients</h2>
        <button class="btn-primary" onclick="toggleForm()">➕ Ajouter un Patient</button>
    </div>

    <!-- Formulaire d'ajout patient (caché par défaut) -->
    <div class="form-container" id="patientForm">
        <h3 style="color: #333; margin-bottom: 20px;">Nouveau Patient</h3>
        <form action="${pageContext.request.contextPath}/infirmier/ajouterPatient" method="post">

            <!-- Informations personnelles -->
            <div class="form-section-title">📝 Informations Personnelles</div>
            <div class="form-grid">
                <div class="form-group">
                    <label for="nom">Nom *</label>
                    <input type="text" id="nom" name="nom" required>
                </div>

                <div class="form-group">
                    <label for="prenom">Prénom *</label>
                    <input type="text" id="prenom" name="prenom" required>
                </div>

                <div class="form-group">
                    <label for="dateNaissance">Date de Naissance *</label>
                    <input type="date" id="dateNaissance" name="dateNaissance" required>
                </div>

                <div class="form-group">
                    <label for="numSecu">N° Sécurité Sociale *</label>
                    <input type="text" id="numSecu" name="numSecu" required>
                </div>
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <label for="telephone">Téléphone</label>
                    <input type="tel" id="telephone" name="telephone">
                </div>

                <div class="form-group">
                    <label for="mutuelle">Mutuelle</label>
                    <input type="text" id="mutuelle" name="mutuelle">
                </div>
            </div>

            <div class="form-group">
                <label for="adresse">Adresse</label>
                <textarea id="adresse" name="adresse" rows="2"></textarea>
            </div>

            <!-- Signes Vitaux -->
            <div class="form-section-title">🩺 Signes Vitaux</div>
            <div class="form-grid">
                <div class="form-group">
                    <label for="tensionArterielle">Tension Artérielle (mmHg)</label>
                    <input type="text" id="tensionArterielle" name="tensionArterielle" placeholder="ex: 120/80">
                </div>

                <div class="form-group">
                    <label for="frequenceCardiaque">Fréquence Cardiaque (bpm)</label>
                    <input type="number" id="frequenceCardiaque" name="frequenceCardiaque" placeholder="ex: 75">
                </div>

                <div class="form-group">
                    <label for="temperature">Température (°C)</label>
                    <input type="number" step="0.1" id="temperature" name="temperature" placeholder="ex: 37.5">
                </div>

                <div class="form-group">
                    <label for="frequenceRespiratoire">Fréquence Respiratoire (cycles/min)</label>
                    <input type="number" id="frequenceRespiratoire" name="frequenceRespiratoire" placeholder="ex: 16">
                </div>

                <div class="form-group">
                    <label for="poids">Poids (kg)</label>
                    <input type="number" step="0.1" id="poids" name="poids" placeholder="ex: 70.5">
                </div>

                <div class="form-group">
                    <label for="taille">Taille (cm)</label>
                    <input type="number" id="taille" name="taille" placeholder="ex: 175">
                </div>
            </div>

            <!-- Dossier Médical -->
            <div class="form-section-title">📋 Dossier Médical</div>
            <div class="form-group">
                <label for="antecedents">Antécédents Médicaux</label>
                <textarea id="antecedents" name="antecedents" rows="3" placeholder="ex: Diabète, Hypertension..."></textarea>
            </div>

            <div class="form-group">
                <label for="allergies">Allergies</label>
                <textarea id="allergies" name="allergies" rows="2" placeholder="ex: Pénicilline, Arachides..."></textarea>
            </div>

            <div class="form-group">
                <label for="traitements">Traitements en Cours</label>
                <textarea id="traitements" name="traitements" rows="3" placeholder="ex: Metformine 500mg, 2x/jour..."></textarea>
            </div>

            <!-- Actions -->
            <div class="form-actions">
                <button type="button" class="btn-secondary" onclick="toggleForm()">Annuler</button>
                <button type="submit" class="btn-primary">💾 Enregistrer le Patient</button>
            </div>
        </form>
    </div>

    <!-- Liste des patients -->
    <c:choose>
        <c:when test="${empty patients}">
            <div class="empty-state">
                <div class="empty-state-icon">📋</div>
                <h3>Aucun patient enregistré</h3>
                <p>Cliquez sur "Ajouter un Patient" pour commencer</p>
            </div>
        </c:when>
        <c:otherwise>
            <table class="patients-table">
                <thead>
                    <tr>
                        <th>N° Sécu</th>
                        <th>Nom Complet</th>
                        <th>Date Naissance</th>
                        <th>Téléphone</th>
                        <th>Statut</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${patients}" var="patient">
                        <tr>
                            <td>${patient.numSecu}</td>
                            <td><strong>${patient.nom} ${patient.prenom}</strong></td>
                            <td>${patient.dateNaissance}</td>
                            <td>${patient.telephone}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${patient.fileAttente}">
                                        <span class="badge badge-attente">⏳ En Attente</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-termine">✅ Traité</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a class="btn-primary"
                                   href="${pageContext.request.contextPath}/infirmier/modifierPatient?id=${patient.id}"
                                   style="padding:8px 12px; font-size:0.9rem; text-decoration:none; display:inline-block;">
                                    ✏️ Modifier
                                </a>

                                <form action="${pageContext.request.contextPath}/infirmier/supprimerPatient" method="post"
                                      style="display:inline-block; margin-left:8px;"
                                      onsubmit="return confirm('Confirmer la suppression du patient ?');">
                                    <input type="hidden" name="id" value="${patient.id}" />
                                    <button type="submit" class="btn-secondary"
                                            style="padding:8px 12px; font-size:0.9rem; background:#e74c3c; border:none; color:white; border-radius:8px;">
                                        🗑️ Supprimer
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

<script>
    function toggleForm() {
        const form = document.getElementById('patientForm');
        form.classList.toggle('active');

        if (form.classList.contains('active')) {
            form.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }
    }
</script>

</body>
</html>
