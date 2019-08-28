# Falsey Values

These values will be coerced to false when evaluated in a boolean expression.

In JS there are 6 falsey values:

```js
0;

("");

null;

undefined;

false;

NaN;
```

All other values are truthy and are coerced to true

# Strings

```js
// concats arguments to the calling string, returns a new string.
String.concat('string1', 'stringN')

// determines if one string is in the calling string, returns true or false
String.includes('string')

// Returns the index within the calling String object of the first occurrence of the specified value, or -1 if not found.
String.indexOf('string')

// Returns the index within the calling String object of the last occurrence of the specified value, or -1 if not found.
String.lastIndexOf('string')

// Used to find a match between a regular expression and a string, and to replace the matched substring with a new substring.x
String.replace(regEx, 'replacement')

// Extracts section of calling string from beginIndex to endIndex (not included). If you use negative number, then it starts at the end of the string. Providing first arg only returns the string beginIndex to the end.
String.slice('beginIndex', 'endIndex')

// Splits a string into an array using separator to determine where to make each split. If arg is left empty, the entire string will be one item in the array
String.substring('separator')

// Converts string to all lower case letters
String.toLowerCase()

// Converts string to all lower case letters
String.toUpperCase()

// ESCAPE SEQUENCES
\'	single quote
\"	double quote
\\	backslash
\n	newline
\r	carriage return
\t	tab
\b	backspace
\f	form feed


```

# Arrays

```js
// Remember that arrays are objects, therefore they are passed by reference. To create a new array from another array:
let arr1 = [1, 2, 3];
let arr2 = [...arr1]; // creates new array
let arr2 = Array.from(arr1); // creates new array
let arr3 = [].concat(arr1); // creates new array


Array.findIndex()
Array.forEach()
Array.includes()
Array.indexOf()
Array.join()
Array.keys()
Array.pop()
Array.push()
Array.reverse()
Array.shift()
Array.slice()
Array.some()
Array.splice()
Array.toString()
Array.unshift()


Array.sort()
// By default, the sort() function sorts values as strings. This works well for strings ("Apple" comes before "Banana"). However, if numbers are sorted as strings, "25" is bigger than "100", because "2" is bigger than "1". Because of this, the sort() method will produce incorrect result when sorting numbers. You can fix this by providing a compare function:
var fruits = ["Banana", "Orange", "Apple", "Mango"];
// sort stings ascending
fruits.sort();
// use Array.reverse after sort to get descending order
fruits.reverse();

let points = [40, 100, 1, 5, 25, 10];
// numerical sort ascending
points.sort((a, b) => return a - b);
// numerical sort descending
points.sort((a, b) => return b - a);


Array.map()
// Use map over forEach a return is required map creates a newArray (mapArray in this case) based on the return. With forEach you wouldnt be creating a new array unless you are pushing to a new array.
const mapArray = someArray.map(num => num * 2);


Array.filter()
// filter this array, as you are going one by one filter those that are > than 5. If it returns true then it goes into the new array.
// A return is required.
const filterArray = someArray.filter(num => num > 5);


Array.reduce()
// Reduce take an accumulator and the number in the array. Accumulator stores the return from each iteration of the array. 5 is a second parameter that specifies where we want the accumulator to start from. At the end it returns the value of the accumulator.
const reduceArray = someArray.reduce((accumulator, num) => {
  return accumulator + num;
}, 5);
```

# Objects

Objects are collections of key-value pairs.

```js
const person = {
  name: 'Andrew',
  run: function() { some code; }, // function inside an object is known as a method
  walk() { some code; }           // new method syntax in ES6
};

//Accessing properties: Dot Notation and Bracket Notation
// Use brackets when you don't know the property you are searching for ahead of time.
person.name;
person['name'];


// creates a new object from an existing object.
Object.create(sourceObject)

// returns an array whose elements are arrays of the key-value pairs in the object.
Object.entries(object)

// transforms a list of key-value pairs into an object
// [ [age: 30], [name: Andrew] ]
Object.fromEntries(list)

// returns array of object's key names.
Object.keys(object)

// returns array of object's property values.
Object.values(object)
```

