package main.combinatoric.complex;

import main.combinatoric.basic.CombObject;
import main.combinatoric.basic.InitialFilling;
import main.combinatoric.basic.NonRecursiveSearch;
import main.combinatoric.basic.RecursiveSearch;
import main.combinatoric.placements.PlacementWithRepeats;

import java.util.Arrays;
import java.util.Objects;

public class WordLong5TwoAElseDontRepeat extends CombObject<String>
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
        placementWithRepeatsInstance.setK(5);
        placementWithRepeatsInstance.setAlphabet(getAlphabet());
        placementWithRepeatsInstance.setN(getAlphabet().length);
        placementWithRepeatsInstance.setCurrentObj(new String[5]);
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
            if (Arrays.stream(obj).filter((item) -> item.equals("a")).count() != 2) {
                continue;
            }
            boolean flag = false;
            for (var item: getAlphabet()) {
                if (!Objects.equals(item, "a")) {
                    if (Arrays.stream(obj).filter((_item) -> Objects.equals(_item, item)).count() > 1) {
                        flag = true;
                        continue;
                    }
                }
            }
            if (flag) {
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
