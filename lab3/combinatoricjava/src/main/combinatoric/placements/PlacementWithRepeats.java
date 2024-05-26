package main.combinatoric.placements;

import lombok.Getter;
import lombok.Setter;
import main.combinatoric.basic.*;

import java.util.Objects;

/**
 * Комбинаторный объект - размещение без повторений
 */
public class PlacementWithRepeats<TAlphabet> extends CombObject<TAlphabet> implements IPlacement<TAlphabet> {

    @Getter
    @Setter
    private int n;

    @Getter
    @Setter
    private int k;

    /**
     * Получение следующего значения из алфавита
     *
     * @param curAlphabetValue текущий значение
     * @return Следующее значение в алфавите
     */
    public TAlphabet getNextSymbol(TAlphabet curAlphabetValue) {
        int i = 0;
        while ((i < this.n) && (!Objects.equals(this.getAlphabet()[i], curAlphabetValue))) {
            i = i + 1;
        }
        return this.getAlphabet()[i + 1];
    }

    @Override
    public boolean genNextObj() {
        int j = getK() - 1;
        //находим НЕ последнюю букву алфавита
        while ((j >= 0) && (Objects.equals(getCurrentObj()[j], getAlphabet()[getN() - 1]))) {
            j--;
        }

        //если таких символов не осталось
        if (j < 0) {
            return false;
        }

        // получаем следующий символ из алфавита
        getCurrentObj()[j] = getNextSymbol(getCurrentObj()[j]);

        // оставшиеся символы забиваем первым значением алфавита
        for (int i = j + 1; i < getK(); i++) getCurrentObj()[i] = getAlphabet()[0];

        return true;
    }

    public void initialFill() {
        for (int i = 0; i < getK(); i++) getCurrentObj()[i] = getAlphabet()[0];
    }


    /**
     * Нерекурсивный метод для вывода всех размещений с повторениями
     */
    @Override
    public void nonRecursivePrintAllObjects() {
        // первое размещение просто заполняем первым символом алфавита и выводим
        initialFill();
        printObject();

        // Выводим все размещения, пока они существуют
        printWhileExistNextComb();
    }

    /**
     * Рекурсивный метод для вывода всех размещений с повторениями
     */
    @Override
    public void recursivePrintAllObjects() {
        recursivePrintAllObjects(0);
    }

    private void recursivePrintAllObjects(int currentKIndex) {
        if (currentKIndex == getK()) {
            printObject();
        } else {
            for (int i = 0; i < getN(); i++) {
                replaceElementInCurrentObj(getAlphabet()[i], currentKIndex);
                recursivePrintAllObjects(currentKIndex + 1);
            }
        }
    }
}
