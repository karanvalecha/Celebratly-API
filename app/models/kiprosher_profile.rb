Airrecord.api_key = ENV["KARAN_AIRTABLE_KEY"]

class KiprosherProfile < Airrecord::Table
  self.base_key = "appKOzlajD5gcjfAK"
  self.table_name = "A. Directory- Active Status"

  attr_accessor :full_name, :dob, :wow

  def full_name
    self['Name']
  end

  def doj
    self['DOJ']
  end

  def dob
    self['DOB']
  end

  def email
    self['E-mail id']
  end
end
