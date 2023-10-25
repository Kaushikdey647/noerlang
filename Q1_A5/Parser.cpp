#include<bits/stdc++.h>
#include</home/amit/Sem7/Compiler_Design/20CS01035_Amit_Kumar_Pandit_5/Q1_A5/lex.h>
using namespace std;

string myText;

class Grammer{
   public:
   string start_symbol;
   vector<string> non_terminals;
   vector<string> terminals;
   map<string, vector<string>> rules;

   Grammer()
    {
    }

   void input_Grammer(string filename)
    {
        // input format
        // non_terminals - number of non-terminals followed by each non-terminal
        // terminals - number of terminals followed by each terminal
        // rules - number of rules followed by each rule

        string myText;

        // Read from the text file
        ifstream MyReadFile(filename);

        int terms, non_terms, rule_count;
        string temp_term, temp_non_term, prod_rule, non_term, rules_rhs;
        string produces = "->";
        char del = '|';

        getline(MyReadFile, myText);
        start_symbol = myText;
        

        getline(MyReadFile, myText);
        non_terms = stoi(myText);
       
        for (int i = 0; i < non_terms; i++)
        {
            getline(MyReadFile, myText);
            temp_non_term = myText;
            non_terminals.push_back(temp_non_term);
        }

        getline(MyReadFile, myText);

        terms = stoi(myText);
        for (int i = 0; i < terms; i++)
        {
            getline(MyReadFile, myText);
            temp_term = myText;
            terminals.push_back(temp_term);
        }
        getline(MyReadFile, myText);
     
        rule_count = stoi(myText);
        for (int i = 0; i < rule_count; i++)
        {
            getline(MyReadFile, myText);
            prod_rule = myText;
            int id = prod_rule.find(produces);

            vector<string> prod_rules;

            if (id != string ::npos)
            {
                non_term = prod_rule.substr(0, id);
                rules_rhs = prod_rule.substr(id + 2);
                stringstream ss(rules_rhs);
                string word;
                while (!ss.eof())
                {
                    getline(ss, word, del);
                    prod_rules.push_back(word);
                }
            }
            else
            {
                cout << "Error with production rules" << endl;
                return;
            }
            rules[non_term] = prod_rules;
        }
       
        MyReadFile.close();
    }
    


};
class Sets{

    public:
    map<string, set<string>> first_sets;
    map<string, set<string>> follow_sets;

    Sets(){

    }

    void input_sets(string filename){
        ifstream MyReadFile(filename);
        
        getline(MyReadFile,myText);
        if (myText=="First Sets")
       

        getline(MyReadFile,myText);
        int no_of_first_sets=stoi(myText);

        for(int i=0;i<no_of_first_sets;i++){
           getline(MyReadFile,myText);
           string first_set=myText;
           for(int j=1;j<first_set.size();j++){
            if (first_set[j]!='{' && first_set[j]!='}' && first_set[j]!=':' && first_set[j]!=' '){
                if (first_set[j]==',' && first_set[j-1]!=',')
                continue;
                string temp="";
                temp+=first_set[0];
                string temp1;
                temp1+=first_set[j];
                first_sets[temp].insert(temp1);
            }
           }
        
        }

        getline(MyReadFile,myText);
        if (myText=="Follow Sets")
        
         getline(MyReadFile,myText);
        int no_of_follow_sets=stoi(myText);

        for(int i=0;i<no_of_follow_sets;i++){
           getline(MyReadFile,myText);
           string follow_set=myText;
           for(int j=1;j<follow_set.size();j++){
            if (follow_set[j]!='{' && follow_set[j]!='}' && follow_set[j]!=':' && follow_set[j]!=' '){
                if (follow_set[j]==',' && follow_set[j-1]!=',')
                continue;
               string temp="";
                temp+=follow_set[0];
                string temp1;
                temp1+=follow_set[j];
                follow_sets[temp].insert(temp1);
            }
           }
        
        }

        MyReadFile.close();




    }
};

void build_index_maps(Grammer grammer,map<string,int> &row_index_map,map<string,int> &col_index_map){

  for(int i=0;i<grammer.terminals.size();i++){
       col_index_map.insert(make_pair(grammer.terminals[i],i));
   }
   col_index_map.insert(make_pair("$",grammer.terminals.size()));
   for(int i=0;i<grammer.non_terminals.size();i++){
       row_index_map.insert(make_pair(grammer.non_terminals[i],i));
   }

}

