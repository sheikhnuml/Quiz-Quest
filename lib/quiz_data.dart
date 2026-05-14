class QuizData {
  static const Map<String, List<Map<String, dynamic>>> questions = {
    'Maths': [
      {'question': 'What is 5 + 7?', 'options': ['10', '11', '12', '13'], 'answer': 2},
      {'question': 'Square root of 64?', 'options': ['6', '7', '8', '9'], 'answer': 2},
      {'question': '12 multiplied by 8?', 'options': ['86', '96', '106', '76'], 'answer': 1},
      {'question': 'Value of pi (approx)?', 'options': ['3.14', '2.14', '4.14', '1.14'], 'answer': 0},
      {'question': 'Sides of a hexagon?', 'options': ['5', '6', '7', '8'], 'answer': 1},
      {'question': '100 divided by 4?', 'options': ['20', '25', '30', '40'], 'answer': 1},
      {'question': 'Which is a prime number?', 'options': ['4', '9', '11', '15'], 'answer': 2},
      {'question': '15% of 200?', 'options': ['20', '30', '40', '50'], 'answer': 1},
      {'question': 'If x + 5 = 12, what is x?', 'options': ['5', '6', '7', '8'], 'answer': 2},
      {'question': '2 to the power of 5?', 'options': ['16', '32', '64', '128'], 'answer': 1},
    ],
    'Computer': [
      {'question': 'Father of Computer?', 'options': ['Bill Gates', 'Charles Babbage', 'Elon Musk', 'Steve Jobs'], 'answer': 1},
      {'question': 'RAM stands for?', 'options': ['Read Access', 'Random Access', 'Run Any', 'Real Access'], 'answer': 1},
      {'question': '1 Byte = ? bits', 'options': ['4', '8', '16', '32'], 'answer': 1},
      {'question': 'Input device?', 'options': ['Monitor', 'Printer', 'Speaker', 'Keyboard'], 'answer': 3},
      {'question': 'Brain of computer?', 'options': ['RAM', 'HDD', 'CPU', 'Monitor'], 'answer': 2},
      {'question': 'Flutter file extension?', 'options': ['.java', '.cpp', '.dart', '.kt'], 'answer': 2},
      {'question': 'Permanent storage?', 'options': ['RAM', 'Hard Drive', 'Cache', 'Registers'], 'answer': 1},
      {'question': 'HTTP stands for?', 'options': ['HyperText Transfer', 'High Transfer', 'Hyper Tool', 'None'], 'answer': 0},
      {'question': 'Shortcut for Copy?', 'options': ['Ctrl+V', 'Ctrl+X', 'Ctrl+C', 'Ctrl+Z'], 'answer': 2},
      {'question': 'Main page of a website?', 'options': ['Last', 'Link', 'Home', 'Web'], 'answer': 2},
    ],
    'English': [
      {'question': 'Opposite of "Happy"?', 'options': ['Joyful', 'Sad', 'Excited', 'Angry'], 'answer': 1},
      {'question': 'Plural of "Child"?', 'options': ['Childs', 'Children', 'Childrens', 'Childes'], 'answer': 1},
      {'question': 'Which is a vowel?', 'options': ['B', 'D', 'E', 'F'], 'answer': 2},
      {'question': 'Past tense of "Go"?', 'options': ['Gone', 'Going', 'Went', 'Goes'], 'answer': 2},
      {'question': 'Synonym of "Fast"?', 'options': ['Slow', 'Quick', 'Heavy', 'Small'], 'answer': 1},
      {'question': 'Correct spelling?', 'options': ['Receive', 'Recieve', 'Receve', 'Recive'], 'answer': 0},
      {'question': 'Writes books?', 'options': ['Actor', 'Author', 'Artist', 'Engineer'], 'answer': 1},
      {'question': 'Verb in: "Cat runs fast."', 'options': ['The', 'Cat', 'Runs', 'Fast'], 'answer': 2},
      {'question': 'Opposite of "Tall"?', 'options': ['Big', 'Short', 'Thin', 'Wide'], 'answer': 1},
      {'question': 'She is _____ honest girl.', 'options': ['A', 'An', 'The', 'No'], 'answer': 1},
    ],
    'Urdu': [
      {
        'question': 'پاکستان کا قومی پرندہ کون سا ہے؟',
        'options': ['طوطا', 'چکور', 'شاہین', 'کبوتر'],
        'answer': 1
      },
      {
        'question': 'علامہ اقبال کی جائے پیدائش کون سی ہے؟',
        'options': ['لاہور', 'کراچی', 'سیالکوٹ', 'اسلام آباد'],
        'answer': 2
      },
      {
        'question': 'پاکستان کب معرضِ وجود میں آیا؟',
        'options': ['1940', '1947', '1948', '1950'],
        'answer': 1
      },
      {
        'question': '"علم" کا متضاد لفظ کیا ہے؟',
        'options': ['جہل', 'عالم', 'کتاب', 'استاد'],
        'answer': 0
      },
      {
        'question': '"کتاب" کی جمع کیا ہے؟',
        'options': ['کتابوں', 'کتابیں', 'کتب', 'کوئی نہیں'],
        'answer': 2
      },
      {
        'question': 'پاکستان کا قومی پھول کون سا ہے؟',
        'options': ['گلاب', 'چمیلی', 'سورج مکھی', 'کنول'],
        'answer': 1
      },
      {
        'question': 'اردو کے حروفِ تہجی کی تعداد کتنی ہے؟',
        'options': ['30', '35', '39', '45'],
        'answer': 2
      },
      {
        'question': '"دن" کا متضاد لفظ کیا ہے؟',
        'options': ['صبح', 'شام', 'رات', 'دوپہر'],
        'answer': 2
      },
      {
        'question': 'لفظ "اردو" کس زبان کا لفظ ہے؟',
        'options': ['عربی', 'فارسی', 'ترکی', 'ہندی'],
        'answer': 2
      },
      {
        'question': 'پاکستان کا قومی کھیل کون سا ہے؟',
        'options': ['کرکٹ', 'فٹ بال', 'ہاکی', 'سکواش'],
        'answer': 2
      },
    ],
  };
}