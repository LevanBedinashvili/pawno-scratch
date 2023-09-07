-- phpMyAdmin SQL Dump
-- version 4.2.12deb2+deb8u9
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 26, 2023 at 10:16 AM
-- Server version: 5.5.62-0+deb8u1
-- PHP Version: 5.6.40-0+deb8u12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `user11321`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE IF NOT EXISTS `accounts` (
`pID` int(11) NOT NULL,
  `pName` varchar(100) COLLATE cp1251_bin NOT NULL,
  `pPassword` varchar(32) COLLATE cp1251_bin NOT NULL,
  `pMail` varchar(64) COLLATE cp1251_bin NOT NULL,
  `pSex` int(11) NOT NULL,
  `pSkin` int(11) NOT NULL,
  `pCash` int(11) NOT NULL,
  `pLevel` int(11) NOT NULL,
  `pAdmin` int(11) NOT NULL,
  `pDostup` varchar(32) COLLATE cp1251_bin NOT NULL,
  `pHouse` int(11) NOT NULL,
  `pQuest1` int(11) NOT NULL,
  `pQuest2` int(11) NOT NULL,
  `pQuest3` int(11) NOT NULL,
  `pLeader` int(11) NOT NULL,
  `pMember` int(11) NOT NULL,
  `pForma` int(11) NOT NULL,
  `pRank` int(11) NOT NULL,
  `pAdminLogin` int(11) NOT NULL,
  `pBizz` int(11) NOT NULL,
  `pClock` int(11) NOT NULL,
  `pMobile` int(11) NOT NULL,
  `pMute` int(11) NOT NULL,
  `pMuteTime` int(11) NOT NULL,
  `pExp1` int(11) NOT NULL,
  `pExp2` int(11) NOT NULL,
  `pBank` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=cp1251 COLLATE=cp1251_bin ROW_FORMAT=COMPACT;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`pID`, `pName`, `pPassword`, `pMail`, `pSex`, `pSkin`, `pCash`, `pLevel`, `pAdmin`, `pDostup`, `pHouse`, `pQuest1`, `pQuest2`, `pQuest3`, `pLeader`, `pMember`, `pForma`, `pRank`, `pAdminLogin`, `pBizz`, `pClock`, `pMobile`, `pMute`, `pMuteTime`, `pExp1`, `pExp2`, `pBank`) VALUES
