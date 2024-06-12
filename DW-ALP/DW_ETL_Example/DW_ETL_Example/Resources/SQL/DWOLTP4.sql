CREATE DATABASE oltp4;


USE oltp4;


drop table if exists `user`;
CREATE TABLE IF NOT EXISTS `user` (
    ID_user varchar(100) PRIMARY KEY,
        user_role varchar(100) not null,
    username varchar(100) NOT NULL,
    `password` varchar(100) NOT NULL,
    email varchar(100) NOT NULL,
    sub_date timestamp,
    statusdel varchar(1) NOT NULL DEFAULT 'F',
    is_warehouse BOOL DEFAULT 0
);

drop table if exists keranjang;
CREATE TABLE IF NOT EXISTS keranjang (
    ID_keranjang varchar(100) PRIMARY KEY,
    ID_user varchar(100) REFERENCES `user`(ID_user), -- user pelanggan
    ID_catalog varchar(100) REFERENCES catalog(ID_catalog),
    harga int,
    statusdel varchar(1) NOT NULL DEFAULT 'F',
    is_warehouse BOOL DEFAULT 0
);

drop table if exists wishlist;
CREATE TABLE IF NOT EXISTS wishlist (
	ID_wishlist varchar(100) PRIMARY KEY,
	ID_user varchar(100) REFERENCES `user`(ID_user),
    ID_catalog varchar(100) REFERENCES catalog(ID_catalog),
	harga int,
    statusdel varchar(1) NOT NULL DEFAULT 'F',
    is_warehouse BOOL DEFAULT 0
);

drop table if exists transaksi;
CREATE TABLE IF NOT EXISTS transaksi (
    ID_transaksi varchar(100) PRIMARY KEY,
	ID_catalog varchar(100) REFERENCES catalog(ID_catalog),
    transaksi_date timestamp,
    ID_user varchar(100) REFERENCES `user`(ID_user), -- user pelanggan
    harga int NOT NULL,
    deskripsi varchar (100),
    statusbyr varchar (1) NOT NULL DEFAULT 'F',
    statustrans varchar (1) NOT NULL DEFAULT 'F',
    statusdel varchar(1) NOT NULL DEFAULT 'F',
    is_warehouse BOOL DEFAULT 0
);

drop table if exists games;
CREATE TABLE IF NOT EXISTS games (
    ID_game varchar(100) PRIMARY KEY,
    game_name varchar(100) NOT NULL,
    `description` varchar(10000) NOT NULL,
    genre varchar(100) NOT NULL,
    img varchar(100) not null,
    statusdel varchar(1) NOT NULL DEFAULT 'F',
    is_warehouse BOOL DEFAULT 0
);

drop table if exists catalog;
CREATE TABLE IF NOT EXISTS catalog (
	ID_catalog varchar (100) primary key, 
	ID_game varchar(100) REFERENCES games(ID_game),
	ID_user varchar(100) REFERENCES `user`(ID_user), -- user joki
    product_name varchar(100) NOT NULL,
    `description` varchar(100) NOT NULL,
     harga int NOT NULL,
     imgproduct varchar (100) not null,
    statusdel varchar(1) NOT NULL DEFAULT 'F',
    is_warehouse BOOL DEFAULT 0
);

drop table if exists review;
CREATE TABLE IF NOT EXISTS review (
    ID_review varchar(100) PRIMARY KEY,
    ID_user varchar(100) REFERENCES `user`(ID_user),
	ID_catalog varchar(100) REFERENCES catalog(ID_catalog),
    review_date timestamp,
    rating float,
    review_text varchar(100),
    statusdel varchar(1) NOT NULL DEFAULT 'F',
    is_warehouse BOOL DEFAULT 0
);

