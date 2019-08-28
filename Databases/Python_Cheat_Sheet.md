Things to research:

- call by reference & value in python
- Generators
- Closures, First Class Functions
- if **name** == **main**:
- pip package manager
- Doc Strings in functions and using @wraps in Decorators
- Async, Await, Asyncio
- JSON Module
- DateTime Module
- CSV Module
- HTTP Requests

# Data Types

## String Type

In Python, a string can be defined using single or double quotes. We can also create a multi-line string using triple quotes.

```py
string_1 = 'single quotes'
string_2 = "double quotes"

string_3 =  """ this is
a multi-line string
using triple quotes
"""
```

## Numeric Types

Python has two numeric types, int (integer) and float (decimal)

```py
number_1 = 10   # this is an int
number_2 = 1.45 # this is a float
```

## Bool Type

The bool type is used for logical values and expressions

In Python, everything evaluates to true except for:

- 0
- ""
- None

```py
logical_value = True
logical_expression = 7 > 5

# Falsey Values
no_value = None     # evaluates to False
zero_value = 0      # evaluates to False
empty_string = ""   # evaluates to False
empty_list = []     # evaluates to False
empty_tuple = ()    # evaluates to False
empty_dict = {}     # evaluates to False

```

## Sequence Type

Python provides some sequence data types, including lists, tuples, and dictionaries

```py
a_list = [1, 2, 3, 4]   # mutable, index starts at 0
a_tuple = (1, 2, 3, 4)  # immutable, index starts at zero
a_dictionary = {"one": 1, "two": 2} # key-value pairs
```

### Range Function

The range function returns a sequence of numbers starting from 0 (default), increments by 1 (default), and ends at a specified number.

range(start, end(non-inclusive), step)

```py
range_1 = range(5)
range_2 = range(3, 20, 2)
```

## None Type

In Python, None is used to represent the absence of a value.

```py
no_value = None
```

## type() and id()

type() returns the object type
id() return the unique id of an object

```py
a_tuple = (1, 2, 3)
tuple_2 = (6, 7, 2)

print(type(a_tuple))  # tuple
print(id(a_tuple))    # 028394634
print(id(tuple_2))    # 748573029

# checking if something is of a certain type
if isinstance(a_tuple, tuple):
    print("yes, this is a tuple")
```

# Conditionals

## If Statement

```py
if x < 5:
  print("Too Small")
elif x == 5:
  print("Perfect!")
else:
  print("Too Big")
```

## Conditional Operators

```py
a > b     # greater than
a >= b    # greater than or equal to
a < b     # less than
a <= b    # less than or equal to
a == b    # equal
a != b    # not equal
```

## Logical Operators

```py
x and y   # True if x and y
x or y    # True if x or y
not x     # Invert state
```

## Identity Operator

```py
x is y      # True if same object
x is not y  # True if not same object
```

## Membership Operator

```py
x in y      # True if x is member of collection y
x not in y  # True if x is not member of collection y
```

## Ternary Operator

The ternary operator is a simple one-line conditional statement. If the condition is true, it evaluates the first expression, if it is false it evaluates the second expression.

```py
[on_true] if [expression] else [on_false]

hungry = 0
x = "feed the bear" if hungry else "don't feed bear"

print(x)  # don't feed bear
```

# Operators

## Arithmetic Operators

```py
+     # addition
-     # subtraction
*     # multiplication
/     # division, returns a float
//    # division, returns an int
%     # modulo, returns the remainder of division
**    # exponentiation x ** y = x to the power of y

-     # unary negative
+     # unary positive
```

## Bitwise Operators

```py
&   # And
|   # Or
^   # Xor
<<  # Shift Left
>>  # Shift Right
```

## Comparison Operators

```py
a > b     # greater than
a >= b    # greater than or equal to
a < b     # less than
a <= b    # less than or equal to
a == b    # equal
a != b    # not equal
```

## Boolean Operators

```py
and     # And
or      # Or
not     # Not
in      # value in set
not in  # value not in set
is      # Same object identity
is not  # Not same object identity
```

## Operator Precedence

1. parenthesis
2. exponentiation
3. multiplication / division
4. addition / subtraction

# Loops

## While Loop

```py
while <condition>:
    print("something")

while 7 > 3:
    print("infinite loop")
```

## For Loop

```py
for pet in animals:
    print(pet)

for i in range(2, 10):
    print(i)
```

## Loop Controls

```py
break     # breaks out of the current loop
continue  # continues to the next iteration of the loop
pass      # does nothing
else      # executes only if loop ends naturally (i.e. without a break statement)

for i in range(2, 10):
    print(i)
else:
    print("all done")
```

