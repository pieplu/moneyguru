Modifier un document
====================

Concepts de base
----------------

La modification de donnée se passe à peu près de la même façon dans toutes les vues de moneyGuru. D'abord, il y a ces trois boutons au bas de la fenêtre qui servent à la même chose partout:

|edition_buttons|

Le + crée un nouveau truc, le - supprime le truc sélectionné, le "i" invoque un dialogue de détail pour le truc sélectionné. Le "truc" en question dépend de la vue courante (compte, transaction, récurrence, budget...). Dans le cas des transactions, si vous appuyez sur "i" alors que plus d'une transaction est sélectionnée, le dialogue invoqué sera le dialogue de modification multiple.

Les mêmes actions sont possible à partir du clavier. |cmd|\ N crée un nouveau truc, Delete le supprime, et |cmd|\ I invoque les détails.

Il est aussi possible de modifier la plupart des trucs dans les tables elles-même. Appuyer sur Return initie l'édition de la sélection (un double-clic aussi). Lorsque vous êtes en mode édition, appuyez sur Tab et Shift-Tab pour naviguer dans les champs. Appuyez sur Return pour confirmer votre édition ou sur Escape pour annuler cette édition.

Comptes
-------

Les comptes sont modifiés à partir des vues de Valeur nette et de Profits/Pertes. Quand vous créez un compte, ce compte sera créé sous le type présentement sélectionné. Vous pouvez toujours changer ce type en glissant le compte ailleurs.

|edition_account_panel|

Le dialogue de détails de compte permet de changer la :doc:`devise <currencies>` du compte. Il permet aussi de lui assigner un numéro de compte. Ce numéro peut alors être utilisé comme référence partout dans l'application (vous pouvez donc taper ce numéro au lieu du nom de compte). Ce numéro sera aussi affiché à côté du compte.

Les comptes et les devises: Il n'est pas possible de changer la devise d'un compte ayant des
:doc:`transactions réconciliées <reconciliation>`. Si pour une raison quelconque vous voulez changer
la devise d'un pareil compte, vous devrez commencer par dé-réconcilier ses transactions. Notez aussi
que changer la devise d'un compte ne change **pas** la devise des transaction qu'il contient.

Transactions
------------

Les transactions sont modifiées à partir des vues Transactions et Compte. Quand vous créez une nouvelle transaction, la date de la transaction sélectionnée est utilisée pour la nouvelle. Les colonnes de Description, Tiers et de comptes sont auto-complétés (voir ci-dessous).

Vous pouvez changer l'ordre de transaction ayant la même date en les glissant ou en utilisant |cmd|\ + et |cmd|\ -.

Si vous tapez un nom de compte inexistant, ce compte sera automatiquement créé. Ne vous en faites pas à propos des erreurs de frappe créant pleins de comptes à la rien à voir, moneyGuru fera le ménage des comptes vides quand vous corrigerez vos erreurs.

|edition_transaction_panel|

Le dialogue ci-dessus est le détail d'une seule transaction. À partir de la, vous pouvez modifier les mêmes données que dans les table. De plus, vous pouvez aussi modifier les entrées de façon individuelle, vous permettant ainsi de créer une transaction avec plus de deux entrées ("split transaction").

Une chose à retenir à propos de cette table d'entrée est qu'elle est constamment balancée. Chaque entrée que vous modifiez déclenche une opération de re-balancement créant ou modifiant une entrée non-assignée. Par exemple, imaginons que vous partagez internet avec un colocataire. L'internet coute 40$ et vous voulez assigner 20$ à un compte "Compte à recevoir coloc". Vous allez d'abord créer une transaction normale de 40$ "Compte Courant" --> "Internet". Puis, vous ouvrez le dialogue de détails et vous changez la ligne "Internet" de 40$ à 20$. Automatiquement, une 3e ligne non-assignée de 20$ apparaitra. Assignez cette ligne à "Compte à recevoir coloc". Votre table ressemblera à:

