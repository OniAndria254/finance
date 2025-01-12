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

INSERT INTO Bilan (description_note, valeur, date_enregistrement, Id_Entreprise, Id_Sous_Sous_Categorie, Id_Sous_Categorie, Id_Categorie) VALUES
('Vente locale janvier', 300000.00, '2023-01-15', 1, null, null, 7),
('Vente export fevrier', 200000.00, '2023-02-20', 1, null, null, 7);

-- Entries without subcategories
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
-- Classe 1 - Comptes de capitaux
(101, 'Capital', 1),
(104, 'Primes liees au capital social', 1),
(105, 'Ecart d evaluation', 1),
(106, 'Reserves', 1),
(107, 'Ecart d equivalence', 1),
(108, 'Compte de l exploitant', 1),
(109, 'Actionnaires, capital souscrit non appele', 1),
-- Report a nouveau
(110, 'Report a nouveau solde crediteur', 1),
(119, 'Report a nouveau solde debiteur', 1),
-- Resultat de l exercice
(120, 'Resultat de l exercice (benefice)', 1),
(129, 'Resultat de l exercice (perte)', 1),
-- Produits et charges differes - hors cycle d exploitation
(131, 'Subventions d equipement', 1),
(132, 'Autres subventions d investissement', 1),
(133, 'Impots differes actif', 1),
(134, 'Impots differes passif', 1),
(138, 'Autres produits et charges differes', 1),
-- Provisions pour charges - passifs non courants
(153, 'Provisions pour pensions et obligations similaires', 1),
(155, 'Provisions pour impots', 1),
(156, 'Provisions pour renouvellement des immobilisations', 1),
(158, 'Autres provisions pour charges - passifs non courants', 1),
-- Emprunts et dettes assimiles
(161, 'Emprunts obligataires convertibles', 1),
(163, 'Autres emprunts obligataires', 1),
(164, 'Emprunts aupras des etablissements de credit', 1),
(165, 'Depots et cautionnements reçus', 1),
(167, 'Dettes sur contrat de location-financement', 1),
(168, 'Autres emprunts et dettes assimiles', 1),
(169, 'Primes de remboursement des obligations', 1),
-- Dettes rattachees a des participations
(171, 'Dettes rattachees a des participations groupe', 1),
(172, 'Dettes rattachees a des participations hors groupe', 1),
(173, 'Dettes rattachees a des societes en participation', 1),
(178, 'Autres dettes rattachees a des participations', 1),
-- Comptes de liaison des etablissements et societes en participation
(181, 'Comptes de liaison entre etablissements', 1),
(188, 'Comptes de liaison entre societes en participation', 1),

