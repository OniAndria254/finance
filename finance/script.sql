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