# Object Destructuring

Destructuring allows us to extract data from arrays, objects, maps and sets into their own variable.

```js
//Sometimes you need to make a variable from something that is inside of an object.

const address = {
  street: "Jacinto",
  city: "Long Beach",
  country: "United States"
};

//We access the properties within the object like this:
const street = address.street;
const city = address.city;
const country = address.country;

//What we could do instead of creating multiple variables, we destructure them in a single line. This is basically saying get the values of properties street, city, and country from the address object and store them in variables named street, city, and country.
const { street, city, country } = address;

// What if you want to name the variable something different? You can use an alias like so:
const { street: myStreet, city: myCity, country: myCountry } = address;

//What if the value you are trying to set does not exist? You will get undefined unless you set a default value. Default values kick in ONLY when the value is undefined. You can set default values like so:
const { street = "unknown", phone = "unknown" } = address;

console.log(street); // Jacinto
console.log(phone); //unknown
```

# Loops

```js
// FOR LOOP
for (initial expression; condition; incrementExpression) {
  statements
}
for (let i = 0; i < 10; i++) {
  some code;
}

// WHILE LOOP
while (condition) {
  statements;
}

// DO WHILE LOOP
// runs code before checking condition
do {
  statements
} while (condition);

// FOR IN LOOP
// iterates over keys
for (variable in object) {
  statements
}

// FOR OF LOOP
// iterates over values
for (variable of object) {
  statements
}

// BREAK
// breaks out of innermost loop
for (variable of object) {
  break;
}

// CONTINUE
// terminates the current loop iteration and continues the next iteration
for (variable of object) {
  continue;
}

// NOTE: In JavaScript, Objects are not iterable unless they implement the iterable protocol. Therefore, you cannot use for…of to iterate over the properties of an object. Instead you have to use Object.keys or Object.entries, to iterate over the properties or entries of an object.
```

# Iterators & Generators

In JavaScript, Objects are not iterable unless they implement the iterable protocol. Therefore, you cannot use for…of to iterate over the properties of an object. Instead you have to use Object.keys or Object.entries, to iterate over the properties or entries of an object.

# Functions

