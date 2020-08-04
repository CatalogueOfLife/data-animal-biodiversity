DROP TABLE IF EXISTS `Name`;
CREATE TABLE `Name` (
    SELECT * FROM (
    SELECT DISTINCT `Order` AS ID,
                    `Order` AS scientificName,
                    "order" AS `rank`, `Order` AS uninomial,
                    NULL    AS authorship
    FROM `data-animal-biodiversity`.`raw`
    UNION
    SELECT DISTINCT CONCAT_WS('-', `Order`, `Superfamily`) AS ID,
                    `Superfamily`                          AS scientificName,
                    "superfamily"                          AS `rank`,
                    `superfamily`                          AS uninomial,
                    NULL                                   AS authorship
    FROM `data-animal-biodiversity`.`raw`
    UNION
    SELECT DISTINCT CONCAT_WS('-', `Order`, `Superfamily`, `Family`) AS ID,
                    CONCAT_WS(' ', `Family`, AuthorString)           AS scientificName,
                    AuthorString                                     AS authorship,
                    "family"                                         AS `rank`,
                    `family`                                         AS uninomial
    FROM `data-animal-biodiversity`.`raw`) U WHERE scientificName IS NOT NULL
);

DROP TABLE IF EXISTS `Taxon`;
CREATE TABLE `Taxon` (
    SELECT DISTINCT `Order` AS nameID,
                    NULL AS parentID,
                    `Order` AS taxonID,
                    NULL    AS extinct
    FROM `data-animal-biodiversity`.`raw` WHERE Family IS NOT NULL
    UNION
    SELECT DISTINCT CONCAT_WS('-', `Order`, `Superfamily`) AS nameID,
                    `Order` AS parentID,
                    CONCAT_WS('-', `Order`, `Superfamily`) AS taxonID,
                    NULL    AS extinct
    FROM `data-animal-biodiversity`.`raw` WHERE Superfamily IS NOT NULL
    UNION
    SELECT DISTINCT CONCAT_WS('-', `Order`, `Superfamily`, `Family`) AS nameID,
                    CONCAT_WS('-', `Order`, `Superfamily`)           AS parentID,
                    CONCAT_WS('-', `Order`, `Superfamily`, `Family`) AS taxonID,
                    Extinct                                          AS extinct
    FROM `data-animal-biodiversity`.`raw` WHERE Family IS NOT NULL
);


