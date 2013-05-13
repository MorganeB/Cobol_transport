       program-id. 3-1-dispoChauffeurs.

       file-control.
           *> fichiers à ouvrir
           select f-chaufNouv assign 'ChaufNouv.dat' organization
           indexed
           access dynamic record key numchaufN.

           select f-affectation assign 'Affectation.dat' organization
           indexed access dynamic
               record key Numaffect
               alternate record key NumchaufA duplicates
               alternate record key NumbusA duplicates.


       file section.

       fd f-chaufNouv.
       1 ChaufNouv.
           2 numchaufN pic 9(4).
           2 nomN pic x(30).
           2 prenomN pic x(30).
           2 datepermisN pic 9(8).

       fd f-affectation.
       1 Affectation.
           2 Numaffect pic 9(4).
           2 numchaufA pic 9(4).
           2 numbusA pic 9(4).
           2 dateDebAffectA pic 9(8).
           2 dateFinAffectA pic 9(8).


       working-storage section.
       *> indice de ligne
       1 i pic 99 value 11 .

       *>booleens
       1 pic x value 'n'.
       88 fin-lire value 'o' false 'n'.

       1 pic x value 'n'.
       88 trouve value 'o' false 'n'.

       1 pic x value 'n'.
       88 juste value 'o' false 'n'.

       1 suivant pic x.
       1 dateSaisie pic 9(8).
       1 nom pic x(30).
       1 prenom pic x(30).
       1 nextPage pic x.

       screen section.
       1 a-plg-effacerEcran.
           2 blank screen.

       1 a-plg-nextPage.
           2 line 24 'Appuyez sur une touche pour afficher la suite' .
           2 s-nextPage line 25 col 80 pic x to nextPage auto secure.

       1 s-plg-saisie.
           2 line 5 col 4 'A quelle date (format AAAA/MM/JJ) '.
           2 line 5 col 40 'voulez-vous un chauffeur ?'.
           2 s-date1 line 6 col 10 pic 9(4) to dateSaisie(1:4).
           2 '/'.
           2 s-date2 pic 99 to dateSaisie(5:2).
           2 '/'.
           2 s-date3 pic 99 to dateSaisie(7:2).

       1 a-plg-entete.
           2 line 9 col 4 'Chauffeur(s) disponible(s) : '.


       1 a-plg-res.
           2 a-nom line i col 8 pic x(30) from nomN.
           2 a-prenom line i col 40 pic x(30) from prenomN.

       1 a-plg-nonRes.
           2 line 12 col 15 'Pas de chauffeur disponible à cette date'.

       1 a-plg-next.
           2 line 24 'Appuyez sur une touche pour continuer' .
           2 s-next line 25 col 80 pic x to suivant auto secure.

       1 a-plg-erreur.
           2 line 23 col 12 'Saisir une date correcte svp'.

       1 a-effacer.
           2 line 23 blank line.


       procedure division.
           display s-plg-saisie
           accept s-date1
           accept s-date2
           accept s-date3

           *> verification date saisie
           perform test after until juste
               if dateSaisie(5:2) > 12 or dateSaisie (7:2) > 31 then
                   display a-plg-erreur
                   display s-plg-saisie
                   accept s-date1
                   accept s-date2
                   accept s-date3
               else
                   set juste to true
                   display a-effacer
               end-if
           end-perform

           open input f-affectation
           open input f-chaufNouv

           read f-chaufNouv next
           end set fin-lire to true end-read

           read f-affectation next
           perform test after until fin-lire

               if dateSaisie < dateDebAffectA or dateSaisie >
               dateFinAffectA then
                   perform mod-affichage
              else
                   read f-affectation next
                   end set fin-lire to true end-read

                   read f-chaufNouv next
                   end set fin-lire to true end-read


               end-if
          end-perform

          if not trouve then
               display a-plg-nonRes
           end-if

          display a-plg-next
          accept s-next

           close f-affectation
           close f-chaufNouv

          set trouve to false
          set fin-lire to false

           goback.

       mod-affichage.
                   display a-plg-entete
                   display a-plg-res
                   compute i = i + 1
                   read f-affectation next
                   read f-chaufNouv next
                   end set fin-lire to true end-read
                   set trouve to true

           if(i > 20) then
               compute i = 11
               display a-plg-nextPage
               accept s-nextPage
               display a-plg-effacerEcran
               display a-plg-entete
               display a-plg-res
           end-if

       .
       end program 3-1-dispoChauffeurs.





