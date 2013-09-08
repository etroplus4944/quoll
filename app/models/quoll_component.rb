require "csv"

class QuollComponent

  # options:
  # query: the identifier of the query
  # label and value: define the columns of the query to consider
  # title
  def self.bar(table)
    r=rand
    table.rows=table.rows.sort
    <<-eos
     <script type="text/javascript">
    google.load("visualization", "1", {packages:["corechart"]})

       google.setOnLoadCallback(function() {
      var data = google.visualization.arrayToDataTable(#{table.to_2d_array(0)});

      var options = {
          title : '#{table.options[:title]||'You forgot to set :title'}',
          vAxis: {title: '#{table.options[:vaxis]||'You forgot to set :vaxis'}'},
          hAxis: {title: '#{table.options[:haxis]||'You forgot to set :haxis'}'},
          seriesType: "bars",
          series: {5: {type: "line"}}
    };

    var chart = new google.visualization.ComboChart(document.getElementById('#{r}'));
    chart.draw(data, options);
    })
    </script>
    <div id=#{r} style="width: 900px; height: 500px;"></div>
    eos
  end


  def self.area(table)
    r=rand
    table.rows=table.rows.sort
    <<-eos
     <script type="text/javascript">
    google.load("visualization", "1", {packages:["corechart"]})

       google.setOnLoadCallback(function() {
      var data = google.visualization.arrayToDataTable(#{table.to_2d_array(0)});

      var options = {
          title : '#{table.options[:title]||'You forgot to set :title'}',
          vAxis: {title: '#{table.options[:vaxis]||'You forgot to set :vaxis'}'},
          hAxis: {title: '#{table.options[:haxis]||'You forgot to set :haxis'}'}
    };

         var chart = new google.visualization.AreaChart(document.getElementById('#{r}'));
    chart.draw(data, options);
    })
    </script>

    <div id=#{r} style="width: 900px; height: 500px;"></div>
    eos
  end

  def self.pie(table)
    r=rand
    <<-eos
    <script type="text/javascript">
    google.load("visualization", "1", {packages:["corechart"]})

       google.setOnLoadCallback(function() {
         var data = google.visualization.arrayToDataTable(#{table.to_2d_array(0)});
         var options = {
            title: "#{table.options[:title] || ':title not set' }"
         };
         var chart = new google.visualization.PieChart(document.getElementById('#{r}'));
         chart.draw(data, options);
      });
    </script>
    <div id=#{r} style="width: 900px; height: 500px;"></div>
    eos
  end

  def self.val(row, col, val, &block)
    if block
      block.call(row, col, val) || " "
    else
      val || " "
    end
  end

  def self.table(t, &block)
    re="<h2>#{t.options[:title]}</h2>"
    re+="<table class=quoll_table><tr><th class=quoll_th> </th>"
    t.cols.each do |c|
      re+="<th class=quoll_th>"+self.val("_", c, c, &block)+"</th>"
    end
    re+="</tr>"
    t.rows.each do |r|
      re += "<tr><td>"+self.val(r, "_", r, &block)+"</td>"
      t.cols.each do |c|
        re+="<td>"
        re+=self.val(r, c, t.get(r, c), &block).to_s
        re+="</td>"
      end
      re += "</tr>"
    end
    re+"</table"
  end

  def self.file(file_name, table, &block)
    CSV.open("#{file_name}","wb") do |csv|
      csv << table.cols.inject(['']) {|r,c| r << self.val("_", c, c, &block)}
      table.rows.each do |r|
        csv << table.cols.inject([self.val(r, "_", r, &block)]) {|res,c| res << self.val(r, c, table.get(r, c), &block).to_s}
      end
    end
  end


end
