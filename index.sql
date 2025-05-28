Objectif et attendu du devoir : 


Question 1 : 
  Afficher toutes les recettes disponibles (nom de la recette, catégorie et temps de préparation) triées
  de façon décroissante sur la durée de réalisation

SELECT -- indique les colonnes que l'on souhaite afficher dans le résultat final
  recette.nom_recette,  -- nom de chaque recette (colonne/champ provenant de la table "recette")
  categorie.nom_categorie, -- nom de la catégorie associée (colonne provenant de la table "categorie") A l'avenir privilégier les alias au nom (complet) de la table 
  recette.temps_preparation -- durée de préparation de la recette (toujours dans la table "recette")
FROM -- ici, je précise que les données que je veux récupérer proviennent de la table "recette"
  recette
INNER JOIN /* ici, je relie (ou "joins") la table "categorie" à la table "recette" car les noms des catégories (ex : entrée, dessert…) 
ne sont pas dans la table recette, ils sont stockés dans la table "categorie", donc je dois faire une liaison entre les deux
  categorie */
  categorie
ON 
  recette.id_categorie = categorie.id_categorie
ORDER BY 
  recette.temps_preparation DESC;  -- trie les résultats par durée de préparation, du plus long au plus court
     
Question 2 :
  En modifiant la requête précédente, faites apparaître le nombre d’ingrédients nécessaire par recette.


SELECT 
  recette.nom_recette, 
  categorie.nom_categorie, 
  recette.temps_preparation,
  COUNT(recette_ingredient.id_ingredient) AS nb_ingredients
FROM 
  recette
JOIN 
  categorie ON recette.id_categorie = categorie.id_categorie
JOIN 
  recette_ingredient ON recette.id_recette = recette_ingredient.id_recette
GROUP BY 
  recette.id_recette
ORDER BY 
  recette.temps_preparation DESC;


Question 3
  Afficher les recettes qui nécessitent au moins 30 min de préparation
 
SELECT 
  recette.nom_recette, 
  categorie.nom_categorie, 
  recette.temps_preparation
FROM 
  recette
JOIN 
  categorie ON recette.id_categorie = categorie.id_categorie
WHERE 
  recette.temps_preparation >= '00:30:00'
ORDER BY 
  recette.temps_preparation DESC;

Question 4 : 
  Afficher les recettes dont le nom contient le mot « Salade » (peu importe où est situé le mot en
  question)
 
SELECT 
  r.nom_recette, 
  c.nom_categorie, 
  r.temps_preparation
FROM 
  recette r
INNER JOIN 
  categorie c ON r.id_categorie = c.id_categorie
WHERE 
  r.nom_recette LIKE '%Salade%'
ORDER BY 
  r.temps_preparation DESC;

Question 5 : 
  Insérer une nouvelle recette : « Pâtes à la carbonara » dont la durée de réalisation est de 20 min avec
  les instructions de votre choix. Pensez à alimenter votre base de données en conséquence afin de
  pouvoir lister les détails de cette recettes (ingrédients)

Pour tout afficher (A refaire)
 
SELECT 
  r.nom_recette,
  c.nom_categorie,
  r.temps_preparation,
  i.nom_ingredient,
  ri.quantité,
  i.unité
FROM 
  recette r
INNER JOIN 
  categorie c  r.id_categorie = c.id_categorie
INNER JOIN 
  recette_ingredient ri ON r.id_recette = ri.id_recette
INNER JOIN 
  ingredient i ON ri.id_ingredient = i.id_ingredient
WHERE 
  r.id_recette;


Question 6 : (ok)
  Modifier le nom de la recette ayant comme identifiant id_recette = 3 (nom de la recette à votre
convenance)

Question 7 : (ok)
  Supprimer la recette n°2 de la base de données

Question 8 :
  Afficher le prix total de la recette n°5

SELECT
  SUM(ri.quantité * i.prix) AS prix_total
FROM
  recette_ingredient ri
INNER JOIN
  ingredient i ON ri.id_ingredient = i.id_ingredient
WHERE
  ri.id_recette = 5;

Question 9 : 
Afficher le détail de la recette n°5 (liste des ingrédients, quantités et prix)

SELECT
  i.nom_ingredient,
  ri.quantite,
  i.prix
FROM
  recette_ingredient ri
INNER JOIN
  ingredient i ON ri.id_ingredient = i.id_ingredient
WHERE
  ri.id_recette = 5;

Question 10 : (ok)
  Ajouter un ingrédient en base de données : Poivre, unité : cuillère à café, prix : 2.5 €

Question 11 : (ok)
  Modifier le prix de l’ingrédient n°12 (prix à votre convenance)

Question 12 : 
  Afficher le nombre de recettes par catégories : X entrées, Y plats, Z desserts

SELECT 
  c.nom_categorie,
  COUNT(r.id_recette) AS nb_recettes
FROM 
  recette r
INNER JOIN 
  categorie c ON r.id_categorie = c.id_categorie
GROUP BY 
  c.nom_categorie
ORDER BY 
  nb_recettes DESC;

Question 13 : 
  Afficher les recettes qui contiennent l’ingrédient « Poulet »

SELECT 
  r.nom_recette
FROM 
  recette r
INNER JOIN 
  recette_ingredient ri ON r.id_recette = ri.id_recette
WHERE 
  i.nom_ingredient LIKE '%Poulet%';

Question 14 (ok)
  Mettez à jour toutes les recettes en diminuant leur temps de préparation de 5 minutes

Question 15 : 
  Afficher les recettes qui ne nécessitent pas d’ingrédients coûtant plus de 2€ par unité de mesure

SELECT r.nom_recette
FROM recette r
INNER JOIN recette_ingredient ri ON r.id_recette = ri.id_recette
INNER JOIN ingredient i ON ri.id_ingredient = i.id_ingredient
GROUP BY r.id_recette
HAVING MAX(i.prix) <= 2;

Question 16 :
  Afficher la / les recette(s) les plus rapides à préparer 

SELECT r.nom_recette, r.temps_preparation
FROM recette r
ORDER BY temps_preparation ASC;
