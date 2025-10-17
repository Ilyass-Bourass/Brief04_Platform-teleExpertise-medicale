<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Choisir une Date - Demande d'Expertise</title>
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

        .container {
            max-width: 800px;
            margin: 0 auto;
        }

        .card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            margin-bottom: 25px;
        }

        .card h1 {
            color: #f093fb;
            font-size: 1.8rem;
            margin-bottom: 10px;
        }

        .breadcrumb {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 25px;
        }

        .breadcrumb a {
            color: #4ca1af;
            text-decoration: none;
        }

        .info-box {
            background: #f8f9fa;
            border-left: 4px solid #f093fb;
            padding: 15px;
            margin-bottom: 25px;
            border-radius: 8px;
        }

        .info-box strong {
            color: #f093fb;
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

        .form-group input[type="date"] {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            outline: none;
            border-color: #f093fb;
            box-shadow: 0 0 0 3px rgba(240, 147, 251, 0.1);
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
            background: linear-gradient(135deg, #f093fb, #f5576c);
            color: white;
            box-shadow: 0 4px 15px rgba(240, 147, 251, 0.4);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(240, 147, 251, 0.5);
        }

        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            margin-top: 30px;
        }

        .required {
            color: #e74c3c;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="card">
        <h1>🩺 Demande d'Expertise - Étape 1</h1>
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/generaliste/dashboard">← Retour au Dashboard</a>
        </div>

        <div class="info-box">
            <p><strong>📋 Consultation :</strong> ${consultation.patient.nom} ${consultation.patient.prenom} - ${consultation.motif}</p>
            <p><strong>👨‍⚕️ Spécialiste :</strong> Dr. ${specialiste.nom} ${specialiste.prenom} (${specialiste.specialite})</p>
        </div>

        <h2 style="color: #333; margin-bottom: 20px;">Choisir une date pour le rendez-vous</h2>

        <form action="${pageContext.request.contextPath}/generaliste/voirCreneaux" method="post">
            <input type="hidden" name="consultationId" value="${consultation.id}">
            <input type="hidden" name="specialisteId" value="${specialiste.id}">

            <div class="form-group">
                <label for="dateRendezVous">Date souhaitée du rendez-vous <span class="required">*</span></label>
                <input type="date" id="dateRendezVous" name="dateRendezVous" required
                       min="<%= java.time.LocalDate.now() %>">
            </div>

            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/generaliste/dashboard" class="btn btn-secondary">
                    ← Annuler
                </a>
                <button type="submit" class="btn btn-primary">
                    📅 Voir les créneaux disponibles →
                </button>
            </div>
        </form>
    </div>
</div>

</body>
</html>

