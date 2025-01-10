

CREATE TABLE entreprise (
    id_entreprise SERIAL PRIMARY KEY,
    nom_entreprise VARCHAR(100) NOT NULL,
    secteur_activite VARCHAR(50),
    date_creation DATE
);

CREATE TABLE bilan (
    id_bilan SERIAL PRIMARY KEY,
    id_entreprise INTEGER NOT NULL,
    annee INTEGER NOT NULL,
    date_creation DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (id_entreprise) REFERENCES entreprise(id_entreprise) ON DELETE CASCADE
);

CREATE TABLE bilan_details (
    id_detail_bilan SERIAL PRIMARY KEY,
    id_bilan INTEGER NOT NULL,
    categorie VARCHAR(50) NOT NULL,        -- Exemple : "Actifs", "Passifs"
    sous_categorie VARCHAR(50) NOT NULL,   -- Exemple : "Actifs courants"
    montant DECIMAL(15,2) NOT NULL,        -- Valeur avec 2 décimales
    FOREIGN KEY (id_bilan) REFERENCES bilan(id_bilan) ON DELETE CASCADE
);

CREATE TABLE compte_resultat (
    id_resultat SERIAL PRIMARY KEY,
    id_entreprise INTEGER NOT NULL,
    annee INTEGER NOT NULL,
    date_creation DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (id_entreprise) REFERENCES entreprise(id_entreprise) ON DELETE CASCADE
);

CREATE TABLE compte_resultat_details (
    id_detail_resultat SERIAL PRIMARY KEY,
    categorie VARCHAR(50) NOT NULL,        -- Exemple : "Revenus", "Charges"
    id_resultat INTEGER NOT NULL,
    sous_categorie VARCHAR(50) NOT NULL,   -- Exemple : "Charges d'exploitation"
    montant DECIMAL(15,2) NOT NULL,        -- Valeur avec 2 décimales
    FOREIGN KEY (id_resultat) REFERENCES compte_resultat(id_resultat) ON DELETE CASCADE
);

CREATE TABLE indicateurs_financiers (
    id_indicateur SERIAL PRIMARY KEY,
    id_bilan INTEGER NOT NULL,
    id_resultat INTEGER NOT NULL,
    marge_nette DECIMAL(15,2),            -- En pourcentage
    retour_actifs DECIMAL(15,2),          -- ROA : Return on Assets
    retour_capitaux_propres DECIMAL(15,2),-- ROE : Return on Equity
    ratio_liquidite_generale DECIMAL(15,2),
    ratio_liquidite_reduite DECIMAL(15,2),
    ratio_endettement_global DECIMAL(15,2),
    couverture_interets DECIMAL(15,2),
    levier_financier DECIMAL(15,2),
    FOREIGN KEY (id_bilan) REFERENCES bilan(id_bilan) ON DELETE CASCADE,
    FOREIGN KEY (id_resultat) REFERENCES compte_resultat(id_resultat) ON DELETE CASCADE
);

INSERT INTO entreprise (nom_entreprise, secteur_activite, date_creation)
VALUES ('TechSol Inc.', 'SaaS', '2015-06-12');

INSERT INTO bilan (id_entreprise, annee)
VALUES (1, 2023);

INSERT INTO bilan_details (id_bilan, categorie, sous_categorie, montant)
VALUES 
(1, 'Actifs', 'Actifs courants', 250000),
(1, 'Actifs', 'Actifs immobilisés', 600000),
(1, 'Passifs', 'Passifs courants', 120000),
(1, 'Passifs', 'Passifs non courants', 300000),
(1, 'Capitaux Propres', 'Capitaux propres', 430000);

INSERT INTO compte_resultat (id_entreprise, annee)
VALUES (1, 2023);

INSERT INTO compte_resultat_details (id_resultat, categorie, sous_categorie, montant)
VALUES 
(1, 'Revenus', 'Revenus', 800000),
(1, 'Charges', 'Charges d''exploitation', 500000),
(1, 'Charges', 'Charges financières', 20000),
(1, 'Charges', 'Impôts', 80000),
(1, 'Résultat', 'Résultat net', 200000);

