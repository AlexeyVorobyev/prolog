package main.combinatoric.subset;

import main.combinatoric.basic.ICombObject;
import main.combinatoric.basic.InitialFilling;
import main.combinatoric.basic.NonRecursiveSearch;
import main.combinatoric.basic.RecursiveSearch;

/**
 * Интерфейс для комбинаторного объекта подмножества
 * */
public interface ISubset<TAlphabet> extends
        InitialFilling,
        RecursiveSearch,
        NonRecursiveSearch,
        ICombObject<TAlphabet> {
}