```js
// FUNCTION DECLARATION
function functionName(parameters){
  statements;
  return;
}


// FUNCTION EXPRESSION
// anonymous function
let functionName = function(parameters) {
  statements;
  return
};


// ARROW FUNCTIONS
// A cleaner, simpler way of writing functions in ES6

// Arrow Function Syntax
(param, param) => { some code; };

// The Old Way
const funcName = function(parameter) {
  return parameter + parameter;
}

// The New Way
const funcName = (parameter) => { return parameter + parameter; };

// But if you have ONLY ONE parameter you can omit the parenthesis
const funcName = parameter => { return parameter + parameter; };

// If the body of the function only includes a SINGLE LINE and a RETURN, we can simplify even further by omiting the curly braces, return keyword, and semi-colon.
const funcName = parameter => parameter + parameter;

// If you have no parameters, use empty parenthesis
const funcName = () => some code;



// DEFAULT PARAMETERS
// you can give parameters default values
function funcName(name='Andrew', age=33) {
    console.log(`My name is ${name}, I am ${age} years old.`);
}
// this will pass the default parameters to console.log
funcName();



// REST PARAMETERS
// collects all remaining elements into an array. Rest parameters have to be the last argument. This is because it collects all remaining/ excess arguments into an array.

// This function call returns 3, this is because in Javascript it is possible to call a function with any number of arguments. However, only the fist two arguments will be counted.
function add(x, y) { return x + y; }
add(1, 2, 3, 4, 5) // returns 3

// With rest parameters we can gather any number of arguments into an array and do what we want with them. So we can re-write the add function like this:
function add(...args) {
  let result = 0;
  for (let arg of args){
    result += arg;
  }
  return result
}
add(1,2) // returns 3
add(1, 2, 3, 4, 5) // returns 15

// We can separately define the first arguments, and the rest of the arguments in the function call (no matter how many they are) will be collected into an array by the rest parameter.
function xyz(x, y, ...z) {
  console.log(x, ' ', y);
  console.log(z);
  console.log(z[0]);
  console.log(z.length);
}
xyz("hey", "hello", "wassup", "goodmorning", "hi", "howdy")
// hey hello
// ["wassup", "goodmorning", "hi", "howdy"]
// wassup
// 4



// CURRYING
// the process of converting a function that takes multiple arguments into a function that takes the arguments one at a time.

const multiply = (a, b) => a * b;


// the curried version. think of it as a function within a function.
const curriedMultiply = (a) => (b) => a * b;

//to call it
curriedMultiply(3)(4); //would return 12

// if you only only supply one argument
// it would return a function
curriedMultiply(3); // would return (b) => 3*b;

// but why use this? it makes things more extensible.
//  you could use curriedMultiply() to create another function.

//new function that multiplies everything by 5.
// you are supplying the first argument for curriedMultiply
const newCurry = curriedMultiply(5);

//to call it
//no you are supplying the second argument to curried multiply
newCurry(6); // returns 30.



// COMPOSE
// is the act of putting two functions together to form a third function where the output of one function in the input of the other.

// parameters 'f' and 'g' return a function that takes parameter 'a'
// parameter 'a' returns function 'f' that takes a parameter, function 'g', which takes in parameter a.
const compose = (f,g) => (a) => f(g(a));

// now lets do something with it
const sum = (num) => num + 1;

// f is sum
// g is sum
// a is 5
// what happens when this runs?
// first, g(a) runs and returns 6
// the f(6) runs and returns 7
// so the result is 7
compose(sum, sum)(5);
```

# Spread Operator

The spread operator allows an iterable to expand in places where 0+ arguments are expected. Huh? Let's look at some examples:

```js

// Combining arrays
const array1 = [1, 2, 3];
const array2 = [4, 5, 6];

const array3 = array1.concat(array2);

//The above code works, but what if you wanted to add another element between the two arrays. The code would look a lot more complicated. Or we can use the spread operator to achieve this.

const array3 = [...array1, 'another element', ...array2];
>> [1, 2, 3, 'another element', 4, 5, 6]

// We can use it with the Math object
const maxNumber = Math.max(...array1);
>> 3

// We can create a new array from another array.
const newArray = array1;

// The above code creates a reference to the same array as array1. Any changes to newArray would be reflected in array1 as well. Instead we can use the spread operator to create a new array, seperate from the source array. This works because the value of array1 is spread into the new array as individual values and not as a reference of array1.
const newArray = [...array1];

// We can also use the spread operator to convert a string into an array.
const string1 = 'Hello';
const newArray = [...string1];
>> ['H', 'e', 'l', 'l', 'o']

// We can also use the spread operator on objects
const obj1 = { first: 'Andrew'};
const obj2 = { last: 'Martinez'};

const obj3 = { ...obj1, ...obj2, email: 'andrew@email.com' };
>> {first: 'Andrew', last: 'Martinez', email: 'andrew@email.com'}

// We can also use the spread operator to easily clone an object
const obj4 = { ...obj3 };
```

# Dates