|edition_three_way_split|

Voilà, vous avez une transaction à 3 entrées.

|edition_mass_edition_panel|

Le dialogue ci-dessus est invoqué quand vous avez plusieurs transactions sélectionnées. Il permet de modifier toutes ces transactions en même temps. Choisissez les champs à modifier en cochant la case appropriée, entrez la nouvelle valeur désirée, puis cliquez sur Enregistrer.

Modification de dates
---------------------

Partout où les dates sont modifiables, un composant spécifique est utilisé rendant cette modification plus facile et efficace. Ce composant à 3 champs: jour, mois, année. À chaque fois qu'une modification est initiée, c'est toujours le champ **jour** qui reçoit le focus. Vous pouvez alors taper la date dans l'ordre jour --> mois --> année **quelque soit votre format de date**. Il est aussi possible d'utiliser les flèches latérales pour naviguer dans les champs. Les flèches verticales augmentent/diminuent le champ sélectionné de 1. Voici les règles:

* Le format d'affichage est toujours le format de votre système.
* Le format d'entrée est **toujours** jour --> mois --> année.
* Quelque soit votre format, vous pouvez taper les dates sans séparateur en utilisant le 0. Par exemple, si vous voulez entrer le 07/06/2010, vous pouvez taper "070610"
* Quelque soit votre format, taper un séparateur change de champ. Par exemple, si vous voulez entrer le 07/06/2010, vous pouvez taper "7/6/10".
* Vous pouvez taper "T" pour changer la date pour la date d'aujourd'hui.

Si vous changez la date d'une transaction pour une date qui est hors de l'intervalle courant, un petit |backward_16| ou |forward_16| apparaîtra. Ça indiquera que l'intervalle sera changé, si il est navigable, pour suivre la transaction. Si l'intervalle n'est pas navigable, la transaction deviendra invisible.

Modification de montants
------------------------

Les champs de modification de montants on de petites fonctionnalités cachées:

* Vous pouvez entrer des expressions comme "2+4.35/2" et elles seront calculées.
* Si vous activez "Placement automatique de décimale", taper un montant sans décimale place automatiquement cette décimale. Par exemple, si votre devise native est le USD, taper "1234" donne un montant de "12.34".
* Vous pouvez toujours spécifier la devise d'un montant à l'aide de son code ISO. Exemple: "24 usd", "eur 42".

Auto-complétion, Auto-remplissage, Recherche
--------------------------------------------

moneyGuru a des fonctionnalités d'auto-complétion et d'auto-remplissage avancées. Aussitôt que vous commencez à taper quelque chose dans un champ auto-complété, une proposition vous sera affichée (en utilisant les transactions précédemment entrées). Vous pouvez accepter la proposition en changeant de focus de champ, vous pouvez "cycler" au travers les propositions avec les flèches haut/bas ou bien vous pouvez ignorer les propositions en continuant à taper.

Lorsque vous remplissez un champ et que vous changez de focus, si la valeur de ce champ correspond à une transaction déja entrée, les autres champs seront automatiquement remplis par les autres valeurs correspondantes à la transaction précédente.

Sous Mac OS X, il est possible d'invoquer une fenêtre de recherche pour tous les champs avec auto-complétion. Ainsi, si vous savez que vous avez déjà entré la valeur que vous voulez entrer mais que vous ne vous souvenez plus du nom exact, appuyez sur |cmd|\ L et une fenêtre vous permettra de rechercher cette valeur.

.. |edition_buttons| image:: image/edition_buttons.png
.. |edition_account_panel| image:: image/edition_account_panel.png
.. |edition_transaction_panel| image:: image/edition_transaction_panel.png
.. |edition_three_way_split| image:: image/edition_three_way_split.png
.. |edition_mass_edition_panel| image:: image/edition_mass_edition_panel.png
.. |backward_16| image:: image/backward_16.png
.. |forward_16| image:: image/forward_16.png
