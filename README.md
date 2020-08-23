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



