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
using Codeplex.Data;

namespace NCV_plugin_for_VCas
{
    public partial class Form1 : Form
    {
        bool started;
        string[] commentList = new string[9] { @"Comment1", @"Comment2", @"Comment3", @"Comment4", @"Comment5", @"Comment6", @"Comment7", @"Comment8", @"Comment9" };
        string[] opecommentList = new string[9] { @"opeComment1", @"opeComment2", @"opeComment3", @"opeComment4", @"opeComment5", @"opeComment6", @"opeComment7", @"opeComment8", @"opeComment9" };
        Thread t;

        public Form1()
        {
            InitializeComponent();
            this.button1.Click += new EventHandler(refButton_Click);
            this.startButton.Click += new EventHandler(startButton_Click);
            started = false;
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
        public bool getCheckBox()
        {
            if (this.checkBox1.Checked == true)
            {
                return true;
            }
            return false;
        }
        void startButton_Click(object sender, EventArgs e)
        {
            if (started == false)
            {
                this.startButton.Text = "停止";
                started = true;
                t = new Thread(new ThreadStart(writeThread));
                // スレッドを開始する
                t.Start();
            }
            else
            {
                this.startButton.Text = "開始";
                started = false;
                t.Join();
            }
        }
        public async void writeThread()
        {
            while (started == true)
            {
                writeLuaFile();
                await Task.Delay(1000);
            }

        }
        public void addCommentArray(string user, string message)
        {
            for (int i = 0; i < commentList.Length - 1; i++)
            {
                commentList[i] = commentList[i + 1];
            }
            commentList[commentList.Length - 1] = @"{" + "live=" + "\"nicolive\"" + "," + "date=" + ToUnixTime(GetCurrentDateTime()) + "," + "user=\"" + user + "\"," + "msg=\"" + message + "\"}";
            mseesageLabel.Text = commentList[commentList.Length - 1];
        }
        protected virtual DateTime GetCurrentDateTime()
        {
            return DateTime.Now;
        }

        public static long ToUnixTime(DateTime dateTime)
        {
            // 時刻をUTCに変換
            dateTime = dateTime.ToUniversalTime();

            // unix epochからの経過秒数を求める
            return (long)dateTime.Subtract(new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalSeconds;
        }
        public void addOpeCommentArray(string message)
        {
            for (int i = 0; i < opecommentList.Length - 1; i++)
            {
                opecommentList[i] = opecommentList[i + 1];
            }
            string msg = message.Replace("\"", "\\\"");
            string[] str = msg.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);

            switch (str[0])
            {

                case "/nicoad":
                    str[1] = str[1].Replace("\\", "");
                    dynamic obj = DynamicJson.Parse(@"" + str[1]);
                    if (obj.IsDefined("message") == true)
                    {
                        msg = obj.message;
                    }
                    else
                    {
                        msg = str[1];
                        mseesageLabel.Text = obj;
                    }
                    break;
                case "/info":
                    msg = str[2];
                    break;
                case "/gift":
                    string user = str[3].Replace("/", "／");
                    msg = user + "さんからギフト" + str[6];
                    msg = msg.Replace("\\\"", "");
                    break;
                case "/cruise":
                    msg = str[1];
                    msg = msg.Replace("\\\"", "");
                    break;
                case "/quote":
                    msg = str[1];
                    msg = msg.Replace("\\\"", "");
                    break;
                case "/uadpoint":
                    msg = "広告が設定されました累計ポイントが" + str[2] + "になりました";
                    msg = msg.Replace("\\\"", "");
                    break;
                case "/disconnect":
                    msg = "disconnect";
                    msg = msg.Replace("\\\"", "");
                    break;
                case "/spi":
                    msg = str[1];
                    msg = msg.Replace("\\\"", "");
                    break;
                case "/perm":
                    msg = msg.Replace("\n", "").Replace("$", "＄").Replace("/", "／");
                    msg = msg.Replace("\\\"", "");
                    break;
                default:
                    msg = msg.Replace("\n", "").Replace("$", "＄").Replace("/", "／");
                    msg = msg.Replace("\\\"", "").Replace("\\", "￥");
                    break;
            }
            opecommentList[opecommentList.Length - 1] = @"{date = " + ToUnixTime(GetCurrentDateTime()) + ",msg = \"" + msg + "\"}";
            mseesageLabel.Text = msg;
        }
        public void writeLuaFile()
        {
            string message;

            if (started != true)
                return;

            try
            {
                string luaFile = @"" + this.textBox1.Text;
                StreamReader sr = new StreamReader(luaFile, Encoding.GetEncoding("utf-8"));
                string rStr = sr.ReadToEnd();
                sr.Close();

                for (int i = 0; i < commentList.Length; i++)
                {
                    string msg = commentList[i];
                    msg = Regex.Replace(msg, "Comment[0-9]", "\"" + msg + "\"");

                    rStr = Regex.Replace(rStr, @"commentList\[" + (i + 1).ToString() + @"\] = .+", @"commentList[" + (i + 1).ToString() + "] = " + msg + "");
                }

                for (int i = 0; i < opecommentList.Length; i++)
                {
                    message = opecommentList[i];

                    message = Regex.Replace(message, "opeComment[0-9]", "\"" + message + "\"");


                    rStr = Regex.Replace(rStr, @"opeCommentList\[" + (i + 1).ToString() + @"\] = .+", @"opeCommentList[" + (i + 1).ToString() + "] = " + message + "");
                }

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
            }

        }
    }
}
