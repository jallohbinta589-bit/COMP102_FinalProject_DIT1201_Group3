-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 19, 2026 at 08:18 PM
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
-- Database: `publichealthclinicdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `clinic_visit`
--

CREATE TABLE `clinic_visit` (
  `visit_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `visit_date` date NOT NULL,
  `chief_complaint` varchar(300) NOT NULL,
  `visit_status` enum('Open','Closed','Follow-up') DEFAULT 'Open'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clinic_visit`
--

INSERT INTO `clinic_visit` (`visit_id`, `patient_id`, `staff_id`, `visit_date`, `chief_complaint`, `visit_status`) VALUES
(1, 1, 1, '2026-06-01', 'Fever and headache', 'Open'),
(2, 2, 2, '2026-06-02', 'Persistent cough', 'Open'),
(3, 3, 3, '2026-06-03', 'Stomach pain', 'Open');

-- --------------------------------------------------------

--
-- Table structure for table `health_staff`
--

CREATE TABLE `health_staff` (
  `staff_id` int(11) NOT NULL,
  `full_name` varchar(120) NOT NULL,
  `designation` varchar(80) NOT NULL,
  `department` varchar(80) NOT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `years_experience` tinyint(4) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `health_staff`
--

INSERT INTO `health_staff` (`staff_id`, `full_name`, `designation`, `department`, `contact_number`, `years_experience`, `is_active`) VALUES
(1, 'Dr. John Kanu', 'Doctor', 'General Medicine', '075111111', 10, 1),
(2, 'Nurse Hawa Conteh', 'Nurse', 'Outpatient', '075222222', 6, 1),
(3, 'Dr. Ibrahim Koroma', 'Doctor', 'Pediatrics', '075333333', 8, 1);

-- --------------------------------------------------------

--
-- Table structure for table `medical_record`
--

CREATE TABLE `medical_record` (
  `record_id` int(11) NOT NULL,
  `visit_id` int(11) NOT NULL,
  `condition_name` varchar(200) NOT NULL,
  `symptoms` text DEFAULT NULL,
  `treatment_given` text DEFAULT NULL,
  `follow_up_required` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `medical_record`
--

INSERT INTO `medical_record` (`record_id`, `visit_id`, `condition_name`, `symptoms`, `treatment_given`, `follow_up_required`) VALUES
(4, 1, 'Malaria', 'Fever, headache', 'Antimalarial drugs', 1),
(5, 2, 'Flu', 'Cough, cold', 'Flu medication', 0),
(6, 3, 'Gastritis', 'Abdominal pain', 'Antacid treatment', 1);

-- --------------------------------------------------------

--
-- Table structure for table `medication`
--

CREATE TABLE `medication` (
  `medication_id` int(11) NOT NULL,
  `record_id` int(11) NOT NULL,
  `medication_name` varchar(150) NOT NULL,
  `category` varchar(80) NOT NULL,
  `stock_quantity` int(11) DEFAULT 0,
  `expiry_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `medication`
--

INSERT INTO `medication` (`medication_id`, `record_id`, `medication_name`, `category`, `stock_quantity`, `expiry_date`) VALUES
(4, 4, 'Coartem', 'Antimalarial', 50, '2027-01-01'),
(5, 5, 'Paracetamol', 'Pain Relief', 100, '2027-05-01'),
(6, 6, 'Omeprazole', 'Gastrointestinal', 70, '2027-03-01');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `patient_id` int(11) NOT NULL,
  `full_name` varchar(120) NOT NULL,
  `date_of_birth` date NOT NULL,
  `sex` enum('Male','Female','Other') NOT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `home_address` varchar(250) DEFAULT NULL,
  `registered_on` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`patient_id`, `full_name`, `date_of_birth`, `sex`, `contact_number`, `home_address`, `registered_on`) VALUES
(1, 'Mariama Kamara', '2000-05-15', 'Female', '079999999', 'Freetown', '2026-06-11'),
(2, 'Abdul Sesay', '1998-03-10', 'Male', '077234567', 'Bo', '2026-06-11'),
(3, 'Fatmata Bangura', '2002-11-21', 'Female', '078345678', 'Kenema', '2026-06-11');

-- --------------------------------------------------------

--
-- Table structure for table `prescription`
--

CREATE TABLE `prescription` (
  `prescription_id` int(11) NOT NULL,
  `record_id` int(11) NOT NULL,
  `issue_date` date NOT NULL,
  `drug_name` varchar(150) NOT NULL,
  `dosage_instructions` varchar(300) NOT NULL,
  `duration_days` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `prescription`
--

INSERT INTO `prescription` (`prescription_id`, `record_id`, `issue_date`, `drug_name`, `dosage_instructions`, `duration_days`) VALUES
(4, 4, '2026-06-01', 'Coartem', '2 tablets twice daily', 3),
(5, 5, '2026-06-02', 'Paracetamol', '1 tablet every 8 hours', 5),
(6, 6, '2026-06-03', 'Omeprazole', '1 capsule daily', 14);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `clinic_visit`
--
ALTER TABLE `clinic_visit`
  ADD PRIMARY KEY (`visit_id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indexes for table `health_staff`
--
ALTER TABLE `health_staff`
  ADD PRIMARY KEY (`staff_id`);

--
-- Indexes for table `medical_record`
--
ALTER TABLE `medical_record`
  ADD PRIMARY KEY (`record_id`),
  ADD KEY `visit_id` (`visit_id`);

--
-- Indexes for table `medication`
--
ALTER TABLE `medication`
  ADD PRIMARY KEY (`medication_id`),
  ADD KEY `record_id` (`record_id`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`patient_id`);

--
-- Indexes for table `prescription`
--
ALTER TABLE `prescription`
  ADD PRIMARY KEY (`prescription_id`),
  ADD KEY `record_id` (`record_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `clinic_visit`
--
ALTER TABLE `clinic_visit`
  MODIFY `visit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `health_staff`
--
ALTER TABLE `health_staff`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `medical_record`
--
ALTER TABLE `medical_record`
  MODIFY `record_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `medication`
--
ALTER TABLE `medication`
  MODIFY `medication_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `patient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `prescription`
--
ALTER TABLE `prescription`
  MODIFY `prescription_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `clinic_visit`
--
ALTER TABLE `clinic_visit`
  ADD CONSTRAINT `clinic_visit_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  ADD CONSTRAINT `clinic_visit_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `health_staff` (`staff_id`);

--
-- Constraints for table `medical_record`
--
ALTER TABLE `medical_record`
  ADD CONSTRAINT `medical_record_ibfk_1` FOREIGN KEY (`visit_id`) REFERENCES `clinic_visit` (`visit_id`);

--
-- Constraints for table `medication`
--
ALTER TABLE `medication`
  ADD CONSTRAINT `medication_ibfk_1` FOREIGN KEY (`record_id`) REFERENCES `medical_record` (`record_id`);

--
-- Constraints for table `prescription`
--
ALTER TABLE `prescription`
  ADD CONSTRAINT `prescription_ibfk_1` FOREIGN KEY (`record_id`) REFERENCES `medical_record` (`record_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
