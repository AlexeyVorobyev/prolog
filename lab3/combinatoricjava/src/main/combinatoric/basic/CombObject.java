package main.combinatoric.basic;

import lombok.Getter;
import lombok.Setter;
import main.combinatoric.basic.printers.CombObjPrinter;

/**
 * Базовый класс для комбинаторных объектов
 */
abstract public class CombObject<TAlphabet> implements ICombObject<TAlphabet>{

    @Getter
    @Setter
    private TAlphabet[] alphabet;

    @Setter
    @Getter
    private TAlphabet[] currentObj;

    @Setter
    @Getter
    private CombObjPrinter printer;


    /**
     * Заменить элемент в текущем комбинаторном объекте
     * @param value значение для замены
     * @param index индекс, на который поставить value
     */
    public void replaceElementInCurrentObj(TAlphabet value, int index)
    {
        this.currentObj[index] = value;
    }

    /**
     * Вывести объект с помощью экземпляра, реализующего интерфейс CombObjPrinter;
     */
    public void printObject() {
        printer.printCombObj(this);
    }

    protected void printWhileExistNextComb() {
        while (genNextObj()) printObject();
    }

    public abstract void nonRecursivePrintAllObjects();
}