# Functions

Function are the basic unit of reuseable code.

- Easier to maintain code
- Easier to read code
- Parameter are placeholders for the data we can pass to functions
- Arguments are the actual values that are passed to the functions
- All functions return a value
- If there is no return statement, None is returned

```py
def func_name(parameters):
    code block
    return something

def func_name2(name, a = 1, b = 3): # default arguments for parameters
    print(name)
    print(a + b)
    return something

# Calling functions
func_name(arguments)

# positional arguments : the order of the arguments matters
func_name2("Andrew", 10, 5)

# keyword arguments
func_name2(name="Andrew", a=10, b=5)
```

## Argument Lists

Python functions allow variable length argument lists

```py
def kitten(*args): # variable length argument list
  if len(args):    # args is a tuple
    for sound in args:
      print(sound)
  else: print("Meow")

kitten("Meow", "Purr", "Grrr!") # will print however many args you pass

# We can also call it with a variable
cat_sounds = ("grr!", "growl!")
kitten(*cat_sounds) # we need to use an asterisk before the variable name
```

## Generators

## Decorators

A function that takes another function as an argument, adds some functionality, and returns a function.

Syntax:

```py
@my_decorator_fnc
def my_function(x,y):
  return x + y
```

Typically, a decorator has an inner() function that is defined inside of it. This inner function then calls the original, decorated function, and adds some functionality to it.

In the example below, the original function takes in a single string value and turn it into camel case. But what if we want to pass in a list of string to turn into camel case. We can add the additional functionality with a decorator.

By placing the @decorator_name above the original function we are basically saying

original_function = decorator_function(original_function)

The decorator_function takes in the original_function as an argument. Inside the decorator function we have inner_function, which adds some additional functionality to original_function. The inner_function is returned by the decorator function and stored in original_function. Now, when we call original_function we are using the function with the functionality we added.

```py
def decorator_function(original_function):
    def inner_function(list_of_strings):
        return [original_function(str_value) for str_value in list_of_strings]

    return inner_function

@decorator_function
def original_function(str_value):
    ''.join([word.capitalize() for word in s.split('_')])

names = ["Andrew_martinez", "Jessica_Martines", "Ethan_Frontino"]
original_function(names)
```

# Data Structures

## Lists

A list is a collection of items

- ordered
- mutable
- allows duplicates
- index starts at 0
- uses square brackets

```py
numbers = [1, 2, 3, 4, 5]

numbers[0] # returns the first item
numbers[1] # returns the second item
numbers[-1] # returns the first item from the end
numbers[-2] # returns the second item from the end

# List Methods
numbers.append(6) # adds 6 to the end
numbers.insert(0, 6) # adds 6 at index position of 0
numbers.remove(6) # removes 6
numbers.pop() # removes the last item
numbers.clear() # removes all the items
numbers.index(8) # returns the index of first occurrence of 8
numbers.sort() # sorts the list
numbers.reverse() # reverses the list
numbers.copy() # returns a copy of the list
numbers.count(1)	# returns the number of elements with the specified value
numbers.extend(9)	# add the elements of a list (or any iterable), to the end of the current list
```

## Tuple

A tuple is a collection of items, similar to a list

- unlike a list, a tuple is immutable
- ordered
- allows duplicates
- index starts at 0
- uses parenthesis

```py
numbers = (1, 2, 3, 4, 5)

# Tuple Methods
numbers.count(3)	# returns the number of times a specified value occurs in a tuple
numbers.index(8)	# searches the tuple for a specified value and returns the position of where it was found
```

## Sets

Sets are collections of unique values

- unordered
- unindexed
- No duplicates
- uses curly brackets

```py
a_set = {1, 2, 3, 4, 5}

# defining an empty set
empty_set = set{}

# Set Methods
add()	              # Adds an element to the set
clear()	            # Removes all the elements from the set
copy()	            # Returns a copy of the set
difference()	      # Returns a set containing the difference between two or more sets
difference_update()	# Removes the items in this set that are also included in another, specified set
discard()	          # Remove the specified item
intersection()	    # Returns a set, that is the intersection of two other sets
intersection_update()	# Removes the items in this set that are not present in other, specified set(s)
isdisjoint()	      # Returns whether two sets have a intersection or not
issubset()	        # Returns whether another set contains this set or not
issuperset()	      # Returns whether this set contains another set or not
pop()	              # Removes an element from the set
remove()	          # Removes the specified element
symmetric_difference()	# Returns a set with the symmetric differences of two sets
symmetric_difference_update()	# inserts the symmetric differences from this set and another
union()	            # Return a set containing the union of sets
update()	          # Update the set with the union of this set and others
```

