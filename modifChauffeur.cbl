       program-id. modifChauffeur.

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
       1 pic x value 'n'.
       88 trouve value 'o' false 'n'.
       1 suivant pic x.

       1 num pic 9(4) value 0.
       1 nomSaisi pic x(30).
       1 prenomSaisi pic x(30).
       1 permisSaisi pic 9(8).



       screen section.
       1 a-effacer.
           2 blank screen.

       1 a-plg-next.
           2 line 24 'Appuyez sur une touche pour continuer' .
           2 s-next line 25 col 80 pic x to suivant auto secure.

       1 s-num-a-modifier.
           2 line 7 col 5 'Quel matricule voulez-vous modifier ?'.
           2 s-num line 7 col 50 pic 9(4) to num required.

       1 s-plg-saisie.
           2 line 9 col 11 'Nom :  '.
           2 s-nom pic x(30) to nomSaisi.
           2 line 10 col 11 'Pr'&x'82'&'nom : '.
           2 s-prenom pic x(30) to prenomSaisi.
           2 line 11 col 10 'Date d''obtention du permis  '.
           2 s-date1 line 11 col 40 pic 9(4) to permisSaisi(1:4).
           2 '/'.
           2 s-date2 pic 99 to permisSaisi(5:2).
           2 '/'.
           2 s-date3 pic 99 to permisSaisi(7:2).

       1 a-plg-res.
           2 line 20 col 15 'Chauffeur modifi'&x'82'&' !'.

       1 a-plg-nonRes.
           2 line 20 col 15 'Echec. Chauffeur introuvable'.


       procedure division.
           display s-num-a-modifier
           accept s-num
           open i-o f-chaufNouv
           read f-chaufNouv next

           perform test after until trouve or fin-lire

               *> recherche matricule
           if numchaufN = num then
              set trouve to true
              set fin-lire to true
              move numchaufN to num
           else
               read f-chaufNouv next
               end set fin-lire to true end-read
           end-if
           end-perform

           *> si on trouve le matricule
           if trouve then
               display s-plg-saisie
               accept s-nom
               accept s-prenom
               accept s-date1
               accept s-date2
               accept s-date3

               move nomSaisi to nomN
               move prenomSaisi to prenomN
               move permisSaisi to datepermisN

               rewrite chaufNouv
                   invalid key
                   display a-plg-nonRes
                   display a-plg-next
                   accept s-next


                   not invalid key
                   display a-plg-res
                   display a-plg-next
                   accept s-next

               end-rewrite
           else
               display a-plg-nonRes
               display a-plg-next
               accept s-next


           end-if

           close f-chaufNouv
           goback.


       end program modifChauffeur.

















