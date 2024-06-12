


CREATE DATABASE oltp1;


USE oltp1;


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

-- drop table if exists detail_transaksi;
-- CREATE TABLE IF NOT EXISTS detail_transaksi (
--     ID_transaksi varchar(100) REFERENCES transaksi(ID_transaksi),
--     ID_catalog varchar(100) REFERENCES catalog(ID_catalog),
--     amount int,
--     statusdel varchar(1) NOT NULL DEFAULT 'F'
-- );

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
('U0001', 'User', 'papilu', 'mataku', 'papilu@gmail.com', '2024-04-10 09:15:50'),
('U0002', 'User', 'banana', 'pipiku', 'banana@gmail.com', '2024-04-10 10:15:50'),
('U0003', 'Joki', 'donkey', 'donkeyganteng', 'donkey@gmail.com', '2024-04-10 12:15:50'),
('U0004', 'Admin', 'lemon', 'lemonganteng', 'lemon@gmail.com', '2024-04-08 09:15:50'),
('U0005', 'Joki', 'apple', 'apels', 'apple@gmail.com', '2024-04-20 08:20:50'),
('U0006', 'User', 'grape', 'anggurku', 'grape@gmail.com', '2024-04-20 09:20:50'),
('U0007', 'User', 'watermelon', 'semangka', 'watermelon@gmail.com', '2024-04-21 10:20:50'),
('U0008', 'Joki', 'pineapple', 'nanasmanis', 'pineapple@gmail.com', '2024-04-22 11:20:50'),
('U0009', 'Joki', 'strawberry', 'stroberiku', 'strawberry@gmail.com', '2024-04-23 12:20:50'),
('U0010', 'User', 'blueberry', 'birubiruku', 'blueberry@gmail.com', '2024-04-24 13:20:50'),
('U0011', 'User', 'kiwi', 'kiwikuu', 'kiwi@gmail.com', '2024-04-25 14:20:50'),
('U0012', 'Joki', 'orange', 'orenskuy', 'orange@gmail.com', '2024-04-26 15:20:50'),
('U0013', 'Joki', 'mango', 'manggiskuy', 'mango@gmail.com', '2024-04-27 16:20:50'),
('U0014', 'User', 'peach', 'peachy', 'peach@gmail.com', '2024-04-28 17:20:50'),
('U0015', 'User', 'blackberry', 'hitammanis', 'blackberry@gmail.com', '2024-04-29 18:20:50');
INSERT INTO games (ID_game, game_name, `description`, genre, img) VALUES
('G0001', 'Mobile Legends', 'Sebuah permainan daring multipemain real-time yang menuntut strategi, kerjasama tim, dan keterampilan individu dalam pertempuran 5 vs 5.', 'Action', 'ml.jpg'),
('G0002', 'PUBG', 'Permainan video battle royale yang mempertemukan puluhan pemain dalam pertempuran mati-matian di sebuah pulau dengan tujuan menjadi yang terakhir bertahan hidup.', 'Action', 'pubg.jpg'),
('G0003', 'Fortnite', 'Sebuah permainan battle royale yang menuntut pemainnya untuk membangun dan bertahan hidup dalam lingkungan yang terus berubah.', 'Action', 'fortnite.jpg'),
('G0004', 'League of Legends', 'Sebuah permainan MOBA yang mempertemukan dua tim dalam pertempuran epik untuk menghancurkan basis musuh.', 'Strategy', 'lol.jpg'),
('G0005', 'Among Us', 'Permainan multipemain online yang mengharuskan pemain untuk menyelesaikan tugas sambil mencoba mengidentifikasi pemain lain yang merupakan impostor.', 'Social Deduction', 'amogus.jpg'),
('G0006', 'Call of Duty: Warzone', 'Sebuah permainan battle royale yang menampilkan pertempuran massal antara pemain di peta yang luas.', 'Action', 'cod.jpg'),
('G0007', 'Valorant', 'Permainan first-person shooter taktis yang menggabungkan elemen-elemen dari game seperti Counter-Strike dan Overwatch.', 'Strategy', 'valo.jpg'),
('G0008', 'Minecraft', 'Sebuah permainan sandbox yang memberikan kebebasan kepada pemain untuk membuat dan menjelajahi dunia virtual.', 'Adventure', 'MCPE.jpg'),
('G0009', 'FIFA 22', 'Permainan simulasi sepak bola yang menawarkan pengalaman bermain sepak bola yang realistis.', 'Sports', 'fifa.jpg'),
('G0010', 'The Witcher 3: Wild Hunt', 'Sebuah permainan role-playing yang menampilkan petualangan epik dari seorang pemburu monster bernama Geralt.', 'RPG', 'witcher3 2.avif'),
('G0011', 'Overwatch', 'Permainan first-person shooter tim yang menampilkan beragam pahlawan dengan kemampuan unik.', 'Action', 'overwatch.jpg'),
('G0012', 'Animal Crossing: New Horizons', 'Sebuah permainan simulasi kehidupan di pulau terpencil yang dihuni oleh hewan antropomorfik.', 'Simulation', 'animalcrosing.jpg'),
('G0013', 'Counter-Strike: Global Offensive', 'Permainan first-person shooter tim yang mempertemukan antara teroris dan counter-teroris.', 'Action', 'cs.jpg'),
('G0014', 'World of Warcraft', 'Sebuah permainan role-playing daring yang mengajak pemain menjelajahi dunia fantasi Azeroth.', 'MMORPG', 'wow.jpg'),
('G0015', 'Grand Theft Auto V', 'Sebuah permainan aksi-petualangan yang menghadirkan dunia terbuka yang besar untuk dijelajahi.', 'Action', 'gtav.jpg');
INSERT INTO catalog (ID_catalog, ID_game, ID_user, product_name, `description`, harga, imgproduct) VALUES
('L0001', 'G0001', 'U0003', 'Joki Sampai Mythic', 'WS 100 persen', 80000,'fifa 22 product.jfif'),
('L0002', 'G0002', 'U0003', 'Joki Sampai Ace', 'KDA 9.00', 90000,'fortnite product.jfif'),
('L0003', 'G0001', 'U0003', 'From Warrior to Epic', 'Layla Winrate 100 persen', 60000,'mobile legend product 2.jfif'),
('L0004', 'G0003', 'U0012', 'Victory Royale', 'Menang tanpa berpakaian', 100000,'mobile legend product 3.jfif'),
('L0005', 'G0004', 'U0005', 'Challenger Rank Boost', 'Naik peringkat dalam semalam', 120000,'pubg mobile legend.jfif'),
('L0006', 'G0005', 'U0005', 'Impostor Master', 'Winrate menjadi 100%', 110000,'pubg product.jfif'),
('L0007', 'G0006', 'U0005', 'Victory Booster', 'Menang terus', 95000,'valorant product.jfif'),
('L0008', 'G0007', 'U0013', 'Go To Ace', 'Menang sampai rank Ace', 130000,'fifa 22 product.jfif'),
('L0009', 'G0005', 'U0013', 'Sneaky Saboteur', 'Mengacaukan kru tanpa ketahuan', 100000,'mobile legend product 2.jfif'),
('L0010', 'G0009', 'U0013', 'Hattrick goal', 'Main sampai pemain bisa mencetak hattrick', 90000,'fortnite product.jfif'),
('L0011', 'G0004', 'U0008', 'Visionary Strategist', 'Membuat strategi tak terkalahkan', 125000,'mobile legend product 3.jfif'),
('L0012', 'G0005', 'U0008', 'Task Master', 'Menyelesaikan tugas dengan cepat', 95000,'pubg product.jfif'),
('L0013', 'G0001', 'U0009', 'Go To Epic', 'Main Mobile Legend Sampai Rank Epic', 105000,'valorant product.jfif'),
('L0014', 'G0002', 'U0009', 'Conqu is the best', 'Masuk ke Rank conqueror', 140000,'fifa 22 product.jfif'),
('L0015', 'G0015', 'U0009', 'End Game', 'Menyelesaikan Game GTA V', 97000,'fortnite product.jfif');
INSERT INTO keranjang (ID_keranjang, ID_user, ID_catalog, harga) VALUES
('K0001', 'U0001', 'L0001', 80000),
('K0002', 'U0002', 'L0002', 90000),
('K0003', 'U0003','L0003', 60000),
('K0004', 'U0004','L0002', 125000),
('K0005', 'U0005','L0003', 95000),
('K0006', 'U0006','L0005', 120000),
('K0007', 'U0007','L0006', 110000),
('K0008', 'U0008','L0010', 90000),
('K0009', 'U0009','L0012', 95000),
('K0010', 'U0010','L0014', 140000),
('K0011', 'U0011','L0015', 97000),
('K0012', 'U0012','L0001', 80000),
('K0013', 'U0013','L0009', 100000),
('K0014', 'U0001','L0007', 95000),
('K0015', 'U0014','L0005', 120000),
('K0016', 'U0015','L0006', 110000),
('K0017', 'U0001','L0011', 125000),
('K0018', 'U0002','L0008', 95000),
('K0019', 'U0003','L0014', 60000),
('K0020', 'U0004','L0007', 95000),
('K0021', 'U0004','L0009', 100000),
('K0022', 'U0005','L0012', 95000),
('K0023', 'U0006','L0004', 120000),
('K0024', 'U0006','L0006', 110000),
('K0025', 'U0007','L0014', 140000);


