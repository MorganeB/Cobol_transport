       program-id. quelleDate.

       file-control.
           *> fichiers à ouvrir
           select f-bus assign 'FBus.dat' organization
           indexed
           access dynamic record key numero.

           select f-chaufNouv assign 'ChaufNouv.dat' organization
           indexed
           access dynamic record key numchaufN.


           select f-affectation assign 'Affectation.dat' organization
           indexed access dynamic
               record key Numaffect
               alternate record key NumchaufA duplicates
               alternate record key NumbusA duplicates.


       file section.

       fd f-bus.
       1 bus.
           2 numero pic 9(4).
           2 marque pic x(20).
           2 nbplaces pic 9(3).
           2 modele pic x(20).
           2 kilom pic 9(6).


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

       1 pic x value 'n'.
       88 fin-lire value 'o' false 'n'.

       1 pic x value 'n'.
       88 trouve value 'o' false 'n'.

       1 pic x value 'n'.
       88 disponible value 'o' false 'n'.

       1 pic x value 'n'.
       88 fin value 'o' false 'n'.

       1 pic x value 'n'.
       88 dernierTrouve value 'o' false 'n'.

       1 pic x value 'n'.
       88 busExiste value '0' false 'n'.

       1 pic x value 'n'.
       88 chauffeurExiste value '0' false 'n'.

       1 pic x value 'n'.
       88 finBusNouv value 'o' false 'n'.

       1 linkage section.
       1 num pic 9(8).

       1 suivant pic x.
       1 numBus pic 9(4).
       1 numAffect pic 9(4).
       1 numChauff pic 9(4).
       1 ligne pic 99 value 1

       screen section.

       1 a-plg-titre.
           2 blank screen.
           2 line 2 col 10 'Consulter des dates d''affectation'.

       1 s-plg-saisie.
           2 line 4 col 4 'Num'&x'82'&'ro du bus : '.
           2 s-bus line 4 col 40 pic 9(4) to numBus required.
           2 line 5 col 4 'Matricule du chauffeur : '.
           2 s-chauffeur line 5 col 40 pic 9(4) to numChauff required.

       1 a-plg-entete.
           2 line 7 col 4 'D'&x'82'&'but d''affectation'.
           2 line 7 col 18 'Bus'.
           2 line 7 col 25 'Chauffeur'.
       1 a-plg-res.
           2 line ligne col 4
           2 a-date1 line ligne col 40 pic 9(8) from dateDebAffectA.
           2 line ligne col


       1 a-plg-nonRes.
           2 line 23 col 10 'Pas de resultats'.

       1 a-plg-next.
           2 line 24 'Appuyez sur une touche pour continuer' .
           2 s-next line 25 col 80 pic x to suivant auto secure.

       procedure division.

           display a-plg-titre
           display s-plg-saisie
           accept s-bus
           accept s-chauffeur

           *>ouvertures des fichiers
           open input f-affectation
           open input f-chaufNouv


           perform test after until fin-lire
               if numBus = numbusA then
                   if numChauff = numChaufN then
                       set trouve to true
                       set fin-lire to true
                       display a-plg-res
               else
                   read f-chaufNouv next
               end-if

          end-perform

          if not trouve then
               display a-plg-nonRes
           end-if

          display a-plg-next
          accept s-next

           close f-affectation
           close f-chaufNouv

           goback.








       end program quelleDate.