Quick operands for set operations

```py
A = {0, 2, 4, 6, 8};
B = {1, 2, 3, 4, 5};

# union
print("Union :", A | B)

# intersection
print("Intersection :", A & B)

# difference
print("Difference :", A - B)

# symmetric difference
print("Symmetric difference :", A ^ B)
```

## Dictionaries

A dictionary is a collection of key value pairs

- unordered
- mutable
- keys must be unique
- keys can be strings or numbers
- values can be any type

```py
customer = {
 “name”: “John Smith”,
 “age”: 30,
 “is_verified”: True
}

# Dictionary Methods
clear()	        # Removes all the elements from the dictionary
copy()          #	Returns a copy of the dictionary
fromkeys()	    # Returns a dictionary with the specified keys and values
get()	          # Returns the value of the specified key
items()	        # Returns a list containing a tuple for each key value pair
keys()	        # Returns a list containing the dictionary's keys
pop()	          # Removes the element with the specified key
popitem()	      # Removes the last inserted key-value pair
setdefault()	  # Returns the value of the specified key. If the key does not exist: insert the key, with the specified value
update()	      # Updates the dictionary with the specified key-value pairs
values()	      # Returns a list of all the values in the dictionary

# Looping through a dictionary
for key, value in dictionary.items():
  print(key)
  print(value)

for key in dictionary.keys():
  print(key)
  print(value)

for value in dictionary.values():
  print(key)
  print(value)

```

# Comprehensions

A comprehension is a way to build an iterable object in a single expression, without the need for a traditional for loop. There are four types of comprehensions: list, dict, set, and a generator expression

There is no tuple comprehension!

## List Comprehension

A list comprehension creates and returns a list from other iterables.

Syntax:

```py
new_list = [ expression_to_apply  for_loop  condition ]
```

Example:
Here, the list expression takes the numbers list and for each element (n), if n is greater than two, it will square the number and append the result to the squared_numbers list

```py
numbers = [1, 2, 3, 4]
squared_numbers = [ n ** 2 for n in numbers if n > 2 ]
```

### Nested List Comprehension

Nested list comprehensions are harder to read. Perhaps try a nested for loop instead?

Here, the first loop is the outer loop and the second loop is the inner loop. You can also add a condition if necessary.

```py
new_list = [ (x, y) for x in x_list for y in y_list ]
```

## Dictionary Comprehension

Syntax-wise a Dict Comprehension is very similar to a list comprehension

Here, we loop through some dictionary, if some string is in the key then we capitlize the key and we run the value through some function. The result is then stored in the new dictionary.

```py
new_dict = {
    key.capitalize(): some_func(value)
    for key, value in some_dict.items()
    if "some_string" in key
}
```

## Set Comprehension

Remember that a set is a collection of unique elements without order. A set comprehension uses curly brackets, like a dict comprehension, but we dont have a key : value expression. This is how Python knows it is a set comprehension.

```py
primes = { set_element for set_element in Numbers if is_prime(set_element) }
```

## Generator Expression

# Classes (OOP)

A class is a blueprint of an object. An object is called an instance of a class.

```py
  # the init method is how we initialize instance attributes. The init method runs every time a new instance is created.
  # the first parameter should always be self
  # self is a reference to the instance
class Employee:
    def __init__(self, fName, lName, pay):
        self.fName = fName
        self.lName = lName
        self.pay = pay

    # when we create class methods we also need to pass in self
    def methodName(self):
        do domething here

# Creating an instance of the Employee class. We pass in the arguments in order. Notice that we don't pass anything for the self parameter. This is because python does this under the hood. In this case self is the reference to employee1
employee1 = Employee("Andrew", "Martinez", 70000)
```

## Class Variables

Instance variables, as shown above, are unique to each instance, but class variables are variables that are shared across all instances. A class variable is the same for each instance.

```py
class Employee:
    # initialize a class variable
    variable_name = 0

    def __init__(self, fName, lName, pay):
        self.fName = fName
        self.lName = lName
        self.pay = pay

    # To access the class variables we need to access them through the class itself or through the instance
    # When we try to access an attribute, Python will first check the instance. If the instance does not have the attribute then it will check the class for the attribute.
    def methodName(self):
        print(Employee.variable_name) # through the class
        print(self.variable_name)     # through the instance

employee1 = Employee("Andrew", "Martinez", 70000)

employee1.methodName()

# We can change the value of the class variable for a specific  instance only.
# This creates the variable_name within employee1
# Then, we can access it by using self.variable_name in the method
employee1.variable_name =  1
```

