package main.combinatoric.subset;

import main.combinatoric.basic.CombObject;
import main.combinatoric.placements.PlacementWithoutRepeats;

public class Subset<TAlphabet> extends CombObject<TAlphabet> implements ISubset<TAlphabet> {

    private PlacementWithoutRepeats<TAlphabet> currentLengthPlacementWithoutRepeatsInstance;
    private int len;

    @Override
    public void nonRecursivePrintAllObjects() {
        initialFill();
        printObject();

        printWhileExistNextComb();
    }

    @Override
    public boolean genNextObj() {
        if (currentLengthPlacementWithoutRepeatsInstance.genNextObj()) {
            TAlphabet[] nextObj = currentLengthPlacementWithoutRepeatsInstance.getCurrentObj();
            setCurrentObj(nextObj);
            return true;
        }
        len -= 1;
        if (len == 0) {
            len -= 1;
            setCurrentObj((TAlphabet[]) new Object[0]);
            return true;
        }
        if (len < 0) {
            return false;
        }
        currentLengthPlacementWithoutRepeatsInstance = new PlacementWithoutRepeats<>();
        currentLengthPlacementWithoutRepeatsInstance.setAlphabet(getAlphabet());
        currentLengthPlacementWithoutRepeatsInstance.setN(getAlphabet().length);
        currentLengthPlacementWithoutRepeatsInstance.setK(len);
        currentLengthPlacementWithoutRepeatsInstance.initialFill();
        setCurrentObj(currentLengthPlacementWithoutRepeatsInstance.getCurrentObj());
        return true;
    }

    @Override
    public void initialFill() {
        currentLengthPlacementWithoutRepeatsInstance = new PlacementWithoutRepeats<>();
        currentLengthPlacementWithoutRepeatsInstance.setAlphabet(getAlphabet());
        currentLengthPlacementWithoutRepeatsInstance.setN(getAlphabet().length);
        currentLengthPlacementWithoutRepeatsInstance.setK(getAlphabet().length);
        currentLengthPlacementWithoutRepeatsInstance.initialFill();
        setCurrentObj(currentLengthPlacementWithoutRepeatsInstance.getCurrentObj());
        len = getAlphabet().length;
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

