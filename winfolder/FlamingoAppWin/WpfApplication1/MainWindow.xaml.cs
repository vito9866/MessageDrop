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
using System.Runtime.InteropServices;
using System.Windows.Interop;
using Newtonsoft.Json;
using FireSharp.Config;
using FireSharp.Interfaces;
using FireSharp.Extensions;
using FireSharp.EventStreaming;
using FireSharp.Response;
using FireSharp.Exceptions;






namespace WpfApplication1
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        static IFirebaseConfig config;
        static IFirebaseClient client;
        Dictionary<string, User> userList = new Dictionary<string, User>();
        class ChatMessage
        {
            public string fromUid { get; set; }
            public string text { get; set; }
            public string time { get; set; }
            public string toUid { get; set; }
        }
        class User
        {
            public string email { get; set; }
            public string profileImageUrl { get; set; }
            public string username { get; set; }
        }
        public MainWindow()
        {
            InitializeComponent();
            config = new FirebaseConfig
            {
                AuthSecret = "fFq8a45xQIunxO5KzRPZwXurNMgaB6EBEQILyUEn",
                BasePath = "https://flamingomessenger-80bf4.firebaseio.com"
            };
            client = new FireSharp.FirebaseClient(config);
            
        }
        private async void sendMessage(object sender, RoutedEventArgs e)
        {
                PushResponse response = await client.PushAsync("messages/", new ChatMessage
            {
                fromUid = "T4xfkkbeZ0fpnThJF4vMacNOw4E3",
                text = "",
                time = "",
                toUid = "3cekJ9P7t7YavLGzVByQcTz7el53"
            });
        }
        private async void BtnSign_Click(object sender, RoutedEventArgs e)
        {
            this.GroupInput.Visibility = Visibility.Collapsed;
            this.Grid_2.Visibility = Visibility.Visible;
            FirebaseResponse response2 = await client.GetAsync("users/");
            var obj = JsonConvert.DeserializeObject<Dictionary<string, User>>(response2.Body);
            lbUsers.ItemsSource = obj;
            if (tbcEmail.Visibility == Visibility.Visible )
            {
                client.CreateUser(tBEmail.Text, pbPassword.Password);
                PushResponse response = await client.PushAsync("users/", new User {email=tBEmail.Text,username=tbUsername.Text,profileImageUrl=""}); 
            }
        }
        private async void btnSomeUser_Click(object sender, RoutedEventArgs e)
        {
            string value="";
            string changedUserSecret;
            if ((sender as Button)!=null)
            {
                object obj= (sender as Button).Content;
                value=(obj as String);
            }
            foreach(KeyValuePair<string,User> element in userList)
            {
                if (element.Value.username==value)
                {
                    changedUserSecret = element.Key;
                }
            }
            FirebaseResponse messagesresp = await client.GetAsync("messages/");
            var messagesList = JsonConvert.DeserializeObject<Dictionary<string, ChatMessage>>(messagesresp.Body);
            lbMessages.ItemsSource = messagesList;
        }
        private void ButtonCloseClick(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
        private void MouseDownDrag(object sender, MouseButtonEventArgs e)
        {
            this.DragMove();
        }
        private void ExitClick(object sender, RoutedEventArgs e)
        {
            GroupInput.Visibility = Visibility.Visible;
            Grid_2.Visibility = Visibility.Collapsed;
            GridProfil.Visibility = Visibility.Collapsed;
        }
        private void EditProfilClick(object sender, RoutedEventArgs e)
        {
            GridStack1.Visibility = Visibility.Collapsed;
            GridStack2.Visibility = Visibility.Collapsed;
            GridProfil.Visibility = Visibility.Visible;
        }
        private void BackToMessengerClick(object sender, RoutedEventArgs e)
        {
            GridStack1.Visibility = Visibility.Visible;
            GridStack2.Visibility = Visibility.Visible;
            GridProfil.Visibility = Visibility.Collapsed;
        }
        private void NameChange(object sender, RoutedEventArgs e)
        {
            btnChangeName.Visibility = Visibility.Hidden;
            tbChangeName.Visibility = Visibility.Visible;
            btnAcceptChanges.Visibility = Visibility.Visible;
        }
        private void AcceptNameChanges(object sender, RoutedEventArgs e)
        {
            tbcName.Text = tbChangeName.Text;
            tbChangeName.Visibility = Visibility.Hidden;
            btnAcceptChanges.Visibility = Visibility.Hidden;
            btnChangeName.Visibility = Visibility.Visible;
        }

        private void btnAlready_Click(object sender, RoutedEventArgs e)
        {
            gridBegin.Visibility = Visibility.Collapsed;
            GroupInput.Visibility = Visibility.Visible;
            tbcEmail.Visibility = Visibility.Collapsed;
            tBEmail.Visibility = Visibility.Collapsed;
        }
        private void btnNewUser_Click(object sender, RoutedEventArgs e)
        {
            gridBegin.Visibility = Visibility.Collapsed;
            GroupInput.Visibility = Visibility.Visible;
            tbcEmail.SetValue(Grid.RowProperty, 2);
            tBEmail.SetValue(Grid.RowProperty, 2);
            BtnSign.SetValue(Grid.RowProperty,3);
            RadBut.SetValue(Grid.RowProperty, 4);
            tbcRem.SetValue(Grid.RowProperty,4);
        }
    }
}
