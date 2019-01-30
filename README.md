# WordPress-Backup-Mini-Project-
## Scenario
This assignment involved programming a function, or series of function , to perform a specific task. The scenario was your new start up company provides a variety of Web Services to clients. One of these services is hosting the Word Press Website. <br>
WordPress is a free and open-source content management system (CMS) based on PHP and MySQL. Used by more than 60 million websites, including 30.6% of the top 10 million websites as of April 2018, WordPress is the most popular website management system in use.
WordPress keeps all the data in MySQL Databases.<br>
To manage the sites more efficiently, I needed to compile a list of clients on my server.And to make sure my client’s website is secure, I needed to change the admin password periodically.
## Implementation
1. I needed to populate enough information on my system. This was be done by installing asimple WordPress site and then making multiple copy of the files.<br>
I prepared list.sql file containing SQL statements that compiles a list including this information
* The website
* The email of the admin person
* User’s login
2. I also prepared and submited a changePass.sql file that changed the password for all admin users. 
## Restrictions
I <b>DIDN'T</b> know the name of database files on your server, so using Meta Data, I needed to first find
the names and then go through to a loop to process the above queries for all databases.<br>
I also needed to keep a log of what I have done with the time-stamp, including the list of sites
with the password before and after changing the admin pass. 
