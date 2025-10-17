<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Demande d'Expertise - Choix du Créneau</title>
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
            max-width: 1200px;
            margin: 0 auto;
        }

        .header {
            background: white;
            border-radius: 15px;
            padding: 25px 30px;
            margin-bottom: 25px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }

        .header h1 {
            color: #333;
            font-size: 1.8rem;
            margin-bottom: 10px;
        }

        .breadcrumb {
            color: #666;
            font-size: 0.9rem;
        }

        .breadcrumb a {
            color: #4ca1af;
            text-decoration: none;
        }

        .breadcrumb a:hover {
            text-decoration: underline;
        }

        .content-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-bottom: 25px;
        }

        @media (max-width: 1024px) {
            .content-grid {
                grid-template-columns: 1fr;
            }
        }

        .info-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }

        .info-card h2 {
            color: #4ca1af;
            font-size: 1.3rem;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #4ca1af;
        }

        .info-row {
            display: flex;
            margin-bottom: 15px;
            padding: 10px;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .info-label {
            font-weight: 600;
            color: #666;
            min-width: 150px;
        }

        .info-value {
            color: #333;
            flex: 1;
        }

        .form-section {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }

        .form-section h2 {
            color: #f093fb;
            font-size: 1.5rem;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 3px solid #f093fb;
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

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
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
            border-color: #f093fb;
            box-shadow: 0 0 0 3px rgba(240, 147, 251, 0.1);
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

        .section-title {
            color: #666;
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 15px;
            padding-left: 10px;
            border-left: 4px solid #f093fb;
        }

        .badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .badge-specialite {
            background: linear-gradient(135deg, #f093fb, #f5576c);
            color: white;
        }

        .required {
            color: #e74c3c;
        }
    </style>
    <script>
        function chargerCreneauxDisponibles() {
            var dateRendezVous = document.getElementById('dateRendezVous').value;
            var specialisteId = '${specialiste.id}';
            var creneauxSection = document.getElementById('creneauxSection');
            var creneauxMessage = document.getElementById('creneauxMessage');
            var creneauxMatin = document.getElementById('creneauxMatin');
            var creneauxApresMidi = document.getElementById('creneauxApresMidi');

            if (!dateRendezVous) {
                creneauxSection.style.display = 'none';
                return;
            }

            creneauxSection.style.display = 'block';
            creneauxMessage.innerHTML = '⏳ Chargement des créneaux disponibles...';
            creneauxMessage.style.display = 'block';
            creneauxMatin.style.display = 'none';
            creneauxApresMidi.style.display = 'none';

            var xhr = new XMLHttpRequest();
            xhr.open('GET', '${pageContext.request.contextPath}/generaliste/api/creneauxDisponibles?specialisteId=' + specialisteId + '&dateRendezVous=' + dateRendezVous, true);

            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        var response = JSON.parse(xhr.responseText);
                        afficherCreneaux(response.creneaux);
                    } else {
                        creneauxMessage.innerHTML = '❌ Erreur lors du chargement des créneaux';
                        creneauxMessage.style.color = '#e74c3c';
                    }
                }
            };

            xhr.send();
        }

        function afficherCreneaux(creneaux) {
            var creneauxMatinGrid = document.getElementById('creneauxMatinGrid');
            var creneauxApresMidiGrid = document.getElementById('creneauxApresMidiGrid');
            var creneauxMatin = document.getElementById('creneauxMatin');
            var creneauxApresMidi = document.getElementById('creneauxApresMidi');
            var creneauxMessage = document.getElementById('creneauxMessage');

            // Vider les grilles
            creneauxMatinGrid.innerHTML = '';
            creneauxApresMidiGrid.innerHTML = '';

            if (!creneaux || creneaux.length === 0) {
                creneauxMessage.innerHTML = '❌ Aucun créneau disponible pour cette date. Le spécialiste est complet.';
                creneauxMessage.style.color = '#e74c3c';
                creneauxMessage.style.display = 'block';
                creneauxMatin.style.display = 'none';
                creneauxApresMidi.style.display = 'none';
                return;
            }

            // Cacher le message
            creneauxMessage.style.display = 'none';

            // Séparer les créneaux du matin et de l'après-midi
            var creneauxMatinListe = [];
            var creneauxApresMidiListe = [];

            creneaux.forEach(function(creneau) {
                var heure = parseInt(creneau.split('h')[0]);
                if (heure < 12) {
                    creneauxMatinListe.push(creneau);
                } else {
                    creneauxApresMidiListe.push(creneau);
                }
            });

            // Afficher les créneaux du matin
            if (creneauxMatinListe.length > 0) {
                creneauxMatinListe.forEach(function(creneau, index) {
                    var creneauId = 'creneau_matin_' + index;
                    var div = document.createElement('div');
                    div.className = 'creneau-option';
                    div.innerHTML =
                        '<input type="radio" id="' + creneauId + '" name="creneauHoraire" value="' + creneau + '" required>' +
                        '<label for="' + creneauId + '" class="creneau-label">' +
                            '<span class="creneau-time">⏰ ' + creneau + '</span>' +
                            '<span class="creneau-period">Matinée</span>' +
                        '</label>';
                    creneauxMatinGrid.appendChild(div);
                });
                creneauxMatin.style.display = 'block';
            }

            // Afficher les créneaux de l'après-midi
            if (creneauxApresMidiListe.length > 0) {
                creneauxApresMidiListe.forEach(function(creneau, index) {
                    var creneauId = 'creneau_apm_' + index;
                    var div = document.createElement('div');
                    div.className = 'creneau-option';
                    div.innerHTML =
                        '<input type="radio" id="' + creneauId + '" name="creneauHoraire" value="' + creneau + '" required>' +
                        '<label for="' + creneauId + '" class="creneau-label">' +
                            '<span class="creneau-time">⏰ ' + creneau + '</span>' +
                            '<span class="creneau-period">Après-midi</span>' +
                        '</label>';
                    creneauxApresMidiGrid.appendChild(div);
                });
                creneauxApresMidi.style.display = 'block';
            }
        }
    </script>
