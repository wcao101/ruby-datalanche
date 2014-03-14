# -*- coding: utf-8 -*-

class DLQuery(object):

    def initialize(self, database = None)
        @params = Hash.new
        if database != None
            @params['database'] = database
        end
    end

    #
    # COMMON
    #

    def self.cascade(boolean)
        @params['cascade'] = boolean
        return self # method chaining
    end

    def self.columns(columns)
        @params['columns'] = columns
        return self # method chaining
    end

    def self.description(text)
        @params['description'] = text
        return self # method chaining
    end

    def self.rename_to(table_name)
        @params['rename_to'] = table_name
        return self # method chaining
    end

    def self.where(expression)
        @params['where'] = expression
        return self # method chaining
    end

    #
    # EXPRESSIONS
    #

    #
    # usage examples
    #
    # q.expr(2, "+", 2)
    # q.expr("~", 2)
    # q.expr(2, "!")
    # q.expr(q.column("c1"), "$like", "%abc%")
    # q.expr(q.column("c1"), "$not", "$in", [1, 2, 3, 4])
    # q.expr(q.column("c1"), "=", 1, "$and", q.column("c2"), "=", 2)
    #
    def self.expr(*args)
        # *args is a built-in Python variable which is a tuple of function args
        return { '$expr'=>list(args) }
    end

    def self.alias(alias_name)
        return { '$alias'=>alias_name }
    end

    def self.column(column_name)
        return { '$column'=>column_name }
    end

    def self.literal(value)
        return { '$literal'=>value }
    end

    def self.table(table_name)
        return { '$table'=>table_name }
    end

    #
    # FUNCTIONS
    #

    # NOTE: *args is a built-in Python variable which is a tuple of function args

    #
    # usage examples
    #
    # q.func("$count", "*")
    # q.func("$sum", q.column("c1"))
    #
    def self.func(*args)
        return { '$function'=>list(args) }
    end

    def self.avg(*args)
        temp_args = [ '$avg' ] + list(args)
        return { '$function'=>temp_args }
    end

    def self.count(*args)
        temp_args = [ '$count' ] + list(args)
        return { '$function'=>temp_args }
    end

    def self.max(*args)
        temp_args = [ '$max' ] + list(args)
        return { '$function'=>temp_args }
    end

    def self.min(*args)
        temp_args = [ '$min' ] + list(args)
        return { '$function'=>temp_args }
    end

    def self.sum(*args)
        temp_args = [ '$sum' ] + list(args)
        return { '$function'=>temp_args }
    end

    #
    # ALTER DATABASE
    #

    def self.alter_database(database_name)
        @params['alter_database'] = database_name
        return self # method chaining
    end

    def self.add_collaborator(username, permission)
        if @params.has_key?('add_collaborators')
            @params['add_collaborators'] = Hase.new
        end

        @params['add_collaborators'][username] = permission
        return self # method chaining
    end

    def self.alter_collaborator(username, permission)
        if @params.has_key?('alter_collaborators')
            @params['alter_collaborators'] = Hash.new
        end

        @params['alter_collaborators'][username] = permission
        return self # method chaining
    end

    def self.drop_collaborator(username)
        if @params.has_key?('drop_collaborators')
            @params['drop_collaborators'] = Array.new
        end

        @params['drop_collaborators'].push(username)
        return self # method chaining
    end

    def self.is_private(boolean)
        @params['is_private'] = boolean
        return self # method chaining
    end

    def self.max_size_gb(integer)
        @params['max_size_gb'] = integer
        return self # method chaining
    end

    #
    # ALTER INDEX
    #

    def self.alter_index(index_name)
        @params['alter_index'] = index_name
        return self # method chaining
    end

    #
    # ALTER SCHEMA
    #

    def self.alter_schema(schema_name)
        @params['alter_schema'] = schema_name
        return self # method chaining
    end

    #
    # ALTER TABLE
    #

    def self.alter_table(table_name)
        @params['alter_table'] = table_name
        return self # method chaining
    end

    def self.add_column(column_name, attributes)
        if @params.has_key?('add_columns')
            @params['add_columns'] = Hash.new
        end

        @params['add_columns'][column_name] = attributes
        return self # method chaining
    end

    # TODO: add_constraint
    
    def self.alter_column(column_name, attributes)
        if @params.has_key?('alter_columns')
            @params['alter_columns'] = Hash.new
        end
        @params['alter_columns'][column_name] = attributes
        return self # method chaining
    end

    def self.drop_column(column_name, cascade = False)
        if @params.has_key?('drop_columns')
            @params['drop_columns'] = Array.new
        end

        column_obj = Hash.new
        column_obj['name'] = column_name
        column_obj['cascade'] = cascade
        self.params['drop_columns'].push(column_obj)
        return self # method chaining
    end

