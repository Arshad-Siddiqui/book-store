require_relative 'lib/database_connection.rb'
require_relative 'lib/book_repository.rb'
require_relative 'lib/book.rb'
DatabaseConnection.connect("book_store")

book_repository = BookRepository.new
result_set = book_repository.all

result_set.each do |book|
  puts "#{book.id} - #{book.title} - #{book.author_name}"
end
