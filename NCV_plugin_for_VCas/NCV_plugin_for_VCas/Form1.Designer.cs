namespace NCV_plugin_for_VCas
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
            this.mseesageLabel = new System.Windows.Forms.Label();
            this.startButton = new System.Windows.Forms.Button();
            this.checkBox1 = new System.Windows.Forms.CheckBox();
            this.label1 = new System.Windows.Forms.Label();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.button1 = new System.Windows.Forms.Button();
            this.参照 = new System.Windows.Forms.OpenFileDialog();
            this.SuspendLayout();
            // 
            // mseesageLabel
            // 
            this.mseesageLabel.AutoSize = true;
            this.mseesageLabel.Location = new System.Drawing.Point(12, 9);
            this.mseesageLabel.Name = "mseesageLabel";
            this.mseesageLabel.Size = new System.Drawing.Size(56, 12);
            this.mseesageLabel.TabIndex = 6;
            this.mseesageLabel.Text = "mseesage";
            // 
            // startButton
            // 
            this.startButton.Location = new System.Drawing.Point(73, 96);
            this.startButton.Name = "startButton";
            this.startButton.Size = new System.Drawing.Size(120, 64);
            this.startButton.TabIndex = 7;
            this.startButton.Text = "開始";
            this.startButton.UseVisualStyleBackColor = true;
            // 
            // checkBox1
            // 
            this.checkBox1.AutoSize = true;
            this.checkBox1.Location = new System.Drawing.Point(12, 204);
            this.checkBox1.Name = "checkBox1";
            this.checkBox1.Size = new System.Drawing.Size(154, 16);
            this.checkBox1.TabIndex = 10;
            this.checkBox1.Text = "運営コメントのみVCIに送信";
            this.checkBox1.UseVisualStyleBackColor = true;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(9, 223);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(157, 12);
            this.label1.TabIndex = 11;
            this.label1.Text = "ファイルの場所を選択してください";
            // 
            // textBox1
            // 
            this.textBox1.Location = new System.Drawing.Point(1, 238);
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(192, 19);
            this.textBox1.TabIndex = 12;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(235, 230);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(37, 27);
            this.button1.TabIndex = 13;
            this.button1.Text = "参照";
            this.button1.UseVisualStyleBackColor = true;
            // 
            // 参照
            // 
            this.参照.FileName = "openFileDialog1";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(284, 261);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.textBox1);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.checkBox1);
            this.Controls.Add(this.startButton);
            this.Controls.Add(this.mseesageLabel);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label mseesageLabel;
        private System.Windows.Forms.Button startButton;
        private System.Windows.Forms.CheckBox checkBox1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.OpenFileDialog 参照;
    }
}