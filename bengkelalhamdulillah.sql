-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 29, 2024 at 05:54 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bengkelalhamdulillah`
--

-- --------------------------------------------------------

--
-- Table structure for table `coa`
--

CREATE TABLE `coa` (
  `no_akun` char(5) NOT NULL DEFAULT '',
  `nama_akun` varchar(20) DEFAULT NULL,
  `header_akun` char(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `coa`
--

INSERT INTO `coa` (`no_akun`, `nama_akun`, `header_akun`) VALUES
('1', 'Aktiva', NULL),
('11', 'Aktiva Lancar', '1'),
('111', 'Kas', '11'),
('112', 'Piutang Dagang', '11'),
('113', 'Persediaan Barang Da', '11'),
('114', 'Sewa Dibayar Dimuka', '11'),
('115', 'Asuransi Dibayar Dim', '11'),
('116', 'Perlengkapan', '11'),
('2', 'Hutang', NULL),
('21', 'Hutang Lancar', '2'),
('211', 'Utang Dagang', '21'),
('3', 'Modal', NULL),
('311', 'Modal Tn. X', '3'),
('3112', 'Prive Tn. X', '311'),
('4', 'Pendapatan', NULL),
('41', 'Pendapatan Usaha', '4'),
('411', 'Penjualan', '41'),
('412', 'Harga Pokok Penjuala', '41'),
('413', 'Retur Penjualan', '41'),
('414', 'Potongan Penjualan', '41'),
('415', 'Pendapatan Jasa', '41'),
('5', 'Beban', NULL),
('511', 'Beban Listrik', '5'),
('512', 'Beban Air', '5'),
('513', 'Beban Telepon', '5'),
('514', 'Beban Gaji', '5');

-- --------------------------------------------------------

--
-- Table structure for table `detail_pembelian_sparepart`
--

CREATE TABLE `detail_pembelian_sparepart` (
  `id_pembelian` int(11) NOT NULL,
  `id_sparepart` int(11) NOT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `subtotal` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detail_pembelian_sparepart`
--

INSERT INTO `detail_pembelian_sparepart` (`id_pembelian`, `id_sparepart`, `jumlah`, `subtotal`) VALUES
(1, 1, 10, 500000.00),
(2, 2, 4, 300000.00),
(3, 3, 5, 250000.00),
(4, 4, 6, 180000.00),
(5, 5, 8, 400000.00),
(6, 6, 7, 350000.00),
(7, 1, 12, 600000.00),
(8, 2, 5, 375000.00),
(9, 3, 10, 500000.00),
(10, 4, 3, 90000.00);

-- --------------------------------------------------------

--
-- Table structure for table `detail_penjualan_jasa`
--

