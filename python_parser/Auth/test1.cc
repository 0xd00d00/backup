#include <iostream>
#include <cstring>

class Label {
    char* text;
    std::size_t size;
    int* ref;

public:
    Label(const char* s) :  ref(new int(1))
    {
        size = strlen(s);
        text = new char[size + 1];
        strcpy(text,s);
    }

    Label(const Label& other) : text(other.text), size(other.size), ref(other.ref) {
        ++(*ref);
    }

    ~Label() {
        if (--(*ref) == 0) {
            delete ref;
            delete[] text;
        }
    }

    char& operator[](std::size_t index) {
        if (index >= size) {
            throw std::out_of_range("Index out of bounds");
        }
        if (*ref > 1) {
            --(*ref); 
            ref = new int(1); 
            char* newText = new char[size + 1];
            strcpy(newText, text);
            text = newText; 
        }
        return text[index];
    }

    void print() const {
        std::cout << text << std::endl;
    }
};

int main() {
    Label lb1("hello");
    Label lb2 = lb1;

    char c = lb1[0];
    lb1[0] = 'A';

    lb1.print();
    lb2.print();

    return 0;
}
