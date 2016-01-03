require 'set'
class QuollTable
  def initialize
    @table={}
    @cols=Set.new
    @rows=Set.new
    @color={}
  end

  def add(row, col, val)
    row||=""
    col||=""
    @table[row]={} if !@table[row]
    @table[row][col]=val
    @cols<<col
    @rows<<row
  end

  def get(row, col)
    return nil if !@table[row] || !@table[row][col]
    @table[row][col]
  end

  def to_2d_array(null_value)
    r=[["0"]+@cols.to_a+[{ role: 'style' }]]
    @rows.each do |row|
      new_row=[row]
      @cols.each do |col|
        new_row<<get(row, col).to_f || null_value
        new_row << (@color[row] || "")
        end
      r<<new_row
    end
    result=r.to_s.gsub(/:role=>/,"role:").to_s
    result
  end

  def color(row, color)
    @color[row]=color
  end

  def cols=(c)
    @cols=c
  end

  def rows=(r)
    @rows=r
  end

  def cols
    @cols
  end

  def rows
    @rows
  end

  def clear
    @table={}
  end

  def add_sql_row_col_val(sql)
    results=ActiveRecord::Base.connection().execute(sql)
    results.each do |row|
      puts ":::::::"
      puts row
      # mysql returns array, postgres not an array
      if row.class!=Array
        cols=row.values
      else
        cols=row
      end
      v=cols[2]
      if v.to_s.include? "."
        v=v.to_f
      else
        v=v.to_i
      end
      add(cols[0], cols[1], v)
    end
  end

  def add_sql(sql)
    results=ActiveRecord::Base.connection().execute(sql)
    results.each do |row|
      first_col=true
      r=nil
      row.each do |c, v|
        if first_col
          r=v
          first_col=false
        else
          add(r, c, v)
        end
      end
    end
  end

  def add_options(o)
    @options||={}
    @options=@options.merge(o)
  end

  def options
    @options||={}
  end

end