INSERT INTO transaksi (ID_transaksi,ID_catalog, transaksi_date, ID_user, harga) VALUES
('T0001', 'L0001', '2024-04-14 09:15:50', 'U0001', 80000),
('T0002', 'L0002', '2024-04-15 09:15:50', 'U0001', 90000),
('T0003', 'L0003', '2024-04-16 09:15:50', 'U0001', 60000),
('T0004', 'L0004', '2024-04-17 09:15:50', 'U0001', 100000),
('T0005', 'L0005', '2024-04-18 09:15:50', 'U0003', 120000),
('T0006', 'L0006', '2024-04-19 09:15:50', 'U0004', 110000),
('T0007', 'L0007', '2024-04-20 09:15:50', 'U0005', 95000),
('T0008', 'L0008', '2024-04-21 09:15:50', 'U0006', 130000),
('T0009', 'L0009', '2024-04-22 09:15:50', 'U0007', 100000),
('T0010', 'L0010', '2024-04-23 09:15:50', 'U0008', 90000),
('T0011', 'L0011', '2024-04-24 09:15:50', 'U0009', 125000),
('T0012', 'L0012', '2024-04-25 09:15:50', 'U0010', 95000),
('T0013', 'L0013', '2024-04-26 09:15:50', 'U0011', 105000),
('T0014', 'L0014', '2024-04-27 09:15:50', 'U0012', 140000),
('T0015', 'L0015', '2024-04-28 09:15:50', 'U0013', 97000),
('T0016', 'L0001', '2024-04-29 09:15:50', 'U0014', 80000),
('T0017', 'L0002', '2024-04-30 09:15:50', 'U0015', 90000),
('T0018', 'L0003', '2024-05-01 09:15:50', 'U0003', 60000),
('T0019', 'L0004', '2024-05-02 09:15:50', 'U0004', 100000),
('T0020', 'L0005', '2024-05-03 09:15:50', 'U0005', 120000),
('T0021', 'L0006', '2024-05-04 09:15:50', 'U0006', 110000),
('T0022', 'L0007', '2024-05-05 09:15:50', 'U0007', 95000),
('T0023', 'L0008', '2024-05-06 09:15:50', 'U0008', 130000),
('T0024', 'L0009', '2024-05-07 09:15:50', 'U0009', 100000),
('T0025', 'L0010', '2024-05-08 09:15:50', 'U0010', 90000);
-- INSERT INTO detail_transaksi (ID_transaksi, ID_catalog, amount) VALUES
-- ('T0001', 'L0001', 80000),
-- ('T0002', 'L0002', 90000),
-- ('T0003', 'L0004', 90000),
-- ('T0003', 'L0003', 60000),
-- ('T0004', 'L0004', 90000),
-- ('T0004', 'L0003', 60000),
-- ('T0005', 'L0002', 125000),
-- ('T0005', 'L0003', 95000),
-- ('T0006', 'L0004', 100000),
-- ('T0006', 'L0002', 90000),
-- ('T0007', 'L0006', 110000),
-- ('T0008', 'L0010', 90000),
-- ('T0009', 'L0012', 95000),
-- ('T0010', 'L0014', 140000),
-- ('T0011', 'L0015', 97000),
-- ('T0012', 'L0001', 80000),
-- ('T0013', 'L0009', 100000),
-- ('T0014', 'L0007', 95000),
-- ('T0015', 'L0005', 120000),
-- ('T0016', 'L0011', 125000),
-- ('T0017', 'L0013', 105000),
-- ('T0018', 'L0008', 95000),
-- ('T0019', 'L0005', 120000),
-- ('T0020', 'L0006', 110000),
-- ('T0021', 'L0012', 95000),
-- ('T0022', 'L0007', 130000),
-- ('T0023', 'L0009', 100000),
-- ('T0024', 'L0007', 130000),
-- ('T0025', 'L0014', 140000),
-- ('T0026', 'L0004', 100000),
-- ('T0027', 'L0013', 105000);
INSERT INTO review (ID_review, ID_user, ID_catalog, review_date, rating, review_text) VALUES
('R0001', 'U0001', 'L0001', '2024-04-15 09:15:50', 4.0, 'Joki yang keren'),
('R0002', 'U0001', 'L0002', '2024-04-16 09:15:50', 5.0, 'Hebat'),
('R0003', 'U0002', 'L0004', '2024-04-20 09:30:50', 4.5, 'Sangat seru'),
('R0004', 'U0002', 'L0005', '2024-04-21 10:30:50', 4.0, 'Membantu sekali'),
('R0005', 'U0004', 'L0006', '2024-04-22 11:30:50', 5.0, 'Sangat menghibur'),
('R0006', 'U0004', 'L0007', '2024-04-23 12:30:50', 3.5, 'Cukup baik'),
('R0007', 'U0006', 'L0008', '2024-04-24 13:30:50', 4.0, 'Rekomendasi'),
('R0008', 'U0007', 'L0009', '2024-04-25 14:30:50', 4.5, 'Kualitas tinggi'),
('R0009', 'U0010', 'L0010', '2024-04-26 15:30:50', 3.0, 'Perlu peningkatan'),
('R0010', 'U0010', 'L0011', '2024-04-27 16:30:50', 4.0, 'Sangat informatif'),
('R0011', 'U0010', 'L0011', '2024-04-28 17:30:50', 5.0, 'Luar biasa'),
('R0012', 'U0011', 'L0012', '2024-04-29 18:30:50', 3.5, 'Biasa saja'),
('R0013', 'U0012', 'L0012', '2024-04-30 19:30:50', 4.5, 'Terbaik'),
('R0014', 'U0014', 'L0013', '2024-05-01 20:30:50', 2.5, 'Tidak terlalu bagus'),
('R0015', 'U0014', 'L0014', '2024-05-02 21:30:50', 4.0, 'Rekomendasi untuk pemula'),
('R0016', 'U0015', 'L0014', '2024-05-03 22:30:50', 3.0, 'Agak mengecewakan'),
('R0017', 'U0015', 'L0015', '2024-05-04 23:30:50', 4.5, 'Layak dicoba');
INSERT INTO wishlist (ID_wishlist,ID_user,ID_catalog, harga) VALUES
('W0001','U0001', 'L0001', 80000),
('W0002','U0002', 'L0002', 90000),
('W0003','U0003', 'L0002', 60000),
('W0004','U0004', 'L0003', 125000),
('W0005','U0005', 'L0003', 95000),
('W0006','U0006', 'L0005', 120000),
('W0007','U0007', 'L0006', 110000),
('W0008','U0008', 'L0010', 90000),
('W0009','U0009', 'L0012', 95000),
('W0010','U0010', 'L0014', 140000),
('W0011','U0011', 'L0015', 97000),
('W0012','U0012', 'L0001', 80000),
('W0013','U0013', 'L0009', 100000),
('W0014','U0014', 'L0007', 95000),
('W0015','U0015', 'L0005', 120000),
('W0016','U0001', 'L0006', 110000),
('W0017','U0002', 'L0011', 125000),
('W0018','U0003', 'L0008', 95000),
('W0019','U0004', 'L0003', 60000),
('W0020','U0005', 'L0007', 95000),
('W0021','U0006', 'L0009', 100000),
('W0022','U0007', 'L0012', 95000),
('W0023','U0008', 'L0005', 120000),
('W0024','U0009', 'L0006', 110000),
('W0025','U0010', 'L0014', 140000);


