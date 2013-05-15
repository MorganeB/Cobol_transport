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
			   
          select f-recap assign 'bilan.txt' organization line
          sequential.


       file section.

       fd f-recap.
           1 recap.
               2 ligne pic x(80).

       fd f-bus.
       1 bus.
           2 numero pic 9(4).
           2 marque pic x(20).
           2 nbplaces pic z(3).
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
       1 totalService pic 9(8).

       1 pic x value 'n'.
       88 fin-lire value 'o' false 'n'.

       1 pic x value 'n'.
       88 fin-lire2 value 'o' false 'n'.

       1 ligneVide pic x(80).

       screen section.
       1 a-plg-next.
           2 line 24 'Appuyez sur une touche pour continuer' .
           2 s-next line 25 col 80 pic x to suivant auto secure.


       1 a-plg-res.
           2 line 18 col 15 'bilan.txt a bien '&x'82'&'t'&x'82'&' '.
           2 line 18 col 36 'cr'&x'82'&'e'.

       1 a-plg-nonRes.
           2 line 10 col 15 'Erreur'.

       procedure division.


           open input f-bus
           open output f-recap


           read f-bus next end set fin-lire2 to true end-read
           perform test after until fin-lire2
               compute totalService = 0
              open input f-affectation
               move numero to numbusA
               move 'Bus ' to ligne(1:4)
               move numero to ligne(5:4)
               move 'Nombre de places :' to ligne(20:19)
               move nbplaces to ligne(40:3)
               write recap
                    set fin-lire to false
                   read f-affectation next end set fin-lire to true
                   end-read
                   perform test before until fin-lire
                   if numbusA = numero then
                       move '    ' to ligne(1:4)
                       move dateDebAffectA(7:2) to ligne(5:2)
                       move '/' to ligne(7:1)
                       move dateDebAffectA(5:2) to ligne(8:2)
                       move '/' to ligne(10:1)
                       move dateDebAffectA(1:4) to ligne(11:4)

                       move dateFinAffectA(7:2) to ligne(20:2)
                       move '/' to ligne(22:1)
                       move dateFinAffectA(5:2) to ligne(23:2)
                       move '/' to ligne(25:1)
                       move dateFinAffectA(1:4) to ligne(26:13)
                       move 'Chauffeur ' to ligne (40:19)
                       move numchaufA to ligne(52:4)
                       write recap

         compute totalService = totalService +
         (function integer-of-date(dateFinAffectA)
         - function integer-of-date(dateDebAffectA))

                   end-if

         read f-affectation next end set fin-lire to true end-read
                   end-perform
                   move ligneVide to ligne(1:80)
                   write recap

            move totalService to ligne(40:10)
            move 'jours de service au total' to ligne(50:80)
            write recap

                   move ligneVide to ligne(1:80)
                   write recap
                   move ligneVide to ligne(1:80)
                   write recap


           read f-bus next end set fin-lire2 to true end-read
            close f-affectation


           end-perform
            display a-plg-res

           display a-plg-next
           accept s-next

           close f-bus
           close f-recap

           set fin-lire2 to false
           set fin-lire to false
            goback
       end program recap.
