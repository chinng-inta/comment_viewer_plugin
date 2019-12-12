using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace shocoroPrugin
{
    public partial class Form1 : Form
    {
        List<Gifts> giftList;
        bool started;
        Thread t;

        public Form1()
        {
            InitializeComponent();
            this.button1.Click += new EventHandler(refButton_Click);
            this.startButton.Click += new EventHandler(startButton_Click);
            giftList = new List<Gifts>();
            started = false;
        }

        private void Form1_Load(object sender, EventArgs e)
        {
        }
        // イベントハンドラ本体
        void refButton_Click(object sender, EventArgs e)
        {
            DialogResult dlgRetCode; //ファイルファイアログの戻り値格納用


            //ダイアログボックスのタイトル
            this.参照.Title = "luaソースコードの選択";

            //ダイアログ初期表示ファイル名
            this.参照.FileName = "";

            //存在しないファイルが指定された時の動作
            this.参照.CheckFileExists = true;

            //ファイルフィルター
            this.参照.Filter = "Lua|*.lua";

            //ダイアログ初期表示のディレクトリ
            this.参照.InitialDirectory = @"D:\Test";

            //ダイアログ表示
            dlgRetCode = this.参照.ShowDialog();

            //OKボタンが押下された時の動作
            if (dlgRetCode == DialogResult.OK)
            {
                MessageBox.Show("ファイルパス：" + this.参照.FileName +
                                "\r\n" +
                                "ファイル名　：" + this.参照.SafeFileName);

            }
            this.textBox1.Text = this.参照.FileName;
        }
        void startButton_Click(object sender, EventArgs e)
        {
            if(started == false)
            {
                this.startButton.Text = "停止";
                started = true;

                t = new Thread(new ThreadStart(writeThread));
                // スレッドを開始する
                t.Start();

                t.IsBackground = true;
            } else
            {
                this.startButton.Text = "開始";
                started = false;
                t.Join();
            }

        }
        public void userNameChange(string ChangeText)
        {
            userName.Text = ChangeText;
        }
        public void giftNameChange(string ChangeText)
        {
            giftName.Text = ChangeText;
        }
        public void giftCntChange(string ChangeText)
        {
            giftCnt.Text = ChangeText + "個";
        }
        public void addGiftList(string name, int cnt)
        {
            Gifts gift = new Gifts();
            gift.Name = name;
            gift.Count = cnt;

            giftList.Add(gift);
        }
        public async void writeThread()
        {
            while(started == true)
            {
                writeLuaFile();
                await Task.Delay(1000);
            }

        }
        public void writeLuaFile()
        {
            int SeedA = 0;
            int SeedB = 0;
            int SeedC = 0;
            int SeedD = 0;
            int SeedE = 0;
            int Heart = 0;

            foreach (Gifts gift in giftList)
            {
                switch (gift.Name)
                {
                    case "seedA":
                        SeedA += gift.Count;
                        break;
                    case "seedB":
                        SeedB += gift.Count;
                        break;
                    case "seedC":
                        SeedC += gift.Count;
                        break;
                    case "seedD":
                        SeedD += gift.Count;
                        break;
                    case "seedE":
                        SeedE += gift.Count;
                        break;
                    case "3":
                        Heart += gift.Count;
                        break;
                    default:
                        break;
                }
            }
            giftList.Clear();

            try
            {
                string luaFile = @"" + this.textBox1.Text;
                StreamReader sr = new StreamReader(luaFile, Encoding.GetEncoding("utf-8"));
                string rStr = sr.ReadToEnd();
                sr.Close();

                rStr = Regex.Replace(rStr, @"SeedA = [0-9]+", "SeedA = " + SeedA.ToString());
                rStr = Regex.Replace(rStr, @"SeedB = [0-9]+", "SeedB = " + SeedB.ToString());
                rStr = Regex.Replace(rStr, @"SeedC = [0-9]+", "SeedC = " + SeedC.ToString());
                rStr = Regex.Replace(rStr, @"SeedD = [0-9]+", "SeedD = " + SeedD.ToString());
                rStr = Regex.Replace(rStr, @"SeedE = [0-9]+", "SeedE = " + SeedE.ToString());
                rStr = Regex.Replace(rStr, @"Heart = [0-9]+", "Heart = " + Heart.ToString());

                StreamWriter sw = new StreamWriter(
                    luaFile,
                    false,
                    System.Text.Encoding.GetEncoding("utf-8")
                    );

                sw.Write(rStr);
                sw.Close();
            }
            catch (DirectoryNotFoundException sr)
            {
                // Let the user know that the directory did not exist.
                errorLabel.Text = sr.Message;
            }
        }
    }
}