INSERT INTO `user` (ID_user, user_role, username, `password`, email, sub_date) VALUES
('U0001', 'User', 'john_doe', 'password123', 'john_doe@gmail.com', '2024-05-01 09:15:50'),
('U0002', 'User', 'jane_smith', 'hello_world', 'jane_smith@gmail.com', '2024-05-01 10:15:50'),
('U0003', 'Admin', 'alex_jones', 'admin123', 'alex_jones@gmail.com', '2024-05-01 12:15:50'),
('U0004', 'Admin', 'emily_williams', 'welcome123', 'emily_williams@gmail.com', '2024-05-01 14:15:50'),
('U0005', 'Joki', 'michael_brown', 'mikeb123', 'michael_brown@gmail.com', '2024-05-02 09:20:50'),
('U0006', 'User', 'samantha_taylor', 'sammyt123', 'samantha_taylor@gmail.com', '2024-05-02 10:20:50'),
('U0007', 'User', 'david_clark', 'davidc123', 'david_clark@gmail.com', '2024-05-02 11:20:50'),
('U0008', 'Joki', 'lisa_martin', 'lisam123', 'lisa_martin@gmail.com', '2024-05-02 12:20:50'),
('U0009', 'Joki', 'peter_thompson', 'petert123', 'peter_thompson@gmail.com', '2024-05-03 08:20:50'),
('U0010', 'User', 'sarah_anderson', 'sara123', 'sarah_anderson@gmail.com', '2024-05-03 09:20:50'),
('U0011', 'User', 'matt_davis', 'mattd123', 'matt_davis@gmail.com', '2024-05-03 10:20:50'),
('U0012', 'Joki', 'katie_jackson', 'katiej123', 'katie_jackson@gmail.com', '2024-05-03 11:20:50'),
('U0013', 'Joki', 'chris_roberts', 'chrisr123', 'chris_roberts@gmail.com', '2024-05-03 12:20:50'),
('U0014', 'User', 'jennifer_evans', 'jennifere123', 'jennifer_evans@gmail.com', '2024-05-03 13:20:50'),
('U0015', 'User', 'ryan_wilson', 'ryanw123', 'ryan_wilson@gmail.com', '2024-05-03 14:20:50');

