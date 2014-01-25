class Legislator < ActiveRecord::Base
  def full_name
    "#{firstname} #{middlename} #{lastname} #{name_suffix}".gsub(/\s{2}/," ").strip
  end
end
