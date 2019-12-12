namespace shocoroPrugin
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.userName = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.giftName = new System.Windows.Forms.Label();
            this.giftCnt = new System.Windows.Forms.Label();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.button1 = new System.Windows.Forms.Button();
            this.参照 = new System.Windows.Forms.OpenFileDialog();
            this.errorLabel = new System.Windows.Forms.Label();
            this.startButton = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // userName
            // 
            resources.ApplyResources(this.userName, "userName");
            this.userName.Name = "userName";
            // 
            // label2
            // 
            resources.ApplyResources(this.label2, "label2");
            this.label2.Name = "label2";
            // 
            // giftName
            // 
            resources.ApplyResources(this.giftName, "giftName");
            this.giftName.Name = "giftName";
            // 
            // giftCnt
            // 
            resources.ApplyResources(this.giftCnt, "giftCnt");
            this.giftCnt.Name = "giftCnt";
            // 
            // textBox1
            // 
            resources.ApplyResources(this.textBox1, "textBox1");
            this.textBox1.Name = "textBox1";
            // 
            // label1
            // 
            resources.ApplyResources(this.label1, "label1");
            this.label1.Name = "label1";
            // 
            // button1
            // 
            resources.ApplyResources(this.button1, "button1");
            this.button1.Name = "button1";
            this.button1.UseVisualStyleBackColor = true;
            // 
            // 参照
            // 
            this.参照.FileName = "openFileDialog1";
            // 
            // errorLabel
            // 
            resources.ApplyResources(this.errorLabel, "errorLabel");
            this.errorLabel.Name = "errorLabel";
            // 
            // startButton
            // 
            resources.ApplyResources(this.startButton, "startButton");
            this.startButton.Name = "startButton";
            this.startButton.UseVisualStyleBackColor = true;
            // 
            // Form1
            // 
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.startButton);
            this.Controls.Add(this.errorLabel);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.textBox1);
            this.Controls.Add(this.giftCnt);
            this.Controls.Add(this.giftName);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.userName);
            this.Name = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label userName;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label giftName;
        private System.Windows.Forms.Label giftCnt;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.OpenFileDialog 参照;
        private System.Windows.Forms.Label errorLabel;
        private System.Windows.Forms.Button startButton;
    }
}