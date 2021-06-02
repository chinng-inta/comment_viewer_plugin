using GalaSoft.MvvmLight;
using GalaSoft.MvvmLight.CommandWpf;
using System.ComponentModel;
using System.Windows.Forms;
using System.Windows.Input;

namespace MCV_Plugin_forVCas_Plugin.ViewModel
{
    /// <summary>
    /// This class contains properties that the main View can data bind to.
    /// <para>
    /// Use the <strong>mvvminpc</strong> snippet to add bindable properties to this ViewModel.
    /// </para>
    /// <para>
    /// You can also use Blend to data bind with the tool's support.
    /// </para>
    /// <para>
    /// See http://www.galasoft.ch/mvvm
    /// </para>
    /// </summary>
    public class MainViewModel : ViewModelBase
    {
        private readonly Options _options;


        public virtual bool isStarted
        {
            get { return _options.isStarted; }
            set
            {
                _options.isStarted = value;
            }
        }

        public virtual string buttonName
        {
            get { return _options.buttonName; }
            set
            {
                _options.buttonName = value;
            }
        }

        public virtual string luaFile
        {
            get { return _options.luaFile; }
            set
            {
                _options.luaFile = value;
            }
        }

        public virtual bool _check
        {
            get { return _options.isAbbreviation; }
            set
            {
                _options.isAbbreviation = value;
            }
        }
        

        public string commentList0
        {
            get { return _options.commentList0; }
            set { _options.commentList0 = value; }
        }
        public string commentList1
        {
            get { return _options.commentList1; }
            set { _options.commentList1 = value; }
        }
        public string commentList2
        {
            get { return _options.commentList2; }
            set { _options.commentList2 = value; }
        }
        public string commentList3
        {
            get { return _options.commentList3; }
            set { _options.commentList3 = value; }
        }
        public string commentList4
        {
            get { return _options.commentList4; }
            set { _options.commentList4 = value; }
        }

        public ICommand startButtonOnPushCommand { get; }
        public void startButtonOnPush()
        {
            if(this.isStarted == true)
            {
                this.isStarted = false;
                this.buttonName = "開始";
            } else
            {
                if (string.IsNullOrEmpty(_options.luaFile) == true)
                {
                    MessageBox.Show("main.luaを指定してください");
                    return;
                }
                this.isStarted = true;
                this.buttonName = "停止";
            }
        }

        public ICommand refButtonOnPushCommand { get; }
        public void refButtonOnPush()
        {
            var fileDialog = new System.Windows.Forms.OpenFileDialog
            {
                Title = "luaファイルを選択してください",
                Filter = "luaファイル | main.lua"
            };
            var result = fileDialog.ShowDialog();
            if (result == System.Windows.Forms.DialogResult.OK)
            {
                MessageBox.Show("ファイルパス：" + fileDialog.FileName +
                                "\r\n" +
                                "ファイル名　：" + fileDialog.SafeFileName);
                _options.luaFile = fileDialog.FileName;
            }
        }

        public ICommand refRadioButtonOnPushCommand { get; }
        public void refRadioButtonOnPush()
        {
                _options.isAbbreviation = _check;
        }

        /// <summary>
        /// Initializes a new instance of the MainViewModel class.
        /// </summary>
        public MainViewModel()
        {
            ////if (IsInDesignMode)
            ////{
            ////    // Code runs in Blend --> create design time data.
            ////}
            ////else
            ////{
            ////    // Code runs "for real"
            ////}
            _options = Options.Load();
            startButtonOnPushCommand = new RelayCommand(startButtonOnPush);
            refButtonOnPushCommand = new RelayCommand(refButtonOnPush);
            refRadioButtonOnPushCommand = new RelayCommand(refRadioButtonOnPush);
        }
        [GalaSoft.MvvmLight.Ioc.PreferredConstructor]
        public MainViewModel(Options options)
        {
            _options = options;
            _options.PropertyChanged += (s, e) =>
            {
                switch (e.PropertyName)
                {
                    case nameof(_options.isStarted):
                        RaisePropertyChanged(nameof(isStarted));
                        break;
                    case nameof(_options.buttonName):
                        RaisePropertyChanged(nameof(buttonName));
                        break;
                    case nameof(_options.luaFile):
                        RaisePropertyChanged(nameof(luaFile));
                        break;
                    case nameof(_options.commentList0):
                        RaisePropertyChanged(nameof(commentList0));
                        break;
                    case nameof(_options.commentList1):
                        RaisePropertyChanged(nameof(commentList1));
                        break;
                    case nameof(_options.commentList2):
                        RaisePropertyChanged(nameof(commentList2));
                        break;
                    case nameof(_options.commentList3):
                        RaisePropertyChanged(nameof(commentList3));
                        break;
                    case nameof(_options.commentList4):
                        RaisePropertyChanged(nameof(commentList4));
                        break;
                }
            };
            startButtonOnPushCommand = new RelayCommand(startButtonOnPush);
            refButtonOnPushCommand = new RelayCommand(refButtonOnPush);
            refRadioButtonOnPushCommand = new RelayCommand(refRadioButtonOnPush);
        }

    }
}