-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: farmi_qly
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

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
-- Table structure for table `chi_tiet_don_hang`
--

DROP TABLE IF EXISTS `chi_tiet_don_hang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chi_tiet_don_hang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_don_hang` int(11) DEFAULT NULL,
  `id_san_pham` int(11) DEFAULT NULL,
  `so_luong` int(11) NOT NULL,
  `gia_luc_ban` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_don_hang` (`id_don_hang`),
  KEY `id_san_pham` (`id_san_pham`),
  CONSTRAINT `chi_tiet_don_hang_ibfk_1` FOREIGN KEY (`id_don_hang`) REFERENCES `don_hang` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chi_tiet_don_hang_ibfk_2` FOREIGN KEY (`id_san_pham`) REFERENCES `san_pham` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chi_tiet_don_hang`
--

LOCK TABLES `chi_tiet_don_hang` WRITE;
/*!40000 ALTER TABLE `chi_tiet_don_hang` DISABLE KEYS */;
INSERT INTO `chi_tiet_don_hang` VALUES (1,1,8,1,60000.00),(2,1,6,1,18000.00),(3,2,5,1,16000.00),(4,3,6,1,18000.00),(5,3,5,1,16000.00),(6,4,6,1,18000.00),(7,5,7,1,55000.00),(8,5,5,1,16000.00),(9,5,2,1,75000.00),(10,6,17,1,65000.00),(11,7,3,1,11000.00),(12,8,6,1,18000.00);
/*!40000 ALTER TABLE `chi_tiet_don_hang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `danh_muc`
--

DROP TABLE IF EXISTS `danh_muc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `danh_muc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ten_danh_muc` varchar(100) NOT NULL,
  `mo_ta` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Phân loại các loại rau củ quả';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `danh_muc`
--

LOCK TABLES `danh_muc` WRITE;
/*!40000 ALTER TABLE `danh_muc` DISABLE KEYS */;
INSERT INTO `danh_muc` VALUES (1,'Rau lá xanh',''),(3,'Quả ','quả tươi ngon\r\n'),(4,'Củ','\r\n'),(5,'Nấm','\r\n');
/*!40000 ALTER TABLE `danh_muc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `don_hang`
--

DROP TABLE IF EXISTS `don_hang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `don_hang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_nguoi_dung` int(11) DEFAULT NULL,
  `id_khach_hang` int(11) DEFAULT NULL,
  `tong_tien_hang` decimal(15,2) DEFAULT NULL,
  `so_tien_giam` decimal(15,2) DEFAULT 0.00,
  `tong_thanh_toan` decimal(15,2) DEFAULT NULL,
  `phuong_thuc_tt` enum('tien_mat','chuyen_khoan') DEFAULT 'tien_mat',
  `trang_thai` enum('cho','xong','huy') DEFAULT 'xong',
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `id_nguoi_dung` (`id_nguoi_dung`),
  KEY `id_khach_hang` (`id_khach_hang`),
  CONSTRAINT `don_hang_ibfk_1` FOREIGN KEY (`id_nguoi_dung`) REFERENCES `nguoi_dung` (`id`),
  CONSTRAINT `don_hang_ibfk_2` FOREIGN KEY (`id_khach_hang`) REFERENCES `khach_hang` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `don_hang`
--

LOCK TABLES `don_hang` WRITE;
/*!40000 ALTER TABLE `don_hang` DISABLE KEYS */;
INSERT INTO `don_hang` VALUES (1,NULL,NULL,78000.00,48000.00,30000.00,'tien_mat','xong','2026-04-19 08:04:15'),(2,NULL,NULL,16000.00,0.00,16000.00,'tien_mat','xong','2026-04-19 08:25:14'),(3,2,NULL,34000.00,0.00,34000.00,'tien_mat','xong','2026-04-19 08:40:19'),(4,1,NULL,18000.00,15840.00,2160.00,'tien_mat','xong','2026-04-19 08:46:01'),(5,3,NULL,146000.00,0.00,146000.00,'tien_mat','xong','2026-04-19 17:02:08'),(6,1,NULL,65000.00,0.00,65000.00,'tien_mat','xong','2026-05-09 10:23:11'),(7,1,NULL,11000.00,0.00,11000.00,'chuyen_khoan','xong','2026-05-09 10:30:44'),(8,NULL,NULL,18000.00,0.00,18000.00,'tien_mat','xong','2026-10-14 06:07:29');
/*!40000 ALTER TABLE `don_hang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `khach_hang`
--

