#include <bits/stdc++.h>
using namespace std;

class RecursiveDescentParser {
public:
    RecursiveDescentParser() {
        pointer = 0;
        errorFlag = 0;
    }

    bool startTopDownParser(string s) {
        input = s;
        S();  // Start parsing from the S non-terminal
        if (pointer == s.size() && errorFlag == 0) return true;
        else return false;
    }

private:
    string input;
    int pointer;
    int errorFlag;

    // Helper function to print parsing steps
    void print(string a, string b) {
        if (pointer < input.length()) cout << "( " << input[pointer];
        else cout << "( @";
        cout << ", " << a << " -> " << b << " )" << endl;
    }

    void S() {
        cout << "in S\n";
        if (input[pointer] == 'n') {
            pointer++;
            print("S", "nB");
            B();
        }
        //else errorFlag = 1;
    }

    void B() {
        cout << "in B\n";
        if (input[pointer] == 'n') {
            pointer++;
            print("B", "nBAB");
            B();
            A();
            B();
        } 
    }

    void A() {
        cout << "in A\n";
        if (input[pointer] == '+' || input[pointer] == '*') {
            print("A", string(1, input[pointer]));
            pointer++;
        } 
        else errorFlag = true;
    }
};

int main() {
    ifstream inputFile("input3.txt");
    string inputStatement;
    getline(inputFile, inputStatement);
    cout << "Input string: " << inputStatement << endl;
    RecursiveDescentParser topDownParser;
    bool check = topDownParser.startTopDownParser(inputStatement);
    if (check) cout << "Accepted" << endl;
    else cout << "Rejected" << endl;
    return 0;
}