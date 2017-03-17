# README

Installation instructions:

It needs to be installed in a server/desktop with Linux OS.

1. Downlad and unzip the code from https://github.com/Confiuzer/RealEstateTest

2. Open a terminal and get in the extracted folder directory. In my case "cd Descargas/RealEstateTest-master/"

3. It usues ruby version 2.3.3. I'm going to asume you are using RVM but if you dont just install the ruby version the way you know.
	- Install ruby version 2.3.3 "rvm install 2.3.3"
	- Create a gemset "rvm gemset create RealEstateTest"
	- Use the gemset for this project "rvm use ruby-2.3.3@RealEstateTest"

4. Next install rails version 5.0.0.1 "gem install rails -v 5.0.0.1"

5. Then you can run the bundle command "bundle"

6. The project uses sidekiq and redis to monitor the jobs on the background so we need to install it. We install it with the following commands.
	- Download the pacakge "wget http://download.redis.io/redis-stable.tar.gz"
	- Unzip it "tar xvzf redis-stable.tar.gz"
	- Get in the folder of the unziped file "cd redis-stable"
	- Compile it "make"
	- Install it "make install"
	- Check if everything is alright "make test"
	- The installation instructions are here: https://redis.io/topics/quickstart in case you run into any problems. 

7. Now we go back to our rails project folder and start the redis server with the following command "redis-server"

8. Next open up a new terminal, get inside the rails project directory and start the sidekiq server with "bundle exec sidekiq"

9. Leave those 2 terminals running and open another one to start the rails server. Again go inside the rails project directory and first run the database migrations with "rake db:migrate", then start the rails server "rails s"

10. The sidekiq server has a web interface, open your web browser and go to this url address: "http://localhost:3000/sidekiq"

11. Open up a new tab in your web browser and go to "http://localhost:3000" to see the application landing page.



You will notice the database has no information in it so lets do that manually and set up the job in the linux crontab.

1. Open another terminal, get inside the rails project folder and run the command "whenever --update-crontab". This will put the job in the crontab of the current user. You can check the crontab contents to see the changes with the command "crontab -l"

2. Now lets open the rails console and run the job once manually to get some information in the database. Inside the rails project directory run the command "rails c"

3. Then inside the rails console type the command "PropertyUpdatesJob.perform_later('Easy_Broker', 'http://www.stagingeb.com/feeds/d420256874ddb9b6ee5502b9d54e773d8316a695/trovit_MX.xml.gz')" This is just a method that accepts 2 arguments, the name of the company name that we are importing the properties from and the url of the xml.gz file.

After you start the job you can view the sidekiq web interface, click on Busy, then on Live Poll and you will see the job working, if there is any error you will see it there and even kill the process if you dont want it to retry the process.

Once the job is finished you will see the Processed number changes and then you can refresh the applications web page. The properties will be shown this time.



**** BUGS ****

There are a few known asthetic bugs in the application.

	- When a property has no image if you paginate through the properties listing the image mockup generated with holder.js wont render. It seems to be a turbolinks problem. It could be fixed implementing the download of the images and generate our own.
	- When clicking on details to show a property it should display its images in a carousel, its not working right at the moment. Might also be better to show it in the same page instead of redirecting.
	- Information shown in the details of a property needs formatting.
	- The Map link for each property is not implemented yet.
	- Search only searches by title.




**** TODO ****

- Download the images so its easier to work with them like resizing.
- Implement the Map link.
- Make the search able to search for different options other than title.
- Add filters and/or tags for properties.
- Add more tests.