set<string> get_first_set_of_rule(string str,map<string, set<string>> first_sets)
    {
        set<string> result, temp;
        string temp_str = "";
        bool non_epsilon_symbol = false;

        int j = 0;
        while (j < str.length())
        {
            string temp_str = "";
            temp_str += str[j];
            temp = first_sets[temp_str];
            if (temp.find("#") != temp.end())
            {
                for (auto it = temp.begin(); it != temp.end(); ++it)
                {
                    if ((*it) != "#")
                    {
                        result.insert((*it));
                    }
                }
            }
            else
            {
                result.insert(temp.begin(), temp.end());
                non_epsilon_symbol = true;
                break;
            }
            j++;
        }
        if (!non_epsilon_symbol)
        {
            result.insert("#");
        }

        return result;
    }
vector<vector<string>> build_parsing_table(Grammer &grammer,map<string, set<string>> first_sets,map<string, set<string>> follow_sets, map<string,int> &row_index_map,map<string,int> &col_index_map){
    vector<vector<string>> table(grammer.non_terminals.size(), vector<string>(grammer.terminals.size() + 1, ""));

        for (auto it = grammer.rules.begin(); it != grammer.rules.end(); ++it)
        {

            string non_term = it->first;

            for (auto it2 = 0; it2 < it->second.size(); ++it2)
            {
                string rule = it->second[it2];

                string first_symbol_in_rule = "";
                first_symbol_in_rule += rule[0];

                set<string> first_temp = get_first_set_of_rule(rule,first_sets);
                set<string> follow_temp = follow_sets[non_term];
                string temp_str = rule;

                for (auto it3 = first_temp.begin(); it3 != first_temp.end(); ++it3)
                {

                    if ((*it3) != "#")
                    {
                        table[row_index_map[non_term]][col_index_map[*it3]] = temp_str;
                    }
                    else
                    {
                        for (auto it4 = follow_temp.begin(); it4 != follow_temp.end(); ++it4)
                        {
                            table[row_index_map[non_term]][col_index_map[*it4]] = temp_str;
                        }
                    }
                }
            }
        }

        return table;
}
void print_parsing_table(string filename,Grammer &grammer,vector<vector<string>> &parsing_table)
    {
        ofstream MyFile(filename);
        MyFile << endl;
        MyFile << "\t|";
        for (int i = 0; i < grammer.terminals.size(); ++i)
        {
            MyFile << grammer.terminals[i] << "\t|";
        }
        MyFile << "$" << endl;
        for (int i = 0; i < parsing_table.size(); ++i)
        {
            MyFile << grammer.non_terminals[i] << "\t|";
            for (int j = 0; j < parsing_table[i].size(); ++j)
            {

                MyFile << parsing_table[i][j] << "\t|";
            }

            MyFile << endl;
        }
    }
void parse_input(string tokenized_input,Grammer &grammer, map<string,int> &row_index_map,map<string,int> &col_index_map,vector<vector<string>> &parsing_table)
    {
        
       
        stack<string> st;

        st.push("$");
        string start_symbol = grammer.start_symbol;
        st.push(start_symbol);

        bool flag = true;

        while (!(st.top() == "$" && tokenized_input == "$"))
        {

            string st_top = st.top();
            string lookahead = "";
            lookahead += tokenized_input[0];

            if (st_top == lookahead)
            {
                st.pop();
                tokenized_input.erase(tokenized_input.begin());
            }
            else
            {
                int r_ind = row_index_map[st_top];
                int c_ind = col_index_map[lookahead];

                string rule_to_be_applied = parsing_table[r_ind][c_ind];

                if (rule_to_be_applied == "")
                {
                    cout << "ERROR: Invalid rule search [" << st_top << "," << lookahead << "]" << endl;
                    cout << "Current state of unconsumed input is " << tokenized_input << endl;
                    cout << "Rejected !" << endl;
                    flag = false;
                    break;
                }

                st.pop();
                if (rule_to_be_applied != "#")
                {

                    for (int j = rule_to_be_applied.size() - 1; j >= 0; j--)
                    {
                        string temp = "";
                        temp += rule_to_be_applied[j];
                        st.push(temp);
                    }
                }
            }
        }

        if (flag)
        {
            cout<<"Accepted"<<endl;
        }
        
        return ;
    }
int main(){

   Grammer grammer= Grammer();

   grammer.input_Grammer("grammerLL.txt");
   Sets sets = Sets();
   sets.input_sets("First-Follow.txt");

   
   map<string,int> row_index_map;
   map<string,int> col_index_map;
   build_index_maps(grammer,row_index_map,col_index_map);
   vector<vector<string>> parsing_table=
   build_parsing_table(grammer,sets.first_sets,sets.follow_sets,row_index_map,col_index_map);
   print_parsing_table("parsing_table.txt",grammer,parsing_table);

   char filename[] = "input.txt";
   string input;
   get_string(filename, input);

   if (input == "ERROR$")
    {
        cout << "Rejected" << endl;
    }
    
    else
    {
        parse_input(input,grammer,row_index_map,col_index_map,parsing_table);
    }

    return 0;

   


   




}