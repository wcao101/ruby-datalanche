API_CREDENTIALS = l3xrfLfHQfGGZa3UPG46KQ==:6lqNom5jQFa8f43/FcD5xw==
DB_QUERY_URL = https://localhost:4001/my_database/query 
QUERY_URL = https://localhost:4001/query 
CURL_OPTS_DROP_SCHEMA = -X -k POST -u "$(API_CREDENTIALS)" -H "Content-Type: application/json" -d '{ "drop_schema": "my_new_schema", "cascade": true }'
CURL_OPTS_ALTER_DATABASE = -X -k POST -u "$(API_CREDENTIALS)" -H "Content-Type: application/json" -d '{ "alter_database": "my_new_database", "rename_to": "my_database"}'

#host api.datalanche.com
all: target

target:  test

test: pre_test test_schema test_table test_selects test_index test_alter_schema test_database # run examples test
	
test_schema: pre_test
	# schema examples
	# create a schema
	ruby ./examples/schema/create_schema.rb

	# describe the schema
	ruby ./examples/schema/describe_schema.rb

	# show the created schema
	ruby ./examples/schema/show_schemas.rb

test_table: test_schema
	# table examples
	# create a table
	ruby ./examples/table/create_table.rb

	# describe the table
	ruby ./examples/table/describe_table.rb

	# show the tables in my_database, should return 2 tables
	ruby ./examples/table/show_tables.rb

	# insert data into my_schema.my_table
	ruby ./examples/table/insert.rb

	# update my_schema.my_table
	ruby ./examples/table/update.rb

	# delete my_schema.my_table
	ruby ./examples/table/delete.rb

	# alther the table name and the table descriptions
	ruby ./examples/table/alter_table.rb

	# create table again after altering table.
	ruby ./examples/table/create_table.rb

	# show table to make sure the new table is created before drop
	ruby ./examples/table/show_tables.rb

	# drop my_schema.my_table
	ruby ./examples/table/drop_table.rb

	# show table to make sure the new table is created before drop
	ruby ./examples/table/show_tables.rb

test_selects: test_schema
	# create sample tables for selects
	sh ./test/create_sample_tables

	# testing select example
	ruby ./examples/table/select_all.rb

	# testing select_search example
	ruby ./examples/table/select_search.rb

	# testing select_join example
	ruby ./examples/table/select_join.rb

test_index: test_selects
	# create index on my_schema.my_table
	ruby ./examples/index/create_index.rb

	# show the tables with index
	ruby ./examples/table/describe_table.rb

	# drop index on my_schema.my_table
	ruby ./examples/index/drop_index.rb

	# show the tables with dropped index
	ruby ./examples/table/describe_table.rb

	# create index on my_schema.my_table again for testing alterring index
	ruby ./examples/index/create_index.rb

	# show the tables with index
	ruby ./examples/table/describe_table.rb

	# alter index on my_schema.my_table
	ruby ./examples/index/alter_index.rb

	# show the tables with alterred index
	ruby ./examples/table/describe_table.rb

test_alter_schema: test_schema
	#echo drop the schema: my_new_schema before testing alter_schema example
	curl $(DB_QUERY_URL) $(CURL_OPTS_DROP_SCHEMA)

	# alter my_schema to my_new_schema
	ruby ./examples/schema/alter_schema.rb

	# show schema which should show my_new_schema
	ruby ./examples/schema/show_schemas.rb

	#create the schema again to test drop schema.
	ruby ./examples/schema/create_schema.rb

	# show schema which should show my_schema and my_new_schema
	ruby ./examples/schema/show_schemas.rb

	# drop my_schema
	ruby ./examples/schema/drop_schema.rb

	# show schema which should show new_schema only
	ruby ./examples/schema/show_schemas.rb

test_database:
	# database examples
	# describe the database
	ruby ./examples/database/describe_database.rb

	# show the database
	ruby ./examples/database/show_databases.rb

	# alther the database
	ruby ./examples/database/alter_database.rb

	# show the database after altered
	ruby ./examples/database/show_databases.rb

	# alter the my_new_database to my_database
	curl $(QUERY_URL) $(CURL_OPTS_ALTER_DATABASE)

	# show the database to check if the database is altered back to my_database
	ruby ./examples/database/show_databases.rb

pre_test: # setup the production server
	sh ./test/pre

.PHONY: test test_schema test_tables test_database test_
