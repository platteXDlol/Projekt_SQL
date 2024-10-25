create database UniDatenbank
go

use UniDatenbank

CREATE TABLE Professoren(
	PersNr int IDENTITY(1,1)  PRIMARY KEY,
	Vorname varchar(30) NOT NULL,
	Nachname varchar(30) NOT NULL,
	Raum int NOT NULL UNIQUE,
	Geburtsdatum datetime NOT NULL
)

CREATE TABLE Assistenten(
	PersNr int IDENTITY(1,1) PRIMARY KEY,
	Vorname varchar(30) NOT NULL,
	Nachname varchar(30) NOT NULL,
	Chef int NULL,
	Geburtsdatum smalldatetime NULL,
    CONSTRAINT fk_Assistenten_Professoren FOREIGN KEY(Chef) REFERENCES Professoren (PersNr)
)

CREATE TABLE Studenten(
	StudNr int IDENTITY(1,1) PRIMARY KEY,
	MatrNr varchar(30) NOT NULL UNIQUE,
	Vorname varchar(30) NOT NULL,
	Nachname varchar(30) NOT NULL,
	Studienbeginn smalldatetime NOT NULL,
	Wohnort varchar(50) NULL
)

CREATE TABLE Vorlesungen(
	VorlNr int IDENTITY(1,1) PRIMARY KEY,
	Titel varchar(30) NULL,
	GelesenVon int NULL,
    CONSTRAINT fk_Vorlesungen_Professoren FOREIGN KEY(GelesenVon) REFERENCES Professoren (PersNr)
)

CREATE TABLE dbo.VorlesungBesuch(
	VorlNr int NOT NULL,
	StudNr int NOT NULL,
    CONSTRAINT pk_VorlesungBuch PRIMARY KEY (VorlNr, StudNr), 
    CONSTRAINT fk_VorlesungBesuch_Studenten FOREIGN KEY(StudNr) REFERENCES Studenten (StudNr) ON DELETE CASCADE,
    CONSTRAINT fk_VorlesungBesuch_Vorlesungen FOREIGN KEY(VorlNr) REFERENCES Vorlesungen (VorlNr)
) 


CREATE TABLE Voraussetzung(
	Vorgaenger int NOT NULL,
	Nachfolger int NOT NULL,
    CONSTRAINT pk_Voraussetzung PRIMARY KEY (Vorgaenger, Nachfolger), 
    CONSTRAINT fk_Voraussetzung_Vorlesungen FOREIGN KEY(Vorgaenger) REFERENCES Vorlesungen (VorlNr),
    CONSTRAINT fk_Voraussetzung_Vorlesungen_2 FOREIGN KEY(Nachfolger) REFERENCES Vorlesungen (VorlNr)
)

CREATE TABLE Pruefungen(
    PruefungID int IDENTITY(1,1) PRIMARY KEY,
	VorlNr int NOT NULL,
	PersNr int NULL,
	Note decimal(2, 1) NULL,
	Termin smalldatetime NULL,
	StudNr int NOT NULL,
    CONSTRAINT fk_Pruefungen_Professoren FOREIGN KEY(PersNr) REFERENCES Professoren (PersNr), 
    CONSTRAINT fk_Pruefungen_Studenten FOREIGN KEY(StudNr) REFERENCES Studenten (StudNr) ON DELETE CASCADE, 
    CONSTRAINT fk_Pruefungen_Vorlesungen FOREIGN KEY(VorlNr) REFERENCES Vorlesungen (VorlNr)
)



