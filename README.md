# goit-rdb-fp
Final Project Relational Data Bases

Final Project Description:

1. Load the data:

Create a pandemic schema in the database using SQL.
Select it as the default schema using SQL.
Import the data using the Import wizard as you did in topic 3.
Look at the data to get context.
💡 As you can see, the Entity and Code attributes are constantly repeating. Get rid of this by normalizing the data.

2. Normalize the infectious_cases table to 3rd normal form. Save the two tables with the normalized data in the same schema.

Run a SELECT COUNT(*) FROM infectious_cases query so that the mentor can understand how many records you loaded into the database from the file.

3. Analyze the data:

For each unique combination of Entity and Code or their id, calculate the average, minimum, maximum value and sum for the Number_rabies attribute.
💡 Note that the Number_rabies attribute may contain empty values ​​‘’ — you need to filter them out first.

Sort the result by the calculated average value in descending order.

Select only 10 rows to display on the screen.

4. Build a column of the difference in years.

For the original or normalized table, for the Year column, build using built-in SQL functions:

an attribute that creates the date of the first January of the corresponding year,
💡 For example, if the attribute contains the value ’1996’, then the value of the new attribute should be ‘1996-01-01’.
an attribute that is equal to the current date,
an attribute that is equal to the difference in years of the two columns mentioned above.
💡 You don’t need to list all the other attributes, such as Number_malaria.

👉🏼 You may need to refer to topic 7 to find the necessary built-in functions.

5. Build your own function.

Create and use a function that builds the same attribute as in the previous task: the function should take the year as input and return the difference in years between the current date and the date created from the year attribute (1996 → ‘1996-01-01’).
💡 If you haven’t completed the previous task, you can build another function — a function that counts the number of diseases for a certain period. To do this, you need to divide the number of diseases per year by a certain number: 12 — to get the average number of diseases per month, 4 — for a quarter, or 2 — for half a year. Thus, the function will take two parameters: the number of diseases per year and an arbitrary divisor. You should also use it — run it on the data. Since not all rows contain the number of diseases, you will need to filter out those that do not have a numerical value (≠ ‘’).

Final project acceptance criteria

Attached links to the goit-rdb-fp repository and directly the repository files themselves as an archive.
A schema has been created in the database. Data has been imported.
The table has been normalized.
SQL queries have been written in accordance with the specified execution conditions. The queries are executed and give the expected result, namely:
average, minimum, maximum value and sum for the Number_rabies attribute. The output is in accordance with the above-mentioned sorting and number of rows requirements;
a column of difference in years using built-in SQL functions;
a function for calculating the difference in years or the number of diseases for a certain period. The function returns the necessary data.
