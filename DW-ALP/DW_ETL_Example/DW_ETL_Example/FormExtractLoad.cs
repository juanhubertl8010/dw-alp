using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

namespace DW_ETL_Example
{
    public partial class FormExtractLoad : Form
    {
        MySqlConnection myConnOLTP;
        MySqlCommand myCmdOLTP = new MySqlCommand(); 

        MySqlConnection myConnOLAP;
        MySqlCommand myCmdOLAP = new MySqlCommand();
        MySqlDataAdapter myAdapter;
        DataTable dt;
        string originOLTP;
        bool statConnOLTP = false;
        bool statConnOLAP = false;

        public FormExtractLoad()
        {
            InitializeComponent();
        }

        private void FormExtractLoad_Load(object sender, EventArgs e)
        {
            disconnectedOLTPComponent();
            disconnectedOLAPComponent();
        }

        private void btnConnectOLTP_Click(object sender, EventArgs e)
        {
            connToSelectedOLTP(tbUserOLTP.Text, tbPassOLTP.Text, cbDBNameOLTP.Text);
            connectedOLTPComponent();
        }

        private void btnDiscOLTP_Click(object sender, EventArgs e)
        {
            disconnectedOLTPComponent();
            statConnOLTP = false;
            MessageBox.Show("Koneksi DATABASE LOCAL / OLTP DIPUTUS!");
            myConnOLTP.Close();
        }

        private void connectedOLTPComponent()
        {
            cbDBNameOLTP.Enabled = false;
            tbUserOLTP.Enabled = false;
            tbPassOLTP.Enabled = false;
            btnConnectOLTP.Enabled = false;
            btnDiscOLTP.Enabled = true;
            btnExtract.Enabled = true;
            cbTable.Enabled = true;
            dgvExtractedData.DataSource = null;
            dgvExtractedData.Refresh();
            dgvExtractedData.Enabled = true;
            lblStatOLTP.Text = "Status OLTP : Connected";
            if (statConnOLTP && statConnOLAP && cbTable.SelectedIndex != 0)
                btnTL.Enabled = true;
            else
                btnTL.Enabled = false;
        }

        private void disconnectedOLTPComponent()
        {
            cbDBNameOLTP.SelectedIndex = 0;
            cbDBNameOLTP.Enabled = true;
            tbUserOLTP.Enabled = true;
            tbPassOLTP.Enabled = true;
            btnDiscOLTP.Enabled = false;
            btnConnectOLTP.Enabled = true;
            cbTable.SelectedIndex = 0;
            cbTable.Enabled = false;
            btnTL.Enabled = false;
            btnExtract.Enabled = false;
            dgvExtractedData.DataSource = null;
            dgvExtractedData.Refresh();
            dgvExtractedData.Enabled = false;
            lblStatOLTP.Text = "Status OLTP : Disconnected";
            dgvExtractedData.DataSource = null;
            if (statConnOLTP && statConnOLAP && cbTable.SelectedIndex != 0)
                btnTL.Enabled = true;
            else
                btnTL.Enabled = false;
        }