/* Professoren */
INSERT Professoren (Vorname, Nachname, Raum, Geburtsdatum) VALUES (N'Albert', N'Einstein', 14, CAST(N'1879-03-14T00:00:00.000' AS DateTime))
INSERT Professoren (Vorname, Nachname, Raum, Geburtsdatum) VALUES (N'Marie', N'Curie', 12, CAST(N'1867-11-07T00:00:00.000' AS DateTime))
INSERT Professoren (Vorname, Nachname, Raum, Geburtsdatum) VALUES (N'Peter', N'Von Matt', 8, CAST(N'1937-05-20T00:00:00.000' AS DateTime))
INSERT Professoren (Vorname, Nachname, Raum, Geburtsdatum) VALUES (N'Nikola', N'Tesla', 13, CAST(N'1856-07-10T00:00:00.000' AS DateTime))
INSERT Professoren (Vorname, Nachname, Raum, Geburtsdatum) VALUES (N'Wilhelm Conrad', N'Röntgen', 10, CAST(N'1845-03-27T00:00:00.000' AS DateTime))
INSERT Professoren (Vorname, Nachname, Raum, Geburtsdatum) VALUES (N'Jean-Paul', N'Sartre', 1, CAST(N'1905-06-21T00:00:00.000' AS DateTime))
INSERT Professoren (Vorname, Nachname, Raum, Geburtsdatum) VALUES (N'Jacobus', N'van ''t Hoff', 3, CAST(N'1852-08-30T00:00:00.000' AS DateTime))

/* Assistenten */
INSERT Assistenten (Vorname, Nachname, Chef, Geburtsdatum) VALUES (N'Lionel', N'Messi', NULL, CAST(N'1987-06-24T00:00:00' AS SmallDateTime))
INSERT Assistenten (Vorname, Nachname, Chef, Geburtsdatum) VALUES (N'Xherdan', N'Shaqiri', 4, CAST(N'1991-10-10T00:00:00' AS SmallDateTime))
INSERT Assistenten (Vorname, Nachname, Chef, Geburtsdatum) VALUES (N'Sami', N'Khedira', 3, CAST(N'1987-04-04T00:00:00' AS SmallDateTime))
INSERT Assistenten (Vorname, Nachname, Chef, Geburtsdatum) VALUES (N'Cristiano', N'Ronaldo', 3, CAST(N'1985-02-05T00:00:00' AS SmallDateTime))
INSERT Assistenten (Vorname, Nachname, Chef, Geburtsdatum) VALUES (N'Wayne', N'Rooney', NULL, CAST(N'1985-10-24T00:00:00' AS SmallDateTime))
INSERT Assistenten (Vorname, Nachname, Chef, Geburtsdatum) VALUES (N'Arjen', N'Robben', 7, CAST(N'1984-01-23T00:00:00' AS SmallDateTime))
INSERT Assistenten (Vorname, Nachname, Chef, Geburtsdatum) VALUES (N'Andrea', N'Pirlo', 1, CAST(N'1979-05-19T00:00:00' AS SmallDateTime))
INSERT Assistenten (Vorname, Nachname, Chef, Geburtsdatum) VALUES (N'Robert', N'Lewandowski', 3, CAST(N'1988-08-21T00:00:00' AS SmallDateTime))
INSERT Assistenten (Vorname, Nachname, Chef, Geburtsdatum) VALUES (N'Luis', N'Suàrez', 5, CAST(N'1987-01-24T00:00:00' AS SmallDateTime))
INSERT Assistenten (Vorname, Nachname, Chef, Geburtsdatum) VALUES (N'Alexis', N'Sanchez', 2, CAST(N'1988-12-19T00:00:00' AS SmallDateTime))

