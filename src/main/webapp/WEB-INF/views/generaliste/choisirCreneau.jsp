<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Choisir un Créneau - Demande d'Expertise</title>
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

        .info-box p {
            margin-bottom: 8px;
        }

        .alert-warning {
            background: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 15px;
            margin-bottom: 25px;
            border-radius: 8px;
            color: #856404;
        }

        .section-title {
            color: #666;
            font-size: 1.2rem;
            font-weight: 600;
            margin: 25px 0 15px 0;
            padding-left: 10px;
            border-left: 4px solid #f093fb;
        }

        .creneaux-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            margin-bottom: 25px;
        }

        .creneau-option {
            position: relative;
        }

        .creneau-option input[type="radio"] {
            position: absolute;
            opacity: 0;
        }

        .creneau-label {
            display: block;
            padding: 15px 20px;
            background: #f8f9fa;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            font-weight: 600;
        }

        .creneau-option input[type="radio"]:checked + .creneau-label {
            background: linear-gradient(135deg, #f093fb, #f5576c);
            color: white;
            border-color: #f093fb;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(240, 147, 251, 0.4);
        }

        .creneau-label:hover {
            border-color: #f093fb;
            transform: translateY(-2px);
        }

        .creneau-time {
            font-size: 1.1rem;
            display: block;
        }

        .creneau-period {
            font-size: 0.85rem;
            opacity: 0.8;
            margin-top: 5px;
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

        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-group textarea:focus,
        .form-group select:focus {
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
        <h1>🩺 Demande d'Expertise - Étape 2</h1>
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/generaliste/dashboard">← Retour au Dashboard</a>
        </div>

        <div class="info-box">
            <p><strong>📋 Consultation :</strong> ${consultation.patient.nom} ${consultation.patient.prenom} - ${consultation.motif}</p>
            <p><strong>👨‍⚕️ Spécialiste :</strong> Dr. ${specialiste.nom} ${specialiste.prenom} (${specialiste.specialite})</p>
            <p><strong>📅 Date choisie :</strong> ${dateRendezVous}</p>
        </div>

        <c:choose>
            <c:when test="${empty creneauxDisponibles}">
                <div class="alert-warning">
                    <strong>❌ Aucun créneau disponible</strong>
                    <p>Le spécialiste n'a aucun créneau disponible pour cette date. Tous les créneaux sont déjà réservés.</p>
                    <p>Veuillez choisir une autre date.</p>
                </div>
                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/generaliste/dashboard" class="btn btn-secondary">
                        ← Retour au Dashboard
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <h2 style="color: #333; margin-bottom: 20px;">Choisir un créneau et compléter la demande</h2>

                <form action="${pageContext.request.contextPath}/generaliste/soumettreDemandeExpertise" method="post">
                    <input type="hidden" name="consultationId" value="${consultation.id}">
                    <input type="hidden" name="specialisteId" value="${specialiste.id}">
                    <input type="hidden" name="dateRendezVous" value="${dateRendezVous}">

                    <div class="section-title">🌅 Créneaux du Matin</div>
                    <div class="creneaux-grid">
                        <c:set var="hasMatinCreneaux" value="false" />
                        <c:forEach items="${creneauxDisponibles}" var="creneau">
                            <c:set var="heure" value="${creneau.substring(0, 2)}" />
                            <c:if test="${heure < '12'}">
                                <c:set var="hasMatinCreneaux" value="true" />
                                <div class="creneau-option">
                                    <input type="radio" id="creneau_${creneau}" name="creneauHoraire" value="${creneau}" required>
                                    <label for="creneau_${creneau}" class="creneau-label">
                                        <span class="creneau-time">⏰ ${creneau}</span>
                                        <span class="creneau-period">Matinée</span>
                                    </label>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                    <c:if test="${!hasMatinCreneaux}">
                        <p style="color: #999; text-align: center; margin-bottom: 25px;">Aucun créneau disponible le matin</p>
                    </c:if>

                    <!-- Créneaux de l'après-midi -->
                    <div class="section-title">🌆 Créneaux de l'Après-midi</div>
                    <div class="creneaux-grid">
                        <c:set var="hasApresMidiCreneaux" value="false" />
                        <c:forEach items="${creneauxDisponibles}" var="creneau">
                            <c:set var="heure" value="${creneau.substring(0, 2)}" />
                            <c:if test="${heure >= '12'}">
                                <c:set var="hasApresMidiCreneaux" value="true" />
                                <div class="creneau-option">
                                    <input type="radio" id="creneau_${creneau}" name="creneauHoraire" value="${creneau}" required>
                                    <label for="creneau_${creneau}" class="creneau-label">
                                        <span class="creneau-time">⏰ ${creneau}</span>
                                        <span class="creneau-period">Après-midi</span>
                                    </label>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                    <c:if test="${!hasApresMidiCreneaux}">
                        <p style="color: #999; text-align: center; margin-bottom: 25px;">Aucun créneau disponible l'après-midi</p>
                    </c:if>

                    <!-- Question pour le spécialiste -->
                    <div class="form-group">
                        <label for="question">Question pour le spécialiste <span class="required">*</span></label>
                        <textarea id="question" name="question" rows="5" required
                            placeholder="Décrivez votre question ou le cas médical pour lequel vous souhaitez l'avis du spécialiste..."></textarea>
                    </div>

                    <!-- Priorité -->
                    <div class="form-group">
                        <label for="priorite">Niveau de priorité</label>
                        <select id="priorite" name="priorite">
                            <option value="NORMALE" selected>⚪ Normale</option>
                            <option value="URGENTE">🔴 Urgente</option>
                            <option value="NON_URGENTE">🟢 Non urgente</option>
                        </select>
                    </div>

                    <!-- Actions -->
                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/generaliste/dashboard" class="btn btn-secondary">
                            ← Annuler
                        </a>
                        <button type="submit" class="btn btn-primary">
                            ✅ Confirmer la Demande d'Expertise
                        </button>
                    </div>
                </form>
            </c:otherwise>
        </c:choose>
    </div>
</div>

</body>
</html>

