class Candidate < ApplicationRecord
	belongs_to :job
  mount_uploader :resume, ResumeUploader
end
