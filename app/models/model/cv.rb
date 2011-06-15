module EasyCV
  module Model
  class CV  < ActiveRecord::Base

   default_scope :order => 'created_at DESC'


    def initialize()
      @job_entries = []
    end

    def add_job_entry(job_entry)
       @job_entries << job_entry
    end
  end
  end
end
end