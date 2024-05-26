package main.combinatoric.complex;

import main.combinatoric.basic.CombObject;
import main.combinatoric.basic.InitialFilling;
import main.combinatoric.basic.NonRecursiveSearch;
import main.combinatoric.basic.RecursiveSearch;
import main.combinatoric.placements.PlacementWithRepeats;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Objects;

public class WordLong7TwoThreeElseDontRepeat extends CombObject<String>
        implements InitialFilling,
        RecursiveSearch,
        NonRecursiveSearch {

    private PlacementWithRepeats<String> placementWithRepeatsInstance;


    @Override
    public void nonRecursivePrintAllObjects() {
        initialFill();
        printObject();

        printWhileExistNextComb();
    }

    @Override
    public boolean genNextObj() {
        return checkConditionsAndSetCurrentObj();
    }

    @Override
    public void initialFill() {
        placementWithRepeatsInstance = new PlacementWithRepeats<>();
        placementWithRepeatsInstance.setK(7);
        placementWithRepeatsInstance.setAlphabet(getAlphabet());
        placementWithRepeatsInstance.setN(getAlphabet().length);
        placementWithRepeatsInstance.setCurrentObj(new String[7]);
        placementWithRepeatsInstance.initialFill();
        checkConditionsAndSetCurrentObj();
        setCurrentObj(placementWithRepeatsInstance.getCurrentObj());
    }

    private boolean checkConditionsAndSetCurrentObj() {
        while(true) {
            placementWithRepeatsInstance.genNextObj();
            String[] obj = placementWithRepeatsInstance.getCurrentObj();
            if (obj == null) {
                return false;
            }
            HashMap<String,Integer> alphabetToAmount = new HashMap<>();
            for (var item: getAlphabet()) {
                alphabetToAmount.put(
                        item,
                        (int) Arrays.stream(obj).filter((_item) -> _item.equals(item)).count()
                );
            }
            if (alphabetToAmount.values().stream().filter((item) -> item > 3).count() != 0) {
                continue;
            }
            if (alphabetToAmount.values().stream().filter((item) -> item == 3).count() != 1) {
                continue;
            }
            if (alphabetToAmount.values().stream().filter((item) -> item == 2).count() != 1) {
                continue;
            }
            if (alphabetToAmount.values().stream().filter((item) -> item == 1).count() != 2) {
                continue;
            }
            return true;
        }
    }

    @Override
    public void recursivePrintAllObjects() {
        initialFill();
        recursivePrintAllObjectsPrivate();
    }

    private void recursivePrintAllObjectsPrivate() {
        printObject();
        if (genNextObj()) {
            recursivePrintAllObjectsPrivate();
        }
    }
}
