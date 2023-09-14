-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 14, 2023 at 12:28 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `zero`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `pID` int(11) NOT NULL,
  `pName` varchar(100) NOT NULL,
  `pPassword` varchar(32) NOT NULL,
  `pMail` varchar(64) NOT NULL,
  `pSex` int(11) NOT NULL,
  `pSkin` int(11) NOT NULL,
  `pCash` int(11) NOT NULL,
  `pLevel` int(11) NOT NULL,
  `pAdmin` int(11) NOT NULL,
  `pDostup` varchar(32) NOT NULL,
  `pHouse` int(11) NOT NULL,
  `pCars` int(11) NOT NULL,
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
  `pBank` int(11) NOT NULL,
  `pBan` int(11) NOT NULL,
  `pBanDay` int(11) NOT NULL,
  `pBanMounth` int(11) NOT NULL,
  `pIP` varchar(128) NOT NULL,
  `pRegIP` varchar(128) NOT NULL,
  `pJailed` int(11) NOT NULL,
  `pJailTime` int(11) NOT NULL,
  `pWantedLevel` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251 COLLATE=cp1251_bin ROW_FORMAT=COMPACT;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`pID`, `pName`, `pPassword`, `pMail`, `pSex`, `pSkin`, `pCash`, `pLevel`, `pAdmin`, `pDostup`, `pHouse`, `pCars`, `pQuest1`, `pQuest2`, `pQuest3`, `pLeader`, `pMember`, `pForma`, `pRank`, `pAdminLogin`, `pBizz`, `pClock`, `pMobile`, `pMute`, `pMuteTime`, `pExp1`, `pExp2`, `pBank`, `pBan`, `pBanDay`, `pBanMounth`, `pIP`, `pRegIP`, `pJailed`, `pJailTime`, `pWantedLevel`) VALUES
