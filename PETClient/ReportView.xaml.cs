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
        List<Person> authorlist = new List<Person>();
        List<Observed> observedlist = new List<Observed>();

        public ReportView(int id) {
            InitializeComponent();

            var list = ReportWrapper.GetReports(id);

            if (list.Count != 0) {
                lstReports.ItemsSource = list;
            }

            var agentlist = AgentWrapper.GetAllAgents();
            var informerlist = InformerWrapper.GetAllInformers();

            foreach (var i in agentlist) {
                authorlist.Add(new Person(i.Id, "", "", i.Name));
            }

            foreach (var i in informerlist) {
                authorlist.Add(new Person(i.Id, "", "", i.Name));
            }
            
            cmbAuthor.ItemsSource = authorlist;

            observedlist = ObservedWrapper.GetAllObserved();

            cmbObserved.ItemsSource = observedlist;
            
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
                cmbAuthor.SelectedIndex = authorlist.IndexOf(authorlist.Where(x => x.Id == report.Author_Id).First());

                // observed
                cmbObserved.SelectedIndex = observedlist.IndexOf(observedlist.Where(x => x.Id == report.Observed_Id).First());

                // content
                txtContent.Text = report.Content;

                // comment
                txtComment.Text = report.Comment;

            }
        }

        private void btnCreateReport_Click(object sender, RoutedEventArgs e) {
            lstReports.SelectedIndex = -1;

            txtId.Text = (-1).ToString();
            dtCreate.SelectedDate = DateTime.Now;
            dtChange.SelectedDate = DateTime.Now;
            txtPlace.Text = "";
            cmbAuthor.SelectedIndex = -1;
            txtContent.Text = "";
            txtComment.Text = "";

        }

        private void btnSaveReport_Click(object sender, RoutedEventArgs e) {

        }

    }
}
