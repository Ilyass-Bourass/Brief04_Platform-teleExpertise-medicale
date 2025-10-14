<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Télé-Expertise Médicale - Accueil</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            padding: 40px;
            max-width: 600px;
            width: 100%;
        }
        h1 {
            color: #667eea;
            text-align: center;
            margin-bottom: 10px;
            font-size: 2rem;
        }
        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
            font-size: 0.95rem;
        }
        .menu {
            list-style: none;
        }
        .menu li {
            margin-bottom: 15px;
        }
        .menu a {
            display: block;
            padding: 15px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 10px;
            transition: all 0.3s ease;
            font-weight: 500;
        }
        .menu a:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        .menu a.test {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }
        .menu a.test:hover {
            box-shadow: 0 5px 15px rgba(245, 87, 108, 0.4);
        }
        .status {
            margin-top: 30px;
            padding: 15px;
            background: #f0f4ff;
            border-left: 4px solid #667eea;
            border-radius: 5px;
        }
        .status strong {
            color: #667eea;
        }
        .emoji {
            font-size: 1.2em;
            margin-right: 8px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏥 Télé-Expertise Médicale</h1>
        <p class="subtitle">Système de coordination médecin-patient</p>

        <ul class="menu">
            <li>
                <a href="test-connexion" class="test">
                    <span class="emoji">🔍</span>
                    Tester la connexion à la base de données
                </a>
            </li>
            <li>
                <a href="hello-servlet">
                    <span class="emoji">👋</span>
                    Hello Servlet (test basique)
                </a>
            </li>
            <li>
                <a href="#" style="opacity: 0.5; cursor: not-allowed;">
                    <span class="emoji">👨‍⚕️</span>
                    Espace Médecin Généraliste (à venir)
                </a>
            </li>
            <li>
                <a href="#" style="opacity: 0.5; cursor: not-allowed;">
                    <span class="emoji">🩺</span>
                    Espace Médecin Spécialiste (à venir)
                </a>
            </li>
            <li>
                <a href="#" style="opacity: 0.5; cursor: not-allowed;">
                    <span class="emoji">👩‍⚕️</span>
                    Espace Infirmier (à venir)
                </a>
            </li>
        </ul>

        <div class="status">
            <strong>📊 Statut du projet :</strong><br>
            ✅ Serveur Tomcat démarré<br>
            ✅ Configuration JPA/Hibernate OK<br>
            ⏳ Développement en cours...
        </div>
    </div>
</body>
</html>

