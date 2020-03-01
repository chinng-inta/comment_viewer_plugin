using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.Composition;
using System.Data;
using System.Diagnostics;
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
        private SynchronizedCollection<Data> _commentCollection = new SynchronizedCollection<Data>();
        private SynchronizedCollection<Data> _opecommentCollection = new SynchronizedCollection<Data>();
        string[] commentList = new string[9] { @"Comment1", @"Comment2", @"Comment3", @"Comment4", @"Comment5", @"Comment6", @"Comment7", @"Comment8", @"Comment9" };
        string[] opecommentList = new string[9] { @"opeComment1", @"opeComment2", @"opeComment3", @"opeComment4", @"opeComment5", @"opeComment6", @"opeComment7", @"opeComment8", @"opeComment9" };
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
            if(started == false)
            {
                if (string.IsNullOrEmpty(this.textBox1.Text) == true)
                {
                    MessageBox.Show("main.luaを指定してください");
                    return;
                }
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
                Write();
                await Task.Delay(1000);
            }

        }
        class Data
        {
            public object Comment { get; internal set; }
            public object SiteName { get; internal set; }
            public string Nickname { get; internal set; }
        }
        public void addCommentArray(string user, string message)
        {
//            for (int i = 0; i < commentList.Length - 1; i++)
//            {
//                commentList[i] = commentList[i + 1];
//            }

            user = user.Replace("\n", "").Replace("$", "＄").Replace("\\", "￥").Replace("/", "／");
            message = message.Replace("\n", "").Replace("$", "＄").Replace("\\", "￥").Replace("/", "／").Replace("\"", ""); ;
//            commentList[commentList.Length - 1] = @"{"+ "live=" + "\"showroom\"" + "," + "date=" + ToUnixTime(GetCurrentDateTime()) + "," + "user=\"" + user + "\"," + "msg=\"" + message + "\"}";
//            mseesageLabel.Text = commentList[commentList.Length - 1];
            var data = new Data
            {
                Comment = message,
                Nickname = user,
                SiteName = "showroom",
            };
            _commentCollection.Add(data);
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
//            for (int i = 0; i < opecommentList.Length -1; i++)
//            {
//                opecommentList[i] = opecommentList[i + 1];
//            }
            string msg = message.Replace("\"", "\\\"");
            string[] str = msg.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);

            opecommentList[opecommentList.Length - 1] = @"{date = " + ToUnixTime(GetCurrentDateTime()) + ", msg = \"" + msg + "\"}";
            var data = new Data
            {
                Comment = msg,
                Nickname = "",
                SiteName = "",
            };
            _opecommentCollection.Add(data);
        }
        public void writeLuaFile()
        {
            string message;

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

        public void Write()
        {
            if (started != true)
                return;

            if (_commentCollection.Count == 0 && _opecommentCollection.Count == 0)
                return;

            var arr = _commentCollection.ToArray();
            List<string> _commentList = new List<string>();

            int count = 0;

            foreach (var data in arr)
            {
                string msg = "";

                //2019/08/25 コメジェネの仕様で、handleタグが無いと"0コメ"に置換されてしまう。だから空欄でも良いからhandleタグは必須。
                var handle = string.IsNullOrEmpty(data.Nickname) ? "" : data.Nickname;

                msg = @"{" + "live=\"" + data.SiteName + "\"," + "date=" + ToUnixTime(GetCurrentDateTime()) + "," + "user=\"" + handle + "\"," + "msg=\"" + data.Comment + "\"}";
                _commentList.Add(msg);
                _commentCollection.RemoveAt(0);
                count++;
                if (count > 9)
                {
                    break;
                }
            }
            for (int i = 0; i < (9 - count); i++)
                commentList[i] = commentList[i + count];
            for (int i = 0; i < count; i++)
            {
                commentList[9 - count + i] = _commentList[i];
            }

            var arr1 = _opecommentCollection.ToArray();
            List<string> _opecommentList = new List<string>();

            count = 0;
            foreach (var data in arr1)
            {
                string msg = "";

                //2019/08/25 コメジェネの仕様で、handleタグが無いと"0コメ"に置換されてしまう。だから空欄でも良いからhandleタグは必須。
                var handle = string.IsNullOrEmpty(data.Nickname) ? "" : data.Nickname;

                msg = @"{" + "date=" + ToUnixTime(GetCurrentDateTime()) + ", " + "msg=\"" + data.Comment + "\"}";
                _opecommentList.Add(msg);
                _opecommentCollection.RemoveAt(0);
                count++;
                if (count > 9)
                {
                    break;
                }
            }
            for (int i = 0; i < (9 - count); i++)
                opecommentList[i] = opecommentList[i + count];
            for (int i = 0; i < count; i++)
            {
                opecommentList[9 - count + i] = _opecommentList[i];
            }

            try
            {
                writeLuaFile();
            }
            catch (IOException ex)
            {
                //コメントの流れが早すぎるとused in another processが来てしまう。
                //この場合、コメントが書き込まれずに消されてしまう。
                Debug.WriteLine(ex.Message);
                return;
            }

            return;
        }
    }
}
