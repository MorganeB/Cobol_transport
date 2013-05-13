       program-id. listChauffeurs.

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
       1 num pic 9(4).
       1 nom pic x(30).
       1 prenom pic x(30).
       1 permis pic 9(8).

       1 pic x value 'n'.
       88 fin-lire value 'o' false 'n'.

       1 i pic 99 value 7. *> indice de ligne
       1 nextPage pic x.


       screen section.
       1 a-plg-next.
           2 line 24 'Appuyez sur une touche pour continuer' .
           2 s-next line 25 col 80 pic x to suivant auto secure.

       1 a-plg-effacerEcran.
           2 blank screen.

       1 a-plg-titre.
           2 line 5 col 4 'La liste des chauffeurs (suite) '.

       1 a-plg-nextPage.
           2 line 24 'Appuyez sur une touche pour afficher la suite'.
           2 s-nextPage line 25 col 80 pic x to nextPage auto secure.

       1 a-plg-res.
           2 s-num line i col 2 pic 9(4) from numchaufN.
           2 a-nom line i col 8 pic x(30) from nomN.
           2 a-prenom line i col 30 pic x(30) from prenomN.
           2 a-permis line i col 55 pic 9(4) from datepermisN(1:4).
           2 '/'.
           2 a-permis2 line i col 60 pic 9(2) from datepermisN(5:2).
           2 '/'.
           2 a-permis3 line i col 63 pic 9(2) from datepermisN(7:2).


       1 a-plg-nonRes.
           2 line 10 col 15 'Echec'.

       procedure division.

          open input f-chaufNouv
          perform test after until fin-lire
               read f-chaufNouv next
               end set fin-lire to true end-read
               if not fin-lire then
                    perform mod-affichage

               end-if

         end-perform

               display a-plg-next
               accept s-next

               close f-chaufNouv

          set fin-lire to false

           goback.

         mod-affichage.
           display a-plg-res
           compute i = i + 1
           if (i > 20) then
               compute i = 7
               display a-plg-nextPage
               accept s-nextPage
               display a-plg-effacerEcran
               display a-plg-titre
               display a-plg-res
           end-if
       .


       end program listChauffeurs.