DROP TABLE IF EXISTS `khach_hang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `khach_hang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ho_ten` varchar(100) NOT NULL,
  `so_dien_thoai` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `dia_chi` text DEFAULT NULL,
  `diem_tich_luy` int(11) DEFAULT 0,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `so_dien_thoai` (`so_dien_thoai`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khach_hang`
--

LOCK TABLES `khach_hang` WRITE;
/*!40000 ALTER TABLE `khach_hang` DISABLE KEYS */;
INSERT INTO `khach_hang` VALUES (2,'Phạm Thị Thu Huế','0987654321','thuhue@gmail.com','57hn',2,'2026-05-08 16:39:54');
/*!40000 ALTER TABLE `khach_hang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `khuyen_mai`
--

DROP TABLE IF EXISTS `khuyen_mai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `khuyen_mai` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `danh_sach_san_pham` varchar(500) DEFAULT NULL,
  `ma_code` varchar(20) NOT NULL,
  `phan_tram_giam` int(11) DEFAULT NULL,
  `ngay_bat_dau` date DEFAULT NULL,
  `ngay_ket_thuc` date DEFAULT NULL,
  `trang_thai` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ma_code` (`ma_code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khuyen_mai`
--

LOCK TABLES `khuyen_mai` WRITE;
/*!40000 ALTER TABLE `khuyen_mai` DISABLE KEYS */;
INSERT INTO `khuyen_mai` VALUES (1,'8','MB04',80,'2026-04-18','2026-04-21',1),(2,'6','MB01',88,'2026-04-18','2026-04-22',1),(3,'6','MB03',30,'2026-05-08','2026-05-15',1),(4,'2','hihi',50,'2026-04-19','2026-04-20',0),(5,'4','MB02',25,'2026-05-07','2026-05-12',1);
/*!40000 ALTER TABLE `khuyen_mai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lich_su_kho`
--

DROP TABLE IF EXISTS `lich_su_kho`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lich_su_kho` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_san_pham` int(11) DEFAULT NULL,
  `loai_bien_dong` enum('nhap','xuat') NOT NULL,
  `so_luong` int(11) NOT NULL,
  `ly_do` text DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `id_san_pham` (`id_san_pham`),
  CONSTRAINT `lich_su_kho_ibfk_1` FOREIGN KEY (`id_san_pham`) REFERENCES `san_pham` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lich_su_kho`
--

LOCK TABLES `lich_su_kho` WRITE;
/*!40000 ALTER TABLE `lich_su_kho` DISABLE KEYS */;
/*!40000 ALTER TABLE `lich_su_kho` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nguoi_dung`
--

DROP TABLE IF EXISTS `nguoi_dung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nguoi_dung` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ten_dang_nhap` varchar(50) NOT NULL,
  `mat_khau` varchar(255) NOT NULL,
  `ho_ten` varchar(100) DEFAULT NULL,
  `vai_tro` enum('admin','staff') DEFAULT 'staff',
  `trang_thai` tinyint(1) DEFAULT 1,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ten_dang_nhap` (`ten_dang_nhap`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Quản lý tài khoản nhân viên';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nguoi_dung`
--

LOCK TABLES `nguoi_dung` WRITE;
/*!40000 ALTER TABLE `nguoi_dung` DISABLE KEYS */;
INSERT INTO `nguoi_dung` VALUES (1,'admin','123456','Quản Trị Viên','admin',1,'2026-04-18 09:47:19'),(2,'nhanvien1','123456','Nguyễn Văn A','staff',1,'2026-04-18 09:47:19'),(3,'nhanvien2','123456','Trần Thị B','staff',1,'2026-04-18 09:47:19');
/*!40000 ALTER TABLE `nguoi_dung` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nha_cung_cap`
--

DROP TABLE IF EXISTS `nha_cung_cap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nha_cung_cap` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ten_nha_cc` varchar(255) NOT NULL,
  `so_dien_thoai` varchar(20) DEFAULT NULL,
  `dia_chi` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nha_cung_cap`
--

LOCK TABLES `nha_cung_cap` WRITE;
/*!40000 ALTER TABLE `nha_cung_cap` DISABLE KEYS */;
INSERT INTO `nha_cung_cap` VALUES (1,'Rau sạch Đà Lạt','0397616469','Hà Nội, Việt Nam'),(2,'HHH-Footfarm-Công ty THHH Nông trại Thực Phẩm','0968011869','Ngõ 5 Khuất Duy Tiến, Hà Nội, Việt Nam'),(3,'Thực Phẩm Hoàng Đông','02422182181','Phòng 201, Nhà C6, Phường Tương Mai, Hà Nội, Việt Nam'),(4,'Thực Phẩm Trần Văn Hùng','0964737283','Đại Đô, Võng La, Đông Anh, Hà Nội ,Việt Nam'),(5,'Rau củ, Trái cây việt- Công Ty THHH Cung cấp trái cây Việt','0962929739','683 Giải Phóng, Phường Giáp Bát, Quận Hoàng Mai, Hà Nội, Việt Nam');
/*!40000 ALTER TABLE `nha_cung_cap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `san_pham`
--

DROP TABLE IF EXISTS `san_pham`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `san_pham` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_danh_muc` int(11) DEFAULT NULL,
  `ten_san_pham` varchar(200) NOT NULL,
  `anh_san_pham` varchar(255) DEFAULT NULL,
  `gia_nhap` decimal(15,2) DEFAULT 0.00,
  `gia_ban` decimal(15,2) NOT NULL,
  `so_luong_kho` int(11) DEFAULT 0,
  `nguong_canh_bao` int(11) DEFAULT 5,
  `don_vi_tinh` varchar(50) DEFAULT 'kg',
  `trang_thai` tinyint(1) DEFAULT 1,
  `id_nha_cc` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_danh_muc` (`id_danh_muc`),
  CONSTRAINT `san_pham_ibfk_1` FOREIGN KEY (`id_danh_muc`) REFERENCES `danh_muc` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Thông tin chi tiết hàng hóa';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `san_pham`
--

LOCK TABLES `san_pham` WRITE;
/*!40000 ALTER TABLE `san_pham` DISABLE KEYS */;
INSERT INTO `san_pham` VALUES (1,4,'Tỏi lý sơn','1778320429_69ff042d90812.jpg',0.00,180000.00,60,5,'kg',0,4),(2,4,'Gừng tươi','1778320451_69ff0443696c6.jpg',0.00,75000.00,8,5,'kg',1,1),(3,1,'Rau lang','1778320461_69ff044dc3b04.jpg',0.00,11000.00,33,5,'kg',1,2),(4,3,'Khổ qua','1778320475_69ff045bd1577.jpg',0.00,38000.00,14,5,'kg',1,1),(5,3,'Bầu xanh','1778321122_69ff06e29c963.jpg',0.00,16000.00,22,5,'kg',1,4),(6,3,'Mướp hương','1778321107_69ff06d32dbf1.jpg',0.00,18000.00,26,5,'kg',1,1),(7,1,'Cần tây mỹ','1778320847_69ff05cf7dfa5.jpg',0.00,55000.00,10,5,'kg',1,1),(8,3,'Ớt chuông đỏ','1778320830_69ff05be91cb2.jpg',0.00,60000.00,9,5,'kg',1,3),(9,3,'Ngô Ngọt','1778320815_69ff05af91b4f.jpg',0.00,22000.00,55,5,'kg',1,3),(10,4,'Hành Tây','1778320802_69ff05a23ec4e.jpg',0.00,60000.00,14,5,'kg',1,3),(11,4,'Cà rốt','1778320785_69ff0591218f1.jpg',0.00,45000.00,65,5,'kg',1,4),(12,1,'Bông cải trắng','1778320769_69ff05817623b.jpg',0.00,55000.00,54,5,'kg',1,3),(13,4,'Khoai Sọ','1778320756_69ff0574082e7.jpg',0.00,65000.00,80,5,'kg',1,3),(14,4,'Khoai Lang','1778320742_69ff05665ed9c.jpg',0.00,60000.00,75,5,'kg',1,3),(15,4,'Khoai Tây','1778320716_69ff054cbc22f.jpg',0.00,55000.00,90,5,'kg',1,3),(16,3,'Đậu cove','1778320705_69ff054198565.jpg',0.00,69000.00,45,5,'kg',1,2),(17,4,'Củ Dền','1778320693_69ff0535ba1ef.jpg',0.00,65000.00,44,5,'kg',1,3),(18,3,'Cà chua','1778320684_69ff052c327ce.jpg',0.00,45000.00,20,5,'kg',1,3),(19,1,'Cải Thảo','1778320675_69ff0523b8043.jpg',0.00,40000.00,35,5,'kg',1,2),(20,1,'Bắp Cải','1778320643_69ff05030f264.png',0.00,35000.00,65,5,'kg',1,4);
/*!40000 ALTER TABLE `san_pham` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-14 13:55:00