INSERT INTO games (ID_game, game_name, `description`, genre, img) VALUES
('G0001', 'Counter-Strike', 'Sebuah permainan first-person shooter (FPS) di mana pemain memilih menjadi bagian dari tim teroris atau tim counter-teroris untuk menyelesaikan tujuan-tujuan tertentu.', 'Action', 'Counter-Strike.jpg'),
('G0002', 'Warcraft III: Reign of Chaos', 'Permainan strategi real-time (RTS) yang menggabungkan elemen-elemen strategi dan fantasi dalam pertempuran antar ras.', 'Strategy', 'Warcraft_III_Reign_of_Chaos.jpg'),
('G0003', 'The Sims', 'Permainan simulasi kehidupan yang memungkinkan pemain untuk mengendalikan kehidupan virtual dari karakter-karakternya dalam berbagai situasi.', 'Simulation', 'The_Sims.jpg'),
('G0004', 'Grand Theft Auto: Vice City', 'Sebuah permainan aksi-petualangan yang berlatar di kota fiksi Vice City pada tahun 1980-an, menampilkan cerita tentang kejahatan, korupsi, dan petualangan.', 'Action', 'Grand_Theft_Auto_Vice_City.jpg'),
('G0005', 'Age of Empires II', 'Permainan strategi real-time (RTS) yang menempatkan pemain dalam peran pemimpin suatu peradaban untuk membangun kota, mengumpulkan sumber daya, dan mengalahkan musuh.', 'Strategy', 'Age_of_Empires_II.jpg'),
('G0006', 'Diablo II', 'Sebuah permainan role-playing action (RPG) yang menghadirkan petualangan gelap di dunia Sanctuary, di mana pemain bertarung melawan iblis dan monster.', 'RPG', 'Diablo_II.jpg'),
('G0007', 'Need for Speed: Underground', 'Permainan balapan mobil yang berfokus pada balapan jalanan ilegal dan modifikasi kendaraan, menampilkan beragam mobil keren dan jalan-jalan kota yang ramai.', 'Racing', 'Need_for_Speed_Underground.jpg'),
('G0008', 'Tony Hawks Pro Skater 3', 'Permainan olahraga ekstrem yang memungkinkan pemain mengendalikan karakter skateboard mereka dalam berbagai level yang menantang.', 'Sports', 'Tony_Hawks_Pro_Skater_3.jpg'),
('G0009', 'Max Payne', 'Sebuah permainan aksi-petualangan dengan sudut pandang orang ketiga (TPS) yang mengikuti kisah mantan detektif Max Payne dalam pencariannya untuk membalas dendam.', 'Action', 'Max_Payne.jpg'),
('G0010', 'Final Fantasy X', 'Permainan peran (RPG) yang mengikuti petualangan Tidus, seorang pemain blitzball, dan Yuna, seorang summoner, dalam upaya mereka untuk menyelamatkan dunia Spira dari ancaman Sin.', 'RPG', 'Final_Fantasy_X.jpg'),
('G0011', 'Pro Evolution Soccer 3', 'Permainan simulasi sepak bola yang menawarkan pengalaman bermain sepak bola yang realistis dengan beragam mode permainan dan fitur.', 'Sports', 'Pro_Evolution_Soccer_3.jpg'),
('G0012', 'Hitman 2: Silent Assassin', 'Permainan stealth action yang mengikuti kisah pembunuh bayaran terkenal, Agent 47, dalam misi-misi untuk membersihkan nama baiknya dan mengungkap konspirasi yang lebih besar.', 'Action', 'Hitman_2_Silent_Assassin.jpg'),
('G0013', 'Half-Life', 'Permainan first-person shooter (FPS) yang mengikuti petualangan ilmuwan fisika Gordon Freeman saat ia berjuang melawan invasi makhluk asing yang disebut Combine.', 'Action', 'Half-Life.jpg'),
('G0014', 'Medal of Honor: Allied Assault', 'Permainan first-person shooter (FPS) yang menempatkan pemain dalam peran tentara Amerika Serikat yang berjuang dalam pertempuran-pertempuran penting di Eropa selama Perang Dunia II.', 'Action', 'Medal_of_Honor_Allied_Assault.jpg'),
('G0015', 'Command & Conquer: Red Alert 2', 'Permainan strategi real-time (RTS) yang menggabungkan elemen-elemen strategi dan fiksi ilmiah dalam pertempuran antara Sekutu dan Pakta Warsawa.', 'Strategy', 'Command_&_Conquer_Red_Alert_2.jpg');

INSERT INTO catalog (ID_catalog, ID_game, ID_user, product_name, `description`, harga, imgproduct) VALUES
('L0001', 'G0014', 'U0003', 'Campaign Done', '100% game selesai', 150000, 'Campaign_Done.jfif'),
('L0002', 'G0001', 'U0003', 'CS Pro Package', 'Peningkatan skill dan rank dalam Counter Strike', 110000, 'CS_Pro_Package.jfif'),
('L0003', 'G0005', 'U0003', 'History Builder', 'Bangun area dalam AOE II', 85000, 'History_Builder.jfif'),
('L0004', 'G0003', 'U0012', 'Island Paradise', 'Buat pulau di Sims', 105000, 'Island_Paradise.jfif'),
('L0005', 'G0015', 'U0005', 'Heroic Actions', 'Menangkan pertempuran Strategy di Command & Conquer', 115000, 'Heroic_Actions.jfif'),
('L0006', 'G0006', 'U0005', 'Diablo Dominator', 'Kalahkan semua dalam Diablo II', 100000, 'Diablo_Dominator.jfif'),
('L0007', 'G0010', 'U0005', 'Monster Slayer', 'Hancurkan semua monster', 125000, 'Monster_Slayer.jfif'),
('L0008', 'G0011', 'U0013', 'Soccer Star', 'Bawa timmu ke kemenangan dalam PES 3', 95000, 'Soccer_Star.jfif'),
('L0009', 'G0004', 'U0013', 'Crime Boss', 'Kuasai kota dalam GTA Vice City', 120000, 'Crime_Boss.jfif'),
('L0010', 'G0003', 'U0011', 'Building Champion', 'Bangun Rumah EPIC di Sims', 130000, 'Building_Champion.jfif'),
('L0011', 'G0002', 'U0011', 'Tactical Mastermind', 'Menangkan pertempuran dalam Warcraft III', 100000, 'Tactical_Mastermind.jfif'),
('L0012', 'G0012', 'U0011', 'Hitman Expert', 'Kalahkan semua dalam Hitman', 115000, 'Hitman_Expert.jfif'),
('L0013', 'G0002', 'U0004', 'Legendary Adventurer', 'Petualang legendaris di Warcraft', 135000, 'Legendary_Adventurer.jfif'),
('L0014', 'G0010', 'U0004', 'Legend of the Rift', 'Capai level tertinggi dalam PES', 95000, 'Legend_of_the_Rift.jfif'),
('L0015', 'G0015', 'U0004', 'Strategic Commander', 'Kalahkan musuh dengan strategi di C&C', 105000, 'Strategic_Commander.jfif');

