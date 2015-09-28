module Sort
  module ClassMethods
    attr_accessor :sort_group_by
    
    def sort!(sorting_records)
      sorted_records = sorting_records.sort do |x, y|
                        a, b = [x.last, y.last]
                        if (a['new'].to_i <=> b['new'].to_i) == 0
                          b['old'].to_i <=> a['old'].to_i
                        else
                          a['new'].to_i <=> b['new'].to_i
                        end
                      end
      
      sorted_records.inject(1) do |count, record_row|
        record_id = record_row.first
        find(record_id).update_attribute(:sort, count)
        count += 1
      end
    end
  end
  
  def self.included(receiver)
    receiver.extend ClassMethods
  end
  
  protected
    
    def initialize_sort!
      self.sort = (self.class.where(@sort_group_by ? ["#{@sort_group_by.to_str} = ?", self.send(@sort_group_by)] : "1=1").collect(&:sort).compact.sort.last || 0) + 1
    end
        
end