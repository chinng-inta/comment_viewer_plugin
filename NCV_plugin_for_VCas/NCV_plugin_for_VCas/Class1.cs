using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Plugin;
using System.Windows.Forms;

namespace NCV_plugin_for_VCas
{
    public class Class1 : IPlugin
    {
        private IPluginHost _host = null;
        //フォームの変数
        Form1 form = null;

        public IPluginHost Host {
            get
            {
                //throw new NotImplementedException();
                return this._host;
            }
            set
            {
                //throw new NotImplementedException();
                this._host = value;
            }
        }

        public bool IsAutoRun {
            get
            {
                //throw new NotImplementedException();
                return false;
            }
        }


        public string Description
        {
            get
            {
                //throw new NotImplementedException();
                return "あんこちゃんからLuaにコメントを送信";
            }
        }

        public string Version
        {
            get
            {
                //throw new NotImplementedException();
                return "0.1β";
            }
        }

        public string Name
        {
            get
            {
                //throw new NotImplementedException();
                return "NCV_plugin_for_VCas";
            }
        }

        public void AutoRun()
        {
            // throw new NotImplementedException();
        }

        public void Run()
        {
            //  throw new NotImplementedException();
            if (form == null)
            {
                //フォームの生成
                form = new Form1();
                //フォームの表示
                form.Show(_host.MainForm);
                //フォームクローズイベント
                form.FormClosing += Form_FormClosing;

                //放送接続イベントハンドラ追加
                _host.BroadcastConnected += new BroadcastConnectedEventHandler(_host_BroadcastConnected);

                //放送切断イベントハンドラ追加
                _host.BroadcastDisConnected += new BroadcastDisConnectedEventHandler(_host_BroadcastDisConnected);

                //コメント受信時のイベントハンドラ追加
                _host.ReceivedComment += new ReceivedCommentEventHandler(_host_ReceivedComment);

            }
        }

        private void Form_FormClosing(object sender, System.Windows.Forms.FormClosingEventArgs e)
        {
            //コメント受信時のイベントハンドラ削除
            _host.ReceivedComment -= _host_ReceivedComment;

            //放送開始直後イベントハンドラ削除
            _host.BroadcastConnected -= _host_BroadcastConnected;

            //放送終了直後のイベントハンドラ削除
            _host.BroadcastDisConnected -= _host_BroadcastDisConnected;

            form.FormClosing -= Form_FormClosing;
            //throw new NotImplementedException();
            form = null;
        }
        //放送接続時イベントハンドラ
        void _host_BroadcastConnected(object sender, EventArgs e)
        {
//             MessageBox.Show("放送に接続しました", Name);//動作確認用MessageBox
        }

        //放送切断時イベントハンドラ
        void _host_BroadcastDisConnected(object sender, EventArgs e)
        {
//             MessageBox.Show("放送から切断しました", Name);//動作確認用MessageBox
        }

        //コメント受信時イベントハンドラ
        void _host_ReceivedComment(object sender, ReceivedCommentEventArgs e)
        {

            //受信したコメント数を取り出す
            int count = e.CommentDataList.Count;
            if (count == 0)
            {
                return;
            }

            //最新のコメントデータを取り出す
            NicoLibrary.NicoLiveData.LiveCommentData commentData = e.CommentDataList[count - 1];
            string comment = commentData.Comment;

            if ( ( (commentData.PremiumBits & NicoLibrary.NicoLiveData.PremiumFlags.ServerComment ) == NicoLibrary.NicoLiveData.PremiumFlags.ServerComment ) &&
                 form.getCheckBox() == true )
            {
                form.addOpeCommentArray(comment);
            } else
            {
                //コメント文字列を取り出す
                string user = commentData.Name;
                form.addCommentArray(user, comment);
            }

        }
    }
}
