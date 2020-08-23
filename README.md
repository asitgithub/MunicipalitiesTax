# Municipalities Tax Scheduling and Displaying Application

This application calculates and provide taxes for different Municipalities for selected Date. This has capability of schedulinging of new taxes for any municipality.

Requirement Statement -

Expectation is to create a small application which manages taxes applied in different municipalities. The taxes are scheduled in time. Application should provide the user an ability to get taxes applied in certain municipality at the given day.
Example: Municipality Copenhagen has its taxes scheduled like this :
- yearly tax = 0.2 (for period 2016.01.01-2016.12.31),
- monthly tax = 0.4 (for period 2016.05.01-2016.05.31),
- it has no weekly taxes scheduled,
- and it has two daily taxes scheduled = 0.1 (at days 2016.01.01 and 2016.12.25).
 The result according to provided example would be:
Municipality (Input)	Date (Input)	Result
Copenhagen	2016.01.01	0.1
Copenhagen	2016.05.02	0.4
Copenhagen	2016.07.10	0.2
Copenhagen	2016.03.16	0.2

Full requirements for the application (choose the priority of tasks in the way that when the time ends up you would have working application, not necessarily with all functionality):
•	It has its own database where municipality taxes are stored
•	Taxes should have ability to be scheduled (yearly, monthly ,weekly ,daily) for each municipality
•	Application should have ability to import municipalities data from file (choose one data format you believe is suitable)
•	Application should have ability to insert new records for municipality taxes (one record at a time)
•	User can ask for a specific municipality tax by entering municipality name and date
•	Errors needs to be handled i.e. internal errors should not to be exposed to the end user
•	You should ensure that application works correctly
Application has no visible user interface; requests are given directly to application as a service (producer service). Also, there should be a consumer service created to demonstrate how the producer service can be used.
Bonus tasks (if there is time left)
•	Application is  deployed as a self-hosted windows service
•	Update record functionality is exposed via API

Below are few of my Assumptions  -

1. a Yearly schedule to start not on the first day of January
2. a Monthly schedule to start not on the 1st of the month
3. a Weekly schedule to start not on a Monday

I since realised that maybe that's a constraint that I assumed, as it is not specifically mentioned in the specification, so I decided to add another Tax Validation class that would remove this restriction, and enable it to be configured in the config file.

The relevant configuration setting is in the AppSettings section, with key ITaxScheduleValidator, and currently 2 possible values:

MunicipalityTaxes.PermissiveDateTaxScheduleValidator for a less restrictive schedule date validator

MunicipalityTaxes.TaxScheduleValidator for a more restrictive schedule date validator

Also, the task mentioned that the solution should have it's own database - for simplicity I chose to interpret this loosely, and am using an "in memory database" which could easily be swapped out for another ITaxStorageProvider if one was implemented, again using AppSettings and you guessed it, the key ITaxStorageProvider.

# Windows Service

Instructions on how to install a Windows Service: https://msdn.microsoft.com/en-us/library/zt39148a(v=vs.110).aspx#BK_Install The startup type for this MunicipalityTaxes Windows Service is set to Manual by default, so you'll need to start it manually after installing. :)

The URL for the service is set in the config, and is currently http://localhost:8733/Design_Time_Addresses/MunicipalityTaxes/Service1/mex, as defined at https://github.com/keith-hall/Showcase_CSharp_MunicipalityTaxSchedule/blob/4cda15a87b536a346af33f62e035f646b7bc03ae/MunicipalityTaxes/MunicipalityTaxes/App.config#L25.

If you get an System.ServiceModel.AddressAccessDeniedException when you try to host the WCF service, like:

Please try changing the HTTP port to 8733 or running as Administrator.

# Bulk Import

The bulk import method expects a text file in the following format:

Vilnius|Yearly|2016-01-01|0.2
Vilnius|Monthly|2016-05-01|0.4
Vilnius|Daily|2016-01-01|0.1
Vilnius|Daily|2016-12-25|0.1
i.e. for each tax schedule:

Muncipality

followed by a pipe character
followed by the frequency - either "Yearly", "Monthly", "Weekly" or "Daily"
followed by a pipe character
followed by a date that .NET can parse unambiguously
followed by a pipe character
followed by the tax amount (a double that .NET can parse)
followed by a new line character (CRLF in Windows world)

Of course, in keeping with the requirements, any internal errors like the specifics of parse failures etc. are not shown to the user, but are logged for the service administrators to peruse.

I have used In Memory Database for my solution.



