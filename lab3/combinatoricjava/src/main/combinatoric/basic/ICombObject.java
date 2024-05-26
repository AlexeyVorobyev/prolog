package main.combinatoric.basic;

public interface ICombObject<TAlphabet> {

    /**
     * Метод проверяет, можно ли сгенерировать следующий комбинаторный объект,
     * если можно, то записывает следующий объект в this.currentObj и возвращает true
     * если нет, то возвращает false
     *
     * @return boolean
     */
    boolean genNextObj();

    TAlphabet[] getAlphabet();

    void setAlphabet(TAlphabet[] alphabet);

    TAlphabet[] getCurrentObj();

    void setCurrentObj(TAlphabet[] currentObj);
}