## Class Methods

Class methods are methods that automatically take the class as the first argument. Class methods can also be used as alternative constructors.

```py
class Employee:
    variable_name = 0

    def __init__(self, fName, lName, pay):
        self.fName = fName
        self.lName = lName
        self.pay = pay

    def methodName(self):
        print(Employee.variable_name)
        print(self.variable_name)

    # We use a decorator to create a class method
    # cls is the first parameter, instead of self.
    @classmethod
    def classMethodName(cls, otherParam):
        pass
```

## Static Methods

Static methods do not take the instance or the class as the first argument. They behave just like normal functions, yet they should have some logical connection to our class.

We use static methods when the function does not reference cls or self.

```py
class Employee:
    variable_name = 0

    def __init__(self, fName, lName, pay):
        self.fName = fName
        self.lName = lName
        self.pay = pay

    def methodName(self):
        print(Employee.variable_name)
        print(self.variable_name)

    # We use a decorator to create a static method
    @staticmethod
    def staticMethodName(Params):
        pass
```

## Class Inheritance

Inheritance allows us to inherit attributes and methods from a parent class. This is useful because we can create subclasses and get all of the functionality of our parents class, and have the ability to overwrite or add completely new functionality without affecting the parents class in any ways.

```py
class Employee:
    variable_name = 0

    def __init__(self, fName, lName, pay):
        self.fName = fName
        self.lName = lName
        self.pay = pay

# we can inherit the attributes and methods from the parent class.
class Developer(Employee):
    # we can extend the parent class with additional attributes (prog_lang) for the developer class
    def __init__(self, fName, lName, pay, prog_lang):
        # we use super so that the parent class init method initializes the inherited attributes
        super().__init__(fName, lName, pay)
        self.prog_lang = prog_lang

dev1 = Developer("Andrew", "Martinez", 70000, "Python")
```

## isinstance() and issubclass()

isinstance tell us if an object is an instance of a class

issubclass tells us if a class is a subclass of another class

```py
print(isinstance(dev1, Developer))     # True
print(issubclass(Developer, Employee)) # True
```

## Magic/Dunder Methods

Special or Dunder menthods are usually surrounded by double underscores. These methods allow us to emulate built-in types or implement operator overloading. These can be extremely powerful if used correctly.

Two common dunder methods that we should probably always implement are:

```py
# the goal of repr is to be unambiguous
def __repr__(self):
    # return a string that represents the object
    return "Employee( '{}', '{}', '{}')".format(self.fName, self.fName, self.pay)

# the goal of str is to be readable
def __str__(self):
    # return a string that represents the object
    return "{} - {}".format(self.fullName(), self.email())
```

For example, if we wanted to create a special add method where is added the combined salaries of two employees when we used the addition operator, we could use the dunder add method.

Look at the documentation for other dunder/magic methods

```py
def __add__(self, other):
    return self.pay + other.pay

print(employee_1 + employee_2) # 110000

```

## Property Decorator

The property decorator allows us to define Class methods that we can access like attributes. This allows us to implement getters, setters, and deleters.

Suppose we have a class with an email attribut in the init method. The init method only runs when an object is created from that class. In this example, if we were to change the first name, the email attribute would have the wrong first name.

```py
class Employee:
    def __init__(self, fName, lName, pay):
        self.fName = fName
        self.lName = lName
        self.email = '{}.{}@email.com'.format(self.fName, self.lName)
```

We can alter our code and create an email function that uses the current names to construct the email every time it is called. But the problem here is that when we break the code. Anyone who was using the email attribute would have to go through their code to make the changes.

```py
class Employee:
    def __init__(self, fName, lName, pay):
        self.fName = fName
        self.lName = lName

    def email(self):
        return '{}.{}@email.com'.format(self.fName, self.lName)
```

By adding the @property decorator above the email method we can access it like an attribute

```py
class Employee:
    def __init__(self, fName, lName, pay):
        self.fName = fName
        self.lName = lName

    # this is getter
    @property
    def email(self):
        return '{}.{}@email.com'.format(self.fName, self.lName)

emp1 = Employee("Andrew", "Martinez")
print(emp1.email) # Andrew.Martinez@email.com
```

### Creating a setter

