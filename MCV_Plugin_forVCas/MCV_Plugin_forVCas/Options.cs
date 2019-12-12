using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using GalaSoft.MvvmLight;

namespace MCV_Plugin_forVCas_Plugin
{
    [DataContract]
    public class Options
    {
        [DataMember]
        private bool _isStarted = false;
        public virtual bool isStarted
        {
            get { return _isStarted; }
            set
            {
                _isStarted = value;
                RaisePropertyChanged();
            }
        }
        [DataMember]
        private string _buttonName = "開始";
        public virtual string buttonName
        {
            get { return _buttonName; }
            set
            {
                _buttonName = value;
                RaisePropertyChanged();
            }
        }
        [DataMember]
        private string _luaFile = "";
        public virtual string luaFile
        {
            get { return _luaFile; }
            set
            {
                _luaFile = value;
                RaisePropertyChanged();
            }
        }
        [DataMember]
        private string[] _commentList = new string[5] { @"Comment1", @"Comment2", @"Comment3", @"Comment4", @"Comment5" };
        public string commentList0
        {
            get { return _commentList[0]; }
            set {
                _commentList[0] = value;
                RaisePropertyChanged();
            }
        }
        public string commentList1
        {
            get { return _commentList[1]; }
            set {
                _commentList[1] = value;
                RaisePropertyChanged();
            }
        }
        public string commentList2
        {
            get { return _commentList[2]; }
            set {
                _commentList[2] = value;
                RaisePropertyChanged();
            }
        }
        public string commentList3
        {
            get { return _commentList[3]; }
            set {
                _commentList[3] = value;
                RaisePropertyChanged();
            }
        }
        public string commentList4
        {
            get { return _commentList[4]; }
            set {
                _commentList[4] = value;
                RaisePropertyChanged();
            }
        }

        public static Options Load()
        {
            Options options = new Options();
            return options;
        }

        #region INotifyPropertyChanged
        [NonSerialized]
        private System.ComponentModel.PropertyChangedEventHandler _propertyChanged;
        /// <summary>
        /// 
        /// </summary>
        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged
        {
            add { _propertyChanged += value; }
            remove { _propertyChanged -= value; }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="propertyName"></param>
        protected void RaisePropertyChanged([System.Runtime.CompilerServices.CallerMemberName] string propertyName = "")
        {
            _propertyChanged?.Invoke(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
        }
        #endregion
    }

}
