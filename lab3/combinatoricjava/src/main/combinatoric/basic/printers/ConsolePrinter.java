package main.combinatoric.basic.printers;

import main.combinatoric.basic.CombObject;
import java.util.Arrays;

public final class ConsolePrinter implements CombObjPrinter {

    @Override
    public void printCombObj(CombObject<?> combObj) {
        System.out.println(Arrays.toString(combObj.getCurrentObj()));
    }
}