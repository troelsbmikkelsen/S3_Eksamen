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
using Database.Entities;
using Database;
using System.IO;

namespace PETClient {
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window {
        public MainWindow() {
            InitializeComponent();
        }
        #region Informer

        private void btnGetAllInformers_Click(object sender, RoutedEventArgs e) {
            var list = InformerWrapper.GetAllInformers();

            if (list.Count != 0) {
                lstInformers.ItemsSource = list;
            }
        }

        private void lstInformers_SelectionChanged(object sender, SelectionChangedEventArgs e) {
           // Console.WriteLine(lstInformants.SelectedIndex);
            if (lstInformers.SelectedIndex != -1) {

                Informer inf = (Informer)lstInformers.SelectedItem;

                // id
                txtInformerId.Text = inf.Id.ToString();
                // name
                txtInformerName.Text = inf.Name;
                // nationality
                txtInformerNationality.Text = inf.Nationality;
                // cpr
                txtInformerCPR.Text = inf.CPR;
                // currency
                txtInformerCurrency.Text = inf.Currency;
                // paymenttype
                txtInformerPaymentType.Text = inf.PaymentType;
                // tags
                txtInformerTags.Text = inf.Tags;

                // Check for existence of appearance, and insert if it exists
                Appearance infapp = InfoWrapper.GetAppearance(inf.Id);
                if (infapp.Id != -1) {
                    txtInformerHeight.Text = infapp.Height.ToString();
                    txtInformerEyecolor.Text = infapp.Eyecolor;
                    txtInformerHaircolor.Text = infapp.Haircolor;
                }

                Address infadd = InfoWrapper.GetAddress(inf.Id);
                // Check for existence of address, and insert if it exists
                if (infadd.Id != -1) {
                    txtInformerStreet.Text = infadd.Street;
                    txtInformerAreacode.Text = infadd.AreaCode.ToString();
                }

                Database.Entities.Image infimg = InfoWrapper.GetImage(inf.Id);
                // Check for existence of image, and insert if it exists
                if (infimg.Id != -1) {
                    try {
                        MemoryStream ms = new MemoryStream(infimg.Data);

                        BitmapImage bimg = new BitmapImage();
                        bimg.BeginInit();
                        bimg.StreamSource = ms;
                        bimg.EndInit();

                        imgInformer.Source = bimg;
                    } catch (Exception ex) {
                        MessageBox.Show($"Billedformatet er ikke understøttet.\n\n{ex.Message}");
                    }
                    
                }

            }

        }

        private void btnCreateInformer_Click(object sender, RoutedEventArgs e) {
            lstInformers.SelectedIndex = -1;

            // id
            txtInformerId.Text = (-1).ToString();
            // name
            txtInformerName.Text = "";
            // nationality
            txtInformerNationality.Text = "";
            // cpr
            txtInformerCPR.Text = "";
            // currency
            txtInformerCurrency.Text = "";
            // paymenttype
            txtInformerPaymentType.Text = "";
            // tags
            txtInformerTags.Text = "";

            txtInformerHeight.Text = "";
            txtInformerEyecolor.Text = "";
            txtInformerHaircolor.Text = "";

            txtInformerStreet.Text = "";
            txtInformerAreacode.Text = "";

            imgInformer.Source = null;

            
        }

        private void btnSaveInformer_Click(object sender, RoutedEventArgs e) {
            try {
                Informer informer = new Informer();

                informer.Id = int.Parse(txtInformerId.Text);
                informer.Name = txtInformerName.Text;
                informer.Nationality = txtInformerNationality.Text;
                informer.CPR = txtInformerCPR.Text;
                informer.Currency = txtInformerCurrency.Text;
                informer.PaymentType = txtInformerPaymentType.Text;
                informer.Tags = txtInformerTags.Text;

                InformerWrapper.SaveInformer(informer);

                // Try to save appearance
                if (txtInformerHeight.Text != "" || txtInformerEyecolor.Text != "" || txtInformerHaircolor.Text != "") {
                    Appearance appearance;
                    if (informer.Id == -1) {
                        appearance = new Appearance(int.Parse(txtInformerHeight.Text), txtInformerEyecolor.Text, txtInformerHaircolor.Text, InfoWrapper.GetLastPersonId());
                    } else {
                        appearance = new Appearance(int.Parse(txtInformerHeight.Text), txtInformerEyecolor.Text, txtInformerHaircolor.Text, informer.Id);
                    }

                    InfoWrapper.SaveAppearence(appearance);
                }

                // Try to save address
                if (txtInformerStreet.Text != "" || txtInformerAreacode.Text != "") {
                    Address address;
                    // If it's a new informer
                    if (informer.Id == -1) {
                        address = new Address(txtInformerStreet.Text, int.Parse(txtInformerAreacode.Text), InfoWrapper.GetLastPersonId());
                    } else {
                        address = new Address(txtInformerStreet.Text, int.Parse(txtInformerAreacode.Text), informer.Id);
                    }

                    InfoWrapper.SaveAddress(address);
                }

                // Try to save image
                if (txtInformerImagePath.Text != "") {
                    if (File.Exists(txtInformerImagePath.Text)) {
                        FileStream fs = new FileStream(txtInformerImagePath.Text, FileMode.Open, FileAccess.Read);
                        BinaryReader br = new BinaryReader(fs);

                        Database.Entities.Image img;

                        // if new informer
                        if (informer.Id == -1) {
                            img = new Database.Entities.Image(br.ReadBytes(Convert.ToInt32(fs.Length)), InfoWrapper.GetLastPersonId());
                        } else {
                            img = new Database.Entities.Image(br.ReadBytes(Convert.ToInt32(fs.Length)), informer.Id);
                        }

                        InfoWrapper.SaveImage(img);
                    }
                }


            } catch (Exception ex) {
                MessageBox.Show($"Der er sket en fejl. Er alle felterne korrekt udfyldt?\n\n{ex.Message}");
            }
        }
        
        private void btnInformerChooseImage_Click(object sender, RoutedEventArgs e) {
            // Create the file dialog
            Microsoft.Win32.OpenFileDialog dlg = new Microsoft.Win32.OpenFileDialog();

            // Set dialog filter
            dlg.DefaultExt = ".png";
            //dlg.Filter = "All files (*.*)|*.*|JPG Files (*.jpg)|*.jpg|PNG Files (*.png)|*.png|JPEG Files (*.jpeg)|*.jpeg|GIF Files (*.gif)|*.bmp|BMP Files (*.bmp)|*.bmp";
            dlg.Filter = "All files (*.*)|*.*|Image Files|*.jpg;*.jpeg;*.png;*.bmp";

            // Show file dialog
            bool? result = dlg.ShowDialog();

            if (result == true) {
                // Set file path
                txtInformerImagePath.Text = dlg.FileName;
            }
        }

        private void btnDeleteInformer_Click(object sender, RoutedEventArgs e) {
            try {
                if (lstInformers.SelectedIndex != -1) {
                    PersonWrapper.DeletePerson(((Person)lstInformers.SelectedItem).Id);
                }
            } catch (Exception ex) {
                MessageBox.Show($"Personen kunne slettes.\n\n{ex.Message}");
            }
        }

        #endregion

        #region Observed

        private void btnGetAllObserved_Click(object sender, RoutedEventArgs e) {
            var list = ObservedWrapper.GetAllObserved();

            if (list.Count != 0) {
                lstObserved.ItemsSource = list;
            }
        }

        private void lstObserved_SelectionChanged(object sender, SelectionChangedEventArgs e) {
            if (lstObserved.SelectedIndex != -1) {

                Observed obs = (Observed)lstObserved.SelectedItem;

                // id
                txtObservedId.Text = obs.Id.ToString();
                // name
                txtObservedName.Text = obs.Name;
                // nationality
                txtObservedNationality.Text = obs.Nationality;
                // cpr
                txtObservedCPR.Text = obs.CPR;
                // tags
                txtObservedTags.Text = obs.Tags;

                // Check for existence of appearance, and insert if it exists
                Appearance obsapp = InfoWrapper.GetAppearance(obs.Id);
                if (obsapp.Id != -1) {
                    txtObservedHeight.Text = obsapp.Height.ToString();
                    txtObservedEyecolor.Text = obsapp.Eyecolor;
                    txtObservedHaircolor.Text = obsapp.Haircolor;
                }

                Address obsadd = InfoWrapper.GetAddress(obs.Id);
                // Check for existence of address, and insert if it exists
                if (obsadd.Id != -1) {
                    txtObservedStreet.Text = obsadd.Street;
                    txtObservedAreacode.Text = obsadd.AreaCode.ToString();
                }

                Database.Entities.Image obsimg = InfoWrapper.GetImage(obs.Id);
                // Check for existence of image, and insert if it exists
                if (obsimg.Id != -1) {
                    try {
                        MemoryStream ms = new MemoryStream(obsimg.Data);

                        BitmapImage bimg = new BitmapImage();
                        bimg.BeginInit();
                        bimg.StreamSource = ms;
                        bimg.EndInit();

                        imgObserved.Source = bimg;
                    } catch (Exception ex) {
                        MessageBox.Show($"Billedformatet er ikke understøttet.\n\n{ex.Message}");
                    }

                }

            }
        }

        private void btnCreateObserved_Click(object sender, RoutedEventArgs e) {
            // id
            txtObservedId.Text = (-1).ToString();
            // name
            txtObservedName.Text = "";
            // nationality
            txtObservedNationality.Text = "";
            // cpr
            txtObservedCPR.Text = "";
            // tags
            txtObservedTags.Text = "";

            txtObservedHeight.Text = "";
            txtObservedEyecolor.Text = "";
            txtObservedHaircolor.Text = "";

            txtObservedStreet.Text = "";
            txtObservedAreacode.Text = "";

            imgObserved.Source = null;
        }

        private void btnSaveObserved_Click(object sender, RoutedEventArgs e) {
            try {
                Observed observed = new Observed();

                observed.Id = int.Parse(txtObservedId.Text);
                observed.Name = txtObservedName.Text;
                observed.Nationality = txtObservedNationality.Text;
                observed.CPR = txtObservedCPR.Text;
                observed.Tags = txtObservedTags.Text;

                ObservedWrapper.SaveObserved(observed);

                // Try to save appearance
                if (txtObservedHeight.Text != "" || txtObservedEyecolor.Text != "" || txtObservedHaircolor.Text != "") {
                    Appearance appearance;
                    if (observed.Id == -1) {
                        appearance = new Appearance(int.Parse(txtObservedHeight.Text), txtObservedEyecolor.Text, txtObservedHaircolor.Text, InfoWrapper.GetLastPersonId());
                    } else {
                        appearance = new Appearance(int.Parse(txtObservedHeight.Text), txtObservedEyecolor.Text, txtObservedHaircolor.Text, observed.Id);
                    }

                    InfoWrapper.SaveAppearence(appearance);
                }

                // Try to save address
                if (txtObservedStreet.Text != "" || txtObservedAreacode.Text != "") {
                    Address address;
                    // Check if it's a new observed
                    if (observed.Id == -1) {
                        address = new Address(txtObservedStreet.Text, int.Parse(txtObservedAreacode.Text), InfoWrapper.GetLastPersonId());
                    } else {
                        address = new Address(txtObservedStreet.Text, int.Parse(txtObservedAreacode.Text), observed.Id);
                    }

                    InfoWrapper.SaveAddress(address);
                }

                // Try to save image
                if (txtObservedImagePath.Text != "") {
                    if (File.Exists(txtObservedImagePath.Text)) {
                        FileStream fs = new FileStream(txtObservedImagePath.Text, FileMode.Open, FileAccess.Read);
                        BinaryReader br = new BinaryReader(fs);

                        Database.Entities.Image img;

                        // if new observed
                        if (observed.Id == -1) {
                            img = new Database.Entities.Image(br.ReadBytes(Convert.ToInt32(fs.Length)), InfoWrapper.GetLastPersonId());
                        } else {
                            img = new Database.Entities.Image(br.ReadBytes(Convert.ToInt32(fs.Length)), observed.Id);
                        }

                        InfoWrapper.SaveImage(img);
                    }
                }


            } catch (Exception ex) {
                MessageBox.Show($"Der er sket en fejl. Er alle felterne korrekt udfyldt?\n\n{ex.Message}");
            }
        }

        private void btnDeleteObserved_Click(object sender, RoutedEventArgs e) {
            try {
                if (lstObserved.SelectedIndex != -1) {
                    PersonWrapper.DeletePerson(((Person)lstObserved.SelectedItem).Id);
                }
            } catch (Exception ex) {
                MessageBox.Show($"Personen kunne slettes.\n\n{ex.Message}");
            }
        }

        private void lstObserved_MouseDoubleClick(object sender, MouseButtonEventArgs e) {
            ReportView repview = new ReportView(((Observed)lstObserved.SelectedItem).Id);

            repview.ShowDialog();
        }

        #endregion

        #region Agent

        private void btnGetAllAgents_Click(object sender, RoutedEventArgs e) {
            var list = AgentWrapper.GetAllAgents();

            if (list.Count != 0) {
                lstAgents.ItemsSource = list;
            }
        }

        private void lstAgents_SelectionChanged(object sender, SelectionChangedEventArgs e) {
            if (lstAgents.SelectedIndex != -1) {

                Agent agent = (Agent)lstAgents.SelectedItem;

                // id
                txtAgentId.Text = agent.Id.ToString();
                // name
                txtAgentName.Text = agent.Name;
                // nationality
                txtAgentNationality.Text = agent.Nationality;
                // cpr
                txtAgentCPR.Text = agent.CPR;

                // Check for existence of appearance, and populate if it exists
                Appearance agentapp = InfoWrapper.GetAppearance(agent.Id);
                if (agentapp.Id != -1) {
                    txtAgentHeight.Text = agentapp.Height.ToString();
                    txtAgentEyecolor.Text = agentapp.Eyecolor;
                    txtAgentHaircolor.Text = agentapp.Haircolor;
                }

                Address agentadd = InfoWrapper.GetAddress(agent.Id);
                // Check for existence of address, and populate if it exists
                if (agentadd.Id != -1) {
                    txtAgentStreet.Text = agentadd.Street;
                    txtAgentAreacode.Text = agentadd.AreaCode.ToString();
                }

                Database.Entities.Image agentimg = InfoWrapper.GetImage(agent.Id);
                // Check for existence of image, and populate if it exists
                if (agentimg.Id != -1) {
                    try {
                        MemoryStream ms = new MemoryStream(agentimg.Data);

                        BitmapImage bimg = new BitmapImage();
                        bimg.BeginInit();
                        bimg.StreamSource = ms;
                        bimg.EndInit();

                        imgAgent.Source = bimg;
                    } catch (Exception ex) {
                        MessageBox.Show($"Billedformatet er ikke understøttet.\n\n{ex.Message}");
                    }

                }

            }
        }
        
        private void btnCreateAgent_Click(object sender, RoutedEventArgs e) {
            // id
            txtAgentId.Text = (-1).ToString();
            // name
            txtAgentName.Text = "";
            // nationality
            txtAgentNationality.Text = "";
            // cpr
            txtAgentCPR.Text = "";

            txtAgentHeight.Text = "";
            txtAgentEyecolor.Text = "";
            txtAgentHaircolor.Text = "";

            txtAgentStreet.Text = "";
            txtAgentAreacode.Text = "";

            imgAgent.Source = null;
        }

        private void btnSaveAgent_Click(object sender, RoutedEventArgs e) {
            try {
                Agent agent = new Agent();

                agent.Id = int.Parse(txtAgentId.Text);
                agent.Name = txtAgentName.Text;
                agent.Nationality = txtAgentNationality.Text;
                agent.CPR = txtAgentCPR.Text;

                AgentWrapper.SaveAgent(agent);

                // Try to save appearance
                if (txtAgentHeight.Text != "" || txtAgentEyecolor.Text != "" || txtAgentHaircolor.Text != "") {
                    Appearance appearance;
                    if (agent.Id == -1) {
                        appearance = new Appearance(int.Parse(txtAgentHeight.Text), txtAgentEyecolor.Text, txtAgentHaircolor.Text, InfoWrapper.GetLastPersonId());
                    } else {
                        appearance = new Appearance(int.Parse(txtAgentHeight.Text), txtAgentEyecolor.Text, txtAgentHaircolor.Text, agent.Id);
                    }

                    InfoWrapper.SaveAppearence(appearance);
                }

                // Try to save address
                if (txtAgentStreet.Text != "" || txtAgentAreacode.Text != "") {
                    Address address;
                    // Check if it's a new agent
                    if (agent.Id == -1) {
                        address = new Address(txtAgentStreet.Text, int.Parse(txtAgentAreacode.Text), InfoWrapper.GetLastPersonId());
                    } else {
                        address = new Address(txtAgentStreet.Text, int.Parse(txtAgentAreacode.Text), agent.Id);
                    }

                    InfoWrapper.SaveAddress(address);
                }

                // Try to save image
                if (txtAgentImagePath.Text != "") {
                    if (File.Exists(txtAgentImagePath.Text)) {
                        FileStream fs = new FileStream(txtAgentImagePath.Text, FileMode.Open, FileAccess.Read);
                        BinaryReader br = new BinaryReader(fs);

                        Database.Entities.Image img;

                        // if new agent
                        if (agent.Id == -1) {
                            img = new Database.Entities.Image(br.ReadBytes(Convert.ToInt32(fs.Length)), InfoWrapper.GetLastPersonId());
                        } else {
                            img = new Database.Entities.Image(br.ReadBytes(Convert.ToInt32(fs.Length)), agent.Id);
                        }

                        InfoWrapper.SaveImage(img);
                    }
                }


            } catch (Exception ex) {
                MessageBox.Show($"Der er sket en fejl. Er alle felterne korrekt udfyldt?\n\n{ex.Message}");
            }
        }

        private void btnDeleteAgent_Click(object sender, RoutedEventArgs e) {
            try {
                if (lstAgents.SelectedIndex != -1) {
                    PersonWrapper.DeletePerson(((Person)lstAgents.SelectedItem).Id);
                }
            } catch (Exception ex) {
                MessageBox.Show($"Personen kunne slettes.\n\n{ex.Message}");
            }
        }


        #endregion

        
    }
}
