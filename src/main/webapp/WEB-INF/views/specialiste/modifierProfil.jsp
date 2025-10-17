<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier Mon Profil - Spécialiste</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            max-width: 600px;
            width: 100%;
        }

        .header-section {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 3px solid #667eea;
        }

        .header-section h1 {
            color: #333;
            font-size: 2rem;
            margin-bottom: 10px;
        }

        .header-section p {
            color: #666;
            font-size: 1rem;
        }

        .alert {
            padding: 12px 18px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-weight: 600;
        }

        .alert-success { background: #d4edda; color: #155724; }
        .alert-error { background: #f8d7da; color: #721c24; }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 600;
            font-size: 0.95rem;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .btn-container {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 14px;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-submit {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-retour {
            background: #6c757d;
            color: white;
            text-align: center;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-retour:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }

        .info-box {
            background: #e7f3ff;
            border-left: 4px solid #2196F3;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .info-box p {
            color: #0d47a1;
            font-size: 0.9rem;
            line-height: 1.5;
        }

        .required {
            color: #e74c3c;
            margin-left: 3px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header-section">
        <h1>⚙️ Modifier Mon Profil</h1>
        <p>Mettez à jour vos informations professionnelles</p>
    </div>

    <c:if test="${not empty sessionScope.successMessage}">
        <div class="alert alert-success">${sessionScope.successMessage}</div>
        <c:remove var="successMessage" scope="session" />
    </c:if>

    <c:if test="${not empty sessionScope.errorMessage}">
        <div class="alert alert-error">${sessionScope.errorMessage}</div>
        <c:remove var="errorMessage" scope="session" />
    </c:if>

    <div class="info-box">
        <p>💡 <strong>Information :</strong> Vous pouvez modifier votre spécialité, votre tarif de consultation et la durée moyenne de vos consultations.</p>
    </div>

    <form action="${pageContext.request.contextPath}/specialiste/modifierProfil" method="post">

        <div class="form-row">
            <div class="form-group">
                <label for="nom">👤 Nom <span class="required">*</span></label>
                <input type="text" id="nom" name="nom" value="${specialiste.nom}" required>
            </div>

            <div class="form-group">
                <label for="prenom">👤 Prénom <span class="required">*</span></label>
                <input type="text" id="prenom" name="prenom" value="${specialiste.prenom}" required>
            </div>
        </div>

        <div class="form-group">
            <label for="email">📧 Email <span class="required">*</span></label>
            <input type="email" id="email" name="email" value="${specialiste.email}" required>
        </div>

        <div class="form-group">
            <label for="specialite">🩺 Spécialité <span class="required">*</span></label>
            <select id="specialite" name="specialite" required>
                <option value="">-- Choisir une spécialité --</option>
                <option value="CARDIOLOGIE" ${specialiste.specialite == 'CARDIOLOGIE' ? 'selected' : ''}>Cardiologie</option>
                <option value="PNEUMOLOGIE" ${specialiste.specialite == 'PNEUMOLOGIE' ? 'selected' : ''}>Pneumologie</option>
                <option value="DERMATOLOGIE" ${specialiste.specialite == 'DERMATOLOGIE' ? 'selected' : ''}>Dermatologie</option>
                <option value="PEDIATRIE" ${specialiste.specialite == 'PEDIATRIE' ? 'selected' : ''}>Pédiatrie</option>
                <option value="NEUROLOGIE" ${specialiste.specialite == 'NEUROLOGIE' ? 'selected' : ''}>Neurologie</option>
                <option value="OPHTALMOLOGIE" ${specialiste.specialite == 'OPHTALMOLOGIE' ? 'selected' : ''}>Ophtalmologie</option>
                <option value="PSYCHIATRIE" ${specialiste.specialite == 'PSYCHIATRIE' ? 'selected' : ''}>Psychiatrie</option>
                <option value="RADIOLOGIE" ${specialiste.specialite == 'RADIOLOGIE' ? 'selected' : ''}>Radiologie</option>
                <option value="GYNECOLOGIE" ${specialiste.specialite == 'GYNECOLOGIE' ? 'selected' : ''}>Gynécologie</option>
                <option value="ORTHOPEDIE" ${specialiste.specialite == 'ORTHOPEDIE' ? 'selected' : ''}>Orthopédie</option>
                <option value="ORL" ${specialiste.specialite == 'ORL' ? 'selected' : ''}>ORL (Oto-Rhino-Laryngologie)</option>
                <option value="UROLOGIE" ${specialiste.specialite == 'UROLOGIE' ? 'selected' : ''}>Urologie</option>
                <option value="GASTRO_ENTEROLOGIE" ${specialiste.specialite == 'GASTRO_ENTEROLOGIE' ? 'selected' : ''}>Gastro-entérologie</option>
                <option value="ENDOCRINOLOGIE" ${specialiste.specialite == 'ENDOCRINOLOGIE' ? 'selected' : ''}>Endocrinologie</option>
                <option value="RHUMATOLOGIE" ${specialiste.specialite == 'RHUMATOLOGIE' ? 'selected' : ''}>Rhumatologie</option>
            </select>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="tarif">💰 Tarif (DH) <span class="required">*</span></label>
                <input type="number" id="tarif" name="tarif" step="0.01" min="0" value="${specialiste.tarif}" required>
            </div>

            <div class="form-group">
                <label for="dureeConsultation">⏱️ Durée (min) <span class="required">*</span></label>
                <input type="number" id="dureeConsultation" name="dureeConsultation" min="15" max="120" step="15" value="${specialiste.dureeConsultation}" required>
            </div>
        </div>

        <div class="btn-container">
            <a href="${pageContext.request.contextPath}/specialiste/dashboard" class="btn btn-retour">
                ← Retour
            </a>
            <button type="submit" class="btn btn-submit">
                ✅ Enregistrer les modifications
            </button>
        </div>
    </form>
</div>

</body>
</html>
