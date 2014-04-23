# -*- coding: utf-8 -*-

class DLQuery

    # return params
    attr_reader :params
    
    # initialize parameters
    def initialize(database = nil)
        @params = Hash.new
        if database != nil
            @params['database'] = database
        end
    end
    
    #
    # COMMON
    #
    
    def cascade(boolean)
        @params['cascade'] = boolean
        return self # method chaining
    end
    
    def columns(columns)
        @params['columns'] = columns
        return self # method chaining
    end
    
    def description(text)
        @params['description'] = text
        return self # method chaining
    end
    
    def rename_to(table_name)
        @params['rename_to'] = table_name
        return self # method chaining
    end
    
    def where(expression)
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
    def expr(*args)
        # *args is a built-in Ruby variable which is a tuple of function args
        return { '$expr'=> args }
    end
    
    def alias(alias_name)
        return { '$alias'=>alias_name }
    end
    
    def column(column_name)
        return { '$column'=>column_name }
    end
    
    def literal(value)
        return { '$literal'=>value }
    end
    
    def table(table_name)
        return { '$table'=>table_name }
    end
    
    #
    # FUNCTIONS
    #
    
    # NOTE: *args is a built-in Ruby variable which is a tuple of function args
    
    #
    # usage examples
    #
    # q.count("*")
    # q.sum(q.column("c1"))
    #
    def avg(*args)
        return { '$avg'=>args }
    end
    
    def count(*args)
        return { '$count'=>args }
    end
    
    def max(*args)
        return { '$max'=>args }
    end
    
    def min(*args)
        return { '$min'=>args }
    end
    
    def sum(*args)
        return { '$sum'=>args }
    end
    
    #
    # ALTER DATABASE
    #
    
    def alter_database(database_name)
        @params['alter_database'] = database_name
        return self # method chaining
    end
    
    def add_collaborator(username, permission)
        if @params.has_key?('add_collaborators')
            @params['add_collaborators'] = Hase.new
        end
        
        @params['add_collaborators'][username] = permission
        return self # method chaining
    end
    
    def alter_collaborator(username, permission)
        if @params.has_key?('alter_collaborators')
            @params['alter_collaborators'] = Hash.new
        end
        
        @params['alter_collaborators'][username] = permission
        return self # method chaining
    end
    
    def drop_collaborator(username)
        if @params.has_key?('drop_collaborators')
            @params['drop_collaborators'] = Array.new
        end
        
        @params['drop_collaborators'].push(username)
        return self # method chaining
    end
    
    def is_private(boolean)
        @params['is_private'] = boolean
        return self # method chaining
    end

    def max_size_gb(integer)
        @params['max_size_gb'] = integer
        return self # method chaining
    end
    
    #
    # ALTER INDEX
    #
    
    def alter_index(index_name)
        @params['alter_index'] = index_name
        return self # method chaining
    end
    
    #
    # ALTER SCHEMA
    #
    
    def alter_schema(schema_name)
        @params['alter_schema'] = schema_name
        return self # method chaining
    end
    
    #
    # ALTER TABLE
    #
    
    def alter_table(table_name)
        @params['alter_table'] = table_name
        return self # method chaining
    end
    
    def add_column(column_name, attributes)
        if !(@params.has_key?('add_columns'))
            @params['add_columns'] = Hash.new
        end
        
        @params['add_columns'][column_name] = attributes
        return self # method chaining
    end
    
    # TODO: add_constraint
    
    def alter_column(column_name, attributes)
        if !(@params.has_key?('alter_columns'))
            @params['alter_columns'] = Hash.new
        end

        @params['alter_columns'][column_name] = attributes
        return self # method chaining
    end
    
    def drop_column(column_name, cascade = false)
        if !(@params.has_key?('drop_columns'))
            @params['drop_columns'] = Array.new
        end
        
        column_obj = Hash.new
        column_obj['name'] = column_name
        column_obj['cascade'] = cascade
        self.params['drop_columns'].push(column_obj)
        return self # method chaining
    end
    
    # TODO: drop_constraint

    def rename_column(column_name, new_name)
        if !(@params.has_key?('rename_columns'))
            @params['rename_columns'] = Hash.new
        end
        
        @params['rename_columns'][column_name] = new_name
        return self # method chaining
    end
    
    # TODO: rename_constraint
    
    def set_schema(schema_name)
        @params['set_schema'] = schema_name
        return self # method chaining
    end
    
    #
    # CREATE INDEX
    #
    
    def create_index(index_name)
        @params['create_index'] = index_name
        return self # method chaining
    end
    
    def on_table(tableName)
        @params['on_table'] = tableName
        return self # method chaining
    end

    def unique(boolean)
        @params['unique'] = boolean
        return self # method chaining
    end
    
    def using_method(text)
        @params['using_method'] = text
        return self # method chaining
    end
    
    #
    # CREATE SCHEMA
    #
    
    def create_schema(schema_name)
        @params['create_schema'] = schema_name
        return self # method chaining
    end
    
    #
    # CREATE TABLE
    #
    
    def create_table(table_name)
        @params['create_table'] = table_name
        return self # method chaining
    end
    
    
    # TODO: constraints
    
    #
    # DELETE
    #
    
    def delete_from(table_name)
        @params['delete_from'] = table_name
        return self # method chaining
    end
    
    #
    # DESCRIBE DATABASE
    #
    
    def describe_database(database_name)
        @params['describe_database'] = database_name
        return self # method chaining
    end
    
    #
    # DESCRIBE SCHEMA
    #
    
    def describe_schema(schema_name)
        @params['describe_schema'] = schema_name
        return self # method chaining
    end

    #
    # DESCRIBE TABLE
    #
    
    def describe_table(table_name)
        @params['describe_table'] = table_name
        return self # method chaining
    end
    
    #
    # DROP INDEX
    #
    
    def drop_index(index_name)
        @params['drop_index'] = index_name
        return self # method chaining
    end

    #
    # DROP SCHEMA
    #
    
    def drop_schema(schema_name)
        @params['drop_schema'] = schema_name
        return self # method chaining
    end

    #
    # DROP TABLE
    #
    
    def drop_table(table_name)
        @params['drop_table'] = table_name
        return self # method chaining
    end
    
    #
    # INSERT
    #
    
    def insert_into(table_name)
        @params['insert_into'] = table_name
        return self # method chaining
    end
    
    def values(rows)
        @params['values'] = rows
        return self # method chaining
    end
    
    #
    # SELECT
    #
    
    def select(columns)
        if columns == '*'
            raise Exception('please use select_all() instead of select("*")')
        end
        
        @params['select'] = columns
        return self # method chaining
    end
    
    def select_all()
        @params['select'] = true
        return self # method chaining
    end
    
    def distinct(boolean)
        @params['distinct'] = boolean
        return self # method chaining
    end
    
    def from(tables)
        @params['from'] = tables
        return self # method chaining
    end
    
    def group_by(columns)
        @params['group_by'] = columns
        return self # method chaining
    end
    
    def having(expression)
        @params['having'] = expression
        return self # method chaining
    end
    
    def limit(integer)
        @params['limit'] = integer
        return self # method chaining
    end
    
    def offset(integer)
        @params['offset'] = integer
        return self # method chaining
    end
    
    def order_by(expr_array)
        @params['order_by'] = expr_array
        return self # method chaining
    end
    
    def search(query_text)
        @params['search'] = query_text
        return self # method chaining
    end

    #
    # SHOW DATABASES
    #
    
    def show_databases()
        @params['show_databases'] = true
        return self # method chaining
    end
    
    #
    # SHOW SCHEMAS
    #
    
    def show_schemas()
        @params['show_schemas'] = true
        return self # method chaining
    end

    #
    # SHOW TABLES
    #
    
    def show_tables()
        @params['show_tables'] = true
        return self # method chaining
    end
    
    #
    # UPDATE
    #
    
    def update(table_name)
        @params['update'] = table_name
        return self # method chaining
    end
    
    def set(kv_pairs)
        @params['set'] = kv_pairs
        return self # method chaining
    end
end
