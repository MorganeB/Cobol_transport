       program-id. supprChauffeur.

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
       1 suivant pic x.
       1 numSaisi pic 9(4) value 0.


       screen section.
       1 a-effacer.
           2 blank screen.

       1 a-plg-next.
           2 line 24 'Appuyez sur une touche pour continuer' .
           2 s-next line 25 col 80 pic x to suivant auto secure.

       1 s-plg-saisie.
           2 line 7 col 10 'Matricule du chauffeur a supprimer :'.
           2 s-num line 8 col 10 pic 9(4) to numSaisi required.

       1 a-plg-res.
           2 line 20 col 15 'Chauffeur supprim'&x'82'&' !'.

       1 a-plg-nonRes.
           2 line 19 col 15 'Echec. '.
           2 line 20 col 15 'Le matricule est peut-etre incorrect'.


       procedure division.
           display s-plg-saisie
           accept s-num

           open i-o f-chaufNouv
           read f-chaufNouv
           move numSaisi to numchaufN
           if numSaisi = numChaufN then
           delete f-chaufNouv
               invalid key
                   display a-plg-nonRes
               not invalid key
                   display a-plg-res
           end-delete
           end-if

           display a-plg-next
           accept s-next

           close f-chaufNouv
           goback.


       end program supprChauffeur.

