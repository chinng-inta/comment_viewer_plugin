using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.IO;
using System.Xml.Linq;
using System.Diagnostics;
using Plugin;
using System.ComponentModel.Composition;
using SitePlugin;
using System.Windows.Input;
using GalaSoft.MvvmLight.CommandWpf;
using MCV_Plugin_forVCas_Plugin.ViewModel;

namespace MCV_Plugin_forVCas_Plugin
{
    [Export(typeof(IPlugin))]
    public class Class1 : IPlugin, IDisposable
    {
        protected virtual Options Options { get; set; }
        private System.Timers.Timer _writeTimer;
        private SynchronizedCollection<Data> _commentCollection = new SynchronizedCollection<Data>();

        string[] commentList = new string[9] { @"Comment1", @"Comment2", @"Comment3", @"Comment4", @"Comment5", @"Comment6", @"Comment7", @"Comment8", @"Comment9" };

        public string Name => "VCas";

        public string Description => "VCas";
        public IPluginHost Host { get; set; }
        UserControl1 form;

        public void OnCommentReceived(ICommentData data)
        {
            if ( data.IsFirstComment)
                return;

            var a = new Data
            {
                Comment = data.Comment,
                Nickname = data.Nickname,
                SiteName = data.SiteName,
            };
            _commentCollection.Add(a);
        }
        class CommentData : ICommentData
        {
            public string ThumbnailUrl { get; set; }
            public int ThumbnailWidth { get; set; }
            public int ThumbnailHeight { get; set; }
            public string Id { get; set; }
            public string UserId { get; set; }
            public string Nickname { get; set; }
            public string Comment { get; set; }
            public bool IsNgUser { get; set; }
            public bool IsFirstComment { get; set; }
            public string SiteName { get; set; }
            public bool Is184 { get; set; }
        }
        class Data
        {
            public object Comment { get; internal set; }
            public object SiteName { get; internal set; }
            public string Nickname { get; internal set; }
        }
        public void OnMessageReceived(IMessage message, IMessageMetadata messageMetadata)
        {
            if (!(message is IMessageComment comment)) return;


            //各サイトのサービス名
            //YouTubeLive:youtubelive
            //ニコ生:nicolive
            //Twitch:twitch
            //Twicas:twicas
            //ふわっち:whowatch
            //OPENREC:openrec
            //Mirrativ:mirrativ
            //LINELIVE:linelive
            //Periscope:periscope
            //Mixer:mixer

            string siteName;
            if (message is YouTubeLiveSitePlugin.IYouTubeLiveComment)
            {
                siteName = "youtubelive";
            }
            else if (message is NicoSitePlugin.INicoComment)
            {
                siteName = "nicolive";
            }
            else if (message is TwitchSitePlugin.ITwitchComment)
            {
                siteName = "twitch";
            }
            else if (message is TwicasSitePlugin.ITwicasComment)
            {
                siteName = "twicas";
            }
            else if (message is WhowatchSitePlugin.IWhowatchComment)
            {
                siteName = "whowatch";
            }
            else if (message is OpenrecSitePlugin.IOpenrecComment)
            {
                siteName = "openrec";
            }
            else if (message is MirrativSitePlugin.IMirrativComment)
            {
                siteName = "mirrativ";
            }
            else if (message is LineLiveSitePlugin.ILineLiveComment)
            {
                siteName = "linelive";
            }
            else if (message is PeriscopeSitePlugin.IPeriscopeComment)
            {
                siteName = "periscope";
            }
            else if (message is ShowRoomSitePlugin.IShowRoomComment)
            {
                siteName = "showroom";
            }
            //else if (message is MixerSitePlugin.IMixerComment)
            //{
            //    siteName = "mixer";
            //}
            else
            {
                siteName = "";
            }

            string name;
            if (messageMetadata.User != null && !string.IsNullOrEmpty(messageMetadata.User.Nickname))
            {
                name = messageMetadata.User.Nickname;
            }
            else
            {
                name = comment.NameItems.ToText();
            }
            name = name.Replace("\n", "").Replace("$", "＄").Replace("\\", "￥").Replace("/", "／");

            string _comment = comment.CommentItems.ToText();
            _comment = _comment.Replace("\n", "").Replace("$", "＄").Replace("\\", "￥").Replace("/", "／").Replace("\"", "");
            var data = new Data
            {
                Comment = _comment,
                Nickname = name,
                SiteName = siteName,
            };
            _commentCollection.Add(data);
        }
        public virtual void OnLoaded()
        {
            //throw new NotImplementedException();
            Options = Options.Load();
            startTimer();
        }

        public  void startTimer()
        {
            _writeTimer = new System.Timers.Timer
            {
                Interval = 1000
            };
            _writeTimer.Elapsed += _writeTimer_Elapsed;
            _writeTimer.Start();
        }

        public void stopTimer()
        {
            _writeTimer?.Stop();
        }

        private void _writeTimer_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            //定期的にcomment.xmlに書き込む。

            Write();
        }

        public void writeLuaFile()
        {
            string message;
            string luaFile = Options.luaFile;
            
            try
            {
                StreamReader sr = new StreamReader(luaFile, Encoding.GetEncoding("utf-8"));
                string rStr = sr.ReadToEnd();
                sr.Close();

                for (int i = 0; i < commentList.Length; i++)
                {
                    message = commentList[i];

                    string msg= message;

                    if (Regex.IsMatch(msg, "Comment[0-9]") == true)
                    {
                        msg = Regex.Replace(msg, "Comment[0-9]", "\"" + msg + "\"");
                    }
                    rStr = Regex.Replace(rStr, @"commentList\[" + (i + 1).ToString() + @"\] = .+", @"commentList[" + (i + 1).ToString() + "] = " + msg + "");
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

        /// <summary>
        /// _commentCollectionの内容をファイルに書き出す
        /// </summary>
        public void Write()
        {
            if (Options.isStarted == false)
                return;

            if (_commentCollection.Count == 0)
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
                if(count > 9)
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

            Options.commentList1 = commentList[5];
            Options.commentList2 = commentList[6];
            Options.commentList3 = commentList[7];
            Options.commentList4 = commentList[8];

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
        public void OnClosing()
        {
            _writeTimer?.Stop();
        }
        public void ShowSettingView()
        {
            form = new UserControl1 {
                DataContext = new MainViewModel(Options)
            };
            form.Show();
        }
        [GalaSoft.MvvmLight.Ioc.PreferredConstructor]
        public Class1()
        {
        }

        public string GetSettingsFilePath()
        {
            var dir = Host.SettingsDirPath;
            return Path.Combine(dir, $"{Name}.lua");
        }
        public void Dispose()
        {
            _writeTimer.Dispose();
        }

        public void OnTopmostChanged(bool isTopmost)
        {

        }
    }
}
