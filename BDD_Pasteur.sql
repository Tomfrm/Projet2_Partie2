-- ===========================================
--   CREATION BASE DE DONNEES
-- ===========================================
CREATE DATABASE IF NOT EXISTS cliniquePasteur;
USE cliniquePasteur;

-- ===========================================
--   TABLES
-- ===========================================

DROP TABLE IF EXISTS Services;
CREATE TABLE Services (
    id INT AUTO_INCREMENT,
    libelleServ VARCHAR(100),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Specialites;
CREATE TABLE Specialites (
    id INT AUTO_INCREMENT,
    libelleSpec VARCHAR(100),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Roles;
CREATE TABLE Roles (
    id INT AUTO_INCREMENT,
    libelleRole VARCHAR(100),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Stades;
CREATE TABLE Stades (
    id INT AUTO_INCREMENT,
    nomStade VARCHAR(100),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Organes;
CREATE TABLE Organes (
    id INT AUTO_INCREMENT,
    nomOrgane VARCHAR(100),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Maladies;
CREATE TABLE Maladies (
    id INT AUTO_INCREMENT,
    nomMaladie VARCHAR(100),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Organismes;
CREATE TABLE Organismes (
    id INT AUTO_INCREMENT,
    nomOrg VARCHAR(150),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Protocole;
CREATE TABLE Protocole (
    id INT AUTO_INCREMENT,
    libelleProtocole VARCHAR(150),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS EtatInclusion;
CREATE TABLE EtatInclusion (
    id INT AUTO_INCREMENT,
    libelleEtat VARCHAR(100),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Themes;
CREATE TABLE Themes (
    id INT AUTO_INCREMENT,
    libelleTheme VARCHAR(150),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS QuestionSecrete;
CREATE TABLE QuestionSecrète (
    id INT AUTO_INCREMENT,
    libelleQuestion VARCHAR(150),
    libelleReponse VARCHAR(150),
    idCompte INT,
    PRIMARY KEY (id),
    FOREIGN KEY (idCompte) REFERENCES Patients(id),
)

-- ===========================================
--   TABLE QUESTIONNAIRE
-- ===========================================

DROP TABLE IF EXISTS Questionnaire;
CREATE TABLE Questionnaire (
    id INT AUTO_INCREMENT,
    libelleQuest VARCHAR(150),
    descQuest TEXT,
    PRIMARY KEY (id)
);

-- ===========================================
--   TABLE PERSONNELS + DERIVE CHIRURGIEN
-- ===========================================

DROP TABLE IF EXISTS Personnels;
CREATE TABLE Personnels (
    id INT AUTO_INCREMENT,
    nomPersonnel VARCHAR(100),
    prenomPersonnel VARCHAR(100),
    idService INT,
    idSpecialite INT,
    idRole INT,
    PRIMARY KEY (id),
    FOREIGN KEY (idService) REFERENCES Services(id),
    FOREIGN KEY (idSpecialite) REFERENCES Specialites(id),
    FOREIGN KEY (idRole) REFERENCES Roles(id)
);

DROP TABLE IF EXISTS Chirurgien;
CREATE TABLE Chirurgien (
    id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES Personnels(id)
);

-- ===========================================
--   TABLE PATIENTS
-- ===========================================
DROP TABLE IF EXISTS Patients;
CREATE TABLE Patients (
    id INT AUTO_INCREMENT,
    nomPat VARCHAR(100),
    prenomPat VARCHAR(100),
    dateNaisPat DATE,
    sexe CHAR(1),
    numDossierClinique VARCHAR(100),
    mailPat VARCHAR(150),
    mdpPat VARCHAR(255),
    PRIMARY KEY (id)
);

-- ===========================================
--   TABLE DETAIL MALADIE
-- ===========================================
DROP TABLE IF EXISTS DetailMaladie;
CREATE TABLE DetailMaladie (
    idPatient INT,
    idMaladie INT,
    dateDiag DATE,
    idStade INT,
    idOrgane INT,
    PRIMARY KEY (idPatient, idMaladie, dateDiag),
    FOREIGN KEY (idPatient) REFERENCES Patients(id),
    FOREIGN KEY (idMaladie) REFERENCES Maladies(id),
    FOREIGN KEY (idStade) REFERENCES Stades(id),
    FOREIGN KEY (idOrgane) REFERENCES Organes(id)
);

-- ===========================================
--   TABLE ETUDES
-- ===========================================
DROP TABLE IF EXISTS Etudes;
CREATE TABLE Etudes (
    id INT AUTO_INCREMENT,
    nomEtu VARCHAR(200),
    descEtude TEXT,
    dateDebEtu DATE,
    dateFinEtu DATE,
    idOrganisme INT,
    idProtocole INT,
    idQuestionnaire INT,
    idChirurgien INT,
    PRIMARY KEY (id),
    FOREIGN KEY (idOrganisme) REFERENCES Organismes(id),
    FOREIGN KEY (idProtocole) REFERENCES Protocole(id),
    FOREIGN KEY (idQuestionnaire) REFERENCES Questionnaire(id),
    FOREIGN KEY (idChirurgien) REFERENCES Chirurgien(id)
);

-- ===========================================
--   TABLE DETAIL ETUDE
-- ===========================================
DROP TABLE IF EXISTS DetailEtude;
CREATE TABLE DetailEtude (
    idPatient INT,
    idEtude INT,
    dateInclusion DATE,
    idEtatInclusion INT,
    PRIMARY KEY (idPatient, idEtude),
    FOREIGN KEY (idPatient) REFERENCES Patients(id),
    FOREIGN KEY (idEtude) REFERENCES Etudes(id),
    FOREIGN KEY (idEtatInclusion) REFERENCES EtatInclusion(id)
);

-- ===========================================
--   TABLE CONSULTATIONS
-- ===========================================
DROP TABLE IF EXISTS Consultations;
CREATE TABLE Consultations (
    idPatient INT,
    idEtude INT,
    numVisite INT,
    dateConsultation DATE,
    idChirurgien INT,
    PRIMARY KEY (idPatient, idEtude, numVisite),
    FOREIGN KEY (idChirurgien) REFERENCES Chirurgien(id)
);

-- ===========================================
--   TABLE REPONSES (entête)
-- ===========================================
DROP TABLE IF EXISTS Reponses;
CREATE TABLE Reponses (
    idPatient INT,
    idEtude INT,
    numRep INT,
    dateRep DATE,
    PRIMARY KEY (idPatient, idEtude, numRep),
    FOREIGN KEY (idPatient, idEtude) REFERENCES DetailEtude(idPatient, idEtude)
);

-- ===========================================
--   TABLE QUESTIONS
-- ===========================================
DROP TABLE IF EXISTS Questions;
CREATE TABLE Questions (
    idTheme INT,
    numQuest INT,
    libelleQuestion TEXT,
    PRIMARY KEY (idTheme, numQuest),
    FOREIGN KEY (idTheme) REFERENCES Themes(id)
);

-- ===========================================
--   TABLE DETAIL THEME
-- ===========================================
DROP TABLE IF EXISTS DetailTheme;
CREATE TABLE DetailTheme (
    idQuestionnaire INT,
    idTheme INT,
    PRIMARY KEY (idQuestionnaire, idTheme),
    FOREIGN KEY (idQuestionnaire) REFERENCES Questionnaire(id),
    FOREIGN KEY (idTheme) REFERENCES Themes(id)
);

-- ===========================================
--   TABLE DETAIL REPONSES
-- ===========================================
DROP TABLE IF EXISTS DetailReponses;
CREATE TABLE DetailReponses (
    id INT AUTO_INCREMENT,
    idPatient INT,
    idEtude INT,
    numRep INT,
    idTheme INT,
    numQuest INT,
    valRep TEXT,
    PRIMARY KEY (id),
    FOREIGN KEY (idPatient, idEtude, numRep) 
        REFERENCES Reponses(idPatient, idEtude, numRep),
    FOREIGN KEY (idTheme, numQuest) 
        REFERENCES Questions(idTheme, numQuest),
    UNIQUE (idPatient, idEtude, numRep, idTheme, numQuest)
);