```py
class Employee:
    def __init__(self, fName, lName, pay):
        self.fName = fName
        self.lName = lName

    @property
    def email(self):
        return '{}.{}@email.com'.format(self.fName, self.lName)

    def fullname(self):
        return '{} {}'.format(self.fName, self.lName)

emp1 = Employee("Andrew", "Martinez")
# This would throw an error because there is no fullname attribute. But we can create a setter to add the functionality to change the name.
emp1.fullname = "Andy Martinez"
```

Creating the setter:

```py
class Employee:
    def __init__(self, fName, lName, pay):
        self.fName = fName
        self.lName = lName

    @property
    def email(self):
        return '{}.{}@email.com'.format(self.fName, self.lName)

    # first we add the @property decorator to the original method
    @property
    def fullname(self):
        return '{} {}'.format(self.fName, self.lName)

    # then we create a new method with the same name as the original method and add the setter decorator - @fullname.setter in this case
    @fullname.setter
    def fullname(self, name):
        first, last = name.split(' ')
        self.fName = first
        self.lName = last

emp1 = Employee("Andrew", "Martinez")
# Now when we set the fullname attribute we are actually calling the fullname setter method, which sets the fName and lName attributes.
emp1.fullname = "Andy Martinez"
```

### Creating a deleter

We can create a deleter the same way we create a setter.
Creating the setter:

```py
class Employee:
    def __init__(self, fName, lName, pay):
        self.fName = fName
        self.lName = lName

    @property
    def email(self):
        return '{}.{}@email.com'.format(self.fName, self.lName)

    @property
    def fullname(self):
        return '{} {}'.format(self.fName, self.lName)

    @fullname.setter
    def fullname(self, name):
        first, last = name.split(' ')
        self.fName = first
        self.lName = last

    @fullname.deleter
    def fullname(self, name):
        self.fName = None
        self.lName = None

emp1 = Employee("Andrew", "Martinez")
# Now when we del emp1.fullname we are actually calling the fullname deleter method, which sets the fName and lName attributes to None.
del emp1.fullname
```

# DOCSTRINGS

Python documentation strings (or docstrings) provide a convenient way of associating documentation with Python modules, functions, classes, and methods.

It’s specified in source code that is used, like a comment, to document a specific segment of code. Unlike conventional source code comments, the docstring should describe what the function does, not how.

Declaring Docstrings: The docstrings are declared using “””triple double quotes””” just below the class, method or function declaration. All functions should have a docstring.

Accessing Docstrings: The docstrings can be accessed using the dunder doc method of the object or using the help function.
The below example demonstrates how to declare and access a docstring.

```py
def my_function():
    """Demonstrate docstrings and does nothing really."""

    return None

print "Using __doc__:"
print my_function.__doc__

print "Using help:"
help(my_function)
```

# Exceptions

An exception occurs when an error occurs during execution of syntactically valid Python code. This is different than a SyntaxError, which is when you try to run syntactically invalid Python code. When this happens, none of the code is executed.

## Basic Exception Handling

We can use a try-exception block to catch errors

```py
try:
    i = oneover(0)
except:
    print("this is a blank exception and captures every single type of error that can occur. This is bad practice. It is better to be specific about the errors we capture.")

# We can find the different types of errors in the Python documentation
try:
    i = oneover(0)
except ZeroDivisionError:
    print("Cannot divide by zero!")


# But we can have multiple errors. So, we can specify multiple exceptions
try:
    i = oneover("x")
except ZeroDivisionError:
    print("Cannot divide by zero!")
except TypeError:
    print("You can only divide by an integer")

# We can also group the error types together. Although this method gives you less flexibility on how to treat each type of exception
try:
    i = oneover("x")
except ( ZeroDivisionError, TypeError ):
    print("A problem occured")
```

## the else clause

```py
try:
    i = oneover("x")
except ( ZeroDivisionError, TypeError ):
    print("...")
else:
    print("the code in this block is executed only if NO exceptions are raised.")
```

## the finally clause

```py
try:
    i = oneover("x")
except ( ZeroDivisionError, TypeError ):
    print("...")
else:
    print("...")
finally:
    print("The code in this block is ALWAYS executed, even if an exception is raised.")
```

## Raising Exception

You can raise Exceptions yourself. It's most elegant to use Python's built-in Exception objects whenever this makes sense. But you can also create custom Exception objects.

```py
def someFunc(positive_num):
    if positive_num < 0:
        raise ValueError("someFunc only accepts positive numbers greater than zero")

    return 1/positive_num

```

# String Objects

Strings are first-class objects. Strings are immutable in Python. When we use transformation methods, the return is a new string object.

## Formatting Strings

We can use a placeholder {} with the format() method

