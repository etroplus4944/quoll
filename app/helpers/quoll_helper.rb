module QuollHelper

  def quoll_group
    index do
      column :name
      default_actions
    end
    form do |f|
      f.inputs "Details" do
        f.input :name
      end
      f.actions
    end
    show do |g|
      attributes_table do
        row :name
      end
    end
  end

  def quoll_query
    index do
      column :name
      column :quoll_group
      default_actions
    end

    form do |f|
      f.inputs "Details" do
        f.input :name
        f.input :description, :input_html => {:rows => 2}
        f.input :form, :input_html => {:rows => 5}
        f.input :report
        f.input :quoll_group
      end
      f.actions
    end
    show do |q|
      attributes_table do
        row :name
        row :description
        row :form
        row :report do
          r=q.report.gsub(/\n/,"<br>".html_safe)
          r.html_safe
        end
        row :quoll_group
      end
    end
  end

  def quoll_oracle
    require "zip/zip"
    content :title => xname do
      #action: new/query_id, edit/formdata_id, (show)formdata, destroy/formdata_id
      action=params[:a]
      query_id=params[:q]
      form_data_id=params[:fd]
      form_data_obj=QuollFormData.new(params[:quoll_form_data]) if params[:quoll_form_data]
      @table=QuollTable.new
      @files_to_zip=[]
      def add_sql(*sql)
        if sql[0].class==Symbol
          @table.add_sql(sql[1]) if sql[0]==:normal
          @table.add_sql_row_col_val(sql[1]) if sql[0]==:row_col_val
          Rails.logger.info("SQL ====> #{sql[1]}")
        else
          Rails.logger.info("SQL ====> #{sql[0]}")
          @table.add_sql(sql[0])
        end
      end
      def color(row, color)
        @table.color(row,color)
      end
      def add(row, col, val)
        @table.add(row, col, val)
      end
      def to_file(file_name)
        QuollComponent.file("public/"+file_name, @table)
        @files_to_zip<<file_name
      end
      def one_row_query(sql)
        results=ActiveRecord::Base.connection().execute(sql)
        results.each do |row|
          return row
        end
        return nil
      end
      def clear
        @table=QuollTable.new
      end
      def to_pie
        QuollComponent.pie(@table)
      end
      def to_area
        QuollComponent.area(@table)
      end
      def to_bar(e=nil)
        QuollComponent.bar(@table,e)
      end
      def to_table(&block)
        QuollComponent.table(@table, &block)
      end
      def add_options(options)
        @table.add_options(options)
      end
      def create_file
        zip_file_name="#{rand()}"[2, 1000]+".zip"
        Zip::ZipFile.open("public/"+zip_file_name, Zip::ZipFile::CREATE) do |zipfile|
          @files_to_zip.each do |filename|
            zipfile.add(filename, 'public/' + filename)
          end
        end
        File.chmod(0644, "public/"+zip_file_name)
        zip_file_name
      end
      div class: "oracle_left" do
        QuollGroup.all.each do |group|
          div class: "oracle_group" do
            h3 group.name
            group.quoll_queries.all.sort{|a,b| a.name<=>b.name}.each do |query|
              #1/0
              current_query=query_id.to_i
              current_query=QuollFormData.find(form_data_id).quoll_query_id if form_data_id
              current_query=form_data_obj.quoll_query_id if form_data_obj
              button_class=current_query!=query.id ? "quoll_button blue" : "quoll_button purple"
              div style:"margin-top:2px" do a class: button_class, href: "?a=new&q=#{query.id}" do
                query.name
              end    end
            end
          end
        end
      end
      style=""
      if params[:e]
        style="width:90%"
      end
      div style: style, class: "oracle_right" do
        if action=="new"
          form_data = QuollFormData.new
          form_data.quoll_query_id=query_id
          render partial: "admin/quolloracle/shared", locals: {form_data: form_data, last_form_data: QuollFormData.where(quoll_query_id: query_id)}
        end
        if action=="edit"
          form_data = QuollFormData.find(form_data_id)
          query_id=form_data.quoll_query_id
          render partial: "admin/quolloracle/shared", locals: {form_data: form_data, last_form_data: QuollFormData.where(quoll_query_id: query_id)}
        end
        if action=="destroy"
          form_data = QuollFormData.find(form_data_id)
          query_id=form_data.quoll_query_id
          form_data.destroy
          form_data = QuollFormData.new
          form_data.quoll_query_id=query_id
          render partial: "admin/quolloracle/shared", locals: {form_data: form_data, last_form_data: QuollFormData.where(quoll_query_id: query_id)}
        end
        if form_data_obj
          data = form_data_obj
          if data.name && data.name!=""
            exdata=QuollFormData.find_by_name(data.name)
            exdata.destroy if exdata
            data.save
          end
          query=data.quoll_query
          int1=data.int1
          int2=data.int2
          int3=data.int3
          int4=data.int4
          int5=data.int5
          int6=data.int6
          int7=data.int7
          int8=data.int8
          int9=data.int9
          date1=data.date1
          date2=data.date2
          date3=data.date3
          date4=data.date4
          date5=data.date5
          date6=data.date6
          date7=data.date7
          date8=data.date8
          date9=data.date9
          string1=data.string1
          string2=data.string2
          string3=data.string3
          string4=data.string4
          string5=data.string5
          string6=data.string6
          string7=data.string7
          string8=data.string8
          string9=data.string9
          report=ERB.new(query.report).result(binding)
          file=create_file
          render partial: "admin/quolloracle/show", locals: {data: data, report: report, query_id: query_id, file: file, e: params[:e]}
        end
      end
    end
  end
end