-- Immobilisations incorporelles
(203, 'Frais de developpement immobilisables', 2),
(204, 'Logiciels informatiques et assimiles', 2),
(205, 'Concessions et droits similaires, brevets, licences, marques', 2),
(207, 'Fonds commercial', 2),
(208, 'Autres immobilisations incorporelles', 2),
-- Immobilisations corporelles
(211, 'Terrains', 2),
(212, 'Agencements et amenagements de terrain', 2),
(213, 'Constructions', 2),
(215, 'Installations techniques', 2),
(218, 'Autres immobilisations corporelles', 2),
-- Immobilisations mises en concession
(221, 'Terrains en concession', 2),
(222, 'Agencements et amenagements de terrain en concession', 2),
(223, 'Constructions en concession', 2),
(225, 'Installations techniques en concession', 2),
(228, 'Autres immobilisations corporelles en concession', 2),
(229, 'Droits du concedant', 2),
-- Immobilisations en cours
(232, 'Immobilisations corporelles en cours', 2),
(237, 'Immobilisations incorporelles en cours', 2),
(238, 'Avances et acomptes verses sur commandes d immobilisations', 2),
-- Participations et creances rattachees a des participations
(261, 'Titres de participation', 2),
(262, 'Autres formes de participations', 2),
(265, 'Titres de participation evalues par equivalence', 2),
(266, 'Creances rattachees a des participations groupe', 2),
(267, 'Creances rattachees a des participations hors groupe', 2),
(268, 'Creances rattachees a des societes en participation', 2),
(269, 'Versements restant a effectuer sur titres de participation non liberes', 2),
-- Autres immobilisations financiares
(271, 'Titres immobilises autres que les titres immobilises de l activite de portefeuille', 2),
(272, 'Titres representatifs de droit de creance (obligations, bons)', 2),
(273, 'Titres immobilises de l activite de portefeuille', 2),
(274, 'Prets', 2),
(275, 'Depots et cautionnements verses', 2),
(276, 'Autres creances immobilisees', 2),
(277, 'Actions propres (ou parts propres)', 2),
(279, 'Versements restant a effectuer sur titres immobilises non liberes', 2),
-- Amortissement des immobilisations
(280, 'Amortissement des immobilisations incorporelles', 2),
(281, 'Amortissement des immobilisations corporelles', 2),
(282, 'Amortissement des immobilisations mises en concession', 2),
-- Pertes de valeur sur immobilisations
(290, 'Perte de valeur sur immobilisations incorporelles', 2),
(291, 'Perte de valeur sur immobilisations corporelles', 2),
(292, 'Depreciation sur immobilisations mises en concession', 2),
(293, 'Perte de valeur sur immobilisations en cours', 2),
(296, 'Perte de valeur sur participations et creances rattachees a participations', 2),
(297, 'Perte de valeur sur autres immobilisations financiares', 2),

-- Classe 3 - Comptes de stocks et en-cours
-- Matiares premiares et fournitures
(31, 'Matiares premiares et fournitures', 3),
-- Autres approvisionnements
(321, 'Matiares consommables', 3),
(322, 'Fournitures consommables', 3),
(326, 'Emballages', 3),
-- En cours de production de biens
(331, 'Produits en cours', 3),
(335, 'Travaux en cours', 3),
-- En cours de production de services
(341, 'Etudes en cours', 3),
(345, 'Prestations de service en cours', 3),
-- Stocks de produits
(351, 'Produits intermediaires', 3),
(355, 'Produits finis', 3),
(358, 'Produits residuels ou matiares de recuperation (dechets, rebuts)', 3),
-- Stocks de marchandises
(37, 'Stocks de marchandises', 3),
-- Stocks a l'exterieur
(38, 'Stocks a l exterieur (en cours de route, en depot ou en consignation)', 3),
-- Pertes de valeur sur stocks et en cours
(391, 'Pertes de valeur Matiares premiares et fournitures', 3),
(392, 'Pertes de valeur Autres approvisionnements', 3),
(393, 'Pertes de valeur En cours de production de biens', 3),
(394, 'Pertes de valeur En cours de production de services', 3),
(395, 'Pertes de valeur Stocks de produits', 3),
(397, 'Pertes de valeur Stocks de marchandise', 3),