INSERT INTO keranjang (ID_keranjang, ID_user, ID_catalog, harga) VALUES
('K0001', 'U0002', 'L0001', 150000),
('K0002', 'U0001', 'L0002', 110000),
('K0003', 'U0003', 'L0003', 85000),
('K0004', 'U0004', 'L0004', 105000),
('K0005', 'U0005', 'L0005', 115000),
('K0006', 'U0006', 'L0006', 100000),
('K0007', 'U0007', 'L0007', 125000),
('K0008', 'U0008', 'L0008', 95000),
('K0009', 'U0009', 'L0009', 120000),
('K0010', 'U0010', 'L0010', 130000),
('K0011', 'U0011', 'L0011', 100000),
('K0012', 'U0012', 'L0012', 115000),
('K0013', 'U0013', 'L0013', 135000),
('K0014', 'U0014', 'L0014', 95000),
('K0015', 'U0015', 'L0015', 105000),
('K0016', 'U0003', 'L0003', 85000),
('K0017', 'U0004', 'L0005', 115000),
('K0018', 'U0005', 'L0007', 125000),
('K0019', 'U0006', 'L0006', 100000),
('K0020', 'U0007', 'L0007', 125000),
('K0021', 'U0008', 'L0008', 95000),
('K0022', 'U0009', 'L0005', 115000),
('K0023', 'U0010', 'L0009', 120000),
('K0024', 'U0011', 'L0010', 130000),
('K0025', 'U0012', 'L0013', 135000);

INSERT INTO transaksi (ID_transaksi, ID_catalog, transaksi_date, ID_user, harga) VALUES
('T0001', 'L0001', '2024-04-14 09:15:50', 'U0001', 150000),
('T0002', 'L0002', '2024-04-15 09:15:50', 'U0001', 110000),
('T0003', 'L0003', '2024-04-16 09:15:50', 'U0001', 85000),
('T0004', 'L0004', '2024-04-17 09:15:50', 'U0001', 105000),
('T0005', 'L0005', '2024-04-18 09:15:50', 'U0003', 115000),
('T0006', 'L0006', '2024-04-19 09:15:50', 'U0004', 100000),
('T0007', 'L0007', '2024-04-20 09:15:50', 'U0005', 125000),
('T0008', 'L0008', '2024-04-21 09:15:50', 'U0006', 95000),
('T0009', 'L0009', '2024-04-22 09:15:50', 'U0007', 120000),
('T0010', 'L0010', '2024-04-23 09:15:50', 'U0008', 130000),
('T0011', 'L0011', '2024-04-24 09:15:50', 'U0009', 100000),
('T0012', 'L0012', '2024-04-25 09:15:50', 'U0010', 115000),
('T0013', 'L0013', '2024-04-26 09:15:50', 'U0011', 135000),
('T0014', 'L0014', '2024-04-27 09:15:50', 'U0012', 95000),
('T0015', 'L0015', '2024-04-28 09:15:50', 'U0013', 105000),
('T0016', 'L0003', '2024-04-29 09:15:50', 'U0014', 85000),
('T0017', 'L0005', '2024-04-30 09:15:50', 'U0015', 115000),
('T0018', 'L0007', '2024-05-01 09:15:50', 'U0003', 125000),
('T0019', 'L0006', '2024-05-02 09:15:50', 'U0004', 100000),
('T0020', 'L0007', '2024-05-03 09:15:50', 'U0005', 125000),
('T0021', 'L0008', '2024-05-04 09:15:50', 'U0006', 95000),
('T0022', 'L0009', '2024-05-05 09:15:50', 'U0007', 120000),
('T0023', 'L0010', '2024-05-06 09:15:50', 'U0008', 130000),
('T0024', 'L0005', '2024-05-07 09:15:50', 'U0009', 115000),
('T0025', 'L0008', '2024-05-08 09:15:50', 'U0010', 95000),
('T0026', 'L0010', '2024-05-09 09:15:50', 'U0011', 130000),
('T0027', 'L0013', '2024-05-10 09:15:50', 'U0012', 135000);

