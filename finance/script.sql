CREATE TABLE Categorie(
    Id_Categorie SERIAL,
    compte INTEGER NOT NULL,
    nom_categorie VARCHAR(50)  NOT NULL,
    PRIMARY KEY(Id_Categorie)
);

CREATE TABLE Sous_Categorie(
    Id_Sous_Categorie SERIAL,
    compte INTEGER NOT NULL,
    nom_sous_categorie VARCHAR(50)  NOT NULL,
    Id_Categorie INTEGER NOT NULL,
    PRIMARY KEY(Id_Sous_Categorie),
    FOREIGN KEY(Id_Categorie) REFERENCES Categorie(Id_Categorie)
);

CREATE TABLE Sous_Sous_Categorie(
    Id_Sous_Sous_Categorie SERIAL,
    compte INTEGER NOT NULL,
    nom VARCHAR(50)  NOT NULL,
    Id_Sous_Categorie INTEGER NOT NULL,
    PRIMARY KEY(Id_Sous_Sous_Categorie),
    FOREIGN KEY(Id_Sous_Categorie) REFERENCES Sous_Categorie(Id_Sous_Categorie)
);

CREATE TABLE Entreprise(
    Id_Entreprise SERIAL,
    nom VARCHAR(50) ,
    PRIMARY KEY(Id_Entreprise)
);

CREATE TABLE Bilan(
    Id_Bilan SERIAL,
    description_note VARCHAR(50) ,
    valeur NUMERIC(15,2)   NOT NULL,
    date_enregistrement DATE NOT NULL,
    Id_Entreprise INTEGER NOT NULL,
    Id_Sous_Sous_Categorie INTEGER,
    Id_Sous_Categorie INTEGER,
    Id_Categorie INTEGER NOT NULL,
    PRIMARY KEY(Id_Bilan),
    FOREIGN KEY(Id_Entreprise) REFERENCES Entreprise(Id_Entreprise),
    FOREIGN KEY(Id_Sous_Sous_Categorie) REFERENCES Sous_Sous_Categorie(Id_Sous_Sous_Categorie),
    FOREIGN KEY(Id_Sous_Categorie) REFERENCES Sous_Categorie(Id_Sous_Categorie),
    FOREIGN KEY(Id_Categorie) REFERENCES Categorie(Id_Categorie)
);


-- Entreprise
INSERT INTO Entreprise (nom) VALUES 
('SARL Example'),
('SA Finance Corp');

-- Categories principales
INSERT INTO Categorie (compte, nom_categorie) VALUES 
(100, 'Actifs non courants'),
(200, 'Actifs courants'),
(300, 'Capitaux propres'),
(400, 'Passifs non courants'),
(500, 'Passifs courants'),
(600, 'Charges'),
(700, 'Revenus (Produits)');

-- Sous categories
INSERT INTO Sous_Categorie (compte, nom_sous_categorie, Id_Categorie) VALUES
-- Actifs non courants
(110, 'Immobilisations incorporelles', 1),
(120, 'Immobilisations corporelles', 1),
(130, 'Immobilisations financieres', 1),
-- Actifs courants
(210, 'Stocks', 2),
(220, 'Creances et emplois assimiles', 2),
(230, 'Tresorerie', 2),
-- Capitaux propres
(310, 'Capital emis', 3),
(320, 'Reserves', 3),
-- Passifs non courants
(410, 'Emprunts et dettes financieres', 4),
(420, 'Impots differes', 4),
-- Passifs courants
(510, 'Fournisseurs', 5),
(520, 'Dettes fiscales', 5),
-- Charges (600)
(610, 'Achats consommes', 6),
(620, 'Services exterieurs', 6),
(630, 'Charges de personnel', 6),
(640, 'Impots et taxes', 6),
(650, 'Charges financieres', 6),
(660, 'Charges exceptionnelles', 6),
-- Revenus (700)
(710, 'Ventes de marchandises', 7),
(720, 'Production vendue', 7),
(730, 'Produits financiers', 7),
(740, 'Produits exceptionnels', 7);

-- Sous-sous categories
INSERT INTO Sous_Sous_Categorie (compte, nom, Id_Sous_Categorie) VALUES
-- Immobilisations
(111, 'Frais de developpement', 1),
(112, 'Logiciels', 1),
(121, 'Terrains', 2),
(122, 'Batiments', 2),
(123, 'Installations techniques', 2),
-- Stocks et tresorerie
(211, 'Matieres premieres', 4),
(212, 'Produits finis', 4),
(231, 'Banque', 6),
(232, 'Caisse', 6),
-- Capitaux propres
(311, 'Capital social', 7),
(312, 'Capital non appele', 7),
(321, 'Reserves legales', 8),
(322, 'Reserves statutaires', 8),
-- Passifs
(411, 'Emprunts obligataires', 9),
(412, 'Emprunts bancaires', 9),
(421, 'Impots differes passif', 10),
(422, 'Provisions fiscales', 10),
(511, 'Fournisseurs locaux', 11),
(512, 'Fournisseurs etrangers', 11),
(521, 'TVA a payer', 12),
(522, 'Autres impots a payer', 12),
-- Charges
(611, 'Achats de marchandises', 13),
(612, 'Matieres premieres', 13),
(621, 'Locations', 14),
(622, 'Entretien et reparations', 14),
(631, 'Salaires', 15),
(632, 'Charges sociales', 15),
(651, 'Interets bancaires', 17),
(652, 'Pertes de change', 17),
-- Revenus
(711, 'Ventes locales', 19),
(712, 'Ventes export', 19),
(721, 'Prestations de services', 20),
(722, 'Produits des activites annexes', 20),
(731, 'Revenus des titres', 21),
(732, 'Gains de change', 21);

