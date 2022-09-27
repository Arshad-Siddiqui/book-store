require 'book_repository'
require 'book'

def reset_books_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store' })
  connection.exec(seed_sql)
end

RSpec.describe BookRepository do
  before(:each) do 
    reset_books_table
  end

  describe '#all' do
    it 'returns all entries of database as an array of book objects' do
      book_repository = BookRepository.new
      expect(book_repository.all.first.title). to eq "Nineteen Eighty-Four"
      expect(book_repository.all.last.title).to eq "The Age of Innocence"
      expect(book_repository.all.length).to eq 5
    end
  end

  describe '#find' do
    it 'returns a book object corresponding to database id' do
      book_repository = BookRepository.new
      expect(book_repository.find(1).title).to eq 'Nineteen Eighty-Four'
      expect(book_repository.find(2).id).to eq "2"
      expect(book_repository.find(3).author_name).to eq 'Jane Austen'
    end
  end

  describe '#create' do
    it 'Adds new book to database' do
      book = Book.new(6, "Project Hail Mary", "Andy Weir")
      book_repository = BookRepository.new
      book_repository.create book
      expect(book_repository.all.last.title).to eq "Project Hail Mary"
      book2 = Book.new(7, "All These Worlds", "Dennis E. Taylor")
      book_repository.create book2
      expect(book_repository.all.last.title).to eq 'All These Worlds'
      expect(book_repository.all.last.author_name).to eq 'Dennis E. Taylor'
    end
  end

  describe '#delete' do
    it 'deletes a book from the database' do
      book_repository = BookRepository.new
      book_repository.delete(1)
      expect(book_repository.all.first.title).to eq "Mrs Dalloway"
      expect(book_repository.all.first.author_name).to eq 'Virginia Woolf'
    end
  end

  describe '#update' do
    it 'updates a book entry from the database' do
      book_repository = BookRepository.new
      book_repository.update(1, 'title', 'CoolBook7')
      expect(book_repository.all.last.title).to eq 'CoolBook7'
      book_repository.update(1, 'id', '7')
      expect(book_repository.all.last.id).to eq '7'
    end
  end
end