(1, 'Jonathan_Anderson', 'ikkka415', 'ikka@gmail.com', 1, 293, 1800, 4, 0, '', 11, 0, 0, 0, 1, 1, 0, 15, 0, 0, 1, 1, 0, 0, 9, 16, 84105),
(2, 'Levan_Bedinashvili', 'levani2004', 'sad@gmail.com', 1, 30, 457905580, 27, 0, '', -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 2, 4, 0),
(3, 'Davit_Ximenez', 'bachiele', 'sjsieieie@gmail.com', 1, 174, 30001, 1, 6, 'bachiele', 42, 1, 0, 0, 1, 1, 104, 15, 0, -1, 0, 0, 1, 600, 1, 2, 22245),
(4, 'Taha_Miqesta', 'TahaVar123', '@gmail.com', 1, 3, 1000, 1, 0, '', -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 2, 0),
(5, 'Kurcaa_Solo', 'sanosano', 'kurcadzesandro@gmail.com', 1, 3, 1000, 1, 0, 'sanosano', -1, 0, 0, 0, 7, 7, 104, 9, 0, -1, 0, 0, 0, 0, 0, 2, 0),
(6, 'Vakhtang_Gorgasali', 'vaxtang2000', 'samsonidzeluka70@gmail.com', 1, 3, 1000, 1, 0, '', -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 2, 0),
(7, 'Inoue_Takehiko', 'samsona2000', 'samsonidzeluka70@gmail.com', 1, 280, 4501000, 1, 5, 'ssssss', 32, 0, 0, 0, 7, 7, 104, 9, 0, -1, 0, 0, 0, 0, 0, 2, 0),
(8, 'Georg_Anderson', 'duduka22', 'mr.kiknavelidze@gmail.com', 1, 0, 1411, 2, 6, 'duduka22', 10, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 4, 20916),
(9, 'Lominadze_Manuchar', 'sagadasaxado', 'manucharlominadze@gmail.com', 1, 3, 29652, 1, 0, '', -1, 1, 0, 0, 11, 11, 0, 9, 0, -1, 0, 0, 0, 0, 0, 2, 0),
(10, 'Saint_Sebastian', 'sabuka12', 'saba_mukbaniani95@gmail.com', 1, 116, 999999999, 2, 6, 'swansky', 36, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 1, 0, 0, 1, 4, 22395),
(11, 'Lominadze_Manucha', 'sagadasaxado', 'gamijng.tv-2001@gmail.com', 1, 3, 1000, 1, 0, '', -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 2, 0),
(12, 'Rass_Springzz', 'sanosano', 'kurcadzesandro@gmail.com', 1, 3, 1000, 1, 0, '', -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 2, 0),
(13, 'Kurcaa_Softeri', 'sanosano', 'kurcadzesandro@gmail.com', 1, 3, 5001000, 1, 3, 'sanosano', -1, 0, 0, 0, 10, 10, 0, 9, 0, -1, 0, 0, 0, 0, 0, 2, 0),
(14, 'Levani_Bedinashvili', 'levani2004', 'asdasd@gmail.com', 1, 3, 215139, 31, 0, '', 39, 0, 0, 0, 1, 1, 288, 15, 1, -1, 0, 1, 0, 0, 0, 8, 42945),
(15, 'Qeti_Hell', 'qeti2007', 'lado.davitashvili2011@gmail.com', 2, 193, 1000, 1, 1, 'qeti2007', -1, 0, 0, 0, 1, 1, 0, 15, 1, -1, 0, 0, 0, 0, 0, 2, 0),
(16, 'Lorento_Memento', 'murtalo22', 'lukagamersgeims@gmail.com', 1, 3, 1200001000, 1, 4, 'murtalo22', -1, 0, 0, 0, 1, 1, 288, 15, 0, -1, 0, 0, 0, 0, 1, 2, 22215),
(17, 'Jonathan_Prochi', 'asdasda1', 'mr.kiknavelidze@gmail.com', 2, 6, 1000, 1, 0, '', -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 2, 0),
(18, 'Zarbo_Ox', 'ilia2011ox', 'ilianayofia80@gmail.com', 1, 3, 580, 1, 0, '', -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 1, 2, 0),
(19, 'Nick_Gustin', 'nikolozi', 'nika42@gmail.com', 1, 3, 1000, 1, 0, '', -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 2, 0),
(20, 'George_Swift', 'levani2004', 'levan@gmail.com', 1, 3, 25213, 1, 0, '', -1, 0, 0, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 2, 0),
(21, 'Bedinashvili_Levani', 'levani2004', 'asd@gmail.com', 1, 3, 30622, 1, 0, '', -1, 0, 0, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `business`
--

CREATE TABLE IF NOT EXISTS `business` (
`bID` int(11) NOT NULL,
  `bOwned` int(11) NOT NULL,
  `bOwner` varchar(100) COLLATE cp1251_bin NOT NULL,
  `bEnterX` float NOT NULL,
  `bEnterY` float NOT NULL,
  `bEnterZ` float NOT NULL,
  `bExitX` float NOT NULL,
  `bExitY` float NOT NULL,
  `bExitZ` float NOT NULL,
  `bBuyX` float NOT NULL,
  `bBuyY` float NOT NULL,
  `bBuyZ` float NOT NULL,
  `bPrice` int(11) NOT NULL,
  `bLock` int(11) NOT NULL,
  `bType` int(11) NOT NULL,
  `bInt` int(11) NOT NULL,
  `bTypeID` int(11) NOT NULL,
  `bIcon` int(11) NOT NULL,
  `bBank` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=cp1251 COLLATE=cp1251_bin;

--
-- Dumping data for table `business`
--

INSERT INTO `business` (`bID`, `bOwned`, `bOwner`, `bEnterX`, `bEnterY`, `bEnterZ`, `bExitX`, `bExitY`, `bExitZ`, `bBuyX`, `bBuyY`, `bBuyZ`, `bPrice`, `bLock`, `bType`, `bInt`, `bTypeID`, `bIcon`, `bBank`) VALUES
(1, 1, 'Jonathan_Anderson', 1352.42, -1759.25, 13.5078, -25.9097, -187.815, 1003.55, -29.3675, -184.934, 1003.55, 2500000, 0, 1, 17, 19132, 17, 5100),
(2, 1, 'Georg_Anderson', 1928.58, -1776.32, 13.5469, -25.9097, -187.815, 1003.55, -29.3675, -184.934, 1003.55, 2500000, 0, 1, 17, 19132, 17, 750);

-- --------------------------------------------------------

--
-- Table structure for table `console`
--

CREATE TABLE IF NOT EXISTS `console` (
`ID` int(11) NOT NULL,
  `CMD` varchar(200) COLLATE cp1251_bin NOT NULL,
  `Name` varchar(200) COLLATE cp1251_bin NOT NULL,
  `Recipient` varchar(200) COLLATE cp1251_bin NOT NULL,
  `Value` int(11) NOT NULL,
  `Data` varchar(200) COLLATE cp1251_bin NOT NULL,
  `Time` varchar(200) COLLATE cp1251_bin NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=cp1251 COLLATE=cp1251_bin;

--
-- Dumping data for table `console`
--

INSERT INTO `console` (`ID`, `CMD`, `Name`, `Recipient`, `Value`, `Data`, `Time`) VALUES
(1, '/makeadmin', 'Levan_Bedinashvili', 'Kurcaa_Solo', 3, '21/2/2023', '22:14'),
(2, '/makeadmin', 'Levan_Bedinashvili', 'Inoue_Takehiko', 3, '21/2/2023', '22:22'),
(3, '/makeadmin', 'Levan_Bedinashvili', 'Inoue_Takehiko', 5, '21/2/2023', '22:23'),
(4, '/makeadmin', 'Jonathan_Anderson', 'Davit_Ximenez', 6, '21/2/2023', '23:48'),
(5, '/givemoney', 'Davit_Ximenez', 'Davit_Ximenez', 150000, '21/2/2023', '23:57'),
(6, '/givemoney', 'Davit_Ximenez', 'Davit_Ximenez', -150000, '21/2/2023', '23:57'),
(7, '/givemoney', 'Davit_Ximenez', 'Davit_Ximenez', 150000, '21/2/2023', '23:58'),
(8, '/givemoney', 'Jonathan_Anderson', 'Jonathan_Anderson', 2500000, '22/2/2023', '7:59'),
(9, '/givemoney', 'Jonathan_Anderson', 'Jonathan_Anderson', 2500, '22/2/2023', '8:00'),
(10, '/givemoney', 'Davit_Ximenez', 'Davit_Ximenez', 100000000, '22/2/2023', '10:34'),
(11, '/givemoney', 'Jonathan_Anderson', 'Jonathan_Anderson', 500000, '22/2/2023', '11:30'),
(12, '/makeadmin', 'Levan_Bedinashvili', 'Davit_Ximenez', 6, '22/2/2023', '15:16'),
(13, '/givemoney', 'Davit_Ximenez', 'Davit_Ximenez', -100000000, '22/2/2023', '15:47'),
(14, '/givemoney', 'Davit_Ximenez', 'Lominadze_Manuchar', -1000000, '22/2/2023', '16:12'),
(15, '/givemoney', 'Davit_Ximenez', 'Lominadze_Manuchar', -1000000, '22/2/2023', '16:12'),
(16, '/givemoney', 'Davit_Ximenez', 'Lominadze_Manuchar', 1000000, '22/2/2023', '16:12'),
(17, '/givemoney', 'Davit_Ximenez', 'Lominadze_Manuchar', 1000000, '22/2/2023', '16:12'),
(18, '/makeadmin', 'Davit_Ximenez', 'Saint_Sebastian', 5, '22/2/2023', '17:51'),
(19, '/makeadmin', 'Davit_Ximenez', 'Saint_Sebastian', 6, '22/2/2023', '17:51'),
(20, '/givemoney', 'Saint_Sebastian', 'Saint_Sebastian', 1000000000, '22/2/2023', '18:01'),
(21, '/makeadmin', 'Davit_Ximenez', 'Georg_Anderson', 6, '22/2/2023', '21:36'),
(22, '/removeadmin', 'Georg_Anderson', 'Kurcaa_Solo', 0, '22/2/2023', '21:43'),
(23, '/makeadmin', 'Georg_Anderson', 'Kurcaa_Softeri', 2, '22/2/2023', '21:44'),
(24, '/makeadmin', 'Georg_Anderson', 'Kurcaa_Softeri', 3, '22/2/2023', '21:45'),
(25, '/givemoney', 'Georg_Anderson', 'Kurcaa_Softeri', 5000000, '22/2/2023', '21:46'),
(26, '/givemoney', 'Georg_Anderson', 'Inoue_Takehiko', 5000000, '22/2/2023', '21:46'),
(27, '/givemoney', 'Georg_Anderson', 'Georg_Anderson', 50000, '22/2/2023', '22:54'),
(28, '/givemoney', 'Georg_Anderson', 'Georg_Anderson', 5000000, '22/2/2023', '22:55'),
(29, '/givemoney', 'Levani_Bedinashvili', 'Levani_Bedinashvili', 300000, '23/2/2023', '23:43'),
(30, '/makeadmin', 'Jonathan_Anderson', 'Qeti_Hell', 1, '24/2/2023', '21:04'),
(31, '/makeadmin', 'Saint_Sebastian', 'Lorento_Memento', 4, '24/2/2023', '22:43'),
(32, '/givemoney', 'Georg_Anderson', 'Georg_Anderson', -2549300, '24/2/2023', '22:43'),
(33, '/givemoney', 'Saint_Sebastian', 'Lorento_Memento', 200000000, '24/2/2023', '22:55'),
(34, '/givemoney', 'Saint_Sebastian', 'Lorento_Memento', 1000000000, '24/2/2023', '22:55'),
(35, '/givemoney', 'Davit_Ximenez', 'Davit_Ximenez', 1, '25/2/2023', '14:25'),
(36, '/removeadmin', 'Levan_Bedinashvili', 'Davit_Ximenez', 0, '25/2/2023', '15:13'),
(37, '/givemoney', 'Saint_Sebastian', 'Saint_Sebastian', 500000, '25/2/2023', '19:19'),
(38, '/givemoney', 'Saint_Sebastian', 'Saint_Sebastian', 10000, '25/2/2023', '19:20'),
(39, '/givemoney', 'Saint_Sebastian', 'Saint_Sebastian', 10000, '25/2/2023', '19:20'),
(40, '/givemoney', 'Saint_Sebastian', 'Saint_Sebastian', 1000, '25/2/2023', '19:20'),
(41, '/givemoney', 'Saint_Sebastian', 'Saint_Sebastian', 1000, '25/2/2023', '19:20'),
(42, '/givemoney', 'Saint_Sebastian', 'Saint_Sebastian', 1000, '25/2/2023', '19:20'),
(43, '/givemoney', 'Saint_Sebastian', 'Saint_Sebastian', 1000, '25/2/2023', '19:20'),
(44, '/givemoney', 'Saint_Sebastian', 'Saint_Sebastian', 1000, '25/2/2023', '19:20'),
(45, '/givemoney', 'Saint_Sebastian', 'Saint_Sebastian', 100, '25/2/2023', '19:20'),
(46, '/givemoney', 'Saint_Sebastian', 'Saint_Sebastian', 100, '25/2/2023', '19:20'),
(47, '/givemoney', 'Saint_Sebastian', 'Saint_Sebastian', 100, '25/2/2023', '19:20'),
(48, '/givemoney', 'Saint_Sebastian', 'Saint_Sebastian', 100, '25/2/2023', '19:20'),
(49, '/givemoney', 'Saint_Sebastian', 'Saint_Sebastian', 100, '25/2/2023', '19:20'),
(50, '/givemoney', 'Saint_Sebastian', 'Saint_Sebastian', 100, '25/2/2023', '19:20'),
(51, '/givemoney', 'Saint_Sebastian', 'Saint_Sebastian', 99, '25/2/2023', '19:20'),
(52, '/makeadmin', 'Jonathan_Anderson', 'Davit_Ximenez', 6, '25/2/2023', '20:56'),
(53, '/givemoney', 'Georg_Anderson', 'Georg_Anderson', 400000, '25/2/2023', '21:19'),
(54, '/removeadmin', 'Jonathan_Anderson', 'Georg_Anderson', 0, '25/2/2023', '21:22'),
(55, '/makeadmin', 'Jonathan_Anderson', 'Georg_Anderson', 6, '25/2/2023', '21:44'),
(56, '/givemoney', 'Levan_Bedinashvili', 'Levan_Bedinashvili', -300000000, '26/2/2023', '1:45'),
(57, '/givemoney', 'Levan_Bedinashvili', 'Levan_Bedinashvili', -30000000, '26/2/2023', '1:45'),
(58, '/givemoney', 'Levan_Bedinashvili', 'Levan_Bedinashvili', 647710720, '26/2/2023', '1:46');

-- --------------------------------------------------------

--
-- Table structure for table `fractions`
--

CREATE TABLE IF NOT EXISTS `fractions` (
`wID` int(11) NOT NULL,
  `wAmmo` int(11) NOT NULL,
  `wBank` int(11) NOT NULL,
  `wDrug` int(11) NOT NULL,
  `wStatus` int(11) NOT NULL,
  `wInviteRank` int(11) NOT NULL,
  `wSkin1` int(11) NOT NULL,
  `wSkin2` int(11) NOT NULL,
  `wSkin3` int(11) NOT NULL,
  `wSkin4` int(11) NOT NULL,
  `wSkin5` int(11) NOT NULL,
  `wSkin6` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=cp1251 COLLATE=cp1251_bin;

--
-- Dumping data for table `fractions`
--

INSERT INTO `fractions` (`wID`, `wAmmo`, `wBank`, `wDrug`, `wStatus`, `wInviteRank`, `wSkin1`, `wSkin2`, `wSkin3`, `wSkin4`, `wSkin5`, `wSkin6`) VALUES
(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, 1000000, 30571220, 0, 1, 14, 280, 300, 305, 0, 0, 0),
(2, 0, 20370843, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(3, 0, 35679330, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(4, 0, 25473650, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(7, 999800, 2019809, 1000, 1, 8, 102, 103, 104, 0, 0, 0),
(8, 1000000, 2019364, 1000, 1, 8, 0, 0, 0, 0, 0, 0),
(9, 1000000, 2018851, 1000, 1, 8, 0, 0, 0, 0, 0, 0),
(10, 1000000, 2018480, 1000, 1, 5, 114, 115, 116, 0, 0, 0),
(11, 1000000, 2019940, 1000, 1, 7, 30, 173, 174, 175, 273, 0),
(12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `house`
--

CREATE TABLE IF NOT EXISTS `house` (
`hID` int(11) NOT NULL,
  `hOwned` int(11) NOT NULL,
  `hOwner` varchar(100) COLLATE cp1251_bin NOT NULL,
  `hEnterX` float NOT NULL,
  `hEnterY` float NOT NULL,
  `hEnterZ` float NOT NULL,
  `hExitX` float NOT NULL,
  `hExitY` float NOT NULL,
  `hExitZ` float NOT NULL,
  `hPrice` int(11) NOT NULL,
  `hLock` int(11) NOT NULL,
  `hClass` int(11) NOT NULL,
  `hInt` int(11) NOT NULL,
  `hSpawnX` float NOT NULL,
  `hSpawnY` float NOT NULL,
  `hSpawnZ` float NOT NULL,
  `hSpawnF` float NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=cp1251 COLLATE=cp1251_bin;

--
-- Dumping data for table `house`
--

INSERT INTO `house` (`hID`, `hOwned`, `hOwner`, `hEnterX`, `hEnterY`, `hEnterZ`, `hExitX`, `hExitY`, `hExitZ`, `hPrice`, `hLock`, `hClass`, `hInt`, `hSpawnX`, `hSpawnY`, `hSpawnZ`, `hSpawnF`) VALUES
(1, 0, 'The State', 1496.94, -687.894, 95.5633, 140.313, 1365.92, 1083.86, 500000, 0, 4, 5, 140.23, 1378.48, 1088.37, 180.168),
(2, 0, 'The State', 1527.79, -772.552, 80.5781, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061),
(3, 0, 'The State', 1535.03, -800.245, 72.8495, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061),
(4, 0, 'The State', 1540.47, -851.437, 64.3361, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061),
(5, 0, 'The State', 1468.52, -906.185, 54.8359, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061),
(6, 0, 'The State', 1421.86, -886.232, 50.6864, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061),
(7, 0, 'The State', 1411.19, -920.874, 38.4219, 2324.47, -1149.55, 1050.71, 400000, 1, 3, 12, 2324.34, -1136.53, 1051.3, 180.458),
(8, 0, 'The State', 1440.64, -926.133, 39.6477, 2324.47, -1149.55, 1050.71, 400000, 1, 3, 12, 2324.34, -1136.53, 1051.3, 180.458),
(9, 0, 'The State', 1332.08, -633.51, 109.135, 140.313, 1365.92, 1083.86, 500000, 1, 4, 5, 140.23, 1378.48, 1088.37, 180.168),
(10, 0, 'The State', 1094.99, -647.915, 113.648, 2324.47, -1149.55, 1050.71, 400000, 1, 3, 12, 2324.34, -1136.53, 1051.3, 180.458),
(11, 1, 'Georg_Anderson', 1045.16, -642.939, 120.117, 2324.47, -1149.55, 1050.71, 400000, 1, 3, 12, 2324.34, -1136.53, 1051.3, 180.458),
(12, 1, 'Jonathan_Anderson', 980.5, -677.256, 121.976, 140.313, 1365.92, 1083.86, 500000, 0, 4, 5, 140.23, 1378.48, 1088.37, 180.168),
(13, 0, 'The State', 946.345, -710.68, 122.62, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061),
(14, 0, 'The State', 897.869, -677.193, 116.89, 2324.47, -1149.55, 1050.71, 400000, 1, 3, 12, 2324.34, -1136.53, 1051.3, 180.458),
(15, 0, 'The State', 867.508, -717.587, 105.68, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061),
(16, 0, 'The State', 848.022, -745.544, 94.9693, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061),
(17, 0, 'The State', 891.201, -783.151, 101.314, 2324.47, -1149.55, 1050.71, 400000, 1, 3, 12, 2324.34, -1136.53, 1051.3, 180.458),
(18, 0, 'The State', 937.975, -848.663, 93.5774, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061),
(19, 0, 'The State', 923.887, -853.371, 93.4565, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061),
(20, 0, 'The State', 989.832, -828.639, 95.4686, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061),
(21, 0, 'The State', 977.434, -771.719, 112.203, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061),
(22, 0, 'The State', 1016.89, -763.362, 112.563, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061),
(23, 0, 'The State', 1034.86, -813.168, 101.852, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061),
(24, 0, 'The State', 827.728, -858.014, 70.3308, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061),
(25, 0, 'The State', 836.003, -894.889, 68.7689, 2324.47, -1149.55, 1050.71, 400000, 1, 3, 12, 2324.34, -1136.53, 1051.3, 180.458),
(26, 0, 'The State', 700.289, -1060.28, 49.4217, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061),
(27, 0, 'The State', 645.977, -1117.44, 44.207, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061),
(28, 0, 'The State', 558.803, -1161.07, 54.4297, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061),
(29, 0, 'The State', 497.446, -1095.07, 82.3592, 140.313, 1365.92, 1083.86, 500000, 1, 4, 5, 140.23, 1378.48, 1088.37, 180.168),
(30, 0, 'The State', 432.596, -1138.46, 73.7169, 2324.47, -1149.55, 1050.71, 400000, 1, 3, 12, 2324.34, -1136.53, 1051.3, 180.458),
(31, 0, 'The State', 416.769, -1154.12, 76.6876, 2324.47, -1149.55, 1050.71, 400000, 1, 3, 12, 2324.34, -1136.53, 1051.3, 180.458),
(32, 0, 'The State', 352.395, -1197.95, 76.5156, 2324.47, -1149.55, 1050.71, 400000, 1, 3, 12, 2324.34, -1136.53, 1051.3, 180.458),
(33, 1, 'Inoue_Takehiko', 300.238, -1154.45, 81.3904, 140.313, 1365.92, 1083.86, 500000, 1, 4, 5, 140.23, 1378.48, 1088.37, 180.168),
(34, 0, 'The State', 253.216, -1269.99, 74.4302, 140.313, 1365.92, 1083.86, 500000, 1, 4, 5, 140.23, 1378.48, 1088.37, 180.168),
(35, 0, 'The State', 219.244, -1249.8, 78.3364, 140.313, 1365.92, 1083.86, 500000, 1, 4, 5, 140.23, 1378.48, 1088.37, 180.168),
(36, 0, 'The State', 298.853, -1338.5, 53.4415, 2324.47, -1149.55, 1050.71, 400000, 1, 3, 12, 2324.34, -1136.53, 1051.3, 180.458),
(37, 1, 'Saint_Sebastian', 254.346, -1367.08, 53.1094, 2324.47, -1149.55, 1050.71, 400000, 1, 3, 12, 2324.34, -1136.53, 1051.3, 180.458),
(38, 0, 'The State', 398.127, -1271.39, 50.0198, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061),
(39, 0, 'The State', 552.975, -1200.27, 44.8315, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061),
(40, 1, 'Levani_Bedinashvili', 1684.9, -2098.16, 13.8343, 422.573, 2536.49, 10, 150000, 0, 1, 10, 416.93, 2536.62, 10, 272.892),
(41, 0, 'The State', 2168.91, -1815.23, 13.5469, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892),
(42, 0, 'The State', 2155.88, -1815.23, 13.5469, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892),
(43, 1, 'Davit_Ximenez', 2151.05, -1807.95, 13.5464, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892),
(44, 0, 'The State', 2151.04, -1789.24, 13.5093, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892),
(45, 0, 'The State', 2146.52, -1808.4, 16.1406, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892),
(46, 0, 'The State', 2146.47, -1815.03, 16.1406, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892),
(47, 0, 'The State', 2151.96, -1819.7, 16.1406, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892),
(48, 0, 'The State', 2158.29, -1819.7, 16.1406, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892),
(49, 0, 'The State', 2164.85, -1819.62, 16.1406, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892),
(50, 0, 'The State', 2172.39, -1819.7, 16.1406, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892),
(51, 0, 'The State', 2140.93, -1801.92, 16.1475, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892),
(52, 0, 'The State', 2145, -1801.77, 16.1406, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892),
(53, 0, 'The State', 2162.67, -1815.23, 13.5469, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892),
(54, 0, 'The State', 2176.25, -1815.23, 13.5469, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892),
(55, 0, 'The State', 2151.04, -1815.01, 13.5498, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892),
(56, 0, 'The State', 2185.8, -1815.23, 13.5469, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892),
(57, 0, 'The State', 2192.37, -1815.23, 13.5469, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
 ADD PRIMARY KEY (`pID`);

--
-- Indexes for table `business`
--
ALTER TABLE `business`
 ADD PRIMARY KEY (`bID`);

--
-- Indexes for table `console`
--
ALTER TABLE `console`
 ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `fractions`
--
ALTER TABLE `fractions`
 ADD PRIMARY KEY (`wID`);

--
-- Indexes for table `house`
--
ALTER TABLE `house`
 ADD PRIMARY KEY (`hID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
MODIFY `pID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `business`
--
ALTER TABLE `business`
MODIFY `bID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `console`
--
ALTER TABLE `console`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=59;
--
-- AUTO_INCREMENT for table `fractions`
--
ALTER TABLE `fractions`
MODIFY `wID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `house`
--
ALTER TABLE `house`
MODIFY `hID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=58;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