-- Classe 4 - Comptes de tiers
-- Fournisseurs et comptes rattaches
(40, 'Fournisseurs et comptes rattaches', 4),
(401, 'Fournisseurs de biens et services', 4),
(403, 'Fournisseurs effets a payer', 4),
(404, 'Fournisseurs d immobilisations', 4),
(405, 'Fournisseurs d immobilisations effets a payer', 4),
(408, 'Fournisseurs factures non parvenues', 4),
(409, 'Fournisseurs debiteurs : avances et acomptes, RRR a obtenir, autres creances', 4),
-- Clients et comptes rattaches
(41, 'Clients et comptes rattaches', 4),
(411, 'Clients', 4),
(413, 'Clients effets a recevoir', 4),
(416, 'Clients douteux', 4),
(417, 'Creances sur travaux non encore facturables', 4),
(418, 'Clients - produits non encore factures', 4),
(419, 'Clients crediteurs', 4),
-- Personnel et comptes rattaches
(42, 'Personnel et comptes rattaches', 4),
(421, 'Personnel, remunerations dues', 4),
(422, 'Fonds sociaux - œuvres sociales', 4),
(425, 'Personnel, avances et acomptes accordes', 4),
(426, 'Personnel, depots reçus', 4),
(427, 'Personnel, oppositions', 4),
(428, 'Personnel, charges a payer et produits a recevoir', 4),
-- Organismes sociaux et comptes rattaches
(43, 'Organismes sociaux et comptes rattaches', 4),
(431, 'Organismes sociaux A', 4),
(432, 'Organismes sociaux B', 4),
(438, 'Organismes sociaux, charges a payer', 4),
-- etat, collectivites publiques, organismes internationaux
(44, 'etat, collectivites publiques, organismes internationaux', 4),
(441, 'etat, subventions a recevoir', 4),
(442, 'etat, impots et taxes recouvrables sur des tiers', 4),
(443, 'Operations particuliares avec l etat et autres organismes publiques', 4),
(444, 'etat, impots sur les resultats', 4),
(445, 'etat, taxes sur le chiffre d affaires', 4),
(447, 'Autres impots, taxes et versements assimiles', 4),
(448, 'etat, charges a payer et produits a recevoir', 4),
-- Groupe et Associes
(45, 'Groupe et Associes', 4),
(451, 'Operations Groupe', 4),
(455, 'Associes - comptes courants', 4),
(456, 'Associes, operations sur le capital', 4),
(457, 'Associes, dividendes a payer', 4),
(458, 'Associes, operations faites en commun ou en groupement', 4),
-- Debiteurs divers et crediteurs divers
(46, 'Debiteurs divers et crediteurs divers', 4),
(462, 'Creances sur cessions d immobilisations', 4),
(464, 'Dettes sur acquisitions de valeurs mobiliares de placement', 4),
(465, 'Creances sur cessions de valeurs mobiliares de placement', 4),
(467, 'Autres comptes debiteurs ou crediteurs', 4),
(468, 'Divers charges a payer ou produits a recevoir', 4),
-- Comptes transitoires ou d attente
(47, 'Comptes transitoires ou d attente', 4),
-- Charges ou produits constates d avance et provisions
(48, 'Charges ou produits constates d avance et provisions', 4),
(481, 'Provisions - passifs courants', 4),
(486, 'Charges constatees d avance', 4),
(487, 'Produits constates d avance', 4),
-- Pertes de valeur sur comptes de tiers
(49, 'Pertes de valeur sur comptes de tiers', 4),
(491, 'Pertes de valeur sur comptes de clients', 4),
(495, 'Pertes de valeur sur comptes du groupe et des associes', 4),
(496, 'Pertes de valeur sur comptes de debiteurs divers', 4),

-- Classe 5 - Comptes financiers
-- Valeurs mobiliares de placement
(50, 'Valeurs mobiliares de placement', 5),
(501, 'Part dans des entreprises liees', 5),
(503, 'Actions', 5),
(504, 'Autres titres conferant un droit de propriete', 5),
(505, 'Obligations et bons emis par la societe et rachetes par elle', 5),
(506, 'Obligations', 5),
(507, 'Bons du tresor et bons de caisse a court terme', 5),
(508, 'Autres valeurs mobiliares de placement et creances assimiles', 5),
(509, 'Versements restant a effectuer sur VMP non liberees', 5),
-- Banques, etablissements financiers et assimiles
(51, 'Banques, etablissements financiers et assimiles', 5),
(511, 'Valeurs a l encaissement', 5),
(512, 'Banques comptes courants', 5),
(515, 'Caisse du Tresor Public et etablissements publics', 5),
(517, 'Autres organismes financiers', 5),
(518, 'Interets courus', 5),
(519, 'Concours bancaires courants', 5),
-- Instruments de tresorerie
(52, 'Instruments de tresorerie', 5),
-- Caisse
(53, 'Caisse', 5),
-- Regies d avances et accreditifs
(54, 'Regies d avances et accreditifs', 5),
-- Comptes disponibles
(55, 'Compte disponible', 5),
(56, 'Compte disponible', 5),
(57, 'Compte disponible', 5),
-- Virements internes
(58, 'Virements internes', 5),
(581, 'Virements de fonds', 5),
(588, 'Autres virements internes', 5),
-- Pertes de valeur sur comptes financiers
(59, 'Pertes de valeur sur comptes financiers', 5),
(591, 'Pertes de valeur sur valeurs en banque et Ets financiers', 5),
(594, 'Pertes de valeur sur regies d avances et accreditifs', 5),

