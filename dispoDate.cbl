       program-id. dispoDate.

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


       end program dispoDate.





