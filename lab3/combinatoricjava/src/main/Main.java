package main;

import main.combinatoric.basic.printers.ConsolePrinter;
import main.combinatoric.basic.printers.FilePrinter;
import main.combinatoric.complex.WordLong5TwoAElseDontRepeat;
import main.combinatoric.complex.WordLong7TwoThreeElseDontRepeat;
import main.combinatoric.subset.Subset;

import java.io.IOException;

public class Main {
    public static void main(String[] args) throws IOException {
//        Subset<String> subset = new Subset<>();
//        String[] alphabet = {"a","b","c"};
//        subset.setAlphabet(alphabet);
//        subset.setPrinter(new FilePrinter("./files/subset.txt"));
//
//        subset.recursivePrintAllObjects();
//
//        WordLong5TwoAElseDontRepeat word1 = new WordLong5TwoAElseDontRepeat();
//        String[] alphabet1 = {"a","b","c","d"};
//        word1.setAlphabet(alphabet1);
//        word1.setPrinter(new FilePrinter("./files/comb6.txt"));
//
//        word1.nonRecursivePrintAllObjects();

        WordLong7TwoThreeElseDontRepeat word2 = new WordLong7TwoThreeElseDontRepeat();
        String[] alphabet2 = {"a","b","c","d"};
        word2.setAlphabet(alphabet2);
//        word2.setPrinter(new ConsolePrinter());
        word2.setPrinter(new FilePrinter("./files/comb9.txt"));

        word2.nonRecursivePrintAllObjects();
    }
}