-- Classe 6 - Comptes de charge (imputation par nature)

-- Achats consommes
(60, 'Achats consommes', 6),
(601, 'Matiares premiares', 6),
(602, 'Autres approvisionnements', 6),
(603, 'Variations des stocks', 6),
(604, 'Achats d etudes et de prestations de service', 6),
(605, 'Achats de materiels, equipements et travaux', 6),
(606, 'Achats non stockes de matiares et fournitures', 6),
(607, 'Achats de marchandises', 6),
(608, 'Frais accessoires d achat', 6),
(609, 'Rabais, remises, ristournes obtenus sur achats', 6),

-- Services exterieurs
(61, 'Services exterieurs', 6),
(611, 'Sous-traitance generale', 6),
(613, 'Locations', 6),
(614, 'Charges locatives et charges de copropriete', 6),
(615, 'Entretien, reparations et maintenance', 6),
(616, 'Primes d assurances', 6),
(617, 'Etudes et recherches', 6),
(618, 'Documentation et divers', 6),
(619, 'Rabais, remises, ristournes obtenus sur services exterieurs', 6),

-- Autres services exterieurs
(62, 'Autres services exterieurs', 6),
(621, 'Personnel exterieur a l entreprise', 6),
(622, 'Remunerations d intermediaires et honoraires', 6),
(623, 'Publicite, publication, relations publiques', 6),
(624, 'Transports de biens et transport collectif du personnel', 6),
(625, 'Deplacements, missions et receptions', 6),
(626, 'Frais postaux et de telecommunications', 6),
(627, 'Services bancaires et assimiles', 6),
(628, 'Cotisations et divers', 6),
(629, 'Rabais, remises, ristournes obtenus sur autres services exterieurs', 6),

-- Impots, taxes et versements assimiles
(63, 'Impots, taxes et versements assimiles', 6),
(631, 'Impots, taxes et versements assimiles sur remunerations', 6),
(635, 'Autres impots et taxes', 6),

-- Charges de personnel
(64, 'Charges de personnel', 6),
(641, 'Remunerations du personnel', 6),
(644, 'Remunerations des dirigeants', 6),
(645, 'Cotisations aux organismes sociaux', 6),
(646, 'Charges sociales sur remunerations des dirigeants', 6),
(647, 'Autres charges sociales', 6),
(648, 'Autres charges de personnel', 6),

-- Autres charges des activites ordinaires
(65, 'Autres charges des activites ordinaires', 6),
(651, 'Redevances pour concessions, brevets, licences, logiciels et valeurs similaires', 6),
(652, 'Moins-values sur cessions d actifs non courants', 6),
(653, 'Jetons de presence', 6),
(654, 'Pertes sur creances irrecouvrables', 6),
(655, 'Quote-part de resultat sur operations faites en commun', 6),
(656, 'Amendes et penalites, subventions accordees, dons et liberalites', 6),
(657, 'Charges exceptionnelles de gestion courante', 6),
(658, 'Autres charges de gestion courante', 6),