-- Bilan data
INSERT INTO Bilan (description_note, valeur, date_enregistrement, Id_Entreprise, Id_Sous_Sous_Categorie, Id_Sous_Categorie, Id_Categorie) VALUES
-- Actifs non courants
('Logiciel comptable', 50000.00, '2023-01-01', 1, 2, 1, 1),
('Terrain principal', 800000.00, '2023-01-01', 1, 3, 2, 1),
('Batiment siege', 1200000.00, '2023-01-01', 1, 4, 2, 1),

-- Actifs courants
('Stock matieres premieres', 300000.00, '2023-03-31', 1, 6, 4, 2),
('Stock produits finis', 450000.00, '2023-03-31', 1, 7, 4, 2),
('Compte bancaire BNI', 250000.00, '2023-03-31', 1, 8, 6, 2),
('Caisse principale', 25000.00, '2023-03-31', 1, 9, 6, 2),

-- Capitaux propres
('Capital initial', 2000000.00, '2023-01-01', 1, 13, 7, 3),
('Reserve legale', 100000.00, '2023-03-31', 1, 15, 8, 3),

-- Passifs non courants
('Emprunt bancaire long terme', 800000.00, '2023-01-01', 1, 17, 9, 4),
('Provision fiscale', 150000.00, '2023-03-31', 1, 20, 10, 4),

-- Passifs courants
('Dettes fournisseurs locaux', 200000.00, '2023-03-31', 1, 21, 11, 5),
('TVA a payer', 75000.00, '2023-03-31', 1, 23, 12, 5),

-- Charges (600)
('Achat marchandises', 200000.00, '2023-01-20', 1, 26, 13, 6),
('Location bureau', 50000.00, '2023-02-15', 1, 28, 14, 6),
('Salaires mars', 100000.00, '2023-03-05', 1, 30, 15, 6),
('Charges sociales', 30000.00, '2023-03-15', 1, 31, 15, 6),
('Interets bancaires', 25000.00, '2023-03-30', 1, 32, 17, 6),

-- Revenus (700)
('Vente locale janvier', 300000.00, '2023-01-15', 1, 33, 19, 7),
('Vente export fevrier', 200000.00, '2023-02-20', 1, 34, 19, 7),
('Services mars', 150000.00, '2023-03-10', 1, 35, 20, 7),
('Gain change avril', 50000.00, '2023-04-10', 1, 34, 21, 7);

-- Entries without subcategories
INSERT INTO Bilan (description_note, valeur, date_enregistrement, Id_Entreprise, Id_Sous_Sous_Categorie, Id_Sous_Categorie, Id_Categorie) VALUES
('Vente locale janvier', 300000.00, '2023-01-15', 1, null, null, 7),
('Vente export fevrier', 200000.00, '2023-02-20', 1, null, null, 7);


-- I. Production de l'exercice
CREATE VIEW vue_production_exercice AS
WITH chiffre_affaires AS (
    SELECT COALESCE(SUM(valeur), 0) as ca
    FROM Bilan
    WHERE Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '71%')
),
production_stockee AS (
    SELECT COALESCE(SUM(valeur), 0) as ps
    FROM Bilan
    WHERE Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '72%')
),
production_immobilisee AS (
    SELECT COALESCE(SUM(valeur), 0) as pi
    FROM Bilan
    WHERE Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '73%')
),
production AS (
    SELECT COALESCE(SUM(valeur), 0) as p
    FROM Bilan
    WHERE Id_Categorie = 7
    AND Id_Sous_Categorie IS NULL
)
SELECT (ca + ps + pi + p) as production_exercice
FROM chiffre_affaires, production_stockee, production_immobilisee, production;


-- II. Consommation de l'exercice
CREATE VIEW vue_consommation_exercice AS
WITH achats_consommes AS (
    SELECT COALESCE(SUM(valeur), 0) as ac
    FROM Bilan
    WHERE Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '61%')
),
services_exterieurs AS (
    SELECT COALESCE(SUM(valeur), 0) as se
    FROM Bilan
    WHERE Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '62%')
),
consommation AS (
    SELECT COALESCE(SUM(valeur), 0) as c
    FROM Bilan
    WHERE Id_Categorie = 6
    AND Id_Sous_Categorie IS NULL
)
SELECT (ac + se + c) as consommation_exercice
FROM achats_consommes, services_exterieurs, consommation;



-- III. Valeur ajoutée d'exploitation
CREATE VIEW vue_valeur_ajoutee AS
SELECT 
    (production.production_exercice - consommation.consommation_exercice) as valeur_ajoutee
FROM 
    vue_production_exercice production,
    vue_consommation_exercice consommation;


-- IV. EBE (Excédent brut d'exploitation)
CREATE VIEW vue_ebe AS
WITH charges_personnel AS (
    SELECT COALESCE(SUM(valeur), 0) as cp
    FROM Bilan
    WHERE Id_Categorie = 6
    AND Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '63%')
),
impots_taxes AS (
    SELECT COALESCE(SUM(valeur), 0) as it
    FROM Bilan
    WHERE Id_Categorie = 6
    AND Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '64%')
)
SELECT 
    (va.valeur_ajoutee - cp - it) as ebe
FROM 
    vue_valeur_ajoutee va,
    charges_personnel,
    impots_taxes;





