# -*- coding: utf-8 -*-

class DLQuery

    def initialize(database = nil)
        @params = Hash.new
        if database != nil
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

    def self.drop_column(column_name, cascade = false)
        if @params.has_key?('drop_columns')
            @params['drop_columns'] = Array.new
        end

        column_obj = Hash.new
        column_obj['name'] = column_name
        column_obj['cascade'] = cascade
        self.params['drop_columns'].push(column_obj)
        return self # method chaining
    end

    # TODO: drop_constraint

    def self.rename_column(column_name, new_name)
        if @params.has_key?('rename_columns')
            @params['rename_columns'] = Hash.new
        end

        @params['rename_columns'][column_name] = new_name
        return self # method chaining
    end

    # TODO: rename_constraint

    def self.set_schema(schema_name)
        @params['set_schema'] = schema_name
        return self # method chaining
    end

    #
    # CREATE INDEX
    #

    def self.create_index(index_name)
        @params['create_index'] = index_name
        return self # method chaining
    end

    def self.on_table(tableName)
        @params['on_table'] = tableName
        return self # method chaining
    end

    def self.unique(boolean)
        @params['unique'] = boolean
        return self # method chaining
    end

    def self.using_method(text)
        @params['using_method'] = text
        return self # method chaining
    end

    #
    # CREATE SCHEMA
    #

    def self.create_schema(schema_name)
        @params['create_schema'] = schema_name
        return self # method chaining
    end

    #
    # CREATE TABLE
    #

    def self.create_table(table_name)
        @params['create_table'] = table_name
        return self # method chaining
    end


    # TODO: constraints

    #
    # DELETE
    #

    def self.delete_from(table_name)
        @params['delete_from'] = table_name
        return self # method chaining
    end

    #
    # DESCRIBE DATABASE
    #

    def self.describe_database(database_name)
        @params['describe_database'] = database_name
        return self # method chaining
    end

    #
    # DESCRIBE SCHEMA
    #

    def self.describe_schema(schema_name)
        @params['describe_schema'] = schema_name
        return self # method chaining
    end

    #
    # DESCRIBE TABLE
    #

    def self.describe_table(table_name)
        @params['describe_table'] = table_name
        return self # method chaining
    end

    #
    # DROP INDEX
    #

    def self.drop_index(index_name)
        @params['drop_index'] = index_name
        return self # method chaining
    end

    #
    # DROP SCHEMA
    #

    def self.drop_schema(schema_name)
        @params['drop_schema'] = schema_name
        return self # method chaining
    end

    #
    # DROP TABLE
    #

    def self.drop_table(table_name)
        @params['drop_table'] = table_name
        return self # method chaining
    end

    #
    # INSERT
    #

    def self.insert_into(table_name)
        @params['insert_into'] = table_name
        return self # method chaining
    end

    def self.values(rows)
        @params['values'] = rows
        return self # method chaining
    end

    #
    # SELECT
    #

    def self.select(columns)
        if columns == '*':
            raise Exception('please use select_all() instead of select("*")')
        end

        @params['select'] = columns
        return self # method chaining
    end

    def self.select_all()
        @params['select'] = true
        return self # method chaining
    end

    def self.distinct(boolean)
        @params['distinct'] = boolean
        return self # method chaining
    end

    def self.from_tables(tables)
        @params['from'] = tables
        return self # method chaining
    end

    def self.group_by(columns)
        @params['group_by'] = columns
        return self # method chaining
    end

    def self.having(expression)
        @params['having'] = expression
        return self # method chaining
    end

    def self.limit(integer)
        @params['limit'] = integer
        return self # method chaining
    end

    def self.offset(integer)
        @params['offset'] = integer
        return self # method chaining
    end

    def self.order_by(expr_array)
        @params['order_by'] = expr_array
        return self # method chaining
    end

    def self.search(query_text)
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

    def self.show_schemas()
        @params['show_schemas'] = true
        return self # method chaining
    end

    #
    # SHOW TABLES
    #

    def self.show_tables()
        @params['show_tables'] = true
        return self # method chaining
    end

    #
    # UPDATE
    #

    def self.update(table_name)
        @params['update'] = table_name
        return self # method chaining
    end

    def self.set(kv_pairs)
        @params['set'] = kv_pairs
        return self # method chaining
    end
end