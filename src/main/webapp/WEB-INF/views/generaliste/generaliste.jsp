<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Espace Généraliste - Télé-Expertise Médicale</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #4ca1af 0%, #357e8c 100%);
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
            background: linear-gradient(135deg, #4ca1af, #357e8c);
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
            background: linear-gradient(135deg, #4ca1af, #357e8c);
            color: white;
        }

        .stat-icon.consultations {
            background: linear-gradient(135deg, #f093fb, #f5576c);
            color: white;
        }

        .stat-icon.attente {
            background: linear-gradient(135deg, #ffa751, #ffe259);
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
            background: linear-gradient(135deg, #4ca1af, #357e8c);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(76, 161, 175, 0.4);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(76, 161, 175, 0.5);
        }

        /* Formulaire d'ajout consultation */
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
        .form-group select,
        .form-group textarea {
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #4ca1af;
            box-shadow: 0 0 0 3px rgba(76, 161, 175, 0.1);
        }

        .form-section-title {
            color: #4ca1af;
            font-size: 1.2rem;
            font-weight: 700;
            margin: 20px 0 15px 0;
            padding-bottom: 10px;
            border-bottom: 2px solid #4ca1af;
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

        /* Layout en 2 colonnes */
        .content-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-top: 25px;
        }

        @media (max-width: 1024px) {
            .content-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Table des patients */
        .patients-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .patients-table thead {
            background: linear-gradient(135deg, #4ca1af, #357e8c);
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

        .badge-avis {
            background: #d1ecf1;
            color: #0c5460;
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

        /* Consultations list */
        .consultation-item {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 15px;
            border-left: 4px solid #4ca1af;
            transition: all 0.3s ease;
        }

        .consultation-item:hover {
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
            transform: translateX(5px);
        }

        .consultation-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .consultation-patient {
            font-weight: 700;
            color: #333;
            font-size: 1.1rem;
        }

        .consultation-date {
            color: #666;
            font-size: 0.85rem;
        }

        .consultation-details {
            color: #555;
            font-size: 0.9rem;
            margin-top: 8px;
        }

        .consultation-motif {
            font-weight: 600;
            color: #4ca1af;
        }
    </style>
</head>
<body>

<!-- Header avec nom et déconnexion -->
<div class="header">
    <div class="welcome">
        <div class="welcome-icon">
            <c:choose>
                <c:when test="${not empty sessionScope.utilisateur.nom}">
                    ${fn:substring(sessionScope.utilisateur.nom, 0, 1)}
                </c:when>
                <c:otherwise>G</c:otherwise>
            </c:choose>
        </div>
        <div class="welcome-text">
            <h2>Bonjour Dr. ${sessionScope.utilisateur.prenom} ${sessionScope.utilisateur.nom}</h2>
            <p>Médecin Généraliste | Espace de Consultation</p>
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
                <h3>Patients en Attente</h3>
                <div class="stat-number">
                    <c:choose>
                        <c:when test="${not empty patientsEnAttente}">
                            ${fn:length(patientsEnAttente)}
                        </c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <div class="stat-card">
        <div class="stat-card-header">
            <div class="stat-icon consultations">📋</div>
            <div class="stat-info">
                <h3>Consultations du Jour</h3>
                <div class="stat-number">
                    <c:choose>
                        <c:when test="${not empty consultations}">
                            ${fn:length(consultations)}
                        </c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <div class="stat-card">
        <div class="stat-card-header">
            <div class="stat-icon attente">⏳</div>
            <div class="stat-info">
                <h3>Total Patients</h3>
                <div class="stat-number">${totalPatients != null ? totalPatients : 0}</div>
            </div>
        </div>
    </div>
</div>

<!-- Section principale -->
<div class="main-section">
    <div class="section-header">
        <h2>📋 Gestion des Consultations</h2>
        <div style="display: flex; gap: 15px;">
            <button class="btn-primary" onclick="toggleForm()">➕ Nouvelle Consultation</button>
            <button class="btn-primary" style="background: linear-gradient(135deg, #f093fb, #f5576c);" onclick="toggleExpertiseForm()">🩺 Demande Expertise</button>
        </div>
    </div>

    <!-- Formulaire d'ajout consultation (caché par défaut) -->
    <div class="form-container" id="consultationForm">
        <h3 style="color: #333; margin-bottom: 20px;">Nouvelle Consultation</h3>
        <form action="${pageContext.request.contextPath}/generaliste/ajouterConsultation" method="post">

            <!-- Sélection du patient -->
            <div class="form-section-title">👤 Sélection du Patient</div>
            <div class="form-grid">
                <div class="form-group">
                    <label for="patientId">Patient *</label>
                    <select id="patientId" name="patientId" required>
                        <option value="">-- Choisir un patient --</option>
                        <c:forEach items="${patientsEnAttente}" var="p">
                            <option value="${p.id}">${p.nom} ${p.prenom} - ${p.numSecu}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <!-- Détails de la consultation -->
            <div class="form-section-title">🩺 Détails de la Consultation</div>
            <div class="form-grid">
                <div class="form-group">
                    <label for="motif">Motif de consultation *</label>
                    <input type="text" id="motif" name="motif" required placeholder="Ex: Grippe, Douleur abdominale...">
                </div>

                <div class="form-group">
                    <label for="cout">Coût de consultation (DH)</label>
                    <input type="number" id="cout" name="cout" value="150" step="0.01" placeholder="150.00">
                </div>
            </div>

            <div class="form-group">
                <label for="observations">Observations *</label>
                <textarea id="observations" name="observations" rows="4" required placeholder="Examen clinique, symptômes observés..."></textarea>
            </div>

            <!-- Diagnostic et traitement -->
            <div class="form-section-title">💊 Diagnostic & Traitement</div>
            <div class="form-group">
                <label for="diagnostic">Diagnostic</label>
                <textarea id="diagnostic" name="diagnostic" rows="3" placeholder="Diagnostic médical..."></textarea>
            </div>

            <div class="form-group">
                <label for="traitement">Traitement prescrit</label>
                <textarea id="traitement" name="traitement" rows="3" placeholder="Médicaments, posologie, durée..."></textarea>
            </div>

            <!-- Actions -->
            <div class="form-actions">
                <button type="button" class="btn-secondary" onclick="toggleForm()">Annuler</button>
                <button type="submit" class="btn-primary">💾 Enregistrer la Consultation</button>
            </div>
        </form>
    </div>

    <!-- Formulaire de demande d'expertise (caché par défaut) -->
    <div class="form-container" id="expertiseForm">
        <h3 style="color: #333; margin-bottom: 20px;">🩺 Demander l'avis d'un Spécialiste</h3>
        <form action="${pageContext.request.contextPath}/generaliste/formulaireDemandeCrenaux" method="post">

            <!-- Sélection de la consultation -->
            <div class="form-section-title">📋 Sélection de la Consultation</div>
            <div class="form-group">
                <label for="consultationId">Consultation concernée *</label>
                <select id="consultationId" name="consultationId" required>
                    <option value="">-- Choisir une consultation --</option>
                    <c:choose>
                        <c:when test="${empty consultationsSansExpertise}">
                            <option value="" disabled>⚠️ Aucune consultation disponible (toutes ont déjà une demande d'expertise)</option>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${consultationsSansExpertise}" var="c">
                                <option value="${c.id}">
                                    ${c.patient.nom} ${c.patient.prenom} - ${c.motif} (${c.dateConsultation})
                                </option>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </select>
            </div>

            <!-- Sélection du spécialiste -->
            <div class="form-section-title">👨‍⚕️ Sélection du Spécialiste</div>
            <div class="form-group">
                <label for="specialisteId">Médecin Spécialiste *</label>
                <select id="specialisteId" name="specialisteId" required>
                    <option value="">-- Choisir un spécialiste --</option>
                    <c:forEach items="${specialistes}" var="sp">
                        <option value="${sp.id}">
                            Dr. ${sp.nom} ${sp.prenom} - ${sp.specialite} (Tarif: ${sp.tarif} DH)
                        </option>
                    </c:forEach>
                </select>
            </div>

            <!-- Actions -->
            <div class="form-actions">
                <button type="button" class="btn-secondary" onclick="toggleExpertiseForm()">Annuler</button>
                <button type="submit" class="btn-primary" style="background: linear-gradient(135deg, #f093fb, #f5576c);">📅 Choisir un Créneau</button>
            </div>
        </form>
    </div>

    <!-- Layout en 2 colonnes -->
    <div class="content-grid">
        <!-- Colonne 1: Patients en attente -->
        <div>
            <h3 style="color: #333; margin-bottom: 15px;">⏳ Patients en Attente</h3>
            <c:choose>
                <c:when test="${empty patientsEnAttente}">
                    <div class="empty-state">
                        <div class="empty-state-icon">👥</div>
                        <h3>Aucun patient en attente</h3>
                        <p>La file d'attente est vide</p>
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
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${patientsEnAttente}" var="patient">
                                <tr>
                                    <td>${patient.numSecu}</td>
                                    <td><strong>${patient.nom} ${patient.prenom}</strong></td>
                                    <td>${patient.dateNaissance}</td>
                                    <td>${patient.telephone}</td>
                                    <td>
                                        <span class="badge badge-attente">⏳ En Attente</span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Colonne 2: Consultations réalisées -->
        <div>
            <h3 style="color: #333; margin-bottom: 15px;">📋 Mes Consultations</h3>
            <c:choose>
                <c:when test="${empty consultations}">
                    <div class="empty-state">
                        <div class="empty-state-icon">📋</div>
                        <h3>Aucune consultation</h3>
                        <p>Commencez par ajouter une consultation</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${consultations}" var="consultation">
                        <div class="consultation-item">
                            <div class="consultation-header">
                                <div class="consultation-patient">
                                    ${consultation.patient.nom} ${consultation.patient.prenom}
                                </div>
                                <div>
                                    <c:choose>
                                        <c:when test="${consultation.status == 'TERMINEE'}">
                                            <span class="badge badge-termine">✅ Terminée</span>
                                        </c:when>
                                        <c:when test="${consultation.status == 'EN_ATTENTE_AVIS_SPECIALISTE'}">
                                            <span class="badge badge-avis">🩺 Avis Spécialiste</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-attente">⏳ En cours</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="consultation-date">
                                📅 ${consultation.dateConsultation}
                            </div>
                            <div class="consultation-details">
                                <div class="consultation-motif">Motif: ${consultation.motif}</div>
                                <c:if test="${not empty consultation.diagnostic}">
                                    <div style="margin-top: 5px;">Diagnostic: ${consultation.diagnostic}</div>
                                </c:if>
                                <c:if test="${not empty consultation.cout}">
                                    <div style="margin-top: 5px; font-weight: 600; color: #4ca1af;">Coût: ${consultation.cout} DH</div>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script>
    function toggleForm() {
        const form = document.getElementById('consultationForm');
        const expertiseForm = document.getElementById('expertiseForm');

        // Fermer le formulaire d'expertise si ouvert
        expertiseForm.classList.remove('active');

        form.classList.toggle('active');

        if (form.classList.contains('active')) {
            form.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }
    }

    function toggleExpertiseForm() {
        const form = document.getElementById('consultationForm');
        const expertiseForm = document.getElementById('expertiseForm');

        // Fermer le formulaire de consultation si ouvert
        form.classList.remove('active');

        expertiseForm.classList.toggle('active');

        if (expertiseForm.classList.contains('active')) {
            expertiseForm.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }
    }
</script>

</body>
</html>
