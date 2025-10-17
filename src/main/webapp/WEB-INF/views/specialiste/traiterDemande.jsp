<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Traiter la Demande - Télé-Expertise</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        .card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            margin-bottom: 25px;
        }

        .header h1 {
            color: #667eea;
            font-size: 1.8rem;
            margin-bottom: 10px;
        }

        .breadcrumb {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 25px;
        }

        .breadcrumb a {
            color: #667eea;
            text-decoration: none;
        }

        .breadcrumb a:hover {
            text-decoration: underline;
        }

        .info-section {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            border-left: 4px solid #667eea;
        }

        .info-title {
            font-weight: 700;
            color: #667eea;
            font-size: 1.1rem;
            margin-bottom: 15px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }

        .info-item {
            display: flex;
            gap: 10px;
        }

        .info-label {
            font-weight: 600;
            color: #666;
        }

        .info-value {
            color: #333;
        }

        .question-box {
            background: #fff3cd;
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
            border-left: 3px solid #ffc107;
        }

        .question-label {
            font-weight: 600;
            color: #856404;
            margin-bottom: 8px;
        }

        .question-text {
            color: #555;
            line-height: 1.6;
        }

        .form-section-title {
            color: #667eea;
            font-size: 1.3rem;
            font-weight: 700;
            margin: 25px 0 15px 0;
            padding-bottom: 10px;
            border-bottom: 2px solid #667eea;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            color: #333;
            font-weight: 600;
            margin-bottom: 10px;
            font-size: 1rem;
        }

        .form-group textarea {
            width: 100%;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            font-family: inherit;
            transition: all 0.3s ease;
            resize: vertical;
        }

        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .required {
            color: #e74c3c;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            margin-top: 30px;
        }

        .btn {
            padding: 14px 35px;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.5);
        }

        .alert-info {
            background: #d1ecf1;
            color: #0c5460;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 4px solid #17a2b8;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="card">
        <div class="header">
            <h1>✍️ Traiter la Demande d'Expertise</h1>
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/specialiste/dashboard">← Retour aux Demandes</a>
            </div>
        </div>

        <div class="alert-info">
            <strong>ℹ️ Information :</strong> Remplissez votre avis médical et vos recommandations.
            Ces informations seront envoyées au médecin généraliste demandeur.
        </div>

        <!-- Informations sur la demande -->
        <div class="info-section">
            <div class="info-title">📋 Informations sur le Patient et la Consultation</div>
            <div class="info-grid">
                <div class="info-item">
                    <span class="info-label">👤 Patient :</span>
                    <span class="info-value"><strong>${demande.consultation.patient.nom} ${demande.consultation.patient.prenom}</strong></span>
                </div>
                <div class="info-item">
                    <span class="info-label">📅 Date RDV :</span>
                    <span class="info-value">${demande.dateRendezVous} à ${demande.creneauHoraire}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">🩺 Motif consultation :</span>
                    <span class="info-value">${demande.consultation.motif}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">👨‍⚕️ Médecin demandeur :</span>
                    <span class="info-value">Dr. ${demande.consultation.medecinGeneraliste.nom}</span>
                </div>
            </div>

            <c:if test="${not empty demande.consultation.diagnostic}">
                <div style="margin-top: 15px;">
                    <span class="info-label">💊 Diagnostic initial :</span>
                    <span class="info-value">${demande.consultation.diagnostic}</span>
                </div>
            </c:if>
        </div>

        <!-- Question du généraliste -->
        <div class="question-box">
            <div class="question-label">❓ Question du Médecin Généraliste :</div>
            <div class="question-text">${demande.question}</div>
        </div>

        <!-- Formulaire pour l'avis -->
        <form action="${pageContext.request.contextPath}/specialiste/soumettreAvis" method="post">
            <input type="hidden" name="demandeId" value="${demande.id}">

            <div class="form-section-title">✍️ Votre Avis Médical</div>

            <div class="form-group">
                <label for="avisMedecin">Avis du Spécialiste <span class="required">*</span></label>
                <textarea id="avisMedecin" name="avisMedecin" rows="8" required
                    placeholder="Rédigez votre avis médical détaillé concernant le cas du patient..."></textarea>
            </div>

            <div class="form-group">
                <label for="recommandations">Recommandations et Prescriptions</label>
                <textarea id="recommandations" name="recommandations" rows="6"
                    placeholder="Ajoutez vos recommandations, prescriptions ou conseils pour le traitement... (optionnel)"></textarea>
            </div>

            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/specialiste/dashboard" class="btn btn-secondary">
                    ← Annuler
                </a>
                <button type="submit" class="btn btn-primary">
                    ✅ Enregistrer et Terminer
                </button>
            </div>
        </form>
    </div>
</div>

</body>
</html>

