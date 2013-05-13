       program-id. pg-partie1.

       file-control.
           *> fichier à ouvrir
           select f-chauffeur assign 'Fchauffeur.dat' organization
           sequential.

           *> fichier dans lequel on va recopier
           select f-chaufNouv assign 'ChaufNouv.dat' organization
           indexed
           access dynamic record key numchaufN.

           *> fichier 2
           select f-affectation assign 'Affectation.dat' organization
           indexed access dynamic
               record key Numaffect
               alternate record key NumchaufA duplicates
               alternate record key NumbusA duplicates.


       file section.

       fd f-chauffeur.
       1 chauffeur.
           2 nom pic x(30).
           2 prenom pic x(30).
           2 datepermis pic 9(8).
           2 tabAffect.
               3 affect occurs 20.
                   4 numbus pic 9(4).
                   4 dateDebAffect pic 9(8).
                   4 dateFinAffect pic 9(8).

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
       1 pic x value 'N'.
       88 fin-lire value 'O' false 'N'.
       1 i pic 99.  *> compteur boucle de lecture
       1 j pic 99.  *> compteur pour parcours tableau
       1 creaNumChauf pic 99.
       1 creaNumAffect pic 99.


       procedure division.
           *> ouvertures
           open input f-chauffeur
           open output f-chaufNouv
           open output f-affectation

           *> positionnement des numeros de chauffeurs
           compute creaNumChauf = 1
           compute creaNumAffect = 1
           read f-chauffeur end set fin-lire to true end-read

           perform until fin-lire
               compute creaNumChauf = creaNumChauf + 1
               perform mod-traitement
               read f-chauffeur end set fin-lire to true end-read
           end-perform
           close f-Chauffeur f-ChaufNouv f-Affectation
           goback.


       mod-traitement.
           move nom to nomN
           move prenom to prenomN
           move creaNumChauf to numChaufN
           compute datepermisN = datepermis
           write ChaufNouv

           *>boucle pour recopier le tableau (numBus, dates)
           perform test after varying j from 1 by 1 until j = 20
              if numbus(j) <> 0 then
                 move creaNumChauf to numchaufA
                 move creaNumAffect to NumAffect
                 compute creaNumAffect = creaNumAffect + 1
                 move numbus(j) to numbusA
                 move dateDebAffect(j) to dateDebAffectA
                 move dateFinAffect(j) to dateFinAffectA
                 write Affectation
             end-if

           end-perform




       .




       end program pg-partie1.