-- INSERT INTO detail_transaksi (ID_transaksi, ID_catalog, amount) VALUES
-- ('T0001', 'L0001', 150000),
-- ('T0002', 'L0002', 110000),
-- ('T0003', 'L0004', 105000),
-- ('T0003', 'L0003', 85000),
-- ('T0004', 'L0004', 105000),
-- ('T0004', 'L0003', 85000),
-- ('T0005', 'L0002', 110000),
-- ('T0005', 'L0003', 85000),
-- ('T0006', 'L0005', 115000),
-- ('T0007', 'L0006', 100000),
-- ('T0008', 'L0010', 135000),
-- ('T0009', 'L0012', 115000),
-- ('T0010', 'L0014', 95000),
-- ('T0011', 'L0015', 105000),
-- ('T0012', 'L0001', 150000),
-- ('T0013', 'L0009', 120000),
-- ('T0014', 'L0007', 125000),
-- ('T0015', 'L0005', 115000),
-- ('T0016', 'L0011', 115000),
-- ('T0017', 'L0013', 135000),
-- ('T0018', 'L0008', 95000),
-- ('T0019', 'L0005', 115000),
-- ('T0020', 'L0006', 100000),
-- ('T0021', 'L0012', 115000),
-- ('T0022', 'L0007', 125000),
-- ('T0023', 'L0009', 120000),
-- ('T0024', 'L0007', 125000),
-- ('T0025', 'L0014', 95000),
-- ('T0026', 'L0004', 105000),
-- ('T0027', 'L0013', 135000);

