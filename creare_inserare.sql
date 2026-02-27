--DEPARTAMENTE(id_departament#, nume) 
--DOCTORI(id_doctor#, nume, specializare, salariu, id_departament*) 
--ASISTENTE(id_asistenta#, nume, salariu, id_departament*) 
--ASISTENTE_DOCTORI(id_asistenta#, id_doctor#) 
--PACIENTI(id_pacient#, nume, data_nasterii) 
--BOLI(id_boala#, denumire, descriere) 
--PACIENTI_BOLI(id_pacient#, id_boala#) 
--TRATAMENTE(id_tratament#, descriere) 
--TRATAMENTE_BOLI(id_tratament#, id_boala#) 
--SPITALIZARI(id_spitalizare#, id_pacient*, id_doctor*, data_internare, data_externare, diagnostic) 
--MEDICAMENTE(id_medicament#, denumire, producator) 
--RETETE(id_tratament#, id_medicament#) 
--PRESCRIPTII(id_tratament#, id_doctor#)

DROP TABLE departamente;
DROP SEQUENCE departamente_seq;
-- departamente
CREATE TABLE departamente (
    id_departament NUMBER PRIMARY KEY,
    nume VARCHAR2(50),
    etaj NUMBER,
    email VARCHAR2(100)
);
CREATE SEQUENCE departamente_seq
START WITH 1 INCREMENT BY 1
NOCACHE
NOCYCLE;

-- creez un trigger care seteaza automat id_departament daca nu este setat
CREATE OR REPLACE TRIGGER trg_departamente_autoinsert
BEFORE INSERT ON departamente
FOR EACH ROW
BEGIN
  IF :NEW.id_departament IS NULL THEN
    :NEW.id_departament := departamente_seq.NEXTVAL;
  END IF;
END;
/

-- insert data into departamente 
INSERT ALL
    INTO departamente (nume, etaj, email) VALUES ('Cardiologie', 1, 'sectie-cardiologie@yahoo.com')
    INTO departamente (nume, etaj, email) VALUES ('Neurologie', 2, 'sectie-neurologie@yahoo.com')
    INTO departamente (nume, etaj, email) VALUES ('Oncologie', 3, 'sectie-oncologie@yahoo.com')
    INTO departamente (nume, etaj, email) VALUES ('Pediatrie', 4, 'sectie-pediatrie@yahoo.com')
    INTO departamente (nume, etaj, email) VALUES ('Chirurgie', 5, 'sectie-chirurgie@yahoo.com')
    INTO departamente (nume, etaj, email) VALUES ('Psihiatrie', 6, 'sectie-psihiatrie@yahoo.com')
    INTO departamente (nume, etaj, email) VALUES ('Dermatologie', 7, 'sectie-dermatologie@yahoo.com')
    INTO departamente (nume, etaj, email) VALUES ('Oftalmologie', 8, 'sectie-oftalmologie@yahoo.com')
    INTO departamente (nume, etaj, email) VALUES ('Ginecologie', 9, 'sectie-ginecologie@yahoo.com')
    INTO departamente (nume, etaj, email) VALUES ('Ortopedie', 10, 'sectie-ortopedie@yahoo.com')
SELECT * FROM dual;

COMMIT;

SELECT *
FROM departamente;

DROP TABLE doctori;
DROP SEQUENCE doctori_seq;
-- doctori
CREATE TABLE doctori (
    id_doctor NUMBER PRIMARY KEY,
    nume VARCHAR2(50),
    specializare VARCHAR2(50),
    salariu NUMBER,
    id_departament NUMBER,
    nr_telefon VARCHAR2(20),
    data_nasterii DATE,
    FOREIGN KEY (id_departament) REFERENCES departamente(id_departament)
);
CREATE SEQUENCE doctori_seq
START WITH 1 INCREMENT BY 1
NOCACHE
NOCYCLE;

-- creez un trigger care seteaza automat id_doctor daca nu este setat
CREATE OR REPLACE TRIGGER trg_doctori_autoinsert
BEFORE INSERT ON doctori
FOR EACH ROW
BEGIN
  IF :NEW.id_doctor IS NULL THEN
    :NEW.id_doctor := doctori_seq.NEXTVAL;
  END IF;
END;
/

-- insert data into doctori 
INSERT ALL 
    INTO doctori (nume, specializare, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Dr. Popescu', 'Cardiologie', 15000, 1, '+40713418896', TO_DATE('2005-02-15', 'YYYY-MM-DD'))
    INTO doctori (nume, specializare, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Dr. Vasile', 'Psihiatrie', 25000, 6, '+40799261732', TO_DATE('1980-12-01', 'YYYY-MM-DD'))
    INTO doctori (nume, specializare, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Dr. Ionescu', 'Neurologie', 20000, 2, '+40723619971', TO_DATE('1978-08-09', 'YYYY-MM-DD'))
    INTO doctori (nume, specializare, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Dr. Georgescu', 'Oncologie', 17000, 3, '+40784451623', TO_DATE('1969-05-11', 'YYYY-MM-DD'))
    INTO doctori (nume, specializare, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Dr. Vasilescu', 'Pediatrie', 19000, 4, '+40789261728', TO_DATE('1980-12-01', 'YYYY-MM-DD'))
    INTO doctori (nume, specializare, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Dr. Marinescu', 'Chirurgie', 30000, 5, '+40745192341', TO_DATE('1983-03-23', 'YYYY-MM-DD'))
    INTO doctori (nume, specializare, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Dr. Panainte', 'Dermatologie', 14000, 7, '+40745187294', TO_DATE('1987-01-21', 'YYYY-MM-DD'))
    INTO doctori (nume, specializare, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Dr. Butnaru', 'Ginecologie', 15500, 9, '+40718896662', TO_DATE('1988-06-01', 'YYYY-MM-DD'))
    INTO doctori (nume, specializare, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Dr. Soldan', 'Oftalmologie', 17500, 8, '+40723717034', TO_DATE('1975-12-25', 'YYYY-MM-DD'))
    INTO doctori (nume, specializare, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Dr. Enache', 'Ortopedie', 16000, 10, '+40788361924', TO_DATE('1975-07-19', 'YYYY-MM-DD'))
    INTO doctori (nume, specializare, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Dr. Stan', 'Cardiologie', 15000, 1, '+40772341023', TO_DATE('1974-02-15', 'YYYY-MM-DD'))
    INTO doctori (nume, specializare, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Dr. Oatu', 'Chirurgie', 26000, 5, '+40711439856', TO_DATE('1980-10-17', 'YYYY-MM-DD'))
    INTO doctori (nume, specializare, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Dr. Anton', 'Neurologie', 20000, 2, '+40711034789', TO_DATE('1970-11-27', 'YYYY-MM-DD'))
    INTO doctori (nume, specializare, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Dr. Dumitru', 'Chirurgie', 30000, 5, '+40754791372', TO_DATE('1972-05-13', 'YYYY-MM-DD'))
    INTO doctori (nume, specializare, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Dr. Dumitrescu', 'Chirurgie', 32000, 5, '+40734901385', TO_DATE('1974-08-10', 'YYYY-MM-DD'))
SELECT * FROM dual;

COMMIT;

SELECT *
FROM doctori;

DROP TABLE asistente;
DROP SEQUENCE asistente_seq;
-- asistente
CREATE TABLE asistente (
    id_asistenta NUMBER PRIMARY KEY,
    nume VARCHAR2(50),
    salariu NUMBER,
    id_departament NUMBER,
    nr_telefon VARCHAR2(20),
    data_nasterii DATE,
    FOREIGN KEY (id_departament) REFERENCES departamente(id_departament)
);
CREATE SEQUENCE asistente_seq
START WITH 1 INCREMENT BY 1
NOCACHE
NOCYCLE;

-- creez un trigger care seteaza automat id_asistenta daca nu este setat
CREATE OR REPLACE TRIGGER trg_asistente_autoinsert
BEFORE INSERT ON asistente
FOR EACH ROW
BEGIN
  IF :NEW.id_asistenta IS NULL THEN
    :NEW.id_asistenta := asistente_seq.NEXTVAL;
  END IF;
END;
/

-- insert data into asistente 
INSERT ALL 
    INTO asistente (nume, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Maria Popescu', 6000, 1, '+40788413671', TO_DATE('1974-08-11', 'YYYY-MM-DD'))
    INTO asistente (nume, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Cristina Pop', 6500, 2, '+40721541782', TO_DATE('1975-07-19', 'YYYY-MM-DD'))
    INTO asistente (nume, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Andreea Marin', 5500, 3, '+40725719623', TO_DATE('1976-03-24', 'YYYY-MM-DD'))
    INTO asistente (nume, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Ana Blandiana', 5430, 3, '+40756158924', TO_DATE('1973-02-12', 'YYYY-MM-DD'))
    INTO asistente (nume, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Miruna Ionescu', 6400, 4, '+40745189482', TO_DATE('1978-07-03', 'YYYY-MM-DD'))
    INTO asistente (nume, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Ioana Georgescu', 6200, 5, '+40732581934', TO_DATE('1975-12-16', 'YYYY-MM-DD'))
    INTO asistente (nume, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Ilinca Vasile', 5500, 6, '+40742615912', TO_DATE('1985-04-21', 'YYYY-MM-DD'))
    INTO asistente (nume, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Oana Simion', 5700, 7, '+40782964552', TO_DATE('1980-01-27', 'YYYY-MM-DD'))
    INTO asistente (nume, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Anca Stan', 5800, 8, '+40723661902', TO_DATE('1981-11-13', 'YYYY-MM-DD'))
    INTO asistente (nume, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Andreea Ionescu', 5970, 9, '+40711783492', TO_DATE('1974-05-07', 'YYYY-MM-DD'))
    INTO asistente (nume, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Georgiana Dumitru', 6700, 10, '+40756251892', TO_DATE('1970-01-10', 'YYYY-MM-DD'))
    INTO asistente (nume, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Isabela Anton', 6330, 3, '+40723641579', TO_DATE('1971-06-29', 'YYYY-MM-DD'))
    INTO asistente (nume, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Irina Antonescu', 6240, 3, '+40789004561', TO_DATE('1977-10-10', 'YYYY-MM-DD'))
    INTO asistente (nume, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Clara Dumitru', 6870, 4, '+40725516793', TO_DATE('1979-06-26', 'YYYY-MM-DD'))
    INTO asistente (nume, salariu, id_departament, nr_telefon, data_nasterii) VALUES ('Mara Enache', 6790, 7, '+40775023418', TO_DATE('1978-03-16', 'YYYY-MM-DD'))
SELECT * FROM dual;

COMMIT;

SELECT *
FROM asistente;

DROP TABLE asistente_doctori;
-- asistente_doctori(Relatie M:N)
CREATE TABLE asistente_doctori (
    id_asistenta NUMBER,
    id_doctor NUMBER,
    PRIMARY KEY (id_asistenta, id_doctor),
    FOREIGN KEY (id_asistenta) REFERENCES asistente(id_asistenta),
    FOREIGN KEY (id_doctor) REFERENCES doctori(id_doctor)
);

-- insert data into asistente_doctori 
INSERT ALL 
    INTO asistente_doctori (id_asistenta, id_doctor) VALUES (1, 1)
    INTO asistente_doctori (id_asistenta, id_doctor) VALUES (1, 7)
    INTO asistente_doctori (id_asistenta, id_doctor) VALUES (2, 8)
    INTO asistente_doctori (id_asistenta, id_doctor) VALUES (3, 5)
    INTO asistente_doctori (id_asistenta, id_doctor) VALUES (4, 3)
    INTO asistente_doctori (id_asistenta, id_doctor) VALUES (10, 2)
    INTO asistente_doctori (id_asistenta, id_doctor) VALUES (9, 8)
    INTO asistente_doctori (id_asistenta, id_doctor) VALUES (8, 14)
    INTO asistente_doctori (id_asistenta, id_doctor) VALUES (7, 13)
    INTO asistente_doctori (id_asistenta, id_doctor) VALUES (6, 12)
    INTO asistente_doctori (id_asistenta, id_doctor) VALUES (5, 11)
    INTO asistente_doctori (id_asistenta, id_doctor) VALUES (4, 10)
    INTO asistente_doctori (id_asistenta, id_doctor) VALUES (3, 1)
SELECT * FROM dual;

COMMIT;

SELECT *
FROM asistente_doctori;

DROP TABLE pacienti;
DROP SEQUENCE pacienti_seq;
-- pacienti
CREATE TABLE pacienti (
    id_pacient NUMBER PRIMARY KEY,
    nume VARCHAR2(50),
    data_nasterii DATE,
    nr_telefon VARCHAR2(20),
    gen VARCHAR2(10),
    grupa VARCHAR2(10)
);
CREATE SEQUENCE pacienti_seq
START WITH 1 INCREMENT BY 1
NOCACHE
NOCYCLE;

-- creez un trigger care seteaza automat id_pacient daca nu este setat
CREATE OR REPLACE TRIGGER trg_pacienti_autoinsert
BEFORE INSERT ON pacienti
FOR EACH ROW
BEGIN
  IF :NEW.id_pacient IS NULL THEN
    :NEW.id_pacient := pacienti_seq.NEXTVAL;
  END IF;
END;
/

-- insert data into pacienti 
INSERT ALL 
    INTO pacienti (nume, data_nasterii, nr_telefon, gen, grupa) VALUES ('Andrei Munteanu', TO_DATE('2005-02-15', 'YYYY-MM-DD'), '+40724745324', 'Masculin', 'A')
    INTO pacienti (nume, data_nasterii, nr_telefon, gen, grupa) VALUES ('Ioana Dinu', TO_DATE('2015-03-25', 'YYYY-MM-DD'), '+4724564927', 'Feminin', 'B')
    INTO pacienti (nume, data_nasterii, nr_telefon, gen, grupa) VALUES ('George Enache', TO_DATE('1995-02-24', 'YYYY-MM-DD'), '+40789458236', 'Masculin', 'AB')
    INTO pacienti (nume, data_nasterii, nr_telefon, gen, grupa) VALUES ('Raluca Zamfir', TO_DATE('1980-09-03', 'YYYY-MM-DD'), '+40734612835', 'Feminin', '0')
    INTO pacienti (nume, data_nasterii, nr_telefon, gen, grupa) VALUES ('Florin Radu', TO_DATE('2006-04-18', 'YYYY-MM-DD'), '+40723712938', 'Masculin', 'AB')
    INTO pacienti (nume, data_nasterii, nr_telefon, gen, grupa) VALUES ('Ariana Stan', TO_DATE('2006-03-15', 'YYYY-MM-DD'), '+40743295612', 'Feminin', 'A')
    INTO pacienti (nume, data_nasterii, nr_telefon, gen, grupa) VALUES ('Ana Panainte', TO_DATE('2006-04-26', 'YYYY-MM-DD'), '+40762903417', 'Feminin', 'A')
    INTO pacienti (nume, data_nasterii, nr_telefon, gen, grupa) VALUES ('Dennis Enache', TO_DATE('2005-07-19', 'YYYY-MM-DD'), '+40717213365', 'Masculin', 'B')
    INTO pacienti (nume, data_nasterii, nr_telefon, gen, grupa) VALUES ('Codrin Irofti', TO_DATE('2005-03-05', 'YYYY-MM-DD'), '+40755781392', 'Masculin', 'AB')
    INTO pacienti (nume, data_nasterii, nr_telefon, gen, grupa) VALUES ('Rares Sava', TO_DATE('2008-09-16', 'YYYY-MM-DD'), '+40735290012', 'Masculin', '0')
    INTO pacienti (nume, data_nasterii, nr_telefon, gen, grupa) VALUES ('Stefania Carp', TO_DATE('1997-11-09', 'YYYY-MM-DD'), '+40788345917', 'Feminin', '0')
    INTO pacienti (nume, data_nasterii, nr_telefon, gen, grupa) VALUES ('Robert Dumitru', TO_DATE('2006-04-26', 'YYYY-MM-DD'), '+40711549218', 'Masculin', 'AB')
SELECT * FROM dual;

COMMIT;

SELECT *
FROM pacienti;

DROP TABLE boli;
DROP SEQUENCE boli_seq;
-- boli
CREATE TABLE boli (
    id_boala NUMBER PRIMARY KEY,
    denumire VARCHAR2(100),
    descriere VARCHAR2(255)
);
CREATE SEQUENCE boli_seq
START WITH 1 INCREMENT BY 1
NOCACHE
NOCYCLE;

-- creez un trigger care seteaza automat id_boala daca nu este setat
CREATE OR REPLACE TRIGGER trg_boli_autoinsert
BEFORE INSERT ON boli
FOR EACH ROW
BEGIN
  IF :NEW.id_boala IS NULL THEN
    :NEW.id_boala := boli_seq.NEXTVAL;
  END IF;
END;
/

-- insert data into boli 
INSERT ALL
    INTO boli (denumire, descriere) VALUES ('Hipertensiune', 'Presiune arteriala crescuta')
    INTO boli (denumire, descriere) VALUES ('Cancer pulmonar', 'Tumora maligna in plamani')
    INTO boli (denumire, descriere) VALUES ('Epilepsie', 'Tulburari neurologice recurente')
    INTO boli (denumire, descriere) VALUES ('Bronsita', 'Inflamatie a bronhiilor')
    INTO boli (denumire, descriere) VALUES ('Apendicita', 'Inflamatie a apendicelui')
    INTO boli (denumire, descriere) VALUES ('Diabet zaharat', 'Boala metabolica caracterizata prin hiperglicemie')
    INTO boli (denumire, descriere) VALUES ('Pneumonie', 'Infectie acuta a tesutului pulmonar')
    INTO boli (denumire, descriere) VALUES ('Migrena', 'Cefalee severa, adesea insotita de greata si fotofobie')
    INTO boli (denumire, descriere) VALUES ('Anemie feripriva', 'Lipsa fierului care duce la scaderea hemoglobinei')
    INTO boli (denumire, descriere) VALUES ('Boala de reflux gastric', 'Reflux acid frecvent in esofag, arsura gastrica')
SELECT * FROM dual;

COMMIT;

SELECT *
FROM boli;

DROP TABLE pacienti_boli;
-- pacienti_boli(Relatie M:N)
CREATE TABLE pacienti_boli (
    id_pacient NUMBER,
    id_boala NUMBER,
    PRIMARY KEY (id_pacient, id_boala),
    FOREIGN KEY (id_pacient) REFERENCES pacienti(id_pacient),
    FOREIGN KEY (id_boala) REFERENCES boli(id_boala)
);

-- insert data into pacienti_boli
INSERT ALL
    INTO pacienti_boli (id_pacient, id_boala) VALUES (1, 1)
    INTO pacienti_boli (id_pacient, id_boala) VALUES (1, 7)
    INTO pacienti_boli (id_pacient, id_boala) VALUES (2, 8)
    INTO pacienti_boli (id_pacient, id_boala) VALUES (3, 5)
    INTO pacienti_boli (id_pacient, id_boala) VALUES (12, 3)
    INTO pacienti_boli (id_pacient, id_boala) VALUES (10, 2)
    INTO pacienti_boli (id_pacient, id_boala) VALUES (9, 8)
    INTO pacienti_boli (id_pacient, id_boala) VALUES (8, 10)
    INTO pacienti_boli (id_pacient, id_boala) VALUES (7, 9)
    INTO pacienti_boli (id_pacient, id_boala) VALUES (6, 1)
    INTO pacienti_boli (id_pacient, id_boala) VALUES (5, 3)
    INTO pacienti_boli (id_pacient, id_boala) VALUES (1, 10)
    INTO pacienti_boli (id_pacient, id_boala) VALUES (3, 1)
SELECT * FROM dual;

COMMIT;

SELECT *
FROM pacienti_boli;

DROP TABLE tratamente;
DROP SEQUENCE tratamente_seq;
-- tratamente
CREATE TABLE tratamente (
    id_tratament NUMBER PRIMARY KEY,
    descriere VARCHAR2(255)
);
CREATE SEQUENCE tratamente_seq
START WITH 1 INCREMENT BY 1
NOCACHE
NOCYCLE;

-- creez un trigger care seteaza automat id_tratament daca nu este setat
CREATE OR REPLACE TRIGGER trg_tratamente_autoinsert
BEFORE INSERT ON tratamente
FOR EACH ROW
BEGIN
  IF :NEW.id_tratament IS NULL THEN
    :NEW.id_tratament := tratamente_seq.NEXTVAL;
  END IF;
END;
/

-- insert data into tratamente
INSERT ALL
    INTO tratamente (descriere) VALUES ('Administrare medicamente antihipertensive')
    INTO tratamente (descriere) VALUES ('Chimioterapie')
    INTO tratamente (descriere) VALUES ('Tratament cu anticonvulsivante')
    INTO tratamente (descriere) VALUES ('Inhalatoare si repaus')
    INTO tratamente (descriere) VALUES ('Interventie chirurgicala')
    INTO tratamente (descriere) VALUES ('Administrare zilnica de insulina')
    INTO tratamente (descriere) VALUES ('Antibioterapie cu amoxicilina pentru 7 zile')
    INTO tratamente (descriere) VALUES ('Administrare de analgezice')
    INTO tratamente (descriere) VALUES ('Suplimentare orala cu fier si dieta bogata in fier')
    INTO tratamente (descriere) VALUES ('Inhibitori de pompa de protoni si regim alimentar')
    INTO tratamente (descriere) VALUES ('Terapie antivirala cu oseltamivir timp de 5 zile')
SELECT * FROM dual; 

COMMIT;

SELECT *
FROM tratamente;

DROP TABLE tratamente_boli;
-- tratamente_boli(Relatie M:N)
CREATE TABLE tratamente_boli (
    id_boala NUMBER,
    id_tratament NUMBER,
    PRIMARY KEY (id_boala, id_tratament),
    FOREIGN KEY (id_boala) REFERENCES  boli(id_boala),
    FOREIGN KEY (id_tratament) REFERENCES tratamente(id_tratament)
);

-- insert data into tratamente_boli
INSERT ALL 
    INTO tratamente_boli (id_tratament, id_boala) VALUES (1, 1)
    INTO tratamente_boli (id_tratament, id_boala) VALUES (1, 7)
    INTO tratamente_boli (id_tratament, id_boala) VALUES (2, 8)
    INTO tratamente_boli (id_tratament, id_boala) VALUES (3, 5)
    INTO tratamente_boli (id_tratament, id_boala) VALUES (11, 3)
    INTO tratamente_boli (id_tratament, id_boala) VALUES (10, 2)
    INTO tratamente_boli (id_tratament, id_boala) VALUES (9, 8)
    INTO tratamente_boli (id_tratament, id_boala) VALUES (8, 10)
    INTO tratamente_boli (id_tratament, id_boala) VALUES (7, 9)
    INTO tratamente_boli (id_tratament, id_boala) VALUES (6, 1)
    INTO tratamente_boli (id_tratament, id_boala) VALUES (5, 3)
    INTO tratamente_boli (id_tratament, id_boala) VALUES (4, 10)
    INTO tratamente_boli (id_tratament, id_boala) VALUES (3, 1)
SELECT * FROM dual; 

COMMIT;

SELECT *
FROM tratamente_boli;

DROP TABLE spitalizari;
DROP SEQUENCE spitalizari_seq;
-- spitalizari
CREATE TABLE spitalizari (
    id_spitalizare NUMBER PRIMARY KEY,
    id_pacient NUMBER,
    id_doctor NUMBER,
    data_internare DATE,
    data_externare DATE,
    diagnostic VARCHAR2(100),
    FOREIGN KEY (id_pacient) REFERENCES pacienti(id_pacient),
    FOREIGN KEY (id_doctor) REFERENCES doctori(id_doctor)
);
CREATE SEQUENCE spitalizari_seq
START WITH 1 INCREMENT BY 1
NOCACHE
NOCYCLE;

-- creez un trigger care seteaza automat id_spitalizare daca nu este setat
CREATE OR REPLACE TRIGGER trg_spitalizari_autoinsert
BEFORE INSERT ON spitalizari
FOR EACH ROW
BEGIN
  IF :NEW.id_spitalizare IS NULL THEN
    :NEW.id_spitalizare := spitalizari_seq.NEXTVAL;
  END IF;
END;
/

-- insert data into spitalizari
INSERT ALL 
    INTO spitalizari (id_pacient, id_doctor, data_internare, data_externare, diagnostic) VALUES (1, 1, TO_DATE('2024-05-21', 'YYYY-MM-DD'), TO_DATE('2024-05-25', 'YYYY-MM-DD'), 'Hipertensiune')
    INTO spitalizari (id_pacient, id_doctor, data_internare, data_externare, diagnostic) VALUES (2, 2, TO_DATE('2005-02-15', 'YYYY-MM-DD'), TO_DATE('2005-02-28', 'YYYY-MM-DD'), 'Apendicita')
    INTO spitalizari (id_pacient, id_doctor, data_internare, data_externare, diagnostic) VALUES (3, 3, TO_DATE('2020-07-15', 'YYYY-MM-DD'), NULL, 'Epilepsie')
    INTO spitalizari (id_pacient, id_doctor, data_internare, data_externare, diagnostic) VALUES (4, 4, TO_DATE('2024-08-17', 'YYYY-MM-DD'), TO_DATE('2024-12-25', 'YYYY-MM-DD'), 'Cancer pulmonar')
    INTO spitalizari (id_pacient, id_doctor, data_internare, data_externare, diagnostic) VALUES (5, 2, TO_DATE('2023-10-02', 'YYYY-MM-DD'), TO_DATE('2023-10-23', 'YYYY-MM-DD'), 'Pneumonie')
    INTO spitalizari (id_pacient, id_doctor, data_internare, data_externare, diagnostic) VALUES (5, 5, TO_DATE('2022-05-10', 'YYYY-MM-DD'), TO_DATE('2022-06-15', 'YYYY-MM-DD'), 'Cancer pulmonar')
    INTO spitalizari (id_pacient, id_doctor, data_internare, data_externare, diagnostic) VALUES (1, 7, TO_DATE('2017-04-08', 'YYYY-MM-DD'), TO_DATE('2017-04-10', 'YYYY-MM-DD'), 'Migrena')
SELECT * FROM dual; 

COMMIT;

SELECT *
FROM spitalizari;

DROP TABLE medicamente;
DROP SEQUENCE medicamente_seq;
-- medicamente
CREATE TABLE medicamente (
    id_medicament NUMBER PRIMARY KEY,
    denumire VARCHAR2(100),
    producator VARCHAR2(100)
);
CREATE SEQUENCE medicamente_seq
START WITH 1 INCREMENT BY 1
NOCACHE
NOCYCLE;

-- creez un trigger care seteaza automat id_medicament daca nu este setat
CREATE OR REPLACE TRIGGER trg_medicamente_autoinsert
BEFORE INSERT ON medicamente
FOR EACH ROW
BEGIN
  IF :NEW.id_medicament IS NULL THEN
    :NEW.id_medicament := medicamente_seq.NEXTVAL;
  END IF;
END;
/

-- insert data into medicamente
INSERT ALL 
    INTO medicamente (denumire, producator) VALUES ('Enalapril', 'Terapia Ranbaxy')
    INTO medicamente (denumire, producator) VALUES ('Cisplatin', 'Roche')
    INTO medicamente (denumire, producator) VALUES ('Valproat', 'Pfizer')
    INTO medicamente (denumire, producator) VALUES ('Ventolin', 'GSK')
    INTO medicamente (denumire, producator) VALUES ('Augmentin', 'GSK')
    INTO medicamente (denumire, producator) VALUES ('Olint', 'Berlin-Chemie')
    INTO medicamente (denumire, producator) VALUES ('Paracetamol', 'Terapia')
    INTO medicamente (denumire, producator) VALUES ('Ibuprofen', 'Zentiva')
    INTO medicamente (denumire, producator) VALUES ('Amoxicilina', 'Antibiotice Iasi')
    INTO medicamente (denumire, producator) VALUES ('Omeprazol', 'Krka')
SELECT * FROM dual; 

COMMIT;

SELECT *
FROM medicamente;

DROP TABLE retete;
-- retete(Relatie M:N)
CREATE TABLE retete (
    id_tratament NUMBER,
    id_medicament NUMBER,
    PRIMARY KEY (id_tratament, id_medicament),
    FOREIGN KEY (id_tratament) REFERENCES tratamente(id_tratament),
    FOREIGN KEY (id_medicament) REFERENCES medicamente(id_medicament)
);

-- insert data into retete
INSERT ALL
    INTO retete (id_tratament, id_medicament) VALUES (1, 1)
    INTO retete (id_tratament, id_medicament) VALUES (1, 7)
    INTO retete (id_tratament, id_medicament) VALUES (2, 8)
    INTO retete (id_tratament, id_medicament) VALUES (3, 5)
    INTO retete (id_tratament, id_medicament) VALUES (11, 3)
    INTO retete (id_tratament, id_medicament) VALUES (10, 2)
    INTO retete (id_tratament, id_medicament) VALUES (9, 8)
    INTO retete (id_tratament, id_medicament) VALUES (8, 10)
    INTO retete (id_tratament, id_medicament) VALUES (7, 9)
    INTO retete (id_tratament, id_medicament) VALUES (6, 1)
    INTO retete (id_tratament, id_medicament) VALUES (5, 3)
    INTO retete (id_tratament, id_medicament) VALUES (4, 10)
    INTO retete (id_tratament, id_medicament) VALUES (3, 1)
SELECT * FROM dual; 

COMMIT;

SELECT *
FROM retete;

DROP TABLE prescriptii;
-- prescriptii(Relatie M:N)
CREATE TABLE prescriptii (
    id_tratament NUMBER,
    id_doctor NUMBER,
    PRIMARY KEY (id_tratament, id_doctor),
    FOREIGN KEY (id_tratament) REFERENCES tratamente(id_tratament),
    FOREIGN KEY (id_doctor) REFERENCES doctori(id_doctor)
);

-- insert data into prescriptii
INSERT ALL 
    INTO prescriptii (id_tratament, id_doctor) VALUES (1, 1)
    INTO prescriptii (id_tratament, id_doctor) VALUES (1, 7)
    INTO prescriptii (id_tratament, id_doctor) VALUES (2, 8)
    INTO prescriptii (id_tratament, id_doctor) VALUES (3, 5)
    INTO prescriptii (id_tratament, id_doctor) VALUES (11, 3)
    INTO prescriptii (id_tratament, id_doctor) VALUES (10, 15)
    INTO prescriptii (id_tratament, id_doctor) VALUES (9, 8)
    INTO prescriptii (id_tratament, id_doctor) VALUES (8, 10)
    INTO prescriptii (id_tratament, id_doctor) VALUES (7, 9)
    INTO prescriptii (id_tratament, id_doctor) VALUES (6, 1)
    INTO prescriptii (id_tratament, id_doctor) VALUES (5, 3)
    INTO prescriptii (id_tratament, id_doctor) VALUES (4, 10)
    INTO prescriptii (id_tratament, id_doctor) VALUES (3, 1)
SELECT * FROM dual;     

COMMIT;

SELECT *
FROM prescriptii;

DROP TABLE doctori_pacienti;
-- doctori_pacienti (Relatie M:N)
CREATE TABLE doctori_pacienti (
    id_doctor NUMBER,
    id_pacient NUMBER,
    PRIMARY KEY (id_doctor, id_pacient),
    FOREIGN KEY (id_doctor) REFERENCES doctori(id_doctor),
    FOREIGN KEY (id_pacient) REFERENCES pacienti(id_pacient)
);   

-- insert data into doctori_pacienti 
INSERT ALL 
    INTO doctori_pacienti (id_doctor, id_pacient) VALUES (1, 1)
    INTO doctori_pacienti (id_doctor, id_pacient) VALUES (1, 7)
    INTO doctori_pacienti (id_doctor, id_pacient) VALUES (2, 8)
    INTO doctori_pacienti (id_doctor, id_pacient) VALUES (3, 5)
    INTO doctori_pacienti (id_doctor, id_pacient) VALUES (14, 3)
    INTO doctori_pacienti (id_doctor, id_pacient) VALUES (10, 2)
    INTO doctori_pacienti (id_doctor, id_pacient) VALUES (9, 8)
    INTO doctori_pacienti (id_doctor, id_pacient) VALUES (8, 8)
    INTO doctori_pacienti (id_doctor, id_pacient) VALUES (7, 7)
    INTO doctori_pacienti (id_doctor, id_pacient) VALUES (1, 12)
    INTO doctori_pacienti (id_doctor, id_pacient) VALUES (5, 11)
    INTO doctori_pacienti (id_doctor, id_pacient) VALUES (4, 10)
    INTO doctori_pacienti (id_doctor, id_pacient) VALUES (3, 1)
SELECT * FROM dual; 

COMMIT;

SELECT *
FROM doctori_pacienti;