/* Studenten */
INSERT Studenten (MatrNr, Vorname, Nachname, Studienbeginn, Wohnort) VALUES (N'09-4845-0', N'Eliane', N'Burri', CAST(N'2019-10-01T00:00:00' AS SmallDateTime), N'Bern')
INSERT Studenten (MatrNr, Vorname, Nachname, Studienbeginn, Wohnort) VALUES (N'12-5776-4', N'Guido', N'Duss', CAST(N'2019-10-01T00:00:00' AS SmallDateTime), N'Solothurn')
INSERT Studenten (MatrNr, Vorname, Nachname, Studienbeginn, Wohnort) VALUES (N'09-7270-8', N'Gertrud', N'Zollinger', CAST(N'2019-10-01T00:00:00' AS SmallDateTime), N'Thun')
INSERT Studenten (MatrNr, Vorname, Nachname, Studienbeginn, Wohnort) VALUES (N'08-5694-8', N'Giorgio', N'Antonelli', CAST(N'2018-10-01T00:00:00' AS SmallDateTime), N'Sempach')
INSERT Studenten (MatrNr, Vorname, Nachname, Studienbeginn, Wohnort) VALUES (N'13-3963-7', N'Miguel', N'Sanchez', CAST(N'2019-10-01T00:00:00' AS SmallDateTime), N'')
INSERT Studenten (MatrNr, Vorname, Nachname, Studienbeginn, Wohnort) VALUES (N'09-6537-7', N'Zoran', N'Stefanovski', CAST(N'2019-10-01T00:00:00' AS SmallDateTime), N'Bern')
INSERT Studenten (MatrNr, Vorname, Nachname, Studienbeginn, Wohnort) VALUES (N'10-4336-3', N'Luis', N'Prieto', CAST(N'2019-10-01T00:00:00' AS SmallDateTime), N'Basel')
INSERT Studenten (MatrNr, Vorname, Nachname, Studienbeginn, Wohnort) VALUES (N'13-4372-1', N'Martin', N'Isler', CAST(N'2019-10-01T00:00:00' AS SmallDateTime), N'')
INSERT Studenten (MatrNr, Vorname, Nachname, Studienbeginn, Wohnort) VALUES (N'09-1079-4', N'Paolo', N'Di Lavello', CAST(N'2019-10-01T00:00:00' AS SmallDateTime), N'Baden')
INSERT Studenten (MatrNr, Vorname, Nachname, Studienbeginn, Wohnort) VALUES (N'10-5068-5', N'Rolf', N'Meier', CAST(N'2019-10-01T00:00:00' AS SmallDateTime), N'Wettingen')
INSERT Studenten (MatrNr, Vorname, Nachname, Studienbeginn, Wohnort) VALUES (N'09-9370-0', N'Marco', N'Maggi', CAST(N'2019-10-01T00:00:00' AS SmallDateTime), N'Unterlunkhofen')
INSERT Studenten (MatrNr, Vorname, Nachname, Studienbeginn, Wohnort) VALUES (N'09-0523-5', N'Heike', N'Kurmann', CAST(N'2019-10-01T00:00:00' AS SmallDateTime), N'Hochdorf')
INSERT Studenten (MatrNr, Vorname, Nachname, Studienbeginn, Wohnort) VALUES (N'09-9376-6', N'Lelzim', N'Krasniqi', CAST(N'2019-10-01T00:00:00' AS SmallDateTime), N'Courtedoux')
INSERT Studenten (MatrNr, Vorname, Nachname, Studienbeginn, Wohnort) VALUES (N'14-0556-8', N'Jean-Paul', N'Léchenne', CAST(N'2019-10-01T00:00:00' AS SmallDateTime), N'Solothurn')
INSERT Studenten (MatrNr, Vorname, Nachname, Studienbeginn, Wohnort) VALUES (N'09-0665-1', N'Roger', N'Détraz', CAST(N'2017-10-01T00:00:00' AS SmallDateTime), N'Lurtigen')
INSERT Studenten (MatrNr, Vorname, Nachname, Studienbeginn, Wohnort) VALUES (N'11-8456-6', N'Hans', N'Dubach', CAST(N'2018-10-01T00:00:00' AS SmallDateTime), N'Bern')
INSERT Studenten (MatrNr, Vorname, Nachname, Studienbeginn, Wohnort) VALUES (N'10-3201-8', N'Yvonne', N'Keller', CAST(N'2019-10-01T00:00:00' AS SmallDateTime), N'')
INSERT Studenten (MatrNr, Vorname, Nachname, Studienbeginn, Wohnort) VALUES (N'12-0948-3', N'Priska', N'Weber', CAST(N'2019-10-01T00:00:00' AS SmallDateTime), N'Riehen')
INSERT Studenten (MatrNr, Vorname, Nachname, Studienbeginn, Wohnort) VALUES (N'13-3225-2', N'Heidi', N'Dubuis', CAST(N'2019-10-01T00:00:00' AS SmallDateTime), N'Knutwil')
INSERT Studenten (MatrNr, Vorname, Nachname, Studienbeginn, Wohnort) VALUES (N'13-5660-2', N'Slobodan', N'Stojanovic', CAST(N'2019-10-01T00:00:00' AS SmallDateTime), N'Muttenz')
INSERT Studenten (MatrNr, Vorname, Nachname, Studienbeginn, Wohnort) VALUES (N'07-0633-6', N'Bruno', N'Zobrist', CAST(N'2018-10-01T00:00:00' AS SmallDateTime), N'Birr')
INSERT Studenten (MatrNr, Vorname, Nachname, Studienbeginn, Wohnort) VALUES (N'10-1471-6', N'Slobodanka', N'Babaja', CAST(N'2019-10-01T00:00:00' AS SmallDateTime), N'Olten')
INSERT Studenten (MatrNr, Vorname, Nachname, Studienbeginn, Wohnort) VALUES (N'10-2466-6', N'Roger', N'Gugler', CAST(N'2018-10-01T00:00:00' AS SmallDateTime), N'Burgdorf')
INSERT Studenten (MatrNr, Vorname, Nachname, Studienbeginn, Wohnort) VALUES (N'13-3704-2', N'Marian', N'Genkinger', CAST(N'2019-10-01T00:00:00' AS SmallDateTime), N'')
INSERT Studenten (MatrNr, Vorname, Nachname, Studienbeginn, Wohnort) VALUES (N'12-8867-9', N'Michele', N'Dell''Amore', CAST(N'2019-10-01T00:00:00' AS SmallDateTime), N'Langenthal')