```py
x= 99
y= 11

# the order of the values in the .format method matters
print("Your lucky numbers are {} and {}").format(x, y)

# Using position. In this example, y is the 0 position and x is in the 1 position.
print("Your lucky numbers are {1} and {0}").format(y, x)

# Using keywords. In this example, y is the 0 position and x is in the 1 position.
print("Your lucky numbers are {First} and {Second}").format(First = y, Second = x)

```

## F Strings ( Python 3.6+)

The F string is a shortcut for the format method.

```py
x= 99
y= 11

# the order of the values in the .format method matters
print(f'Your lucky numbers are {x} and {y}'

```

## Adding Formatting Instructions

```py
'{:x}'.format(100)
# Hexadecimal representation
# Output: 64

'{:X}'.format(3487)
# Hexadecimal representation (uppercase letters)
# Output: D9F

'{:#x}'.format(100)
# Hexadecimal representation (including the 0x)
# Output: 0x64

'{:b}'.format(100)
# Binary representation
# Output: 1100100

'{:c}'.format(100)
# Character representation
# Output: d

'{:d}'.format(100)
# Decimal representation (default)
# Output: 100

'{:,}'.format(1000000)
# With thousands separator
# Output: 1,000,000

'{:o}'.format(100)
# Octal representation
# Output: 144

'{:n}'.format(100)
# Like d, but uses locale information for separators
# Output: 100

'{:e}'.format(0.0000000001)
# Exponent notation
# Output: 1.000000e-10

'{:E}'.format(0.0000000001)
# Exponent notation (capital 'E')
# Output: 1.000000E-10

'{:f}'.format(3/14.0)
# Fixed point
# Output: 0.214286

'{:g}'.format(3/14.0)
# General format
# Output: 0.214286

'{:%}'.format(0.66)
# Percentage
# Output: 66.000000%

'{:.3}'.format(0.214286)
# Precision
# Output: 0.214
```

## Common String Methods

```py
capitalize()	# Converts the first character to upper case
casefold()	  # Converts string into lower case
center()	    # Returns a centered string
count()	      # Returns the number of times a specified value occurs in a string
encode()	    # Returns an encoded version of the string
endswith()	  # Returns true if the string ends with the specified value
expandtabs()	# Sets the tab size of the string
find()	      # Searches the string for a specified value and returns the position of where it was found
format()	    # Formats specified values in a string
format_map()	# Formats specified values in a string
index()	      # Searches the string for a specified value and returns the position of where it was found
isalnum()	    # Returns True if all characters in the string are alphanumeric
isalpha()	    # Returns True if all characters in the string are in the alphabet
isdecimal()	  # Returns True if all characters in the string are decimals
isdigit()	    # Returns True if all characters in the string are digits
isidentifier()	# Returns True if the string is an identifier
islower()	    # Returns True if all characters in the string are lower case
isnumeric()	  # Returns True if all characters in the string are numeric
isprintable()	# Returns True if all characters in the string are printable
isspace()	    # Returns True if all characters in the string are whitespaces
istitle()	    # Returns True if the string follows the rules of a title
isupper()	    # Returns True if all characters in the string are upper case
join()	      # Joins the elements of an iterable to the end of the string
ljust()	      # Returns a left justified version of the string
lower()	      # Converts a string into lower case
lstrip()	    # Returns a left trim version of the string
maketrans()	  # Returns a translation table to be used in translations
partition()	  # Returns a tuple where the string is parted into three parts
replace()	    # Returns a string where a specified value is replaced with a specified value
rfind()	      # Searches the string for a specified value and returns the last position of where it was found
rindex()	    # Searches the string for a specified value and returns the last position of where it was found
rjust()	      # Returns a right justified version of the string
rpartition()	# Returns a tuple where the string is parted into three parts
rsplit()	    # Splits the string at the specified separator, and returns a list
rstrip()	    # Returns a right trim version of the string
split()	      # Splits the string at the specified separator, and returns a list
splitlines()	# Splits the string at line breaks and returns a list
startswith()	# Returns true if the string starts with the specified value
strip()	      # Returns a trimmed version of the string
swapcase()	  # Swaps cases, lower case becomes upper case and vice versa
title()	      # Converts the first character of each word to upper case
translate()	  # Returns a translated string
upper()	      # Converts a string into upper case
zfill()	      # Fills the string with a specified number of 0 values at the beginning
```

# Slices

Slices
In Python, we can access parts of lists or strings using slices.

Creating slices:

