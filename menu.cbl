       program-id. menu.


       1 choix     pic 9.
       1 choix2    pic 9.


       screen section.
       1 a-effacer.
           2 blank screen.

       *>>>>>>>>>>>>>> Menu 0 : menu principal >>>>>>>>>>>>>>>
       1 a-plg-menu.
           2 line 5 col 10 'Menu principal'.
           2 line 7 col 10 '1 Gestion des chauffeurs'.
           2 line 8 col 10 '2 Gestion des affectations'.
           2 line 9 col 10 '3 Disponibilit'&x'82'&'s'.
           2 line 10 col 10 '4 R'&x'82'&'capitulatif'.

       1 s-plg-choix.
           2 line 13 col 13 'Choix ? '.
           2 s-choix line 13 col 22 pic z to choix required.

       *>>>>>>>>>>>>>>>>>>>> Menu 1 : chauffeurs >>>>>>>>>>>>>>

       1 a-plg-chauffeur.
           2 line 3 col 14 ' Gestion des chauffeurs'.
           2 line 5 col 10 '1 Consulter la fiche-chauffeur'.
           2 line 6 col 10 '2 Ajouter un chauffeur'.
           2 line 7 col 10 '3 Supprimer un chauffeur'.
           2 line 8 col 10 '4 Modifier une fiche-chauffeur'.
           2 line 9 col 10 '5 Lister tous les chauffeurs'.
           2 line 10 col 10 '6 Menu principal'.

       1 a-plg-affectation.
           2 line 3 col 14 'Affectations'.
           2 line 5 col 10 '1 Consulter une affectation'.
           2 line 6 col 10 '2 Ajouter une affectation'.
           2 line 7 col 10 '3 Supprimer une affectation'.
           2 line 8 col 10 '4 Modifier une affectation'.
           2 line 9 col 10 '5 Menu principal'.

       1 a-plg-disponibilites.
           2 line 3 col 14 'Disponibilit'&x'82'&'s'.
           2 line 5 col 10 '1 Chauffeurs un jour donn'&x'82'&' '.
           2 line 6 col 10 '2 Bus disponibles un jour donn'&x'82'&' '.
           2 line 7 col 10 '3 Disponibilit'&x'82'&' d''un chauffeur'.
           2 line 8 col 10 '4 Dates d''affectation d''un chauffeur'.
           2 line 9 col 10 '5 Menu principal'.

       1 a-plg-recap.
           2 line 15 col 10 '1 *fichier texte*'.
           2 line 15 col 10 '2 Menu principal'.


       *> 1-1 consulter les info d'un chauffeur
       1 s-choixsaisie.
           2 line 4 col 11 'Consulter la fiche d''un chauffeur'.
           2 line 6 col 8 '1 Par saisie de son matricule'.
           2 line 7 col 8 '2 Par saisie de son nom'.
           2 line 8 col 8 '3 Menu Principal'.
           2 line 10 col 11 'Choix : '.
           2 s-choixInfo line 10 col 20 pic 9 to choix required.



       *> 1-2 ajouter un chauffeur
       1 s-ajouterChauffeur.
           2 line 5 col 4 'Ajouter un nouveau chauffeur '.

       *> 1-3 supprimer un chauffeur
       1 s-supprimerChauffeur.
           2 line 5 col 4 'Supprimer un chauffeur '.

       *> 1-4 Modifier un chauffeur
       1 s-modifierChauffeur.
           2 line 5 col 4 'Modifier un chauffeur '.

       *> 1-5 Lister les chauffeurs
       1 s-listerChauffeurs.
           2 line 5 col 4 'La liste des chauffeurs '.

       *>>>>>>>>>>>> Menu 2 : affectations >>>>>>>>>>>

       *> 2-1 Consulter affectation
       1 s-consultation.
           2 line 4 col 4 'Consulter une affectation'.

       *> 2-2 Ajouter affectation
       1 s-ajouterAffectation.
           2 line 4 col 4 'Ajouter une affectation '.

       *> 2-3 Supprimer affectation
       1 s-supprimerAffect.
           2 line 5 col 4 'Supprimer une affectation '.

       *> 2-4 Modifier affectation
       1 s-modifierAffect.
           2 line 5 col 4 'Modifier une affectation '.


       *>>>>>>>>>>>> Menu 3 : disponibilités >>>>>>>>>>>

       *> 3-1 Chauffeurs dispo pour un jour donné
       1 s-dispoChauffeur.

       *> 3-2 Bus dispo pour un jour donné
       1 s-dispoBus.

       *> 3-3 Quel chauffeur pour un jour et un bus donnés
       1 s-quelChauffeur.

       *> 3-4 A quelle date ont été affectés un bus et un chauffeur
       1 s-quelleDate.


       *>>>>>>>>>>>> Menu 4 : Récapitulatif >>>>>>>>>>>




       *>>>>>>>>>>>>>>>> Fin screen section >>>>>>>>>>>>>>>>>>>

       procedure division.

       *> traitement pour les 2 menus
       display a-effacer
       perform test after until choix = 5
           display a-effacer
           display a-plg-menu
           display s-plg-choix
           accept s-choix
           evaluate choix
               when 1 perform mod-chauffeur
               when 2 perform mod-affectation
               when 3 perform mod-disponibilites
               when 4 perform mod-recap

            end-evaluate
            end-perform
       .


       mod-menu.
       display a-effacer
       perform test after until choix = 5
           display a-effacer
           display a-plg-menu
           accept s-choix
           evaluate choix
               when 1 perform mod-chauffeur
               when 2 perform mod-affectation
               when 3 perform mod-disponibilites
               when 4 perform mod-recap
           end-evaluate
           end-perform
       .

       *>>>>>>>>>> 1. modules pour chauffeurs >>>>>>>>>>>>>>>>>>

       mod-chauffeur.
       perform test after until choix = 6
           display a-effacer
           display a-plg-chauffeur
           display s-plg-choix
           accept s-choix
           evaluate choix
               when 1 perform mod-consultation
               when 2 perform mod-ajout
               when 3 perform mod-supprimer
               when 4 perform mod-modifier
               when 5 perform mod-lister
           end-evaluate
           end-perform
          .

       mod-consultation.
       perform test after until choix = 3
           display a-effacer
           display s-choixsaisie
           accept s-choixinfo
           if choix = 1 then
               call 'consultChauffeurs' end-call
           else if choix = 2 then
               call 'consultChauffeurs2' end-call
           else
               perform mod-menu
           end-if
           perform mod-menu

          end-perform


       .

       mod-ajout.
           perform test after until choix = 2
               display a-effacer
               display s-ajouterChauffeur
               call 'ajoutChauffeur' end-call
               perform mod-menu
           end-perform
       .

       mod-supprimer.
           perform test after until choix = 2
               display a-effacer
               display s-supprimerChauffeur
               call 'supprChauffeur' end-call
               perform mod-menu
           end-perform
       .

       mod-modifier.
           perform test after until choix = 2
               display a-effacer
               display s-modifierChauffeur
               call 'modifChauffeur' end-call
               perform mod-menu
           end-perform
       .

       mod-lister.
           perform test after until choix = 5
               display a-effacer
               display s-listerChauffeurs
               call 'listChauffeurs' end-call
               perform mod-menu
           end-perform

       .

       *>>>>>>>>>> 2. modules pour affections >>>>>>>>>>>>>>>>

       mod-affectation.
           perform test after until choix = 5
               display a-effacer
               display a-plg-affectation
               display s-plg-choix
               accept s-choix
               evaluate choix
                   when 1 perform mod-consult
                   when 2 perform mod-affecter
                   when 3 perform mod-supprAffect
                   when 4 perform mod-modifierAffect
                   when 5 perform mod-menu


           end-perform
       .

       mod-consult.
           perform test after until choix = 2
               display a-effacer
               display s-consultation
               call 'consultAffect' end-call
               perform mod-menu
           end-perform
       .

       mod-affecter.
           perform test after until choix = 2
               display a-effacer
               display s-ajouterAffectation
               call 'ajoutAffect' end-call
               perform mod-menu
           end-perform
       .

       mod-supprAffect.
           perform test after until choix = 2
               display a-effacer
               display s-supprimerAffect
               call 'supprAffect' end-call
               perform mod-menu
           end-perform
       .

       mod-modifierAffect.
           perform test after until choix = 2
               display a-effacer
               display s-modifierAffect
               call 'modifAffect' end-call
               perform mod-menu
           end-perform
       .

       *>>>>>>>>>> 3. modules pour disponibilites >>>>>>>>>>>>>>
       mod-disponibilites.
           perform test after until choix = 5
           display a-effacer
               display a-plg-disponibilites
               display s-plg-choix
               accept s-choix
               evaluate choix
                   when 1 perform mod-dispoChauffeur
                   when 2 perform mod-dispoBus
                   when 3 perform mod-quelChauffeur
                   when 4 perform mod-quelleDate
                   when 5 perform mod-menu
       .

       mod-dispoChauffeur.
           display a-effacer
           call '3-1-dispoChauffeurs' end-call
           perform mod-menu

       .

       mod-dispoBus.
           display a-effacer
           call '3-2-dispoBus' end-call
           perform mod-menu
       .

       mod-quelChauffeur.
           display a-effacer
           call '3-3-quelChauffeur' end-call
           perform mod-menu

       .

       mod-quelleDate.
           display a-effacer
           call '3-4-quelleDate' end-call
           perform mod-menu
       .

       *>>>>>>>>>>>>>> 4. modules pour recapitulatif >>>>>>>>


       mod-recap.
           display a-effacer
           call 'recap' end-call
           perform mod-menu

       .
       end program menu.









