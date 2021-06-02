using SitePlugin;


namespace MCV_Plugin_forVCas_Plugin
{
    public static class Tools
    {
        public static string GetSiteName(ISiteMessage message, Options otionts)
        {
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
            //Mildom:mildom
            //NimoTV:nimotv

            string siteName;
            if (otionts.isAbbreviation)
            {
                switch (message)
                {
                    case YouTubeLiveSitePlugin.IYouTubeLiveMessage _:
                        siteName = "Yt";
                        break;
                    case NicoSitePlugin.INicoMessage _:
                        siteName = "Nico";
                        break;
                    case TwitchSitePlugin.ITwitchMessage _:
                        siteName = "twitch";
                        break;
                    case TwicasSitePlugin.ITwicasMessage _:
                        siteName = "twicas";
                        break;
                    case WhowatchSitePlugin.IWhowatchMessage _:
                        siteName = "who";
                        break;
                    case OpenrecSitePlugin.IOpenrecMessage _:
                        siteName = "orec";
                        break;
                    case MirrativSitePlugin.IMirrativMessage _:
                        siteName = "mir";
                        break;
                    case LineLiveSitePlugin.ILineLiveMessage _:
                        siteName = "line";
                        break;
                    case PeriscopeSitePlugin.IPeriscopeMessage _:
                        siteName = "peri";
                        break;

                    case MildomSitePlugin.IMildomMessage _:
                        siteName = "mil";
                        break;
                    default:
                        siteName = "unknown";
                        break;
                }

            }
            else
            {
                switch (message)
                {
                    case YouTubeLiveSitePlugin.IYouTubeLiveMessage _:
                        siteName = "youtubelive";
                        break;
                    case NicoSitePlugin.INicoMessage _:
                        siteName = "nicolive";
                        break;
                    case TwitchSitePlugin.ITwitchMessage _:
                        siteName = "twitch";
                        break;
                    case TwicasSitePlugin.ITwicasMessage _:
                        siteName = "twicas";
                        break;
                    case WhowatchSitePlugin.IWhowatchMessage _:
                        siteName = "whowatch";
                        break;
                    case OpenrecSitePlugin.IOpenrecMessage _:
                        siteName = "openrec";
                        break;
                    case MirrativSitePlugin.IMirrativMessage _:
                        siteName = "mirrativ";
                        break;
                    case LineLiveSitePlugin.ILineLiveMessage _:
                        siteName = "linelive";
                        break;
                    case PeriscopeSitePlugin.IPeriscopeMessage _:
                        siteName = "periscope";
                        break;
                    //                case MixerSitePlugin.IMixerMessage _:
                    //                    siteName = "mixer";
                    //                    break;
                    case MildomSitePlugin.IMildomMessage _:
                        siteName = "mildom";
                        break;
                    default:
                        siteName = "unknown";
                        break;
                }
            }

            return siteName;
        }
        /* Plugincommon.Tool.GetDataを移植 */
        public static (string name, string comment) GetData(ISiteMessage message)
        {
            string name = null;
            string comment = null;

            //if (message is YouTubeLiveSitePlugin.IYouTubeLiveMessage ytMessage)
            //{
            if (message is YouTubeLiveSitePlugin.IYouTubeLiveComment ytComment)
            {
                comment = ytComment.CommentItems.ToText();
                name = ytComment.NameItems.ToText();
            }
            else if (message is YouTubeLiveSitePlugin.IYouTubeLiveSuperchat superchat)
            {
                var s = superchat.PurchaseAmount;
                var text = superchat.CommentItems.ToText();
                if (!string.IsNullOrEmpty(text))
                {
                    s += text;
                }
                comment = s;
                name = superchat.NameItems.ToText();
            }
            //}
            //else if (message is NicoSitePlugin.INicoMessage nicoMessage)
            //{
            else if (message is NicoSitePlugin.INicoComment nicoComment)
            {
                comment = nicoComment.Text;
                name = nicoComment.UserName;
            }
            else if (message is NicoSitePlugin.INicoGift nicoItem)
            {
                comment = nicoItem.Text;
                //name = nicoItem.;
            }
            else if (message is NicoSitePlugin.INicoAd nicoAd)
            {
                comment = nicoAd.Text;
                //name = nicoItem.;
            }
            else if (message is NicoSitePlugin.INicoSpi nicoSpi)
            {
                comment = nicoSpi.Text;
                //name = nicoItem.;
            }
            else if (message is NicoSitePlugin.INicoEmotion nicoEmotion)
            {
                comment = nicoEmotion.Content;
                //name = nicoItem.;
            }
            //}
            //else if (message is TwitchSitePlugin.ITwitchMessage twMessage)
            //{
            else if (message is TwitchSitePlugin.ITwitchComment twComment)
            {
                comment = twComment.CommentItems.ToText();
                name = twComment.DisplayName;
            }
            //}
            //else if (message is TwicasSitePlugin.ITwicasMessage casMessage)
            //{
            else if (message is TwicasSitePlugin.ITwicasComment casComment)
            {
                comment = casComment.CommentItems.ToText();
                name = casComment.UserName;
            }
            else if (message is TwicasSitePlugin.ITwicasKiitos casKiitos)
            {
                comment = casKiitos.CommentItems.ToText();
                name = casKiitos.UserName;
            }
            else if (message is TwicasSitePlugin.ITwicasItem casItem)
            {
                comment = casItem.CommentItems.ToText();
                name = casItem.UserName;
            }
            //}
            //else if (message is WhowatchSitePlugin.IWhowatchMessage wwMessage)
            //{
            else if (message is WhowatchSitePlugin.IWhowatchComment wwComment)
            {
                comment = wwComment.Comment;
                name = wwComment.UserName;
            }
            else if (message is WhowatchSitePlugin.IWhowatchItem wwItem)
            {
                comment = wwItem.Comment;
                name = wwItem.UserName;
            }
            //}
            //else if (message is OpenrecSitePlugin.IOpenrecMessage opMessage)
            //{
            else if (message is OpenrecSitePlugin.IOpenrecComment opComment)
            {
                comment = opComment.MessageItems.ToText();
                name = opComment.NameItems.ToText();
            }
            //}
            //else if (message is MirrativSitePlugin.IMirrativMessage mrMessage)
            //{
            else if (message is MirrativSitePlugin.IMirrativComment mrComment)
            {
                comment = mrComment.Text;
                name = mrComment.UserName;
            }
            else if (message is MirrativSitePlugin.IMirrativJoinRoom mrJoin)
            {
                comment = mrJoin.Text;
                name = mrJoin.UserName;
            }
            //}
            //else if (message is LineLiveSitePlugin.ILineLiveMessage lineLiveMessage)
            //{
            else if (message is LineLiveSitePlugin.ILineLiveComment llComment)
            {
                comment = llComment.Text;
                name = llComment.DisplayName;
            }
            //}
            //else if (message is PeriscopeSitePlugin.IPeriscopeMessage psMessage)
            //{
            else if (message is PeriscopeSitePlugin.IPeriscopeComment psComment)
            {
                comment = psComment.Text;
                name = psComment.DisplayName;
            }
            else if (message is ShowRoomSitePlugin.IShowRoomComment srComment)
            {
                comment = srComment.Text;
                name = srComment.UserName;
            }
            //}
            //else if (message is MildomSitePlugin.IMildomMessage mildomMessage)
            //{
            else if (message is MildomSitePlugin.IMildomComment mildomComment)
            {
                comment = mildomComment.CommentItems.ToText();
                name = mildomComment.UserName;
            }
            //}
/*
            else if (message is BigoSitePlugin.IBigoComment bgComment)
            {
                comment = bgComment.Message;
                name = bgComment.Name;
            }
*/
            return (name, comment);
        }
    }
}