```py
a[start:end] # items start through end-1
a[start:]    # items start through the rest of the array
a[:end]      # items from the beginning through end-1
a[:]         # a copy of the whole array
```

Starting from the end: We can also use negative numbers when creating slices, which just means we start with the index at the end of the array, rather than the index at the beginning of the array.

```py
a[-1]    # last item in the array
a[-2:]   # last two items in the array
a[:-2]   # everything except the last two items
```

# File I/O Basics

```py
# first specify the file to open, and then the mode
file = open('file_name.txt', 'rt')

# Modes
# "r" - Read - Default value. Opens a file for reading, error if the file does not exist
# "a" - Append - Opens a file for appending, creates the file if it does not exist
# "w" - Write - Opens a file for writing, creates the file if it does not exist
# "x" - Create - Creates the specified file, returns an error if the file exists

# In addition you can specify if the file should be handled as binary or text mode
# "t" - Text - Default value. Text mode
# "b" - Binary - Binary mode (e.g. images)

# File Methods
file.close()	# Closes the file. It is important to close the file when you are done.
file.detach()	# Returns the separated raw stream from the buffer
file.fileno()	# Returns a number that represents the stream, from the operating system's perspective
file.flush()	# Flushes the internal buffer
file.isatty()	# Returns whether the file stream is interactive or not
file.read()	# Returns the entire file content
file.read(50)	# Returns the next specified # of characters
file.readable()	# Returns whether the file stream can be read or not
file.readline()	# Returns one line from the file
file.readlines()	# Returns a list of lines from the file
file.seek()	# Change the file position
file.seekable()	# Returns whether the file allows us to change the file position
file.tell()	# Returns the current file position
file.truncate()	# Resizes the file to a specified size
file.writeable()	# Returns whether the file can be written to or not
file.write()	# Writes the specified string to the file
file.writelines()	# Writes a list of strings to the file

# Example: reading a file
f = open("demofile.txt", "r")
print(f.read())
f.close()

# Example: appending to a file
f = open("demofile2.txt", "a")
f.write("Now the file has more content!")
f.close()

# Example: overwrite a file
f = open("demofile3.txt", "w")
f.write("Woops! I have deleted the content!")
f.close()
```

## Using a Context Manager

Perhaps the most common (and important) use of context managers is to properly manage resources. In fact, that's the reason we use a context manager when reading from a file. The act of opening a file consumes a resource (called a file descriptor), and this resource is limited by your OS. That is to say, there are a maximum number of files a process can have open at one time.

what is a "file descriptor" and what does it mean to "leak" one? Well, when you open a file, the operating system assigns an integer to the open file, allowing it to essentially give you a handle to the open file rather than direct access to the underlying file itself. This is beneficial for a variety of reasons, including being able to pass references to files between processes and to maintain a certain level of security enforced by the kernel.

So how does one "leak" a file descriptor. Simply: by not closing opened files. When working with files, it's easy to forget that any file that is open()-ed must also be close()-ed. Failure to do so will lead you to discover that there is (usually) a limit to the number of file descriptors a process can be assigned.

We can use the WITH keyword to manage our resources when working with files

```py
# we open the file in the specified mode and assign it to the file variable
# note: the file variable is only available within the with block
with open('example.txt', 'r') as file:
    for line in file:
        print(line)
    # we don't have to worry about closing the file.

# we can also open multiple files in the same with block
with open('example.txt', 'r') as f1, open('example2.txt', 'r') as f2:
    # work with both files in this block

```

# Built-In Functions

