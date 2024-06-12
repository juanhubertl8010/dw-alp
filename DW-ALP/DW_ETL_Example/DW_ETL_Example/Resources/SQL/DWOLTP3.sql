CREATE DATABASE oltp3;


USE oltp3;


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
('U0001', 'User', 'melon', 'melonsaya', 'melon@gmail.com', '2024-05-01 08:30:00'),
('U0002', 'User', 'applepie', 'apelmudah', 'applepie@gmail.com', '2024-05-01 09:30:00'),
('U0003', 'Joki', 'banana_split', 'pisangbikinaku', 'bananasplit@gmail.com', '2024-05-01 10:30:00'),
('U0004', 'Admin', 'lemonade', 'lemonsegar', 'lemonade@gmail.com', '2024-05-01 11:30:00'),
('U0005', 'Joki', 'grapejuice', 'anggurmakinsegar', 'grapejuice@gmail.com', '2024-05-01 12:30:00'),
('U0006', 'User', 'watermelonlove', 'semangkacintaku', 'watermelonlove@gmail.com', '2024-05-01 13:30:00'),
('U0007', 'User', 'pineappleexpress', 'nanascepat', 'pineappleexpress@gmail.com', '2024-05-01 14:30:00'),
('U0008', 'Joki', 'strawberrysmoothie', 'stroberi_yummy', 'strawberrysmoothie@gmail.com', '2024-05-01 15:30:00'),
('U0009', 'Joki', 'blueberrybliss', 'birumakinbahagia', 'blueberrybliss@gmail.com', '2024-05-01 16:30:00'),
('U0010', 'User', 'kiwipower', 'kiwisaya', 'kiwipower@gmail.com', '2024-05-01 17:30:00'),
('U0011', 'User', 'orangejoy', 'orensayaku', 'orangejoy@gmail.com', '2024-05-01 18:30:00'),
('U0012', 'Joki', 'mangomadness', 'manggilezat', 'mangomadness@gmail.com', '2024-05-01 19:30:00'),
('U0013', 'Joki', 'peachperfect', 'peachsempurna', 'peachperfect@gmail.com', '2024-05-01 20:30:00'),
('U0014', 'User', 'blackberrybeauty', 'hitamcantik', 'blackberrybeauty@gmail.com', '2024-05-01 21:30:00'),
('U0015', 'User', 'melonmania', 'melonmania', 'melonmania@gmail.com', '2024-05-01 22:30:00');

INSERT INTO games (ID_game, game_name, description, genre, img) VALUES
('G0001', 'Mobile Legends', 'Sebuah permainan daring multipemain real-time yang menuntut strategi, kerjasama tim, dan keterampilan individu dalam pertempuran 5 vs 5.', 'Action', 'mobile_legends.jpg'),
('G0002', 'PUBG', 'Permainan video battle royale yang mempertemukan puluhan pemain dalam pertempuran mati-matian di sebuah pulau dengan tujuan menjadi yang terakhir bertahan hidup.', 'Action', 'pubg.jpg'),
('G0003', 'Fortnite', 'Sebuah permainan battle royale yang menuntut pemainnya untuk membangun dan bertahan hidup dalam lingkungan yang terus berubah.', 'Action', 'fortnite.jpg'),
('G0004', 'League of Legends', 'Sebuah permainan MOBA yang mempertemukan dua tim dalam pertempuran epik untuk menghancurkan basis musuh.', 'Strategy', 'league_of_legends.jpg'),
('G0005', 'Among Us', 'Permainan multipemain online yang mengharuskan pemain untuk menyelesaikan tugas sambil mencoba mengidentifikasi pemain lain yang merupakan impostor.', 'Social Deduction', 'among_us.jpg'),
('G0006', 'Call of Duty: Warzone', 'Sebuah permainan battle royale yang menampilkan pertempuran massal antara pemain di peta yang luas.', 'Action', 'warzone.jpg'),
('G0007', 'Valorant', 'Permainan first-person shooter taktis yang menggabungkan elemen-elemen dari game seperti Counter-Strike dan Overwatch.', 'Strategy', 'valorant.jpg'),
('G0008', 'Minecraft', 'Sebuah permainan sandbox yang memberikan kebebasan kepada pemain untuk membuat dan menjelajahi dunia virtual.', 'Adventure', 'minecraft.jpg'),
('G0009', 'FIFA 22', 'Permainan simulasi sepak bola yang menawarkan pengalaman bermain sepak bola yang realistis.', 'Sports', 'fifa22.jpg'),
('G0010', 'The Witcher 3: Wild Hunt', 'Sebuah permainan role-playing yang menampilkan petualangan epik dari seorang pemburu monster bernama Geralt.', 'RPG', 'witcher3.jpg'),
('G0011', 'Overwatch', 'Permainan first-person shooter tim yang menampilkan beragam pahlawan dengan kemampuan unik.', 'Action', 'overwatch.jpg'),
('G0012', 'Animal Crossing: New Horizons', 'Sebuah permainan simulasi kehidupan di pulau terpencil yang dihuni oleh hewan antropomorfik.', 'Simulation', 'animal_crossing.jpg'),
('G0013', 'Counter-Strike: Global Offensive', 'Permainan first-person shooter tim yang mempertemukan antara teroris dan counter-teroris.', 'Action', 'csgo.jpg'),
('G0014', 'World of Warcraft', 'Sebuah permainan role-playing daring yang mengajak pemain menjelajahi dunia fantasi Azeroth.', 'MMORPG', 'world_of_warcraft.jpg'),
('G0015', 'Grand Theft Auto V', 'Sebuah permainan aksi-petualangan yang menghadirkan dunia terbuka yang besar untuk dijelajahi.', 'Action', 'gta5.jpg');

