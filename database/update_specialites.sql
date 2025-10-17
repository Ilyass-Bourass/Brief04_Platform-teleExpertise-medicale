-- Script pour mettre à jour la colonne specialite avec toutes les spécialités

-- Étape 1 : Modifier le type de la colonne specialite de ENUM vers VARCHAR
ALTER TABLE utilisateur
MODIFY COLUMN specialite VARCHAR(50);

-- Étape 2 : Vérification - Afficher les utilisateurs avec leur spécialité
SELECT id, nom, prenom, role, specialite FROM utilisateur WHERE user_role = 'SPECIALISTE';

-- Note : Maintenant vous pouvez utiliser toutes les spécialités :
-- CARDIOLOGIE, PNEUMOLOGIE, DERMATOLOGIE, PEDIATRIE, NEUROLOGIE,
-- OPHTALMOLOGIE, PSYCHIATRIE, RADIOLOGIE, GYNECOLOGIE, ORTHOPEDIE,
-- ORL, UROLOGIE, GASTRO_ENTEROLOGIE, ENDOCRINOLOGIE, RHUMATOLOGIE

