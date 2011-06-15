module MyCV
  class CV
    attr :personal_data,true
    attr :job_entries,true

    def initialize()
      @job_entries = []
    end

    def add_job_entry(job_entry)
       @job_entries << job_entry
    end
  end
end