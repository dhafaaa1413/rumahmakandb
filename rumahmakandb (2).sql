-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 10, 2026 at 03:01 AM
-- Server version: 8.4.3
-- PHP Version: 8.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rumahmakandb`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilDeposit` ()   BEGIN
SELECT * FROM deposit;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilMenu` ()   BEGIN
SELECT * FROM menu;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `totalMenu` () RETURNS INT DETERMINISTIC BEGIN
    DECLARE total INT;

    SELECT COUNT(*) INTO total
    FROM menu;

    RETURN total;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `deposit`
--

CREATE TABLE `deposit` (
  `iddeposit` int NOT NULL,
  `tgl` date NOT NULL,
  `bankpengirim` varchar(45) DEFAULT NULL,
  `atasnama` varchar(45) DEFAULT NULL,
  `jumlah` int NOT NULL,
  `norekpengirim` varchar(45) DEFAULT NULL,
  `pelanggan_idpelanggan` int NOT NULL,
  `rumahmakan_idrumahmakan` int NOT NULL,
  `status_verifikasi` enum('Pending','Diterima','Ditolak') DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `deposit`
--

INSERT INTO `deposit` (`iddeposit`, `tgl`, `bankpengirim`, `atasnama`, `jumlah`, `norekpengirim`, `pelanggan_idpelanggan`, `rumahmakan_idrumahmakan`, `status_verifikasi`) VALUES
(1, '2026-07-05', 'Bank Central Asia', 'Budi Utomo', 100000, '1122334455', 1, 1, 'Diterima');

--
-- Triggers `deposit`
--
DELIMITER $$
CREATE TRIGGER `trg_deposit_insert` BEFORE INSERT ON `deposit` FOR EACH ROW SET NEW.status_verifikasi='Pending'
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `kritiksaran`
--

CREATE TABLE `kritiksaran` (
  `idkritiksaran` int NOT NULL,
  `tgl` date NOT NULL,
  `isi` mediumtext NOT NULL,
  `pelanggan_idpelanggan` int NOT NULL,
  `rumahmakan_idrumahmakan` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kritiksaran`
--

INSERT INTO `kritiksaran` (`idkritiksaran`, `tgl`, `isi`, `pelanggan_idpelanggan`, `rumahmakan_idrumahmakan`) VALUES
(1, '2026-07-05', 'Makanannya enak sekali, bumbunya pas. Tapi pengiriman agak sedikit lama tolong ditingkatkan ya!', 1, 1),
(2, '2026-07-05', 'Porsi nasi kapau nya banyak dan mengenyangkan. Mantap!', 1, 1),
(3, '2026-07-05', 'Makanannya mantap sekali, bumbunya pas. Tapi pengiriman agak sedikit lama tolong ditingkatkan ya!', 1, 1),
(4, '2026-07-05', 'Porsi nasi kapau nya banyak dan mengenyangkan. Mantap!', 1, 1);

--
-- Triggers `kritiksaran`
--
DELIMITER $$
CREATE TRIGGER `trg_kritik_insert` BEFORE INSERT ON `kritiksaran` FOR EACH ROW SET NEW.tgl=CURDATE()
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `idmenu` int NOT NULL,
  `nama` varchar(50) NOT NULL,
  `harga` int NOT NULL,
  `gambar` longblob,
  `rmhmakan_idrmhmakan` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`idmenu`, `nama`, `harga`, `gambar`, `rmhmakan_idrmhmakan`) VALUES
(1, 'Ayam Rendang', 20000, NULL, 1),
(2, 'Nasi Kapau', 22000, NULL, 1);

--
-- Triggers `menu`
--
DELIMITER $$
CREATE TRIGGER `trg_menu_insert` BEFORE INSERT ON `menu` FOR EACH ROW SET NEW.harga=ABS(NEW.harga)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `mhmakan`
--