INSERT INTO catalog (ID_catalog, ID_game, ID_user, product_name, description, harga, imgproduct) VALUES
('L0016', 'G0008', 'U0014', 'Creative Builder', 'Bangun struktur unik di Minecraft', 80000, 'creative_builder.jfif'),
('L0017', 'G0009', 'U0014', 'Ultimate Team Manager', 'Bangun tim terbaik di FIFA 22', 95000, 'ultimate_team_manager.jfif'),
('L0018', 'G0010', 'U0014', 'Monster Slayer', 'Hancurkan monster di The Witcher 3', 110000, 'monster_slayer.jfif'),
('L0019', 'G0011', 'U0015', 'Team Leader', 'Pimpin tim Anda ke kemenangan di Overwatch', 105000, 'team_leader.jfif'),
('L0020', 'G0012', 'U0015', 'Island Designer', 'Desain pulau Anda sendiri di Animal Crossing', 85000, 'island_designer.jfif'),
('L0021', 'G0013', 'U0015', 'Terrorist Specialist', 'Kuasai peran sebagai teroris di CS:GO', 100000, 'terrorist_specialist.jfif'),
('L0022', 'G0014', 'U0016', 'Legendary Hero', 'Jelajahi dunia Azeroth sebagai pahlawan di WoW', 120000, 'legendary_hero.jfif'),
('L0023', 'G0015', 'U0016', 'Crime Lord', 'Kuasai dunia kriminal di GTA V', 130000, 'crime_lord.jfif'),
('L0024', 'G0008', 'U0016', 'Cave Explorer', 'Telusuri gua yang misterius di Minecraft', 90000, 'cave_explorer.jfif'),
('L0025', 'G0009', 'U0017', 'Soccer Superstar', 'Menjadi bintang sepak bola di FIFA 22', 100000, 'soccer_superstar.jfif'),
('L0026', 'G0010', 'U0017', 'Witcher Apprentice', 'Mulai petualangan sebagai pemburu monster di The Witcher 3', 95000, 'witcher_apprentice.jfif'),
('L0027', 'G0011', 'U0017', 'Heroic Fighter', 'Bukti keberanianmu di Overwatch', 110000, 'heroic_fighter.jfif'),
('L0028', 'G0012', 'U0018', 'Community Mayor', 'Pimpin komunitas di Animal Crossing', 85000, 'community_mayor.jfif'),
('L0029', 'G0013', 'U0018', 'Counter-Terrorist', 'Lawan teroris di CS:GO', 100000, 'counter_terrorist.jfif'),
('L0030', 'G0014', 'U0018', 'Master Explorer', 'Telusuri setiap sudut dunia WoW', 120000, 'master_explorer.jfif');

