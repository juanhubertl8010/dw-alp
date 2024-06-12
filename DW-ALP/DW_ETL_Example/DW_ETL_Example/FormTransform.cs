using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

namespace DW_ETL_Example
{
    public partial class FormTransform : Form
    {
        MySqlConnection myConnOLAP;
        MySqlCommand myCmdOLAP = new MySqlCommand();
        MySqlDataAdapter myAdapter;
        DataTable dt;

        public FormTransform()
        {
            InitializeComponent();
        }

        private void btnConnectOLAP_Click(object sender, EventArgs e)
        {
            connToOLAPDB(tbHostOLAP.Text, tbUserOLAP.Text, tbPassOLAP.Text, tbDBNameOLAP.Text);
            connectedOLAPComponent();
        }

        private void btnDiscOLAP_Click(object sender, EventArgs e)
        {
            disconnectedOLAPComponent();
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
            btnTransform.Enabled = true;
            lblStatOLAP.Text = "Status OLAP : Connected";
            showFactTable();
        }

        private void disconnectedOLAPComponent()
        {
            tbHostOLAP.Enabled = true;
            tbDBNameOLAP.Enabled = true;
            tbUserOLAP.Enabled = true;
            tbPassOLAP.Enabled = true;
            btnConnectOLAP.Enabled = true;
            btnDiscOLAP.Enabled = false;
            btnTransform.Enabled = false;
            lblStatOLAP.Text = "Status OLAP : Disconnected";
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

        private void FormTransform_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (myConnOLAP != null)
                if (myConnOLAP.State == ConnectionState.Open) myConnOLAP.Close();
        }

        private void btnTransform_Click(object sender, EventArgs e)
        {
            try
            {
                myCmdOLAP.Connection = myConnOLAP;
                string cmdText = @"
                (
                    SELECT user.ID_user, user.username, catalog.ID_catalog, transaksi.ID_transaksi, transaksi.transaksi_date1, user.user_origin, catalog.harga 
                    FROM user, catalog, transaksi 
                    WHERE user.ID_user = transaksi.ID_user 
                      AND catalog.ID_catalog = transaksi.ID_catalog 
                      AND catalog.harga = transaksi.harga 
                      AND transaksi.is_fact = 1
                      AND user.user_origin = catalog.catalog_origin 
                      AND user.user_origin = transaksi.transaksi_origin 
                      AND user.user_origin = 'Juan'
                    GROUP BY user.ID_user, user.username, catalog.ID_catalog, transaksi.ID_transaksi, transaksi.transaksi_date1, user.user_origin, catalog.harga
                )
                UNION 
                (
                    SELECT user.ID_user, user.username, catalog.ID_catalog, transaksi.ID_transaksi, transaksi.transaksi_date1, user.user_origin, catalog.harga 
                    FROM user, catalog, transaksi 
                    WHERE user.ID_user = transaksi.ID_user 
                      AND catalog.ID_catalog = transaksi.ID_catalog 
                      AND catalog.harga = transaksi.harga 
                      AND transaksi.is_fact = 1
                      AND user.user_origin = catalog.catalog_origin 
                      AND user.user_origin = transaksi.transaksi_origin 
                      AND user.user_origin = 'Rangga'
                    GROUP BY user.ID_user, user.username, catalog.ID_catalog, transaksi.ID_transaksi, transaksi.transaksi_date1, user.user_origin, catalog.harga
                )
                UNION
                (
                    SELECT user.ID_user, user.username, catalog.ID_catalog, transaksi.ID_transaksi, transaksi.transaksi_date1, user.user_origin, catalog.harga 
                    FROM user, catalog, transaksi 
                    WHERE user.ID_user = transaksi.ID_user 
                      AND catalog.ID_catalog = transaksi.ID_catalog 
                      AND catalog.harga = transaksi.harga 
                      AND transaksi.is_fact = 1
                      AND user.user_origin = catalog.catalog_origin 
                      AND user.user_origin = transaksi.transaksi_origin 
                      AND user.user_origin = 'Kenneith'
                    GROUP BY user.ID_user, user.username, catalog.ID_catalog, transaksi.ID_transaksi, transaksi.transaksi_date1, user.user_origin, catalog.harga
                )
                UNION
                (
                    SELECT user.ID_user, user.username, catalog.ID_catalog, transaksi.ID_transaksi, transaksi.transaksi_date1, user.user_origin, catalog.harga 
                    FROM user, catalog, transaksi 
                    WHERE user.ID_user = transaksi.ID_user 
                      AND catalog.ID_catalog = transaksi.ID_catalog 
                      AND catalog.harga = transaksi.harga 
                      AND transaksi.is_fact = 1  
                      AND user.user_origin = catalog.catalog_origin 
                      AND user.user_origin = transaksi.transaksi_origin 
                      AND user.user_origin = 'Valent'
                    GROUP BY user.ID_user, user.username, catalog.ID_catalog, transaksi.ID_transaksi, transaksi.transaksi_date1, user.user_origin, catalog.harga
                )
                ORDER BY 4;";
                myAdapter = new MySqlDataAdapter(cmdText, myConnOLAP);
                dt = new DataTable();
                myAdapter.Fill(dt);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    myCmdOLAP.CommandText = "INSERT INTO SalesFact1 (ID_user, username, ID_catalog, ID_transaksi, transaksi_date1, user_origin, harga) VALUES ('" + dt.Rows[i][0].ToString() + "','" + dt.Rows[i][1].ToString() + "','" + dt.Rows[i][2].ToString() + "','" + dt.Rows[i][3].ToString() + "','" +
                                            dt.Rows[i][4].ToString() + "','" + dt.Rows[i][5].ToString() + "','" + dt.Rows[i][6].ToString() + "')";
                    myCmdOLAP.ExecuteNonQuery();
                    myCmdOLAP.CommandText = "UPDATE transaksi SET is_fact = 2 WHERE ID_transaksi = '" + dt.Rows[i][3].ToString() + "'";
                    myCmdOLAP.ExecuteNonQuery();
                }

                showFactTable();
                MessageBox.Show("Berhasil Membuat FACT TABLE");
            } 
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

        private void showFactTable()
        {
            try
            {
                myAdapter = new MySqlDataAdapter("SELECT ID_user, username, ID_catalog, ID_transaksi, transaksi_date1, user_origin, harga FROM SalesFact1 ORDER BY 1 DESC", myConnOLAP);
                dt = new DataTable();
                myAdapter.Fill(dt);
                dgvFactTable.DataSource = dt;
                dgvFactTable.Refresh();
            } catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

        private void FormTransform_Load(object sender, EventArgs e)
        {
            disconnectedOLAPComponent();
        }
    }
}
