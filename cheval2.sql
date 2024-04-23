
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 13
Server version: 8.0.36 MySQL Community Server - GPL

Copyright (c) 2000, 2024, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| bd_vol             |
| centre_formation   |
| djallabasoft       |
| ecuri              |
| hollywood          |
| information_schema |
| isgi               |
| mysql              |
| performance_schema |
| resto              |
| sakila             |
| stordb             |
| sys                |
| test1              |
| tramway            |
| world              |
+--------------------+
16 rows in set (0.01 sec)

mysql> use ecuri;
Database changed
mysql> show tables;
+-----------------+
| Tables_in_ecuri |
+-----------------+
| cheval          |
| concours        |
| croissance      |
| participation   |
| personnes       |
| proprietaire    |
| race            |
+-----------------+
7 rows in set (0.01 sec)

mysql> select * from cheval;
+-------+----------+-----------+--------------+----------------+---------------+----------+------------+
| ID_CH | nom_chev | num_tatto | couleur_chev | num_cheva_mere | num_chev_pere | nom_race | nump_eleve |
+-------+----------+-----------+--------------+----------------+---------------+----------+------------+
|     1 | bavan    |       100 | black        |              1 |             1 | ARABIAN  |         10 |
|     2 | kabour   |       200 | white        |              1 |             2 | MUSTANG  |         20
|     3 | masaoud  |       300 | brown        |              3 |             2 | ANDALOU  |         30 |
|     4 | avaar    |       400 | white        |              3 |             1 | ARABIAN  |         40 |
+-------+----------+-----------+--------------+----------------+---------------+----------+------------+
4 rows in set (0.00 sec)

mysql> select  couleur_chev,COUNT( ID_CH) as Cheval_Black
    -> from cheval
    ->  where couleur_chev = 'black'
    -> group by couleur_chev ;
+--------------+--------------+
| couleur_chev | Cheval_Black |
+--------------+--------------+
| black        |            1 |
+--------------+--------------+
1 row in set (0.00 sec)

mysql> select  nom_race,COUNT( ID_CH) as Cheval_Black
    -> ;
ERROR 1054 (42S22): Unknown column 'nom_race' in 'field list'
mysql> select  nom_race,COUNT( ID_CH) as Cheval_ARABIAN
    -> from cheval
    ->  where  nom_race = 'ARABIAN'
    -> group by  nom_race ;
+----------+----------------+
| nom_race | Cheval_ARABIAN |
+----------+----------------+
| ARABIAN  |              2 |
+----------+----------------+
1 row in set (0.00 sec)

mysql> select ID_CH, nom_chev from cheval
    -> where num_tatto = 300;
+-------+----------+
| ID_CH | nom_chev |
+-------+----------+
|     3 | masaoud  |
+-------+----------+
1 row in set (0.00 sec)

mysql> select COUNT(nom_con) as Nb_edition
    -> from concours
    ->  where nom_con = 'DRESSAGE';
+------------+
| Nb_edition |
+------------+
|          3 |
+------------+
1 row in set (0.00 sec)

mysql> select * from concours;
+------------+-------+----------------+--------+
| nom_con    | annee | nb_participant | place  |
+------------+-------+----------------+--------+
| DRESSAGE   |  2020 |             10 | RABTA  |
| DRESSAGE   |  2021 |             10 | RABTA  |
| DRESSAGE   |  2022 |             10 | RABTA  |
| JUMPING    |  2024 |             20 | CASA   |
| SHOW       |  2015 |             40 | AGADIR |
| TOURNAMENT |  2000 |             30 | KECH   |
+------------+-------+----------------+--------+
6 rows in set (0.00 sec)

mysql>  select SUM( nb_participant) as Total_Participants
    -> from concours
    -> where nom_con ='DRESSAGE';
+--------------------+
| Total_Participants |
+--------------------+
|                 30 |
+--------------------+
1 row in set (0.00 sec)

mysql> select * from participation
    -> ;
+-------+------------+-------+------+
| ID_CH | nom_con    | annee | rant |
+-------+------------+-------+------+
|     1 | DRESSAGE   |  2022 |   50 |
|     1 | JUMPING    |  2024 |   40 |
|     2 | JUMPING    |  2024 |   40 |
|     3 | JUMPING    |  2024 |   40 |
|     3 | SHOW       |  2015 |   30 |
|     4 | TOURNAMENT |  2000 |   20 |
+-------+------------+-------+------+
6 rows in set (0.00 sec)

mysql> select ID_CH from participation
    -> WHERE nom_con = 'JUMPING' AND annee = 2024;
+-------+
| ID_CH |
+-------+
|     1 |
|     2 |
|     3 |
+-------+
3 rows in set (0.00 sec)

mysql> SELECT DISTINCT participation.ID_CH, cheval.nom_chev
    -> FROM participation
    -> JOIN cheval ON participation.ID_CH = cheval.ID_CH
    -> WHERE participation.nom_con = 'JUMPING' AND participation.annee = 2024;
+-------+----------+
| ID_CH | nom_chev |
+-------+----------+
|     1 | bavan    |
|     2 | kabour   |
|     3 | masaoud  |
+-------+----------+
3 rows in set (0.00 sec)

mysql> select * from personnes;
+--------+---------+------------+-----------+-------------+--------------+-----------------+
| ID_PER | nom_per | prenom_per | tele      | adresse_per | fonction     | ID_PERSONNE_SUP |
+--------+---------+------------+-----------+-------------+--------------+-----------------+
|     10 | meryam  | amzil      | 612345645 | marrakech   | directrice   |            NULL |
|     20 | farah   | saiza      |  63456789 | agadir      | secretaire   |              20 |
|     30 | wissal  | loutfi     | 678543298 | rabat       | comptable    |              30 |
|     40 | rihab   | kabadj     | 678976543 | casa        | proprietaire |              40 |
|     50 | rihab   | kabadj     | 612345678 | fes         | secretaire   |              50 |
+--------+---------+------------+-----------+-------------+--------------+-----------------+
5 rows in set (0.00 sec)

mysql> select nom_per from personnes
    -> ;
+---------+
| nom_per |
+---------+
| meryam  |
| farah   |
| wissal  |
| rihab   |
| rihab   |
+---------+
5 rows in set (0.00 sec)

mysql> select nom_per  as Directrice
    ->  from personnes
    -> where fonction = 'directrice';
+------------+
| Directrice |
+------------+
| meryam     |
+------------+
1 row in set (0.00 sec)

mysql>  select COUNT( ID_PER ) as Nb_Pro
    -> from proprietaire;
+--------+
| Nb_Pro |
+--------+
|      6 |
+--------+
1 row in set (0.01 sec)

mysql> 


