require './helper'
require './student'
require './teacher'
require './book'
require './rental'

class App
  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def list_books
    puts 'No books found' if @books.empty?
    puts(@books.map { |book| "Title #{book.title}, Author: #{book.author}" })
  end

  def list_people
    puts 'No people found' if @people.empty?
    puts(@people.map { |person| "#{person.class.name} Name: #{person.name}, Age: #{person.age}, ID: #{person.id}" })
  end

  def create_person
    option = get_promt('Do you want to create a new student (1) or a new teacher? (2) [1/2]: ').to_i

    unless [1, 2].include?(option)
      puts 'Invalid selection'
      return
    end

    age = get_promt('Age: ')
    name = get_promt('Name: ')

    case option
    when 1
      permission = get_promt('Has parent permission? [y/n]:') == 'y'
      student = Student.new(age, 'class', name, parent_permission: permission)
      @people << student
    when 2
      specialization = get_promt('Specialization')
      teacher = Teacher.new(age, specialization, name)
      @people << teacher
    end
    puts "Person #{name} created successfully!"
  end

  def create_book
    print('Book title: ')
    title = gets.chomp
    print('Author: ')
    author = gets.chomp
    book = Book.new(title, author)

    @books << book
    puts 'Book created successfully!'
  end

  def create_rental
    puts 'Select a book from the following list by its number:'
    puts(@books.each_with_index.map { |book, index| "#{index + 1}) Title: #{book.title} Author: #{book.author}" })
    book_index = gets.chomp.to_i

    puts 'Select a person from the following list by its number:'
    puts(@people.each_with_index.map do |person, index|
           "#{index + 1}) #{person.class.name} name: #{person.name} ID: #{person.id} age: #{person.age}"
         end)
    person_index = gets.chomp.to_i

    print 'Date [YYYY/MM/DD]: '
    date = gets.chomp

    rental = Rental.new(date, @books[book_index - 1], @people[person_index - 1])

    @rentals << rental
    puts 'Rental created successfully!'
  end

  def list_rentals
    print('Id of the person: ')
    id = gets.chomp.to_i
    person = @people.filter { |p| p.id == id }.first
    puts(person.rentals.map { |rental| "Date: #{rental.date}, Book: #{rental.book.title}, by #{rental.book.author}" })
  end

  def print_start_message
    puts 'Please choose an option:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person'
    puts '7 - Exit'
  end

  def execute(option)
    case option
    when 1
      list_books
    when 2
      list_people
    when 3
      create_person
    when 4
      create_book
    when 5
      create_rental
    when 6
      list_rentals
    end
  end

  def start
    puts 'Welcome to our school library app!'
    loop do
      print_start_message

      option = gets.chomp.to_i

      if option == 7
        puts 'Okay. Bye'
        break
      end

      execute(option)
    end
  end
end

def main
  app = App.new
  app.start
end

main
