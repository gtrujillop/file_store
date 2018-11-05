class FileUpload < ApplicationRecord
  has_one_attached :file
  acts_as_taggable

  enum status: [:initiated, :in_progress, :failed, :uploaded]
  
  validates :file_name, presence: true, uniqueness: true
  validate :tag_list_format

  after_create :attach_file

  def self.by_tags(search_params)
    raise ActiveRecord::RecordNotFound.new("Invalid Search") unless valid_search?(search_params)
    search_params.downcase.split(" ").map do |search|
      if search.include?('+')
        inclusive_search(search)
      elsif search.include?('-')
        exclusive_search(search)
      end
    end.flatten.uniq
  end

  private

  def self.inclusive_search(search)
    FileUpload.tagged_with(search.tr('+', ''), any: true)    
  end

  def self.exclusive_search(search)
    FileUpload.tagged_with(search.tr('-', ''), exclude: true)
  end
  
  

  def attach_file
    self.file.attach(io: Tempfile.new(self.tag_list.join(',')), filename: file_name)
  rescue => e
    self.errors.add(:file, "Error attaching file #{e}" )
    raise ActiveRecord::RecordInvalid.new(self)
  end

  def tag_list_format
    self.tag_list.each do |tag|
      unless /^[^\+\-\s]+$/.match tag
        errors.add(:tag_list, "invalid tags. #{tag}")
      end
    end
  end
  

  def self.valid_search?(search_params)
    search_params.match?(/((\+|\-){1}[\w]+\s*)+/)
  end
end
