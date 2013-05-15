       program-id. consultChauffeurs1.

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

       screen section.
       1 a-effacer.
           2 blank screen.

       1 a-plg-next.
           2 line 19 'Appuyez sur une touche pour continuer' .
           2 s-next line 25 col 80 pic x to suivant auto secure.


       1 a-plg-nonRes.
           2 line 14 'Chauffeur inexistant'.

       1 s-plg-matricule.
           2 line 12 col 11 'Num'&x'82'&'ro du chauffeur : '.
           2 s-numChauffeur line 12 col 40 pic 9999 to numchaufN
           required.

       1 a-plg-res.
           2 line 14 col 2 'Nom : '.
           2 a-nom pic x(30) from nomN.
           2 line 15 col 2 'Pr'&x'82'&'nom : '.
           2 a-prenom pic x(30) from prenomN.
           2 line 16 col 2 'Date d''obtention du permis : '.
           2 a-permis pic 9(2) from datepermisN(7:2).
           2 '/'.
           2 a-permis2 pic 9(2) from datepermisN(5:2).
           2 '/'.
           2 a-permis3 pic 9(4) from datepermisN(1:4).


       procedure division.

           display s-plg-matricule
           accept s-numChauffeur

           open input f-chaufNouv
               read f-chaufNouv
               invalid key
                   display a-plg-nonRes
                   display a-plg-next
                   accept s-next

               not invalid key
                   display a-plg-res
                   display a-plg-next
                   accept s-next


               end-read

           close f-chaufNouv
           goback.


       end program consultChauffeurs1.

