INSERT INTO keranjang (ID_keranjang, ID_user, ID_catalog, harga) VALUES
('K0001', 'U0003', 'L0016', 80000),
('K0002', 'U0003', 'L0017', 95000),
('K0003', 'U0012', 'L0018', 110000),
('K0004', 'U0005', 'L0019', 105000),
('K0005', 'U0005', 'L0020', 85000),
('K0006', 'U0005', 'L0021', 100000),
('K0007', 'U0013', 'L0022', 120000),
('K0008', 'U0013', 'L0023', 130000),
('K0009', 'U0013', 'L0024', 90000),
('K0010', 'U0013', 'L0025', 100000),
('K0011', 'U0008', 'L0016', 80000),
('K0012', 'U0008', 'L0017', 95000),
('K0013', 'U0009', 'L0018', 110000),
('K0014', 'U0009', 'L0019', 105000),
('K0015', 'U0009', 'L0020', 85000),
('K0016', 'U0014', 'L0021', 100000),
('K0017', 'U0014', 'L0022', 120000),
('K0018', 'U0014', 'L0023', 130000),
('K0019', 'U0015', 'L0016', 90000),
('K0020', 'U0015', 'L0017', 100000),
('K0021', 'U0015', 'L0018', 95000),
('K0022', 'U0001', 'L0018', 110000),
('K0023', 'U0001', 'L0020', 85000),
('K0024', 'U0002', 'L0021', 100000),
('K0025', 'U0002', 'L0022', 120000);

INSERT INTO transaksi (ID_transaksi,ID_catalog, transaksi_date, ID_user, harga) VALUES
('T0001', 'L0016', '2024-05-02 08:30:00', 'U0003', 80000),
('T0002', 'L0017', '2024-05-02 09:30:00', 'U0003', 95000),
('T0003', 'L0018', '2024-05-02 10:30:00', 'U0012', 110000),
('T0004', 'L0019', '2024-05-02 11:30:00', 'U0005', 105000),
('T0005', 'L0020', '2024-05-02 12:30:00', 'U0005', 85000),
('T0006', 'L0021', '2024-05-02 13:30:00', 'U0005', 100000),
('T0007', 'L0022', '2024-05-02 14:30:00', 'U0013', 120000),
('T0008', 'L0023', '2024-05-02 15:30:00', 'U0013', 130000),
('T0009', 'L0024', '2024-05-02 16:30:00', 'U0013', 90000),
('T0010', 'L0025', '2024-05-02 17:30:00', 'U0013', 100000),
('T0011', 'L0016', '2024-05-02 18:30:00', 'U0008', 80000),
('T0012', 'L0017', '2024-05-02 19:30:00', 'U0008', 95000),
('T0013', 'L0018', '2024-05-02 20:30:00', 'U0009', 110000),
('T0014', 'L0019', '2024-05-02 21:30:00', 'U0009', 105000),
('T0015', 'L0020', '2024-05-02 22:30:00', 'U0009', 85000),
('T0016', 'L0021', '2024-05-02 23:30:00', 'U0014', 100000),
('T0017', 'L0022', '2024-05-03 00:30:00', 'U0014', 120000),
('T0018', 'L0023', '2024-05-03 01:30:00', 'U0014', 130000),
('T0019', 'L0016', '2024-05-03 02:30:00', 'U0015', 90000),
('T0020', 'L0017', '2024-05-03 03:30:00', 'U0015', 100000),
('T0021', 'L0018', '2024-05-03 04:30:00', 'U0015', 95000),
('T0022', 'L0018', '2024-05-03 05:30:00', 'U0016', 110000),
('T0023', 'L0020', '2024-05-03 06:30:00', 'U0016', 85000),
('T0024', 'L0021', '2024-05-03 07:30:00', 'U0016', 100000),
('T0025', 'L0022', '2024-05-03 08:30:00', 'U0017', 120000);

