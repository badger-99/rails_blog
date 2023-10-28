class PostResource < JSONAPI::Resource
  class PostResource < JSONAPI::Resource
    attributes :title, :content
    has_many :comments
    has_one :user
  end
end