```js
let event = new Date("December 17, 1995 03:24:00");
let event2 = new Date("1995-12-17T03:24:00");

// returns the number of milliseconds elapsed since January 1, 1970 00:00:00 UTC.
let event3 = Date.now();

// returns day of the month
Date.getDate();

// returns day of the week where 0 represents Sunday
Date.getDay();

// returns year of the specified date
Date.getFullYear();

// returns hour for the specified date
Date.getHours();

// returns milliseconds in the specified date
Date.getMilliseconds();

// returns minutes of specified date
Date.getMinutes();

// returns month of specified value. January = 0.
Date.getMonth();

// returns seconds in specified date
Date.getSeconds();

// returns milliseconds since Jan 1, 1970, 00:00:00.000 GMT
Date.getTime();

Date.setDate(); // day as a number (1-31)
Date.setFullYear(); // year (optionally month and day)
Date.setHours(); // hour (0-23)
Date.setMilliseconds(); // milliseconds (0-999)
Date.setMinutes(); // minutes (0-59)
Date.setMonth(); // month (0-11)
Date.setSeconds(); // seconds (0-59)
Date.setTime(); // milliseconds since 1970)
```

# Number()

```js
//Number() can be used to convert JavaScript variables to numbers:
Number(true); // returns 1
Number(false); // returns 0
Number("10"); // returns 10
Number("  10"); // returns 10
Number("10  "); // returns 10
Number(" 10  "); // returns 10
Number("10.33"); // returns 10.33
Number("10,33"); // returns NaN
Number("10 33"); // returns NaN
Number("John"); // returns NaN

let num = 3.141;
// returns string representing the number.
// x is optional. x is the number of digits after the decimal point.
// Default is 0 (no digits after the decimal point)
num.toFixed(x);

// returns string representing the number.
// formats a number to a specified length.
// x is optional. x is the number of digits. If omitted, it returns the entire number (without any formatting)
num.toPrecision(x);

// returns the primitive value of a number.
num.valueOf();

Number.MAX_VALUE; // largest possible JS number
Number.MIN_VALUE; // smallest possible JS number
Number.NEGATIVE_INFINITY; // -Infinity
Number.POSITIVE_INFINITY; // Infinity

parseFloat("10"); // 10
parseFloat("10.00"); // 10
parseFloat("10.33"); // 10.33
parseFloat("34 45 66"); // 34
parseFloat("   60   "); // 60
parseFloat("40 years"); // 40
parseFloat("He was 40"); // NaN

parseInt("10"); // 10
parseInt("10.00"); // 10
parseInt("10.33"); // 10
parseInt("34 45 66"); // 34
parseInt("   60   "); // 60
parseInt("40 years"); // 40
parseInt("He was 40"); // NaN
parseInt("10", 10); // 10
parseInt("010"); // 10
parseInt("10", 8); // 8
parseInt("0x10"); // 16
parseInt("10", 16); // 16
```

# Math

```js
var pi = Math.PI; // 3.141592653589793
Math.round(4.4); // = 4 - rounded
Math.round(4.5); // = 5
Math.pow(2, 8); // = 256 - 2 to the power of 8
Math.sqrt(49); // = 7 - square root
Math.abs(-3.14); // = 3.14 - absolute, positive value
Math.ceil(3.14); // = 4 - rounded up
Math.floor(3.99); // = 3 - rounded down
Math.sin(0); // = 0 - sine
Math.cos(Math.PI); // OTHERS: tan,atan,asin,acos,
Math.min(0, 3, -2, 2); // = -2 - the lowest value
Math.max(0, 3, -2, 2); // = 3 - the highest value
Math.log(1); // = 0 natural logarithm
Math.exp(1); // = 2.7182pow(E,x)
Math.random(); // random number between 0 and 1
Math.floor(Math.random() * 5) + 1; // random integer, from 1 to 5

Math.E; // returns Euler's number
Math.PI; // returns PI
Math.SQRT2; // returns the square root of 2
Math.SQRT1_2; // returns the square root of 1/2
Math.LN2; // returns the natural logarithm of 2
Math.LN10; // returns the natural logarithm of 10
Math.LOG2E; // returns base 2 logarithm of E
Math.LOG10E; // returns base 10 logarithm of E
```

# Classes

