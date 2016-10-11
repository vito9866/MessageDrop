using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace WpfApplication1
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }
        private void BtnSign_Click(object sender, RoutedEventArgs e)
        {
            this.GroupInput.Visibility=Visibility.Collapsed;
            this.backGFlamingo.Visibility = Visibility.Collapsed;
            this.Grid_2.Visibility = Visibility.Visible;
            this.Grid_1.Visibility = Visibility.Visible;
        }
    }
}
