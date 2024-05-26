package main.combinatoric.placements;


import main.combinatoric.basic.ICombObject;
import main.combinatoric.basic.InitialFilling;
import main.combinatoric.basic.NonRecursiveSearch;
import main.combinatoric.basic.RecursiveSearch;

/**
 * Обобщающий интерфейс для размещений
 *
 * @param <TAlphabet>
 */
public interface IPlacement<TAlphabet> extends
        InitialFilling,
        RecursiveSearch,
        NonRecursiveSearch,
        ICombObject<TAlphabet> {
    int getN();

    void setN(int n);

    int getK();

    void setK(int k);
}