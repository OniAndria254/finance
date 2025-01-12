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
CREATE OR REPLACE FUNCTION vue_production_exercice(annee INTEGER) 
RETURNS TABLE (production_exercice NUMERIC) AS $$
BEGIN
    RETURN QUERY
    WITH chiffre_affaires AS (
        SELECT COALESCE(SUM(valeur), 0) as ca
        FROM Bilan
        WHERE Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '71%')
        AND EXTRACT(YEAR FROM date_enregistrement) = annee
    ),
    production_stockee AS (
        SELECT COALESCE(SUM(valeur), 0) as ps
        FROM Bilan
        WHERE Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '72%')
        AND EXTRACT(YEAR FROM date_enregistrement) = annee
    ),
    production_immobilisee AS (
        SELECT COALESCE(SUM(valeur), 0) as pi
        FROM Bilan
        WHERE Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '73%')
        AND EXTRACT(YEAR FROM date_enregistrement) = annee
    ),
    production AS (
        SELECT COALESCE(SUM(valeur), 0) as p
        FROM Bilan
        WHERE Id_Categorie = 7
        AND Id_Sous_Categorie IS NULL
        AND EXTRACT(YEAR FROM date_enregistrement) = annee
    )
    SELECT (ca + ps + pi + p) as production_exercice
    FROM chiffre_affaires, production_stockee, production_immobilisee, production;
END;
$$ LANGUAGE plpgsql;

-- II. Consommation de l'exercice
CREATE OR REPLACE FUNCTION vue_consommation_exercice(annee INTEGER) 
RETURNS TABLE (consommation_exercice NUMERIC) AS $$
BEGIN
    RETURN QUERY
    WITH achats_consommes AS (
        SELECT COALESCE(SUM(valeur), 0) as ac
        FROM Bilan
        WHERE Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '61%')
        AND EXTRACT(YEAR FROM date_enregistrement) = annee
    ),
    services_exterieurs AS (
        SELECT COALESCE(SUM(valeur), 0) as se
        FROM Bilan
        WHERE Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '62%')
        AND EXTRACT(YEAR FROM date_enregistrement) = annee
    ),
    consommation AS (
        SELECT COALESCE(SUM(valeur), 0) as c
        FROM Bilan
        WHERE Id_Categorie = 6
        AND Id_Sous_Categorie IS NULL
        AND EXTRACT(YEAR FROM date_enregistrement) = annee
    )
    SELECT (ac + se + c) as consommation_exercice
    FROM achats_consommes, services_exterieurs, consommation;
END;
$$ LANGUAGE plpgsql;

-- III. Valeur ajoutée
CREATE OR REPLACE FUNCTION vue_valeur_ajoutee(annee INTEGER) 
RETURNS TABLE (valeur_ajoutee NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        (p.production_exercice - c.consommation_exercice) as valeur_ajoutee
    FROM 
        vue_production_exercice(annee) p,
        vue_consommation_exercice(annee) c;
END;
$$ LANGUAGE plpgsql;

-- IV. EBE
CREATE OR REPLACE FUNCTION vue_ebe(annee INTEGER) 
RETURNS TABLE (ebe NUMERIC) AS $$
BEGIN
    RETURN QUERY
    WITH charges_personnel AS (
        SELECT COALESCE(SUM(valeur), 0) as cp
        FROM Bilan
        WHERE Id_Categorie = 6
        AND Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '63%')
        AND EXTRACT(YEAR FROM date_enregistrement) = annee
    ),
    impots_taxes AS (
        SELECT COALESCE(SUM(valeur), 0) as it
        FROM Bilan
        WHERE Id_Categorie = 6
        AND Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '64%')
        AND EXTRACT(YEAR FROM date_enregistrement) = annee
    )
    SELECT
        (va.valeur_ajoutee - cp - it) as ebe
    FROM
        vue_valeur_ajoutee(annee) va,
        charges_personnel,
        impots_taxes;
END;
$$ LANGUAGE plpgsql;

-- V. Résultat opérationnel
CREATE OR REPLACE FUNCTION vue_resultat_operationnel(annee INTEGER) 
RETURNS TABLE (resultat_operationnel NUMERIC) AS $$
BEGIN
    RETURN QUERY
    WITH autres_produits AS (
        SELECT COALESCE(SUM(valeur), 0) as ap
        FROM Bilan
        WHERE Id_Categorie = 7
        AND Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '75%')
        AND EXTRACT(YEAR FROM date_enregistrement) = annee
    ),
    autres_charges AS (
        SELECT COALESCE(SUM(valeur), 0) as ac
        FROM Bilan
        WHERE Id_Categorie = 6
        AND Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '65%')
        AND EXTRACT(YEAR FROM date_enregistrement) = annee
    ),
    dotations AS (
        SELECT COALESCE(SUM(valeur), 0) as dot
        FROM Bilan
        WHERE Id_Categorie = 6
        AND Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '68%')
        AND EXTRACT(YEAR FROM date_enregistrement) = annee
    ),
    reprises AS (
        SELECT COALESCE(SUM(valeur), 0) as rep
        FROM Bilan
        WHERE Id_Categorie = 7
        AND Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '78%')
        AND EXTRACT(YEAR FROM date_enregistrement) = annee
    )
    SELECT
        (e.ebe + ap - ac - dot + rep) as resultat_operationnel
    FROM
        vue_ebe(annee) e,
        autres_produits,
        autres_charges,
        dotations,
        reprises;
END;
$$ LANGUAGE plpgsql;

