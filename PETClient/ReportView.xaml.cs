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
using System.Windows.Shapes;
using Database;
using Database.Entities;

namespace PETClient {
    /// <summary>
    /// Interaction logic for ReportView.xaml
    /// </summary>
    public partial class ReportView : Window {
        public ReportView(int id) {
            InitializeComponent();

            var list = ReportWrapper.GetReports(id);

            if (list.Count != 0) {
                lstReports.ItemsSource = list;
            }

            var agentlist = AgentWrapper.GetAllAgents().Select(x => x.GetPerson());
            var informerlist = InformerWrapper.GetAllInformers().Select(x => x.GetPerson());
            cmbAuthor.ItemsSource = agentlist.Concat(informerlist);
            
        }

        private void lstReports_SelectionChanged(object sender, SelectionChangedEventArgs e) {
            if (lstReports.SelectedIndex != -1) {
                Report report = ((Report)lstReports.SelectedItem);

                // id
                txtId.Text = report.Id.ToString();

                // create date
                dtCreate.SelectedDate = report.Create_Date;

                // change date
                dtChange.SelectedDate = report.Change_Date;

                // place
                txtPlace.Text = report.Place;

                // author

                // observed

                // content

                // comment

            }
        }

        private void btnCreateReport_Click(object sender, RoutedEventArgs e) {

        }

        private void btnSaveReport_Click(object sender, RoutedEventArgs e) {

        }

    }
}
