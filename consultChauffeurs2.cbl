       program-id. consultChauffeurs2.

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
       1 nomRech   pic x(30).
       1 pic x value 'N'.
       88 fin-lire value 'O' false 'N'.
       1 pic x value 'N'.
       88 trouve value 'O' false 'N'.
       1 num pic 9(4).
       1 nom pic x(30).
       1 prenom pic x(30).
       1 permis pic 9(8).
       1 suivant      pic x.


       screen section.
       1 a-effacer.
           2 blank screen.

       1 a-plg-next.
           2 line 24 'Appuyez sur une touche pour continuer' .
           2 s-next line 25 col 80 pic x to suivant auto secure.


       1 s-plg-nom.
           2 line 12 col 11 'Nom du chauffeur : '.
           2 s-nom line 12 col 40 pic x(30) to nomRech required.

       1 a-plg-nonRes.
           2 line 14 'Chauffeur inexistant'.

       1 a-plg-res.
           2 line 15 col 2 'Matricule : '.
           2 a-num pic 9(4) from num.
           2 line 14 col 2 'Pr'&x'82'&'nom : '.
           2 a-prenom pic x(30) from prenom.
           2 line 16 col 2 'Date d''obtention du permis : '.
           2 a-permis pic 9(2) from datepermisN(7:2).
           2 '/'.
           2 a-permis2 pic 9(2) from datepermisN(5:2).
           2 '/'.
           2 a-permis3 pic 9(4) from datepermisN(1:4).



       procedure division.
           display s-plg-nom
           accept s-nom

           open input f-chaufNouv
           read f-chaufNouv next
           end set fin-lire to true end-read

           perform until fin-lire or trouve
               if function upper-case(nomRech) = function
                   upper-case(nomN) then
                       move numchaufN to num
                       move prenomN to prenom
                       move datepermisN to permis
                        display a-plg-res
                       display a-plg-next
                       accept s-next
                       set trouve to true
                end-if

           if not trouve then
               read f-chaufNouv next
           end set fin-lire to true end-read
           end-if

           end-perform

           if not trouve and fin-lire then
               display a-plg-nonRes
               display a-plg-next
               accept s-next

               end-if


           close f-chaufNouv

           set trouve to false
           set fin-lire to false

           goback.


       end program consultChauffeurs2.

