Often we need to represent an idea or concept in our programs — maybe a car engine, a computer file, a router, or a temperature reading. Representing these concepts directly in code comes in two parts: data to represent the state, and functions to represent the behavior. ES6 classes give us a convenient syntax for defining the state and behavior of objects that will represent our concepts.

```js
// We can use an object to represent a person.
const person = {
  name: "Andrew",
  walk() {
    console.log(this);
  }
};

// If we wanted to represent multiple people we could create multiple objects, but in this case we would be duplicating the walk method over and over. And if there was a bug in the walk method we would need to go into every person object and change the code.
const person = {
  name: "Jay",
  walk() {
    console.log(this);
  }
};

const person = {
  name: "Mike",
  walk() {
    console.log(this);
  }
};

// Instead, we can use classes to create a blueprint of a person and then create objects from that blueprint to represent different people.

// class name is capitalized
// The constructor's job is to initialize an instance to a valid state, and it will be called automatically so we can’t forget to initialize our objects.
class Person {
  constructor(name) {
    this.name = name;
  }
  walk() {
    console.log(this);
  }
}

// We create a person object with the 'new' operator and the Person class, passing in any parameters to the constructor function.
// Anytime an object is created from a class, it is called an instance of that class.
const person1 = new Person("Jessica");
```

# Inheritance

```js
class Person {
  constructor(name) {
    this.name = name;
  }
  walk() {
    console.log("walk");
  }
}

// The teacher class inherit the constructor properties and method from Person. Super is needed to initialize the constructor from Person.
class Teacher extends Person {
  constructor(name, degree) {
    super(name);
    this.degree = degree;
  }
  Teach() {
    console.log("teach");
  }
}

const teacher = new Teacher("Andrew", "Bachelors");
```

# The DOM

```js
// It is important to CACHE selectors in variables
let element = document.querySelector("#Id");

let element = document.getElementsByTagName("tag");
let element = document.getElementsByClassName("class");
let element = document.getElementById("id");

let element = document.querySelector("#id");
let element = document.querySelector(".class");
let element = document.querySelector("tag");

let element = document.querySelectorAll("#id");
let element = document.querySelectorAll(".class");
let element = document.querySelectorAll("tag");

// returns the DOM node's parent Element, or null if the node either has no parent, or its parent isn't a DOM Element.
let parentElement = node.parentElement;

// returns the parent of the specified node in the DOM tree.
let parentNode = node.parentNode;

// returns first child of the node or null
let childNode = node.firstChild;

// returns last child of the node or null
let childNode = node.lastChild;

// returns NodeList of child nodes of the given element
let nodeList = elementNodeReference.childNodes;

// returns the node immediately following the specified one in their parent's childNodes, or returns null if the specified node is the last child in the parent element.
let nextNode = node.nextSibling;

// returns the node immediately preceding the specified one in its parent's childNodes list, or null if the specified node is the first in that list.
let previousNode = node.previousSibling;

// returns the value of the attribute
element.getAttribute("elementAttribute");
// sets the value of the
element.setAttribute("attributeName", "attributeValue");
// returns true if attribute exists
element.hasAttribute("attributeName");
// removes the specified atrribute
element.removeAttribute("attributeName");

// set the value of a style property
element.style.CSSproperty = "value";

// Adds the specified class values. If these classes already exist in the element's class attribute they are ignored.
element.classList.add("ClassName1", "ClassNameN");

// Removes the specified class values.
element.classList.remove("ClassName1", "ClassNameN");

// Removes a given class from the list and returns false. If class doesn't exist it's added and the function returns true.
element.classList.toggle("class");

// returns an iterator for the classList to use with the 'for of' loop
element.classList.entries();

// calls the callback function once for each value pair in the list, in insertion order. listObj is the array that forEach is being applied to.
element.classList.forEach((currValue, currIndex, listObj) => {
  console.log(currValue, currIndex);
});

// returns an iterator of all the keys contained in the object
element.classList.keys();

// returns an iterator of all the key value pairs in the object
element.classList.values();

// returns true is the list contains the given class
element.classList.contains("className");

// returns true if replaced successfully
element.classList.replace("oldClass", "newClass");

// returns the new element
let newElement = document.createElement("htmlTag");

// returns text node object
let newTextNode = document.createTextNode("data");

// appends a node as the last child of a node
newElement.appendChild(newTextNode);

// append at the beginning of the node
newElement.insertBefore(newTextNode, newElement.childNodes[0]);

// Get HTML content
var html = elem.innerHTML;

// Set HTML content. Replaces all the content.
elem.innerHTML =
  'We can dynamically change the HTML. We can even include HTML elements like <a href="#">this link</a>.';

// Add HTML to the end of an element's existing content
elem.innerHTML += " Add this after what is already there.";

// Add HTML to the beginning of an element's existing content
elem.innerHTML = "We can add this to the beginning. " + elem.innerHTML;

// Get text content
var text = elem.textContent;

// Set text content
elem.textContent = "We can dynamically change the content.";

// Add text to the end of an element's existing content
elem.textContent += " Add this after what is already there.";

// Add text to the beginning of an element's existing content
elem.textContent = "We can add this to the beginning. " + elem.textContent;

// innerHTML vs textContent vs innerText vs nodeValue
innerHTML; // parses content as HTML, so it takes longer.
nodeValue; // uses straight text, does not parse HTML, and is faster.
textContent; // uses straight text, does not parse HTML, and is faster.
innerText; // takes styles into consideration. It won't get hidden text for instance.
```