-- INSERT INTO detail_transaksi (ID_transaksi, ID_catalog, amount) VALUES
-- ('T0001', 'L0016', 80000),
-- ('T0002', 'L0017', 95000),
-- ('T0003', 'L0018', 110000),
-- ('T0004', 'L0019', 105000),
-- ('T0005', 'L0020', 85000),
-- ('T0006', 'L0021', 100000),
-- ('T0007', 'L0022', 120000),
-- ('T0008', 'L0023', 130000),
-- ('T0009', 'L0024', 90000),
-- ('T0010', 'L0025', 100000),
-- ('T0011', 'L0016', 80000),
-- ('T0012', 'L0017', 95000),
-- ('T0013', 'L0018', 110000),
-- ('T0014', 'L0019', 105000),
-- ('T0015', 'L0020', 85000),
-- ('T0016', 'L0021', 100000),
-- ('T0017', 'L0022', 120000),
-- ('T0018', 'L0023', 130000),
-- ('T0019', 'L0024', 90000),
-- ('T0020', 'L0025', 100000),
-- ('T0021', 'L0016', 80000),
-- ('T0022', 'L0017', 95000),
-- ('T0023', 'L0018', 110000),
-- ('T0024', 'L0019', 105000),
-- ('T0025', 'L0020', 85000);

INSERT INTO review (ID_review, ID_user, ID_catalog, review_date, rating, review_text) VALUES
('R0018', 'U0003', 'L0018', '2024-05-05 09:15:50', 4.0, 'Menyenangkan untuk dimainkan'),
('R0019', 'U0005', 'L0016', '2024-05-06 09:15:50', 3.5, 'Grafisnya bagus'),
('R0020', 'U0008', 'L0017', '2024-05-07 09:30:50', 4.0, 'Sangat adiktif'),
('R0021', 'U0009', 'L0018', '2024-05-08 10:30:50', 3.0, 'Butuh perbaikan lebih lanjut'),
('R0022', 'U0013', 'L0019', '2024-05-09 11:30:50', 4.5, 'Sangat menghibur'),
('R0023', 'U0016', 'L0020', '2024-05-10 12:30:50', 2.5, 'Kurang memuaskan'),
('R0024', 'U0017', 'L0021', '2024-05-11 13:30:50', 4.0, 'Luar biasa!'),
('R0025', 'U0018', 'L0022', '2024-05-12 14:30:50', 3.5, 'Bagus untuk mengisi waktu luang'),
('R0026', 'U0019', 'L0023', '2024-05-13 09:15:50', 4.5, 'Sangat direkomendasikan'),
('R0027', 'U0020', 'L0024', '2024-05-14 09:15:50', 3.0, 'Cukup memuaskan'),
('R0028', 'U0021', 'L0025', '2024-05-15 09:30:50', 4.0, 'Bermain dengan teman sangat menyenangkan'),
('R0029', 'U0022', 'L0026', '2024-05-16 10:30:50', 2.5, 'Kurang memuaskan'),
('R0030', 'U0023', 'L0027', '2024-05-17 11:30:50', 4.0, 'Sangat adiktif'),
('R0031', 'U0024', 'L0028', '2024-05-18 12:30:50', 3.5, 'Grafisnya bagus'),
('R0032', 'U0025', 'L0029', '2024-05-19 13:30:50', 4.5, 'Membuat saya ketagihan'),
('R0033', 'U0026', 'L0030', '2024-05-20 14:30:50', 3.0, 'Butuh perbaikan pada sistem multiplayer');

INSERT INTO wishlist (ID_wishlist,ID_user,ID_catalog, harga) VALUES
('W0001','U0001', 'L0016', 80000),
('W0002','U0002', 'L0017', 95000),
('W0003','U0003', 'L0017', 95000),
('W0004','U0004', 'L0018', 110000),
('W0005','U0005', 'L0018', 110000),
('W0006','U0006', 'L0020', 85000),
('W0007','U0007', 'L0021', 100000),
('W0008','U0008', 'L0024', 90000),
('W0009','U0009', 'L0026', 95000),
('W0010','U0010', 'L0028', 120000),
('W0011','U0011', 'L0029', 100000),
('W0012','U0012', 'L0016', 80000),
('W0013','U0013', 'L0014', 140000),
('W0014','U0014', 'L0022', 120000),
('W0015','U0015', 'L0020', 85000),
('W0016','U0001', 'L0021', 100000),
('W0017','U0002', 'L0025', 100000),
('W0018','U0003', 'L0023', 130000),
('W0019','U0004', 'L0018', 110000),
('W0020','U0005', 'L0022', 120000),
('W0021','U0006', 'L0014', 140000),
('W0022','U0007', 'L0026', 95000),
('W0023','U0008', 'L0020', 85000),
('W0024','U0009', 'L0021', 100000),
('W0025','U0010', 'L0028', 120000);