class BookRepository
  def all
    sql = "Select * FROM books"
    result_set = DatabaseConnection.exec_params(sql,[])
    books = []
    result_set.each do |result|
      book = Book.new
      book.id = result['id']
      book.title = result['title']
      book.author_name = result['author_name']
      books.push book
    end
    books
  end
  def find(id)
    sql = "SELECT * FROM books WHERE id = #{id}"
    new_book = DatabaseConnection.exec_params(sql,[])[0]
    book = Book.new
    book.id = new_book['id']
    book.title = new_book['title']
    book.author_name = new_book['author_name']
    book
  end

  def create(book)
    sql = "INSERT INTO books (id, title, author_name) VALUES (#{book.id}, '#{book.title}', '#{book.author_name}')"
    DatabaseConnection.exec_params(sql,[])
  end

  def update(id, key, value)
    sql = "UPDATE books SET #{key} = '#{value}' WHERE id = #{id}"
    DatabaseConnection.exec_params(sql,[])
  end

  def delete(id)
    sql = "DELETE FROM books WHERE id = #{id}"
    DatabaseConnection.exec_params(sql,[])
  end
end