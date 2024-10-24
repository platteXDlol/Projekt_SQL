CREATE DATABASE Projekt;
GO

USE Projekt;


--Create Table--



-- Wohnort table
CREATE TABLE Wohnort (
    OrtID INT IDENTITY(1,1) NOT NULL,
    PLZ INT,
    ORT NVARCHAR(20),
    CONSTRAINT PK_OrtID PRIMARY KEY (OrtID)
);

-- Studenten table (references Wohnort)
CREATE TABLE Studenten (
    Matrikelnummer INT IDENTITY(1,1) NOT NULL,
    Vorname NVARCHAR(20) NOT NULL,
    Nachname NVARCHAR(20) NOT NULL,
    Studienbeginn DATE NOT NULL,
    Wohnort INT NOT NULL, 
    CONSTRAINT PK_Matrikelnummer PRIMARY KEY (Matrikelnummer),
    CONSTRAINT FK_Wohnort FOREIGN KEY (Wohnort) REFERENCES Wohnort(OrtID)
);

-- Assistenten table (must be created before Professor, since Professor references it)
CREATE TABLE Assistenten (
    AssistentenID INT IDENTITY(1,1) NOT NULL,
    Vorname NVARCHAR(20) NOT NULL,
    Nachname NVARCHAR(20) NOT NULL,
    Geburtstag DATE,
    CONSTRAINT PK_AssistentenID PRIMARY KEY (AssistentenID)
);

-- Professor table (references Assistenten and is created after Assistenten)
CREATE TABLE Professor (
    ProfID INT IDENTITY(1,1) NOT NULL,
    Vorname NVARCHAR(20) NOT NULL,
    Nachname NVARCHAR(20) NOT NULL,
    Geburtstag DATE,
    AssistentenID INT NOT NULL, -- Reference to Assistenten
    CONSTRAINT PK_ProfID PRIMARY KEY (ProfID),
    CONSTRAINT FK_AssistentenID FOREIGN KEY (AssistentenID) REFERENCES Assistenten(AssistentenID)
);

-- Hoersaal table
CREATE TABLE Hoersaal (
    HoersaalNr INT IDENTITY(1,1) NOT NULL,
    ProfID INT NOT NULL,
    CONSTRAINT PK_HoersaalNr PRIMARY KEY (HoersaalNr),
    CONSTRAINT FK_ProfID FOREIGN KEY (ProfID) REFERENCES Professor(ProfID)
);

-- Pruefung table
CREATE TABLE Pruefung (
    PruefungID INT IDENTITY(1,1) NOT NULL,
    Note DECIMAL NOT NULL,
    Termin SMALLDATETIME NOT NULL,
    CONSTRAINT PK_Pruefung PRIMARY KEY (PruefungID)
);

-- Vorlesung table (references Professor, Pruefung, Hoersaal)
CREATE TABLE Vorlesung (
    Bezeichnung NVARCHAR(20) NOT NULL,
    VorlesungNr INT IDENTITY(1,1) NOT NULL,
    Voraussetzung INT,
    ProfID INT NOT NULL,
    PruefungID INT NOT NULL,
    HoersaalNr INT NOT NULL,
    CONSTRAINT PK_VorlesungNr PRIMARY KEY (VorlesungNr),
    CONSTRAINT FK_Voraussetzung FOREIGN KEY (Voraussetzung) REFERENCES Vorlesung(VorlesungNr),
    CONSTRAINT FK_Professor FOREIGN KEY (ProfID) REFERENCES Professor(ProfID),
    CONSTRAINT FK_Pruefung FOREIGN KEY (PruefungID) REFERENCES Pruefung(PruefungID),
    CONSTRAINT FK_Hoersaal FOREIGN KEY (HoersaalNr) REFERENCES Hoersaal(HoersaalNr)
);

-- Linking table for Studenten and Vorlesung (many-to-many relationship)
CREATE TABLE Studenten_Vorlesung (
    Matrikelnummer INT NOT NULL,
    Vorlesung INT NOT NULL,
    CONSTRAINT FK_Studenten FOREIGN KEY (Matrikelnummer) REFERENCES Studenten(Matrikelnummer),
    CONSTRAINT FK_Vorlesung FOREIGN KEY (Vorlesung) REFERENCES Vorlesung(VorlesungNr)
);

-- Linking table for Studenten and Pruefung (many-to-many relationship)
CREATE TABLE Studenten_Pruefung (
    PruefungID INT NOT NULL,
    Matrikelnummer INT NOT NULL,
    CONSTRAINT FK_Studenten_StudentenPruefung FOREIGN KEY (Matrikelnummer) REFERENCES Studenten(Matrikelnummer),
    CONSTRAINT FK_Pruefung_StudentenPruefung FOREIGN KEY (PruefungID) REFERENCES Pruefung(PruefungID)
);

ALTER TABLE Assistenten
ADD ProfID INT NULL;

ALTER TABLE Assistenten
ADD CONSTRAINT FK_ProfID_Assistent FOREIGN KEY (ProfID) REFERENCES Professor(ProfID);


--All table createt--
--..................................................Everything functions.........................................................--
--Add things in table--

