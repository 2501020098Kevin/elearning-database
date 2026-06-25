-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 24, 2026 at 02:29 PM
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
(1, 1, 3, 'Hadir', '2026-06-23 15:11:36'),
(2, 1, 4, 'Hadir', '2026-06-23 15:11:36'),
(3, 1, 5, 'Hadir', '2026-06-23 15:11:36'),
(4, 1, 6, 'Hadir', '2026-06-23 15:11:36'),
(5, 2, 3, 'Hadir', '2026-06-23 15:11:36'),
(6, 2, 4, 'Sakit', '2026-06-23 15:11:36'),
(7, 2, 5, 'Hadir', '2026-06-23 15:11:36'),
(8, 2, 6, 'Izin', '2026-06-23 15:11:36');

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
(1, 'INF201', 2, '2025/2026', 'Genap');

-- --------------------------------------------------------

--
-- Table structure for table `krs`
--

CREATE TABLE `krs` (
  `id_krs` int(11) NOT NULL,
  `id_kelas` int(11) DEFAULT NULL,
  `id_mahasiswa` int(11) DEFAULT NULL,
  `status_krs` enum('Pending','Diterima','Ditolak') DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `krs`
--

INSERT INTO `krs` (`id_krs`, `id_kelas`, `id_mahasiswa`, `status_krs`) VALUES
(1, 1, 3, 'Pending'),
(2, 1, 4, 'Pending'),
(3, 1, 5, 'Pending'),
(4, 1, 6, 'Pending'),
(5, 1, 3, 'Diterima'),
(6, 1, 4, 'Diterima'),
(7, 1, 5, 'Diterima'),
(8, 1, 6, 'Diterima');

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
('INF201', 'Sistem Basis Data', 3, 'Belajar perancangan SQL dan NoSQL');

-- --------------------------------------------------------

--
-- Table structure for table `materi_kuliah`
--

CREATE TABLE `materi_kuliah` (
  `id_materi` int(11) NOT NULL,
  `id_pertemuan` int(11) DEFAULT NULL,
  `judul_materi` varchar(150) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `tipe_file` enum('PDF','PPTX','Video','Link_Eksternal') NOT NULL,
  `file_url` varchar(255) NOT NULL,
  `tanggal_upload` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `materi_kuliah`
--

INSERT INTO `materi_kuliah` (`id_materi`, `id_pertemuan`, `judul_materi`, `deskripsi`, `tipe_file`, `file_url`, `tanggal_upload`) VALUES
(1, 1, 'Slide Pengenalan ERD', 'Materi dasar perancangan database.', 'PPTX', 'https://storage.univ.ac.id/materi/erd_dasar.pptx', '2026-06-23 15:10:36'),
(2, 2, 'Modul PDF Normalisasi', 'Panduan mendalam mengenai 1NF hingga 3NF.', 'PDF', 'https://storage.univ.ac.id/materi/normalisasi.pdf', '2026-06-23 15:10:36');

-- --------------------------------------------------------

--
-- Table structure for table `nilai_akhir`
--

CREATE TABLE `nilai_akhir` (
  `id_nilai` int(11) NOT NULL,
  `id_kelas` int(11) DEFAULT NULL,
  `id_mahasiswa` int(11) DEFAULT NULL,
  `nilai_tugas` decimal(5,2) DEFAULT 0.00,
  `nilai_absensi` decimal(5,2) DEFAULT 0.00,
  `nilai_uts` decimal(5,2) DEFAULT 0.00,
  `nilai_uas` decimal(5,2) DEFAULT 0.00,
  `nilai_angka` decimal(5,2) GENERATED ALWAYS AS (`nilai_absensi` * 0.10 + `nilai_tugas` * 0.20 + `nilai_uts` * 0.30 + `nilai_uas` * 0.40) STORED,
  `nilai_huruf` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nilai_akhir`
--

INSERT INTO `nilai_akhir` (`id_nilai`, `id_kelas`, `id_mahasiswa`, `nilai_tugas`, `nilai_absensi`, `nilai_uts`, `nilai_uas`, `nilai_huruf`) VALUES
(3, 1, 3, 88.00, 95.00, 85.00, 80.00, NULL),
(4, 1, 4, 85.00, 90.00, 80.00, 82.00, NULL),
(5, 1, 5, 92.00, 100.00, 90.00, 88.00, NULL),
(6, 1, 6, 80.00, 85.00, 75.00, 78.00, NULL);

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

--
-- Dumping data for table `pengumpulan`
--

INSERT INTO `pengumpulan` (`id_submit`, `id_tugas`, `id_mahasiswa`, `file_url`, `tanggal_submit`, `nilai`) VALUES
(1, 1, 3, 'https://storage.univ.ac.id/tugas/david_erd.pdf', '2026-06-23 22:12:34', 88.00),
(2, 1, 4, 'https://storage.univ.ac.id/tugas/kevin_erd.pdf', '2026-06-23 22:12:34', 85.00),
(3, 1, 5, 'https://storage.univ.ac.id/tugas/irsyad_erd.pdf', '2026-06-23 22:12:34', 92.00),
(4, 1, 6, 'https://storage.univ.ac.id/tugas/fajri_erd.pdf', '2026-06-23 22:12:34', 80.00);

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

--
-- Dumping data for table `pertemuan`
--

INSERT INTO `pertemuan` (`id_pertemuan`, `id_kelas`, `pertemuan_ke`, `tanggal_pertemuan`, `topik`) VALUES
(1, 1, 1, '2026-03-02', 'Pengenalan Entity Relationship Diagram (ERD)'),
(2, 1, 2, '2026-03-09', 'Normalisasi Basis Data (1NF, 2NF, 3NF)');

-- --------------------------------------------------------

--
-- Table structure for table `tugas`
--

CREATE TABLE `tugas` (
  `id_tugas` int(11) NOT NULL,
  `id_kelas` int(11) DEFAULT NULL,
  `judul_tugas` varchar(150) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `tenggat_waktu` datetime NOT NULL,
  `bobot` int(11) NOT NULL DEFAULT 10
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tugas`
--

INSERT INTO `tugas` (`id_tugas`, `id_kelas`, `judul_tugas`, `deskripsi`, `tenggat_waktu`, `bobot`) VALUES
(1, 1, 'Tugas 1: Membuat ERD Toko Online', 'Buatlah ERD lengkap dengan atribut beserta kardinalitasnya.', '2026-03-15 23:59:59', 10);

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
(1, 'Admin E-Learning', 'admin@univ.ac.id', '123456', 'Admin'),
(2, 'Ferdi Cahyadi, M.T', 'ferdi@univ.ac.id', '123456', 'Dosen'),
(3, 'David Herliano', 'david@student.univ.ac.id', '123456', 'Mahasiswa'),
(4, 'Kevin Nara', 'kevin@student.univ.ac.id', '123456', 'Mahasiswa'),
(5, 'Irsyad Utomo', 'irsyad@student.univ.ac.id', '123456', 'Mahasiswa'),
(6, 'Muhammad Fajri', 'fajri@student.univ.ac.id', '123456', 'Mahasiswa');

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
-- Indexes for table `materi_kuliah`
--
ALTER TABLE `materi_kuliah`
  ADD PRIMARY KEY (`id_materi`),
  ADD KEY `id_pertemuan` (`id_pertemuan`);

--
-- Indexes for table `nilai_akhir`
--
ALTER TABLE `nilai_akhir`
  ADD PRIMARY KEY (`id_nilai`),
  ADD UNIQUE KEY `unique_mhs_kelas` (`id_kelas`,`id_mahasiswa`),
  ADD KEY `id_mahasiswa` (`id_mahasiswa`);

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
  MODIFY `id_absensi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `kelas`
--
ALTER TABLE `kelas`
  MODIFY `id_kelas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `krs`
--
ALTER TABLE `krs`
  MODIFY `id_krs` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `materi_kuliah`
--
ALTER TABLE `materi_kuliah`
  MODIFY `id_materi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `nilai_akhir`
--
ALTER TABLE `nilai_akhir`
  MODIFY `id_nilai` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `pengumpulan`
--
ALTER TABLE `pengumpulan`
  MODIFY `id_submit` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `pertemuan`
--
ALTER TABLE `pertemuan`
  MODIFY `id_pertemuan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tugas`
--
ALTER TABLE `tugas`
  MODIFY `id_tugas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `absensi`
--
ALTER TABLE `absensi`
  ADD CONSTRAINT `absensi_ibfk_1` FOREIGN KEY (`id_pertemuan`) REFERENCES `pertemuan` (`id_pertemuan`) ON DELETE CASCADE,
  ADD CONSTRAINT `absensi_ibfk_2` FOREIGN KEY (`id_mahasiswa`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `kelas`
--
ALTER TABLE `kelas`
  ADD CONSTRAINT `kelas_ibfk_1` FOREIGN KEY (`id_matkul`) REFERENCES `mata_kuliah` (`id_matkul`) ON DELETE CASCADE,
  ADD CONSTRAINT `kelas_ibfk_2` FOREIGN KEY (`id_dosen`) REFERENCES `users` (`id_user`) ON DELETE SET NULL;

--
-- Constraints for table `krs`
--
ALTER TABLE `krs`
  ADD CONSTRAINT `krs_ibfk_1` FOREIGN KEY (`id_kelas`) REFERENCES `kelas` (`id_kelas`) ON DELETE CASCADE,
  ADD CONSTRAINT `krs_ibfk_2` FOREIGN KEY (`id_mahasiswa`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `materi_kuliah`
--
ALTER TABLE `materi_kuliah`
  ADD CONSTRAINT `materi_kuliah_ibfk_1` FOREIGN KEY (`id_pertemuan`) REFERENCES `pertemuan` (`id_pertemuan`) ON DELETE CASCADE;

--
-- Constraints for table `nilai_akhir`
--
ALTER TABLE `nilai_akhir`
  ADD CONSTRAINT `nilai_akhir_ibfk_1` FOREIGN KEY (`id_kelas`) REFERENCES `kelas` (`id_kelas`) ON DELETE CASCADE,
  ADD CONSTRAINT `nilai_akhir_ibfk_2` FOREIGN KEY (`id_mahasiswa`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `pengumpulan`
--
ALTER TABLE `pengumpulan`
  ADD CONSTRAINT `pengumpulan_ibfk_1` FOREIGN KEY (`id_tugas`) REFERENCES `tugas` (`id_tugas`) ON DELETE CASCADE,
  ADD CONSTRAINT `pengumpulan_ibfk_2` FOREIGN KEY (`id_mahasiswa`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `pertemuan`
--
ALTER TABLE `pertemuan`
  ADD CONSTRAINT `pertemuan_ibfk_1` FOREIGN KEY (`id_kelas`) REFERENCES `kelas` (`id_kelas`) ON DELETE CASCADE;

--
-- Constraints for table `tugas`
--
ALTER TABLE `tugas`
  ADD CONSTRAINT `tugas_ibfk_1` FOREIGN KEY (`id_kelas`) REFERENCES `kelas` (`id_kelas`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