# JSON

## Data types that can be used with JSON

- Number: no difference between integer and float
- String: string of Unicode characters. Use "DOUBLE" quotes
- Boolean: true or false
- Array: ordered list of 0 or more values
- Object: unordered collection of key/value pairs
- Null: empty value

## Syntax Rules

- Uses key/value pairs - {"name" : "Andrew"}
- Uses double quotes around key and value
- Must use data types specified above
- File type is ".json"
- MIME type is "Application/json"

## JSON Example

```js
let person = {
  Name: "Andrew Martinez",
  Age: 30,
  Address: {
    Street: "4100 Road St.",
    City: "Los Angeles"
  },
  Children: ["Ethan", "Anya"]
};

// turns JS object into a properly formatted JSON object
let jsonObject = JSON.stringify(person);

// turns a JSON object into a JS object
let jsObject = JSON.parse(jsonObject);
```

## JSON file

remember: file type is .json
File: people.json

```json
{
  "people": [
    {
      "Name": "Andrew",
      "Age": 30
    },
    {
      "Name": "Jessica",
      "Age": 31
    },
    {
      "Name": "Jorge",
      "Age": 32
    }
  ]
}
```

## Making a Request to a JSON File

```js
let xhttp = new XMLHttpRequest();
xhttp.onreadystatechange = function() {
  if ((this.readyState = 4 && this.status == 200)) {
    // the response is stored in xhttp.responseText
    // we use JSON.parse() to turn the JSON object into a JS object we can work with.
    let response = JSON.parse(xhttp.responseText);

    // Your code here. Do whatever you want with the data
    console.log(response);
  }
};

// we want to make a GET request to a specific json file and send the request
xhttp.open("GET", "jsonFileURL.json", true);
xhttp.send();
```

# AJAX

## What is Ajax?

- Asynchronous JavaScript And XML
- It is a set of technologies to send and receive data from a client to a server asynchronously
- Does not interfere with the current web page
- JSON has replaced XML for the most part

## XmlHttpRequest (XHR) Object

- API in the form of an object, meaning it has properties and methods
- Provided by the browser's JS environment
- Methods transfer data between client and server
- Can be used with protocols other than HTTP
- Can work with data other than XML (JSON, plain text)

## Libraries and Other Methods to Make Ajax Calls