/* Vorlesungen */
INSERT Vorlesungen (Titel, GelesenVon) VALUES (N'Ethik', 3)
INSERT Vorlesungen (Titel, GelesenVon) VALUES (N'Elektrotechnik', 4)
INSERT Vorlesungen (Titel, GelesenVon) VALUES (N'Sprachtheorie', 3)
INSERT Vorlesungen (Titel, GelesenVon) VALUES (N'Radiologie', 5)
INSERT Vorlesungen (Titel, GelesenVon) VALUES (N'Allgemeine Relativitätstheorie', 1)
INSERT Vorlesungen (Titel, GelesenVon) VALUES (N'Quantenphysik', 1)
INSERT Vorlesungen (Titel, GelesenVon) VALUES (N'Kinetik', 7)
INSERT Vorlesungen (Titel, GelesenVon) VALUES (N'Literaturgeschichte', 3)
INSERT Vorlesungen (Titel, GelesenVon) VALUES (N'Astrophysik', 1)
INSERT Vorlesungen (Titel, GelesenVon) VALUES (N'Biochemie', 7)
INSERT Vorlesungen (Titel, GelesenVon) VALUES (N'Physikalische Chemie', 2)

/* Vorgänger-Nachfolger */
INSERT Voraussetzung (Vorgaenger, Nachfolger) VALUES (2, 4)
INSERT Voraussetzung (Vorgaenger, Nachfolger) VALUES (4, 6)

/* VorlesungBesuch */
INSERT VorlesungBesuch (VorlNr, StudNr) VALUES (1, 5)
INSERT VorlesungBesuch (VorlNr, StudNr) VALUES (1, 24)
INSERT VorlesungBesuch (VorlNr, StudNr) VALUES (1, 25)
INSERT VorlesungBesuch (VorlNr, StudNr) VALUES (2, 1)
INSERT VorlesungBesuch (VorlNr, StudNr) VALUES (2, 2)
INSERT VorlesungBesuch (VorlNr, StudNr) VALUES (2, 20)
INSERT VorlesungBesuch (VorlNr, StudNr) VALUES (3, 5)
INSERT VorlesungBesuch (VorlNr, StudNr) VALUES (3, 24)
INSERT VorlesungBesuch (VorlNr, StudNr) VALUES (4, 1)
INSERT VorlesungBesuch (VorlNr, StudNr) VALUES (5, 14)
INSERT VorlesungBesuch (VorlNr, StudNr) VALUES (5, 20)
INSERT VorlesungBesuch (VorlNr, StudNr) VALUES (7, 8)
INSERT VorlesungBesuch (VorlNr, StudNr) VALUES (7, 15)
INSERT VorlesungBesuch (VorlNr, StudNr) VALUES (7, 17)
INSERT VorlesungBesuch (VorlNr, StudNr) VALUES (7, 20)
INSERT VorlesungBesuch (VorlNr, StudNr) VALUES (8, 4)
INSERT VorlesungBesuch (VorlNr, StudNr) VALUES (8, 5)
INSERT VorlesungBesuch (VorlNr, StudNr) VALUES (8, 11)
INSERT VorlesungBesuch (VorlNr, StudNr) VALUES (8, 24)
INSERT VorlesungBesuch (VorlNr, StudNr) VALUES (10, 3)
INSERT VorlesungBesuch (VorlNr, StudNr) VALUES (10, 9)
INSERT VorlesungBesuch (VorlNr, StudNr) VALUES (11, 21)