(48, 'Bedinashvili_Levani', 'levani2004', 'levanibedinashvili03@gmail.com', 1, 208, 10868852, 3, 10, '1234', 8, 0, 1, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 4, 8, 0, 0, 0, 0, '192.168.229.101', '192.168.208.13', 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `banip`
--

CREATE TABLE `banip` (
  `banID` int(11) NOT NULL,
  `IP` varchar(128) NOT NULL,
  `BanDay` int(11) NOT NULL,
  `AdminName` varchar(128) NOT NULL,
  `BanTime` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251 COLLATE=cp1251_bin;

-- --------------------------------------------------------

--
-- Table structure for table `banlog`
--

CREATE TABLE `banlog` (
  `ID` int(11) NOT NULL,
  `Text` varchar(255) NOT NULL,
  `Name` varchar(128) NOT NULL,
  `NameAdmin` varchar(128) NOT NULL,
  `Date` varchar(128) NOT NULL,
  `Day` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bizz`
--

CREATE TABLE `bizz` (
  `bID` int(11) NOT NULL,
  `bOwned` int(11) NOT NULL,
  `bOwner` varchar(32) NOT NULL,
  `bMessage` varchar(64) NOT NULL,
  `bEntranceX` float NOT NULL,
  `bEntranceY` float NOT NULL,
  `bEntranceZ` float NOT NULL,
  `bExitX` float NOT NULL,
  `bExitY` float NOT NULL,
  `bExitZ` float NOT NULL,
  `bBuyPrice` int(11) NOT NULL,
  `bEntranceCost` int(11) NOT NULL,
  `bTill` int(11) NOT NULL,
  `bLocked` int(11) NOT NULL,
  `bInterior` int(11) NOT NULL,
  `bProducts` int(11) NOT NULL,
  `bPrice` int(11) NOT NULL,
  `bBarX` float NOT NULL,
  `bBarY` float NOT NULL,
  `bBarZ` float NOT NULL,
  `bMafia` int(11) NOT NULL,
  `bType` int(11) NOT NULL,
  `bLockTime` int(11) NOT NULL,
  `bVirtualWorld` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `bizz`
--

INSERT INTO `bizz` (`bID`, `bOwned`, `bOwner`, `bMessage`, `bEntranceX`, `bEntranceY`, `bEntranceZ`, `bExitX`, `bExitY`, `bExitZ`, `bBuyPrice`, `bEntranceCost`, `bTill`, `bLocked`, `bInterior`, `bProducts`, `bPrice`, `bBarX`, `bBarY`, `bBarZ`, `bMafia`, `bType`, `bLockTime`, `bVirtualWorld`) VALUES
(1, 0, 'The State', 'Alhambra', 1836.51, -1682.58, 13.345, 493.487, -24.9609, 1000.67, 500000, 100, 0, 1, 17, 0, 100, 499.97, -20.7076, 1000.68, 14, 1, 0, 1),
(2, 0, 'The State', 'PigPen', 2421.59, -1219.51, 25.5444, 1204.67, -13.8521, 1000.92, 100000, 100, 0, 1, 2, 0, 100, 1215.29, -13.2987, 1000.92, 14, 1, 0, 2),
(3, 0, 'The State', 'Misty Club', -2242.2, -88.0869, 35.3203, 1212.05, -25.8763, 1000.95, 100000, 100, 0, 1, 3, 0, 100, 1207.24, -29.434, 1000.95, 14, 1, 0, 3),
(4, 0, 'The State', 'Casino Adjara', 1022.58, -1121.42, 23.8723, 1133.22, -15.8324, 1000.68, 1000000, 100, 0, 1, 12, 0, 100, 1139.72, -4.90998, 1000.67, 6, 1, 0, 4),
(5, 0, 'The State', 'Grove Street Bar', 2309.95, -1643.42, 14.8269, 501.903, -67.563, 998.758, 100000, 100, 0, 1, 11, 0, 100, 497.353, -76.0409, 998.758, 14, 1, 0, 5),
(6, 0, 'The State', 'Sobrino de Botin', 2269.86, -74.1605, 26.7723, -795.082, 489.282, 1376.2, 100000, 100, 0, 1, 1, 0, 100, -785.496, 500.074, 1371.74, 0, 2, 0, 6),
(7, 0, 'The State', 'Vinewood Burger', 1199.18, -918.168, 43.1236, 362.919, -75.207, 1001.51, 100000, 9999, 0, 1, 10, 0, 5000, 377.075, -67.4374, 1001.51, 5, 2, 0, 7),
(8, 0, 'The State', 'Marina Burger', 810.492, -1616.15, 13.5468, 460.557, -88.594, 999.555, 100000, 100, 0, 1, 4, 0, 100, 450.445, -83.6521, 999.555, 6, 2, 0, 8),
(9, 0, 'The State', 'Idlewood Pizza', 2105.48, -1806.37, 13.5546, 372.36, -133.521, 1001.49, 100000, 100, 0, 1, 5, 0, 100, 375.888, -118.817, 1001.5, 14, 2, 0, 9),
(10, 0, 'The State', 'Downtown Cluc', -1816.64, 618.672, 35.1719, 366.126, -9.0925, 1001.85, 100000, 100, 0, 1, 9, 0, 100, 369.924, -6.01969, 1001.86, 14, 2, 0, 10),
(11, 0, 'The State', 'Subway', 928.914, -1352.79, 13.3437, 377.166, -192.987, 1000.64, 100000, 100, 0, 1, 17, 0, 100, 379.239, -187.858, 1000.63, 5, 2, 0, 11),
(12, 0, 'The State', 'Idelwood 24/7', 1928.6, -1776.17, 13.5468, -2240.47, 137.06, 1035.41, 300000, 100, 0, 1, 6, 0, 100, -2236.11, 130.158, 1035.41, 5, 3, 0, 12),
(13, 0, 'The State', 'Fresko', 1315.47, -897.682, 39.5781, -2240.47, 137.06, 1035.41, 250000, 100, 0, 1, 6, 0, 1000, -2236.11, 130.158, 1035.41, 14, 3, 0, 13),
(14, 0, 'The State', 'MiniMarket', 1833.78, -1842.6, 13.5781, -2240.47, 137.06, 1035.41, 100000, 100, 0, 1, 6, 0, 100, -2236.11, 130.158, 1035.41, 6, 3, 0, 14),
(15, 0, 'The State', 'Mullholand 24/7', 1000.59, -919.911, 42.328, -2240.47, 137.06, 1035.41, 100000, 100, 0, 1, 6, 0, 100, -2236.11, 130.158, 1035.41, 6, 3, 0, 15),
(16, 0, 'The State', 'Jizzy', -2624.49, 1411.88, 7.0938, -2636.61, 1404.99, 906.461, 100000, 100, 0, 1, 3, 0, 100, -2654.02, 1407.91, 906.277, 14, 1, 0, 16),
(17, 0, 'The State', 'Redsands West 24/7', 1599.12, 2221.87, 11.0625, -2240.47, 137.06, 1035.41, 100000, 100, 0, 1, 6, 0, 100, -2236.11, 130.158, 1035.41, 0, 3, 0, 17),
(18, 0, 'The State', 'Smart', 2481.59, -1758.02, 13.5469, -2240.47, 137.06, 1035.41, 100000, 100, 0, 1, 6, 0, 100, -2236.11, 130.158, 1035.41, 5, 3, 0, 18),
(19, 0, 'The State', 'Night Bar', 2348.56, -1372.68, 24.3984, -227.028, 1401.23, 27.7656, 100000, 100, 0, 1, 18, 0, 100, -229.294, 1401.21, 27.7656, 14, 1, 0, 19),
(20, 0, 'The State', 'Idelwood Gas', 1940.93, -1772.94, 13.6406, 0, 0, 0, 100000, 100, 0, 1, 0, 0, 5000, 0, 0, 0, 14, 4, 0, 20),
(21, 0, 'The State', 'Mullholand Gas', 1003.76, -936.11, 42.3281, 0, 0, 0, 100000, 100, 0, 1, 0, 0, 10000, 0, 0, 0, 6, 4, 0, 21),
(22, 0, 'The State', 'Nikora', 1352.35, -1759.25, 13.5078, -2240.47, 137.06, 1035.41, 100000, 100, 0, 1, 6, 0, 100, -2236.11, 130.158, 1035.41, 5, 3, 0, 22);

-- --------------------------------------------------------

--
-- Table structure for table `business`
--

CREATE TABLE `business` (
  `bID` int(11) NOT NULL,
  `bOwned` int(11) NOT NULL,
  `bOwner` varchar(100) NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=cp1251 COLLATE=cp1251_bin;

--
-- Dumping data for table `business`
--

INSERT INTO `business` (`bID`, `bOwned`, `bOwner`, `bEnterX`, `bEnterY`, `bEnterZ`, `bExitX`, `bExitY`, `bExitZ`, `bBuyX`, `bBuyY`, `bBuyZ`, `bPrice`, `bLock`, `bType`, `bInt`, `bTypeID`, `bIcon`, `bBank`) VALUES
(1, 0, 'The State', 1352.42, -1759.25, 13.5078, -25.9097, -187.815, 1003.55, -29.3675, -184.934, 1003.55, 2500000, 0, 1, 17, 19132, 17, 5100),
(2, 0, 'The State', 1928.58, -1776.32, 13.5469, -25.9097, -187.815, 1003.55, -29.3675, -184.934, 1003.55, 2500000, 1, 1, 17, 19132, 17, 750),
(3, 1, 'Bedinashvili_Levani', 2244.4, -1665.42, 15.4766, 226.861, -8.1114, 1002.21, 206.13, -3.7327, 1001.21, 4500000, 1, 2, 5, 19132, 45, 2750),
(4, 1, 'Irakli_Chinchaladze', 461.338, -1500.84, 31.0597, 226.861, -8.1114, 1002.21, 206.13, -3.7327, 1001.21, 4500000, 0, 2, 5, 19132, 45, 2267);

-- --------------------------------------------------------

--
-- Table structure for table `cars`
--

CREATE TABLE `cars` (
  `ID` int(11) NOT NULL,
  `Model` int(11) NOT NULL,
  `Color_1` int(11) NOT NULL,
  `Color_2` int(11) NOT NULL,
  `Owner` varchar(24) NOT NULL,
  `Spoiler` int(11) NOT NULL,
  `Hood` int(11) NOT NULL,
  `Sides` int(11) NOT NULL,
  `Nitro` int(11) NOT NULL,
  `Lamps` int(11) NOT NULL,
  `Exhaust` int(11) NOT NULL,
  `Wheels` int(11) NOT NULL,
  `Roof` int(11) NOT NULL,
  `Hydraulics` int(11) NOT NULL,
  `Bullbar` int(11) NOT NULL,
  `RBullbars` int(11) NOT NULL,
  `FSign` int(11) NOT NULL,
  `FBullbars` int(11) NOT NULL,
  `FBumper` int(11) NOT NULL,
  `RBumper` int(11) NOT NULL,
  `Vents` int(11) NOT NULL,
  `PaintJob` int(11) NOT NULL,
  `Interior` int(11) NOT NULL,
  `VirtualWorld` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `cars`
--

INSERT INTO `cars` (`ID`, `Model`, `Color_1`, `Color_2`, `Owner`, `Spoiler`, `Hood`, `Sides`, `Nitro`, `Lamps`, `Exhaust`, `Wheels`, `Roof`, `Hydraulics`, `Bullbar`, `RBullbars`, `FSign`, `FBullbars`, `FBumper`, `RBumper`, `Vents`, `PaintJob`, `Interior`, `VirtualWorld`) VALUES
(11, 567, 0, 0, 'Bedinashvili_Levani', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10, 415, 0, 0, 'Bedinashvili_Levani', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(9, 415, 0, 0, 'Bedinashvili_Levani', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(8, 541, 0, 0, 'Bedinashvili_Levani', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(7, 451, 0, 0, 'Bedinashvili_Levani', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(12, 411, 0, 0, 'Bedinashvili_Levani', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(13, 434, 0, 0, 'Bedinashvili_Levani', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(14, 429, 0, 0, 'Bedinashvili_Levani', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(15, 494, 0, 0, 'Bedinashvili_Levani', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(16, 400, 0, 0, 'Bedinashvili_Levani', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(17, 402, 0, 0, 'Bedinashvili_Levani', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(18, 411, 0, 0, 'Bedinashvili_Levani', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(19, 434, 0, 0, 'Bedinashvili_Levani', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20, 429, 0, 0, 'Bedinashvili_Levani', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(21, 494, 0, 0, 'Bedinashvili_Levani', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(22, 400, 0, 0, 'Bedinashvili_Levani', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(23, 402, 0, 0, 'Bedinashvili_Levani', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `cmds`
--

CREATE TABLE `cmds` (
  `Name` varchar(45) CHARACTER SET cp1251 COLLATE cp1251_bin NOT NULL,
  `CMD` varchar(45) CHARACTER SET cp1251 COLLATE cp1251_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cmds`
--

INSERT INTO `cmds` (`Name`, `CMD`) VALUES
('San_Carolina', 'mafialeader'),
('Extraz_Uzikiwe', 'gangleader'),
('Serj_Anderson', 'otherleader'),
('Jeez_Sweazy ', 'makehelper');

-- --------------------------------------------------------

--
-- Table structure for table `console`
--

CREATE TABLE `console` (
  `ID` int(11) NOT NULL,
  `CMD` varchar(200) NOT NULL,
  `Name` varchar(200) NOT NULL,
  `Recipient` varchar(200) NOT NULL,
  `Value` int(11) NOT NULL,
  `Data` varchar(200) NOT NULL,
  `Time` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251 COLLATE=cp1251_bin;

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
(58, '/givemoney', 'Levan_Bedinashvili', 'Levan_Bedinashvili', 647710720, '26/2/2023', '1:46'),
(59, '/makeadmin', 'Jonathan_Anderson', 'Nika_Cxoidze', 6, '26/2/2023', '12:35'),
(60, '/givemoney', 'Nika_Cxoidze', 'Nika_Cxoidze', 100000, '26/2/2023', '12:45'),
(61, '/makeadmin', 'Bedinashvili_Levani', 'Nika_Cxoidze', 6, '26/2/2023', '13:15'),
(62, '/givemoney', 'Nika_Cxoidze', 'Nika_Cxoidze', 100000, '26/2/2023', '13:31'),
(63, '/makeadmin', 'Jonathan_Anderson', 'Nick_Gustin', 3, '26/2/2023', '21:13'),
(64, '/makeadmin', 'Jonathan_Anderson', 'Smoke_Rivero', 2, '27/2/2023', '12:21'),
(65, '/makeadmin', 'Georg_Anderson', 'Zarbo_Ox', 3, '28/2/2023', '20:23'),
(66, '/givemoney', 'Georg_Anderson', 'Zarbo_Ox', 1000000, '28/2/2023', '20:27'),
(67, '/givemoney', 'Georg_Anderson', 'Nick_Gustin', 1000000, '28/2/2023', '20:29'),
(68, '/givemoney', 'Georg_Anderson', 'Nick_Gustin', 2000000, '28/2/2023', '20:45'),
(69, '/givemoney', 'Jonathan_Anderson', 'Jonathan_Anderson', 5000000, '1/3/2023', '12:44'),
(70, '/givemoney', 'Levan_Bedinashvili', 'Levan_Bedinashvili', 300000, '1/3/2023', '13:34'),
(71, '/makeadmin', 'Jonathan_Anderson', 'Georg_Anderson', 6, '1/3/2023', '19:56'),
(72, '/makeadmin', 'Georg_Anderson', 'Luka_Calipso', 1, '1/3/2023', '19:56'),
(73, '/makeadmin', 'Jonathan_Anderson', 'Luka_Calipso', 1, '1/3/2023', '19:57'),
(74, '/givemoney', 'Jonathan_Anderson', 'Jonathan_Anderson', 80000, '1/3/2023', '20:00'),
(75, '/givemoney', 'Jonathan_Anderson', 'Jonathan_Anderson', 800000, '1/3/2023', '20:00'),
(76, '/givemoney', 'Georg_Anderson', 'Georg_Anderson', 10000, '1/3/2023', '20:07'),
(77, '/givemoney', 'Georg_Anderson', 'Georg_Anderson', 10000000, '1/3/2023', '20:07'),
(78, '/makeadmin', 'Georg_Anderson', 'Lorento_Memento', 5, '1/3/2023', '20:39'),
(79, '/givemoney', 'Lorento_Memento', 'Lorento_Memento', 50000000, '1/3/2023', '20:39'),
(80, '/makeadmin', 'Georg_Anderson', 'Irakli_Yancha', 1, '1/3/2023', '21:00'),
(81, '/makeadmin', 'Georg_Anderson', 'Irakli_Yancha', 1, '1/3/2023', '21:00'),
(82, '/makeadmin', 'Georg_Anderson', 'Saba_Chitinashvili', 1, '1/3/2023', '21:02'),
(83, '/makeadmin', 'Georg_Anderson', 'Beqa_Beriashvili', 1, '1/3/2023', '21:06'),
(84, '/makeadmin', 'Georg_Anderson', 'Gio_Chitinashvili', 1, '1/3/2023', '21:07'),
(85, '/makeadmin', 'Georg_Anderson', 'Beqa_Beriashvili', 1, '1/3/2023', '21:09'),
(86, '/removeadmin', 'Georg_Anderson', 'Beqa_Beriashvili', 0, '1/3/2023', '21:12'),
(87, '/makeadmin', 'Georg_Anderson', 'Beqa_Beriashvili', 1, '1/3/2023', '21:13'),
(88, '/makeadmin', 'Georg_Anderson', 'Krolik_Dalbaiob', 1, '1/3/2023', '21:23'),
(89, '/givemoney', 'Georg_Anderson', 'Irakli_Yancha', 1000000, '1/3/2023', '21:39'),
(90, '/givemoney', 'Georg_Anderson', 'Saba_Chitinashvili', 1000000, '1/3/2023', '21:39'),
(91, '/givemoney', 'Georg_Anderson', 'Beqa_Beriashvili', 1000000, '1/3/2023', '21:39'),
(92, '/givemoney', 'Georg_Anderson', 'Gio_Chitinashvili', 1000000, '1/3/2023', '21:40'),
(93, '/givemoney', 'Georg_Anderson', 'Krolik_Dalbaiob', 1000000, '1/3/2023', '21:40'),
(94, '/givemoney', 'Georg_Anderson', 'Beqa_Beriashvili', 400000, '1/3/2023', '21:59'),
(95, '/givemoney', 'Georg_Anderson', 'Beqa_Beriashvili', 500000, '1/3/2023', '22:00'),
(96, '/makeadmin', 'Jonathan_Anderson', 'Saba_Mukbaniani', 6, '1/3/2023', '22:29'),
(97, '/makeadmin', 'Jonathan_Anderson', 'Kevin_Destiny', 4, '1/3/2023', '22:31'),
(98, '/givemoney', 'Saba_Mukbaniani', 'Saba_Mukbaniani', 0, '1/3/2023', '23:07'),
(99, '/givemoney', 'Saba_Mukbaniani', 'Saba_Mukbaniani', -1000, '1/3/2023', '23:07'),
(100, '/givemoney', 'Saba_Mukbaniani', 'Saba_Mukbaniani', 999999999, '1/3/2023', '23:07'),
(101, '/givemoney', 'Irakli_Chinchaladze', 'Irakli_Chinchaladze', 250000000, '2/3/2023', '10:36'),
(102, '/removeadmin', 'Saba_Mukbaniani', 'Gio_Chitinashvili', 0, '2/3/2023', '18:23'),
(103, '/givemoney', 'Bedinashvili_Levani', 'Bedinashvili_Levani', 1000000, '9/9/2023', '21:42'),
(104, '/givemoney', 'Bedinashvili_Levani', 'Bedinashvili_Levani', 1000000, '9/9/2023', '21:42'),
(105, '/givemoney', 'Bedinashvili_Levani', 'Bedinashvili_Levani', 1000000, '9/9/2023', '21:42'),
(106, '/givemoney', 'Bedinashvili_Levani', 'Bedinashvili_Levani', 1000000, '9/9/2023', '21:42'),
(107, '/givemoney', 'Bedinashvili_Levani', 'Bedinashvili_Levani', 1000000, '9/9/2023', '21:42'),
(108, '/givemoney', 'Bedinashvili_Levani', 'Bedinashvili_Levani', 1000000, '9/9/2023', '21:42'),
(109, '/givemoney', 'Bedinashvili_Levani', 'Bedinashvili_Levani', 100000, '11/9/2023', '1:45'),
(110, '/givemoney', 'Bedinashvili_Levani', 'Bedinashvili_Levani', 10000000, '11/9/2023', '1:45');

-- --------------------------------------------------------

--
-- Table structure for table `fractions`
--

CREATE TABLE `fractions` (
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
) ENGINE=InnoDB DEFAULT CHARSET=cp1251 COLLATE=cp1251_bin;

--
-- Dumping data for table `fractions`
--

INSERT INTO `fractions` (`wID`, `wAmmo`, `wBank`, `wDrug`, `wStatus`, `wInviteRank`, `wSkin1`, `wSkin2`, `wSkin3`, `wSkin4`, `wSkin5`, `wSkin6`) VALUES
(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, 100000, 36570056, 0, 1, 14, 280, 300, 305, 0, 0, 0),
(2, 1000000, 24369182, 0, 0, 8, 0, 0, 0, 0, 0, 0),
(3, 1000000, 42671031, 0, 0, 8, 0, 0, 0, 0, 0, 0),
(4, 1000000, 30468972, 0, 0, 8, 0, 0, 0, 0, 0, 0),
(5, 1000000, 2409046, 0, 1, 8, 290, 294, 214, 299, 296, 0),
(6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(7, 998800, 2411569, 1000, 1, 8, 102, 103, 104, 0, 0, 0),
(8, 999700, 2412776, 1000, 1, 8, 0, 0, 0, 0, 0, 0),
(9, 999700, 2412760, 1000, 1, 8, 0, 0, 0, 0, 0, 0),
(10, 1000000, 2408535, 1000, 1, 5, 114, 115, 116, 0, 0, 0),
(11, 1000000, 2408820, 1000, 1, 7, 30, 173, 174, 175, 273, 0),
(12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `frakbank`
--

CREATE TABLE `frakbank` (
  `FracBank[0][fLsnews]` int(11) NOT NULL,
  `FracBank[0][fBallas]` int(11) NOT NULL,
  `FracBank[0][fVagos]` int(11) NOT NULL,
  `FracBank[0][fGrove]` int(11) NOT NULL,
  `FracBank[0][fAztek]` int(11) NOT NULL,
  `FracBank[0][fRifa]` int(11) NOT NULL,
  `FracBank[0][fKazna]` int(11) NOT NULL,
  `FracBank[0][nLcn]` int(11) NOT NULL,
  `FracBank[0][nYakuza]` int(11) NOT NULL,
  `FracBank[0][nRm]` int(11) NOT NULL,
  `ballasnark` int(11) NOT NULL,
  `groovnark` int(11) NOT NULL,
  `vagosnark` int(11) NOT NULL,
  `azteknark` int(11) NOT NULL,
  `rifanark` int(11) NOT NULL,
  `healpric` int(11) NOT NULL,
  `addd[0]` int(11) NOT NULL,
  `addd[1]` int(11) NOT NULL,
  `addd[2]` int(11) NOT NULL,
  `guns` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `frakbank`
--

INSERT INTO `frakbank` (`FracBank[0][fLsnews]`, `FracBank[0][fBallas]`, `FracBank[0][fVagos]`, `FracBank[0][fGrove]`, `FracBank[0][fAztek]`, `FracBank[0][fRifa]`, `FracBank[0][fKazna]`, `FracBank[0][nLcn]`, `FracBank[0][nYakuza]`, `FracBank[0][nRm]`, `ballasnark`, `groovnark`, `vagosnark`, `azteknark`, `rifanark`, `healpric`, `addd[0]`, `addd[1]`, `addd[2]`, `guns`) VALUES
(0, 153000, 202200, 122000, 134800, 183600, 0, 25000, 25000, 25000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 60);

-- --------------------------------------------------------

--
-- Table structure for table `frakmats`
--

CREATE TABLE `frakmats` (
  `lsamatbi` int(11) NOT NULL,
  `armmatbi` int(11) NOT NULL,
  `rifamatbi` int(11) NOT NULL,
  `ballasmatbi` int(11) NOT NULL,
  `aztekmatbi` int(11) NOT NULL,
  `vagosmatbi` int(11) NOT NULL,
  `groovmatbi` int(11) NOT NULL,
  `lspdmatbi` int(11) NOT NULL,
  `fbimats` int(11) NOT NULL,
  `yakuzamats` int(11) NOT NULL,
  `rmmats` int(11) NOT NULL,
  `lcnmats` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `frakmats`
--

INSERT INTO `frakmats` (`lsamatbi`, `armmatbi`, `rifamatbi`, `ballasmatbi`, `aztekmatbi`, `vagosmatbi`, `groovmatbi`, `lspdmatbi`, `fbimats`, `yakuzamats`, `rmmats`, `lcnmats`) VALUES
(90000, 300000, 50000, 49500, 50000, 50000, 50000, 50000, 49900, 50000, 50000, 50000);

-- --------------------------------------------------------

--
-- Table structure for table `house`
--

CREATE TABLE `house` (
  `hID` int(11) NOT NULL,
  `hOwned` int(11) NOT NULL,
  `hOwner` varchar(100) NOT NULL,
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
  `hSpawnF` float NOT NULL,
  `hGarage` int(11) NOT NULL,
  `hCarx` float NOT NULL,
  `hCary` float NOT NULL,
  `hCarz` float NOT NULL,
  `hCarc` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251 COLLATE=cp1251_bin;

--
-- Dumping data for table `house`
--

INSERT INTO `house` (`hID`, `hOwned`, `hOwner`, `hEnterX`, `hEnterY`, `hEnterZ`, `hExitX`, `hExitY`, `hExitZ`, `hPrice`, `hLock`, `hClass`, `hInt`, `hSpawnX`, `hSpawnY`, `hSpawnZ`, `hSpawnF`, `hGarage`, `hCarx`, `hCary`, `hCarz`, `hCarc`) VALUES
(1, 1, 'Nick_Gustin', 1496.94, -687.894, 95.5633, 140.313, 1365.92, 1083.86, 500000, 1, 4, 5, 140.23, 1378.48, 1088.37, 180.168, 0, 0, 0, 0, 0),
(2, 0, 'The State', 1527.79, -772.552, 80.5781, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061, 0, 0, 0, 0, 0),
(3, 0, 'The State', 1535.03, -800.245, 72.8495, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061, 0, 0, 0, 0, 0),
(4, 0, 'The State', 1540.47, -851.437, 64.3361, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061, 0, 0, 0, 0, 0),
(5, 0, 'The State', 1468.52, -906.185, 54.8359, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061, 0, 0, 0, 0, 0),
(6, 0, 'The State', 1421.86, -886.232, 50.6864, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061, 0, 0, 0, 0, 0),
(7, 0, 'The State', 1411.19, -920.874, 38.4219, 2324.47, -1149.55, 1050.71, 400000, 1, 3, 12, 2324.34, -1136.53, 1051.3, 180.458, 0, 0, 0, 0, 0),
(8, 0, 'The State', 1440.64, -926.133, 39.6477, 2324.47, -1149.55, 1050.71, 400000, 1, 3, 12, 2324.34, -1136.53, 1051.3, 180.458, 0, 0, 0, 0, 0),
(9, 1, 'Bedinashvili_Levani', 1332.08, -633.51, 109.135, 140.313, 1365.92, 1083.86, 500000, 1, 4, 5, 140.23, 1378.48, 1088.37, 180.168, 1, 1334.23, -626.085, 109.135, 286.366),
(10, 1, 'Gio_Chitinashvili', 1094.99, -647.915, 113.648, 2324.47, -1149.55, 1050.71, 400000, 1, 3, 12, 2324.34, -1136.53, 1051.3, 180.458, 0, 0, 0, 0, 0),
(11, 0, 'The State', 1045.16, -642.939, 120.117, 2324.47, -1149.55, 1050.71, 400000, 0, 3, 12, 2324.34, -1136.53, 1051.3, 180.458, 1, 1040.65, -632.434, 119.991, 290.833),
(12, 1, 'Krolik_Dalbaiob', 980.5, -677.256, 121.976, 140.313, 1365.92, 1083.86, 500000, 1, 4, 5, 140.23, 1378.48, 1088.37, 180.168, 0, 0, 0, 0, 0),
(13, 0, 'The State', 946.345, -710.68, 122.62, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061, 0, 0, 0, 0, 0),
(14, 0, 'The State', 897.869, -677.193, 116.89, 2324.47, -1149.55, 1050.71, 400000, 1, 3, 12, 2324.34, -1136.53, 1051.3, 180.458, 0, 0, 0, 0, 0),
(15, 0, 'The State', 867.508, -717.587, 105.68, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061, 0, 0, 0, 0, 0),
(16, 0, 'The State', 848.022, -745.544, 94.9693, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061, 0, 0, 0, 0, 0),
(17, 0, 'The State', 891.201, -783.151, 101.314, 2324.47, -1149.55, 1050.71, 400000, 1, 3, 12, 2324.34, -1136.53, 1051.3, 180.458, 0, 0, 0, 0, 0),
(18, 0, 'The State', 937.975, -848.663, 93.5774, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061, 0, 0, 0, 0, 0),
(19, 0, 'The State', 923.887, -853.371, 93.4565, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061, 0, 0, 0, 0, 0),
(20, 0, 'The State', 989.832, -828.639, 95.4686, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061, 0, 0, 0, 0, 0),
(21, 0, 'The State', 977.434, -771.719, 112.203, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061, 0, 0, 0, 0, 0),
(22, 0, 'The State', 1016.89, -763.362, 112.563, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061, 0, 0, 0, 0, 0),
(23, 0, 'The State', 1034.86, -813.168, 101.852, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061, 0, 0, 0, 0, 0),
(24, 0, 'The State', 827.728, -858.014, 70.3308, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061, 0, 0, 0, 0, 0),
(25, 0, 'The State', 836.003, -894.889, 68.7689, 2324.47, -1149.55, 1050.71, 400000, 1, 3, 12, 2324.34, -1136.53, 1051.3, 180.458, 0, 0, 0, 0, 0),
(26, 0, 'The State', 700.289, -1060.28, 49.4217, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061, 0, 0, 0, 0, 0),
(27, 0, 'The State', 645.977, -1117.44, 44.207, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061, 0, 0, 0, 0, 0),
(28, 0, 'The State', 558.803, -1161.07, 54.4297, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061, 0, 0, 0, 0, 0),
(29, 0, 'The State', 497.446, -1095.07, 82.3592, 140.313, 1365.92, 1083.86, 500000, 1, 4, 5, 140.23, 1378.48, 1088.37, 180.168, 0, 0, 0, 0, 0),
(30, 0, 'The State', 432.596, -1138.46, 73.7169, 2324.47, -1149.55, 1050.71, 400000, 1, 3, 12, 2324.34, -1136.53, 1051.3, 180.458, 0, 0, 0, 0, 0),
(31, 0, 'The State', 416.769, -1154.12, 76.6876, 2324.47, -1149.55, 1050.71, 400000, 0, 3, 12, 2324.34, -1136.53, 1051.3, 180.458, 0, 0, 0, 0, 0),
(32, 0, 'The State', 352.395, -1197.95, 76.5156, 2324.47, -1149.55, 1050.71, 400000, 1, 3, 12, 2324.34, -1136.53, 1051.3, 180.458, 0, 0, 0, 0, 0),
(33, 1, 'Inoue_Takehiko', 300.238, -1154.45, 81.3904, 140.313, 1365.92, 1083.86, 500000, 1, 4, 5, 140.23, 1378.48, 1088.37, 180.168, 0, 0, 0, 0, 0),
(34, 1, 'Beqa_Beriashvili', 253.216, -1269.99, 74.4302, 140.313, 1365.92, 1083.86, 500000, 1, 4, 5, 140.23, 1378.48, 1088.37, 180.168, 0, 0, 0, 0, 0),
(35, 0, 'The State', 219.244, -1249.8, 78.3364, 140.313, 1365.92, 1083.86, 500000, 0, 4, 5, 140.23, 1378.48, 1088.37, 180.168, 0, 0, 0, 0, 0),
(36, 1, 'Saba_Chitinashvili', 298.853, -1338.5, 53.4415, 2324.47, -1149.55, 1050.71, 400000, 1, 3, 12, 2324.34, -1136.53, 1051.3, 180.458, 0, 0, 0, 0, 0),
(37, 1, 'Saint_Sebastian', 254.346, -1367.08, 53.1094, 2324.47, -1149.55, 1050.71, 400000, 1, 3, 12, 2324.34, -1136.53, 1051.3, 180.458, 0, 0, 0, 0, 0),
(38, 0, 'The State', 398.127, -1271.39, 50.0198, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061, 0, 0, 0, 0, 0),
(39, 0, 'The State', 552.975, -1200.27, 44.8315, 2495.96, -1692.08, 1014.74, 200000, 1, 2, 3, 2492.31, -1702.56, 1018.34, 181.061, 0, 0, 0, 0, 0),
(40, 1, 'Levani_Bedinashvili', 1684.9, -2098.16, 13.8343, 422.573, 2536.49, 10, 150000, 0, 1, 10, 416.93, 2536.62, 10, 272.892, 0, 0, 0, 0, 0),
(41, 0, 'The State', 2168.91, -1815.23, 13.5469, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892, 0, 0, 0, 0, 0),
(42, 0, 'The State', 2155.88, -1815.23, 13.5469, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892, 0, 0, 0, 0, 0),
(43, 1, 'Davit_Ximenez', 2151.05, -1807.95, 13.5464, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892, 0, 0, 0, 0, 0),
(44, 0, 'The State', 2151.04, -1789.24, 13.5093, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892, 0, 0, 0, 0, 0),
(45, 0, 'The State', 2146.52, -1808.4, 16.1406, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892, 0, 0, 0, 0, 0),
(46, 0, 'The State', 2146.47, -1815.03, 16.1406, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892, 0, 0, 0, 0, 0),
(47, 0, 'The State', 2151.96, -1819.7, 16.1406, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892, 0, 0, 0, 0, 0),
(48, 0, 'The State', 2158.29, -1819.7, 16.1406, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892, 0, 0, 0, 0, 0),
(49, 0, 'The State', 2164.85, -1819.62, 16.1406, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892, 0, 0, 0, 0, 0),
(50, 0, 'The State', 2172.39, -1819.7, 16.1406, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892, 0, 0, 0, 0, 0),
(51, 0, 'The State', 2140.93, -1801.92, 16.1475, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892, 0, 0, 0, 0, 0),
(52, 0, 'The State', 2145, -1801.77, 16.1406, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892, 0, 0, 0, 0, 0),
(53, 0, 'The State', 2162.67, -1815.23, 13.5469, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892, 0, 0, 0, 0, 0),
(54, 0, 'The State', 2176.25, -1815.23, 13.5469, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892, 0, 0, 0, 0, 0),
(55, 0, 'The State', 2151.04, -1815.01, 13.5498, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892, 0, 0, 0, 0, 0),
(56, 0, 'The State', 2185.8, -1815.23, 13.5469, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892, 0, 0, 0, 0, 0),
(57, 0, 'The State', 2192.37, -1815.23, 13.5469, 422.573, 2536.49, 10, 150000, 1, 1, 10, 416.93, 2536.62, 10, 272.892, 0, 0, 0, 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`pID`);

--
-- Indexes for table `banip`
--
ALTER TABLE `banip`
  ADD PRIMARY KEY (`banID`);

--
-- Indexes for table `banlog`
--
ALTER TABLE `banlog`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `bizz`
--
ALTER TABLE `bizz`
  ADD PRIMARY KEY (`bID`);

--
-- Indexes for table `business`
--
ALTER TABLE `business`
  ADD PRIMARY KEY (`bID`);

--
-- Indexes for table `cars`
--
ALTER TABLE `cars`
  ADD PRIMARY KEY (`ID`);

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
  MODIFY `pID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `banip`
--
ALTER TABLE `banip`
  MODIFY `banID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `banlog`
--
ALTER TABLE `banlog`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bizz`
--
ALTER TABLE `bizz`
  MODIFY `bID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `business`
--
ALTER TABLE `business`
  MODIFY `bID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cars`
--
ALTER TABLE `cars`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `console`
--
ALTER TABLE `console`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT for table `fractions`
--
ALTER TABLE `fractions`
  MODIFY `wID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `house`
--
ALTER TABLE `house`
  MODIFY `hID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
