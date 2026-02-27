-- 12
-- a) subcereri sincronizate in care intervin cel putin 3 tabele
-- b) subcereri nesincronizate in clauza FROM
-- c) grupari de date, functii grup, filtrare la nivel de grupuri cu subcereri nesincronizate
--    (in clauza HAVING)
-- d) ordonari si utilizarea functiilor NVL si DECODE (in cadrul aceleiasi cereri)
-- e) utilizarea a cel putin 2 functii pe siruri de caractere, 2 functii pe date calendaristice,
--    a cel putin unei expresii CASE
-- f) utilizarea a cel putin 1 bloc de cerere (clauza WITH)

-- 1 - a) + c)
-- Cerere: Selectati numele doctorilor si numarul de pacienti pe care ii trateaza,
--         cu o subcerere sincronizata pentru a verifica diagnosticul pacientilor
--         si grupati datele pe doctori
SELECT d.nume AS nume_doctor, COUNT(p.id_pacient) AS numar_pacienti
FROM doctori d
JOIN doctori_pacienti dp ON d.id_doctor = dp.id_doctor
JOIN pacienti p ON dp.id_pacient = p.id_pacient
WHERE p.id_pacient IN (SELECT sp.id_pacient
                        FROM spitalizari sp
                        WHERE sp.diagnostic = 'Hipertensiune')
GROUP BY d.nume
HAVING COUNT(p.id_pacient) > 0;

-- 2 - b) + d)
-- Cerere: O interogare care calculeaza salariile medicilor si trateaza valorile NULL folosind
--         NVL, iar in acelasi timp utilizeaza DECODE pentru a clasifica doctorii 
--         in functie de specializare
SELECT d.nume,
       NVL(d.salariu, 0) AS salariu,
       DECODE(d.specializare, 'Cardiologie', 'Cardiologie', 'Neurologie', 'Neurologie', 'Oncologie', 'Oncologie', 'Pediatrie', 'Pediatrie', 'Chirurgie', 'Chirurgie', 'Psihiatrie', 'Psihiatrie', 'Dermatologie', 'Dermatologie', 'Oftalmologie', 'Oftalmologie', 'Ginecologie', 'Ginecologie', 'Ortopedie', 'Ortopedie') AS tip_specializare
FROM doctori d
JOIN (SELECT id_doctor, specializare
      FROM doctori) d2 ON d.id_doctor = d2.id_doctor
ORDER BY NVL(d.salariu, 0) DESC;

-- 3 - e) + f)
--Cerere: Dorim obtinerea listei pacientilor majori (Adulti), impreuna cu varsta acestora si 
--        statutul corespunzator (“Adult”), pe baza datei de nastere. Varsta este calculata in ani impliniti,
--        iar clasificarea pacientilor se face in 2 categorii: “Minor”, “Adult”. 
WITH varsta_pacienti AS (
    SELECT p.id_pacient, p.nume, p.data_nasterii,
           TRUNC(MONTHS_BETWEEN(SYSDATE, p.data_nasterii) / 12) AS varsta,
           CASE
               WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, p.data_nasterii) / 12) < 18 THEN 'Minor'
               ELSE 'Adult'
           END AS statut
    FROM pacienti p
)
SELECT UPPER(p.nume) AS nume_complet, p.varsta, p.statut
FROM varsta_pacienti p
WHERE p.statut = 'Adult';
       
-- 4 - a) + c)
-- Cerere: O interogare care selecteaza numele doctorilor si numarul de pacienti pe care ii trateaza, 
--         cu o subcerere sincronizata pentru a calcula media numarului de pacienti tratati
--         de fiecare doctor si un filtru in clauza HAVING
SELECT d.nume, COUNT(p.id_pacient) AS nr_pacienti
FROM doctori d
JOIN doctori_pacienti dp ON d.id_doctor = dp.id_doctor
JOIN pacienti p ON dp.id_pacient = p.id_pacient
GROUP BY d.nume
HAVING COUNT(p.id_pacient) >
    (SELECT AVG(numar_pacienti)
     FROM (SELECT COUNT(*) AS numar_pacienti
           FROM doctori_pacienti dp
           GROUP BY dp.id_doctor));
           
-- 5 - e) + f)
-- Cerere: O interogare care utilizeaza functii ep siruri de caractere 
--         si pe date calendaristice pentru a calcula varsta pacientului si pentru a clasifica
--         pacientul in functie de diagnostic, folosind o expresie CASE
WITH diagnostic_pacienti AS (
    SELECT p.id_pacient, p.nume, p.data_nasterii, sp.diagnostic,
           TRUNC(MONTHS_BETWEEN(SYSDATE, p.data_nasterii) / 12) AS varsta,
           CASE
               WHEN sp.diagnostic LIKE '%Cancer%' THEN 'Grav'
               ELSE 'Normal'
           END AS statut_diagnostic
    FROM pacienti p
    JOIN spitalizari sp ON p.id_pacient = sp.id_pacient
)
SELECT UPPER(p.nume) AS nume_complet, p.varsta, p.statut_diagnostic
FROM diagnostic_pacienti p
WHERE p.statut_diagnostic = 'Grav';

