# 🏥 Hospital Database Management System
O bază de date relațională complexă, dezvoltată în Oracle SQL & PL/SQL, destinată gestionării eficiente a fluxurilor de lucru dintr-un spital.

## 📋 Despre Proiect
Hospital Database Management este o soluție backend dezvoltată pentru a modela și administra informațiile critice dintr-o unitate spitalicească. Proiectul asigură o evidență clară a relațiilor dintre personalul medical, tratamentele prescrise și departamente.

## 🎯 Scopul Proiectului
Acest proiect a fost creat în cadrul disciplinei Sisteme de Gestiune a Bazelor de Date (SGBD) la Facultatea de Matematică și Informatică, Universitatea din București.
Scopul a fost demonstrarea stăpânirii conceptelor avansate de modelare a datelor, incluzând:


* **Design Relațional:** Crearea diagramelor conceptuale și a relațiilor complexe de tip M:N.


* **Normalizare Avansată:** Aducerea bazei de date până la Forma Normală 5 (FN5) și BCNF pentru eliminarea redundanțelor.


* **Automatizare & Securitate:** Implementarea triggerelor pentru auto-incrementare și auditarea modificărilor pe date sensibile.


* **Optimizarea Interogărilor:** Utilizarea algebrei relaționale și a planurilor de execuție pentru eficientizarea extragerii datelor.

## ✨ Features
### 👥 Managementul Pacienților și al Personalului

* **Evidența Pacienților:** Gestionarea datelor demografice și medicale (grupă sanguină, boli asociate).


* **Personal Medical:** Organizarea doctorilor și a asistentelor pe departamente.


* **Relații Complexe (M:N):** Maparea corectă a colaborărilor dintre doctori și asistente, dar și a pacienților tratați de mai mulți medici.

### 💊 Tratamente și Spitalizări

* **Managementul Tratamentelor:** Asocierea tratamentelor cu bolile specifice și cu medicamentele din rețetare.


* **Istoric Internări:** Monitorizarea spitalizărilor, incluzând data internării/externării, diagnosticul și medicul supervizor.

### ⚙️ Logica de Business

* **Secvențe și Triggere:** Auto-generare de chei primare (id) pentru tabele folosind SEQUENCE și triggere BEFORE INSERT.


* **Sistem de Audit (Logare):** Un trigger dedicat care interceptează și salvează într-un tabel separat (log_modificari_pacienti) orice modificare făcută asupra numelui sau numărului de telefon al unui pacient, reținând valorile vechi, valorile noi și timestamp-ul.


* **Interogări Complexe:** Extragerea datelor folosind subcereri sincronizate/nesincronizate, funcții de grup (HAVING), funcții NVL/DECODE și expresii CASE / WITH.

### 🛠️ Tehnologii Utilizate
* **Oracle Database:** Sistemul principal de gestiune a bazei de date relaționale.

* **SQL:** Limbajul utilizat pentru DDL (creare tabele) și DML (inserare, actualizare, interogare).

* **Algebra Relațională:** Baza matematică pentru optimizarea query-urilor (Pushing selection down).

## 📂 Structura Repository-ului

* **creare_inserare.sql** - Scripturile DDL pentru crearea tabelelor, secvențelor, triggerelor și scripturile DML pentru popularea bazei de date cu date coerente.


* **exemple.sql** - Colecție de interogări complexe (Join-uri, Subcereri, View-uri) și scripturi de update/delete.


* **proiect.docx** - Documentația principală a bazei de date. Conține descrierea modelului real, constrângerile, schemele conceptuale și demonstrarea normalizării tabelelor până la Forma Normală 5 (FN5) și BCNF


* **cerinta18.docx** - Exemplificarea nivelurilor de izolare (Read Uncommitted, Read Committed, Repeatable Read, Serializable) prin exemple de tranzacții executate în paralel.


* **cerinta19.docx** - Justificarea migrării către o bază de date NoSQL, incluzând structura colecțiilor (JSON) și exemple de comenzi specifice (inserare, modificare, ștergere, filtrare).


* **cerinta20.docx** - Implementarea de detaliu a mecanismului de auditare. Conține codul pentru trigger-ul care salvează automat istoricul modificărilor pacienților în tabelul log_modificari_pacienti. 

## 👨‍💻 Autor

Panaet Maria Alexandra 

**GitHub:** [@alexandra602]

**Proiect realizat la Facultatea de Matematică și Informatică.**