CREATE TABLE `mhmakan` (
  `idrmhmakan` int NOT NULL,
  `rumahmakan` varchar(45) NOT NULL,
  `deskripsi` mediumtext,
  `alamat` tinytext,
  `notlp` varchar(16) DEFAULT NULL,
  `lat` float(12,8) DEFAULT NULL,
  `lng` float(12,8) DEFAULT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `norek` varchar(45) DEFAULT NULL,
  `namabank` varchar(100) DEFAULT NULL,
  `gambar` longblob
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `mhmakan`
--

INSERT INTO `mhmakan` (`idrmhmakan`, `rumahmakan`, `deskripsi`, `alamat`, `notlp`, `lat`, `lng`, `username`, `password`, `norek`, `namabank`, `gambar`) VALUES
(1, 'Rumah Makan Sederhana', 'Menyediakan masakan padang', 'Jl. Gatot Subroto No.10 Medan', '08123456789', 3.58899999, 98.67299652, 'rm_sederhana', 'password123', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `idpelanggan` int NOT NULL,
  `nama` varchar(50) NOT NULL,
  `alamat` tinytext,
  `nohp` varchar(16) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`idpelanggan`, `nama`, `alamat`, `nohp`, `username`, `password`) VALUES
(1, 'Budi Utomo', 'Jl. Halat No. 45', '081234567890', 'REZA_ARAP', 'budi123');

--
-- Triggers `pelanggan`
--
DELIMITER $$
CREATE TRIGGER `trg_pelanggan_update` BEFORE UPDATE ON `pelanggan` FOR EACH ROW SET NEW.nama=UPPER(NEW.nama)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pesanan`
--

CREATE TABLE `pesanan` (
  `idpesanan` int NOT NULL,
  `tgl` date NOT NULL,
  `lat` float(12,8) DEFAULT NULL,
  `lng` float(12,8) DEFAULT NULL,
  `jenis_pembayaran` enum('Deposit','Tunai') NOT NULL,
  `pelanggan_idpelanggan` int NOT NULL,
  `rumahmakan_idrumahmakan` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `pesanan`
--

INSERT INTO `pesanan` (`idpesanan`, `tgl`, `lat`, `lng`, `jenis_pembayaran`, `pelanggan_idpelanggan`, `rumahmakan_idrumahmakan`) VALUES
(1, '2026-07-05', 3.58899999, 98.67299652, 'Deposit', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `pesanandetail`
--

CREATE TABLE `pesanandetail` (
  `idpesanandetail` int NOT NULL,
  `nama` varchar(45) NOT NULL,
  `harga` int NOT NULL,
  `jumlah` int NOT NULL,
  `menu_idmenu` int NOT NULL,
  `pesan_idpesanan` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `pesanandetail`
--

INSERT INTO `pesanandetail` (`idpesanandetail`, `nama`, `harga`, `jumlah`, `menu_idmenu`, `pesan_idpesanan`) VALUES
(1, 'Ayam Rendang', 18000, 2, 1, 1),
(2, 'Nasi Kapau', 22000, 1, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `saldo`
--

CREATE TABLE `saldo` (
  `idsaldo` int NOT NULL,
  `saldo` int DEFAULT '0',
  `pelanggan_idpelanggan` int NOT NULL,
  `rmhmakan_idrmhmakan` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `saldo`
--

INSERT INTO `saldo` (`idsaldo`, `saldo`, `pelanggan_idpelanggan`, `rmhmakan_idrmhmakan`) VALUES
(1, 150000, 1, 1);

--
-- Triggers `saldo`
--
DELIMITER $$
CREATE TRIGGER `trg_saldo_insert` BEFORE INSERT ON `saldo` FOR EACH ROW SET NEW.saldo=ABS(NEW.saldo)
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `deposit`
--
ALTER TABLE `deposit`
  ADD PRIMARY KEY (`iddeposit`),
  ADD KEY `pelanggan_idpelanggan` (`pelanggan_idpelanggan`),
  ADD KEY `rumahmakan_idrumahmakan` (`rumahmakan_idrumahmakan`);

--
-- Indexes for table `kritiksaran`
--
ALTER TABLE `kritiksaran`
  ADD PRIMARY KEY (`idkritiksaran`),
  ADD KEY `pelanggan_idpelanggan` (`pelanggan_idpelanggan`),
  ADD KEY `rumahmakan_idrumahmakan` (`rumahmakan_idrumahmakan`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`idmenu`),
  ADD KEY `rmhmakan_idrmhmakan` (`rmhmakan_idrmhmakan`);

--
-- Indexes for table `mhmakan`
--
ALTER TABLE `mhmakan`
  ADD PRIMARY KEY (`idrmhmakan`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`idpelanggan`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD PRIMARY KEY (`idpesanan`),
  ADD KEY `pelanggan_idpelanggan` (`pelanggan_idpelanggan`),
  ADD KEY `rumahmakan_idrumahmakan` (`rumahmakan_idrumahmakan`);

--
-- Indexes for table `pesanandetail`
--
ALTER TABLE `pesanandetail`
  ADD PRIMARY KEY (`idpesanandetail`),
  ADD KEY `menu_idmenu` (`menu_idmenu`),
  ADD KEY `pesan_idpesanan` (`pesan_idpesanan`);

--
-- Indexes for table `saldo`
--
ALTER TABLE `saldo`
  ADD PRIMARY KEY (`idsaldo`),
  ADD KEY `pelanggan_idpelanggan` (`pelanggan_idpelanggan`),
  ADD KEY `rmhmakan_idrmhmakan` (`rmhmakan_idrmhmakan`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `deposit`
--
ALTER TABLE `deposit`
  MODIFY `iddeposit` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `kritiksaran`
--
ALTER TABLE `kritiksaran`
  MODIFY `idkritiksaran` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `idmenu` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `mhmakan`
--
ALTER TABLE `mhmakan`
  MODIFY `idrmhmakan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `idpelanggan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pesanan`
--
ALTER TABLE `pesanan`
  MODIFY `idpesanan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pesanandetail`
--
ALTER TABLE `pesanandetail`
  MODIFY `idpesanandetail` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `saldo`
--
ALTER TABLE `saldo`
  MODIFY `idsaldo` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `deposit`
--
ALTER TABLE `deposit`
  ADD CONSTRAINT `deposit_ibfk_1` FOREIGN KEY (`pelanggan_idpelanggan`) REFERENCES `pelanggan` (`idpelanggan`) ON DELETE CASCADE,
  ADD CONSTRAINT `deposit_ibfk_2` FOREIGN KEY (`rumahmakan_idrumahmakan`) REFERENCES `mhmakan` (`idrmhmakan`) ON DELETE CASCADE;

--
-- Constraints for table `kritiksaran`
--
ALTER TABLE `kritiksaran`
  ADD CONSTRAINT `kritiksaran_ibfk_1` FOREIGN KEY (`pelanggan_idpelanggan`) REFERENCES `pelanggan` (`idpelanggan`) ON DELETE CASCADE,
  ADD CONSTRAINT `kritiksaran_ibfk_2` FOREIGN KEY (`rumahmakan_idrumahmakan`) REFERENCES `mhmakan` (`idrmhmakan`) ON DELETE CASCADE;

--
-- Constraints for table `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`rmhmakan_idrmhmakan`) REFERENCES `mhmakan` (`idrmhmakan`) ON DELETE CASCADE;

--
-- Constraints for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD CONSTRAINT `pesanan_ibfk_1` FOREIGN KEY (`pelanggan_idpelanggan`) REFERENCES `pelanggan` (`idpelanggan`) ON DELETE CASCADE,
  ADD CONSTRAINT `pesanan_ibfk_2` FOREIGN KEY (`rumahmakan_idrumahmakan`) REFERENCES `mhmakan` (`idrmhmakan`) ON DELETE CASCADE;

--
-- Constraints for table `pesanandetail`
--
ALTER TABLE `pesanandetail`
  ADD CONSTRAINT `pesanandetail_ibfk_1` FOREIGN KEY (`menu_idmenu`) REFERENCES `menu` (`idmenu`) ON DELETE CASCADE,
  ADD CONSTRAINT `pesanandetail_ibfk_2` FOREIGN KEY (`pesan_idpesanan`) REFERENCES `pesanan` (`idpesanan`) ON DELETE CASCADE;

--
-- Constraints for table `saldo`
--
ALTER TABLE `saldo`
  ADD CONSTRAINT `saldo_ibfk_1` FOREIGN KEY (`pelanggan_idpelanggan`) REFERENCES `pelanggan` (`idpelanggan`) ON DELETE CASCADE,
  ADD CONSTRAINT `saldo_ibfk_2` FOREIGN KEY (`rmhmakan_idrmhmakan`) REFERENCES `mhmakan` (`idrmhmakan`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
