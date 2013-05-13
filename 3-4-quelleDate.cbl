       program-id. 3-4-quelleDate.
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

           select f-chaufNouv assign 'ChaufNouv.dat' organization
           indexed
           access dynamic record key numchaufN.

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

       fd f-chaufNouv.
       1 ChaufNouv.
           2 numchaufN pic 9(4).
           2 nomN pic x(30).
           2 prenomN pic x(30).
           2 datepermisN pic 9(8).





       working-storage section.

       1 numaff pic 9(4).
       1 numchauff pic 9(4).
       1 numbus pic 9(4).
       1 chauf pic 9(4).
       1 bus pic 9(4).
       1 datedebut pic 9(8).
       1 datefin pic 9(8).
       1 dateaffect pic 9(8).
	   
       1 pic x value 'n'.
       88 fin-fichier value '0' false 'n'.
	   
       1 pic x value 'n'.
       88 disponible value '0' false 'n'.
	   
       1 choix pic 9.
       1 suite pic x.
       1 ligne pic 9(4) value 6.
       1 datedispo pic 9(8).
       1 numc pic 9(4).
       1 nom pic x(30).
       1 prenom pic x(30).
       1 numerobus pic 9(4).
       1 marquebus pic x(20).
       1 nbplacebus pic 9(3).
       1 modelebus pic x(20).
       1 busaffect pic 9(4).
       1 numchauffeur pic 9(4).
       1 chaufencours pic 9(4).
	   
       1 pic x value 'n'.
       88 busexistant value '0' false 'n'.
	   
       1 pic x value 'n'.
       88 fin value '0' false 'n'.
	   
       1 pic x value 'n'.
       88 tmp value '0' false 'n'.

       1 busaffect1 pic 9(4).
	   
       1 pic x value 'n'.
       88  chaufexistant value '0' false 'n'.

       1 pic x value 'n'.
       88 derniertrouve value '0' false 'n'.
	   
       1 pic x value 'n'.
       88 finbusnouv value '0' false 'n'.
	   
       1 numchauffeuraff pic 9(4).


       linkage section.
       1 num pic 9(8).

       screen section.
       1 s-ligne.
           2 line 1 col 1.
           2 s-chaufencours pic 9(4) from chaufencours.
           2 line 1 col 6.
           2 s-busaffect1 pic 9(4) from busaffect1.

       1 ecran-couleur.
           2 blank screen.
           2 line 2 col 5 'Date d''affectation'.
           2 line 2 col 25 'd''un chauffeur '&x'85'&' un bus'.

       1 a-plg-titre.
           2 line 7 col 3 'Bus'.
           2 line 7 col 10 'Chauffeur'.
           2 line 7 col 25 'D'&x'82'&'but d''affectation'.


       1 s-plg-chauf.
           2 line 4 col 1 'Num'&x'82'&'ro chauffeur :  '.
           2 s-numchauffeur pic 9(4) to numchauffeur required.

       1 s-plg-bus.
           2 line 5 col 1 'Bus d''affectation :  '.
           2 s-busaffect pic 9(4) to busaffect required.

       1 s-plg-ligne.
           2 line ligne col 1.
           2 s-numbus pic 9(4) from numbus.
           2 line ligne col 10.
           2 s-numchauffeuraff pic 9(4) from numchauffeuraff.
           2 line ligne col 29.
           2 s-datedebut1 pic 9(4) from datedebut(1:4).
           2 '/'.
           2 s-datedebut2 pic 99 from datedebut(5:2).
           2 '/'.
           2 s-datedebut3 pic 99 from datedebut(7:2).


       1 a-plg-next.
           2 line 23 col 1 'Appuyer sur une touche pour continuer'.
           2 line 24 col 10 pic x to suite auto secure.


       1 a-plg-suivante.
           2 line 21 col 1 'Entr'&x'82'&'e pour page suivante'.
           2 line 24 col 10 pic x to suite auto secure.

       1 a-plg-businexistant.
           2 line 20 col 1 'Num'&x'82'&'ro de bus inexistant'.
           2 line 24 col 10 pic x to suite auto secure.


       1 a-plg-chaufinexistant.
           2 line 20 col 1 'Chauffeur inexistant'.
           2 line 24 col 10 pic x to suite auto secure.

       1 a-plg-inexistant.
           2 line 19 col 1 'Pas d''affectation'.
           2 line 24 col 10 pic x to suite auto secure.


       procedure division using num.

       open input f-affectation
       open input f-bus
       open input f-chaufnouv
       display ecran-couleur

       display s-plg-chauf
       accept s-numchauffeur
       perform mod-testchauffeur
       set disponible to false

       if (chaufexistant) then
           display s-plg-bus
           accept s-busaffect
           perform mod-testbus
           if (busexistant) then
               compute ligne = 8
               move busaffect to numbusa

       *>parcours du fichier affectation pour tester si le chauffeur
       *>de la boucle precedente est affecté au bus donnée à la date
       *>donnée
           start f-affectation key = numbusa
               invalid key
                  set tmp to false
               not invalid key

                 set fin-fichier to false
                 perform until fin-fichier
                   read f-affectation next
                       end
                           set fin-fichier to true
                       not end
                           if busaffect = numbusa
                           and numchauffeur = numchaufa
                           then
                               move datedebaffecta to datedebut
                               move numchauffeur to numchauffeuraff
                               perform mod-afficheligne
                               set disponible to true

                           end-if
                   end-read
                 end-perform
           end-start
           else
               display a-plg-businexistant
           end-if
       else
           display a-plg-chaufinexistant
       end-if

       if not(disponible) then
           display a-plg-inexistant
       end-if

       close f-affectation f-bus f-chaufnouv
       display a-plg-next
       accept suite
       goback.


       *>------

       mod-testbus.
       move busaffect to numero
       read f-bus
           invalid key display a-plg-businexistant
               set busexistant to false
           not invalid key
               set busexistant to true
       end-read.

       mod-testchauffeur.
       move numchauffeur to numchaufn
       read f-chaufnouv
           invalid key display a-plg-chaufinexistant
               set chaufexistant to false
           not invalid key
               set chaufexistant to true
       end-read.



       mod-afficheligne.
       display a-plg-titre
       move datedebaffecta to datedebut
       move numchauffeur to numchauffeuraff
       move busaffect to numbus
       display s-plg-ligne
       compute ligne = ligne + 1
       if (ligne > 18) then
           compute ligne = 6
           display a-plg-suivante
           accept suite
           display ecran-couleur
           display a-plg-titre
       end-if.



       end program 3-4-quelleDate.
