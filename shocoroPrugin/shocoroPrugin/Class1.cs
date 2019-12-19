using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Codeplex.Data;
using ankoPlugin2;

namespace shocoroPrugin
{
    public class Class1 : ankoPlugin2.IPlugin
    {
        //ホストをもらう変数
        ankoPlugin2.IPluginHost _host = null;

        //フォームの変数
        Form1 form = null;

        public IPluginHost host
        {
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

        public string Name
        {
            get
            {
                //throw new NotImplementedException();
                return "ShocoroToLua";
            }
        }

        public string Description
        {
            get
            {
                //throw new NotImplementedException();
                return "しょころからLuaにコメントを送信";
            }
        }

        public bool IsAlive
        {
            get
            {
                //throw new NotImplementedException();
                return false;
            }
        }

        public void Run()
        {
            //throw new NotImplementedException();
            if (form == null)
            {
                //フォームの生成
                form = new Form1();
                //オーナー設定
                form.Owner = (System.Windows.Forms.Form)_host.Win32WindowOwner;
                //TopMostを受け取る
                form.TopMost = ((System.Windows.Forms.Form)_host.Win32WindowOwner).TopMost;
                //フォームの表示
                form.Show();
                //フォームクローズイベント
                form.FormClosing += Form_FormClosing;

                //接続・切断のイベントを追加する
                _host.ConnectedServer += new EventHandler<ankoPlugin2.ReceiveContentStatusEventArgs>(_host_ConnectedServer);
                _host.DisconnectedServer += new EventHandler<ankoPlugin2.ConnectStreamEventArgs>(_host_DisconnectedServer);

                //コメント受信イベント
                _host.ReceiveChat += new EventHandler<ankoPlugin2.ReceiveChatEventArgs>(_host_ReceiveChat);
            }
        }

        private void Form_FormClosing(object sender, System.Windows.Forms.FormClosingEventArgs e)
        {
            //コメント受信イベント
            _host.ReceiveChat -= new EventHandler<ankoPlugin2.ReceiveChatEventArgs>(_host_ReceiveChat);

            //接続・切断のイベントを追加する
            _host.ConnectedServer -= new EventHandler<ankoPlugin2.ReceiveContentStatusEventArgs>(_host_ConnectedServer);
            _host.DisconnectedServer -= new EventHandler<ankoPlugin2.ConnectStreamEventArgs>(_host_DisconnectedServer);

            //throw new NotImplementedException();
            form = null;
        }

        public void giftChecker( string userName, string message)
        {
            string giftLog = "gift_name";
            string countLog = "giftcount";

            
            if ( (message.Contains(giftLog) && message.Contains(countLog)) || form.getCheckBox() == true )
            {
                form.userNameChange(userName);
                userName = userName.Replace("\n", "").Replace("$", "＄").Replace("\\", "￥").Replace("/", "／");
                dynamic obj = DynamicJson.Parse(@"" + message);

                string gitfName = obj.gift_name;
                form.giftNameChange(gitfName);

                int num = message.IndexOf(countLog);
                num += countLog.Length + 2;
                int gitfCnt = 0;

                int.TryParse(obj.giftcount.ToString(), out gitfCnt);

                form.giftCntChange(obj.giftcount.ToString());
                string msg = userName + "から" + gitfName +"を"+ gitfCnt + "個";
                form.addOpeCommentArray(msg);
//                form.addGiftList(gitfName, gitfCnt);
            }else
            {
                form.addCommentArray(userName, message);
            }
        }
        /// <summary>
        /// コメント受信時に呼ばれる
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void _host_ReceiveChat(object sender, ankoPlugin2.ReceiveChatEventArgs e)
        {
                giftChecker(e.Chat.Name, e.Chat.Message);
        }
        /// <summary>
        /// 放送に接続したら呼ばれる
        /// ツールバーのコンボボックスで放送を変えても呼ばれる
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void _host_ConnectedServer(object sender, ankoPlugin2.ReceiveContentStatusEventArgs e)
        {
            //放送に接続したときに放送中か判定して
            //コントロールのON/OFFをする
        }

        /// <summary>
        /// 放送から切断したときに呼ばれる
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void _host_DisconnectedServer(object sender, ankoPlugin2.ConnectStreamEventArgs e)
        {
            //放送から切断したらコントロールを使えないようにする
        }
    }
}
