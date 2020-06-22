//gg
//hh
#include <iostream> 
#include <cstring>
#include <string>
#include <vector>
#include <stdexcept>

#define N 100
using namespace std;

int k=0;															// Variables to control the general loops
int l=0;

int score, totalscore;
string inputword;

int m, np;
struct Player {
	
	vector<string> v;
	string name;
	string WordList;
	int score1;
	vector<int> sc;
 	
};

void WordListScore()
{		
	if (inputword.size()==3  || inputword.size()==4)
		score=1;
	
	else if (inputword.size()==5)
		score=2;
			
	else if (inputword.size()==6)
		score=3;
	
	else if  (inputword.size()==7)
		score=5;
	
	else if  (inputword.size()>=8)
		score=11;
	
	else 
		score =0;	
}

void MultiplayerScore()
{
	cout<< "Type the number of Boggle Players: ";
	
	    try {														// Command to exit routine when there is an invalid input
        cin >> np;
        if (cin.fail()) throw runtime_error("It is not a valid input\n");
     
	    } catch (const runtime_error& e) {
	      cout << e.what();
	      exit(1);
    	}
	
	Player player1[N];												// Defining an array in the Struct for the players
	for (m=0; m<np; ++m)											// This task will be repeated as per the number of players
	{
		cout <<'\n'<< "Type the name of the player N° "<< m <<": ";							
		cin >> player1[m].name;										// Storing the names given in the Struct
		int j=0;
		while (j==0)												// Routine to write boggle words up to the user stops it
		{	
			cout <<player1[m].name<< ", type your Boggle Word: ";
			cin >> player1[m].WordList;								// Assigning the word written to a string variable (Part of the struct)
			player1[m].v.push_back (player1[m].WordList);			// Storing the word written in a vector
			
			cout << "Type [0] for next word or [1] to end: ";		// It asks to the user to continue or to end this routine
			cin>> j;	
		}
		
		cout <<'\n'<< "This is "<<player1[m].name<<"'s Word List:"<<endl;
		for (int i = 0; i < player1[m].v.size(); ++i)				// In this loop it is read all the words from the list which was stored in the vector
	    {
	   	  
	      cout << player1[m].v[i]<< '\n';							// Printing the Word List
	      inputword.assign (player1[m].v[i]);						// Assigning each word from the list to a single string to compute its score
	      WordListScore();											// Computing the score of the word
	      player1[m].score1 = score;								// Assigning the score computed in the function to the struct score
	      player1[m].sc.push_back (player1[m].score1);				// Storing in a vector the score previously computed
	    }
	}
	
	// Finding repeated words by comparing every list from each player
	for (int x=0; x<np; ++x)   										// Loops for comparing and finding repeated words in the lists to assign zero as score
	{																// x and y for varying the players. a and b for varying the words from the list for each player
		for (int y = x+1; y<np; ++y) 
		{
		   	for (int a = 0; a < player1[x].v.size(); ++a) 
		   	{
		   		for (int b = 0; b < player1[y].v.size(); ++b) 
			   	{
			   		if (player1[x].v[a] == player1[y].v[b])			// Evaluating if it is found the same word in different lists
			   		{
			   		player1[x].sc[a]=0;								// Assigning score zero to the repeated word
			   		player1[y].sc[b]=0;								// Assigning score zero to the repeated word
			   		cout<<'\n'<<"Repeated words which will recieve zero points:"<<endl;
			   		cout<<player1[x].name<<"'s word: "<<player1[x].v[a]<<", and "<<player1[y].name<<"'s word: "<<player1[y].v[b]<<endl;
					}
				}
			}
	   }
	}
	
	for (int x=0; x<np; ++x)   										// Loops for comparing and finding repeated words in the lists to assign zero as score
	{																
		   	for (int a = 0; a < player1[x].v.size(); ++a) 
		   	{
		   		for (int b = a+1; b < player1[x].v.size(); ++b) 
			   	{
			   		if (player1[x].v[a] == player1[x].v[b])			// Evaluating if it is found the same word in different lists
			   		{
			   		player1[x].sc[a]=0;								// Assigning score zero to the repeated word
			 
			   		cout<<'\n'<<"Only one of the repeated words will be considered:"<<endl;
			   		cout<<player1[x].name<<"'s word: "<<player1[x].v[a]<<endl;
					}
				}
			}
	}
	
	// Printing the final lists for each player
	for (m=0; m<np; ++m)											// This task will be repeated as per the number of players
	{
	cout <<'\n'<< "This is "<<player1[m].name<<"'s final Word List with scores:"<<endl;
		for (int i = 0; i < player1[m].v.size(); ++i)				// In this loop it is read all the words from the list which was stored in the vector
		{
		      cout << player1[m].v[i]<<", score: "<<player1[m].sc[i]<<'\n';	// Printing the Word List with score
		      totalscore += player1[m].sc[i];						// Calculating the final score for each player
		}
	cout <<player1[m].name<<"'s total score is: "<<totalscore<<'\n';
	totalscore=0;
	}
}

int main() 
{ 
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////  FIRST PART: Word List Score function  ///////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	cout << "PART 1.1"<<endl;
	while (k==0)
	{
	cout << "Type your Boggle Word: ";
	cin >> inputword;	
	WordListScore();													// Function to accepts a list of words and computes the score according to the Boggle's rules
	cout << "The score of this word is: "<<score<<endl;
	cout <<'\n'<< "Type [0] for next word or another number to end: "<<endl;
	
		try {															// Command to exit routine when there is an invalid input
        cin >> k;
        if (cin.fail()) throw runtime_error("It is not a valid input\n");
     
	    } catch (const runtime_error& e) {
	      cout << e.what();
	      exit(1);
    	}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////  FIRST PART: Multiplayer Score function  /////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	cout <<'\n'<< "PART 1.2"<<endl;
	while (l==0)
	{
	MultiplayerScore();													// Function to accepts several lists of words for each player and with their respective score
	cout <<'\n'<< "Type [0] to play again or another number to end: "<<endl;
	
		try {															// Command to exit routine when there is an invalid input
        cin >> l;
        if (cin.fail()) throw runtime_error("It is not a valid input\n");
     
	    } catch (const runtime_error& e) {
	      cout << e.what();
	      exit(1);
    	}
	}
	
return 0;
}
/*TEST(FunctionTest, MultiScoreFunctionValidation) {
	np = 2;
	Player player1[N];

	player1[0].name = "Cesar";
	player1[0].WordList = "hello";

	player1[1].name = "Inga";
	player1[1].WordList = "hello";

	MultiplayerScore();
	EXPECT_EQ(5, player1[1].WordList.size());
	EXPECT_TRUE(true);

}*/

