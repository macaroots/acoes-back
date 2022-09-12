-- MySQL dump 10.19  Distrib 10.3.34-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: bolsa
-- ------------------------------------------------------
-- Server version	10.5.9-MariaDB-1:10.5.9+maria~focal

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary table structure for view `carteira`
--

DROP TABLE IF EXISTS `carteira`;
/*!50001 DROP VIEW IF EXISTS `carteira`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `carteira` (
  `nome` tinyint NOT NULL,
  `investido` tinyint NOT NULL,
  `quantidade` tinyint NOT NULL,
  `preco_medio` tinyint NOT NULL,
  `ultimo_mes` tinyint NOT NULL,
  `ultimo_dividendos` tinyint NOT NULL,
  `ultimo_dy` tinyint NOT NULL,
  `dividendos_ultimo_mes` tinyint NOT NULL,
  `dy_ultimo_mes` tinyint NOT NULL,
  `dividendos_ultimo_ano` tinyint NOT NULL,
  `dy_ultimo_ano` tinyint NOT NULL,
  `dividendos_total` tinyint NOT NULL,
  `dy_total` tinyint NOT NULL,
  `primeiro_mes` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `dividendos_mes`
--

DROP TABLE IF EXISTS `dividendos_mes`;
/*!50001 DROP VIEW IF EXISTS `dividendos_mes`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `dividendos_mes` (
  `ano` tinyint NOT NULL,
  `mes` tinyint NOT NULL,
  `nome` tinyint NOT NULL,
  `dividendos` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `dy`
--

DROP TABLE IF EXISTS `dy`;
/*!50001 DROP VIEW IF EXISTS `dy`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `dy` (
  `ano` tinyint NOT NULL,
  `mes` tinyint NOT NULL,
  `nome` tinyint NOT NULL,
  `investido` tinyint NOT NULL,
  `quantidade` tinyint NOT NULL,
  `dividendos` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `movimentacoes`
--

DROP TABLE IF EXISTS `movimentacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movimentacoes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` date DEFAULT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `valor` int(11) DEFAULT NULL,
  `saldo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `data` (`data`,`nome`,`valor`,`saldo`)
) ENGINE=InnoDB AUTO_INCREMENT=713 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `nomes_valores`
--

DROP TABLE IF EXISTS `nomes_valores`;
/*!50001 DROP VIEW IF EXISTS `nomes_valores`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `nomes_valores` (
  `nome` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `valores`
--

DROP TABLE IF EXISTS `valores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `valores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` date DEFAULT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `preco` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `carteira`
--

/*!50001 DROP TABLE IF EXISTS `carteira`*/;
/*!50001 DROP VIEW IF EXISTS `carteira`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `carteira` AS select `o`.`nome` AS `nome`,`o`.`investido` AS `investido`,`o`.`quantidade` AS `quantidade`,`o`.`investido` / `o`.`quantidade` AS `preco_medio`,max(`o`.`mes`) AS `ultimo_mes`,`o`.`dividendos` AS `ultimo_dividendos`,`o`.`dividendos` / `o`.`investido` AS `ultimo_dy`,`m`.`dividendos` AS `dividendos_ultimo_mes`,`m`.`dividendos` / `m`.`investido` AS `dy_ultimo_mes`,`a`.`dividendos` AS `dividendos_ultimo_ano`,`a`.`dy` AS `dy_ultimo_ano`,`t`.`dividendos` AS `dividendos_total`,`t`.`dy` AS `dy_total`,`t`.`mes` AS `primeiro_mes` from ((((`bolsa`.`dy` `o` left join (select `dy`.`ano` AS `ano`,`dy`.`mes` AS `mes`,`dy`.`nome` AS `nome`,`dy`.`investido` AS `investido`,`dy`.`quantidade` AS `quantidade`,`dy`.`dividendos` AS `dividendos` from `bolsa`.`dy` where `dy`.`mes` = date_format(current_timestamp() - interval 1 month,'%Y-%m')) `m` on(`m`.`nome` = `o`.`nome`)) left join (select `i`.`nome` AS `nome`,sum(`i`.`dividendos`) AS `dividendos`,sum(`i`.`dividendos`) / max(`i`.`investido`) AS `dy` from `bolsa`.`dy` `i` where `i`.`ano` = year(current_timestamp() - interval 1 year) group by `i`.`nome`) `a` on(`a`.`nome` = `o`.`nome`)) left join (select `i`.`nome` AS `nome`,sum(`i`.`dividendos`) AS `dividendos`,sum(`i`.`dividendos`) / max(`i`.`investido`) AS `dy`,min(`i`.`mes`) AS `mes` from `bolsa`.`dy` `i` group by `i`.`nome`) `t` on(`t`.`nome` = `o`.`nome`)) join (select max(`dy`.`mes`) AS `mes`,`dy`.`nome` AS `nome` from `bolsa`.`dy` group by `dy`.`nome`) `i` on(`o`.`mes` = `i`.`mes` and `i`.`nome` = `o`.`nome`)) group by `o`.`nome` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `dividendos_mes`
--

/*!50001 DROP TABLE IF EXISTS `dividendos_mes`*/;
/*!50001 DROP VIEW IF EXISTS `dividendos_mes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `dividendos_mes` AS select year(`m`.`data`) AS `ano`,date_format(`m`.`data`,'%Y-%m') AS `mes`,`v`.`nome` AS `nome`,sum(`m`.`valor`) / 100 AS `dividendos` from (`movimentacoes` `m` join `nomes_valores` `v` on(`m`.`nome` like concat('%',`v`.`nome`,'%'))) group by `v`.`nome`,date_format(`m`.`data`,'%Y-%m') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `dy`
--

/*!50001 DROP TABLE IF EXISTS `dy`*/;
/*!50001 DROP VIEW IF EXISTS `dy`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `dy` AS select `d`.`ano` AS `ano`,`d`.`mes` AS `mes`,`i`.`nome` AS `nome`,sum(`i`.`preco` * `i`.`quantidade`) / 100 AS `investido`,sum(`i`.`quantidade`) AS `quantidade`,`d`.`dividendos` AS `dividendos` from (`valores` `i` join `dividendos_mes` `d` on(`i`.`nome` = `d`.`nome` and date_format(`i`.`data`,'%Y-%m') <= `d`.`mes`)) group by `i`.`nome`,`d`.`mes` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `nomes_valores`
--

/*!50001 DROP TABLE IF EXISTS `nomes_valores`*/;
/*!50001 DROP VIEW IF EXISTS `nomes_valores`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `nomes_valores` AS select distinct `v`.`nome` AS `nome` from `valores` `v` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-09-12 19:05:30