-- Charges financiares
(66, 'Charges financiares', 6),
(661, 'Charges d interets', 6),
(664, 'Pertes sur creances liees a des participations', 6),
(665, 'Moins-values sur titres de placement', 6),
(666, 'Pertes de change', 6),
(667, 'Moins-values sur instruments financiers et assimiles', 6),
(668, 'Autres charges financiares', 6),

-- elements extraordinaires (charges)
(67, 'elements extraordinaires (charges)', 6),

-- Dotations aux amortissements, provisions, pertes de valeur
(68, 'Dotations aux amortissements, provisions, pertes de valeur', 6),
(681, 'Dotations - actifs non courants', 6),
(685, 'Dotations - actifs courants', 6),

-- Impots sur les benefices
(69, 'Impots sur les benefices', 6),
(692, 'Imposition differee actif', 6),
(693, 'Imposition differee passif', 6),
(695, 'Impots sur les benefices bases sur le resultat des activites ordinaires', 6),
(698, 'Autres impots sur les resultats', 6),

-- Classe 7 - Comptes de produits

-- Ventes de produits fabriques, marchandises, prestations
(70, 'Ventes de produits fabriques, marchandises, prestations', 7),
(701, 'Ventes de produits finis', 7),
(702, 'Ventes de produits intermediaires', 7),
(703, 'Ventes de produits residuels', 7),
(704, 'Vente de travaux', 7),
(705, 'Vente d etudes', 7),
(706, 'Vente de prestations de service', 7),
(707, 'Ventes de marchandises', 7),
(708, 'Produits des activites annexes', 7),
(709, 'Rabais, remises et ristournes accordes', 7),

-- Production stockee (ou destockage)
(71, 'Production stockee (ou destockage)', 7),
(713, 'Variation de stocks d en-cours', 7),
(714, 'Variation de stocks de produits', 7),

-- Production immobilisee
(72, 'Production immobilisee', 7),
(721, 'Production immobilisee d actif incorporel', 7),
(722, 'Production immobilisee d actif corporel', 7),

-- Subventions d'exploitation
(74, 'Subventions d exploitation', 7),
(741, 'Subvention d equilibre', 7),
(748, 'Autres subventions d exploitation', 7),

-- Autres produits operationnels
(75, 'Autres produits operationnels', 7),
(751, 'Redevances pour concessions, brevets, licences, logiciels et valeurs similaires', 7),
(752, 'Plus-values sur cessions d actifs non courants', 7),
(753, 'Jetons de presence et remunerations d administrateurs ou de gerant', 7),
(754, 'Quotes-parts de subventions d investissement virees au resultat de l exercice', 7),
(755, 'Quote-part de resultat sur operations faites en commun', 7),
(756, 'Liberalites perçues, rentrees sur creances amorties', 7),
(757, 'Produits exceptionnels sur operations de gestion', 7),
(758, 'Autres produits de gestion courante', 7),

-- Produits financiers
(76, 'Produits financiers', 7),
(761, 'Produits de participations', 7),
(762, 'Produits des autres immobilisations financiares', 7),
(763, 'Revenus des autres creances', 7),
(764, 'Revenus et plus-values des valeurs mobiliares de placement', 7),
(766, 'Gains de change', 7),
(767, 'Produits nets sur cessions de valeurs mobiliares de placement', 7),
(768, 'Autres produits financiers', 7),

-- elements extraordinaires (produits)
(77, 'elements extraordinaires (produits)', 7),

-- Reprises sur provisions et pertes de valeur
(78, 'Reprises sur provisions et pertes de valeur', 7),
(781, 'Reprise d exploitation - actifs non courants', 7),
(785, 'Reprise d exploitation - actifs courants', 7),
(786, 'Reprises financiares', 7);

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



-- III. Valeur ajoutee d exploitation
CREATE VIEW vue_valeur_ajoutee AS
SELECT 
    (production.production_exercice - consommation.consommation_exercice) as valeur_ajoutee
FROM 
    vue_production_exercice production,
    vue_consommation_exercice consommation;


-- IV. EBE (Excedent brut d exploitation)
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



