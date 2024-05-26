package main.combinatoric.helpers;

import java.util.Arrays;
import java.util.Objects;

public class BaseArrayHelper<TypeOfArray> {

    private TypeOfArray[] array;

    public BaseArrayHelper(TypeOfArray[] array) {
        this.array = array;
    }

    public boolean inArray(TypeOfArray element) {
        for (TypeOfArray item : array) {
            if (Objects.equals(item, element))
                return true;
        }

        return false;
    }

    public TypeOfArray[] removeElement(TypeOfArray element) {
        TypeOfArray[] newArray = Arrays.copyOfRange(array, 0, array.length - 1);

        boolean elementDeleted = false;

        for (int i = 0; i < array.length; i++) {

            TypeOfArray item = array[i];
            if (Objects.equals(item, element)) {
                elementDeleted = true;
                continue;
            }

            try {
                if (elementDeleted) {
                    newArray[i - 1] = item;
                } else {
                    newArray[i] = item;
                }
            } catch (ArrayIndexOutOfBoundsException exception) {
                System.out.println(Arrays.toString(array));
                System.out.println(Arrays.toString(newArray));

            }
        }

        return newArray;
    }

}
