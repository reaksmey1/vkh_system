class SparePart < ActiveRecord::Base
	belongs_to	:spare_part_type
	has_many :sell_reports
end
