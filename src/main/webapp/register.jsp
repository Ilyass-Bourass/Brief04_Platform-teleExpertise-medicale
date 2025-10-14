<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription - Télé-Expertise Médicale</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 15px;
        }

        .container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.3);
            padding: 30px 35px;
            width: 100%;
            max-width: 450px;
            animation: slideIn 0.5s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .header {
            text-align: center;
            margin-bottom: 25px;
        }

        .header h2 {
            color: #667eea;
            font-size: 1.6rem;
            margin-bottom: 5px;
            font-weight: 700;
        }

        .header p {
            color: #666;
            font-size: 0.85rem;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            color: #333;
            font-weight: 600;
            margin-bottom: 6px;
            font-size: 0.85rem;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px 14px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-group select {
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23667eea' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 14px center;
            padding-right: 40px;
        }

        .btn-submit {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 8px;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.5);
        }

        .btn-submit:active {
            transform: translateY(0);
        }

        .footer-link {
            text-align: center;
            margin-top: 20px;
            font-size: 0.85rem;
            color: #666;
        }

        .footer-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .footer-link a:hover {
            color: #764ba2;
            text-decoration: underline;
        }

        .error-message {
            background: #fee;
            color: #c33;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 15px;
            font-size: 0.85rem;
            border-left: 4px solid #c33;
        }

        .success-message {
            background: #efe;
            color: #3c3;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 15px;
            font-size: 0.85rem;
            border-left: 4px solid #3c3;
        }

        .form-group input::placeholder {
            color: #999;
        }

        option {
            padding: 10px;
        }

        /* Responsive - pour petits écrans */
        @media (max-height: 700px) {
            .container {
                padding: 20px 30px;
                margin: 10px 0;
            }

            .header h2 {
                font-size: 1.4rem;
            }

            .form-group {
                margin-bottom: 12px;
            }

            .form-group input,
            .form-group select {
                padding: 10px 12px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>🏥 Inscription</h2>
            <p>Créez votre compte professionnel</p>
        </div>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <% if (request.getAttribute("success") != null) { %>
            <div class="success-message">
                <%= request.getAttribute("success") %>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/register" method="post">

            <div class="form-group">
                <label for="username">👤 Prénom</label>
                <input type="text"
                       id="username"
                       name="username"
                       placeholder="Entrez votre prénom"
                       required
                       minlength="2"
                       value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
            </div>

            <div class="form-group">
                <label for="secondname">👨‍⚕️ Nom de famille</label>
                <input type="text"
                       id="secondname"
                       name="secondname"
                       placeholder="Entrez votre nom"
                       required
                       minlength="2"
                       value="<%= request.getParameter("secondname") != null ? request.getParameter("secondname") : "" %>">
            </div>

            <div class="form-group">
                <label for="email">📧 Email</label>
                <input type="email"
                       id="email"
                       name="email"
                       placeholder="exemple@medecin.com"
                       required
                       value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
            </div>

            <div class="form-group">
                <label for="password">🔒 Mot de passe</label>
                <input type="password"
                       id="password"
                       name="password"
                       placeholder="Minimum 8 caractères"
                       required
                       minlength="8">
            </div>

            <div class="form-group">
                <label for="role">🩺 Rôle professionnel</label>
                <select name="role" id="role" required>
                    <option value="" disabled selected>-- Sélectionnez --</option>
                    <option value="INFIRMIER" <%= "INFIRMIER".equals(request.getParameter("role")) ? "selected" : "" %>>
                        👩‍⚕️ Infirmier(ère)
                    </option>
                    <option value="GENERALISTE" <%= "GENERALISTE".equals(request.getParameter("role")) ? "selected" : "" %>>
                        👨‍⚕️ Médecin Généraliste
                    </option>
                    <option value="SPECIALISTE" <%= "SPECIALISTE".equals(request.getParameter("role")) ? "selected" : "" %>>
                        🩺 Médecin Spécialiste
                    </option>
                </select>
            </div>

            <button type="submit" class="btn-submit">
                ✨ Créer mon compte
            </button>
        </form>

        <div class="footer-link">
            Déjà inscrit ? <a href="${pageContext.request.contextPath}/login">Se connecter</a>
        </div>
    </div>

    <script>

        document.querySelectorAll('input, select').forEach(element => {
            element.addEventListener('focus', function() {
                this.parentElement.style.transform = 'scale(1.01)';
                this.parentElement.style.transition = 'transform 0.2s ease';
            });

            element.addEventListener('blur', function() {
                this.parentElement.style.transform = 'scale(1)';
            });
        });


        document.querySelector('form').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;

            if (password.length < 8) {
                e.preventDefault();
                alert('Le mot de passe doit contenir au moins 8 caractères');
                return false;
            }
        });
    </script>
</body>
</html>