-- 13
-- 1 
-- Update: Marim salariul doctorilor care trateaza cel putin 3 pacienti
UPDATE doctori
SET salariu = salariu * 1.1
WHERE id_doctor IN (
    SELECT id_doctor
    FROM doctori_pacienti
    GROUP BY id_doctor
    HAVING COUNT(id_pacient) > 3
);
COMMIT;

SELECT *
FROM doctori;

-- 2
-- Delete: Stergem retetele care nu sunt prescrise niciunul pacient
DELETE FROM retete r
WHERE NOT EXISTS (
    SELECT 1
    FROM tratamente_boli tb
    JOIN pacienti_boli pb ON tb.id_boala = pb.id_boala
    WHERE tb.id_tratament = r.id_tratament
);
COMMIT;

SELECT *
FROM retete;

-- 3
-- Update: Schimbam diagnosticul in 'Necunoscut' pentru pacientii care au fost internati,
--         dar nu au nicio boala asociata
UPDATE spitalizari
SET diagnostic = 'Necunoscut'
WHERE id_pacient in (
    SELECT p.id_pacient
    FROM pacienti p
    LEFT JOIN pacienti_boli pb ON p.id_pacient = pb.id_pacient
    WHERE pb.id_boala IS NULL
);
COMMIT;

SELECT * 
FROM spitalizari;

-- 14. Crearea unei vizualizari complexe
CREATE OR REPLACE VIEW V_Spitalizari_Pacienti_Doctori AS
SELECT
    d.nume AS nume_doctor,
    d.specializare,
    dep.nume AS departament,
    p.nume AS nume_pacient,
    s.diagnostic,
    s.data_internare,
    s.data_externare
FROM spitalizari s
JOIN doctori d ON s.id_doctor = d.id_doctor
JOIN departamente dep ON d.id_departament = dep.id_departament
JOIN pacienti p ON s.id_pacient = p.id_pacient;

-- operatie LMD permisa (nu altereaza datele)
SELECT * 
FROM V_Spitalizari_Pacienti_Doctori
WHERE specializare = 'Cardiologie';

-- operatie LMD nepermisa (incearca sa modifice datele)
INSERT INTO V_Spitalizari_Pacienti_Doctori (
    nume_doctor, specializare, departament,
    nume_pacient, diagnostic, data_internare, data_externare
)
VALUES (
     'Dr. Istrate', 'Cardiologie', 'Cardiologie',
     'Ion Popescu', 'Boala Test', TO_DATE('2025-06-01', 'YYYY-MM-DD'), NULL
);

-- 15
-- 1. Afiseaza toti pacientii, impreuna cu spitalizarile lor(daca exista), doctorii care i-au tratat
--    si departamentele de care apartin acesti doctori, chiar si in cazurile in care 
--    pacientul nu a fost spitalizat.
SELECT
    p.nume AS nume_pacient,
    NVL(s.diagnostic, 'Nespitalizat') AS diagnostic,
    d.nume AS nume_doctor,
    dep.nume AS departament
FROM pacienti p
LEFT OUTER JOIN spitalizari s ON p.id_pacient = s.id_pacient
LEFT OUTER JOIN doctori d ON s.id_doctor = d.id_doctor
LEFT OUTER JOIN departamente dep ON d.id_departament = dep.id_departament;

-- 2. Selecteaza doctorii care au tratat toti pacientii 
--    care au fost spitalizati cu diagnosticul 'Hipertensiune'
SELECT d.nume
FROM doctori d
WHERE NOT EXISTS (
    SELECT sp.id_pacient
    FROM spitalizari sp
    WHERE sp.diagnostic = 'Hipertensiune'
    MINUS
    SELECT dp.id_pacient
    FROM doctori_pacienti dp
    WHERE dp.id_doctor = d.id_doctor
);

-- 3. Afiseaza top 5 cei mai frecvent spitalizati pacienti,
--    impreuna cu numarul spitalizarilor
SELECT *
FROM (
    SELECT
        p.nume AS nume_pacient,
        COUNT(s.id_spitalizare) AS nr_spitalizari
    FROM pacienti p
    JOIN spitalizari s ON p.id_pacient = s.id_pacient
    GROUP BY p.nume
    ORDER BY nr_spitalizari DESC
)
WHERE ROWNUM <= 5;

-- 16 - a) Optimizarea unei cereri, aplicand regulile de optimizare 
--         ce deriva din proprietatile operatorilor algebrei relationale.

-- Cerere: Afiseaza numele doctorilor si numarul pacientilor tratati de 
--         acestia, doar pentru doctorii din departamentul 'Cardiologie'.

-- Interogare initiala
SELECT
    d.nume, 
    COUNT(dp.id_pacient) AS nr_pacienti
FROM doctori d
LEFT JOIN doctori_pacienti dp ON d.id_doctor = dp.id_doctor
JOIN departamente dep ON d.id_departament = dep.id_departament
WHERE dep.nume = 'Cardiologie'
GROUP BY d.nume;

-- Interogare optimizata
SELECT
    d.nume,
    COUNT(dp.id_pacient) AS nr_pacienti
FROM doctori d
LEFT JOIN doctori_pacienti dp ON d.id_doctor = dp.id_doctor
JOIN (
     SELECT *
     FROM departamente
     WHERE nume = 'Cardiologie'
) dep ON d.id_departament = dep.id_departament
GROUP BY d.nume;