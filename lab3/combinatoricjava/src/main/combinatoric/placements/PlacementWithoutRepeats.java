package main.combinatoric.placements;

import lombok.Getter;
import lombok.Setter;
import main.combinatoric.basic.*;

import java.util.Arrays;
import java.util.Objects;

public class PlacementWithoutRepeats<TAlphabet> extends CombObject<TAlphabet> implements IPlacement<TAlphabet> {

    @Getter
    @Setter
    private int n;

    @Getter
    @Setter
    private int k;

    /**
     * Получить следующий символ, учитывая те, что уже есть в размещении
     *
     * @param curSymbol текущий значение
     */
    public TAlphabet getNextSymbol(TAlphabet curSymbol) {
        int i = 0;
        int n = getN();
        TAlphabet[] currentObj = getCurrentObj();
        TAlphabet[] alphabet = getAlphabet();
        while ((i < n) && (!Objects.equals(alphabet[i], curSymbol))) {
            i++;
        }
        i++;
        while (i < n) {
            if (!Arrays.asList(currentObj).contains(alphabet[i])) {
                break;
            } else {
                i++;
            }
        }
        return alphabet[i];
    }

    /**
     * Найти текущий свободный максимальный символ
     *
     * @param positionInCurObj позиция в текущем объекте
     */
    public TAlphabet findMaxFreeSymbol(int positionInCurObj) {
        int n = getN();
        TAlphabet[] curObj = getCurrentObj();
        TAlphabet[] alphabet = getAlphabet();

        TAlphabet max = null;
        for (int i = 0; i < n; i++) {
            if (!Arrays.asList(curObj).contains(alphabet[i]) || Objects.equals(alphabet[i], curObj[positionInCurObj])) {
                max = alphabet[i];
            }
        }
        return max;
    }

    @Override
    public boolean genNextObj() {
        int k = getK();
        int n = getN();
        TAlphabet[] alphabet = getAlphabet();
        TAlphabet[] currentObj = getCurrentObj();

        int j = k - 1;
        int i = 0;
        while (j >= 0 && (Objects.equals(currentObj[i], alphabet[n - 1 - i]))) {
            j = j - 1;
            i = i + 1;
        }
        if (j < 0) {
            return false;
        }

        j = k - 1;
        while (j >= 0 && Objects.equals(currentObj[j], findMaxFreeSymbol(j))) {
            currentObj[j] = null;
            j = j - 1;
        }
        currentObj[j] = getNextSymbol(currentObj[j]);

        int p = j + 1;
        for (int m = 0; m < n && p < k; m++) {
            if (!Arrays.asList(currentObj).contains(alphabet[m])) {
                currentObj[p] = alphabet[m];
                p = p + 1;
            }
        }
        return true;
    }

    @Override
    public void nonRecursivePrintAllObjects() {
        initialFill();
        printObject();

        printWhileExistNextComb();
    }

    @Override
    public void initialFill() {
        TAlphabet[] currentObj = getCurrentObj();
        TAlphabet[] alphabet = getAlphabet();

        if (currentObj == null) {
            currentObj = (TAlphabet[]) new Object[getK()];
        }

        for (int i = 0; i < getK(); i++) {
            currentObj[i] = alphabet[i];
        }
        setCurrentObj(currentObj);
    }

    @Override
    public void recursivePrintAllObjects() {
        recursivePrintAllObjects(0);
    }

    private void recursivePrintAllObjects(int currentKIndex) {
        if (currentKIndex == getK()) {
            printObject();
        } else {
            for (int i = 0; i < getN(); i++) {
                if (!Arrays.asList(getCurrentObj()).contains(getAlphabet()[i])) {
                    replaceElementInCurrentObj(getAlphabet()[i], currentKIndex);
                    recursivePrintAllObjects(currentKIndex + 1);
                }
            }
        }
    }
}