CREATE TABLE `detail_penjualan_jasa` (
  `id_jasa` varchar(10) NOT NULL,
  `id_penjualan` varchar(10) NOT NULL,
  `subtotal` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detail_penjualan_jasa`
--

INSERT INTO `detail_penjualan_jasa` (`id_jasa`, `id_penjualan`, `subtotal`) VALUES
('JS001', 'PJ001', 75000.00),
('JS001', 'PJ003', 75000.00),
('JS002', 'PJ001', 75000.00),
('JS003', 'PJ002', 300000.00),
('JS004', 'PJ002', 100000.00),
('JS005', 'PJ004', 200000.00),
('JS006', 'PJ004', 100000.00),
('JS007', 'PJ005', 400000.00);

-- --------------------------------------------------------

--
-- Table structure for table `detail_penjualan_sparepart`
--

CREATE TABLE `detail_penjualan_sparepart` (
  `id_penjualan` int(11) NOT NULL,
  `id_sparepart` int(11) NOT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `subtotal` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detail_penjualan_sparepart`
--

INSERT INTO `detail_penjualan_sparepart` (`id_penjualan`, `id_sparepart`, `jumlah`, `subtotal`) VALUES
(1, 1, 2, 100000.00),
(2, 3, 2, 200000.00),
(3, 4, 1, 300000.00),
(4, 2, 3, 225000.00),
(5, 5, 2, 300000.00),
(6, 6, 1, 400000.00),
(7, 7, 3, 360000.00),
(8, 8, 2, 500000.00),
(9, 9, 1, 500000.00),
(10, 10, 2, 400000.00);

-- --------------------------------------------------------

--
-- Table structure for table `jasa`
--

CREATE TABLE `jasa` (
  `id_jasa` varchar(10) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `harga` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jasa`
--

INSERT INTO `jasa` (`id_jasa`, `nama`, `harga`) VALUES
('JS001', 'Ganti Oli', 75000.00),
('JS002', 'Servis Rutin', 150000.00),
('JS003', 'Ganti Ban', 300000.00),
('JS004', 'Pembersihan Karburator', 100000.00),
('JS005', 'Tune Up Mesin', 200000.00),
('JS006', 'Perbaikan Rem', 120000.00),
('JS007', 'Penggantian Aki', 400000.00);

-- --------------------------------------------------------

--
-- Table structure for table `jurnal_pembelian_sparepart`
--

CREATE TABLE `jurnal_pembelian_sparepart` (
  `id_pembelian` int(11) NOT NULL,
  `no_akun` char(5) NOT NULL,
  `posisi_dr_cr` enum('debit','kredit') DEFAULT NULL,
  `nominal` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jurnal_pembelian_sparepart`
--

INSERT INTO `jurnal_pembelian_sparepart` (`id_pembelian`, `no_akun`, `posisi_dr_cr`, `nominal`) VALUES
(1, '111', 'kredit', 500000.00),
(2, '111', 'kredit', 300000.00),
(3, '111', 'kredit', 400000.00),
(4, '111', 'kredit', 600000.00),
(5, '111', 'kredit', 350000.00),
(6, '111', 'kredit', 750000.00),
(7, '111', 'kredit', 200000.00),
(8, '111', 'kredit', 550000.00),
(9, '111', 'kredit', 800000.00),
(10, '111', 'kredit', 650000.00),
(1, '113', 'debit', 500000.00),
(2, '113', 'debit', 300000.00),
(3, '113', 'debit', 400000.00),
(4, '113', 'debit', 600000.00),
(5, '113', 'debit', 350000.00),
(6, '113', 'debit', 750000.00),
(7, '113', 'debit', 200000.00),
(8, '113', 'debit', 550000.00),
(9, '113', 'debit', 800000.00),
(10, '113', 'debit', 650000.00);

-- --------------------------------------------------------

--
-- Table structure for table `jurnal_penggajian`
--

CREATE TABLE `jurnal_penggajian` (
  `no_akun` char(5) NOT NULL,
  `id_penggajian` int(11) NOT NULL,
  `posisi_dr_cr` enum('debit','kredit') DEFAULT NULL,
  `nominal` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jurnal_penggajian`
--

INSERT INTO `jurnal_penggajian` (`no_akun`, `id_penggajian`, `posisi_dr_cr`, `nominal`) VALUES
('111', 1, 'kredit', 3300000.00),
('111', 2, 'kredit', 2900000.00),
('111', 3, 'kredit', 3600000.00),
('511', 1, 'debit', 3300000.00),
('511', 2, 'debit', 2900000.00),
('511', 3, 'debit', 3600000.00);

-- --------------------------------------------------------

--
-- Table structure for table `jurnal_penjualan_jasa`
--

CREATE TABLE `jurnal_penjualan_jasa` (
  `tanggal` date NOT NULL,
  `id_penjualan` varchar(10) NOT NULL,
  `no_akun` char(5) NOT NULL,
  `posisi_dr_cr` enum('debit','kredit') NOT NULL,
  `nominal` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jurnal_penjualan_jasa`
--

INSERT INTO `jurnal_penjualan_jasa` (`tanggal`, `id_penjualan`, `no_akun`, `posisi_dr_cr`, `nominal`) VALUES
('2024-12-01', 'PJ001', '111', 'debit', 145000.00),
('2024-12-01', 'PJ001', '414', 'kredit', 5000.00),
('2024-12-01', 'PJ001', '415', 'kredit', 150000.00),
('2024-12-02', 'PJ002', '111', 'debit', 290000.00),
('2024-12-02', 'PJ002', '414', 'kredit', 10000.00),
('2024-12-02', 'PJ002', '415', 'kredit', 300000.00),
('2024-12-03', 'PJ003', '111', 'debit', 75000.00),
('2024-12-03', 'PJ003', '415', 'kredit', 75000.00),
('2024-12-04', 'PJ004', '111', 'debit', 285000.00),
('2024-12-04', 'PJ004', '414', 'kredit', 15000.00),
('2024-12-04', 'PJ004', '415', 'kredit', 300000.00),
('2024-12-05', 'PJ005', '111', 'debit', 380000.00),
('2024-12-05', 'PJ005', '414', 'kredit', 20000.00),
('2024-12-05', 'PJ005', '415', 'kredit', 400000.00);

-- --------------------------------------------------------

--
-- Table structure for table `jurnal_penjualan_sparepart`
--

CREATE TABLE `jurnal_penjualan_sparepart` (
  `no_akun` char(5) NOT NULL,
  `id_penjualan` int(11) NOT NULL,
  `posisi_dr_cr` enum('debit','kredit') NOT NULL,
  `nominal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jurnal_penjualan_sparepart`
--

INSERT INTO `jurnal_penjualan_sparepart` (`no_akun`, `id_penjualan`, `posisi_dr_cr`, `nominal`) VALUES
('111', 1, 'debit', 100000.00),
('111', 2, 'debit', 150000.00),
('111', 3, 'debit', 200000.00),
('111', 4, 'debit', 300000.00),
('111', 5, 'debit', 250000.00),
('411', 1, 'kredit', 100000.00),
('411', 2, 'kredit', 150000.00),
('411', 3, 'kredit', 200000.00),
('411', 4, 'kredit', 300000.00),
('411', 5, 'kredit', 250000.00);

-- --------------------------------------------------------

--
-- Table structure for table `kategori_sparepart`
--

CREATE TABLE `kategori_sparepart` (
  `id_kategori` varchar(15) NOT NULL,
  `nama_kategori` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kategori_sparepart`
--

INSERT INTO `kategori_sparepart` (`id_kategori`, `nama_kategori`) VALUES
('S001', 'Mesin'),
('S002', 'Oli'),
('S003', 'Rem'),
('S004', 'Ban'),
('S005', 'Lampu'),
('S006', 'Aki'),
('S007', 'Filter Udara'),
('S008', 'Radiator'),
('S009', 'Knalpot'),
('S010', 'Kopling');

-- --------------------------------------------------------

--
-- Table structure for table `mekanik`
--

CREATE TABLE `mekanik` (
  `id_mekanik` int(11) NOT NULL,
  `nama_mekanik` varchar(255) NOT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `no_telepon` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mekanik`
--

INSERT INTO `mekanik` (`id_mekanik`, `nama_mekanik`, `alamat`, `no_telepon`) VALUES
(101, 'Budi Santoso', 'Jl. Sukabirus', '089628858002'),
(102, 'Siti Aminah', 'Jl. Sukapura', '082282727251'),
(103, 'Herman Wijaya', 'Jl. Baleendah', '081272444456');

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `id_member` int(11) NOT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `no_telepon` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`id_member`, `nama`, `alamat`, `no_telepon`) VALUES
(1, 'Andi Setiawan', 'Jln. Buah Batu', '085767874562'),
(2, 'Rina Sari', 'Jln. Bekasi Timur', '085767777562'),
(3, 'Dewi Lestari', 'Jln. Soekarno Hatta', '085888874562'),
(4, 'Budi Pratama', 'Jln. Asia Afrika', '085799654321'),
(5, 'Siti Aminah', 'Jln. Merdeka', '085712345678'),
(6, 'Ahmad Fauzi', 'Jln. Braga', '085768954321'),
(7, 'Lina Marlina', 'Jln. Cihampelas', '085756789432'),
(8, 'Fajar Santoso', 'Jln. Riau', '085712349876'),
(9, 'Tina Wulandari', 'Jln. Dipatiukur', '085712378945'),
(10, 'Rahmat Hidayat', 'Jln. Dago', '085765432198');

-- --------------------------------------------------------

--
-- Table structure for table `pembelian_sparepart`
--

CREATE TABLE `pembelian_sparepart` (
  `id_pembelian` int(11) NOT NULL,
  `total_harga` decimal(10,2) DEFAULT NULL,
  `tanggal_pembelian` date DEFAULT NULL,
  `id_vendor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pembelian_sparepart`
--

INSERT INTO `pembelian_sparepart` (`id_pembelian`, `total_harga`, `tanggal_pembelian`, `id_vendor`) VALUES
(1, 500000.00, '2023-10-01', 1),
(2, 300000.00, '2023-10-02', 2),
(3, 450000.00, '2023-10-03', 3),
(4, 600000.00, '2023-10-04', 4),
(5, 350000.00, '2023-10-05', 5),
(6, 750000.00, '2023-10-06', 6),
(7, 200000.00, '2023-10-07', 7),
(8, 550000.00, '2023-10-08', 8),
(9, 800000.00, '2023-10-09', 9),
(10, 650000.00, '2023-10-10', 10);

-- --------------------------------------------------------

--
-- Table structure for table `penggajian`
--

CREATE TABLE `penggajian` (
  `id_penggajian` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `gaji_pokok` decimal(15,2) NOT NULL,
  `tunjangan` decimal(15,2) NOT NULL,
  `potongan` decimal(15,2) NOT NULL,
  `total_gaji` decimal(15,2) NOT NULL,
  `id_mekanik` int(11) NOT NULL,
  `id_presensi` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `penggajian`
--

INSERT INTO `penggajian` (`id_penggajian`, `tanggal`, `gaji_pokok`, `tunjangan`, `potongan`, `total_gaji`, `id_mekanik`, `id_presensi`) VALUES
(1, '2023-10-01', 3000000.00, 500000.00, 200000.00, 3300000.00, 101, 1),
(2, '2023-10-01', 2800000.00, 400000.00, 150000.00, 2900000.00, 102, 2),
(3, '2023-10-01', 3200000.00, 600000.00, 250000.00, 3600000.00, 103, 3);

-- --------------------------------------------------------

--
-- Table structure for table `penjualan_jasa`
--

CREATE TABLE `penjualan_jasa` (
  `id_penjualan` varchar(10) NOT NULL,
  `tanggal` date NOT NULL,
  `potongan` decimal(15,2) DEFAULT NULL,
  `total` decimal(15,2) NOT NULL,
  `id_member` int(11) NOT NULL,
  `id_mekanik` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `penjualan_jasa`
--

INSERT INTO `penjualan_jasa` (`id_penjualan`, `tanggal`, `potongan`, `total`, `id_member`, `id_mekanik`) VALUES
('PJ001', '2024-12-01', 5000.00, 145000.00, 1, 101),
('PJ002', '2024-12-02', 10000.00, 290000.00, 2, 102),
('PJ003', '2024-12-03', 0.00, 75000.00, 3, 103),
('PJ004', '2024-12-04', 15000.00, 285000.00, 4, 101),
('PJ005', '2024-12-05', 20000.00, 380000.00, 5, 102);

-- --------------------------------------------------------

--
-- Table structure for table `penjualan_sparepart`
--

CREATE TABLE `penjualan_sparepart` (
  `id_penjualan` int(11) NOT NULL,
  `total_harga` decimal(10,2) DEFAULT NULL,
  `tanggal_penjualan` date DEFAULT NULL,
  `id_member` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `penjualan_sparepart`
--

INSERT INTO `penjualan_sparepart` (`id_penjualan`, `total_harga`, `tanggal_penjualan`, `id_member`) VALUES
(1, 100000.00, '2023-10-01', 1),
(2, 300000.00, '2023-10-02', 2),
(3, 250000.00, '2023-10-03', 3),
(4, 150000.00, '2023-10-04', 1),
(5, 500000.00, '2023-10-05', 4),
(6, 750000.00, '2023-10-06', 5),
(7, 200000.00, '2023-10-07', 3),
(8, 400000.00, '2023-10-08', 2),
(9, 350000.00, '2023-10-09', 6),
(10, 600000.00, '2023-10-10', 4);

-- --------------------------------------------------------

--
-- Table structure for table `presensi`
--

CREATE TABLE `presensi` (
  `id_presensi` int(11) NOT NULL,
  `tanggal` date DEFAULT NULL,
  `status` enum('hadir','tidak hadir','sakit','cuti') DEFAULT NULL,
  `id_mekanik` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `presensi`
--

INSERT INTO `presensi` (`id_presensi`, `tanggal`, `status`, `id_mekanik`) VALUES
(1, '2023-10-01', 'hadir', 101),
(2, '2023-10-01', 'tidak hadir', 102),
(3, '2023-10-01', 'hadir', 103);

-- --------------------------------------------------------

--
-- Table structure for table `sparepart`
--

CREATE TABLE `sparepart` (
  `id_sparepart` int(11) NOT NULL,
  `nama_sparepart` varchar(255) DEFAULT NULL,
  `harga` decimal(10,2) DEFAULT NULL,
  `stok` int(11) DEFAULT NULL,
  `id_kategori` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sparepart`
--

INSERT INTO `sparepart` (`id_sparepart`, `nama_sparepart`, `harga`, `stok`, `id_kategori`) VALUES
(1, 'Busi', 50000.00, 100, 'S001'),
(2, 'Oli Pertamina', 75000.00, 50, 'S002'),
(3, 'Kampas Rem', 100000.00, 20, 'S003'),
(4, 'Ban Luar', 300000.00, 25, 'S004'),
(5, 'Lampu Depan', 150000.00, 30, 'S005'),
(6, 'Aki Kering', 400000.00, 15, 'S006'),
(7, 'Filter Udara Racing', 120000.00, 40, 'S007'),
(8, 'Radiator Universal', 250000.00, 10, 'S008'),
(9, 'Knalpot Racing', 500000.00, 8, 'S009'),
(10, 'Kampas Kopling', 200000.00, 12, 'S010');

-- --------------------------------------------------------

--
-- Table structure for table `vendor`
--

CREATE TABLE `vendor` (
  `id_vendor` int(11) NOT NULL,
  `nama_vendor` varchar(255) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `no_telepon` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vendor`
--

INSERT INTO `vendor` (`id_vendor`, `nama_vendor`, `alamat`, `no_telepon`) VALUES
(1, 'Yamaha', 'Jl. Raya No. 1, Jakarta, Indonesia', '02112345678'),
(2, 'Honda', 'Jl. Sudirman No. 12, Bandung, Indonesia', '02223456789'),
(3, 'Kawasaki', 'Jl. Merdeka No. 5, Surabaya, Indonesia', '03134567890'),
(4, 'Suzuki', 'Jl. Cempaka No. 6, Medan, Indonesia', '06145678901'),
(5, 'Ducati', 'Jl. Siliwangi No. 3, Bali, Indonesia', '03611223344'),
(6, 'BMW', 'Jl. Mangga No. 9, Jakarta, Indonesia', '02199887766'),
(7, 'KTM', 'Jl. Pantai No. 2, Yogyakarta, Indonesia', '02741234567'),
(8, 'Harley Davidson', 'Jl. Pahlawan No. 10, Malang, Indonesia', '03411223344'),
(9, 'Vespa', 'Jl. Pemuda No. 4, Surabaya, Indonesia', '03122334455'),
(10, 'Piaggio', 'Jl. Raya No. 15, Bandung, Indonesia', '02233445566');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `coa`
--
ALTER TABLE `coa`
  ADD PRIMARY KEY (`no_akun`),
  ADD KEY `fk_no_akun` (`header_akun`);

--
-- Indexes for table `detail_pembelian_sparepart`
--
ALTER TABLE `detail_pembelian_sparepart`
  ADD PRIMARY KEY (`id_pembelian`,`id_sparepart`),
  ADD KEY `id_sparepart` (`id_sparepart`);

--
-- Indexes for table `detail_penjualan_jasa`
--
ALTER TABLE `detail_penjualan_jasa`
  ADD PRIMARY KEY (`id_jasa`,`id_penjualan`),
  ADD KEY `id_penjualan` (`id_penjualan`);

--
-- Indexes for table `detail_penjualan_sparepart`
--
ALTER TABLE `detail_penjualan_sparepart`
  ADD PRIMARY KEY (`id_penjualan`,`id_sparepart`),
  ADD KEY `id_sparepart` (`id_sparepart`);

--
-- Indexes for table `jasa`
--
ALTER TABLE `jasa`
  ADD PRIMARY KEY (`id_jasa`);

--
-- Indexes for table `jurnal_pembelian_sparepart`
--
ALTER TABLE `jurnal_pembelian_sparepart`
  ADD PRIMARY KEY (`no_akun`,`id_pembelian`),
  ADD KEY `id_pembelian` (`id_pembelian`);

--
-- Indexes for table `jurnal_penggajian`
--
ALTER TABLE `jurnal_penggajian`
  ADD PRIMARY KEY (`no_akun`,`id_penggajian`),
  ADD KEY `id_penggajian` (`id_penggajian`);

--
-- Indexes for table `jurnal_penjualan_jasa`
--
ALTER TABLE `jurnal_penjualan_jasa`
  ADD PRIMARY KEY (`id_penjualan`,`no_akun`),
  ADD KEY `no_akun` (`no_akun`);

--
-- Indexes for table `jurnal_penjualan_sparepart`
--
ALTER TABLE `jurnal_penjualan_sparepart`
  ADD PRIMARY KEY (`no_akun`,`id_penjualan`),
  ADD KEY `id_penjualan` (`id_penjualan`);

--
-- Indexes for table `kategori_sparepart`
--
ALTER TABLE `kategori_sparepart`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indexes for table `mekanik`
--
ALTER TABLE `mekanik`
  ADD PRIMARY KEY (`id_mekanik`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`id_member`);

--
-- Indexes for table `pembelian_sparepart`
--
ALTER TABLE `pembelian_sparepart`
  ADD PRIMARY KEY (`id_pembelian`),
  ADD KEY `id_vendor` (`id_vendor`);

--
-- Indexes for table `penggajian`
--
ALTER TABLE `penggajian`
  ADD PRIMARY KEY (`id_penggajian`),
  ADD KEY `id_mekanik` (`id_mekanik`),
  ADD KEY `id_presensi` (`id_presensi`);

--
-- Indexes for table `penjualan_jasa`
--
ALTER TABLE `penjualan_jasa`
  ADD PRIMARY KEY (`id_penjualan`),
  ADD KEY `id_member` (`id_member`),
  ADD KEY `id_mekanik` (`id_mekanik`);

--
-- Indexes for table `penjualan_sparepart`
--
ALTER TABLE `penjualan_sparepart`
  ADD PRIMARY KEY (`id_penjualan`),
  ADD KEY `id_member` (`id_member`);

--
-- Indexes for table `presensi`
--
ALTER TABLE `presensi`
  ADD PRIMARY KEY (`id_presensi`),
  ADD KEY `fk_id_mekanik` (`id_mekanik`);

--
-- Indexes for table `sparepart`
--
ALTER TABLE `sparepart`
  ADD PRIMARY KEY (`id_sparepart`),
  ADD KEY `id_kategori` (`id_kategori`);

--
-- Indexes for table `vendor`
--
ALTER TABLE `vendor`
  ADD PRIMARY KEY (`id_vendor`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `mekanik`
--
ALTER TABLE `mekanik`
  MODIFY `id_mekanik` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT for table `member`
--
ALTER TABLE `member`
  MODIFY `id_member` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `pembelian_sparepart`
--
ALTER TABLE `pembelian_sparepart`
  MODIFY `id_pembelian` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `penggajian`
--
ALTER TABLE `penggajian`
  MODIFY `id_penggajian` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `penjualan_sparepart`
--
ALTER TABLE `penjualan_sparepart`
  MODIFY `id_penjualan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `presensi`
--
ALTER TABLE `presensi`
  MODIFY `id_presensi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sparepart`
--
ALTER TABLE `sparepart`
  MODIFY `id_sparepart` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `vendor`
--
ALTER TABLE `vendor`
  MODIFY `id_vendor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `coa`
--
ALTER TABLE `coa`
  ADD CONSTRAINT `fk_no_akun` FOREIGN KEY (`header_akun`) REFERENCES `coa` (`no_akun`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `detail_pembelian_sparepart`
--
ALTER TABLE `detail_pembelian_sparepart`
  ADD CONSTRAINT `detail_pembelian_sparepart_ibfk_1` FOREIGN KEY (`id_pembelian`) REFERENCES `pembelian_sparepart` (`id_pembelian`),
  ADD CONSTRAINT `detail_pembelian_sparepart_ibfk_2` FOREIGN KEY (`id_sparepart`) REFERENCES `sparepart` (`id_sparepart`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `detail_penjualan_jasa`
--
ALTER TABLE `detail_penjualan_jasa`
  ADD CONSTRAINT `detail_penjualan_jasa_ibfk_1` FOREIGN KEY (`id_jasa`) REFERENCES `jasa` (`id_jasa`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detail_penjualan_jasa_ibfk_2` FOREIGN KEY (`id_penjualan`) REFERENCES `penjualan_jasa` (`id_penjualan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `detail_penjualan_sparepart`
--
ALTER TABLE `detail_penjualan_sparepart`
  ADD CONSTRAINT `detail_penjualan_sparepart_ibfk_1` FOREIGN KEY (`id_penjualan`) REFERENCES `penjualan_sparepart` (`id_penjualan`),
  ADD CONSTRAINT `detail_penjualan_sparepart_ibfk_2` FOREIGN KEY (`id_sparepart`) REFERENCES `sparepart` (`id_sparepart`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `jurnal_pembelian_sparepart`
--
ALTER TABLE `jurnal_pembelian_sparepart`
  ADD CONSTRAINT `jurnal_pembelian_sparepart_ibfk_1` FOREIGN KEY (`no_akun`) REFERENCES `coa` (`no_akun`),
  ADD CONSTRAINT `jurnal_pembelian_sparepart_ibfk_2` FOREIGN KEY (`id_pembelian`) REFERENCES `pembelian_sparepart` (`id_pembelian`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `jurnal_penggajian`
--
ALTER TABLE `jurnal_penggajian`
  ADD CONSTRAINT `jurnal_penggajian_ibfk_1` FOREIGN KEY (`no_akun`) REFERENCES `coa` (`no_akun`),
  ADD CONSTRAINT `jurnal_penggajian_ibfk_2` FOREIGN KEY (`id_penggajian`) REFERENCES `penggajian` (`id_penggajian`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `jurnal_penjualan_jasa`
--
ALTER TABLE `jurnal_penjualan_jasa`
  ADD CONSTRAINT `jurnal_penjualan_jasa_ibfk_1` FOREIGN KEY (`id_penjualan`) REFERENCES `penjualan_jasa` (`id_penjualan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `jurnal_penjualan_jasa_ibfk_2` FOREIGN KEY (`no_akun`) REFERENCES `coa` (`no_akun`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `jurnal_penjualan_sparepart`
--
ALTER TABLE `jurnal_penjualan_sparepart`
  ADD CONSTRAINT `jurnal_penjualan_sparepart_ibfk_1` FOREIGN KEY (`no_akun`) REFERENCES `coa` (`no_akun`),
  ADD CONSTRAINT `jurnal_penjualan_sparepart_ibfk_2` FOREIGN KEY (`id_penjualan`) REFERENCES `penjualan_sparepart` (`id_penjualan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pembelian_sparepart`
--
ALTER TABLE `pembelian_sparepart`
  ADD CONSTRAINT `pembelian_sparepart_ibfk_1` FOREIGN KEY (`id_vendor`) REFERENCES `vendor` (`id_vendor`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `penggajian`
--
ALTER TABLE `penggajian`
  ADD CONSTRAINT `penggajian_ibfk_1` FOREIGN KEY (`id_mekanik`) REFERENCES `mekanik` (`id_mekanik`),
  ADD CONSTRAINT `penggajian_ibfk_2` FOREIGN KEY (`id_presensi`) REFERENCES `presensi` (`id_presensi`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `penjualan_jasa`
--
ALTER TABLE `penjualan_jasa`
  ADD CONSTRAINT `penjualan_jasa_ibfk_1` FOREIGN KEY (`id_member`) REFERENCES `member` (`id_member`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `penjualan_jasa_ibfk_2` FOREIGN KEY (`id_mekanik`) REFERENCES `mekanik` (`id_mekanik`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `penjualan_sparepart`
--
ALTER TABLE `penjualan_sparepart`
  ADD CONSTRAINT `penjualan_sparepart_ibfk_1` FOREIGN KEY (`id_member`) REFERENCES `member` (`id_member`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `presensi`
--
ALTER TABLE `presensi`
  ADD CONSTRAINT `fk_id_mekanik` FOREIGN KEY (`id_mekanik`) REFERENCES `mekanik` (`id_mekanik`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sparepart`
--
ALTER TABLE `sparepart`
  ADD CONSTRAINT `sparepart_ibfk_1` FOREIGN KEY (`id_kategori`) REFERENCES `kategori_sparepart` (`id_kategori`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