        private void connToSelectedOLTP(string user, string pass, string db_name)
        {
            try
            {
                myConnOLTP = new MySqlConnection("SERVER=127.0.0.1;PORT=3306;UID=" + user + ";PASSWORD=" + pass + ";DATABASE=" + db_name);

                if (myConnOLTP.State == ConnectionState.Closed)
                {
                    myConnOLTP.Open();
                    MessageBox.Show("Berhasil TERKONEKSI ke DATABASE LOCAL / OLTP");
                    statConnOLTP = true;
                    lblStatOLTP.Text = "Status OLTP : Connected";
                }
                else if (myConnOLTP.State == ConnectionState.Open)
                {
                    MessageBox.Show("Koneksi masih TERBUKA");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

        private void connToOLAPDB(string host, string user, string pass, string db_name)
        {
            try
            {
                myConnOLAP = new MySqlConnection("SERVER=" + host + ";PORT=3306;UID=" + user + ";PASSWORD=" + pass + ";DATABASE=" + db_name);

                if (myConnOLAP.State == ConnectionState.Closed)
                {
                    myConnOLAP.Open();
                    MessageBox.Show("Berhasil TERKONEKSI ke DATA WAREHOUSE (" + host + ")");
                    statConnOLAP = true;
                    lblStatOLAP.Text = "Status OLAP : Connected";
                }
                else if (myConnOLAP.State == ConnectionState.Open)
                {
                    MessageBox.Show("Koneksi masih TERBUKA");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

        private void cbTable_SelectedIndexChanged(object sender, EventArgs e)
        {
            dgvExtractedData.DataSource = null;
            btnTL.Enabled = false;
        }

        private void btnExtract_Click(object sender, EventArgs e)
        {
            extractData(cbTable.Text);
            if (statConnOLTP && statConnOLAP && cbTable.SelectedIndex != 0)
                btnTL.Enabled = true;
            else
                btnTL.Enabled = false;
        }

        private void extractData(string tb_name)
        {
            try
            {
                string cmdText;
                if (tb_name.ToLower() == "orders")
                {
                    cmdText = "SELECT OrderID, CustomerID, DATE_FORMAT(OrderDate,'%Y-%m-%d') as OrderDate, TotalAmount, is_warehouse FROM " + tb_name + " WHERE is_warehouse = 0 ORDER BY 1;";
                    myAdapter = new MySqlDataAdapter(cmdText, myConnOLTP);
                    dt = new DataTable();
                    myAdapter.Fill(dt);
                    dgvExtractedData.DataSource = dt;
                    dgvExtractedData.Refresh();
                }
                else
                {
                    cmdText = "SELECT * FROM " + tb_name + " WHERE is_warehouse = 0 ORDER BY 1;";
                    myAdapter = new MySqlDataAdapter(cmdText, myConnOLTP);
                    dt = new DataTable();
                    myAdapter.Fill(dt);
                    dgvExtractedData.DataSource = dt;
                    dgvExtractedData.Refresh();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

        private void btnConnectOLAP_Click(object sender, EventArgs e)
        {
            connToOLAPDB(tbHostOLAP.Text, tbUserOLAP.Text, tbPassOLAP.Text, tbDBNameOLAP.Text);
            connectedOLAPComponent();
        }

        private void btnDiscOLAP_Click(object sender, EventArgs e)
        {
            disconnectedOLAPComponent();
            statConnOLAP = false;
            MessageBox.Show("Koneksi DATA WAREHOUSE / OLAP DIPUTUS!");
            myConnOLAP.Close();
        }

        private void connectedOLAPComponent()
        {
            tbHostOLAP.Enabled = false;
            tbDBNameOLAP.Enabled = false;
            tbUserOLAP.Enabled = false;
            tbPassOLAP.Enabled = false;
            btnConnectOLAP.Enabled = false;
            btnDiscOLAP.Enabled = true;
            lblStatOLAP.Text = "Status OLAP : Connected";
            if (statConnOLTP && statConnOLAP && cbTable.SelectedIndex != 0)
                btnTL.Enabled = true;
            else
                btnTL.Enabled = false;
        }

        private void disconnectedOLAPComponent()
        {
            tbHostOLAP.Enabled = true;
            tbDBNameOLAP.Enabled = true;
            tbUserOLAP.Enabled = true;
            tbPassOLAP.Enabled = true;
            btnConnectOLAP.Enabled = true;
            btnDiscOLAP.Enabled = false;
            lblStatOLAP.Text = "Status OLAP : Disconnected";
            dgvExtractedData.DataSource = null;
            if (statConnOLTP && statConnOLAP && cbTable.SelectedIndex != 0)
                btnTL.Enabled = true;
            else
                btnTL.Enabled = false;
        }

        private void btnTL_Click(object sender, EventArgs e)
        {
            if (cbDBNameOLTP.Text == "oltp1") originOLTP = "Juan";
            else if (cbDBNameOLTP.Text == "oltp2") originOLTP = "Rangga";
            else if (cbDBNameOLTP.Text == "oltp3") originOLTP = "Kenneith";
            else if (cbDBNameOLTP.Text == "oltp4") originOLTP = "Valent";

            if (cbTable.Text.Equals("games"))
            {
                loadgames();
            }
            else if (cbTable.Text.Equals("catalog"))
            {
                loadcatalog();
            }
            else if (cbTable.Text.Equals("keranjang"))
            {
                loadkeranjang();
            }
            else if (cbTable.Text.Equals("review"))
            {
                loadreview();
            }
            else if (cbTable.Text.Equals("transaksi"))
            {
                loadtransaksi();
            }
            else if (cbTable.Text.Equals("user"))
            {
                loaduser();
            }
            else if (cbTable.Text.Equals("wishlist"))
            {
                loadwishlist();
            }
            btnExtract_Click(sender, e);
        }

        private void loadcatalog()
        {
            try
            {
                myCmdOLTP.Connection = myConnOLTP;
                myCmdOLAP.Connection = myConnOLAP;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    myCmdOLAP.CommandText = "INSERT INTO catalog (ID_catalog, ID_game, ID_user ,product_name,`description`,harga,imgproduct,statusdel,catalog_origin) VALUES ('" + 
                                            dt.Rows[i][0].ToString() + "','" + dt.Rows[i][1].ToString() + "','" + dt.Rows[i][2].ToString() + "','" + 
                                            dt.Rows[i][3].ToString() + "','" + dt.Rows[i][4].ToString() + "','" + dt.Rows[i][5].ToString() + "','" + dt.Rows[i][6].ToString() + "','" + dt.Rows[i][7].ToString() + "','"+ originOLTP + "')";
                    myCmdOLAP.ExecuteNonQuery();

                    myCmdOLTP.CommandText = "UPDATE catalog SET is_warehouse = 1 WHERE ID_catalog='" + dt.Rows[i][0].ToString() + "';";
                    myCmdOLTP.ExecuteNonQuery();
                }
                MessageBox.Show("Berhasil LOAD DATA ke DW utk table " + cbTable.Text);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

        private void loadgames()
        {
            try
            {
                myCmdOLTP.Connection = myConnOLTP;
                myCmdOLAP.Connection = myConnOLAP;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    myCmdOLAP.CommandText = "INSERT INTO games (ID_game, game_name, `description`, genre, img, statusdel, games_origin) VALUES ('" +
                                            dt.Rows[i][0].ToString() + "','" + dt.Rows[i][1].ToString() + "','" + dt.Rows[i][2].ToString() + "','" + 
                                            dt.Rows[i][3].ToString() + "','" + dt.Rows[i][4].ToString() + "','" + dt.Rows[i][5].ToString() + "','" + originOLTP + "')";
                    myCmdOLAP.ExecuteNonQuery();

                    myCmdOLTP.CommandText = "UPDATE games SET is_warehouse = 1 WHERE ID_game='" + dt.Rows[i][0].ToString() + "';";
                    myCmdOLTP.ExecuteNonQuery();

                }
                MessageBox.Show("Berhasil LOAD DATA ke DW utk table " + cbTable.Text);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

        private void loadkeranjang()
        {
            try
            {
                myCmdOLTP.Connection = myConnOLTP;
                myCmdOLAP.Connection = myConnOLAP;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    myCmdOLAP.CommandText = "INSERT INTO keranjang (ID_keranjang, ID_user, ID_catalog, harga, statusdel, keranjang_origin) VALUES ('" +
                                            dt.Rows[i][0].ToString() + "','" + dt.Rows[i][1].ToString() + "','" + dt.Rows[i][2].ToString() + "','" + Convert.ToInt32(dt.Rows[i][3]) + "','" + 
                                            dt.Rows[i][4].ToString() + "','"  + originOLTP + "')";
                    myCmdOLAP.ExecuteNonQuery();

                    myCmdOLTP.CommandText = "UPDATE keranjang SET is_warehouse = 1 WHERE ID_keranjang='" + dt.Rows[i][0].ToString() + "';";
                    myCmdOLTP.ExecuteNonQuery();
                }
                MessageBox.Show("Berhasil LOAD DATA ke DW utk table " + cbTable.Text);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }
        private void loadreview()
        {
            try
            {
                myCmdOLTP.Connection = myConnOLTP;
                myCmdOLAP.Connection = myConnOLAP;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    myCmdOLAP.CommandText = "INSERT INTO review (ID_review, ID_user, ID_catalog, review_date, rating, review_text, statusdel,review_origin ) VALUES ('" +
                                            dt.Rows[i][0].ToString() + "','" + dt.Rows[i][1].ToString() + "','" + dt.Rows[i][2].ToString() + "','" +
                                            dt.Rows[i][3].ToString() + "','" + Convert.ToDouble(dt.Rows[i][4]) + "','" + dt.Rows[i][5].ToString() + "','" + dt.Rows[i][6].ToString() + "','" + originOLTP + "')";
                    myCmdOLAP.ExecuteNonQuery();

                    myCmdOLTP.CommandText = "UPDATE review SET is_warehouse = 1 WHERE ID_review='" + dt.Rows[i][0].ToString() + "';";
                    myCmdOLTP.ExecuteNonQuery();

                }
                MessageBox.Show("Berhasil LOAD DATA ke DW utk table " + cbTable.Text);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

        private void loadtransaksi()
        {
            try
            {
                myCmdOLTP.Connection = myConnOLTP;
                myCmdOLAP.Connection = myConnOLAP;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    myCmdOLAP.CommandText = "INSERT INTO transaksi (ID_transaksi, ID_catalog, transaksi_date1, ID_user, harga, deskripsi, statusbyr, statustrans, statusdel, transaksi_origin) VALUES ('" +
                                            dt.Rows[i][0].ToString() + "','" + dt.Rows[i][1].ToString() + "','" + dt.Rows[i][2].ToString() + "','" +
                                            dt.Rows[i][3].ToString() + "','" + Convert.ToInt32(dt.Rows[i][4]) + "','" + dt.Rows[i][5].ToString() + "','" + dt.Rows[i][6].ToString() + "','" + dt.Rows[i][7].ToString() + "','" + dt.Rows[i][8].ToString() + "','" + originOLTP + "')";
                    myCmdOLAP.ExecuteNonQuery();

                    myCmdOLTP.CommandText = "UPDATE transaksi SET is_warehouse = 1 WHERE ID_transaksi='" + dt.Rows[i][0].ToString() + "';";
                    myCmdOLTP.ExecuteNonQuery();

                }
                MessageBox.Show("Berhasil LOAD DATA ke DW utk table " + cbTable.Text);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }
        private void loaduser()
        {
            try
            {
                myCmdOLTP.Connection = myConnOLTP;
                myCmdOLAP.Connection = myConnOLAP;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    myCmdOLAP.CommandText = "INSERT INTO user (ID_user, user_role, username, `password`, email, sub_date, statusdel, user_origin) VALUES ('" +
                                            dt.Rows[i][0].ToString() + "','" + dt.Rows[i][1].ToString() + "','" + dt.Rows[i][2].ToString() + "','" +
                                            dt.Rows[i][3].ToString() + "','" + dt.Rows[i][4].ToString() + "','" + dt.Rows[i][5].ToString() + "','" + dt.Rows[i][6].ToString() +  "','" + originOLTP + "')";
                    myCmdOLAP.ExecuteNonQuery();

                    myCmdOLTP.CommandText = "UPDATE user SET is_warehouse = 1 WHERE ID_user='" + dt.Rows[i][0].ToString() + "';";
                    myCmdOLTP.ExecuteNonQuery();

                }
                MessageBox.Show("Berhasil LOAD DATA ke DW utk table " + cbTable.Text);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }
        private void loadwishlist()
        {
            try
            {
                myCmdOLTP.Connection = myConnOLTP;
                myCmdOLAP.Connection = myConnOLAP;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    myCmdOLAP.CommandText = "INSERT INTO wishlist (ID_wishlist, ID_user, ID_catalog, harga, statusdel, wishlist_origin) VALUES ('" +
                                            dt.Rows[i][0].ToString() + "','" + dt.Rows[i][1].ToString() + "','" + dt.Rows[i][2].ToString() + "','" +
                                            Convert.ToInt64(dt.Rows[i][3]) + "','" + dt.Rows[i][4].ToString() + "','" + originOLTP + "')";
                    myCmdOLAP.ExecuteNonQuery();

                    myCmdOLTP.CommandText = "UPDATE wishlist SET is_warehouse = 1 WHERE ID_wishlist='" + dt.Rows[i][0].ToString() + "';";
                    myCmdOLTP.ExecuteNonQuery();

                }
                MessageBox.Show("Berhasil LOAD DATA ke DW utk table " + cbTable.Text);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }
        private void FormExtractLoad_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (myConnOLTP != null)
                if (myConnOLTP.State == ConnectionState.Open) myConnOLTP.Close();
            if (myConnOLAP != null)
                if (myConnOLAP.State == ConnectionState.Open) myConnOLAP.Close();
        }
    
        private void tbHostOLAP_TextChanged(object sender, EventArgs e)
        {

        }

        private void cbDBNameOLTP_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