INSERT INTO review (ID_review, ID_user, ID_catalog, review_date, rating, review_text) VALUES
('R0001', 'U0001', 'L0001', '2024-04-16 08:00:00', 4.5, 'Pengalaman yang sangat memuaskan. Joki cepat dan terpercaya.'),
('R0002', 'U0001', 'L0002', '2024-04-17 08:30:00', 4.8, 'Pelayanan sangat baik dan hasil memuaskan.'),
('R0003', 'U0002', 'L0004', '2024-04-21 09:00:00', 4.7, 'Paket ini sangat menarik dan seru dimainkan.'),
('R0004', 'U0002', 'L0005', '2024-04-22 09:30:00', 4.2, 'Banyak membantu dalam memahami permainan.'),
('R0005', 'U0004', 'L0006', '2024-04-23 10:00:00', 5.0, 'Pengalaman bermain yang sangat menghibur dan menantang.'),
('R0006', 'U0004', 'L0007', '2024-04-24 10:30:00', 3.8, 'Cukup baik, tapi masih ada ruang untuk perbaikan.'),
('R0007', 'U0006', 'L0008', '2024-04-25 11:00:00', 4.3, 'Sangat direkomendasikan untuk penggemar game balap.'),
('R0008', 'U0007', 'L0009', '2024-04-26 11:30:00', 4.6, 'Kualitas sangat tinggi, tidak mengecewakan.'),
('R0009', 'U0010', 'L0010', '2024-04-27 12:00:00', 3.2, 'Banyak fitur yang perlu ditingkatkan.'),
('R0010', 'U0010', 'L0011', '2024-04-28 12:30:00', 4.5, 'Informasi yang sangat bermanfaat dan detail.'),
('R0011', 'U0010', 'L0011', '2024-04-29 13:00:00', 5.0, 'Sangat luar biasa, melebihi ekspektasi.'),
('R0012', 'U0011', 'L0012', '2024-04-30 13:30:00', 3.6, 'Pengalaman bermain yang biasa saja.'),
('R0013', 'U0012', 'L0012', '2024-05-01 14:00:00', 4.7, 'Salah satu yang terbaik yang pernah saya coba.'),
('R0014', 'U0014', 'L0013', '2024-05-02 14:30:00', 2.8, 'Tidak sesuai harapan, cukup mengecewakan.'),
('R0015', 'U0014', 'L0014', '2024-05-03 15:00:00', 4.2, 'Sangat direkomendasikan untuk pemula yang ingin belajar.'),
('R0016', 'U0015', 'L0014', '2024-05-04 15:30:00', 3.4, 'Agak mengecewakan, fitur kurang lengkap.'),
('R0017', 'U0015', 'L0015', '2024-05-05 16:00:00', 4.8, 'Sangat layak dicoba, pengalaman yang menyenangkan.');

INSERT INTO wishlist (ID_wishlist, ID_user, ID_catalog, harga) VALUES
('W0001', 'U0001', 'L0001', 150000),  -- harga from catalog for L0001
('W0002', 'U0002', 'L0002', 110000),  -- harga from catalog for L0002
('W0003', 'U0003', 'L0003', 85000),   -- harga from catalog for L0003
('W0004', 'U0004', 'L0002', 110000),  -- harga from catalog for L0002
('W0005', 'U0005', 'L0003', 85000),   -- harga from catalog for L0003
('W0006', 'U0006', 'L0005', 115000),  -- harga from catalog for L0005
('W0007', 'U0007', 'L0006', 100000),  -- harga from catalog for L0006
('W0008', 'U0008', 'L0010', 130000),  -- harga from catalog for L0010
('W0009', 'U0009', 'L0012', 115000),  -- harga from catalog for L0012
('W0010', 'U0010', 'L0014', 95000),   -- harga from catalog for L0014
('W0011', 'U0011', 'L0015', 105000),  -- harga from catalog for L0015
('W0012', 'U0001', 'L0001', 150000),  -- harga from catalog for L0001
('W0013', 'U0002', 'L0009', 120000),  -- harga from catalog for L0009
('W0014', 'U0003', 'L0007', 125000),  -- harga from catalog for L0007
('W0015', 'U0004', 'L0005', 115000),  -- harga from catalog for L0005
('W0016', 'U0005', 'L0006', 100000),  -- harga from catalog for L0006
('W0017', 'U0006', 'L0011', 100000),  -- harga from catalog for L0011
('W0018', 'U0007', 'L0008', 95000),   -- harga from catalog for L0008
('W0019', 'U0008', 'L0003', 85000),   -- harga from catalog for L0003
('W0020', 'U0009', 'L0007', 125000),  -- harga from catalog for L0007
('W0021', 'U0010', 'L0009', 120000),  -- harga from catalog for L0009
('W0022', 'U0011', 'L0012', 115000),  -- harga from catalog for L0012
('W0023', 'U0001', 'L0005', 115000),  -- harga from catalog for L0005
('W0024', 'U0002', 'L0006', 100000),  -- harga from catalog for L0006
('W0025', 'U0003', 'L0014', 95000),   -- harga from catalog for L0014
('W0026', 'U0004', 'L0004', 105000),  -- harga from catalog for L0004
('W0027', 'U0005', 'L0013', 135000);  -- harga from catalog for L0013

