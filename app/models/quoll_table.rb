require 'set'
class QuollTable
  def initialize
    @table={}
    @cols=Set.new
    @rows=Set.new
  end

  def add(row, col, val)
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
    r=[[0]+@cols.to_a]
    @rows.each do |row|
      new_row=[row]
      @cols.each do |col|
        new_row<<(get(row, col).to_f || null_value)
      end
      r<<new_row
    end
    r
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
      # mysql returns array, postgres not an array
      if row.class!=Array
        cols=row.values 
      else
        cols=row
      end
      add(cols[0], cols[1], cols[2].to_i)
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
