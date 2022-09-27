class Book
  def initialize(id = 0, title = '', author_name = '')
    @id, @title, @author_name = id, title, author_name
  end
  attr_accessor :id, :title, :author_name
end