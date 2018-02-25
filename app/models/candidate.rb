class Candidate < ApplicationRecord
	belongs_to :job
  mount_uploader :resume, ResumeUploader
	validates_presence_of :resume
end
