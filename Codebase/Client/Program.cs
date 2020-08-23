using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using ExampleClient.MunicipalityTaxesServiceReference;

namespace ExampleClient
{
    class Program
    {
        static void Main (string[] args)
        {
            var cf = new ChannelFactory<IMunicipalityTaxesService>("BasicHttpBinding_IMunicipalityTaxesService");
            var c = cf.CreateChannel();

            var response = c.InsertTaxScheduleDetails(new MunicipalityTaxDetails { MunicipalitySchedule = new MunicipalityTaxSchedule("Copenhegan", ScheduleFrequency.Yearly, new DateTime(2016, 01, 01)), TaxAmount = 0.2 });
            response = c.InsertTaxScheduleDetails(new MunicipalityTaxDetails { MunicipalitySchedule = new MunicipalityTaxSchedule("Copenhegan", ScheduleFrequency.Monthly, new DateTime(2016, 05, 01)), TaxAmount = 0.4 });
            response = c.InsertTaxScheduleDetails(new MunicipalityTaxDetails { MunicipalitySchedule = new MunicipalityTaxSchedule("Copenhegan", ScheduleFrequency.Daily, new DateTime(2016, 01, 01)), TaxAmount = 0.1 });
            response = c.InsertTaxScheduleDetails(new MunicipalityTaxDetails { MunicipalitySchedule = new MunicipalityTaxSchedule("Copenhegan", ScheduleFrequency.Daily, new DateTime(2016, 12, 25)), TaxAmount = 0.1 });

            Console.Write("Welcome to Tax Manager App for Municipality \n");
            Console.Write("Enter a MunicipalityName:  ");
            string MunicipalityName = Console.ReadLine();
            Console.Write("Enter Input date in below format of day, Month & Year \n");
            Console.Write("Enter a day: ");
            int day = int.Parse(Console.ReadLine());
            Console.Write("Enter a month: ");
            int month = int.Parse(Console.ReadLine());
            Console.Write("Enter a year: ");
            int year = int.Parse(Console.ReadLine());
            DateTime inputtedDate = new DateTime(year, month, day);
            Console.Write("Applicable tax for given input date is: ");
            Console.WriteLine(c.GetTax(MunicipalityName, inputtedDate));
            Console.WriteLine();
            Console.WriteLine("Press any key to continue...");
            Console.ReadKey();
        }
    }
}
