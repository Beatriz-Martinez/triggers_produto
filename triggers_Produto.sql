-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Tempo de geração: 15-Nov-2021 às 23:49
-- Versão do servidor: 5.7.31
-- versão do PHP: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `triggers`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `logproduto`
--

DROP TABLE IF EXISTS `logproduto`;
CREATE TABLE IF NOT EXISTS `logproduto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `DataAlteracao` date NOT NULL,
  `id_doproduto` int(11) NOT NULL,
  `NewName` varchar(250) NOT NULL,
  `OldName` varchar(250) NOT NULL,
  `NewValue` float NOT NULL,
  `OldValue` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `logvenda`
--

DROP TABLE IF EXISTS `logvenda`;
CREATE TABLE IF NOT EXISTS `logvenda` (
  `id` int(11) NOT NULL,
  `DataAlteracao` date NOT NULL,
  `idVenda` int(11) NOT NULL,
  `Vendedor` varchar(250) NOT NULL,
  `qntPedido` int(11) NOT NULL,
  `ProdutoId` int(11) NOT NULL,
  `Total` float NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `produtos`
--

DROP TABLE IF EXISTS `produtos`;
CREATE TABLE IF NOT EXISTS `produtos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Nome` varchar(250) NOT NULL,
  `Preco` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Acionadores `produtos`
--
DROP TRIGGER IF EXISTS `tgrPrdutos_Update`;
DELIMITER $$
CREATE TRIGGER `tgrPrdutos_Update` AFTER UPDATE ON `produtos` FOR EACH ROW INSERT INTO `logproduto`(`id`, `DataAlteracao`, `id_doproduto`, `NewName`, `OldName`, `NewValue`, `OldValue`) VALUES (null,now(),new.id,new.nome,Old.nome,new.Preco,Old.Preco)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `venda`
--

DROP TABLE IF EXISTS `venda`;
CREATE TABLE IF NOT EXISTS `venda` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Vendedor` varchar(250) NOT NULL,
  `qntProdutos` int(11) NOT NULL,
  `produtoId` int(11) NOT NULL,
  `Total` float NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Acionadores `venda`
--
DROP TRIGGER IF EXISTS `tgrVendas_Insert`;
DELIMITER $$
CREATE TRIGGER `tgrVendas_Insert` AFTER INSERT ON `venda` FOR EACH ROW INSERT INTO `logvenda`(`id`, `DataAlteracao`, `idVenda`, `Vendedor`, `qntPedido`, `ProdutoId`, `Total`) VALUES (null ,now(),new.id,new.Vendedor,new.qntProdutos,new.produtoId,new.Total)
$$
DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
