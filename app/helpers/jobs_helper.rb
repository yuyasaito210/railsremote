module JobsHelper
  def quick_job_icon(job)
    css_class =
      case job.job_type
      when "Project"
        "mdi-action-alarm"
      when "Long Term"
        "mdi-maps-local-mall"
      else
        "mdi-file-folder"
      end
    content_tag :i, nil, class: css_class, title: "Job type: #{job.job_type}"
  end

  def select_job_type(control_type, job_type)
    control_type == job_type ? 'selected' : 'none'
  end

  def get_description_template
    description_template = ""
  end
end