-- VI. Résultat financier
CREATE OR REPLACE FUNCTION vue_resultat_financier(annee INTEGER) 
RETURNS TABLE (resultat_financier NUMERIC) AS $$
BEGIN
    RETURN QUERY
    WITH produits_financiers AS (
        SELECT COALESCE(SUM(valeur), 0) as pf
        FROM Bilan
        WHERE Id_Categorie = 7
        AND Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '76%')
        AND EXTRACT(YEAR FROM date_enregistrement) = annee
    ),
    charges_financieres AS (
        SELECT COALESCE(SUM(valeur), 0) as cf
        FROM Bilan
        WHERE Id_Categorie = 6
        AND Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '66%')
        AND EXTRACT(YEAR FROM date_enregistrement) = annee
    )
    SELECT (pf - cf) as resultat_financier
    FROM produits_financiers, charges_financieres;
END;
$$ LANGUAGE plpgsql;

-- VII. Résultat avant impôts
CREATE OR REPLACE FUNCTION vue_resultat_avant_impots(annee INTEGER) 
RETURNS TABLE (resultat_avant_impots NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT
        (ro.resultat_operationnel + rf.resultat_financier) as resultat_avant_impots
    FROM
        vue_resultat_operationnel(annee) ro,
        vue_resultat_financier(annee) rf;
END;
$$ LANGUAGE plpgsql;

-- VIII. Résultat net ordinaire
CREATE OR REPLACE FUNCTION vue_resultat_net_ordinaire(annee INTEGER) 
RETURNS TABLE (resultat_net_ordinaire NUMERIC) AS $$
BEGIN
    RETURN QUERY
    WITH impots_exigibles AS (
        SELECT COALESCE(SUM(valeur), 0) as ie
        FROM Bilan
        WHERE Id_Categorie = 6
        AND Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '695%')
        AND EXTRACT(YEAR FROM date_enregistrement) = annee
    ),
    impots_differes AS (
        SELECT COALESCE(SUM(valeur), 0) as id
        FROM Bilan
        WHERE Id_Categorie = 6
        AND Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '692%')
        AND EXTRACT(YEAR FROM date_enregistrement) = annee
    )
    SELECT
        (rai.resultat_avant_impots - ie + id) as resultat_net_ordinaire
    FROM
        vue_resultat_avant_impots(annee) rai,
        impots_exigibles,
        impots_differes;
END;
$$ LANGUAGE plpgsql;

-- IX. Résultat extraordinaire
CREATE OR REPLACE FUNCTION vue_resultat_extraordinaire(annee INTEGER) 
RETURNS TABLE (resultat_extraordinaire NUMERIC) AS $$
BEGIN
    RETURN QUERY
    WITH produits_extra AS (
        SELECT COALESCE(SUM(valeur), 0) as pe
        FROM Bilan
        WHERE Id_Categorie = 7
        AND Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '77%')
        AND EXTRACT(YEAR FROM date_enregistrement) = annee
    ),
    charges_extra AS (
        SELECT COALESCE(SUM(valeur), 0) as ce
        FROM Bilan
        WHERE Id_Categorie = 6
        AND Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '67%')
        AND EXTRACT(YEAR FROM date_enregistrement) = annee
    )
    SELECT (pe - ce) as resultat_extraordinaire
    FROM produits_extra, charges_extra;
END;
$$ LANGUAGE plpgsql;

-- X. Résultat net
CREATE OR REPLACE FUNCTION vue_resultat_net(annee INTEGER) 
RETURNS TABLE (resultat_net NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT
        (rno.resultat_net_ordinaire + re.resultat_extraordinaire) as resultat_net
    FROM
        vue_resultat_net_ordinaire(annee) rno,
        vue_resultat_extraordinaire(annee) re;
END;
$$ LANGUAGE plpgsql;



SELECT * FROM vue_production_exercice(2023);
SELECT * FROM vue_consommation_exercice(2023);
SELECT * FROM vue_valeur_ajoutee(2023);
SELECT * FROM vue_ebe(2023);
SELECT * FROM vue_resultat_operationnel(2023);
SELECT * FROM vue_resultat_financier(2023);
SELECT * FROM vue_resultat_avant_impots(2023);
SELECT * FROM vue_resultat_net_ordinaire(2023);
SELECT * FROM vue_resultat_extraordinaire(2023);
SELECT * FROM vue_resultat_net(2023);

-- requete pour afficher les données de la table Bilan(efa niala ny charge si produit)
SELECT 
    b.Id_Bilan,
    c.Id_Categorie,
    c.compte AS compte_categorie,
    c.nom_categorie AS nom_categorie,
    sc.Id_Sous_Categorie,
    sc.compte AS compte_sous_categorie,
    sc.nom_sous_categorie AS nom_sous_categorie,
    ssc.Id_Sous_Sous_Categorie,
    ssc.compte AS compte_sous_sous_categorie,
    ssc.nom AS nom_sous_sous_categorie,
    b.description_note,
    b.valeur
FROM 
    Bilan b
INNER JOIN 
    Categorie c ON b.Id_Categorie = c.Id_Categorie
LEFT JOIN 
    Sous_Categorie sc ON b.Id_Sous_Categorie = sc.Id_Sous_Categorie
LEFT JOIN 
    Sous_Sous_Categorie ssc ON b.Id_Sous_Sous_Categorie = ssc.Id_Sous_Sous_Categorie
WHERE 
    c.compte::text NOT LIKE '6%'  
    AND c.compte::text NOT LIKE '7%'  
ORDER BY 
    b.Id_Bilan;
