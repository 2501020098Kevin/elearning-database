-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 23, 2026 at 04:05 PM
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
-- Database: `elemes`
--

-- --------------------------------------------------------

--
-- Table structure for table `absensi`
--

CREATE TABLE `absensi` (
  `id_absensi` int(11) NOT NULL,
  `id_pertemuan` int(11) DEFAULT NULL,
  `id_mahasiswa` int(11) DEFAULT NULL,
  `status_kehadiran` enum('Hadir','Sakit','Izin','Alfa') NOT NULL,
  `waktu_presensi` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `absensi`
--

INSERT INTO `absensi` (`id_absensi`, `id_pertemuan`, `id_mahasiswa`, `status_kehadiran`, `waktu_presensi`) VALUES
(1, 1, 3, 'Hadir', '2026-03-01 01:02:00'),
(2, 1, 4, 'Hadir', '2026-03-01 01:05:00'),
(3, 1, 5, 'Izin', '2026-03-01 00:45:00'),
(4, 1, 6, 'Hadir', '2026-03-01 01:15:00'),
(5, 2, 3, 'Hadir', '2026-03-08 01:01:00'),
(6, 2, 4, 'Sakit', '2026-03-08 00:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `kelas`
--

CREATE TABLE `kelas` (
  `id_kelas` int(11) NOT NULL,
  `id_matkul` varchar(10) DEFAULT NULL,
  `id_dosen` int(11) DEFAULT NULL,
  `tahun_ajaran` varchar(9) NOT NULL,
  `semester` enum('Ganjil','Genap') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kelas`
--

INSERT INTO `kelas` (`id_kelas`, `id_matkul`, `id_dosen`, `tahun_ajaran`, `semester`) VALUES
(1, 'MK001', 2, '2025/2026', 'Genap'),
(2, 'MK002', 2, '2025/2026', 'Genap');

-- --------------------------------------------------------

--
-- Table structure for table `krs`
--

CREATE TABLE `krs` (
  `id_krs` int(11) NOT NULL,
  `id_kelas` int(11) DEFAULT NULL,
  `id_mahasiswa` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `krs`
--

INSERT INTO `krs` (`id_krs`, `id_kelas`, `id_mahasiswa`) VALUES
(1, 1, 3),
(2, 1, 4),
(3, 1, 5),
(4, 1, 6),
(5, 2, 3),
(6, 2, 4);

-- --------------------------------------------------------

--
-- Table structure for table `mata_kuliah`
--

CREATE TABLE `mata_kuliah` (
  `id_matkul` varchar(10) NOT NULL,
  `nama_matkul` varchar(100) NOT NULL,
  `sks` int(11) NOT NULL,
  `deskripsi` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mata_kuliah`
--

INSERT INTO `mata_kuliah` (`id_matkul`, `nama_matkul`, `sks`, `deskripsi`) VALUES
('MK001', 'Pemrograman Web Next.js', 3, 'Belajar membuat aplikasi web modern dengan React dan Next.js'),
('MK002', 'Sistem Basis Data', 3, 'Perancangan database relasional dan query SQL advanced');

-- --------------------------------------------------------

--
-- Table structure for table `pengumpulan`
--

CREATE TABLE `pengumpulan` (
  `id_submit` int(11) NOT NULL,
  `id_tugas` int(11) DEFAULT NULL,
  `id_mahasiswa` int(11) DEFAULT NULL,
  `file_url` varchar(255) DEFAULT NULL,
  `tanggal_submit` datetime DEFAULT current_timestamp(),
  `nilai` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pertemuan`
--

CREATE TABLE `pertemuan` (
  `id_pertemuan` int(11) NOT NULL,
  `id_kelas` int(11) DEFAULT NULL,
  `pertemuan_ke` int(11) NOT NULL,
  `tanggal_pertemuan` date NOT NULL,
  `topik` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tugas`
--

CREATE TABLE `tugas` (
  `id_tugas` int(11) NOT NULL,
  `id_kelas` int(11) DEFAULT NULL,
  `judul_tugas` varchar(150) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `tenggat_waktu` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `peran` enum('Admin','Dosen','Mahasiswa') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id_user`, `nama`, `email`, `password`, `peran`) VALUES
(1, 'Kelompok 3', 'admin@elemes.com', '123456', 'Admin'),
(2, 'Ferdi Cahyadi, M.T.', 'ferdi@elemes.com', '123456', ''),
(3, 'Kevin Nara', 'kevin@student.com', '123456', ''),
(4, 'David Herliano', 'david@student.com', '123456', ''),
(5, 'Irsyad Utomo', 'irsyad@student.com', '123456', ''),
(6, 'Muhammad Fajri', 'fajri@student.com', '123456', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `absensi`
--
ALTER TABLE `absensi`
  ADD PRIMARY KEY (`id_absensi`),
  ADD KEY `id_pertemuan` (`id_pertemuan`),
  ADD KEY `id_mahasiswa` (`id_mahasiswa`);

--
-- Indexes for table `kelas`
--
ALTER TABLE `kelas`
  ADD PRIMARY KEY (`id_kelas`),
  ADD KEY `id_matkul` (`id_matkul`),
  ADD KEY `id_dosen` (`id_dosen`);

--
-- Indexes for table `krs`
--
ALTER TABLE `krs`
  ADD PRIMARY KEY (`id_krs`),
  ADD KEY `id_kelas` (`id_kelas`),
  ADD KEY `id_mahasiswa` (`id_mahasiswa`);

--
-- Indexes for table `mata_kuliah`
--
ALTER TABLE `mata_kuliah`
  ADD PRIMARY KEY (`id_matkul`);

--
-- Indexes for table `pengumpulan`
--
ALTER TABLE `pengumpulan`
  ADD PRIMARY KEY (`id_submit`),
  ADD KEY `id_tugas` (`id_tugas`),
  ADD KEY `id_mahasiswa` (`id_mahasiswa`);

--
-- Indexes for table `pertemuan`
--
ALTER TABLE `pertemuan`
  ADD PRIMARY KEY (`id_pertemuan`),
  ADD KEY `id_kelas` (`id_kelas`);

--
-- Indexes for table `tugas`
--
ALTER TABLE `tugas`
  ADD PRIMARY KEY (`id_tugas`),
  ADD KEY `id_kelas` (`id_kelas`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `absensi`
--
ALTER TABLE `absensi`
  MODIFY `id_absensi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `kelas`
--
ALTER TABLE `kelas`
  MODIFY `id_kelas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `krs`
--
ALTER TABLE `krs`
  MODIFY `id_krs` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