############################################################# will be finished on monday MAR 17th 2014 ###################
    # TODO: drop_constraint

    def rename_column(self, column_name, new_name):
        if 'rename_columns' not in self.params:
            self.params['rename_columns'] = collections.OrderedDict()
        self.params['rename_columns'][column_name] = new_name
        return self # method chaining

    # TODO: rename_constraint

    def set_schema(self, schema_name):
        self.params['set_schema'] = schema_name
        return self # method chaining

    #
    # CREATE INDEX
    #

    def create_index(self, index_name):
        self.params['create_index'] = index_name
        return self # method chaining

    def on_table(self, tableName):
        self.params['on_table'] = tableName
        return self # method chaining

    def unique(self, boolean):
        self.params['unique'] = boolean
        return self # method chaining

    def using_method(self, text):
        self.params['using_method'] = text
        return self # method chaining

    #
    # CREATE SCHEMA
    #

    def create_schema(self, schema_name):
        self.params['create_schema'] = schema_name
        return self # method chaining

    #
    # CREATE TABLE
    #

    def create_table(self, table_name):
        self.params['create_table'] = table_name
        return self # method chaining

    # TODO: constraints

    #
    # DELETE
    #

    def delete_from(self, table_name):
        self.params['delete_from'] = table_name
        return self # method chaining

    #
    # DESCRIBE DATABASE
    #

    def describe_database(self, database_name):
        self.params['describe_database'] = database_name
        return self # method chaining

    #
    # DESCRIBE SCHEMA
    #

    def describe_schema(self, schema_name):
        self.params['describe_schema'] = schema_name
        return self # method chaining

    #
    # DESCRIBE TABLE
    #

    def describe_table(self, table_name):
        self.params['describe_table'] = table_name
        return self # method chaining

    #
    # DROP INDEX
    #

    def drop_index(self, index_name):
        self.params['drop_index'] = index_name
        return self # method chaining

    #
    # DROP SCHEMA
    #

    def drop_schema(self, schema_name):
        self.params['drop_schema'] = schema_name
        return self # method chaining

    #
    # DROP TABLE
    #

    def drop_table(self, table_name):
        self.params['drop_table'] = table_name
        return self # method chaining

    #
    # INSERT
    #

    def insert_into(self, table_name):
        self.params['insert_into'] = table_name
        return self # method chaining

    def values(self, rows):
        self.params['values'] = rows
        return self # method chaining

    #
    # SELECT
    #

    def select(self, columns):
        if columns == '*':
            raise Exception('please use select_all() instead of select("*")')
        self.params['select'] = columns
        return self # method chaining

    def select_all(self):
        self.params['select'] = True
        return self # method chaining

    def distinct(self, boolean):
        self.params['distinct'] = boolean
        return self # method chaining

    def from_tables(self, tables):
        self.params['from'] = tables
        return self # method chaining

    def group_by(self, columns):
        self.params['group_by'] = columns
        return self # method chaining

    def having(self, expression):
        self.params['having'] = expression
        return self # method chaining

    def limit(self, integer):
        self.params['limit'] = integer
        return self # method chaining

    def offset(self, integer):
        self.params['offset'] = integer
        return self # method chaining

    def order_by(self, expr_array):
        self.params['order_by'] = expr_array
        return self # method chaining

    def search(self, query_text):
        self.params['search'] = query_text
        return self # method chaining

    #
    # SHOW DATABASES
    #

    def show_databases(self):
        self.params['show_databases'] = True
        return self # method chaining

    #
    # SHOW SCHEMAS
    #

    def show_schemas(self):
        self.params['show_schemas'] = True
        return self # method chaining

    #
    # SHOW TABLES
    #

    def show_tables(self):
        self.params['show_tables'] = True
        return self # method chaining

    #
    # UPDATE
    #

    def update(self, table_name):
        self.params['update'] = table_name
        return self # method chaining

    def set(self, kv_pairs):
        self.params['set'] = kv_pairs
        return self # method chaining        
