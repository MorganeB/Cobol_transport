       program-id. recap.

       file-control.
           *> fichiers à ouvrir
           select f-bus assign 'FBus.dat' organization
           indexed
           access dynamic record key numero.

           select f-affectation assign 'Affectation.dat' organization
           indexed access dynamic
               record key Numaffect
               alternate record key NumchaufA duplicates
               alternate record key NumbusA duplicates.
			   
          select f-recap assign 'bilan.txt' organization record
          sequential.


       file section.

       fd f-recap.
           1 recap.
               2 numBus pic 9(4).
               2 nbrPlaces pic 999.
               2 dateDebut pic 9(8).
               2 dateFin pic 9(8).
               2 numChauff pic 9(4).
               2 serviceTotal pic 9(8).


       fd f-bus.
       1 bus.
           2 numero pic 9(4).
           2 marque pic x(20).
           2 nbplaces pic 9(3).
           2 modele pic x(20).
           2 kilom pic 9(6).


       fd f-affectation.
       1 Affectation.
           2 Numaffect pic 9(4).
           2 numchaufA pic 9(4).
           2 numbusA pic 9(4).
           2 dateDebAffectA pic 9(8).
           2 dateFinAffectA pic 9(8).

       working-storage section.
       1 suivant pic x.
       1 num pic 9(4).
       1 nom pic x(30).
       1 prenom pic x(30).
       1 permis pic 9(8).

       1 pic x value 'n'.
       88 fin-lire1 value 'o' false 'n'.

       1 pic x value 'n'.
       88 fin-lire2 value 'o' false 'n'.

       1 i pic 99 value 2. *> indice de ligne
       1 nextPage pic x.

       1 ligne pic x(80).

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


       procedure division.

           open input f-affectation
           open input f-bus
           open output f-recap


           perform test after until fin-lire1
               read f-bus next
               end set fin-lire1 to true end-read
               move numero to numBus
               move nbplaces to nbrPlaces

           end-perform



           close f-affectation
           close f-bus
           close f-recap

       end program recap.
