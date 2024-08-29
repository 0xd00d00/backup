#include <iostream>
#include <cstring>

using namespace std;

class Label
{
  char* text;
  std::size_t size;
  int* ref;

public:
  Label(const char* s) : ref(new int(1))
  {
    size = strlen(s);
    text = new char[size + 1];
    strcpy(text,  s);
  }

  Label(const Label& other) : text(other.text), size(other.size), ref(other.ref) {
    ++(*ref);
  }

  ~Label()
  {
    if (--(*ref) == 0)
    {
      delete ref;
      delete[] text;
    }
  }
  void print() const { std::cout << text << std::endl; }

  char& operator[](std::size_t index) {
        if (index < size)
            return text[index];
    }
};

int main()
{
  Label lb1("hello");
  Label lb2 = lb1;

  char c = lb1[0];
  lb1[0] = 'A';

  lb1.print();
  lb2.print();
}
