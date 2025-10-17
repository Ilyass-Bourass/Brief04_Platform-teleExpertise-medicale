<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Espace Spécialiste - Télé-Expertise Médicale</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

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

        .welcome { display: flex; align-items: center; gap: 15px; }

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

        .welcome-text h2 { color: #333; font-size: 1.5rem; margin-bottom: 5px; }
        .welcome-text p { color: #666; font-size: 0.9rem; }

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
        }

        .btn-deconnexion:hover {
            background: #c0392b;
            transform: translateY(-2px);
        }

        .alert {
            padding: 12px 18px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-weight: 600;
        }
        .alert-success { background: #d4edda; color: #155724; }
        .alert-error { background: #f8d7da; color: #721c24; }

        .main-section {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }

        .section-header {
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 3px solid #667eea;
        }

        .section-header h2 {
            color: #333;
            font-size: 1.8rem;
        }

        .demande-card {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            border-left: 4px solid #667eea;
            transition: all 0.3s ease;
        }

        .demande-card:hover {
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transform: translateX(5px);
        }

        .demande-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .patient-info {
            font-size: 1.2rem;
            font-weight: 700;
            color: #333;
        }

        .badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .badge-attente { background: #fff3cd; color: #856404; }
        .badge-terminee { background: #d4edda; color: #155724; }
        .badge-annulee { background: #f8d7da; color: #721c24; }
        .badge-urgente { background: #f8d7da; color: #721c24; }
        .badge-normale { background: #d1ecf1; color: #0c5460; }

        .demande-details {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            margin-bottom: 15px;
        }

        .detail-item {
            display: flex;
            gap: 10px;
        }

        .detail-label {
            font-weight: 600;
            color: #666;
        }

        .detail-value {
            color: #333;
        }

        .question-box {
            background: white;
            padding: 15px;
            border-radius: 8px;
            margin: 15px 0;
            border-left: 3px solid #667eea;
        }

        .question-label {
            font-weight: 600;
            color: #667eea;
            margin-bottom: 8px;
        }

        .question-text {
            color: #555;
            line-height: 1.6;
        }

        .actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .btn {
            padding: 10px 25px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-traiter {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }

        .btn-traiter:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-annuler {
            background: #e74c3c;
            color: white;
        }

        .btn-annuler:hover {
            background: #c0392b;
            transform: translateY(-2px);
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }

        .empty-state-icon {
            font-size: 5rem;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<!-- Header -->
<div class="header">
    <div class="welcome">
        <div class="welcome-icon">
            ${fn:substring(sessionScope.utilisateur.nom, 0, 1)}
        </div>
        <div class="welcome-text">
            <h2>Dr. ${sessionScope.utilisateur.prenom} ${sessionScope.utilisateur.nom}</h2>
            <p>Médecin Spécialiste - ${specialiste.specialite}</p>
        </div>
    </div>
    <form action="${pageContext.request.contextPath}/logout" method="post" style="margin: 0;">
        <button type="submit" class="btn-deconnexion">🚪 Déconnexion</button>
    </form>
</div>

<!-- Messages -->
<c:if test="${not empty sessionScope.successMessage}">
    <div class="alert alert-success">${sessionScope.successMessage}</div>
    <c:remove var="successMessage" scope="session" />
</c:if>

<c:if test="${not empty sessionScope.errorMessage}">
    <div class="alert alert-error">${sessionScope.errorMessage}</div>
    <c:remove var="errorMessage" scope="session" />
</c:if>

<!-- Section principale -->
<div class="main-section">
    <div class="section-header">
        <h2>🩺 Demandes d'Expertise Reçues</h2>
    </div>

    <c:choose>
        <c:when test="${empty demandes}">
            <div class="empty-state">
                <div class="empty-state-icon">📭</div>
                <h3>Aucune demande d'expertise</h3>
                <p>Vous n'avez pas encore reçu de demande des médecins généralistes</p>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach items="${demandes}" var="demande">
                <div class="demande-card">
                    <div class="demande-header">
                        <div class="patient-info">
                            👤 ${demande.consultation.patient.nom} ${demande.consultation.patient.prenom}
                        </div>
                        <div>
                            <c:choose>
                                <c:when test="${demande.status == 'EN_ATTENTE'}">
                                    <span class="badge badge-attente">⏳ En Attente</span>
                                </c:when>
                                <c:when test="${demande.status == 'TERMINEE'}">
                                    <span class="badge badge-terminee">✅ Terminée</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-annulee">❌ Annulée</span>
                                </c:otherwise>
                            </c:choose>

                            <c:if test="${demande.priorite == 'URGENTE'}">
                                <span class="badge badge-urgente">🔴 URGENT</span>
                            </c:if>
                        </div>
                    </div>

                    <div class="demande-details">
                        <div class="detail-item">
                            <span class="detail-label">📅 Date RDV :</span>
                            <span class="detail-value">${demande.dateRendezVous}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">⏰ Créneau :</span>
                            <span class="detail-value">${demande.creneauHoraire}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">🩺 Motif consultation :</span>
                            <span class="detail-value">${demande.consultation.motif}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">👨‍⚕️ Demandeur :</span>
                            <span class="detail-value">Dr. ${demande.consultation.medecinGeneraliste.nom}</span>
                        </div>
                    </div>

                    <div class="question-box">
                        <div class="question-label">❓ Question du Médecin Généraliste :</div>
                        <div class="question-text">${demande.question}</div>
                    </div>

                    <c:if test="${demande.status == 'TERMINEE' and not empty demande.avisMedecin}">
                        <div class="question-box" style="border-left-color: #28a745;">
                            <div class="question-label" style="color: #28a745;">✅ Votre Avis :</div>
                            <div class="question-text">${demande.avisMedecin}</div>
                            <c:if test="${not empty demande.recommandations}">
                                <div class="question-label" style="color: #28a745; margin-top: 10px;">💊 Recommandations :</div>
                                <div class="question-text">${demande.recommandations}</div>
                            </c:if>
                        </div>
                    </c:if>

                    <c:if test="${demande.status == 'EN_ATTENTE'}">
                        <div class="actions">
                            <a href="${pageContext.request.contextPath}/specialiste/traiterDemande?id=${demande.id}"
                               class="btn btn-traiter">
                                ✍️ Traiter la Demande
                            </a>
                            <form action="${pageContext.request.contextPath}/specialiste/annulerDemande"
                                  method="post" style="display: inline;"
                                  onsubmit="return confirm('Êtes-vous sûr de vouloir annuler cette demande ?');">
                                <input type="hidden" name="id" value="${demande.id}">
                                <button type="submit" class="btn btn-annuler">❌ Annuler</button>
                            </form>
                        </div>
                    </c:if>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>
