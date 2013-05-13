       program-id. ajoutChauffeur.

       file-control.
           select f-chaufNouv assign 'ChaufNouv.dat' organization
           indexed
           access dynamic record key numchaufN.

       file section.
       fd f-chaufNouv.
       1 ChaufNouv.
           2 numchaufN pic 9(4).
           2 nomN pic x(30).
           2 prenomN pic x(30).
           2 datepermisN pic 9(8).

       working-storage section.
       1 pic x value 'n'.
       88 fin-lire value 'o' false 'n'.
       1 suivant pic x.

       1 newNum pic 9(4) value 0.
       1 nomSaisi pic x(30).
       1 prenomSaisi pic x(30).
       1 permisSaisi pic 9(8).

       1 pic x value 'n'.
       88 juste value 'o' false 'n'.



       screen section.

       1 a-effacer.
           2 line 23 blank line.

       1 a-plg-next.
           2 line 24 'Appuyez sur une touche pour continuer' .
           2 s-next line 25 col 80 pic x to suivant auto secure.


       1 s-plg-saisie.
           2 line 8 col 8 'Nom :  '.
           2 s-nom pic x(30) to nomSaisi.
           2 line 9 col 8 'Pr'&x'82'&'nom : '.
           2 s-prenom pic x(30) to prenomSaisi.

       1 s-plg-saisie-permis.
           2 line 10 col 8 'Date du permis (au format AAAA/MM/JJ) : '.
           2 s-date11 pic 9(4) to permisSaisi(1:4).
           2 '/'.
           2 s-date12 pic 9(2) to permisSaisi(5:2).
           2 '/'.
           2 s-date13 pic 9(2) to permisSaisi(7:2).


       1 a-plg-res.
           2 line 20 col 15 'Chauffeur ajout'&x'82'&' !'.
           2 line 21 col 15 'Le num'&x'82'&'ro du chauffeur est le : '.
           2 a-newNum pic 9(4) from numchaufN.

       1 a-plg-nonRes.
           2 line 20 col 15 'Echec'.

       1 a-plg-erreur.
           2 line 23 col 12 'Saisir une date correcte svp'.


       procedure division.
           display s-plg-saisie
           display s-plg-saisie-permis
           accept s-nom
           accept s-prenom
           accept s-date11
           accept s-date12
           accept s-date13

           *> verification date saisie
           perform test after until juste
               if permisSaisi(5:2) > 12 or permisSaisi (7:2) > 31 then
               display a-plg-erreur
               display s-plg-saisie-permis
               accept s-date11
               accept s-date12
               accept s-date13

               else
                   set juste to true
                   display a-effacer

               end-if
           end-perform

           open i-o f-chaufNouv
           read f-chaufNouv next
           end set fin-lire to true end-read
           perform test after until fin-lire

               *> recherche du plus grand matricule
           if numchaufN > newNum then
              move numchaufN to newNum
           end-if

               read f-chaufNouv next
               end set fin-lire to true end-read
           end-perform

           *>
           if fin-lire then
               compute newNum = newNum + 1
               move newNum to numchaufN
               move nomSaisi to nomN
               move prenomSaisi to prenomN
               move permisSaisi to datepermisN

               write chaufNouv
                   invalid key
                      display a-plg-nonRes
                   not invalid key
                   display a-plg-res
               end-write
                   display a-plg-next
                   accept s-next


           end-if

           close f-chaufNouv
           goback.


       end program ajoutChauffeur.

