</head>
<body>

<div class="container">
    <!-- Header -->
    <div class="header">
        <h1>🩺 Demande d'Expertise Médicale</h1>
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/generaliste/dashboard">← Retour au Dashboard</a>
            / Formulaire de Demande de Créneau
        </div>
    </div>

    <div class="content-grid">
        <!-- Carte Consultation -->
        <div class="info-card">
            <h2>📋 Consultation Sélectionnée</h2>
            <div class="info-row">
                <span class="info-label">Patient :</span>
                <span class="info-value"><strong>${consultation.patient.nom} ${consultation.patient.prenom}</strong></span>
            </div>
            <div class="info-row">
                <span class="info-label">N° Sécu :</span>
                <span class="info-value">${consultation.patient.numSecu}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Date Consultation :</span>
                <span class="info-value">${consultation.dateConsultation}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Motif :</span>
                <span class="info-value">${consultation.motif}</span>
            </div>
            <c:if test="${not empty consultation.diagnostic}">
                <div class="info-row">
                    <span class="info-label">Diagnostic :</span>
                    <span class="info-value">${consultation.diagnostic}</span>
                </div>
            </c:if>
            <c:if test="${not empty consultation.observations}">
                <div class="info-row">
                    <span class="info-label">Observations :</span>
                    <span class="info-value">${consultation.observations}</span>
                </div>
            </c:if>
        </div>

        <!-- Carte Spécialiste -->
        <div class="info-card">
            <h2>👨‍⚕️ Spécialiste Sélectionné</h2>
            <div class="info-row">
                <span class="info-label">Nom :</span>
                <span class="info-value"><strong>Dr. ${specialiste.nom} ${specialiste.prenom}</strong></span>
            </div>
            <div class="info-row">
                <span class="info-label">Spécialité :</span>
                <span class="info-value">
                    <span class="badge badge-specialite">${specialiste.specialite}</span>
                </span>
            </div>
            <div class="info-row">
                <span class="info-label">Email :</span>
                <span class="info-value">${specialiste.email}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Tarif :</span>
                <span class="info-value"><strong>${specialiste.tarif} DH</strong></span>
            </div>
            <div class="info-row">
                <span class="info-label">Durée Consultation :</span>
                <span class="info-value">${specialiste.dureeConsultation} minutes</span>
            </div>
        </div>
    </div>

    <!-- Formulaire de demande de créneau -->
    <div class="form-section">
        <h2>📅 Choisir une Date et un Créneau Horaire</h2>

        <form action="${pageContext.request.contextPath}/generaliste/soumettreDemandeExpertise" method="post">

            <input type="hidden" name="consultationId" value="${consultation.id}">
            <input type="hidden" name="specialisteId" value="${specialiste.id}">


            <div class="form-group">
                <label for="question">Question pour le spécialiste <span class="required">*</span></label>
                <textarea id="question" name="question" rows="5" required
                    placeholder="Décrivez votre question ou le cas médical pour lequel vous souhaitez l'avis du spécialiste..."></textarea>
            </div>


            <!-- Date du rendez-vous -->
            <div class="form-group">
                <label for="dateRendezVous">Date souhaitée du rendez-vous <span class="required">*</span></label>
                <input type="date" id="dateRendezVous" name="dateRendezVous" required
                    min="<%= java.time.LocalDate.now() %>" onchange="chargerCreneauxDisponibles()">
            </div>

            <!-- Créneaux horaires (dynamiques) -->
            <div class="form-group" id="creneauxSection" style="display: none;">
                <label>Choisir un créneau horaire <span class="required">*</span></label>
                <div id="creneauxMessage" style="text-align: center; padding: 20px; color: #666;">
                    ⏳ Veuillez d'abord sélectionner une date
                </div>
                <div id="creneauxMatin" style="display: none;">
                    <div class="section-title">🌅 Créneaux du Matin</div>
                    <div class="creneaux-grid" id="creneauxMatinGrid"></div>
                </div>

                <div id="creneauxApresMidi" style="display: none; margin-top: 20px;">
                    <div class="section-title">🌆 Créneaux de l'Après-midi</div>
                    <div class="creneaux-grid" id="creneauxApresMidiGrid"></div>
                </div>
            </div>

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
                    ✅ Envoyer la Demande d'Expertise
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    // Fonction pour charger les créneaux disponibles via AJAX
    function chargerCreneauxDisponibles() {
        var dateRendezVous = document.getElementById('dateRendezVous').value;
        var specialisteId = '${specialiste.id}';
        var creneauxSection = document.getElementById('creneauxSection');
        var creneauxMessage = document.getElementById('creneauxMessage');
        var creneauxMatin = document.getElementById('creneauxMatin');
        var creneauxApresMidi = document.getElementById('creneauxApresMidi');

        if (!dateRendezVous) {
            creneauxSection.style.display = 'none';
            return;
        }

        // Afficher la section et le message de chargement
        creneauxSection.style.display = 'block';
        creneauxMessage.innerHTML = '⏳ Chargement des créneaux disponibles...';
        creneauxMessage.style.display = 'block';
        creneauxMatin.style.display = 'none';
        creneauxApresMidi.style.display = 'none';

        // Appel AJAX
        var xhr = new XMLHttpRequest();
        xhr.open('GET', '${pageContext.request.contextPath}/generaliste/api/creneauxDisponibles?specialisteId=' + specialisteId + '&dateRendezVous=' + dateRendezVous, true);

        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    var response = JSON.parse(xhr.responseText);
                    afficherCreneaux(response.creneaux);
                } else {
                    creneauxMessage.innerHTML = '❌ Erreur lors du chargement des créneaux';
                    creneauxMessage.style.color = '#e74c3c';
                }
            }
        };

        xhr.send();
    }

    // Fonction pour afficher les créneaux disponibles
    function afficherCreneaux(creneaux) {
        var creneauxMatinGrid = document.getElementById('creneauxMatinGrid');
        var creneauxApresMidiGrid = document.getElementById('creneauxApresMidiGrid');
        var creneauxMatin = document.getElementById('creneauxMatin');
        var creneauxApresMidi = document.getElementById('creneauxApresMidi');
        var creneauxMessage = document.getElementById('creneauxMessage');

        // Vider les grilles
        creneauxMatinGrid.innerHTML = '';
        creneauxApresMidiGrid.innerHTML = '';

        if (!creneaux || creneaux.length === 0) {
            creneauxMessage.innerHTML = '❌ Aucun créneau disponible pour cette date. Le spécialiste est complet.';
            creneauxMessage.style.color = '#e74c3c';
            creneauxMessage.style.display = 'block';
            creneauxMatin.style.display = 'none';
            creneauxApresMidi.style.display = 'none';
            return;
        }

        // Cacher le message
        creneauxMessage.style.display = 'none';

        // Séparer les créneaux du matin et de l'après-midi
        var creneauxMatinListe = [];
        var creneauxApresMidiListe = [];

        creneaux.forEach(function(creneau) {
            var heure = parseInt(creneau.split('h')[0]);
            if (heure < 12) {
                creneauxMatinListe.push(creneau);
            } else {
                creneauxApresMidiListe.push(creneau);
            }
        });

        // Afficher les créneaux du matin
        if (creneauxMatinListe.length > 0) {
            creneauxMatinListe.forEach(function(creneau, index) {
                var creneauId = 'creneau_matin_' + index;
                var div = document.createElement('div');
                div.className = 'creneau-option';
                div.innerHTML =
                    '<input type="radio" id="' + creneauId + '" name="creneauHoraire" value="' + creneau + '" required>' +
                    '<label for="' + creneauId + '" class="creneau-label">' +
                        '<span class="creneau-time">⏰ ' + creneau + '</span>' +
                        '<span class="creneau-period">Matinée</span>' +
                    '</label>';
                creneauxMatinGrid.appendChild(div);
            });
            creneauxMatin.style.display = 'block';
        }

        // Afficher les créneaux de l'après-midi
        if (creneauxApresMidiListe.length > 0) {
            creneauxApresMidiListe.forEach(function(creneau, index) {
                var creneauId = 'creneau_apm_' + index;
                var div = document.createElement('div');
                div.className = 'creneau-option';
                div.innerHTML =
                    '<input type="radio" id="' + creneauId + '" name="creneauHoraire" value="' + creneau + '" required>' +
                    '<label for="' + creneauId + '" class="creneau-label">' +
                        '<span class="creneau-time">⏰ ' + creneau + '</span>' +
                        '<span class="creneau-period">Après-midi</span>' +
                    '</label>';
                creneauxApresMidiGrid.appendChild(div);
            });
            creneauxApresMidi.style.display = 'block';
        }
    }
</script>

</body>
</html>