- jQuery
- Axios
- Superagent
- Fetch API
- Prototype
- Node HTTP

## Example 1: Ajax Reuest to a Text File

```HTML
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Ajax Request to Text File</title>
</head>
<body>
  <button id="button">Get Text File</button>
  <p id="text"></p>

  <script>
    // create event listener
    document.querySelector('#button').addEventListener('click', loadText);

    function loadText() {
      // Create XHR object
      let xhr = new XMLHttpRequest();

      // OPEN - type, url/file name, async
      xhr.open("GET", 'sample.txt', true);

      // this runs at ReadyState 3. It is optional, but can be used for loader, like the rainbow wheel.
      xhr.onprogress = function () {
        console.log('loading...')
      }

      // we an also use xhr.onreadystatechange but then you have to check that this.readyState == 4 && this.status == 200
      xhr.onload = function () {
        // check that the response status is 'OK' before we do anything else.
        if (this.status == 200) {
          // responseText is where the response is stored. In this case, the text in the file.
          document.querySelector('#text').innerHTML = this.responseText;
        }
      }

      // if you are using onload, you can use xhr.onerror to catch errors
      xhr.onerror = function () {
        console.log('Request error...')
      }

      // we need to send to get anything back
      xhr.send();
    }
  </script>
</body>
</html>
```

## Example 2 - Ajax request to a local JSON file

---

```HTML
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Ajax Request to Local JSON File</title>
</head>
<body>
  <button id="button1">Get User</button>
  <button id="button2">Get Users</button>
  <br />
  <br />
  <h1>User</h1>
  <div id="user"></div>
  <h1>Users</h1>
  <div id="users"></div>

  <script>
    document.querySelector('#button1').addEventListener('click', loadUser);

    document.querySelector('#button2').addEventListener('click', loadUsers);

    function loadUser() {
      let xhr = new XMLHttpRequest();
      xhr.open('GET', 'user.json', true)
      xhr.onload = function () {
        if (this.status == 200) {
          let user = JSON.parse(this.responseText);
          let output = `
          <ul>
            <li>Id: ${user.id}</li>
            <li>Name: ${user.name}</li>
            <li>Email: ${user.email}</li>
          <ul>`;
          document.querySelector('#user').innerHTML = output;
        }
      }
      xhr.send();
    }
    function loadUsers() {
      let xhr = new XMLHttpRequest();
      xhr.open('GET', 'users.json', true)
      xhr.onload = function () {
        if (this.status == 200) {
          let users = JSON.parse(this.responseText);
          let output = '';

          for (let i in users) {
            output += `<ul>
            <li>Id: ${users[i].id}</li>
            <li>Name: ${users[i].name}</li>
            <li>Email: ${users[i].email}</li></ul>`;
          }

          document.querySelector('#users').innerHTML = output;
        }
      }
      xhr.send();
    }
  </script>
</body>
</html>
```

## Example 3 - Ajax request to external API

```HTML
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Ajax Request to External API</title>
</head>
<body>
  <button id="button">Load Github Users</button>
  <br /><br />
  <h1>Github Users</h1>
  <div id="users"></div>

  <script>
    document.querySelector('#button').addEventListener('click', loadUsers);

    function loadUsers() {
      let xhr = new XMLHttpRequest();

      xhr.open('GET', 'https://api.github.com/users', true);

      xhr.onload = function () {
        if (this.status == 200) {
          let users = JSON.parse(this.responseText);
          let output = '';
          for (var i in users) {
            output += `
              <div>
                <img src="${ users[i].avatar_url}  width="70" height="70">
                <ul>
                  <li>Id: ${ users[i].id} </li>
                  <li>Id: ${ users[i].login} </li>
                </ul>
              </div>`;
          }
          document.querySelector('#users').innerHTML = output;
        }
      }
      xhr.send();
    }
  </script>
</body>
</html>
```

# Fetch API