/* Pruefungen */
INSERT Pruefungen (VorlNr, PersNr, Note, Termin, StudNr) VALUES (1, 6, NULL, NULL, 25)
INSERT Pruefungen (VorlNr, PersNr, Note, Termin, StudNr) VALUES (2, 4, CAST(6.0 AS Decimal(2, 1)), CAST(N'2020-10-25T00:00:00' AS SmallDateTime), 1)
INSERT Pruefungen (VorlNr, PersNr, Note, Termin, StudNr) VALUES (2, 4, CAST(5.5 AS Decimal(2, 1)), CAST(N'2021-05-26T00:00:00' AS SmallDateTime), 2)
INSERT Pruefungen (VorlNr, PersNr, Note, Termin, StudNr) VALUES (3, 3, NULL, NULL, 5)
INSERT Pruefungen (VorlNr, PersNr, Note, Termin, StudNr) VALUES (3, 3, CAST(5.0 AS Decimal(2, 1)), CAST(N'2021-05-27T00:00:00' AS SmallDateTime), 24)
INSERT Pruefungen (VorlNr, PersNr, Note, Termin, StudNr) VALUES (4, 2, NULL, NULL, 1)
INSERT Pruefungen (VorlNr, PersNr, Note, Termin, StudNr) VALUES (5, 1, NULL, NULL, 14)
INSERT Pruefungen (VorlNr, PersNr, Note, Termin, StudNr) VALUES (7, 7, CAST(5.5 AS Decimal(2, 1)), CAST(N'2020-05-28T00:00:00' AS SmallDateTime), 15)
INSERT Pruefungen (VorlNr, PersNr, Note, Termin, StudNr) VALUES (7, 7, CAST(2.5 AS Decimal(2, 1)), CAST(N'2020-05-30T00:00:00' AS SmallDateTime), 17)
INSERT Pruefungen (VorlNr, PersNr, Note, Termin, StudNr) VALUES (7, 7, NULL, NULL, 20)
INSERT Pruefungen (VorlNr, PersNr, Note, Termin, StudNr) VALUES (8, 3, NULL, NULL, 4)
INSERT Pruefungen (VorlNr, PersNr, Note, Termin, StudNr) VALUES (8, 3, CAST(3.5 AS Decimal(2, 1)), CAST(N'2021-05-27T00:00:00' AS SmallDateTime), 5)
INSERT Pruefungen (VorlNr, PersNr, Note, Termin, StudNr) VALUES (8, 3, CAST(4.0 AS Decimal(2, 1)), CAST(N'2020-03-03T00:00:00' AS SmallDateTime), 11)
INSERT Pruefungen (VorlNr, PersNr, Note, Termin, StudNr) VALUES (8, 3, CAST(4.5 AS Decimal(2, 1)), CAST(N'2020-03-10T00:00:00' AS SmallDateTime), 24)
INSERT Pruefungen (VorlNr, PersNr, Note, Termin, StudNr) VALUES (10, 5, CAST(4.5 AS Decimal(2, 1)), CAST(N'2020-05-25T00:00:00' AS SmallDateTime), 3)

    