```py
abs()	# Returns the absolute value of a number
all()	# Returns True if all items in an iterable object are true
any()	# Returns True if any item in an iterable object is true
ascii()	# Returns a readable version of an object. Replaces none-ascii characters with escape character
bin()	# Returns the binary version of a number
bool()	# Returns the boolean value of the specified object
bytearray()	# Returns an array of bytes
bytes()	# Returns a bytes object
callable()	# Returns True if the specified object is callable, otherwise False
chr()	# Returns a character from the specified Unicode code.
classmethod()	# Converts a method into a class method
compile()	# Returns the specified source as an object, ready to be executed
complex()	# Returns a complex number
delattr()	# Deletes the specified attribute (property or method) from the specified object
dict()	# Returns a dictionary (Array)
dir()	# Returns a list of the specified object's properties and methods
divmod()	# Returns the quotient and the remainder when argument1 is divided by argument2
enumerate()	# Takes a collection (e.g. a tuple) and returns it as an enumerate object
eval()	# Evaluates and executes an expression
exec()	# Executes the specified code (or object)
filter()	# Use a filter function to exclude items in an iterable object
float()	# Returns a floating point number
format()	# Formats a specified value
frozenset()	# Returns a frozenset object
getattr()	# Returns the value of the specified attribute (property or method)
globals()	# Returns the current global symbol table as a dictionary
hasattr()	# Returns True if the specified object has the specified attribute (property/method)
hash()	# Returns the hash value of a specified object
help()	# Executes the built-in help system
hex()	# Converts a number into a hexadecimal value
id()	# Returns the id of an object
input()	# Allowing user input
int()	# Returns an integer number
isinstance()	# Returns True if a specified object is an instance of a specified object
issubclass()	# Returns True if a specified class is a subclass of a specified object
iter()	# Returns an iterator object
len()	# Returns the length of an object
list()	# Returns a list
locals()	# Returns an updated dictionary of the current local symbol table
map()	# Returns the specified iterator with the specified function applied to each item
max()	# Returns the largest item in an iterable
memoryview()	# Returns a memory view object
min()	# Returns the smallest item in an iterable
next()	# Returns the next item in an iterable
object()	# Returns a new object
oct()	# Converts a number into an octal
open()	# Opens a file and returns a file object
ord()	# Convert an integer representing the Unicode of the specified character
pow()	# Returns the value of x to the power of y
print()	# Prints to the standard output device
property()	# Gets, sets, deletes a property
range()	# Returns a sequence of numbers, starting from 0 and increments by 1 (by default)
repr()	# Returns a readable version of an object
reversed()	# Returns a reversed iterator
round()	# Rounds a numbers
set()	# Returns a new set object
setattr()	# Sets an attribute (property/method) of an object
slice()	# Returns a slice object
sorted()	# Returns a sorted list
@staticmethod()	# Converts a method into a static method
str()	# Returns a string object
sum()	# Sums the items of an iterator
super()	# Returns an object that represents the parent class
tuple()	# Returns a tuple
type()	# Returns the type of an object
vars()	# Returns the __dict__ property of an object
zip()	# Returns an iterator, from two or more iterators
```

# Modules

## Importing Your Own Modules

File: my_module.py

```py
test_variable = "this is my module"

def square_num(num):
    return num ** 2
```

File: main_program.py

```py
# if the module is in the same directory you can import it directly
# Python uses sys.path, which is a list of directories that it looks into when we try to import modules
# this imports the entire file.
import my_module

# now we can use the function in the module
squared_number = my_module.square_num(4)
```

We can shorten this

```py
import my_module as mm

# now we can use mm so we don't have to type out the entire name
squared_number = mm.square_num(4)
```

We can also import specific functions

```py
# the drawback is that we will only have access to the square_num function and test variable
from my_module import square_num, test_variable

# now we can just use the function
squared_number = square_num(4)
```

# Standard Library

## Random

## Math

## DateTime

## Calendar

## CSV

## JSON

## OS

# PyODBC

Note: You might need to install a driver to use PyODBC. Google PyODBC and find the link to the instructions.

```py
import pyodbc   # import the library

# my price data
price_data = [[2.00, 3.00, 1.00, 2.00, 100.00, '1/2/2019'],
              [3.00, 1.00, 2.00, 5.00, 110.00, '1/5/2019'],
              [4.00, 3.00, 1.00, 2.00, 150.00, '1/8/2019']]

# Loop through all the drivers we have access to
for driver in pyodbc.drivers():
    print(driver)

# define the server name and the database name
server = 'DESKTOP-MXHSIOC\SQLEXPRESS'
database = 'database_name'

# define our connection string
cnxn = pyodbc.connect('DRIVER={ODBC DRIVER 17 for SQL Server}; \
                       SERVER=' + server + '; \
                       DATABASE=' + database +';\
                       Trusted_Connection=yes;')

# create the connection cursor
cursor = cnxn.cursor()

# define our insert query
# the question marks are necessary in pyodbc. they are placeholders
insert_query = '''INSERT INTO table_price_data ( close_price, high, low, open_price, volume, day_value)
                  VALUES (?, ?, ?, ?, ?, ?);'''

# loop through each row in the data we will be inserting
for row in price_data:
    # define the values to insert
    values = (row[0], row[1], row[2], row[3], row[4], row[5])

    # insert the data into the database
    cursor.execute(insert_query, values)

# commit the inserts
cnxn.commit()

# grab all the rows in our database
cursor.execute('SELECT * FROM table_price_data')

# loop through the results
for row in cursor:
    print(row)

# close the connection and remove the cursor
cursor.close()
cnxn.close()
```
