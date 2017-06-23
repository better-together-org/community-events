class JobInfo < ActiveRecord::Base
  attr_accessible :job_name, :last_run
  
  def job_name
    read_attribute(:job_name).to_sym
  end
  
  def job_name= (value)
    write_attribute(:job_name, value.to_s)
  end

end
